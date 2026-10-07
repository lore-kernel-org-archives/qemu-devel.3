Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A495BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLV-0000dv-UK; Wed, 07 Oct 2026 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEb-0008St-6m
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEZ-0000i7-J1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977japx1873499
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mw6FdQ5AtA9pUNFmEgch+ZbOHFxRIvXAKyzbh+eOPaU=; b=iTaj3WrviVI/rIL6
 227K4k/WyAvrGkhAVzI6/UetaJVBZTrIyYe2IgSgkhtY8Yb7hzLh91Bi9Q1EdtQK
 Zk1BpQ0K7agBlP4p4/IgwpVQ3wzINVIBOGasrvol4kIhDkS57w+rKiI7lUj+tKS0
 QnnNogvLTuqBPsO2ah3lYCY09lQuJxAu0MCocgSZNdKUlkpNn0yUQXEYMoICVlRU
 TXdBp2JeEekenx/Um29MO+LtebXG+1iBvMiPhh6697WX+lw2/xQ8+oyiuc6ELZjj
 eplsGWuPh/NusJukp6cNB0sWfNKiqcbmGzKLRRJ3oM1Pd8iTJhGEQ5vfPzghJlEA
 vrn1dg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rtk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso470051885a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366405; x=1791971205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mw6FdQ5AtA9pUNFmEgch+ZbOHFxRIvXAKyzbh+eOPaU=;
 b=f7hmIVZpBuJ1DfWJfV3f8D7yaXKZ5ggonYbk5B6CDmOxGjnNQALitTwEZT+KeCMfZI
 fDJ5wUBfanntWWlJzpgP9RTfg4NauvHD3KcVgFzE0DBDzfrbUSvgr1AH9WRhwLQF1O+g
 qH3ENz2YsF7F1h42tMRFvI6ZvptXYjRhTRExhIjy8x+p0LcqJcGVM9xHeiKHieiY98uZ
 sX5y0UGIvrr7mRt/c/XLSay2MX6DZA/AICM5VEI/02Py3vMJ3xG9IyEFPBEkaRfc78yO
 R1MUjT1jSBxshmESi6U8mRiCdwr7lBD+vPoE53Ii3l/3C5yhVFrEdl7dLChlz6X+XIVg
 UjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366405; x=1791971205;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mw6FdQ5AtA9pUNFmEgch+ZbOHFxRIvXAKyzbh+eOPaU=;
 b=fdMZuGFYjoFCJ3m9I/vOVEBMSjg8qr1OTsHaIoDZTw8lDh7EIVI0HCK8VuEC3gx8iW
 6cuoCUMT1Rs6Z/IoDFVUY2V7axZWKisSezv99DxqS7sYrsAI902H/4hExsyjgiSSsYRa
 EVF69vfBoj1oRdZ56lUveUZQSU6bF6j7SjEox1I88Fd3mowlJxvP6LCv5Hh83JK2xrp1
 lD1qsloJ0qKqO1yvdHCx1CeRkJn+E9R287iPaZImF1rmUDRGuzcmIdpaoqMwDS8QZoKp
 ZNxH1U/KDb83Jc3OHo9fGuuUEA1Suo1tw7SyCFvT9qB/3F5a3P1Q5IGzY+mnJfEcNctf
 SKtQ==
X-Gm-Message-State: AFuF++n+RAI9OuziDDXIM2aGb7rKB7IkFPPxt7RwyYpG9EsonYJ5N2zE
 1auuC6RmBmJ21wdNExX1RKmQaAwuA/vBuPUNh4QI5sqh8MLbWN6NQLvU5snb8CTFGZ3AnWeRu17
 x6yN6Ec2ExU0QhU8voLrO7wxmWG8uKj07/SbB1T8G3QaHAMvBLyG+/mQhg6LVgyvSfHzD
X-Gm-Gg: AYBFou3pfXqaacNeGxQ7c99eojN5o8iDBJslkgHpcnZKbbHpMLCcBNNdrKF/Q2CouXQ
 6CYRt1wEoSHw/SZdpuYgXQqs+LY3akdUkI9d0aORuY8YJ8q2SJbGu9MYHlt5BHscLcjbLJVlTeK
 BJcZ+2HDVay8cfGjJyj30Tf68YJFSqM5pg/oHRekju4bGWaMH/ZLwn4NnafdGL6F8Ex2tP/fB/0
 j2wobFxU9P/ZYnnG64JODBkcIUSGg9mT72KUI381FXJJrMG4ZMRPr2ReBq32U+byO5VYt8uybsb
 a3kH/VrddeAuamWWzshEdQoZ11XuaOG+aGCk5M4S+a7CPghwlYqaQ8ZSKDUdizPRXUofHqgsQ8e
 DNlW9TlxRQsPUoGMbBqyCjZ4Gv9ZeigdrRi+r3V/q
X-Received: by 2002:a05:620a:408b:b0:93e:9808:b9ee with SMTP id
 af79cd13be357-93e9b88bf27mr355344285a.83.1791366405067; 
 Wed, 07 Oct 2026 02:46:45 -0700 (PDT)
X-Received: by 2002:a05:620a:408b:b0:93e:9808:b9ee with SMTP id
 af79cd13be357-93e9b88bf27mr355339785a.83.1791366404548; 
 Wed, 07 Oct 2026 02:46:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1272esm4427249f8f.27.2026.10.07.02.46.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 12/27] target/microblaze: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:45:00 +0200
Message-ID: <20261007094516.75732-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX1d9ZL21fKYTQ
 1aX+HMeuHeV5nN3f9w9XwlI7JHYobdxNe0JcAIj0wN7DGZOnDTsLXaNq+v8itJTr/TF1KVt3Dzj
 QB69umQa1jbmvE+IHjmWnu82P0N+yxI=
X-Proofpoint-ORIG-GUID: L3CeGdl-u8Me6UYuSh-oiGVHWLFAW6kH
X-Proofpoint-GUID: L3CeGdl-u8Me6UYuSh-oiGVHWLFAW6kH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX1o2sI6WBHYy9
 n4izAfLejijNNT1IAx7TpihWOIrxmZNgGy2GK6zW0YRROPqPL6b8eREnAq0ybySgM6DvVO8wqY0
 rGmP8ayXNMBR/TVJtDEkCaCApF545qaCRyN2b1VPZzVgqkDTnbr6LAgC291h76R0Nomv1QHeu6D
 ny0fVnBCnxeL0cNUWof0UnnQI9u2uLOveb/+gS4I5ZuxjZbJwKXBP4saIIBB7tJOszQZn5UNDYr
 FUgQfrTzS2pJPb4s0qV2B0AHYoWOUxD1gtjZU+H474kp3cF6MrDsaKnFyWXo9az5yE2p5kHseCx
 ksG1WP1pB1nr8R3wGpi8xEZPfTl1M14uqLVAGoMSskwtCI+7rY7D1ckl5eryCHYY29+A6t5WUWD
 cUH9TPzmQZIVEOZLoEslf1suyzy5XfIUCUIgkH2VaoUv+w4/+7wa5G7NPMZQYZup1+DjCV/xqv8
 UwGVQQTpqkXFDFuOEMQ==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac61506 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_ZqrUhsafL45AmjA-XwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Implement microblaze_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve MicroBlaze exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/cpu.h |  2 ++
 target/microblaze/cpu.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b94..fc2783693e3 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -36,6 +36,8 @@ typedef struct CPUArchState CPUMBState;
 #define EXCP_HW_BREAK   4
 #define EXCP_HW_EXCP    5
 
+const char *microblaze_exception_name(int excp);
+
 /* MicroBlaze-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..224f1052f70 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -79,6 +79,22 @@ static const struct {
 /* If no specific version gets selected, default to the following.  */
 #define DEFAULT_CPU_VERSION "10.0"
 
+const char *microblaze_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_MMU]      = "mmu",
+        [EXCP_IRQ]      = "irq",
+        [EXCP_SYSCALL]  = "syscall",
+        [EXCP_HW_BREAK] = "hw break",
+        [EXCP_HW_EXCP]  = "hw excp",
+    };
+
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -469,6 +485,7 @@ static void mb_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
+    cc->exception_name = microblaze_exception_name;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.55.0


