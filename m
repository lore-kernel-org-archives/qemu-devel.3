Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B6EFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABvd-0005nu-Dz; Tue, 07 Apr 2026 15:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABvQ-0005g3-Pr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:17:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABvM-0003kB-W3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:17:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so4727133f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589439; x=1776194239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rdOrKOPYnfGU/+Rh/+zymiBfgGeru/Ah+miJFHRifsQ=;
 b=A4lbKxqI2BxI/RnERlmTgwz8A4d5KwWpEiNhSfCwcuCAe5zjvYfre774KN1Ga2fsMo
 23dGiMyy5fl7MidMsFSI+soWvf4HZvHw6LkU0lO7XaSahWjWEnAUA/Fno+nbydAUYJxa
 X28nX/hZ4TLy6qs7TL72sSJuR9Pl+CKf0YzaQxSZ6/TAZn8w65qnlITb/kBE0XWPg+Dg
 231/N72i9gx0n8ks/eKQt1fB5GhBmtkUmEduROKTK2t9S70sMmI3sFunm57+v4kggUmy
 Qk11bbxoWhMWL8v3rJyWSWwmHcklEkR5NugMmQ8mxpmfAyyRCjHPw+7CbJwxiqdjEglE
 iZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589439; x=1776194239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdOrKOPYnfGU/+Rh/+zymiBfgGeru/Ah+miJFHRifsQ=;
 b=JLiV9pytFxVBT2zfTaRoQqCPDjavRcEz9IdePX8KUfp5+QN4hnZF/QzJFlw9pztWdL
 kY4+WkLAdke5S/v1bQZ5tjk3dhUA3B4GU4vBf2Ovx/EIw0LinMiMArvkS/hRPZbSDHW9
 EsqU6jlMXmXDDOY8D+59LPIDQdo4vaj7RuiLfmnVMqfPFJh2R4yFWKh2Bj+4PbgyOJl6
 5jxIEnuUcdLK4b1YBAAVQIXG87DlqcqyRvBpI3w3ZNd4G1GskL8XOOA7ruLd/ulpMjXe
 lK7gmwgVyy6RTuHvh3b9Z8o2Klnmlp+YJUiGqoZav3OjTfdUgHJo55dQC/CT0E66yIYh
 fqqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVKSXHkGdv/cDbBMQW0cxoyrXZV5mK3VitILgAsyWuJ99G7ltMcDGvn1XrZMkum3UPPIzQ5MRdJ8ym@nongnu.org
X-Gm-Message-State: AOJu0YxhoECS6EuIgELHyMQbsfy878tS7dmof5528WtVixsG6czQ5gGZ
 tgPoPz32zOP27p793Qc2+lVVZaMOIR1vEFhJYVsYVrzgL0VotUNRPx84dBHW8FBqC14=
X-Gm-Gg: AeBDies96rEzY+uNlLR74ua5cLReA2K2vDIvpjcI+XjqLH73U1I/AxaZ6UvFqtZLhsN
 hHkS4Rbj/iMNS2oQMxkNxlKGds2wsrk+JtM/1ATQULL5/Fdxaw24C5NnFLBlXFq50QF5P8kFXdZ
 1BeV650U7n09aUFkyqOyw6uq6PayFNPcdCqHiN35en9B97GGiW754qwMFPLieJaFEhhG4+0YDlR
 CbjSFBjAUbpGVDaP0eS8dm2+JlQK9WxjY84NEGTc7ey5p0dPTIWhJcBQUE21VqNdCv68hpggsSa
 Xsu45cOBQ9LunMocC5pZ/CyMitglOW225586rl3yfvIRi/LrkKV/5rnAh6hUiAusDOD8SYoW1md
 CP8rTykWiIduLqW0AWcnDpejASwu9g5wDobz44794e7P0bC8G6VVoNrNla3b0hgr4v6LtwOc9wI
 wf53czj+RFdngL5z79gB8NDnLF3wiZKln1+sImScI8/MEraHbR5tz6bmolCApWYYg84g==
X-Received: by 2002:a05:6000:1446:b0:43d:4c:22be with SMTP id
 ffacd0b85a97d-43d292d4789mr27077887f8f.36.1775589439229; 
 Tue, 07 Apr 2026 12:17:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c60a2sm50547199f8f.10.2026.04.07.12.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:17:17 -0700 (PDT)
Message-ID: <d02b6b03-e359-4316-a104-19871f9a5f89@linaro.org>
Date: Tue, 7 Apr 2026 21:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 20/20] target/arm/tcg/translate.c: make compilation
 unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-21-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/4/26 04:27, Pierrick Bouvier wrote:
> We removed all target specifics, and can finally compile this file only
> once.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

