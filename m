Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A947C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGEH-0007w7-Ni; Fri, 11 Jul 2025 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3G-0003Y3-1K
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:42 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3D-0001pn-Fj
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:41 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id e2bc3d9b;
 Fri, 11 Jul 2025 18:52:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=dkimselector; bh=1lmWLLDL2cFAZYDiaB/Q+CEYR54=; b=yH6qMOow8Eqn
 3EbuBvqx2jYx5DU8xwLhQjtKi06OH/6q0dHa/wEpBOkg5vrpiw5MGKdNNfLMEf1o
 If3OIq9rbCnvsQybzKVzdYaesy5t+qE36QMayV9n6uAIloxIEa+E/rw8xTGJxNgc
 BKXMYiz2PBUbVMqfVF71rC0ZZxltjCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 q=dns; s=dkimselector; b=VaDGNW8zeOKp6T8w3B5JFeEfcgp1JlJGkPvcsO
 Npj+JnetyfkUQ5JGVywk8nqE26OAwpKKrOQcRSYslnSrxiGCPKRWsRaepmzsg5FX
 lfav9WeAyEoqQvwM+oms/sR15V/24E4ZtXXXqJgM+AJdwbkQ8CNU5uVvdi8SaqBw
 VsTGI=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id e0ae1a57
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 18:52:04 +0300 (EEST)
From: unisono@quyllur.org
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, atar4qemu@gmail.com, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org,
 Rot127 <unisono@quyllur.org>
Subject: [PATCH v2 0/3] Reformatted Sparc GDB XML patches.
Date: Fri, 11 Jul 2025 10:51:38 -0500
Message-ID: <20250711155141.62916-1-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2:

Fixup for https://lore.kernel.org/qemu-devel/4887cd10-6126-489f-9e68-85b3ecdf0b3d@quyllur.org/

It removes the unused `*-fpu-.xml` and `*-cp0-.xml` and splits up the patches for each target.

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


