Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A6606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F0FXCbE/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQXT-0003jc-3q; Fri, 06 Nov 2026 15:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPQXR-0003jG-Fz
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:27:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xPQXN-0007JI-Es
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:27:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso6241055ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793996867; x=1794601667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uqSWcn4iS4RtVIvS+xXvW+BQb2W/9yeu0vR0RGAlZpY=;
 b=F0FXCbE/HvFLjuih5In/OnlEEuem1WB5wIDN3I4vcrQ0LDzkNkEBF33tdgGX6oZrAB
 OOzrLSnMhgfTYEVLYvNXFVPwVZxEioCNpgZvxVVDX+0b3h9ZY/Zwj5FS31E+ZjAnQq9x
 0GCnSvBbtHNh3pt0osnU12DCihlLIEjWbHPUx2V3p20zppGk77iF5nungFvoAHzHzEu9
 ecoqoXFjRK4KifmXASsFGuKubRmevwBKDVjwhj8kM1sWf7Q/DFhRCLDPgRw7h6xRjDqd
 K3b0O6AtikpVuA8pqtIOKSJejdMQ/fjePJsOHyjUSaBtGhh/xN4Pkpd7vLBigc1Q1OJ0
 vrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793996867; x=1794601667;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uqSWcn4iS4RtVIvS+xXvW+BQb2W/9yeu0vR0RGAlZpY=;
 b=rD73pYCj6UYf9bjsluEcfXeVNYyto+VUVT7FbbiqtQfvnE9aiGltJ7tujKo3edAOD5
 0piQCXs+oHYjX1gRL969Q4aoGxEbZVivpUUEIaXF4PuDdrsgAb25kltWsXKi+rkPViQY
 WLg3ow30TxCw2TBi9d73MufoTSuqliE784l8d5N++eSDnh33Bj4OIAemgx1Pms9i7Iva
 KTS8SSyGzVxFaMa9a07vQSXEa3spoQ8ruV+QS+4rbuXas0rm8Y2VbXaFl+hyrjxwqzlt
 B//YIPndwCKnw/Oiu3DCOGVsdBoIV9D9GY6HjngnhHZiMJtk6IBzWevL9MP7VjcSlmac
 Gacw==
X-Forwarded-Encrypted: i=1;
 AL+hErFAHt49zdGFAfca+lJabpDOL/vQb+cMNAojMVZbqmOSXF3FuXehBy0lsF74SnK4iXYDlsXMl6lHpogj@nongnu.org
X-Gm-Message-State: APuU4Z/kglszQdm4DitbZ2Ky0vDSPpW5imCsCiBTmAIWbtx/CA9au8Zh
 lYw0FWIdbrn57I5L4Xc+L19aHmoOdCBXKHLYOo1UcAxlZYunPPKmbMnCU4aLSfpiuFwFSlN4hyo
 +luEa
X-Gm-Gg: AYBFou02Ebr6Hvg1DCEtze+5N7STg4SAA/f4cch45VQJvMjn4r5ySo0ngYZoMSUy6ku
 XOjYcCYnvqkYKUd/9MKXS3AjkR4TQldJEpbekTzb3oB0TmX48YZopWZ5dN9aeyyc8teJaKwMGMW
 6jbKBSfZEzkKdDb1ewdWzV0zhNeTpJ3OBQX64jrqQr+g7aUarOE/J7RN7JMVEGRxq/As7WxmzA6
 J0KlHzG5cvVj9OqgvXp+BPDfYM8C8OnejIOZ1I8sYw/1LOY/Wq6P46BWDBb7uot7XhOQFXOkRYp
 P8iIY6WHn2q2Ac/Y9SzC8VcAMmI3Ghet5cumIMsD/wGzBjR0mESGL7vf5SNja1Znl8m1N9Asjld
 GKSTNSJv+2lzo184t0tYnTB/Icac5ZpQsmoG4TNWkgNfvGVIrC1jt1QCUAB4A7A5OoMlzsgX2Hb
 CDAaBnxyr3pl1CuWOhzgOf3AKYkHN4ANubjOXL3xX2oiTDmb8oS0o7LpKhJlY0cqW3INbRArX1F
 h9Ft4d8DYzr8Kn5WbXnKDfcPov+b6Ccha4KwqfYIa45uh5Iu0iNg6u+sfGAzeuiKQVzy92+NYaJ
 DAiowlH1mkLtzbG9/MfpFZn+ymwYvXxxdhI1IWNHk4m1UDtnZgrD5Ysogu/U2+qY/ewv83pz1cc
 NddICnAMxxQSbIxo=
X-Received: by 2002:a17:903:ac8:b0:2e6:943:39df with SMTP id
 d9443c01a7336-2ed40c20fffmr47619525ad.25.1793996867299; 
 Fri, 06 Nov 2026 12:27:47 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d88651sm8836875ad.60.2026.11.06.12.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 12:27:46 -0800 (PST)
Message-ID: <84bff89c-903c-426b-b2ed-515356e2f06f@linaro.org>
Date: Fri, 6 Nov 2026 12:27:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] QAPI patches for 2026-11-06
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20261106121143.3771978-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261106121143.3771978-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 11/6/26 04:11, Markus Armbruster wrote:
> The following changes since commit f71afb409a87c4ecd0f9d63a5963eb645dfab780:
> 
>    Merge tag 'pull-loongarch-20261105' ofhttps://github.com/bibo-mao/qemu into staging (2026-11-05 07:24:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-06
> 
> for you to fetch changes up to 6955264d5821b453d3e68472009fe445b55e6311:
> 
>    qom: Convert child and link properties to QAPI-aware registration (2026-11-06 12:56:26 +0100)
> 
> ----------------------------------------------------------------
> QAPI patches for 2026-11-06

Applied, thanks.

r~

