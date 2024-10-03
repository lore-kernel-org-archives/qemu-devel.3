Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED7CF34CC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTfj-00057u-7e; Thu, 03 Oct 2024 17:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTfh-00057j-Hj
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:47:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTfg-0003AY-26
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:47:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20aff65aa37so12142865ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992058; x=1728596858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QxWi9pEixgIiFTkrRcIXA33MaiMpqS+3eoTnMi3J2E=;
 b=CF0Wyj9+4MSTC8HifPgCWRmWPK+uO0fLPC0J34S4iQj6K/FOFzX+GnvuWGFwqzitD0
 6XGWj/O9rfFMsegZQ1DR3LlNokO1w6N/A7F/fdgdRmMn0BCpBPh3OvT9s0ltD5wsnvLo
 ugdEv0iQYZKY5OYXKk2is4DgCI6/qlISOzMe66W5EcmTtOBFSSzLW6/qtwj+iJHlwFyE
 Lmp9OQls1xcm2mX3DPF/g2PM6yjLnajDhN4ZQpEGeXgBFI8zaiwDJ7tCjIE2KAivzu0H
 OsfTUNp4tdL2zV0bdeOiboH6SCwJwj98vz8hL3MQgb1N75OxzUM1gxK0yXKoe7KqAiqe
 f2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992058; x=1728596858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QxWi9pEixgIiFTkrRcIXA33MaiMpqS+3eoTnMi3J2E=;
 b=kNJdiw8aRucKptcpjSgsVPxXaY7ENeNFHHCyOiXXA9L99pd/Py/DDqCdlyciNFVJTv
 BRwe7fjl+dI9TQWCTz08mGkfyIjNYeR2oH5M3D0Moh8Fr2WXocFAJDc/pbeiAhCkCvdp
 yHPKIK8JIAnJoD52BMXs2mT5xroRvApTYQ2936i8QF+jQU+CCxGn2SilgCuUmNlyk8sX
 4kRoLECK9lDQyMYNH2irPjGnx3ERvb6n4twyhzE1o2KhAF0pV5m/p9fHrFHQbwYTf0zJ
 n+HvNsa9JnYMK5hxiKhQ79pwZGXFBsVZOTILB7jzRKhif3d2WuUpnqbGwKlazkkvuakk
 GwNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8u7VQ3BVBck2OrBlxHx7aPpJpggU8tcFDmyiei3Hss5+bKtRjolgRkabkDPnJvfB92ZGOzp7r+TPA@nongnu.org
X-Gm-Message-State: AOJu0YwST4p+BtEx/857U3m5/uWCx4ki0qyenpglq4HmN7zjBJ09k3+C
 UjESdLYHDJsn9MmPyKlIdDDO16f824heRf8NC+AtgAo6Gm7DuzGrYTVPkOphVp1n9TamLgvcw9S
 i
X-Google-Smtp-Source: AGHT+IGXaB6BURlL2MCAdzNVdUjIWPVniut2vueC/X0s4z0v7p3OQU3iBCjcnqekZ0exOFWsmVGF9w==
X-Received: by 2002:a17:90b:3890:b0:2e0:876c:8cb4 with SMTP id
 98e67ed59e1d1-2e1e6321821mr588228a91.30.1727992058495; 
 Thu, 03 Oct 2024 14:47:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e18f54168bsm4376406a91.7.2024.10.03.14.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:47:38 -0700 (PDT)
Message-ID: <7d865af1-41d9-4e0a-a76a-c7acc495f1b7@linaro.org>
Date: Thu, 3 Oct 2024 14:47:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] exec/memory_ldst_phys: Introduce
 ld/st_endian_phys() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930073450.33195-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 9/30/24 00:34, Philippe Mathieu-Daudé wrote:
> Introduce the ld/st_endian_phys() API, which takes an extra
> boolean argument to dispatch to ld/st_{be,le}_phys() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: Update docstring regexp
> ---
>   include/exec/memory_ldst_phys.h.inc | 66 +++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
> index ecd678610d..8ea162b40d 100644
> --- a/include/exec/memory_ldst_phys.h.inc
> +++ b/include/exec/memory_ldst_phys.h.inc
> @@ -74,6 +74,16 @@ static inline uint16_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
>                                                  MEMTXATTRS_UNSPECIFIED, NULL);
>   }
>   
> +static inline uint16_t glue(lduw_endian_phys, SUFFIX)(bool big_endian,
> +                                                      ARG1_DECL, hwaddr addr)
> +{
> +    return big_endian
> +           ? glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
> +                                                 MEMTXATTRS_UNSPECIFIED, NULL)
> +           : glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
> +                                                 MEMTXATTRS_UNSPECIFIED, NULL);
> +}

Endian swap aside, I think you should expose this at the address_space_* level first, 
where the internals already have

     return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
                                                      DEVICE_LITTLE_ENDIAN);

then you can pass big_endian directly (perhaps frobbed into DEVICE_* space).

That leaves one unconditional function call instead of two conditional calls.


r~


