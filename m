Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB10C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 00:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkA1T-0003Hd-CG; Wed, 15 Jul 2026 20:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wkA1N-0003HA-VI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 20:32:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wkA1M-0007JU-Hj
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 20:32:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so55275095ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 17:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784161930; x=1784766730; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bdA3SRYmodoaJD5ICo+251OgbAq91t9IT3lQlwxmCZs=;
 b=Ad57ZHb63kWe4R9Up98P+CRYkwG+Te79YB0guzCykMEAlU7uYGScy6kiUFMuRnVZjC
 Vf4LySgHDsPX84VPlUz7a/rUcynnHrGEHFB4384BjrFY43vcvNhR8XsCPo6fzf+n4zGQ
 gEXkfUGP3RnIeuWKA2rOltwFYbZMCA3CD+rZyjz2n0uyGiheWtYwTvZ7Wjnm+m2B+aje
 N4kbmgzV8i1ZEXSrv5rhAZEdse5jHOB/oy9GicMc/GK1nYhAkl9NfdjKlZDAk3KrYx9K
 hhKZoc3Y6BNlvCYK0SvtQe/Y0KjVU+nXpA5PjO0m1fxtJDAh3gnvB/Knse5VVYPoxsbq
 j9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784161930; x=1784766730;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bdA3SRYmodoaJD5ICo+251OgbAq91t9IT3lQlwxmCZs=;
 b=go6QNlHhRnD5kOPZDzuRMq60n6V4TXVuKf69VIrb0muiq6yWMNrHbnhF/BJrsy/r9J
 esR3aM7K0NCpZgPMofybfOAUH/4bCQaka7HUNs121m0FSlsVB95Z25+44z3wfxxgkLYU
 mrBnQd870xJ/jBWUgF2GIV2uhMMiyli6wo41zUK0Goz0M4GKDVaF7QNR0X7NXCU1nBKy
 oo9R0FU1yMpBPrfWUopcnt7RQrzlhE9Vq8nz/Qv2gJ5sp+O9blu5UQiwZNTK0mbWURux
 Ioaevmxi7fnoHj9q28/5RmXLAyjvym32LF7Dn2AkRxzVBkXzRiEKRs0+ycI+6XUF2q0Z
 k8HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqS2b9zurOWyES11OJK25+McEX91SuuF3F3zt2sjdOrp/kpxO5dUrWVJ4TwPkdv0POA8qnv+BlDAK53@nongnu.org
X-Gm-Message-State: AOJu0Yw1i73WCLAwywdtsgLCZqfAn9jow9qrg5WT/7ZHJn15nkGiXX62
 0SxDUmjvviB8dIBOgFxamFPw+PNNBveBei3LWUAxr6b7ldwkmPE6BSQ4
X-Gm-Gg: AfdE7ckxaa1HccapRTbZkzV1kMaRdT1qpAt6W8EDMS6RSwG2YhBHeOzoLslDl2G3E5j
 Nje2kHeJQRPfMzT9j3RwRKSczvaEmfB9hAzGUjBUtL9TtWV6XaNjmqy5R/C7NAzvwYPuzGXwqH+
 HACj8kVwRDvmCpFjrDtlSsMMsxMCFZMD4MfPUs5GtO6QJBhXdFqfeiaskhx/8pVU0l3HrPyTBnj
 p03v4OAwQMJuW+ge8t/MWmduUG6x57fK29qLi/Sl7uRXadX2fdDVCn2jQLy/CdOoKTFQ/nLzrMd
 6xs2hZdcKdroMBmh7lABbcA39BC9VffsKvE0eSWJpQxmQfzHSVk6JZvX1bNX+2HNoRPwud+2tZv
 9+Az/Vy7qi7WtQWhPBdXQP9pI7HEkxIHm0X5jI1haHkMX+grjOAgWnPO6rg0+3DGwHOqdWIQsp9
 fBWlb6xaP10ZZ1s1Cs
X-Received: by 2002:a17:903:4687:b0:2ca:619f:9733 with SMTP id
 d9443c01a7336-2cef11ccc1dmr80492425ad.17.1784161930163; 
 Wed, 15 Jul 2026 17:32:10 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10120800sm10416925ad.23.2026.07.15.17.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 17:32:09 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 4/5] ufs/aspeed: Add AST2700 UFS host controller
To: clg@kaod.org, peter.maydell@linaro.org
Cc: Mikail Sadic <mikail.sadic@ibm.com>, pbonzini@redhat.com, 
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com, 
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com, 
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@us.ibm.com, 
 milesg@ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
In-Reply-To: <20260715155037.2237011-5-mikail.sadic@ibm.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
 <20260715155037.2237011-5-mikail.sadic@ibm.com>
Date: Thu, 16 Jul 2026 09:31:51 +0900
Message-Id: <178416191159.43667.4929863074645596799.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 15 Jul 2026 10:50:35 -0500, Mikail Sadic <mikail.sadic@ibm.com> wrote:
> Add an emulation of the AST2700 UFS host controller
> (aspeed,ufshc-m31-16nm) and wire it into the AST2700 SoC.
> Implement the functionality needed by U-Boot and Linux to enumerate the
> device and access a BlockBackend using the UFS protocol, allowing the
> AST2700 machine to boot from a UFS image.
> 

Hi Mikail,

This patch duplicates a large amount of logic that already exists in
hw/ufs/. aspeed_ufs.c reimplements the UFSHCI register interface,
UTRL and doorbell handling, UPIU processing, Query handling, and SCSI
command handling, much of which is already implemented in hw/ufs/ufs.c
and hw/ufs/lu.c. It also introduces register and UPIU/UTRD definitions
that overlap with definitions already present in include/block/ufs.h.

For these reasons, I don't think we should add a second independent UFS
implementation under hw/ufs/. This needs to be based on a shared UFS
core instead.

If the motivation for the separate implementation is that the existing
UFS device, TYPE_UFS, is a PCI device, the solution should be to
refactor the existing implementation rather than reimplement it. The
common core, including the register block, UTRL, UPIU, Query, and
ufs-lu command handling, should be separated from the PCI-specific
glue so that both PCI and sysbus frontends can be built on top of it.

The PCI coupling in ufs.c appears to be relatively thin: DMA access,
interrupt handling, and PCI realization and BAR setup. QEMU already has
well-established examples of this structure, such as SDHCI, with a
common core and PCI/sysbus frontends, and XHCI, with hcd-xhci.c shared
by its PCI and sysbus wrappers.

The ASPEED controller should then be implemented as a sysbus frontend
on top of the shared UFS core, with only the ASPEED-specific integration
kept in the frontend.

Thanks,

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

