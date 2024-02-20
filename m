Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54BC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP81-0002zf-Qn; Tue, 20 Feb 2024 07:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP80-0002yS-2r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:21:40 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP7y-0005H8-EQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:21:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d375993f4so1434660f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431697; x=1709036497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f6oXI87+iR5ZssZLkFJMzREgIJ7tHfkviS3tT19oqAU=;
 b=w35XfhF8JZJsnbZ3eSSc/lYdXQcEuWvIZGMuMNiilCDgCVf2s2wgihlXJi8FLGrBZU
 KJVV7wCB12U6BLc5Ugw/gPL56/fHGgLcrz33GiPpWuObfK9OdpZgCbaV+8kDC/Oox4iS
 bJJ/UFjuMlGH7OsCOxIAlCFziBnt0cFlQGBTum8MnkEwPbK/uED5TAihDR3GBfpEY/b9
 y/QC7eVd/5qkJmo0qgL7vBdG1kgfMSv1PXVU1eNjfFnoEszZfmYI6cefs61wo4nzma2V
 SkpGtMQJCa5/5oBfqj2yCIEEnmgVPGEMY8vWUduEs7/OPKEArgod0EGSVlemQcE+UiRg
 Rmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431697; x=1709036497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6oXI87+iR5ZssZLkFJMzREgIJ7tHfkviS3tT19oqAU=;
 b=Y5KcSHUdNKHIaYltQoiGutAuLpPMaGz2gQnRTcrSBUl6g66tR22kaUwqehuo6T61vZ
 lo8bgRloL+0Nsxp8nCQWU0zbbhpFgJl7JdqsVBBn45vnLk7XVCD1qkt4fMJ7LPrijUAa
 CVuehpgezRViDkmpaeNlxLqhW9DPTf1TLZAjAYVVrCHhnwYmblkaGpz1W45rXW2TeyO7
 vbSA+gir33yfMd4MoZ98AhH3U31CVHEwak7C2kBM+pmaUOXUH0WyQmM8pLVQV4PMTy2m
 hX3BR2O98nCC9e/IQtdy9pIx/3ON8nrLgKj/cXE+Y3iHW1bJLxYErv7ny2T/dQUud5eD
 jrXg==
X-Gm-Message-State: AOJu0YzYwZqo43MOM3jqw3DFXfJUQbccUMG2My38Tm88iD9V+cZAEiYn
 FMZVFXFYKxO3D7XwGeNwsyMrNYb2Zn8i05VfDTm1/nAqk/n7FsrI2aKNi8mTBxw=
X-Google-Smtp-Source: AGHT+IF0FWUyyTfX2kAW25BFgitWBykWUI6UJ17L74ZHeXprfbZyNjwonhlollckUZDPfKveQOPfaQ==
X-Received: by 2002:a05:6000:1044:b0:33d:5661:4e7f with SMTP id
 c4-20020a056000104400b0033d56614e7fmr3487195wrx.42.1708431696950; 
 Tue, 20 Feb 2024 04:21:36 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:21:36 -0800 (PST)
Message-ID: <b9afa983-56e7-44d9-815c-634b4e540be7@linaro.org>
Date: Tue, 20 Feb 2024 13:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/21] s390x: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <73c534c8b6cdd769ab4d0220f505da8ec7470983.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73c534c8b6cdd769ab4d0220f505da8ec7470983.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/s390x/cpu_features_def.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



