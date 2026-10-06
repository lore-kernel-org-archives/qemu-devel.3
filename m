Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32120CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xELxt-0000qs-Cf; Wed, 07 Oct 2026 03:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.carrara@proxmox.com>)
 id 1xEFtP-0006yv-Uf; Tue, 06 Oct 2026 20:53:30 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <m.carrara@proxmox.com>)
 id 1xEFtA-0007ph-PJ; Tue, 06 Oct 2026 20:52:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1251D47E9F;
 Tue, 06 Oct 2026 11:24:36 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 11:24:35 +0200
Message-Id: <DLXNAN777OY6.2DP36CH3ZZPZS@proxmox.com>
Subject: Re: [PATCH] block: vmdk: support raw device mappings in vmdk format
Cc: "Fiona Ebner" <f.ebner@proxmox.com>, "Fam Zheng" <fam@euphon.net>,
 "Kevin Wolf" <kwolf@redhat.com>, "Hanna Reitz" <hreitz@redhat.com>,
 <qemu-block@nongnu.org>
To: "Max R. Carrara" <m.carrara@proxmox.com>, <qemu-devel@nongnu.org>
From: "Max R. Carrara" <m.carrara@proxmox.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20260922-2026-09-support-rdm-import-from-esxi-v1-v1-1-2c8c8644d233@proxmox.com>
In-Reply-To: <20260922-2026-09-support-rdm-import-from-esxi-v1-v1-1-2c8c8644d233@proxmox.com>
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791278675533
Received-SPF: pass client-ip=94.136.29.106; envelope-from=m.carrara@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue Sep 22, 2026 at 2:54 PM CEST, Max R. Carrara wrote:
> Implement support for raw device mappings (RDMs) in QEMU's VMDK block
> driver. Handle both virtual and physical compatibility modes. This
> allows us to import RDM disks from ESXi through our FUSE layer without
> any additional changes inside Proxmox VE.
>
> [...]

gentle ping


