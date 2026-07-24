Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4377EC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnJY9-000546-89; Fri, 24 Jul 2026 13:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnJXw-00052T-La
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnJXu-0002Pn-QC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 13:18:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OGqub43155659
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DQS8WzblA3iahVsGoy7ORj
 KlakH+2XLkHVKTh/iD7kQ=; b=i9MdtfzHrB4PpkC34CYCxAa4uhZFKyNt4KFT5k
 8PWVe3ieR45USqDk4PZA4cVe6qhlEM+GP9SAglqfKWdBUAUW+2rR7pZKm1OTLfGl
 EwZ4Qxt4PY1eeMbhObnCerXDeUjVywYzFGNz2eWa86HLtbpeS7ZFcOE3bGvPovMl
 vKk1lunD0+zeoDQ10c4gGgHWa87+wGcxyj8ABfm616cmbVm2yfmkUw9rUugI209m
 08bB36X60lBiu2mV6ZN21zLg49POVUCLdTuz1HuNUp3Ad0IAM66uB2dMEb1dRPwd
 ZaS67b21o9JUmkOVTSOpYQOcj4Kcb0/8qf7VJ42cK8YX0cWg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cgh013-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:18:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so751577a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784913528; x=1785518328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DQS8WzblA3iahVsGoy7ORjKlakH+2XLkHVKTh/iD7kQ=;
 b=LwamU4cvbnfGu4b/cUfzbKfw+ew1jhgjHQn/subOZI2j4ys6tjrH7DFFy3OpZSH5Pd
 4yyaopXURfTzeir1zJKLCCuYXd0pJhvecyszB/Z+wvb9hy8HXB49nDY75KiiLk2JjYQA
 Ow0h/XPyegg6EogsHGN/2yO1B/rTFAU6PvLoWT3QRxHkyEKAyYLqbmLBIV2oyQC+lU3W
 9Lmav0Pq5VdESwXYB2YbxowaFLTqpP1xDZLIfo6tnPq0RwbKWFKKIpTwkhZJoHwGVUjn
 oJ4FQ5Tg5TTGe5HO+PG63RTcC8OyltVJf0Rl+ZAW3Z3oxqwPrrXc5NmNN0ohH6jdZzdc
 eoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784913528; x=1785518328;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DQS8WzblA3iahVsGoy7ORjKlakH+2XLkHVKTh/iD7kQ=;
 b=TxmIXaYQJ21Q8PRUWQavF3EB4m/8I3q+2Jq91yJJLwKqk7igP9ue99t9cVq5t7ibd2
 dO8CI+du42JP03L9FHMye/pFKz/ykob1JpG5vBdsDZVUbV5Yyq46AqGWUlsssk6JOcib
 U7RZP2sSP3o3gr5m5yb5CrMPgAG1HZrNkP1S5/xhQYPcnfu9fvUuHXezPANB74be3G0U
 bBEJp7UgfqCz5NfrUcdH2Thsf7rUI6HbmchhFq3V68nGkPCKZJlAYNFflP9biz/ObZf9
 JNb5vCvr96+RO/UTagaUsEf3Iucv5RM9DdeO80RaeqNlS+vWA38vRrGWXTdJPfl4OC4l
 dP7g==
X-Gm-Message-State: AOJu0YxfjowYvsdid/tX2KdIL5cUETwqYbS1OncoZvNP3kcDi8udRvUK
 rfYhQmvOgBVx8px8qs4XIb40DvrqcJ/AcxTP3R3aP0EX8eYx6HP3ueiz8svxISB2y/4rUk8MTlM
 IcteBtj9RIIjVc1HMLeiuJEfABiLtut33tO5AaMdcbumYfqNjrsc8P8aO6VSVGV4WNw==
X-Gm-Gg: AR+sD10RbS4eiQDGkBTAEOMqb8ebuFJlPWcbjnjfywk+bTk7/U5QmAABPyRP39lq8aQ
 FZgs7qpbriynafmXlPBztRLF6fs2LX+27utNYCpAaP1g8DNcDJVgQVUfuFGZEzUWf1SdXML3t0f
 Qx0tgzsymqbOqh7RMN+9K2sAZ8oURyVhBTBCywmH93wsBmxfCt4lzol8RDaCmFT53nFp0QDbNrz
 uBTCe9OTRzcF0iZr1PcTDzK6o22uFDLTQ1Q4RaOEtAk+DVSjsoEISTnEuvno/FHoYgU/VJMiAyz
 7NHXdf+lfBtNbQU+eVc8mRPNjBaSQrFUWCGSzICQGXr/G3DR+mVXgufdf6batSJ2koG/BnY3FRA
 Cs/ffFmd2TelAmy8+98AGvzw5J4WMhHiUPnzj0fMH58CwhOU5
X-Received: by 2002:a17:90b:3b83:b0:38e:5e2:6dce with SMTP id
 98e67ed59e1d1-38ec660b1f0mr7416375a91.39.1784913527707; 
 Fri, 24 Jul 2026 10:18:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3b83:b0:38e:5e2:6dce with SMTP id
 98e67ed59e1d1-38ec660b1f0mr7416351a91.39.1784913527223; 
 Fri, 24 Jul 2026 10:18:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130158c0sm27816798c88.6.2026.07.24.10.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:18:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon: accept valid packets rejected by check
Date: Fri, 24 Jul 2026 10:18:44 -0700
Message-Id: <20260724171845.78440-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JOMLdcKb c=1 sm=1 tr=0 ts=6a639e78 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JZW4H54UH3-1LPv_A1UA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ju0j-7XPRQWFC6iruLLbR2tQfGoVxfH0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfXwd8gofbbF15O
 3dmMkbzvN9PSTslHBeva4VmDraLpSfz5hyrBzZji+uLO8m2HrjeOWowkXiAIWtGrMxtwhRfWrJF
 AjeXRFLLGUpm/S66QiQUtL4fLFxtx6U=
X-Proofpoint-GUID: ju0j-7XPRQWFC6iruLLbR2tQfGoVxfH0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX1+tvxlzwe+6R
 fdQcC1QYbopAfF0B3yNbv3uM5yLwBzQc+jv2Y56N8hh5r11Ub0Xb2hZ090n4LoIGtKw4+hVvSKX
 zgkkNE6UIhkTPPwPw+e7Z7cIgD6tIFcq7Mx47VBnsXZFKCg6pmL49LUVbtrNpRBnW3D1Dun90Ml
 XNlDuwWXJw0bwHXQl+cbtVnRW9t8TWjSAIO7MK1XdVCXN7G0nPvg047i5pF9U3mewp9dm8ou2SZ
 qzMENBsWw+carIFGx9LQCuCcfVNCYu7Od3yCgjpKCRihZ0qaEUjH+L/qzUVGf1e8jLwbeT7qf18
 Y8DtjQIjub+vGtF/kiPBkkOI0o56dNj8QQU8w71MHoPrfcvSqfVLgIp0kDF5oUxOyPb/IRG1rS1
 fx2Kty8G/WHdKj5jldWFHaZjLw/4kCR4YbT9BGF8+wdFxZDR7FUx+DvHE5Mut1AkndQF5tbkOxC
 tz0cx4o6bhFD1nyS/Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240155
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

has_valid_slot_assignment() rejected any packet with two instructions
assigned to the same slot.  That is too strict.  When a memory
instruction is encoded before a slot-flexible instruction in a packet,
the descending slot assignment places the memory op in slot 1 and the
other in slot 0, then the "mem insns to slot 0" fixup moves the memory
op to slot 0 as well, leaving both in slot 0.  Such a packet is valid
and executes correctly, but the uniqueness test flagged it as
HEX_CAUSE_INVALID_PACKET, raising SIGILL in linux-user and a precise
exception in system mode.

For example this packet, with the load encoded first, was wrongly
rejected:

    { r6 = memw(r3+#-4)
      r7 = #0x4ae6 }

Replace the uniqueness test with a slot-exhaustion check: walk the
instructions in encoding order handing out slots in strictly decreasing
order and fail only if an instruction has no valid slot at or below the
running slot.  This accepts packets that legally share a slot while
still rejecting genuinely unassignable packets, such as a memory
instruction grouped with a duplex, or a load followed by an instruction
that requires a high slot.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/decode.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 6eddcca26ed..e6bb7733be8 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -549,21 +549,35 @@ static bool decode_parsebits_is_loopend(uint32_t encoding32)
     return bits == 0x2;
 }
 
+/*
+ * Check that the packet's instructions can be grouped into slots: walk them
+ * in encoding order handing out slots in strictly decreasing order, and fail
+ * if an instruction has no valid slot at or below the running slot.  Two
+ * instructions may legally share a slot, so this does not require unique
+ * slots, only that every instruction fits.
+ */
 static bool has_valid_slot_assignment(Packet *pkt)
 {
-    int used_slots = 0;
-    for (int i = 0; i < pkt->num_insns; i++) {
-        int slot_mask;
-        Insn *insn = &pkt->insn[i];
-        if (decode_opcode_ends_loop(insn->opcode)) {
+    int i;
+    int slot = 3;
+
+    for (i = 0; i < pkt->num_insns; i++) {
+        SlotMask valid_slots;
+        if (decode_opcode_ends_loop(pkt->insn[i].opcode)) {
             /* We overload slot 0 for endloop. */
             continue;
         }
-        slot_mask = 1 << insn->slot;
-        if (used_slots & slot_mask) {
+        if (slot < 0) {
             return false;
         }
-        used_slots |= slot_mask;
+        valid_slots = get_valid_slots(pkt, i);
+        while (!(valid_slots & (1 << slot))) {
+            if (slot <= 0) {
+                return false;
+            }
+            slot--;
+        }
+        slot--;
     }
     return true;
 }
-- 
2.34.1


