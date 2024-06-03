Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CC7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5sy-0007US-AX; Mon, 03 Jun 2024 07:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5sv-0007IA-HU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:29:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5sp-00010o-Pf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:29:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4212f0444efso22203745e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717414185; x=1718018985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLnxUcJCvwam8NR4TAMOEi8I7SnlVM7G4gOpinBNE8Q=;
 b=vJH62kHoOthlp4eQn6TmID8t85aFcBK6z0v0HoQF7OqwbrIZxbwXJm5/4qglxBbwJj
 UaL+5QrohTx6sPcn+v/umtMQ9KPSbpwNX8rswqHzFvtqtTFhlxw/YkXzl6vIJOODXtLl
 lqal7v+T2I9gcceo5dNM2sBMpnnhovJoF88YDwPJtXmdia/KzgqD9ZrEOAyPst3CzfNT
 2n45EIK804JDwjHagkKBPXjZpDc51jyRwskpfJpf4mKtYXB1fAvP8ZLqPfIJqltwIX+8
 /O+17iNddPGONLgFoQV4cWQahXkdIbYxXzaN4FzNwKbVAWGqSZ5ONsCzd2huLyxgkh0q
 hSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414185; x=1718018985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLnxUcJCvwam8NR4TAMOEi8I7SnlVM7G4gOpinBNE8Q=;
 b=f2Lt5KZTgkPW80jkbr+TPATflxP37W3RSjOfAzSG0HZfBkThMPyuUZpzVEZvUTBxts
 fGzHKqeMTUbljbmlehfKhKVnF5rk5I/s0hiYW4ObyoNQztmphKeqNvPuQk7BOPg7jSx+
 zuwYsqaQmD2mxyt6TNUItHI43r0EhN6IUfYSo7aCVcS5JVdYNQVFeO72y0FD4L8Jf4Gu
 bJX5CPsrqeVvC+OFVtbhjO8rhHU3JAvG+5xwfpimib10aX82149kLrqq6vn87MILyN3z
 Xy2lR11h3dqO5aetPn1aroeESCPAaj1lNejf5iXL0OEOS03B1cYon9oXUqTCe0eLN2Fj
 8SlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwPfhFzrUy/i/85FSsvBW1E6c0q2kkzkaTU/JqDOuNW53tgs+Xr89o4VJ3LrbRxWn8iYc/pmCwaxpK8PBNeBeb9CvzP2U=
X-Gm-Message-State: AOJu0YzOqHubiD01Qzsqv/xDWp2xzU81IkgQdEnypC3vTmqeF22/iKD0
 /GBCiDChhtGNjMRYHVoNpe0bYUAAuG7uaC+xRn6LwaZjhgUShEOL7z5rPa1WBvo=
X-Google-Smtp-Source: AGHT+IHjptcbICMOvw98IRefbTpUVCv3dgn136ed+lZOXrMcu/+Lxkisji2UP+2kAbwtIgGXr9OceQ==
X-Received: by 2002:a05:600c:1c85:b0:421:2b8d:9cea with SMTP id
 5b1f17b1804b1-4212e0ae4b0mr71855815e9.39.1717414185561; 
 Mon, 03 Jun 2024 04:29:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213ad0aa15sm48578905e9.44.2024.06.03.04.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:29:44 -0700 (PDT)
Message-ID: <a4bfd8a3-8d07-4990-8b73-331a301f9545@linaro.org>
Date: Mon, 3 Jun 2024 13:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpu-target: don't set cpu->thread_id to bogus value
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-4-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/5/24 21:42, Alex Bennée wrote:
> The thread_id isn't valid until the threads are created. There is no
> point setting it here. The only thing that cares about the thread_id
> is qmp_query_cpus_fast.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   cpu-target.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


