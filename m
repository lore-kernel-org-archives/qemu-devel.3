Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CD606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SISFRenA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNZoK-0004z2-DG; Sun, 01 Nov 2026 12:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNZoI-0004yL-GB
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:57:38 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNZoG-0003uB-Uh
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 12:57:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2eac4877accso7349155ad.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793555855; x=1794160655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQTtOiWQWqsd8An2citZAyGicnQv4dmk6AILf8PbArE=;
 b=SISFRenA3RDbSZ1M/ory6hNQkaCQcsgphNda+YYaVsf36jrnsB4mwLDNQ7GGRsyI3d
 RdY7Vn9C3+zq8LDko8AKbW8EBBSYIsG2z+5NTK2C03ln/Gvpy+++s3xsTyTvQzBs757q
 nya1V3j19zVGubJEU9a/HYCd9IJlgcYwXZBfZpsVRz0624zcLKziriWUy0w1ViOQbdj6
 DKIQGq/M83oSKUc4WP47RqcxP2XV4Rqr9zgcqTnTtW+nN6/Dq+/CgK9Y3WehlZDRSu3E
 ZNgRFuOWt0AXed6CCTXBznOZAXaOAt1nXWYSAPLctN77F+DKo2B1ZGFIouqoTxavdkyR
 o0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555855; x=1794160655;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rQTtOiWQWqsd8An2citZAyGicnQv4dmk6AILf8PbArE=;
 b=rtcgXo8YLFpOTXccAsUe4QUAN7xTN7MKpHVVT+vi+9/8blfAX2uhX1iwIJwT8nQB74
 P7joH6Tph7nv32OPhJWbQeAWz0yEKLpp1dzxQrwcR31kOViYbuUFlJwfpyDdpakYwO5R
 O/WJ+oAjk9Wp3yU2dzfmfz+e477vi76lrGPebb0TeIA7klgSs0vPhBzcLUgnMlsIIaP+
 Qvvk70SliQiAmlBhFcQSUIAedLM7/SnVlxWhOuQBgvZ9zyzvHSSb371KT/CBAfhdBc4o
 HTXux+Eo02S8s+YmOMgujfUNNig6aknTzAZfiPrrL41Zd3ataOsS/x+ldr8HlW91RbO3
 bLHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2WqJbKFbOVODaxWZggTCt/97vWxn3TRuMw3vLBPRxFPf72eyGOADebPjNuUJFno0cUgjWGBHb/62K@nongnu.org
X-Gm-Message-State: APuU4Z90BLFZ2vC1CDnC9LMj/bhkM1Sm3mHwADI0Ey8L6Q0Al9TiTD8Y
 /89GOeTEJW/jw8eab7oKzjS/YCrxoN9k//o/bdMdSoHymU/NZN5S2RZl6KIS8kebUyO+NindiDl
 XtZrw
X-Gm-Gg: AYBFou1glojXaxy0FgdbR03nVRnvpfiI+XyIRkJYCToIDowve2xaez1GfbOvUeGwYuT
 m0j0dyZpkbNDAroSQ+MCXHSEZXo+mjVypYD0fcd1cqUhOpCorh1bZp33l4blUC3phEcFjMLOesa
 kOBJMz8BIcEIDybPFLQFc/3Dqp66k6ZNwned/NVYOWFJ8vvB/UHmOWDM4pWh+P1GgU5/7YB9Pzs
 hhHGZmJIeMhIjqKbdVy3IvtcGC68Jcb4qijmHQV46u+fsjUV4xLocZZCfBg0DlV1kKv0aD0J0a7
 3l03j2sBadc1VzYwehACdPigQPXlIkMLKzurJzV31/zSyMDotJ8BaHnkrRk0q3l+RPiD4/cdGCq
 GVlgVtniu0dyb92UAxbYd1fGFOsksKGDqmnKN3+gSpnpzSofibsqY0gxLlpX/A6iVaZktQQxDCk
 KD5zRNCBxhBvjkQ35eQuQwryfFkMqA5gYSLZWCFwGVM8W9Yc2OiKuu2JGrxSXjukoPBirAu0+fC
 3GI4lqlUVvymnv2ekbXWJyVoRkPRbDm3pvpyK/GsVpEIdjJYDhaU69rfxn2C5xV/p+riswceR+U
 88xdK1WAowj6IX5acBT6o3j3bZvRN0q8ZtzKID6UwexYcng28OMu/f/MVaiZnjPeRn7OpQ==
X-Received: by 2002:a17:902:ce90:b0:2e7:ff72:203f with SMTP id
 d9443c01a7336-2eb365052dcmr73992205ad.61.1793555855184; 
 Sun, 01 Nov 2026 09:57:35 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39231422sm19961585ad.23.2026.11.01.09.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 09:57:34 -0800 (PST)
Message-ID: <4462931c-9c9b-41ab-80e7-52e4d7a227b6@linaro.org>
Date: Sun, 1 Nov 2026 09:57:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] qemu-sparc queue 20261101
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 06:22, Mark Cave-Ayland wrote:
> The following changes since commit 33eb51c859834f2024090bf843c69814267b6c26:
> 
>    Merge tag 'pull-vfio-20261031' ofhttps://github.com/legoater/qemu into staging (2026-10-31 16:52:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git tags/qemu-sparc-20261101
> 
> for you to fetch changes up to a1eb9a1720eb2738a54fa16ff9fe4ce0b9da9caf:
> 
>    hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg (2026-11-01 14:01:53 +0000)
> 
> ----------------------------------------------------------------
> qemu-sparc queue
> - The remainder of Stian's crypto patches

Applied, thanks.

r~

