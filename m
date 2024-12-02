Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108A6D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7Su-000235-3J; Mon, 02 Dec 2024 09:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7Sr-00022e-Fg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:31:53 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7Sp-0003nq-SF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:31:53 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ffc80318c9so44804321fa.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149909; x=1733754709; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FYSXYPJcRHSBi1DPhDtMCSULWcP6bgBEGvBAIkPXvg=;
 b=dkkIm1wuDml5gIL6ashUiUKdj/82+mDw+zwHabRt1rNUHIJspNiR1LOC6rE1y9H/6z
 dlzhJDAtWCT7sbUMRxGsw+kr9sAcr5QmCl/xUNMxeKaSccE4uVo8iiGSOCi2ENXHBi+q
 Dx9IX/0xWr86tdKGjLcLKxnkMDgOieVPzSk9AVAoTlNYvSsGSS5AhNSc5rwdCYP+T/NA
 +T/fNaDnX9iUkHDlHyZyjk9EzCvI7ZF0xOQGPJMJw1PwkcQsspwS5eJXHg78H6cAnwZ/
 arPPqaHozDQdDjOl1PiON+TLK1iECQADNxjL/m5I5J+lAuIQrsOheEgVSJe7tpWhYQR/
 CXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149909; x=1733754709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FYSXYPJcRHSBi1DPhDtMCSULWcP6bgBEGvBAIkPXvg=;
 b=ZPR/oJNJPbd7+/O1kQU5CNali/NRprSS1/Tw3fGT8ur5OBG24X0YZmUOKMs5YRnQPQ
 DYT/UkOetmUc6lUzCXtbga9Zn8eDChW4u87F41cRvuGscKnmfsuNRdlH3ESI6XrmHYWo
 V9aa8BSRoUWiCiLybyXcGXvtVbghP8D91JX2NersiFeYVCvOhkktXObnPwZZJJSD81SF
 iJSpmEfPF4WHRCRb4jnoB3UFDDKhPcrJXI5xv2Cz5F9+yzJHwcVxH2+AU/mGMudKAPxx
 tQ8PhD7bKUQwA4bXXt+XOke0Th76I5F2XlOMTmCiFTdo/STh3ob+reS6BZ6x/M9GpFo6
 8H0A==
X-Gm-Message-State: AOJu0YyieAxGdGsV5wYK33KRaosKA8TV4VafA0lq60hSLqQV1MlSNC5S
 UQSclkbllWxj+7iCL1e6DIVYO1bxB00r85VxOQNhXBdyrlg0MWEdaOOVP9l0UQO7gvrE2HKFNvo
 qi0Tec00c1RIxyV6z5SVB6Lf3gHahfeDCOSTgUA==
X-Gm-Gg: ASbGncuaZSn6czcSURm5K0Xnr01S9V7cDsMQvwSq5ZHe+opEFs1VEPig2DLXX6Kqt+5
 F9XD40ZqvLAM4cvZLS0zTrpMpGg2OIMxm
X-Google-Smtp-Source: AGHT+IG5ahPYi0vRCv2iDAfXGQ3cBele16G1+gEHo58PQqikuYToQQFis5JFQ/GkWbQR2yIvSLfNlQTTPc5tU+yW2Fw=
X-Received: by 2002:a2e:bc22:0:b0:2ff:a5cc:3ede with SMTP id
 38308e7fff4ca-2ffd604a2a6mr127309661fa.6.1733149908623; Mon, 02 Dec 2024
 06:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-2-shentey@gmail.com>
In-Reply-To: <20241102125724.532843-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 14:31:37 +0000
Message-ID: <CAFEAcA9xzkP=RmrHuKkXLRHAc5PXBVgPPRZ1KrJAps_OWt=s5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] hw/net/lan9118: Extract lan9118_phy
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Sat, 2 Nov 2024 at 12:57, Bernhard Beschow <shentey@gmail.com> wrote:
>
> A very similar implementation of the same device exists in imx_fec. Prepare for
> a common implementation by extracting a device model into its own files.
>
> Some migration state has been moved into the new device model which breaks
> migration compatibility for the following machines:
> * smdkc210
> * realview-*
> * vexpress-*
> * kzm
> * mps2-*
>
> While breaking migration ABI, fix the size of the MII registers to be 16 bit,
> as defined by IEEE 802.3u.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

