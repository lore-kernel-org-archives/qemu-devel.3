Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6250D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7BC-0002EE-MR; Fri, 09 Jan 2026 02:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Ax-00024V-JJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:44:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Aw-0001mp-8e
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:44:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so42937055e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944688; x=1768549488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8lgIk/rH8Hvn+6Pwlizaj6W0SKdss5p7/hE7EBUwqVE=;
 b=rK126GSqw6C2FWGLFRO+ZTgmTy2U4xspJeuX20Ai0Qu1MqiAOsL+MnW8E16Gs6Fzmy
 DEYeY0tuU46VRI1F/gHX8l54Hkj3tprI8ejsslMHMGqxE9qQ007cYFTmEnTf2GFnpn6X
 dBxbCHOmYh3EzEh791N6NezIB63rcQG5y+SjaKe3w06R3nXhJuETrB4UbeTyJJ+fdUJ/
 Eg9LDaaFQUAl34ZKLD3b/tDXSS7/EXo5yFef+RmDnRx5vGFbXbnCIaFVORqRMRIfCOcW
 34aQaeG7KdM4IfFRTvMVPm2St+tjIlng09Lz5OHZQEJkJTf7BdNs7rVAKPHQIvb9paAa
 EOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944688; x=1768549488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lgIk/rH8Hvn+6Pwlizaj6W0SKdss5p7/hE7EBUwqVE=;
 b=rY/AVoSxvpGq5zv8OV4ZaI4zw1Vy9ULaquuU876iIVWhkdMiC7dyipzAydkiVGxdu7
 uBQbKpw0E1j2NWv+ZwMZ1zQ0CfojR8WXc5nHrmfu5+rC5ysUaPV805oClO8rp25NnC3R
 qV71pSD8ezoCHbWfy+aqPB+mgC3byNLPwx5+riTRGKv0rI/wEV0cf3SuCgh74mpW1bBN
 8k3S87DFWKAK7zbKyKwjsHOq57mED2enwwxqEGIZJL7x9emB6TlJ6QnjEmiKHbC2kZXu
 gnhB/tBBf/7YNoRe0ZpqGn9f3EIKziZWAGGiYAjOC8dAxbaS9pTiSWpZYn9CtrPk6T3R
 NskQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lASM5I62QWQ0BkaGRp0346cabegaMv4C/xCtXprmBFjRKOX2VBjqVMwwLTzM9udHuGscCkMfboHO@nongnu.org
X-Gm-Message-State: AOJu0YxcxvhKUlSMn18RP4jXWm2PlukWm90aOIzsb5merQJd4+Nbl/5C
 El7hUyB8zNfvNb+8xSHlmSX6knwRTLYoLDNY3iXPXQNOCsFjBCTeOPX31mGBiCOA/GE=
X-Gm-Gg: AY/fxX52lxNtkBPqtcuh0Nd2Xu3x2+6cjgrktTzP2H4T25dBv9PlSOWezb/azr8kcwD
 E0MzQA5eXFi4ZhSBPHgHPSfdrp0aedDFSaln5MiILsifcxBBg8xJot/aJUC9SRNBDsElmncvgx2
 odr23qwONjAO86vPtLZ+q3TJLYsyvCzmXIkViO02HwxFhtL097ZyXShxlUiD1GErVlx34lA4tM0
 5m8/oTFyg7oi4CnN6rAy52EI2ahN+FXsTNewgpeOhQzBTSSHsdjIQg4rs55EZlhMe8TJ3MFZzRv
 YDo7aqnjhPSM2d+lH3gWZM7DAOwPKrXyO62OqviSre15mIKeAm50/FwfeOMZuRESuZXlMyAnork
 Y/xoiZBtfKn5yzZgvaSAtdin0qf9l1UlTDsV7b0ZQKBrnMeb4Tp+p/mTunmk49BB4lukQzebIT2
 dBHnlUMUdjAgnXo/SYT3TAmv2S7zQL/aplMkf6hH7i61hNfgoIV41BQA==
X-Google-Smtp-Source: AGHT+IFeH/YJUuyfKllk48/i+1lN9EKjx0uq6mWKFjHzGGrbGmgTfdv4TvJp4zwe3jFDLfbW7qI+rg==
X-Received: by 2002:a05:600c:4713:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-47d84b32748mr114551295e9.17.1767944687612; 
 Thu, 08 Jan 2026 23:44:47 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865f84besm60258215e9.1.2026.01.08.23.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:44:47 -0800 (PST)
Message-ID: <a4ac4a84-537b-40e7-86c1-4191d51dc7cf@linaro.org>
Date: Fri, 9 Jan 2026 08:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] target/arm: extract helper64.h
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> This allows to get rid of TARGET_AARCH64 in target/arm/helper.h.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h            | 6 ------
>   target/arm/helper64.h          | 5 +++++
>   target/arm/tcg/gengvec64.c     | 1 +
>   target/arm/tcg/helper-a64.c    | 1 +
>   target/arm/tcg/mte_helper.c    | 1 +
>   target/arm/tcg/pauth_helper.c  | 1 +
>   target/arm/tcg/sme_helper.c    | 1 +
>   target/arm/tcg/sve_helper.c    | 1 +
>   target/arm/tcg/translate-a64.c | 1 +
>   target/arm/tcg/translate-sme.c | 1 +
>   target/arm/tcg/translate-sve.c | 1 +
>   target/arm/tcg/translate.c     | 9 +++++++++
>   target/arm/tcg/vec_helper.c    | 3 +++
>   13 files changed, 26 insertions(+), 6 deletions(-)
>   create mode 100644 target/arm/helper64.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


