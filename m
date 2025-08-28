Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8FACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urYK2-0008Pk-4j; Thu, 28 Aug 2025 04:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urYK0-0008P3-Tw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:49:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urYJy-0001Ad-LO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:49:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso4021305e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756370963; x=1756975763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qb1ffFwRKVEjTJhJ8nKel3LWazUjsohl1k3PFL610V8=;
 b=qH8qj7z/svVUj+CNYh7jik3IIUXS1EkNb9tdG2GFdPiQh9PIJCS3Ihl5h7vG1PaDx8
 bEe9ayirBNH/rsfOb3M09hmybaQOE5WWBnyBwEm6Zw6pQ466O6Sn+850jnanN20Bdv6I
 ERpiX+aHYd3FTv6GjNt6GbHMO2ir60ChnXzlg8cauHdoK7hul/qsUnqE5Zpg5Q7WZaQx
 nfuT2gfEBNg9CSjzFOEapscoDMMw2H8+rszuEI8KXYHMNJyHoP7Tqm6d4P1i13VGAb88
 335y5zvT3z/Xojx8bAbR1waiQo8Y14mEET39IAmWpyZjky1ktyYFxA+G4AAFbCOHWRqA
 hiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756370963; x=1756975763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qb1ffFwRKVEjTJhJ8nKel3LWazUjsohl1k3PFL610V8=;
 b=DPJAUWBNFE0lF/L4uLphpZAVovjwotwLl4cywzkJxlIRZ4TwUOcI4BcrS/LpIA7Q31
 ieyjKD5H1qZe2fraFMdIjaClt5AM6IU3omp8++7RMb9D4V1qmhm6FBD+DyIyfuUqfO2R
 JMjGCxMOORs+ooQMlKNWES1DgVu+J4Y95Y8ZOGVKPoomTDrc0zh5KXFsHLrO2s/iOwmP
 pphIyz6fbrwV/3SK8WwOpSUsgZlFfTSXJ+zNvLQcuQvidh8LLyaEJB5qb3ux5G9AIMqC
 2/iC/qtpFA5jeWUu05TnuSGVWGIPDkiC1iw7troMB2lXsnK6qS46bm6rx4I9meJY2YZ3
 a83w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYrDXSVsf3y7p5MBGdkmAvqzqaHaZYeqMPwfI1+3goiGIcGaMk25Vo6urAdVjFhMTNKD1UTfBnbZT@nongnu.org
X-Gm-Message-State: AOJu0Yzj+QqTAbfUnJYVjmsWJE058X/3xvwhJ48QnLlHRuWUAeFzkhv9
 ar+zFLagdEfsdlB7XOwfFfPAFGAf3rberiq5QN6TmXxzIHNtMGc4CjDRRf7FhclfG03eNwNJOJH
 pIEPHCKQ=
X-Gm-Gg: ASbGncuz384cDFx81aaVbJXtCChZDtlXYq1rs5A8IRlvrxDQLPXxxqwP4piuymw+n5p
 vPOpbOMvno+BFhly42in5C5ZDHbTWs4cpfSP0gBxBxV271gu8eQoNnZqiC3mCCGlK83vnjwQ6DB
 IQ2kBCedm58mBPXT78CXSkblbLnalPuS69o7jf5xmDo7cu5wmvo0jLZpJdvQbbLCPK89xRaJhXf
 aYi5+1kj4Ntvf3sDiPS/Mirf+Vr8aZ0GVO+vebvUCzqn3DcdDuyhXfQAhkd9r8qSGeZqHx/98Yp
 WWUHKNzDnV8GXlDfdVhCAgvxa4hMXcBNAdoX1dv99uoGl5zx6ZysigJJjQAp9mj4XA4TKxVgsMH
 3MvQih5wCFQGiOd42V7Qp1eKNL06CICWrUOIhZGp5p17+yvREK+tY7jWWNyZKtnB+2w==
X-Google-Smtp-Source: AGHT+IEKwrK7hf7J3fMad0fs9WCmI+nX9usex4LTCHj03eUxqhsgPL2HSloG9u2AVjS93JvkPvDiTg==
X-Received: by 2002:a05:600c:1553:b0:45b:75f0:2d66 with SMTP id
 5b1f17b1804b1-45b7630322cmr21552235e9.4.1756370962942; 
 Thu, 28 Aug 2025 01:49:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6cbd435bsm33522515e9.2.2025.08.28.01.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 01:49:22 -0700 (PDT)
Message-ID: <59e3ab62-a6ba-4ffc-929f-8ef10783aac7@linaro.org>
Date: Thu, 28 Aug 2025 10:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>
References: <20250821154459.2417976-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154459.2417976-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/8/25 17:44, Peter Maydell wrote:
> In pca9554_set_pin() we have a string property which we parse in
> order to set some non-string fields in the device state.  So we call
> visit_type_str(), passing it the address of the local variable
> state_str.
> 
> visit_type_str() will allocate a new copy of the string; we
> never free this string, so the result is a memory leak, detected
> by ASAN during a "make check" run:
> 
> Direct leak of 5 byte(s) in 1 object(s) allocated from:
>      #0 0x5d605212ede3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (
> BuildId: 3d5373c89317f58bfcd191a33988c7347714be14)
>      #1 0x7f7edea57b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>      #2 0x7f7edea6d4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>      #3 0x5d6055289a91 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>      #4 0x5d6055289a91 in qobject_input_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qo
> bject-input-visitor.c:542:12
>      #5 0x5d605528479c in visit_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qapi-visit
> -core.c:349:10
>      #6 0x5d60528bdd87 in pca9554_set_pin /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/pca9554.c:179:10
>      #7 0x5d60549bcbbb in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1450:5
>      #8 0x5d60549d2055 in object_property_set_qobject /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qobject.c:28:10
>      #9 0x5d60549bcdf1 in object_property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1458:15
>      #10 0x5d605439d077 in gb200nvl_bmc_i2c_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:1267:5
>      #11 0x5d60543a3bbc in aspeed_machine_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:493:9
> 
> 
> Make the state_str g_autofree, so that we will always free
> it, on both error-exit and success codepaths.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/gpio/pca9554.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks.

