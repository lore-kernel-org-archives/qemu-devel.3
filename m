Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64337C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85Ij-0007ye-Jf; Thu, 24 Apr 2025 18:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85Ih-0007xq-L0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:44:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85Ig-0003NE-1U
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:44:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22da3b26532so15818225ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745534648; x=1746139448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rQyDHhkjA658UuKEvQ7B6SS/XyrYuPQZsyvOCKVGiNY=;
 b=TbA6zJlUGjZkdbMWcspSm6x0pM1fAM/ENBfRVWj91QC6TT4QEdRc4S5QxzuXi7q6w5
 LyrJ8PLj4/WskizYZpZzCQcdPSDwbqnKlyUyctzZBpE8sPmYoD7Y8pZbOKmliIWtXyBG
 8pKGA1EovZZ7yf5JZ1J3Ab6fQQ2izRj3FA+ykDODeA2HxnFEVwzy5+gwa0Z1EVRQn8O3
 0J0pqDVPD161I0GTxEem+QRu1+y22WJpIsSWk2Q72qxRoxobBauXVoRXVEdyqW7Qr44p
 eSTAxPZchXoOXSTGXAKrb24EmOtLEtLrKP/GfPegPoNYgY2ZQmf4QNyOTBOVtIzKFsqY
 TEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745534648; x=1746139448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQyDHhkjA658UuKEvQ7B6SS/XyrYuPQZsyvOCKVGiNY=;
 b=JZKckw5I6jIwInHnOgyfhL/lRA61yMDeej30Z01GAHMC4/7IhDjpfc0iYkaSWYwefu
 gVhzTPOn2WqxBJ2US//nnC9bM6NGfkBVQ0pd5NeMUEmgEscLkh7cuexrwNwLmyMavbPo
 uuYUdb11ysG544VbCw5MgtaQY8V3XNYtov5N3/cGAhJQL7liHF9JUpKsx7WD0zSG7iKT
 QCCglmuqlNG3xccrT9tMO3jc5+a+NqLdP1nd2uQrodDwwCXapM8LoTox8CfdM8W7lh3V
 gwikLIadQHYihU/p9WukayZH/csGfdim0busdyY2T2iy034V4HYvRVg5o8BGouNf0KRy
 u5Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvC3Yd7SOAcj7qXY7UlHmTPZMBWdX/Fo4lbIGubudJm30OeA691FJZSblJhtItFDsvrX/rnNl8Rcuk@nongnu.org
X-Gm-Message-State: AOJu0Ywn7psqeG+9dmqZv/wNmevMUBNkTmt4ufO07XevjBqEHBvsMHTl
 psE+cfRbmOahepizb8mP1YAwyU1pKCHDQgEEeg1ZMsbH3NJVD2qmD1xhQkLpfcM=
X-Gm-Gg: ASbGncvDIIbittOm2l3i8SHyG32CqqGk4RtlmoSNgFVIHArPRI7UOwtYaWs8c8MjpkV
 1cOyxtxrA2Pe44rC8yBLRMA9KXx2mW4H3w6gs9lf4x2pX254LSblazJuuVtqpDxcr8jh8XbDqau
 fbHj1jNDZe0YVwrCgmeumOTu0S+t6Mlh1uc7hP5G3RIVU+puoiQSg/eeV9z3esJWTqhyLC+EyzC
 Gn5ElzE8CLm7kn6Ar9fw9IXyx9YLaDLuuJgfVUm8D43N/IHMD1SVenqhykDzi2/7Bjn/qvpE3AI
 SHOX0JWLjbtImab+B8b7m/eHk2EfsD5tM4m3iQ4eR1mZa9sG/g5jKg==
X-Google-Smtp-Source: AGHT+IFOZy+cHRuuI/fEq6UiARqVdgDj7ub9DgTN9Hbg4i/0KB5u4LYK+hPORriZzG8fbaSpjcJSjw==
X-Received: by 2002:a17:902:ce0f:b0:223:50f0:b97 with SMTP id
 d9443c01a7336-22dbf742de5mr553275ad.52.1745534648690; 
 Thu, 24 Apr 2025 15:44:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221a82sm19002895ad.257.2025.04.24.15.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:44:08 -0700 (PDT)
Message-ID: <0ef787a9-99ef-4900-b765-475be82d0cd2@linaro.org>
Date: Thu, 24 Apr 2025 15:44:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 07/21] hw/boards: Introduce
 DEFINE_MACHINE_WITH_INTERFACES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
> DEFINE_MACHINE_WITH_INTERFACES() is similar to DEFINE_MACHINE()
> but allows to pass a InterfaceInfo[] pointer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

