Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B44C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYAK-0000Rh-48; Tue, 06 Feb 2024 22:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYAH-0000RF-Ln
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:59:57 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYAG-0002Am-8r
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 21:59:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d72f71f222so1694365ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 18:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274794; x=1707879594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J75fbe2WZB98tGetMw9JgJINqxaNy6GeYuYHYOYuxQc=;
 b=cS1rGqPK+F/pQIgnxTvRNIXcSsgbWR7IrRGk6RVU7P92pKRkhJfI0nRYLx7ZF/85q4
 4qWpNkv/316BOlEAYCG0J9TEXD+QfqyfQKSUFAQLGPBsUlX2ckhVfp0edxh08Wkgc3/H
 j+r2NzxAnQJ5rRCPM9XUctWzugwIXpw4loo+idAsjCZJdK7ZqEC4sX9QNm+E3fZwv8DE
 uDd9JK5Yy831Cuutx+H/s9dlLrVD49K3TkORU8GO8PeXJDliVJ/xkqdJ2maTsyoMWV+O
 qLCjqzSoSYNyB54bEGMIx6p1X4vjZ5kBwzro/3W3PvNcy1xLbG4FfBLUFcWTrVQODPaw
 geQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274794; x=1707879594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J75fbe2WZB98tGetMw9JgJINqxaNy6GeYuYHYOYuxQc=;
 b=j3XNCYcMlK9ek/vpy0S+EhAGknKvW2I0/y2ffvNXtWkoVn8kiENCcWVEjuvTfeaOUR
 gQB0HqabXwJAg8fgF5+kiq9cmAYGYgn7Cqowjr9iIwMVIPntcdWsNypkVmQTpEb53Uiq
 8KnAJvZS/fpXnUYdZ1BYpWRINVew/IaiURga714IBXVhSnrW/Jii8AohkoXPFKUBCste
 GeDol4aBXjGL0+93OyAIYHLA7jskqiaMvG5Iv8oTCoXg2xqrn5dtzrUz+wVGXxpDDBGl
 BEkB7XWBZeVY0R3gTZSKCaw2T8yuoHlPLmSKtyBkh79TX2lRej/xUwtDFYWExXD7eAiK
 JBnw==
X-Gm-Message-State: AOJu0Yy74EY3Oru66oCJQefIUxvDySRPv5OUJ12T1WpniGNOfZRO1HmM
 4rAnRdUkl0MD6iWANl4p7agpl258Gx/CIskXCfbcumgqNjqGcW8RsJszIKAB/Qg=
X-Google-Smtp-Source: AGHT+IGxjoT3otgOFq05yUjsORNil5oTlL7aVypafLk95i52ccfoigBnftNTE/bDO60f0CQzMPcHEA==
X-Received: by 2002:a17:902:c412:b0:1d9:df95:89dd with SMTP id
 k18-20020a170902c41200b001d9df9589ddmr3575935plk.47.1707274794454; 
 Tue, 06 Feb 2024 18:59:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqLUipRHbAXtJXLb7R2n57w7Wty5KUGt2QlOuRawXw/lde5Uz8rPMvKFGpOx29b01y+RBQg8E6JedF2g8MJdIzVzSX+8ILE0qIalD59aqCoDUowQAH+jzOQF0ziyl0jakQA9jEi9PsM6A61cgzdf++b5Dv6qAHYq7CiOYGYga1clrk0xeK378G9aHrBL8GdTpEeVwISVWIlQdTvA1Vor/XGWyGkY2IVzQBJubCkyiqeSsIByE4aIj/IKb5N12CyXpYesE25nsUvr3v+fTgqrFM38YA6VyxMiCaMjD3NS14ap/3kw==
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 kh11-20020a170903064b00b001d8e91cff10sm262708plb.5.2024.02.06.18.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 18:59:53 -0800 (PST)
Message-ID: <2bda1ab9-e714-42b8-82fc-b84d10685edf@linaro.org>
Date: Wed, 7 Feb 2024 12:59:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] plugins: fix order of init/idle/resume callback
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206092423.3005995-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/6/24 19:24, Pierrick Bouvier wrote:
> We found that vcpu_init_hook was called*after*  idle callback.
> vcpu_init is called from cpu_realize_fn, while idle/resume cb are called
> from qemu_wait_io_event (in vcpu thread).
> 
> This change ensures we only call idle and resume cb only once a plugin
> was init for a given vcpu.
> 
> Next change in the series will run vcpu_init asynchronously, which will
> make it run*after*  resume callback as well. So we fix this now.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

