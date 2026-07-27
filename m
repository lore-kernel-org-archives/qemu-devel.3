Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35101C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJpT-0004Kn-HC; Mon, 27 Jul 2026 07:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1woJpR-0004KN-UU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:49:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1woJpP-0003GO-Jr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1785152930; x=1785757730; i=laurent@vivier.eu;
 bh=izHEDe4KmGMuFXpzYv98ubGuADuZNf0ACapc9QPNRbI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eiFE3O4mtky6lkLizY9Ht737cDH0OkOxz5uS7Dd06rixFdE5USvNtPSqbqy9Zkz3
 EfuxdSgLFhnuHdzK56N2j17xogzjFIiqPfId0ojbbxlee4789ccHU0STzTa6owe+G
 /bdYB95Uvb2RlKfBeXdjvTrFBmich4L0bMt6hNm7vSRnKluJrX+zW8aJuSHnE8RNN
 1jUSZzalb5MXl6Z21Bq6zuVemv3cmSS1Jqn070x33TYuhsTbl0f9v0vBQVeFgNc69
 GKKDWK7TAqBxFkwXuvOeaBNSuHWRbp3TAPNLErC48ZZcYv4GHO0ePk0pwMd8yRty9
 5ZCrVwGkyx/00fnzCw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7iT4-1x15e42XhK-014plE; Mon, 27
 Jul 2026 13:48:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] linux-user/sh4: allow full 32-bit address space
Date: Mon, 27 Jul 2026 13:48:48 +0200
Message-ID: <20260727114848.1041856-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rV5WDqvLBIVEMZ7KKXcOsu+/zqXBNZcloi+rZ2PP5u8ijIRDuxU
 XlQ8McqUsFFBDt4FLCs51nufik1co6MUB+YqWjoPOYuwEweRaie6VlMesse6tpVhhAX/JIU
 oPmWLI5ZwI2p/z+sZY/ramhlZFSLQH+kik69eo0UNXWE6u6z6nUVobHyBqgtsMnjl/I2G/5
 y0ItunxR1NM0OV+GftYgg==
UI-OutboundReport: notjunk:1;M01:P0:1y2oHLmjbCM=;EPzwscCcN5BbMjdtKIyBNGzD/3a
 UUJokEqKXo85ACXAPt5Vo0098WwS0iPw/4eBIZkHbaqYskD26m4qe6hRCImyDf8sb/Srmjti1
 4fBxKVgc1wuJMCLQbsBW4T8m0u/zn8COJ3D6Kuomradyaw6OIFbzF0goWnIZn8JOROFoxdeXI
 OKpXtYL7uXlpov0m77GT7iXuYqRFcigDoN74lAW0aRj18nb82aKwbZYpBYjv9BsUa7ikDgG4F
 vmEsbT9G9RWj6dZ1T4VP5oacGh5C24S1KJTxHfzXy5b0og5B+fJ1ebeNGuVa+ewbUTrkNw6yU
 EICY7fllOjPiIoAIuBarorhxvOnRqzDT1qElJBjTOyYAAWJGMRQfSOF/weIg4r/JLqiRdUrXg
 Igv0rlGMUzFxbz3iX+Dm1k8OEvQoMYSr69wl4VwG914NZ3lsFdgml3ZhSn3C6GDmr5cIvI+5L
 T7buvOM6E74Q5X3TZYxGrkefo566i4VnjdsVkNiIX4cHLj17yqECiXpcofetg207whE1UQaAY
 DrZgzltyhvtDXK5oX+TDVPY0BXpoa1dQKZy7T8AGA9yCIesEt+DvmRliEVkJWiMVxD8BuYIJy
 EKA6AP+heYUUnVgtDenhbHun81JTLQCdc4T7wmChw7Um9udiw5Xw47yzhrto8xcLPFeQdEr6Y
 B2FXU9rQjGZk2BpvvFpcLc/5SIojxW7X4qpo9GnK3iKXhr3RAS2Gw9pEgdO9Z1iMz8j9dyEgt
 npUCXhVg16e667pptaeEhTzQTV8o2glTcuhsnfjkrca1+YwDqbnPxTshWCzkZ/yrZlgT5COAy
 dJ3fl/6gkBTqaVH1h+adpIPTG8uio2E98uSJqn3BkErMgsaic/LehyLJKUe2As0WiuOZkMZ6e
 pkxN4JPL21/belOj91K86ECRvnaupGOxO7n9YdyvQfCVeUdrX4aW0UiSwYoIDXbVybCfJaHmV
 fuR/YXE8SjB06lzgqyc+6ah3Mk4Qn5ivJvWYlvFokJM95/+UA4xiGMyKo5s0F1FL2mXuKRsMq
 01vGhjjmrHZdn1Ad3WQtIq5UraFZVflBTjjlLsbSU1/f093VB3KBeLAId0144vwzeTSwFy1yw
 ZCqbJIiHfv/V+NA8FNUzl5fB1+CIAkyNi6NF9oBntPgz2C7qifCQT15fEBHzZo2knYMVYxJKk
 iUk72ujmnNgq4H3i0ZHQbiEj5iVdQtXWGy0eEUxJ305Q4lMk9pwTU/aaVrsRzeGefi4+2S/cw
 UDcXkNv+4/nGJMvBPbJJybBia2CN89/5Y1f7LneLSVr4Y75AxA5texwyWQd1Oeyxl9TPeK3Kb
 z2wIbCGsI54VyhPPyhNlhcx1KGeSy1TCnoSIQusbZzobJqr/FCDlGUkwVuV32gF/syf5nUv/j
 Tl98fdVCF+f29Qqi0+NZN9hUekUrO2rh8B2xjfhEp5rzJblQWZojs/Ree7faLWYOt2ddaZoyI
 SFAUuz1IfPeGoZr9WMxHgM7QzStiLk7hply2Kos6hp3akIXuBym8p93UnbmyLUHWBYJQXGu+L
 bHV+cK5NmwPa0dDwVl2UuBDTJg+UC3FNQ9ARvSRZfzn6POIkIFUgI42lBcPFVhm3THgHHK6QJ
 5mHv+gdsbRBuxk1+bNvLjaZs0YIft20u/G1lgj1/nwCGx51RaWOaMepzPbULpJ7n7e/hrdiGQ
 a8LZK/xrc4nM9QqHQ+E7DbcRZ3Yt5ekgAE7duREwL7FCkFGtUjoFZ1HFtwORvyKiIeK12d46H
 LcFXQDzYo7I3LtVeoC15OYSYt71zkkUeZM359KXtJ/T7N1QH/llnpfhOUJffKUcSYcfSHo7Rd
 hSofp5cFEQg36os+pjensMNZi+Z43FjCbCrnaiDYURNKMwKsBUR72JG+8VDcoF3GsKe+j5jBg
 mQLLK2agYUrG8OOhWjl5RiDPK7RoXv8B9Uk3gDBCTNRlAiFfQfCt1x2L+MENimic+xBm9eAL3
 nDKgNu/b/k1cnuAh1MQcek5nX2Gq6rpuNp7SVd62jRr7ItqPPv
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On real SH4 hardware, the address space is split between user mode
(U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffffff)=
,
so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.

However, qemu-user does not emulate the MMU, so this limit is not needed.
The only effect is to restrict reserved_va to 2 GB, causing OOM failures
for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).

Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull instead
of 1u to avoid undefined behavior when shifting by 32.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 linux-user/sh4/target_mman.h | 2 +-
 target/sh4/cpu-param.h       | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
index dd9016081e9f..2d05837c2f36 100644
=2D-- a/linux-user/sh4/target_mman.h
+++ b/linux-user/sh4/target_mman.h
@@ -1,6 +1,6 @@
 /* arch/sh/include/asm/processor_32.h */
 #define TASK_UNMAPPED_BASE \
-    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
+    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
=20
 /* arch/sh/include/asm/elf.h */
 #define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index c3b8114e538b..d95827078260 100644
=2D-- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -9,10 +9,6 @@
 #define SH4_CPU_PARAM_H
=20
 #define TARGET_PAGE_BITS 12  /* 4k */
-#ifdef CONFIG_USER_ONLY
-# define TARGET_VIRT_ADDR_SPACE_BITS 31
-#else
-# define TARGET_VIRT_ADDR_SPACE_BITS 32
-#endif
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
=20
 #endif
=2D-=20
2.54.0


