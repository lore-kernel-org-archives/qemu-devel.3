Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484D606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chrisnc.net header.i=@chrisnc.net header.a=rsa-sha256 header.s=sig1 header.b=WUuLgjRf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQE7e-0000ea-5E; Sun, 08 Nov 2026 20:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@chrisnc.net>) id 1xQCpa-00019G-79
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:01:51 -0500
Received: from mr-2003b-snip6-10.eps.apple.com ([2a01:b747:3000:202::14]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@chrisnc.net>) id 1xQCpU-0002j7-GV
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:01:45 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 172FE1800630; Mon, 09 Nov 2026 00:01:35 +0000 (UTC)
X-ICL-RepId: 01a1bd9c-3ebd-7df5-a1e4-cc875c50616e
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBBHVsZXwdeC0gGTVIPDxNRCloedwhaAlALXQ4ZBVcEGR5XUFQDQBlKFlBDWQ5GUEsbDlkXA1ccVkVcGEMJXQVXHB0ARUVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BUA0AZShZQQ1kORlBUEVdQC1kCQg9JAl0PRlMCVA4LQFITURVJDFoCWUZAFU0NQQMaCF4CXAAeGwZGA11cGwJcB1wLEl9OClh3CFoCUAtdDhkFVwQHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chrisnc.net; s=sig1;
 t=1794182498; x=1825718498; bh=PGEl1UCLj9SuICTUP6NIDGZQmdiKHu0OZLX35UyJnM0=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
 b=WUuLgjRfz5vzysZ4Ab7oKU5OXlHbIvE6+o10iEzGlPdCl6CgmhmY8qLQEcRE/PAQVYerXjD9RqZcXu4IQMAlFz/pDzJQ+WzPtIHvMq5GnN/vD0CW/zeMjGkn8+h7QjypX1M8OmYinu61MmJhMquEGDTl0z/C3Eel/dr5HX7bU+ylaoRfCpbu641mqzvKFZ+0qcb4TrF4tN2UhMcITe0y+68lG3qhMz4E/Zc/sMRDREpe3Zn9wVZE1XLK9Y+J+/ndV4WqBBnVfVnJ48FAeKcI29TjQ13QJLZxhQUHVBQxcnTdspN2vTdxYHE86Gu7sntCBc/B+I9Mz8BMSih7L6oZ7g==
mail-alias-created-date: 1633366900000
Received: from nereus.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 04C74180027C; Mon, 09 Nov 2026 00:01:35 +0000 (UTC)
From: Chris Copeland <chris@chrisnc.net>
Date: Sun, 08 Nov 2026 16:01:15 -0800
Subject: [PATCH] target/arm: Clear the local monitor on AArch32 (v8)
 exception returns
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261108-armv8-exception-return-clrex-v1-1-ec11079bf695@chrisnc.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCMBBG4auUWTvQtGCDVxEXcfqnRjSWSVoCp
 Xc32uUHj7dRggYkujQbKdaQwidWmFND8nBxAoexmrq2OxvTWnb6Xi2jCOZcW1bkRSPLS1HYixf
 XD6MZekt1MSt8KP/99XY4LfcnJP+etO9ftF3HLIAAAAA=
X-Change-ID: 20261108-armv8-exception-return-clrex-fcfca37d1738
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Chris Copeland <chris@chrisnc.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=chris@chrisnc.net;
 h=from:subject:message-id; bh=qgBTTxKieHx6NEKhzuaasmJVYm1QMl0ujxmoZOBc1Fg=;
 b=owGbwMvMwCUmEsq7XKX1vgHjabUkhqyPvHG/oudvqCvzuROwR0Txk+PknMUTmCNTnlc7G/2Zw
 ai6a9PnjoksDGJcDJZiiiwhYvump9bono80UX8CM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6BgzcHEKwFQ/jmb4w60SNPPv1Qtv0tbdjuBgz4tWmMj/8+1xdb9v5df7qlXlXjMyfExbc05
 nvqP0DqudB6fJNInyxfxWecG3VS/+//HW2VOTOAA=
X-Developer-Key: i=chris@chrisnc.net; a=openpgp;
 fpr=5416BE97657C2DCF593427E414550DA72485DF30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA5NSBTYWx0ZWRfXxvJOx2+wUfdH
 ZgCVSCswVedMnPYBXUFAu2NQ0c6hhVOind/Xb5wB6QFuK+nIeDifc8wpPdEf56ljMZryk7ogtXP
 R+aa93848oMFM6KX7fgEpW6VI9Sas9YG5NjO2I9IVUsfGT8velk8Ajb3o8uMt1hMbUcxmJ+tL2e
 IXlFUOETRTTLIqkv0x+Ln/3jaDeD5N7vxQ6cZJnDr3IY1CtywU2zCuSDjtv/blGZ5ZFHwknXTZI
 j+SMcLNkvxKS5GAkZybukj9mhCk6EPBCuABnfzJ30SIXh1OVQxp6toH+JyNX/i8wgSVnl0nsiMo
 UgfgTPu7jLzC/IIacSyT60kTmdD6eTiwiSPP+kw7vI5tqbsTBvjc8OuhHYpUMQ=
X-Authority-Info-Out: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=6af10d60
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EJHnG6ylAAAA:8 a=XPmtPy-9wwEGAlcFYbYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3Es6Gil5AuxR-dLjfNE0:22
X-Proofpoint-GUID: 0jnsHEmQD1ynXf-GOCUnySfFqFw3IzPt
X-Proofpoint-ORIG-GUID: 0jnsHEmQD1ynXf-GOCUnySfFqFw3IzPt
X-JNJ: AAAAAAABTGlgcjDyd590XxU8X8xIkmWHo6fhnL3pDW8gbCx9TDUUE6RDu7LHfQ7kizphz9
 gaT1dMk6qPoOBJ39+q8oT1iUsnEefx5WzCKFlHBjA/HTT7o2+RnxobuR92FR+tY9d4vL1f
 9zM3RHkAlIl+65FdTAMi4bHUnwSzo9QiSlQ6f3Be/k4+CreGD2536pIfKfBgJWVCifRQzO
 /KXaQmz2bWv+CAUraTPBEu2aXGhKaADCrQ4eufiZI2FSpcVv9TAikVA5/XuZ1QneecMSk/
 FUV8x63c5NMnTjzbmPuUBI4Manrmy7Ce7vYoLAnVjIoDaqfVRuDWgieKOeoxxxJm4ft4fF
 /ZceCxt9IYfhm0SEainFum9WWP6v2JC8S4srnmKiYtb2Sukkto0Qhj2W0z1Gzs2w13f6gW
 R5gNSvDQ8BM8nKboUJRPkjxAlZNaR6Qe+4UJZ4wF9tbJEyfm2/Nh38F7HWV7JqKvEmPIME
 RwF0Q/GUQvW6EZy3zzjrmqqJvSilsXCV/wVE29Boan76toArpPDUHEnPH1EZiEYG1kr2ae
 tRgdI5ROJOht0mbj7zdy8GhJx9Dq57gxL152FCyj+2Rt8XZF3zNFO7OtiLMcv/2DyAm/qZ
 NQ2y7wNfQ5y06S3YVrlWa2ADIHW6bYCmXWENU2ks9n1NIjCnLZwNKWaLIHyETVJBJVNZwc
 m6j4sXEu0QPJ6tynM6x1sSIO4oALzrn546zoxQUBMnGMvbCH2lpUM7vTwmIs1qRkT2ZNXE
 WcasmgeOq4I6aEeXvDaZAMiY/V0f+11kUhXXLspSbzfD7uTCP6QkrcUQnAwGbXZr6CHGuD
 zp5VmZ8gy2EArcGRuonqmMAT5gdiMWlcCR+tul3hWnJ/EaiR/MQV6M8FYzy2Fw7H5ar9JB
 NIzhV+4UoCvB/fJgOLJijzvUkV7aogP4Q3tGmkJRbqClW/CV5EhDSTR+7PG8Jvylx+YZr1
 DOzBW4j2YMV+JxJ6fX5OGG0f3/rzHPs+M+0vBTxNUU5JXhU9AZLrtgyfdpPIsu9VF2CIbM
 2r8F+k7UuPedKVZt49pnHVbq7lwBQDmsWrVL9+bQaQC/t4Rcl090V2OVX3nOlrrE3Jw9Tw
 LOw8d/aMLysXMKLC+vsRLfbz9HKLBsKtGbJ1R6haSiaLWGNrGBt4RaSPJX7H6mPf12Gk0l
 htbOT1GZdZdOzsIc6jFxY6dZJzuE280hmwsFvvc5jvT0Jz8Nx5ptSYdN6fKPAwyByhc7ky
 FnMHzRDrmYLYDKJM1ZXIpZLuo2D/45oDK9Evft18Ee/Mnmhqt53rEw==
Received-SPF: pass client-ip=2a01:b747:3000:202::14;
 envelope-from=chris@chrisnc.net; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Nov 2026 20:24:32 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A/R-profile exception returns prior to Armv8 do not clear the local
exclusive monitor, but in Armv8-A/R it is cleared.

From the Arm Architecture Reference Manual for A-profile architecture
(DDI0487 M.d) §E2.10.4 "Context switch support":

    "An exception return clears the local monitor."

The same language appears in the R-profile manual (DDI111353 A.a)
§B2.11.4 "Context switch support".

Signed-off-by: Chris Copeland <chris@chrisnc.net>
---
 target/arm/tcg/op_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4a31ce979c..22f47f7450 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -803,6 +803,10 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
     mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
     cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        arm_clear_exclusive(env);
+    }
+
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
      * masking depends on whether we're returning to Thumb or ARM

---
base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
change-id: 20261108-armv8-exception-return-clrex-fcfca37d1738


