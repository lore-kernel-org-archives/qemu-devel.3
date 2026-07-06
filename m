Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7068EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhh-0006Bt-TC; Mon, 06 Jul 2026 09:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhX-00065z-6L
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjhV-0007A0-I0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxJuG316462
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UNLBNmEEOTthboq5Q1P/L6moygeY0HagU9zFilGJEb0=; b=cBVKeClfg6s3rEvI
 Oo1IM9e/bXhVOLSMG2nEyRJpC6pUdGG5ik7xBsNoaf+hv9boCT35CN4owjiv+cOL
 BUOTvFQOY+O6f9RFY6QqXqmnEMWh8lFPZwLM4TOXiyueOc7Y5HgIkJc38cZ27mdH
 3i1aROooAT3CilMfPIKVUaxKbPpiLhE5uYPo0QFUS2o1x3NH9LkRr50z9dfVMNUJ
 NuMlzJLBbyaCpirc7t3i1doGSR1kb5jJdHoPfl2HO0IM8kdAG6ONCAkWjzd2Srgy
 t0gmmb4FfZt4qwplDvEZ9/KsQLlNv+1DX98khY8QspeH6rNjj8MV1iyygAZkgAME
 pP7xFg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7hjbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:49:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e61b38eddso552212185a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345772; x=1783950572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UNLBNmEEOTthboq5Q1P/L6moygeY0HagU9zFilGJEb0=;
 b=Vq3fKg9SvjYcF0IgluZGh9j+S92xGvLnzaPT3FkVRkdoXWFj0EN6Z3k/8vt5bRJp30
 Aw2LuYLJsS6yNfodw50HiYndkt/w++i2K0aogSQhqGVgN0/lj+rI4Qx9YJefXgTRBkOx
 zYRXfI6dOAXXemW4mhNsCuotpcyEw++9mN4HjyAZnF83OaRgRu6cAimFsCN3FLMb4VuC
 o1IzFOZaBy2uPU1xceiBqeVmN87e24qhtFODo04v9Gcy1iGJTWC7fb9v7NPVgf6NYLuF
 nPxUNTPUERprdk7haKyNpRVcZQ1tuS8vsWWpu1cBkMOCM0pqO/ifVUlaeBJt/IqyfiYz
 51EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345772; x=1783950572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UNLBNmEEOTthboq5Q1P/L6moygeY0HagU9zFilGJEb0=;
 b=h5f6ZLHoUWHZ/c++vol3cVNI/05TZS/O+Sgv4ybr6DixSGij5u/BGWoKG7fo1BpeIF
 jdZuBEk7fknXaCrS1IMhmBFfR57LsqPjyskI1NLy7TJ1zjvuohipD1BvxkZ7XlBGOEOP
 Jqr/1FcF0G2JvV6neM7eoM2sp1g5rfZuPBaJhYypErsFEbHhEYDj9sF0JSOiKcmQlxlh
 ID3YStbGq0US20L+yEm08ump4q1iNmxU3gZYJtYx+VGCtH0DXxVpG9SkeIAhO0DkemAe
 TO6WmiZqDxlrjE2iZrMVUFXqycrh8VXBvIAkcOo0iPlrLrkAKKD6p1yr9QrsmbqjSqcj
 l9+w==
X-Gm-Message-State: AOJu0YzEv9HP6DkzQFw6MpeKyvLDllhDRM2CFXriqdgeYZ8ODdCpIrM9
 UUgN4kJCaRCM9WT4rPbPup7pGh+/vg54Mzf7KwaXmEZQlP1b///1HLtAmdNQBm7frxEgsJ0Ft2/
 MfKHcQwoBLGGX1lMjIXcckEmcq/gTgm6ZMLlq2NnjOC3HLwVq0kBPHlYCDWg5aw0ofQ==
X-Gm-Gg: AfdE7cluRZZwlc4sUefjPARVDGB893C53a62c6WEZ1vva+mra8Z4XNlaf1K5XyrfEW0
 hs9hOrp/Gqp3cFWSIa13gYKdCKJ4jJm66DyrA+TM+bTEaOAGh8YObq6N2oWwnLp6gPCiD3pQ024
 rqGpjyTFEMzcJQVvamluSvSN/jgsEF2q66/Nf2fT4zpJOfAkAg/qHsRz2gNyS1WmgWAbwc+imGy
 J7OkxSEMeCWYyzckjSSxvrITyb6720SdeR/Iw1UXN1iBCDjrUceV9aJO2/vbV+HTxg2j4nQ+bip
 CxTxOapUIuUj2sYgMNLhlqsDihd1dPhD/e4fNCLMqRp3JsDXrXEXxxsTzsNvvI7TJsB/Y70GZMf
 sLSN2GT60bzBYgxOmbs/tlaZu+u4RhEOwDVw6RDOirfl1MWW4ubtGc/tFWw==
X-Received: by 2002:a05:620a:808c:b0:92d:f034:7c39 with SMTP id
 af79cd13be357-92ebb59067dmr88016585a.55.1783345771882; 
 Mon, 06 Jul 2026 06:49:31 -0700 (PDT)
X-Received: by 2002:a05:620a:808c:b0:92d:f034:7c39 with SMTP id
 af79cd13be357-92ebb59067dmr88011585a.55.1783345771214; 
 Mon, 06 Jul 2026 06:49:31 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c0e92687sm366328855e9.0.2026.07.06.06.49.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:49:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] target/arm: Inline check_watchpoints() in
 arm_debug_check_watchpoint()
Date: Mon,  6 Jul 2026 15:45:21 +0200
Message-ID: <20260706134527.84808-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXzI6rRo3FHbCH
 2mvc2BR6ZwYUSQQkO0OtpQWH0fNzaa1T0NsZwh/2rMX/XBioxuGj6xB9Z1zVwq4cQDAP2JB8BVh
 IdXl3laK0K15x5gZrFnKjGSfbEJoR8Amv0qHYC5eg7pUnz9l71Nl7V7/9TmjTkqpjuOgvmVb/vA
 wb2V0UcQFfE7bTik67Fk/qc7f6L2j8EAehG4D97jV8hp6Cdq5zns6IeD/wrac6eDVRx0cHdQEXB
 ppkzin0qEfe9ZVUnjCZPkwrMty3y2znJtcdt3Is4j/EJyIdbRfcqqOgS3gEE6jfSS43YpXyh6ku
 IT5ns8ufS3vrCNrKLjJjDuu/CbzbqcAUDv+c6cswrOby+HHSKeJbx3/q/P/zzZKvqxDcQJDWeyH
 579EAiXhingz6M/89EWtL2BJmxB6kepI59BccaMgl1YCa+DckGJzw0eHHhkZ6SVpK6dkKRgAZsm
 TH3ADeOwE9dbJGRTrag==
X-Proofpoint-ORIG-GUID: 76M2pc7civTDQvyDNWe1okMMnvh34MFd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXwdHo+OK2u6w1
 H6axgzaCqxeVMoBlITMOkJ4rxEnLQsWLrXScvuucAJDpJtNirl0lcPfgD9REzPfhZwpsgFu2/wT
 Y8MfpOBqjGmucSbAosEAtgu0lnhKRLs=
X-Proofpoint-GUID: 76M2pc7civTDQvyDNWe1okMMnvh34MFd
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4bb26c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FSafjcPV3XuXVNEPM0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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

check_watchpoints() is called once, by arm_debug_check_watchpoint(),
which doesn't do more than this call. Merge both. No logical change
intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-27-philmd@oss.qualcomm.com>
---
 target/arm/tcg/debug.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 07a52643e71..528d2889c3a 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -351,28 +351,6 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     return true;
 }
 
-static bool check_watchpoints(ARMCPU *cpu)
-{
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
 bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -426,8 +404,24 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int n;
 
-    return check_watchpoints(cpu);
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
 }
 
 /*
-- 
2.53.0


