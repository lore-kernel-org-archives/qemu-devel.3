Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DD6CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGada-0002L4-U7; Tue, 13 Oct 2026 07:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.fastermann@proxmox.com>)
 id 1xGadT-0002Kh-Me; Tue, 13 Oct 2026 07:25:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.fastermann@proxmox.com>)
 id 1xGadR-00040t-2T; Tue, 13 Oct 2026 07:25:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0871E407D0;
 Tue, 13 Oct 2026 13:25:21 +0200 (CEST)
From: Erik Fastermann <e.fastermann@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Erik Fastermann <e.fastermann@proxmox.com>
Subject: Re: [PATCH] runstate: do not force prelaunch on reset during save-vm
Date: Tue, 13 Oct 2026 13:23:56 +0200
Message-ID: <20261013112356.152301-1-e.fastermann@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916101215.98436-1-e.fastermann@proxmox.com>
References: <20260916101215.98436-1-e.fastermann@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791890719802
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=e.fastermann@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

ping=0D
=0D
https://patchew.org/QEMU/20260916101215.98436-1-e.fastermann@proxmox.com/=0D
=0D


