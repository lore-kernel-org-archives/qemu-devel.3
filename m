Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D610AC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxlT-0007Nn-G6; Tue, 13 Feb 2024 13:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxlK-0007MM-MW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:44:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxlI-0004Vo-DM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:44:10 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso35752845ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849846; x=1708454646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3W3BpHhXvpS8jBtURAVkwbcUVYTJ/qc6jpsPqeFxUxM=;
 b=F7j+Fxm23G476XfCEpPIY+ZkzMEBx7FiiXw933HPLpIJ+XFuHY+X+ZgzQwMe2dN4Ep
 dp6b6Q2i+DLLkPAdwH6lqnaslLn+d3VUME1jUvyMdBS7Btmae75UR4ugAuUmblmQCAD5
 4pEQIRH7p8U/VLjPkdq96zbahgaR5DkxoYep0KJLnHBityO+gX2glVZkRxNAfcathBUH
 LpoCWJgUb1l7ILM1IovGUbs0vpWTNDVA8Z6mL2rLEPFokMJkx14qROBtprBVrtbw0tzG
 FrphELoUhULwaDZsTrajjuLRbYBA8u34ybPP/8oxym603o1Bu8crAfPmzb9AsScx2yT4
 LRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849846; x=1708454646;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3W3BpHhXvpS8jBtURAVkwbcUVYTJ/qc6jpsPqeFxUxM=;
 b=WuaRLaYu24obgHi1/d4mLhci3Wyj3AUfnKeeNFAPtFJiviF0bza3IZAGB49Qdtb8pB
 C6kP+dxKOPCKO2/SLEj8jVd7eJx5ynj1Cvh6GhB92c63TUhkvDOo+gEospMGcuwWpbUw
 ad6hzPtG9JP+hVFCpfo4q55wO7Hwah2Tz9Gub+BO0WX1tq09guCW0qocZrqFkAXofA0a
 +WmEE1B9AEoNG/3Y0KTNdOjVgWUaaFWz2IL349rB+mpdUzPdCLdmY49WOBQOIMYeJEI/
 VhsFim+rG2fncrPUqy6+OSL5a6Kpro8MYPaVz8XhTJkOooB4ezv/oR5+aPW8iboEWsEl
 dk/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3a5ffYHvdUS/NUu/TU16ZoAZOf6EnBiHI6eOuyfOnSW/7HQwXinkjZf4pgQHnq1R9xJaTsxitc6ohm6fJjKiTVetQ27U=
X-Gm-Message-State: AOJu0Yzfhcx58q6ghvVcEjsW/IXL/BNF6hORca8ifdHhjHRYSozuZ7sY
 sFkeP1uIIY9xvOGfkakBA+LDwJvl+C8cmMZXVRSjv7BhknwPtV4ZnwTi7/LLOs2VLPFpeg19Z56
 7
X-Google-Smtp-Source: AGHT+IEW7jFlSvhu/5UQ+ky7BnZBjE/jmBB+y0n4TACZinSP8RbSDk6fCMN3gY9oeNFZTzA1qlSNMw==
X-Received: by 2002:a17:902:b18e:b0:1db:499c:9b9e with SMTP id
 s14-20020a170902b18e00b001db499c9b9emr353104plr.9.1707849845950; 
 Tue, 13 Feb 2024 10:44:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjbmgGq90dRr1Vxm83PSziKgZ98B36/EeNJtIi2TAVbjygLNgLwHR0lW++OCleaxKiRnGua8zOFWoWfptzh0NxmtL0vhc=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jj19-20020a170903049300b001db5079b705sm233013plb.36.2024.02.13.10.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:44:05 -0800 (PST)
Message-ID: <051cd462-ed28-4c52-aeb2-eaaa01956d82@linaro.org>
Date: Tue, 13 Feb 2024 08:44:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] plugins: remove non per_vcpu inline operation
 from API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-17-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/12/24 23:40, Pierrick Bouvier wrote:
> Now we have a thread-safe equivalent of inline operation, and that all
> plugins were changed to use it, there is no point to keep the old API.
> 
> In more, it will help when we implement more functionality (conditional
> callbacks), as we can assume that we operate on a scoreboard.
> 
> Bump API version as it's a breaking change for existing plugins.
> Bump min API version too, as we removed some functions.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h   | 58 ++++--------------------------------
>   plugins/plugin.h             |  2 +-
>   plugins/api.c                | 29 ------------------
>   plugins/qemu-plugins.symbols |  3 --
>   4 files changed, 6 insertions(+), 86 deletions(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index cdf1266d724..9b11098ff82 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -53,11 +53,15 @@ typedef uint64_t qemu_plugin_id_t;
>    * symbol qemu_plugin_version which can be checked.
>    *
>    * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
> + * version 3:
> + * Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
> + * Those functions are replaced by *_per_vcpu variants, which guarantees
> + * thread-safety for operations.

You don't need to bump again, as we won't have a release in the middle of your patch set.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

