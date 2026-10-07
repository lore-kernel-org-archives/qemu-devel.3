Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B065CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKy-0007A2-SL; Wed, 07 Oct 2026 05:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODw-0007kH-1c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODt-0000SN-KF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jdBm3194040
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ueXWUbxF3G7y8AhFxn+zjz/xBkfKZW8/gUyX4qZTszo=; b=idYJETd4mqHU7P9W
 WtkkeYQvuHAnxbNoFKo2Ull1MErCedHebqMKPXCFEE8cbvZUpIMjruJtcwASf+ye
 268ba+e1fFNgiips+edW6vqP367XMwbL/DRAO/uNNpU9oyrlZ+vAn8sUhuopsoLK
 jjwCWqVJ67OXHKmbEuViNA3zDYNwgPTKU38Bi2guUGGaToV/mCsJ2jI4w7Fqiy23
 O7U5YG913LIAzgD+bUK7+InKoRtVbMG2nxrkGSSjH1BjZMmcarxbsKCFVNx2QQJ9
 bE6SRK2eR2UfgtnkJueBrP5dFUm0IgECVPpZIcrd4VktyOJvHmNW8f6TZ8ZDgOLA
 30ptAw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h541ukpj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e834ff4d0so570231085a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366363; x=1791971163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ueXWUbxF3G7y8AhFxn+zjz/xBkfKZW8/gUyX4qZTszo=;
 b=WTFjxxRyuORRMcCb1sdLDX4OtK/dWO7SrYiFgx7OmbjSnwfS8mes8x9WMQLXcJV1d7
 7II2V3TSrDS0We/CroOJBluzMQDKZBjKTvrqo3xL/HJT/7Ej+VrTUZYM5k3E1oDoAgdb
 hdEveJZRA88ibYqhQpsEYjxKecMYSbYQNgtnW1+QcNTMt4QF/SgELO9R+ZxS7A7RDMLD
 +z1tPGdzI+ifzN09aid2TcKo+6F71bqLs8IcttJnG9UcpaP90QB+LB8LQY5mJcaLfY0j
 j2VmSxk5KZu+sWYuVVnJ6BiuE1QPM2SDpS+1Sutgl+uOCdSQ/+PWVNpilQNZd/y1NaIr
 RDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366363; x=1791971163;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ueXWUbxF3G7y8AhFxn+zjz/xBkfKZW8/gUyX4qZTszo=;
 b=gn9eSstTdIxDplVHfPYyErGTdJGU2zqYUkHfjnauPX6zNXI7e4g7S6CAeaHAsYcVBN
 e2ouzlbCDlKjCU3KX7/xXV/3zaWvtSyfjLo/WPWfS/4pdS8/BGCjSzltP2DvoXvWJeGe
 YNR7m4dnBABhx52W6ZC65qfn9oym3QbiDPlSNxxhiSuObKTOqhlJWanfR+Z1y0/+8Sbn
 gRXd8Iz7MUvN9mK1kGBVskNGz/rFWD5J7URmPbkTRJczg6PYe9IsmQ5qoP9ttDV1WBfC
 lYeBtu+BCo4ELErXcm13yus0lZBZ8vaEFsm62U2Pcasgv2XgTqr/z5JF0JY8l0pBUhqr
 OkFA==
X-Gm-Message-State: AFuF++npHII59uyd1Fq1U1k0jNRPykssRUFmz3O6gmJ4xaya4OiRxPFa
 x3JibtnkPKdSFu72cs77pwmTChUZSE/b6BVYDT1V6XPwIpeszR4zRIuqaLlBJpD6kzTytY9rKiI
 Usm/c7k8a7ZfUN7vxCPXMykDcst/Yk+Xphtrj7Iy/tvaki8lpLha6KqLOd2YTVe6CkEf8
X-Gm-Gg: AYBFou1SCl6nY3dUv3OvMd6ZmV8o2KL8cGzZkUkdodAkD6hec6QnHKBD9xGvTI59EUh
 zwUeMPhkuIjqgnh65ZuPAO/Kynk4pAtX7RqMHn4zuG244PNTcboJccddJKpj4bFRfUqS3aMxrgs
 Ff3dg6M52sH+g4RjIv6K09CSLfAtJoUY2+0OFKddM8QPGgOVAMLaG2KhZDUzlzg+l1jbkF44Q/m
 b+zuqNkyNXzpMRpCNMzjhwD99SLYT03zDzNHrbe1om54tC6NkozwsYXFl8jspHHx9Y2Wd9XQT+Z
 G/ZcYHTHyvGQn7m6PUBi0TX5iwKj/+VXKGVPgUHpMhn2X55DGC0L9anqRLjTaagMIdNstFuo2oz
 d5QBaT1z8ZoNPoJK4p+oC4RLhXajrX8X/5gnN2wGB
X-Received: by 2002:a05:620a:45aa:b0:93e:4c1e:cbbd with SMTP id
 af79cd13be357-93e9b7e0836mr311573285a.53.1791366362887; 
 Wed, 07 Oct 2026 02:46:02 -0700 (PDT)
X-Received: by 2002:a05:620a:45aa:b0:93e:4c1e:cbbd with SMTP id
 af79cd13be357-93e9b7e0836mr311569285a.53.1791366362394; 
 Wed, 07 Oct 2026 02:46:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1245bsm4331607f8f.26.2026.10.07.02.46.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/27] target/hexagon: Register CPUClass::exception_name()
 handler
Date: Wed,  7 Oct 2026 11:44:54 +0200
Message-ID: <20261007094516.75732-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: soz5xGNBzqpZI9fMOMKl_4pAP5-2BTNo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXy4fZUxFukVVX
 U7XIyA9ZpCyxeJJPRyrAYCvBFK443OVpt6STcyD5mx1yF9guGnNb7q9F+yiU0ioQ0jmvOsQHFik
 FQ6l44kw944m6hwJFARadthhuFHxhrg=
X-Authority-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6ac614db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gOtg6PG78Z4vFrgGvpEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX9lzmkHNSh/dY
 tCg1XEtxp+9ano0CLEwb0NNLZ/E/48nyM0pIgnbb3+qzaDdjNqy0/yrqNoRf5RkYTtnN+1IlZ/+
 9taW6TlQ9mJZ7B0gEys87lgpedTbwEi3u7XMowgL0BfO1hGhEfhbT0dN6Y0HgSa1euJnpNquULz
 DAMKQXu25JkpZqwEXQUW3kiMLb2hMj6FNtEg8FQ7aVkXxsz/bn4qJ9WdF0otx9Fen8XBS3J/nkR
 iw6u1HQgezKBdN+OKf02cJWoL6037+ajWeLx5Sb+pV0D07d+rU5/3eN/sFbQ/zXd46/QjQfSn2f
 N8kJCClvixz1w/LnM9HLLik9X/eHlYrIRIQ1nLnb49FNPVwoKjzs/rr4sYUl3h2wWQQAGXeM9OV
 H2yhz5DP2J7LznKJoxvNS0erWT7UD3YfOpw4sHOBUxjBBElktLnmUmdatSZVCQhqokHaIXHxV2l
 eHyFZLstvmKvSoLB22Q==
X-Proofpoint-ORIG-GUID: soz5xGNBzqpZI9fMOMKl_4pAP5-2BTNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Expose the hexagon event_name[] array via a hexagon_event_name()
helper and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve Hexagon exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hexagon/cpu_bits.h |  2 ++
 target/hexagon/cpu.c      | 37 +++++++++++++++++++++++++++++++++++++
 target/hexagon/hexswi.c   | 30 +-----------------------------
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index a8fba4aa188..7d1bdfcbc71 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -61,6 +61,8 @@ enum hex_event {
     HEX_EVENT_INTF = 0x1f,
 };
 
+const char *hexagon_event_name(int event);
+
 enum hex_cause {
     HEX_CAUSE_NONE = -1,
     HEX_CAUSE_RESET = 0x000,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1f7d8a8df70..be286b1f2ee 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -318,6 +318,42 @@ void hexagon_debug(CPUHexagonState *env)
     hexagon_dump(env, stdout, CPU_DUMP_FPU);
 }
 
+const char *hexagon_event_name(int event)
+{
+    static const char *event_name[] = {
+        [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
+        [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
+        [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
+        [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
+        [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
+        [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
+        [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
+        [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
+        [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
+        [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
+        [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
+        [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
+        [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
+        [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
+        [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
+        [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
+        [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
+        [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
+        [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
+        [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
+        [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
+        [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
+        [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
+        [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
+        [HEX_EVENT_INTF] = "HEX_EVENT_INTF",
+    };
+
+    if (event < 0 || event >= ARRAY_SIZE(event_name) || !event_name[event]) {
+        return "unknown";
+    }
+    return event_name[event];
+}
+
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->gpr[HEX_REG_PC] = value;
@@ -826,6 +862,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->exception_name = hexagon_event_name;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 4705e915aea..be366d7a373 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -729,34 +729,6 @@ static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
     env->gpr[HEX_REG_PC] = evb | (exception_index << 2);
 }
 
-static const char *event_name[] = {
-    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
-    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
-    [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
-    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
-    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
-    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
-    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
-    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
-    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
-    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
-    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
-    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
-    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
-    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
-    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
-    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
-    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
-    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
-    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
-    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
-    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
-    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
-    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
-    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
-    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
-};
-
 void hexagon_cpu_do_interrupt(CPUState *cs)
 
 {
@@ -769,7 +741,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT,
                   "\t%s: event 0x%02x:%s, cause 0x%" PRIx32 "(%" PRIu32 ")\n",
                   __func__, (unsigned)cs->exception_index,
-                  event_name[cs->exception_index], env->cause_code,
+                  hexagon_event_name(cs->exception_index), env->cause_code,
                   env->cause_code);
 
     env->llsc_addr = ~0;
-- 
2.55.0


