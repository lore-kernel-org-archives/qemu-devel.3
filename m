Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C50C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEdQ-0006Ly-R9; Fri, 12 Apr 2024 06:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEdO-0006La-QF
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:59:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEdN-0003SA-Bd
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:59:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3465921600dso633611f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712919591; x=1713524391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl2SYQzauvtMTI40X4itoNKaJ2QODMBuQjaqjj8zIoU=;
 b=MFRl4Pip9K/C2MhjSFdUUbvFKqp+KkTKyh4fYkjTyd0k70OYaYtx1XDpW+Ctn5xivb
 2rCkiioWzrlbd/rUO7hctAQqktDYi5ylN0QQLljAKgGrsdIRhyR/hapXfvUcIQO6FVzS
 BowIh5CsFERUIifbkMxawuavQDK+r8bCiFx8ZbgPfWmt8hgXld0TtKxH2XDwd5CNjuuz
 HQe2HyhUPUe1rgmV7E7GlmKk92lYQddIUK27ISO2TUCUmeI/FG1QrKAVhU8rQEHSHUKX
 vgrSZrBccaEDMDFGLUt27H0T37Zt3W22zpU1gJEQMFGko17SJ64WtOgaDHHrwgL0kT/Q
 rTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712919591; x=1713524391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xl2SYQzauvtMTI40X4itoNKaJ2QODMBuQjaqjj8zIoU=;
 b=grse/uOkrM2ZG7R3hXRDBW6L6mFSFiBMcAsIBeskJ3s+WGMnoRHt1Cffq86Fxr1b2b
 Mq82t5ujZtSbSovLC1LvXq1yImlBwOHe5ddYWR7zcqMQFK7gRNaVfEZqstvOcACIUfhH
 d6cmnnkGnZyUixEt2TMX3fMZ3UeElQE/1Om6Yx6CN0rIarMiy2FhySWftlDvjCP8VOWh
 AFQZK+K/F3lWHEFvdEDyzvFplzeZJK2EnxmbsuG95tNbTjyQl/gH9LIXdfqR/jONJHgj
 54aJlTIgA++yG7erNTmZLa7w7k04Q+EY6eRpvS4p2O1vMnMBZkBWadJiRKDEUTaEpu6s
 Tp+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTkXD5ruVAYozBC5K0iKBdQpntcuu3cYjqVQ4CEY6lnU12AlC8uzUOKJGWOLcztG2frzkcV97PTPF/JTY2OeTTDwHES6k=
X-Gm-Message-State: AOJu0Yyvwj8MDunqNXVBx8xGQUb7xdateWVHn+yOuUxuEYGQLlYKNtwI
 9jICWKQKV5lUu7WiEMtA+/Q/BYIcSgQN2o/G02LO8cIGdMnZaYrGXs1L9Wi+Cq8=
X-Google-Smtp-Source: AGHT+IHc9K4FZbya5EMlcJ/x8+YfSOaIYSRlK+r2zXRpcBSfaLTFQ2PvlsokLVbiB53I1hNTGX/lMQ==
X-Received: by 2002:adf:e990:0:b0:343:6e18:d7f3 with SMTP id
 h16-20020adfe990000000b003436e18d7f3mr1369622wrm.69.1712919591447; 
 Fri, 12 Apr 2024 03:59:51 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 i4-20020a5d6304000000b003437ad152f9sm4009715wru.105.2024.04.12.03.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 03:59:51 -0700 (PDT)
Message-ID: <11b56722-5bba-4a95-9177-3c9b5ad04723@linaro.org>
Date: Fri, 12 Apr 2024 12:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/27] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/kvm/kvm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


