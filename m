Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4271CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJv-00050h-05; Wed, 07 Oct 2026 05:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEW-0008Rm-SD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOES-0000gz-MY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jXIq1873405
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UAia8jROFwpX1YyXuNyzoovoTuaM9aS/YuQ9zHNJ39g=; b=WJ5HPHdeThxD1h2P
 VbP32BGl1qhjRQU8fYSD18pzxrlFPiSOonoF/h6BUbxFKFekCzmafYhbwOPmkd4C
 N9Uv36BBXQzp8FIAIXhBlHXfXgJUZ1lYzocVzMDr5kH2X6v12r+rsfZXNjcsRZDp
 1eTgoOwHHqRzwNCIT3T10KHVlKzJ37u249WLwfAcCbIrjDr+3Sg/LQxWQ8yIzKbc
 +6VogoN9FgyJaHd8TnSBbje/CTXpH+SsX5dcR6IpnDBKQP0O5/QUttM2tovasN8D
 rxKB+xk2MPEdawn+LezuETagv8XKQ8aU3rNn/6x9fgz8p0hAVgzztM9TbT2tUCpE
 Fk2JIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8rtjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e46b4b700so642004785a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366398; x=1791971198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UAia8jROFwpX1YyXuNyzoovoTuaM9aS/YuQ9zHNJ39g=;
 b=LV0ELmvFzA/wNtmzEmFBldcc6V+ilUaxqnHYSduwx9d7Z9n1t53jVclf35nEGBCp9A
 eGm/DUUfoHNKLjHmVzpwOIvy3T8fXA4ehzZDunXgn/U+WfIvmJ9DNsfZR344TAYDCrG/
 ghcVqfHqMV7UXLnMCH7m67tF77TD/meR/f7CI1dlM0HZnOd30u7lnheS5MYN2pYYriIO
 rLZFuAy5v9StxwosG+oc/arDfNsyuNdSp76Y0S6X5mHNn7H10TJvrqJc84MWmbeInA/6
 8rf99mp5boO3HrUyTd4MPWp/TWsUl/S2TCDFukB6S7/LiN5X0kxOgAhnY6i2IQdwQUHf
 HFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366398; x=1791971198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAia8jROFwpX1YyXuNyzoovoTuaM9aS/YuQ9zHNJ39g=;
 b=pbCtAOxBnu1BKe1nKJVGOQmIVoiQYcuR7hKTjQZvLZMjHGnipvWWfTKSuLBqukOV5w
 wK19RvU9H6wYAr1gOlHNjsFoFGwOdpADGKkMDHE/vXgrvXUX6SmVp3UEzpxGZOS2P69g
 S5Ri+kBmuh6+pnGt+6vVrjzBlt6eZhFDywhS1lQpIgaVoevARImqXCT7jYOyF546e73y
 doXn0H7btEecXQdDXJwFLjGyKsNFYHbCQMS73iDA0q9ICW42qa9nmFKtJRH9qBncljLr
 OgnF3ohbHP2+BI120zFgl8QN+aDs/naaaaiD4GRLKE0LNwwGqnL5DtF4ySqPJbL071Es
 UjXA==
X-Gm-Message-State: AFuF++k9QWaXrdMcPSdi31AbaGz7bRBoaoiRldTWN/sMv6S0gT2ebWuE
 EoJJovfInfzWcV4FSPXS0pzDc26EwtSZBOvRNVYhX1820hLzqhri/s5uMNoT3TF1uvIbxi+A8d0
 /5XDeJ+x88c4fXTxQ1BBYe+U3sfGI77b3mnrPFb/OO/GTzOOGxuBr+L0NNYCQI+2bRcoL
X-Gm-Gg: AYBFou2JVomJIpOUrW8PPebSA8JKO0Ebc3f6g8OWcoIpJ36f0MuQzejXvw6ZLbsqGFK
 IAwNeqasdvgWdzGqRRKCKRAZv0AB5eKDrmc5g/TH47UEwVI1vCeo9Op303zv1ZcXaSuC6xwqYnd
 MruY2RBygZ0hx1WyiB1gXIQ/eOlKn7nT0w42RFakppcj6WjEeaO3gqftXZ30Kyzp1bxK9muPtcq
 NwsKbi2BpB3a+0jFiqF8q4AOEZYCrOq92zIhaSdJDapqwF/u/gqJU85oueCvRI8gEva9I8b1a59
 x31+IVkWYF1bO2NyXMZOv+SoQ5ijN79lzB5EQOgqzsXCzb2XWuNp35zvA/6q3+YWGilOQ8e9UFC
 pR1RPj6WbBQwYQflEPrNob1PqtnKvn4F9xxf6HtKB
X-Received: by 2002:a05:620a:4486:b0:93e:6f85:9643 with SMTP id
 af79cd13be357-93e9b79cb32mr308370685a.32.1791366397928; 
 Wed, 07 Oct 2026 02:46:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4486:b0:93e:6f85:9643 with SMTP id
 af79cd13be357-93e9b79cb32mr308367485a.32.1791366397456; 
 Wed, 07 Oct 2026 02:46:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm4303260f8f.32.2026.10.07.02.46.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 11/27] target/m68k: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:44:59 +0200
Message-ID: <20261007094516.75732-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX/l1xJLVSp07C
 rwK5XcexOPijyKsUoxhRDEUra8IEpg+PLagKj/2tZzvhER5aqU8kpAYfMylLkc/ZXOp61gLEeZK
 IjLj7+Z2zDC701Q79vtMP4G0ONbQDO4=
X-Proofpoint-ORIG-GUID: tMhUlbx_607pzBQPYM1CnyRbIXnbr3Gm
X-Proofpoint-GUID: tMhUlbx_607pzBQPYM1CnyRbIXnbr3Gm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXzVbqTrPO1aQ7
 LO6B2Z8jKhT5eTjpcLPUZEfGY7jdZ2N5DHW3oOIRhyuaP4kgAK8SpjkPTxmIJa74ZtgNzpbhvbp
 5+e5XPZHMihmNlbWe6pxwoWSKvJqh11GkSDNd74vjF6muBJNX5E3SvvaRj+qk3tri5Hs8801/2o
 MkLyOwXxHtHo4RRkLErLcO4AGEOZxG+2QtVxhlkr5ZcD/PLJh7ZAkLXK148GGrcRCaoPaydeUrH
 9O/mng7BrIkqZWC/UdLXamhBsmO/3DaLUCjmwNiFYFQkHFpi8zf7ETWN8hXDE7XY4QGYL+py0aH
 ALolz6K7aiCR/KsUIviMCwFPAphHKx0t4vbVZBID1xSrxCuJXDgbRhmZ6vDaWLr14iHbH5JU+Jq
 5PITVBkHBsc82BazJc/R6nlvPpv9ENmmA87ZKSFN8S4jSRc3cJkPzptEYWMly4tVI7SeO0sw2gy
 vhF4xKzI/+I1BEyIneA==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac614ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=WGgSrhXdDH171488PJ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
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

Expose m68k_exception_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve M68k exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/m68k/cpu.h       | 2 ++
 target/m68k/cpu.c       | 1 +
 target/m68k/op_helper.c | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..44b4afc41c6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -69,6 +69,8 @@
 #define EXCP_RTE            0x100
 #define EXCP_SEMIHOSTING    0x101
 
+const char *m68k_exception_name(int excp);
+
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
 #define M68K_ITTR0   2
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..7d5dfd8e529 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -730,6 +730,7 @@ static void m68k_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
+    cc->exception_name = m68k_exception_name;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a689814..c600f83ddbf 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -80,9 +80,11 @@ throwaway:
     cpu_m68k_set_sr(env, sr);
 }
 
-static const char *m68k_exception_name(int index)
+#endif /* !CONFIG_USER_ONLY */
+
+const char *m68k_exception_name(int excp)
 {
-    switch (index) {
+    switch (excp) {
     case EXCP_ACCESS:
         return "Access Fault";
     case EXCP_ADDRESS:
@@ -185,6 +187,8 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
 {
     switch (cs->exception_index) {
-- 
2.55.0


