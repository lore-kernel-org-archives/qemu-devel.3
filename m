Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B6606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aS0mWs+F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQo3R-0000q8-Th; Tue, 10 Nov 2026 10:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo34-0000jG-Ir
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:46:16 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo32-0006Vc-L8
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:46:13 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67c08c7adadso1783823d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:46:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325571; cv=none;
 d=google.com; s=arc-20260327;
 b=V++x6VrYGwR2NOkWs0Kzi6PcHlpIl65PPsZh7qpLs5cjrHUKwRRzencQga9qqqevOe
 0h7TTAnywXQEQcbeTarTk9oWKF4ZkCK2pGi+hjvu8v7q3TPaLG8pNK1z3ecUcjfDJV3Y
 GW/JAW11r7dKAWTOtw0dVkPptsWGaBnWySh6QaUv0jC8D8S/RcXQS5FZ1bjL1O083Ek6
 iAcVe6mchugXc6GRPHxqTPyyp5bPDTu17px58byHPMp+rWpMZ0WKesfjDjWE1wSmOaMD
 1FkpCrypDnbXQF3mwscEixa4A7jZKz/0iAUlS0t5KH+s9ATNi00HHXfWn3PKYSISQd3O
 JvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2YFRiM7I/4pC0eQpOVN4V0Yi06SrI0OO1sCQjwL0hoI=;
 fh=yL5eFPExM7gfBkmL7HwoRPBH+boDPmpHyxvIKNX9pqQ=;
 b=ld6F92yQfLKWSpLvfEdTPxo4/TzkaRMx6PZUYZPyLIFNUjTGWHwyYOebHwiHkgkZBR
 jf9gYc/M/yByaAnpgACOW6/Lemjco9DDMsMI00DjysrbSY8r5G2LBk3zJHc+QMnenMVK
 ThMyPob0xkAUpR72uyBNldv/weUWCPCTqcGdN7MUEBtSTe8W2WNRhGvzc+Zllr2zcLii
 Sd3FDSvSIYT9V3Hr2/6Rw3PV1WoO7J9f9fkZEliu9pX8kX13SiLs5ZsaMFbNwdTWTZb2
 TvvDvELYX+uCbg0Quj7TRjIoNj3TuByh+0qn502qlsJoIUpX5VEVQt5LyVvbJJJVVNjx
 dMvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794325571; x=1794930371; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2YFRiM7I/4pC0eQpOVN4V0Yi06SrI0OO1sCQjwL0hoI=;
 b=aS0mWs+FNY8xFyGK0WeTVSQwKSAp+DJu6VjNOZ+vgv0EbQdS/stlTvM+idAk9evxBm
 Uo0QqucdroVbFI5p44SMdic9u11PhrHLuSPbClZjjHUPcc164F5sVQHGWx/ZCqKf1Wa7
 II3PlUPGczb01PD7ZGpHkwAHbaPUPVF2weChPvnanqm59Ikmnmqlo5RdNOcnXANHIyKp
 B6GxJXRGFtzJMPMpzcnziExWxr0+o74y7/++CwInSXFfpXjwXdKU74W5LdLn0IRi/QBL
 RrjrU4+c/nVZXOUZgvnfBmfR0QN9wzLtTY/T0d1YZStBlxMoqtC3m++UM05Ym+9xgwQx
 EUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325571; x=1794930371;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2YFRiM7I/4pC0eQpOVN4V0Yi06SrI0OO1sCQjwL0hoI=;
 b=X4XX1D4h1EYO3LBJeQz+d3maAP+TDWfPgdyXKZ/oDPGkQHD2D4LjunQK00swnFCJpv
 DWV2Jbud+2I10Cm4oeEc7d1Omy4wI04SV4Fz6lIXnwwHCpB4MfVNYwEtFV2ffOEw2X1Q
 4wJx6ctZ81Wn1bkWabp6vQTQDNtcQlnLiO5dnfl1ZSjxeRM9+dk3Nrev+rAGolZ9BCWD
 zCsnvmo7ng5wrADVSJxsvIBU7bS8mbuwzkYKSB1G7dlToMDMs3+jfSLJkc5BA7ir+SUM
 6SjlKTr3t5PQjeRzebbkaSfeU0mtLTT1NqzVlvStAyqijMwwslTWGLBkpTPx3Kh/wyMt
 sLxw==
X-Gm-Message-State: APuU4Z9RBWpHFuW4/k6nCyeUchRZavZ/VFPRgqGYvHNZKY0cXyt3Yqnn
 izuKlxpZfLXXUsBKCH3F3zOBWCoY9ePOxnR76XKQzCMMhp1PJsqiYhn2Ope9ts1xNK+xK1WplNt
 vZKlBkcT+8oXBt/TvbN/xj+ulaE3eOuurAEJG5cUkEw==
X-Gm-Gg: AYBFou0KtF75A4zcq0E3adXof8vFBgDF1Maqc6HhVM6va6eTmrYdV8LzzGG6R6zDRhz
 tY5+inMe0R5G3ISbF7JhvVe8/SJCAhlnmS3e0vp0MqEN9A3kGm8iFKoV5IIY6d170DAt7ArfgVN
 VarhepO/KtL8zroO63DZt70rpMCDKtnS5Cgb9SSUwfQ8n0Oc4eTNg/Z4C60LnNyWUvKbu9iPd0U
 BSKFuJfNtfYWeQBx1Prc9DDFWhe0Ya+Kr3YmR8FpMfMvIMiXTsYPPTPhm6n/5eUfSZIk+PfAiUH
 vGMxVUXSEElKAWwnembFuZJM8zDhtLwKxIOEC2gZ9VxFG6XHVwqkhe7TsSyPfucqwIpUNrGr4fB
 Ju/01OyXOtGAbZAA/GQh140OPHPbED50byjVh6bpCEGWUkeUpxbCYwKKGzozT1+Zt0bRn4cRWyP
 P/gbpwvPDaOGOjOohrjgn/
X-Received: by 2002:a05:690e:190e:b0:67a:6b2b:b865 with SMTP id
 956f58d0204a3-67c568a9ca7mr1426084d50.108.1794325569733; Tue, 10 Nov 2026
 07:46:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-2-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:45:58 +0000
X-Gm-Features: AclHuK-a8F9BR9P4x5LhN2nkbvY-Vdk3PGFvLB7Ki081UKkg-BVI3Xz74bLRUGY
Message-ID: <CAFEAcA8QEwxFoqCtZJKzyy5e5B=R7M7V++cYN6xSbuageYaJUA@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] net/eth.c: Check for undersized L2 headers in
 eth_get_protocols()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> We already have some header bounds checks. Add a missing check for
> L2 headers.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

