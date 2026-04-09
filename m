Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C56EE98FAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 04:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAhHx-00085T-DA; Thu, 09 Apr 2026 00:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhHv-00084k-3c
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:46:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAhHt-0003Fs-L5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:46:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ba840146so3348105e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775710000; x=1776314800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tN4iP+/W7f9tl7+doV9oPQItuL5wrUcZi3o14We7Hfk=;
 b=F6O4Nf3T30KPeyf84cCNdElGuq6yW4JJZ/gHA7WQvr41W16om7eoMilc6SidwKKXh6
 YdyOgtfo1rDFV05WbRcjFtReyJ/brZy8KaPqMbwlETJU9Ll1UA6awtcTehuIXXlgpfoe
 3VG+XJlcIn61PQPd1YQzoyoGrjNBD5T95Sfe/FmnlOoJ5lQuFeSPAoBCFepf5RFM84o3
 uzyW+sMMzvJceuwYXgEZd4vcpA7yso2kWb7FNQz5b/MhQifnVGePHtDQ4Gl0upLdYzxw
 V4yeQIEnZ2zAnG5QBOFqDJa8S7WpKsy4uXZJxXH92IcF9EWRA/iEEMdZBoLCgJpO+gWU
 XWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775710000; x=1776314800;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tN4iP+/W7f9tl7+doV9oPQItuL5wrUcZi3o14We7Hfk=;
 b=lI65fwKSnPsppnGcO2e51PJF1f6wgQ1RS9nG4USe4wrr9Wt58oHt5Hjl2g4/DZr3x2
 qr76H/FDi09kCA73kQiBy2as9kTkqMzFKFNiBP58+h6mnbX4kPOu2qSG6BhTBhGlryZp
 LtEQ7uQF6FBum2j8EOzCL/9ywIP4mJvXQxj0ZNStEYx4UshYVwj9n+Cn3Zjd88Fb51wk
 20lQgLK1wAnEyig09/1w1JJ6CdStAacg2+EKKxdIRfWyoxb7maI+atXx/F9INEseR6/9
 +1rBebuRcuDaegOoOajlf3k2eXEPZXMgCFa/Qfe9U1vxnB7oo0Tt0OdVBqfEZw7X3O4n
 F98g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaLtp8CIXOelV5tNjmgWeg5xuBtZjNAqRjZuWYeJKgRtH/ofEfzVfQslwj0gZkeQz6aG0juJbgl8Ms@nongnu.org
X-Gm-Message-State: AOJu0YwsZgtkmciUcTzj4XEVQcIc5khswwVETMFpvPvYMca/5mVcEAul
 7PYhTanDXu0MWlR47RjNnWg3mP/tGQRRY3IKOu8ZP5B55AUzEd18TaITKdvZjbkxz9I=
X-Gm-Gg: AeBDieuymyezNWXkZ9Xy717WpjhjLckX7DxycyH9k9jPROWE6BClsBdTn795SE+uPfp
 loNIpn7Q92Ks0deZ98GYmrJ4syENftKnp8dZcu7z7rRfihZpPE3YklaJ5S/HgdahZPJAJwZxh7B
 HEPlrHpOI8FtFHD1nO/koDOzxJwEqBq78E5tadYmbFowmNKEZo/pxFsBFOgHlLRlklX8T2tolXX
 ESqtOcj0lfLcZfWztZ6z43JYd3t6GlR+6Pb85/xgyPW0D/tZ0lr3KzLsDnoF1+C8/FjBuSpkXSm
 eSAeprVN0kdQsR9Vk/hltGYw3dYM9Vkw1d0THDIaKyoZfsi7i07x4TUJUAm7Ivel2lkaTVqCuCx
 noM5g1K1G2lSIUoxSKEo/e37yprnEn3mbfZJes91QCaChq/lbSpZfg+qXICx66voiJdDBGPXEGQ
 BXs/mn2MjFKmDUVN21BZ8s1HwoFGx3x3QM8m47/ACETiSbMKwq0BlATrPr6we67z+kfA==
X-Received: by 2002:a05:600c:c083:b0:487:1108:48b8 with SMTP id
 5b1f17b1804b1-488ccf4062fmr18027595e9.2.1775709999638; 
 Wed, 08 Apr 2026 21:46:39 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cfa75ae2sm39769365e9.14.2026.04.08.21.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 21:46:38 -0700 (PDT)
Message-ID: <2e703787-96cf-4b0f-827a-81c677a9455c@linaro.org>
Date: Thu, 9 Apr 2026 06:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/arm: Only define aarch64_untagged_addr for
 aarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, peter.maydell@linaro.org
References: <20260409035015.132370-1-richard.henderson@linaro.org>
 <20260409035015.132370-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260409035015.132370-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/4/26 05:50, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

