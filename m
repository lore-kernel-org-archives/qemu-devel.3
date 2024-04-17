Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F3DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAul-0000XL-TC; Wed, 17 Apr 2024 15:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAui-0000X3-Tl
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:25:48 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAuh-0007oD-5O
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:25:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso12788a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381945; x=1713986745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEmDRXz47NtxuI0+13/ZwOzhHzAlnbvn+qMUdNDaVCM=;
 b=pKIMy47BJ/Z2pFLT+Przy2QGSlVg7/iJDNnSca5pH+AuryoVJ4eUcwqzddm1JTonRr
 XGM6W6vQB0oNw59qkKWNlBlbKvZHfs208UH7ud8MO56g+pU6SN74JZCiG3FG634p6R1l
 gQa3zRxwYR6b95H266AtFRAvda54adOJqBNgrgmhZOciS5nCNnUZd+iogpG/UyW1tmwb
 xY4H5a4PE9rYKsMD8hAGQU10Q+7HE2r5EXy7ruVJVuObmoACQN3RWGBQmYlylv24l64a
 V+V1QM+edxpyEyMsQzZS+CuQbD3yZVFGw30yX/djAqG7ZM73T3dVrBYe8jjXIZwYYkL5
 Lt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381945; x=1713986745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEmDRXz47NtxuI0+13/ZwOzhHzAlnbvn+qMUdNDaVCM=;
 b=mCaDyaSI1vNo0WPlk9fkbry13MHVcJzdfPqjz+WwEqWiF/9gXHV5bH2Lef4VK/tjxi
 m3MIv1w2QYNfwszuN7F3/ufs8aJYaKmtW0Dks5fGIF6c/Xs50DIiVgk+Kbbsdfmp7I3T
 ATJ3Hr5bVE8z30ZRjvXU4BAz1ITDQypMBCozC99ygJuPjN/jyN7zxqeB6NeHHV+QcBV8
 AfjsDhjmiAnLK6JBOLuK3gSFv6UCeN8TJO9/p/aeVt/M34bGYiObmWmd1RlTMB6PZ2o1
 cxHOXHexUO0qVqqFA4GDk3qQiLQOf6JfqfklpL8tCENOiS5B5FrNTUon0uL+C0RyJrka
 j5uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg40zI4nJJl6pjiqlPLlv3mkqZSR08D5PVwpnSEO2ZJlxEQ9ecn5VyOanoeS/jqfRzvBg5SL7aImLDr3usTcYBBJF4XhY=
X-Gm-Message-State: AOJu0YzSs3qrFGjfJkbNYS1TqvdEWeESJQcYR5RS/qfGsKzO47JFMo6y
 A0QDcdnYyF+XfdjGFPy2MMYWpQ5S6iIn+CzkPyzc7YZIlxwZOdJU0VRnfVOHZ8Y=
X-Google-Smtp-Source: AGHT+IHedCNRctGKnkozrUM6IA92Idh1BFS4M32X+9JUyN9J8/dN7bTehk8iam3yq8dGdB/3O1RZfQ==
X-Received: by 2002:a17:90a:5913:b0:2a4:b05b:939a with SMTP id
 k19-20020a17090a591300b002a4b05b939amr303470pji.47.1713381945478; 
 Wed, 17 Apr 2024 12:25:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 ta11-20020a17090b4ecb00b002a544263b43sm1722163pjb.28.2024.04.17.12.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:25:44 -0700 (PDT)
Message-ID: <eea54c48-e125-4800-9d6e-36f340a8697e@linaro.org>
Date: Wed, 17 Apr 2024 12:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] exec/cpu-all: Remove unused 'qemu/thread.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> Nothing is required from "qemu/thread.h" in "exec/cpu-all.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Message-Id:<20231212123401.37493-13-philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

