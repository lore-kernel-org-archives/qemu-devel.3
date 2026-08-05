Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA391C55182
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 03:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrSkf-0008LI-UD; Tue, 04 Aug 2026 23:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wrSkd-0008Kx-U1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 23:57:08 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wrSkb-0004VF-1y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 23:57:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6682259cae6so596330d50.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 20:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785902223; cv=none;
 d=google.com; s=arc-20260327;
 b=AdO9vuJ2bWvH5zIWAEKzlat6+HJ6A9zH1Jz0GnMEEK2B+F9MwavclyBkjBv4ZfXSOT
 FvQI2k8yRhnfjH2Zpkh5Mir4/CkCsgvxp8OrArMOzC3Db2YqRQxButHDRzAsFziNdavz
 0RknFd6mCNpSUf1y9EP8Zwie2wf93JNfNWsu/IWhGJ7nlxvhkPpMlxdg/84l6H1h3+VS
 wc1ATfpdzCgRaOHcICRGsk3aTvIAG2bZ+Ucbo5SWrc0UyQzehuLqT34qujR83yuKoOBX
 xSgbsFRcoOINm3R5iPAPP3rydc8rc1Eay7RlW2n2B2Q2yZ2mXUAYfHGeyqiSrn4CNt/R
 m7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DGPqRyESTpo1dQjuakgv79ctyRbkGGHJyLgDIvGMKTg=;
 fh=qCGCLWECMPJt00xO2lmEnyKMUwUmgfeLlFh3mWJKEqU=;
 b=HVeKhfskHq4Fxjiele8U1dpr7p9g1Xf3LjbMAwuFG7WZoSw9/kcShR3lHq/lnAUXo4
 /F5IOHwSjRC46NzqJ17czH4ZY2m3WV+qrUkLdKJGZbDnjUUvpD9rj5Ojm/8ZIxfJ+KDs
 zXJnmeFECyKiUm1vdDusqBD8TcWqZoCTjoNazUmYbK08LBQtFmNjQ5idjo0FVoFHDkRm
 KU2grQeI0lKYdlGOGRU5Ql8oE1TmRNrcm1A0Zz5gEDN1jYsU/79TDuZna+dL1HRwbjzK
 XQCmyISa/qlSqvQiNy9v8/8cvRRO4gRPWgePdS26f4iIEd1szCmUwpBrGwQ3s1uGqgXX
 nVmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785902223; x=1786507023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DGPqRyESTpo1dQjuakgv79ctyRbkGGHJyLgDIvGMKTg=;
 b=rAxcZXxhjx4gBDBIzsEFOue5oVHtl2+LeiTaSbXWjygMD88Ggx4pLCMWh+kJbcXipn
 a5UhSoq7ma4QxqaAQnMRnHZ0CuxG9KT5IzFb6z0L5QBH3gwAxWKMHKHUSwy7LMMWbkAs
 N/W6/8fuLv+JI2Hrj6Dh4QYBZnCa002R0UICEy50Ntg8G2cgJArMIHhCZ84MYKKplHcv
 SCYUpln59D62xpYOt2Ecpgdt99Nt2+3qi75ut+cNQoj2hpQr2Im9PvJXw4styhLKZv/F
 cPySV0ikm6EIjBG51jHDYT61dvn4r17rr+IUuCSnVFMBv0aEAYLkr5i2EAUbq81msObi
 +iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785902223; x=1786507023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DGPqRyESTpo1dQjuakgv79ctyRbkGGHJyLgDIvGMKTg=;
 b=NYvuVRdE4Buq9exc7pczlVTgRz/yoi+BPi7wEQhpgkqslo5fj9azuPkO3UWGygTQZ9
 3bMYEEGf/uJg6d7KZUZgQAuObJ6H6mfxRgfkncYZ2bWKzhZ2J9MKDu4cAVK5nYQd7Cpv
 cG+syShkGSY1w5Nv4+aZXAXtMzl67J74i5s3NH16+HQ9+73pSiC3oaArkRK8isn3hIoR
 E/ysZ+tOVspjYTaSbzQgMkdJD/aCp0PPuS/fmbDTwXyKp2AzuemOEYvfjz5NHiEaqZ5i
 RELpWfYsN0Z1OXg3bxh1qyaBmhlks081j65p2dfsQ0b601w6IFQU9O2fxSVq5mM+/H8l
 N0pw==
X-Gm-Message-State: AOJu0YxHb+/t/vCOJ3OFjhdRegqmcWgwoBbZjlYXQv8y5HhI0u3FA5Xu
 daAm8+XJwJ01TPQe+ZqouM6kpZjdmbqxkGoVtM9aTXVCzt9DmmneA7aAqLcS4QyUcRiA18hnnaA
 6ZPvZQqZ5iTGi5lEPeGm3HA6me8KMFDo=
X-Gm-Gg: AR+sD13pMlfC2ucC2pxGe+V5Uw5ZI62HZ2jmDnIGImDSRbQgABYD0l8CURqQ4ucTn8F
 Ux2uVs4ubyd15sdNxd6rcXvdeXo5uIxzs1XFB1bLyiMISaD7RnjdnM35h9MJIMvXMQv5XBkdb+r
 FNMfNjomBaNavWmE4Ds0fH3ljFEKT13qXILyjAPK8H5f1mvfNNcMLov2ppiNUOdMCIaWXdCfE1e
 tPKw9Ongf79hCApDpSjs3yter8gxNY6V0pPH8qpY1q4+Vsy/CruAKAEGKJFHdC3Ma/L2mwG54qa
 9XLn+AhAadS9FQxKocH+YuTG8doSxlgeg+fcyz5XItE=
X-Received: by 2002:a05:690e:4811:b0:662:e0f6:ccbb with SMTP id
 956f58d0204a3-6699aa3f60amr1887052d50.35.1785902223501; Tue, 04 Aug 2026
 20:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
 <itp7xmctqnac4c7kytqyrrs3xbfnbjprem6ezlltc6b5ncdpdn@6pypq3e7lbog>
In-Reply-To: <itp7xmctqnac4c7kytqyrrs3xbfnbjprem6ezlltc6b5ncdpdn@6pypq3e7lbog>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Wed, 5 Aug 2026 11:56:55 +0800
X-Gm-Features: AUfX_mwcqGYmsjSXy4nsDQEPokVeJ3_G1WoJLBthR5AL833KJStF6fkLDjvCOkU
Message-ID: <CAAW0U4a-nG-ck4g8w0_Vt1Jbu5dNcYEDjJNR-YvGEiHa9G4Rdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=B4=
8=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 02:39=E5=86=99=E9=81=93=EF=BC=9A

> There are 2 variants of designware spi, one is called dw-apb-ssi and
> another is called dwc-ssi. If you look at their u-boot drivers, you can
> see that they differ in the location of the TMOD bits in the CTRLR0.
> dw-apb-ssi has it at bits 8 and 9, while dwc-ssi has it at 10/11.
> This implementation is for the dwc-ssi version (which is the newer one).
>
> Would it be possible to have the naming be consistent (DWC_SSI,
> dwc_ssi.c) everywhere? There are some places throught the series where
> the file names/Kconfig symbols/function names are named dw_ssi.
>
> One could argue that this model could retain the generic designware spi
> name and support both versions, but I don't think that's necessary.

I will make the naming consistently use dwc_ssi throughout the
next revision of the series.

I compared the dw-apb-ssi and dwc-ssi , as well as their Linux
and U-Boot driver implementations, and confirmed that the two variants
have distinct guest-visible register ABIs. As you note, CTRLR0.TMOD is
located at bits [9:8] in dw-apb-ssi and at bits [11:10] in DWC SSI. Also,Th=
e
layouts and supported ranges of other fields, including DFS, FRF and
SCPH/SCPOL, also differ. Linux and U-Boot likewise use explicit
capability checks to select the appropriate register field encodings.

Supporting dw-apb-ssi would require variant-specific register handling
and tests. But QEMU currently has no concrete dw-apb-ssi machine/SoC
consumer, my understanding is that this series should remain focused on
dwc-ssi, with dw-apb-ssi support added together with a concrete consumer
and its tests in the future. Please let me know if I have misunderstood.

Regards,
Kangjie

