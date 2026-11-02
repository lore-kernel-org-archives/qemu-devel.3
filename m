Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E9606ABA4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oYrxmLR2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvYc-0007uP-If; Mon, 02 Nov 2026 12:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvYW-0007rQ-Gg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:10:49 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNvYU-0006TN-Q1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:10:48 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso545512266b.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 09:10:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793639445; cv=none;
 d=google.com; s=arc-20260327;
 b=hvg9vQaQh8EWzfMt4xnNTXFY6yn43kf3wH+6ar3xpzB+Z8wzEyR85QFvE9DAXpHG0/
 olG/ngp+lyK15CWvy70Z3S+DBKLUAtsel8ZhBcg8yt3aEHwnxYQy92qcmPtYULTjXHxR
 oyZsfGLgS3Yr6xxh1JxpFe0fRzqAWHA4eAme/vBPDcM535T4tOrRzLGsTMiDS5gPuVEI
 jpAylekQHR2RpHCnYYoLoe/bH+tW2XuiIbhKjzc3PiRXr0TeR3NBR5EnIvzk21b4adtQ
 xBmPGpEb3JZvIJFx2eELV+8IiUsOG3CJqQYkdSJehHf+SI4GyGBRejA2ZE4S4Q+usMun
 N89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkUDcZO13b5CDOBhwhbxw4u4HE2qnVF6JfiKNmGNzfM=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=NHMLMIrrlm8Mc6oHRQKxQW9hbyRZTDXC/pN4kKMFr1Ll86ulgi3J2dP2Qco0xgfH4Y
 0k9n2Wz75oAEYYCIwnHQLJuc6iS/UnX1PkFtZ9GHu9PN9PdaTxGGUE0TbGu0Oxc/XkL9
 /zbaUUq8Yn40p/rMTVLpTbicZ8T06goWbqYv5DGVlMrdg9SYfd25dkZ5gNVeWGfG9xqr
 5ZfCSpRxrPeVwqymbogxlSml+fCv81feDUfz8w+1hZj38vSFIJ3s2/S3GBNTpiAibeY7
 9PIPM1CMPQ4x3yoK+JL5AyK7uolKJIOGTVByhT8/2jXwAkCb5frwN2RrrSHPyb4BMlFC
 W2Yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793639445; x=1794244245; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AkUDcZO13b5CDOBhwhbxw4u4HE2qnVF6JfiKNmGNzfM=;
 b=oYrxmLR2qRuo9ryzUY/W4zBdNNDRup5SUDppwpUzwiiSq8Yv5KJNKzfSvUkb3Muumm
 1oCJPNq3gH4R0WaLQYsVC1Z6xBfYows6qtgwIG5v0Op3jnxOxeyKdPvKVRYwb4c6MmNT
 Z/IcT7B/qtLGzc60B/q6nXSlssOfFYYvSEJM4Hi+xVzdIRNtdnGw67WTpOrzXHv6MDSh
 yUo7rDTj7EUIWzU8Ao7VPt3HVJfIcMelDx9X0EdGMr8sAmusFQk8zzKwCtc8aR1cEtGf
 QpaUAKXWuWJ3yc314J4Ka5x7rW8iaobg0dNam0bBnidXQVa4hammICur6MjbQq+xSaJ+
 DJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639445; x=1794244245;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AkUDcZO13b5CDOBhwhbxw4u4HE2qnVF6JfiKNmGNzfM=;
 b=f6DFSDfu9FUhCYsaSgQGgTHM+XD6v0nkNh00ZeXhiKaN3CXrFN5dcs1iRxdRRr5OMD
 7Vq/GKCFAxTHiOBP4cGvDatU/A9N4PAHYtjnZG0BoqnK6Anspe2/EA8z8tdJZVE5Ri4/
 ho4EdkPkt+ThRfk2VXvWuiN3Y1JYAMwGblA2WK+LD79YbqJrUffqdpWPv6RQ8Vg1Ck60
 AXdtg+laNaQijyPyK8usaXNIlueM6Q2OrLdu2WW3EfcG3L334QP0CGcbpO4//36uoGQw
 wep3jQMc6zT8A7bZMB1oz3sx91o1gWBTrLUWT98A19GsefKpgI76qyvILj6QJq0nxOvX
 Yw0g==
X-Gm-Message-State: AFq9FYKqjyJNLDNmJCxyVxGVXvGbtQXi08RCZgoT01gBM8Vzie7D3lW3
 WNJQU3uxGKqXeDLHJCY8dXt8Kl0WlsSv2qXhp4Y0wW7ADWQdbd5RvOPIlh7fIaRWODJxXlxVyxR
 CV+Ej+c/Rv67UPNUJDQa/BgRNqBUca97UT8AvQaadKQ==
X-Gm-Gg: AYBFou2Zt7SWbU3igkwCgEDDfOEi/j67Upt+QGgWd0BqI1/kFgl8QZGCd5DlhxnRBkZ
 90dWRNRZoQdrYODPrOgoKCj8kXy7UkeLjtmDRLca0DN+B1i6JMzmIA57O2PSOUujIfj+wQmg1vE
 BLHPI3uZqPi7rOwiHEvWyzE/K3V2zy0UPJV3oUibDM7wu2/CZIZPlU1oKQLrRPrN2Rm64r+XqeE
 pUM/7GbI4TF3+tCG96D8Rg/49a+MvQXriinXPFFl5b8/H7ADUkK70sXpQSAzBoU/snr9wAu9e8v
 qWCfr9+ik9ft9VK9QMJEP/YQACq6TUXU+GFl25s8vWct+5TXjLec/NsN9isYMLe32xVvnKB/Q6N
 S+M3i2+giqgfNqpPFFlKdn3NgzsUEHueTGTARmu5a0+WJ/YN8xUrQqnIO58017yZoBfFS2wxodJ
 bNje4bHn4qFFTNAe7GrPsG
X-Received: by 2002:a17:907:6eaa:b0:c40:bbd2:62f6 with SMTP id
 a640c23a62f3a-c4ca7a730acmr861405566b.19.1793639444922; Mon, 02 Nov 2026
 09:10:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
 <9fbd0709-b62f-40fd-a055-5483bea6e83b@linaro.org>
In-Reply-To: <9fbd0709-b62f-40fd-a055-5483bea6e83b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 17:10:31 +0000
X-Gm-Features: AclHuK-N3PMQXRsoLC-IIwbeWE-Cusybe5MdRlH01F16vtAeoZbCZobxd-U3Y2c
Message-ID: <CAFEAcA-gttAwVf=5L+OQERXN-qiSf5ROm0qNvbZ56bPSMM_YjQ@mail.gmail.com>
Subject: Re: [PULL 00/47] target-arm queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 16:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/2/26 05:35, Peter Maydell wrote:
> > Hi; here's the target-arm queue for softfreeze. There are various
> > bugfixes and refactorings; the big "new functionality" patchset
> > is the reapi4b pci and ethernet support.
> >
> > thanks
> > -- PMM
> >
> > The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> >
> >    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261102
> >
> > for you to fetch changes up to 79b27f3d0832c2b0ffa3e1a59f0f2c46fc0cdc3a:
> >
> >    target/arm: fix bcm2835 migration issue (2026-11-02 11:41:14 +0000)
> >
> > ----------------------------------------------------------------
> > target-arm queue:
> >   * raspi4b: Implement PCI and GENET ethernet device
> >   * target/arm: Initialize SMCR_EL1.EZT0 for linux-user
> >   * hw/dma/xlnx_dpdma: Don't allow DMA off end of host buffers
> >   * target/arm: For linux-user, prioritize PC misalignment fault over insn abort
> >   * net/tap: Avoid "close(-1)" in net_init_tap() error path
> >   * hvf: arm: save/restore SME state only when SME on
> >   * hvf: arm: advertise ID_AA64PFR0_EL1.GIC correctly
> >   * target/arm: Refactoring preparatory to ID register configurability
> >   * target/arm/cpu64: Define cpreg migration tolerance for PMMIR_EL1
> >   * gicv5: minor cleanups and bugfixes
> >   * target/arm: hold bql when SEV sets the event_register
> >   * target/arm: fix bcm2835 migration issue
>
> Fails macos builds:

Oops. I've just sent a v2 which drops the patch that added those;
hopefully it will pass CI now.

thanks
-- PMM

