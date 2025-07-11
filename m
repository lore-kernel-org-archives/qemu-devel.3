Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE49C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaE90-0005Xf-TS; Fri, 11 Jul 2025 09:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE3m-000314-7o
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:45:08 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaE3i-0000Fe-AF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:45:05 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 24a6eb66;
 Fri, 11 Jul 2025 16:44:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkimselector; bh=KTXVkzzIDiRwPLtOZ
 gWY4jQ7ajY=; b=trzivxd+LYazl0lLzin0xJGnjC57ygCQvpunVOuc11KWKlAUZ
 /2hsz/9VVSIfhVj0C84PYI0B4dHcLYRY6y1RHdg+g2JtBXoZTRpS86PTctBOacj8
 Y0v28dt4iAFm7/Ib4dqGaV/lAkYSvmU+cvTgtiB1BJNaOyFeab87bnRRbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkimselector; b=E8cTCRDIebc
 iM+lhYfS3Q1gNIQ1A/eaCDyI6/zKQjHiAtybxJKBElXBKXYoXdmy/yI8Gf04mlnt
 TTJhpcEcGn2BK8wYcn5QzF9qy1y+gun/wWt0zekKaGRzXxJ8mAwjeoyauKHqtJ8o
 ZggfE3A9ZbTZ/SppNoLzMJjA+75CS+5k=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id db8dc1ad
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 16:44:14 +0300 (EEST)
From: unisono@quyllur.org
To: alex.bennee@linaro.org
Cc: atar4qemu@gmail.com, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-devel@nongnu.org, Rot127 <unisono@quyllur.org>
Subject: [PATCH 0/3] Reformatted Sparc GDB XML patches.
Date: Fri, 11 Jul 2025 08:43:30 -0500
Message-ID: <20250711134333.56978-1-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <87h5zltojx.fsf@draig.linaro.org>
References: <87h5zltojx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Rot127 <unisono@quyllur.org>

Adds Sparc XML register files from GDB.

The xml files are copied from binutils-gdb.
The `*-core.xml` files are assembled from the sparc32-fpu.xml, sparc32-cp0.xml etc.
to match the registers defined by QEMU.

The addition is necessary if one wants to use the TCG plugins
with Sparc, because reading registers via the plugin API
just queries GDB.
The GDB stub initializes its register file with the `*-core.xml` files.
If they don't exist it returns no data.
Also relevant for debugging I assume.

Rot127 (3):
  Adds the GDB register XML files for Sparc64.
  Adds the GDB register XML files for Sparc32.
  Assign the GDB register XML files of Sparc64 to Sparc32plus.

 configs/targets/sparc-linux-user.mak       |  1 +
 configs/targets/sparc-softmmu.mak          |  1 +
 configs/targets/sparc32plus-linux-user.mak |  1 +
 configs/targets/sparc64-linux-user.mak     |  1 +
 configs/targets/sparc64-softmmu.mak        |  1 +
 gdb-xml/sparc32-core.xml                   | 84 ++++++++++++++++++
 gdb-xml/sparc64-core.xml                   | 99 ++++++++++++++++++++++
 target/sparc/cpu.c                         |  2 +
 8 files changed, 190 insertions(+)
 create mode 100644 gdb-xml/sparc32-core.xml
 create mode 100644 gdb-xml/sparc64-core.xml

-- 
2.50.0


