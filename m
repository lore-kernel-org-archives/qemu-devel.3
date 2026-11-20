Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B360A2622
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FzMQWO1O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PE/keB0E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSCP-0004hL-I0; Fri, 20 Nov 2026 12:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBV-0003Yj-Fc
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBT-0003vk-8R
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:14:00 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKH0dE11882443
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AIwReEw76AJoywthnrMOk9P1NJhW8jJ6Vw67ozqqJdQ=; b=FzMQWO1OQw0pLMbj
 VMyQa8K8OKc6kvxeMtBEpOLwd507ZSYS8oJQIaz4mnhjEiVq4TrjT7f0AZFfx+J+
 bQCCwneOKZz9V8O27gCEDOAHdEasVTmf3Z/FcUUZB8+DPFROP/JfbgvTNMiYFDYx
 HyIRYVQpkb2pb33GrgOSLa8X9DZH6+4QYJh5Vy0++Mghqm1rTZEEQY3UhBrfsLYl
 Jw/Y3RWjyuHHssD6iPmWCFSKvxBjemOC1WKF6G5R01glviopTovor5OJ6oA7c2J+
 K2nl0RV6nbl0Cq386Z2RP1YMQVYxVmjpbyNk1zwZtVBU4hmk+W0sz/xJusy0EKlK
 8ooDsg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2t7vg1y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b206156cc6so715079137.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194837; x=1795799637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AIwReEw76AJoywthnrMOk9P1NJhW8jJ6Vw67ozqqJdQ=;
 b=PE/keB0EjxtWU4SSJLuoq93fal9rxQ8GsEiWMVZbzngs1+R2sfGY36UHzQeplRVXEB
 s6IuBp3T2MRKd2S3APQa3yEEnXcbqo2WWF0GKY52oCaZyEl5mb8vSz/6MHLnawuMyx5g
 yNrph65pNmWdkcIBtFqFvouA84smV0mLFKa+rizWTdrIunFLx1dCZUcW8ehMPrTuUE4d
 Qz4APVPT93RDuwWMgwMhG4vy2iQI+TWcVUUW2LuksT2NHMYp//M5SwGtom9WHVEW0lR9
 kPvSp4hlTxp3R6oxOZNAnl9KaFhb9Q94D8l+Ew7dAhLogye1iyt+Eij088NYrYn9Hi/n
 JSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194837; x=1795799637;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AIwReEw76AJoywthnrMOk9P1NJhW8jJ6Vw67ozqqJdQ=;
 b=JmCdcqCDYSsf8jGGwKfNjVOcpkx/E3+1SXtsrG+AUzuWVlwZkzu0ouuQ/8O7GBVf9Q
 5wdPaDwvAJ+59WNMoUTGYvUzHh6j5qn3D0i9nhTEiBaWrFCosTxzen7QhVdC97mo3bX1
 3rSS52oFejeZR1qbw2i4Ykq//4tt1fkJJNtQjSKh3NForSDAdL3PUO04276ISR+U1Fo9
 VuYp7q0DFY6GM/pHqTvaeOYmUZJjusEjKSRVvNQX9zKNG1cnkcpjrlkTNq2gq+PBRqXb
 D5F4EpEHu/jZuPoyHlQkMzjlGFYMSog8tDd3rYtt9tDP0IH1hjdkCq4ndytcVkGsLXdX
 cXKw==
X-Gm-Message-State: APuU4Z+zlWAtLxx427jDVazmmChoK8wfo6qN+rpQsz7Wu4PAaon0LOs6
 lsVvmzys/3HwxVVn2NSR9GP6vodMyozouob3pecF2fFqF/iqU0xtdWmiyxUZX4aCi3dOHvt0FoW
 22+ujU1scucSZQpr/vSQ4ajOzdhfI0rCLCCKzBbCPS3poI9RKYcGNyOYzhHNrBdpQrw==
X-Gm-Gg: AZFdTZdUOFGpr/pY/dGp/xRMLO21JNSVuKm16hUx04HNdyRMUnpe8VlW6rGwjwxZRPC
 U0wcrS0w35gnbF775jxbDuub7XNnJrHQu3Zf+aT+9THKF25RnkizTSYtfl25Wd4k47XZGC3imas
 8FtfVqZhm6e8JVLqCRfFS6Dwg/mShjboAyjGpt+mk6/A0YRULmwlpJkhmYz2MAiNuUkxOStkak4
 F1VLebXeZAWdRLAgT/Rn72XCoxGj2GrH0M3xUq1o24347YnxNZ12OJ1JF06iZ8FoE7BfUUuvSsp
 gw/yNkx1a3HmFtuo9/ZIR9sZKvJLwYnA3vv0viOy52Jvwjb1g7eR9zLfRSpxJuk7gQkYd1awCCT
 9jK5QndQUiDkUw2MhT7GUDJe/eaXQgcV7tJM1CVivqqPGdUvj8y63HwR08BgRPeaqAJqiV/izWG
 TzQzVmwQSQl0S0Fw==
X-Received: by 2002:a05:6102:b04:b0:7d6:6732:6ced with SMTP id
 ada2fe7eead31-7d739457b80mr2017778137.17.1795194837369; 
 Fri, 20 Nov 2026 09:13:57 -0800 (PST)
X-Received: by 2002:a05:6102:b04:b0:7d6:6732:6ced with SMTP id
 ada2fe7eead31-7d739457b80mr2017758137.17.1795194836832; 
 Fri, 20 Nov 2026 09:13:56 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm90547225e9.1.2026.11.20.09.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 11/14] hw/scsi/ncr53c710: Guard SCRIPTS
 reentrancy and cancel requests on soft reset
Date: Fri, 20 Nov 2026 18:12:31 +0100
Message-ID: <20261120171235.61325-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WYy9JhfFlql88CNNYNPSrc54lk2qGXHN
X-Authority-Analysis: v=2.4 cv=BZZNQbt2 c=1 sm=1 tr=0 ts=6b007fd5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=v_S-xQxp4mYtYP0rbdAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-ORIG-GUID: WYy9JhfFlql88CNNYNPSrc54lk2qGXHN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX/twhKo6IXnvJ
 ne6L+tunuvStI6zxzWNzzbZ4KyNk90bDxcKTkTzXI2B3yW8cXFbmnx5/aPhH7+3vW14Ud1m0rO6
 w5Tr5SJMAhFe2VScNHg1lDhbNr/hg28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX7SlooS8e3b2/
 VhG1yV66gYV5RuaK197jiRHFQ1b6vZfxES/KphtGvN+dXf/OCb1klfvtJ0dlrFaKJShhS6k0jPP
 8z4IkhwXSjZp3ItwMRtqwbfHb7d4qWF38HyECbb6g1/ZaqLT1PXYTGBt2mTsgVVPHDO7fjhs5sz
 8vulS/KLW8EUdrbQeag6VF+7JFBVQDE561dQRrCgHASBk5EyvKHRgKD4xW2xZqjU+AvCNcrEgvZ
 Ypu5Ywq6mYiNDajGYQISLl1xNzNQNZgjwJ/Wx9DetZbE/Ysu+AMp0hF8ihlZuflJme7SoUfoUYG
 Wf2/WCnCnr2eyzTIOSTrDWsZaD0LJrfxwKTdY44I1LXXfGhsnUGEURXItTBsN3U97DM59nykPO0
 D4J8JXwLdQSuddH27TPZUfmfHrHbm4Obm9EDzri6bW8WkmwEA/jGQ/5DO7oRkdx1DB/XmKeJ4+B
 3CGAQjTE/EsPTeyYyyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The interpreter guards the reentrancy class behind CVE-2023-0330: a
completion that fires synchronously while lsi_execute_script is already
on the stack no longer recurses, and a script that retriggers itself is
bounded by a recursion depth limit.

A guest ISTAT.RST soft reset cancels the connected and any queued
tagged requests, so a stale s->current cannot dangle into the next
command and queued requests are not leaked, mirroring the SCNTL1.RST
bus reset teardown.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.h |  5 +++++
 hw/scsi/ncr53c710.c | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 8b5cbfc135e3..9a4816794e1d 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -101,6 +101,11 @@ typedef struct NCR710State {
     bool sigp_pending_resume;
     /* A SCSI continue was deferred to lsi_issue_bh. */
     bool issue_pending;
+    /*
+     * SCRIPTS interpreter recursion depth; always 0 outside
+     * lsi_execute_script, so it is not migrated.
+     */
+    int reentrancy_level;
     lsi_request *current;
     /* Disconnected tagged commands awaiting reselection. */
     QTAILQ_HEAD(, lsi_request) queue;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index dfed2f2f9fdd..f75540da7720 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -103,8 +103,23 @@ static int lsi_id_from_bits(unsigned bits)
 
 void ncr710_soft_reset(NCR710State *s)
 {
+    lsi_request *p, *p_next;
+
     trace_ncr710_reset();
 
+    /*
+     * A guest ISTAT.RST soft reset can land with commands still in flight.
+     * Cancel them so no stale pointer survives the reset.
+     */
+    if (s->current && s->current->req) {
+        scsi_req_cancel(s->current->req);
+    }
+    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
+        if (p->req) {
+            scsi_req_cancel(p->req);
+        }
+    }
+
     s->carry = 0;
     s->msg_action = LSI_MSG_ACTION_COMMAND;
     s->msg_len = 0;
@@ -114,6 +129,11 @@ void ncr710_soft_reset(NCR710State *s)
     s->command_complete = 0;
     s->script_running = false;
     s->sigp_pending_resume = false;
+    /*
+     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset can run
+     * while lsi_execute_script frames are still on the stack; those frames
+     * decrement the counter as they unwind.
+     */
 
     s->scntl0 = 0xc0;       /* full arbitration */
     s->scntl1 = 0;
@@ -257,6 +277,16 @@ static int lsi_bad_phase(NCR710State *s, int new_phase)
 static void lsi_resume_script(NCR710State *s)
 {
     trace_ncr710_resume_script(s->waiting);
+    if (s->reentrancy_level > 0) {
+        /*
+         * A completion fired synchronously while the SCRIPTS interpreter is
+         * already on the stack.  Do not recurse: release the wait so the outer
+         * loop continues to the next instruction, which the completion has
+         * already armed.
+         */
+        s->waiting = LSI_NOWAIT;
+        return;
+    }
     if (s->waiting != LSI_DMA_SCRIPTS) {
         s->waiting = LSI_NOWAIT;
         lsi_execute_script(s);
@@ -857,13 +887,18 @@ static void lsi_execute_script(NCR710State *s)
         s->waiting = LSI_NOWAIT;
     }
 
+    s->reentrancy_level++;
     s->script_running = true;
 again:
-    /* Yield to the CPU after LSI_MAX_INSN instructions. */
-    if (++insn_processed > LSI_MAX_INSN) {
+    /*
+     * Yield to the CPU after LSI_MAX_INSN instructions, and guard against a
+     * script that retriggers itself (CVE-2023-0330).
+     */
+    if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
         trace_ncr710_script_yield(insn_processed);
         s->waiting = LSI_WAIT_SCRIPTS;
         lsi_scripts_timer_start(s);
+        s->reentrancy_level--;
         return;
     }
 
@@ -1209,6 +1244,8 @@ again:
             goto again;
         }
     }
+
+    s->reentrancy_level--;
 }
 
 static uint8_t lsi_reg_readb(NCR710State *s, int offset)
-- 
2.55.0


