Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D17606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=cYJAo6CL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKxy7-0003rz-4S; Sun, 25 Oct 2026 09:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nkwilson@sina.com>) id 1xKuN1-0005rv-96
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:18:27 -0400
Received: from mail3-167.sinamail.sina.com.cn ([202.108.3.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nkwilson@sina.com>) id 1xKuMt-0005ZD-SX
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1792919900; bh=gRCnd6f02UZM3mj5t8+UzEIcmQUhSyij0WIUsbZlGeI=;
 h=From:Subject:Date:Message-ID;
 b=cYJAo6CLxnBcX00AWUuccMoFl6YmSdkGJUoT2R+Wjyi5GqZGg6lTPLEeJhWrfJf29
 ONYX3YhTkXIFVAdjPqQGO2BDgXfdMXSwa/mrR0GoYlljNfVs3t+KL0km76ymAY1sHn
 +JVXe3p72Bq8u0wV2dwTOQG//IkUnzS5rUsZEBck=
X-SMAIL-HELO: 192.168.1.19
Received: from unknown (HELO 192.168.1.19)([123.118.215.42])
 by sina.com (10.54.253.33) with ESMTP
 id 6ADDC80200001CC6; Sun, 25 Oct 2026 17:12:36 +0800 (CST)
X-Sender: nkwilson@sina.com
X-Auth-ID: nkwilson@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=nkwilson@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=nkwilson@sina.com
X-SMAIL-MID: 8494676685234
X-SMAIL-UIID: 7B07B2DA70B54E828547AD799F36515E-20261025-171236-1
From: Yu Bin <nkwilson@sina.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, pbonzini@redhat.com, yubin1@chinatelecom.cn,
 Yu Bin <nkwilson@sina.com>
Subject: [PATCH 0/1] microvm: fix guest boot with exactly -m 2048M (ACPI
 enabled)
Date: Sun, 25 Oct 2026 17:12:33 +0800
Message-ID: <20261025091234.81072-1-nkwilson@sina.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.108.3.167; envelope-from=nkwilson@sina.com;
 helo=mail3-167.sinamail.sina.com.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 09:08:49 -0400
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

microvm fails to boot a Linux guest when given exactly -m 2048M with
ACPI enabled (the default): the kernel decompressor either hangs in an
infinite relocation loop under KASLR, or (with nokaslr) the boot
proceeds but ACPI core init deadlocks and poweroff via \_S5 silently
stops working.

Root cause: microvm places its ACPI tables (RSDP et al.) in the top
4 KiB page of low RAM, and passes acpi_data_size=0 to x86_load_linux().
In roms/linuxboot/x86-common.c the initrd top is clamped to
initrd_addr_max = 0x7fffffff only when below_4g_mem_size - acpi_data_size
exceeds it; with exactly 2 GiB of low RAM (below_4g == 0x80000000) and
acpi_data_size == 0 the clamp does not engage, and the initrd is placed
ending at 0x7fffffff -- right on top of the 4 KiB ACPI/RSDP page,
corrupting it before the kernel ever runs.

The bug is old: acpi_data_size=0 for microvm dates back to the machine
introduction (0ebf007dda, 2019, when microvm had no ACPI). When Gerd
Hoffmann added ACPI support to microvm (8045df14bc, 2020, QEMU 5.2),
the zero reservation was not revisited. It is still present verbatim in
v11.0.3 (hw/i386/microvm.c:333 in that tag).

Minimal reproducer (any recent QEMU, any Linux bzImage+initramfs):

  qemu-system-x86_64 -M microvm -accel kvm -m 2048M \
      -kernel bzImage -initrd initramfs.cpio.gz \
      -append "console=ttyS0" -nographic

The attached patch fixes this by moving the existing PC_FW_DATA
reservation constant (160 KiB, already used by the pc machine) into
include/hw/i386/x86.h and passing it as acpi_data_size from microvm, so
the initrd is always placed below the firmware/ACPI area.

Verification (patched build, guest kernel with KASLR enabled; each cell
= boot to userspace + ACPI poweroff):

  accel | 128M | 2047M | 2048M | 2049M
  ------+------+-------+-------+------
  KVM   | PASS | PASS  | PASS* | PASS
  TCG   | PASS | PASS  | PASS* | PASS

  * previously broken; TCG inclusion proves this is accelerator-
    independent. 8/8 cells pass with the patch.

scripts/checkpatch.pl is clean on the patch.

Yu Bin (1):
  hw/i386/microvm: reserve firmware area when loading kernel with ACPI

 hw/i386/microvm.c     |  2 +-
 hw/i386/pc.c          | 10 ----------
 include/hw/i386/x86.h | 10 ++++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.54.0 (Apple Git-157)

