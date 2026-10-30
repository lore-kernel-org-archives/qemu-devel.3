Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=URvE7r/G;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JJrfojnA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrKi-0006uE-QQ; Fri, 30 Oct 2026 14:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrKF-0006ej-TI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrKE-0002Rn-AK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:27:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHuLsA3669811
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zMHEOtcFQ6bEV7OyRoEDkdIX7g1cFYMoUEq8agwhB74=; b=URvE7r/G8iLKTGZY
 b0UP3HLuDiTS9KK0blLwOFkSFzuz5Afcl2f35CQHcQdjMyXLrE3qxQGZ4Aw6cAtb
 4x2DK4l9be0LYWpICj4MYAeHsUo/rZeRjGGBQX9VkvXPFpzb8d8df1PPblHVuUpB
 op7zgXqtxvaiU3OPAWRhQP9tCoZf+TqVmJSm21SczA9n3SJXOQPHRvjliPMcBAzz
 FJExkXjcWRY9ddPNWEOnVVYtNmdszJlQjlkaBLKhIEFV8lCgCRscp3iNI6jt7e49
 t+XvDjz1Xjr0CIvwz4BNz8hYCIcC9gcw7HhEL3m0kxX3CmxOv7tKjKFb71C1IK2t
 R5bmxw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmemq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:27:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9441113670dso227393485a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384855; x=1793989655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zMHEOtcFQ6bEV7OyRoEDkdIX7g1cFYMoUEq8agwhB74=;
 b=JJrfojnArZ7o9+4ltIXC71UXBXhFNEWDdanl90CQ7rybZGtVwuiDOEJpYoX1rJFYw6
 rQha5pZ3E0QX+zLWOmmkSxhIUHBJmHHH7wvDdIP6GACzdYU0mwWOeHxURd3qOW/J8aLO
 3PkNYNvI03yVyz09lZQjgHhebsGqdQYMOK5uFXAJ778GzNK1YEPupeCz7DX9q6KyfTSc
 AiXko7BeVP4dNM5Q4ssESGXkjjqj44UpC+2O7xx6iWAzZdgpoCC6Z3/lu1X+0N9VaBWL
 CkMT/vUr+KhSXPaI4ADLtSeL2E4CuAfH5R7vyVvgHnf/IoXruJZIm4O/XVnWJQfqsrmc
 6I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384855; x=1793989655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zMHEOtcFQ6bEV7OyRoEDkdIX7g1cFYMoUEq8agwhB74=;
 b=QjRRc69hDbQAZcQbgU/MgOz3DSJZML36FtD1X1cfitUQNJ3+lQ/unbeOYZh3Ds7Z+P
 ZMrmKUgHCkhBPEdSKSAaz17tzKEaC+nvJCngG4LBB81XHTp0to5NG0O6z6lpx2/Ge5/Q
 E2rGSdOFp28G0c47g9nob/l5MVe2cjH5Rh3KKvQa0C9h00RvuVchHGtaS8fad4pZHypt
 kU0iFbDcw45BFu6xfYA7Wdpgfdsp0KPdvrq1AwHzZNsiBNqOKNor1GiC5u4LaCEwnw8T
 13e3q+3HPHHknp9T06b0jEnsWZB81CQ2sovOZZxHDEAQGDIz2zyx8ERYD4Ldm3lTIO1p
 pG+g==
X-Gm-Message-State: AFq9FYIfpDduqNVqWN7XOu5eu3RqjAGpMuwdBD1y9ZAw2t0KTlwMn53F
 daakA0PL47owv6a1Vfhy3b5WZxPVzVwJCc23xFA9mfhsHVj27y9ULisRkLAkhq+5vlCm/s0bAu9
 ZmLWjA9AuFBxVNqo1iO6MVzEgpddnYwmdmvBNCQMYGhq/sJR0Y6G+yRm1DH994YmCfLTv
X-Gm-Gg: AYBFou0TYI6SSpx9232OVm6g2SPfzwG+MLmj198IHYHvTeDdEBhSpLGn85Q2QkTCTqD
 1ymnHNgsKveiRY8OYk1vccrlAIQLRtweMm50mRBV6pVxQqnM9axmOEjhCpW24mlDnwFslQV8YeZ
 yqAn7/wTA7esrcZ6m4o5M3tQ6Ekz/nzqU7/fTgB9zjLCnh3yj1Aceo4eKnRIpPLGmWaq9mKczSZ
 zODAY40pywPBn+eX8wlBKgDytIJ41ccWDTS26kjjXK+EBd/u1EBA4mG2wJ3kHyKeLlMLMHJVAYE
 Dx6CLOEZgH8KHBkf9I7qTnHtbIO748dnGCvwxJTrn3ZwVeyVqP5i0RMdli91E02ubLAg/UEI1tb
 3MIgTuEzsIPTsYXv3tk/ZEwBUFEkwXpwkcCC8lNVkGDWTIx3bQ/PQ8Qp0DVa28Qsu8g7j/pcpOx
 gTTXV1mkW1+tmzWJSi7DYvcnfeFXejEw==
X-Received: by 2002:a05:620a:2a06:b0:940:f2d9:5f43 with SMTP id
 af79cd13be357-94421588068mr545347385a.6.1793384854920; 
 Fri, 30 Oct 2026 11:27:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:940:f2d9:5f43 with SMTP id
 af79cd13be357-94421588068mr545344185a.6.1793384854515; 
 Fri, 30 Oct 2026 11:27:34 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm101312725e9.12.2026.10.30.11.27.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:27:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 12/12] tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC
Date: Fri, 30 Oct 2026 19:25:45 +0100
Message-ID: <20261030182546.2508-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4e197 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=eBbVtaSGukq6HTEcENYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Rwt7IrQvwiYBQ1n02e6wRGiOhWsP9v2p
X-Proofpoint-GUID: Rwt7IrQvwiYBQ1n02e6wRGiOhWsP9v2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX6WZWJQfgA2iF
 Prg18IJ/Zr3uBDzctHRtnS0M3+g0uLo8E6yFOaEWUeIbgLPSM5eNPibYzKo6xNLjdoQ9LzmI13L
 BC9L45J1tMlU3RPraYLlipUMHQLNqrLE1vGP7/GpNWBLQoCPtbId8N7lPo1Pp+X3LtJ1D1msWNp
 nYMyiMwmfcwynTrYq/NY2t090f8Z+WMgrSgnKs3Dy/XfmU3F/zC2zxwsHcOcvDDs7ox6VfLZ5m4
 AtUHL6Q4wQfwGgiaGvlRFnbuG5bs+LD6BC2HwKanudxBa+OYBAhornrcyT4MDmPtl94yWL2mNVx
 oZNLzPTx8K3DGXLp0iBAB4ET2ndgJxx4F0q6W6ZI0Hrkv/btuVVO1k83nOeaf0DgS/ApFq4gJMO
 Jm8W9eP7a4N6uUAA2dZb9me3x0f1vgqgPcbx4kyr+BdUWs8HMdCv/dFlKk1wjiZCJpMeFL8aq2n
 g3+71sQEcmsvmINobrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX9aO+bOWOkUNB
 VbNDPt/CVVxFEJfWeFZzYGsAaia0tHeCy5F/H/5ks5z6j3UskP9rdbeCYS1vYu52rFmg3fslhW6
 czJSGS5SU5ElZaCEeX8ajzYWXf52TL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
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

Now test JI[AL]C.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_mips32r6_branch.c | 71 +++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/tcg/mipsel/test_mips32r6_branch.c b/tests/tcg/mipsel/test_mips32r6_branch.c
index 83580fcbedac..3c0746c0e028 100644
--- a/tests/tcg/mipsel/test_mips32r6_branch.c
+++ b/tests/tcg/mipsel/test_mips32r6_branch.c
@@ -36,6 +36,75 @@ static int test_balc(void)
     return seen != expected;
 }
 
+/* JIALC rt, offset: call to GPR[rt] + offset, link in $ra. */
+#define JIALC(bias, off, seen, expected, tmp)                           \
+    __asm__ volatile (                                                  \
+        ".set push\n\t"                                                 \
+        ".set noreorder\n\t"                                            \
+        "move %0, $zero\n\t"                                            \
+        "lapc %2, 1f\n\t"                                               \
+        "addiu %2, %2, " #bias "\n\t"                                   \
+        "jialc %2, " #off "\n\t"                                        \
+        "2: bc 3f\n\t"                                                  \
+        "1: move %0, $ra\n\t"                                           \
+        "jrc $ra\n\t"                                                   \
+        "3: lapc %1, 2b\n\t"                                            \
+        ".set pop\n\t"                                                  \
+        : "=&r" (seen), "=&r" (expected), "=&r" (tmp)                   \
+        :                                                               \
+        : "ra")
+
+static int test_jialc(void)
+{
+    uint32_t seen, expected, tmp;
+    int ret = 0;
+
+    JIALC(0, 0, seen, expected, tmp);
+    ret |= seen != expected;
+    JIALC(-8, 8, seen, expected, tmp);
+    ret |= seen != expected;
+    JIALC(8, -8, seen, expected, tmp);
+    ret |= seen != expected;
+    if (ret) {
+        TAP_INFO("JIALC: last ra 0x%08x expected 0x%08x", seen, expected);
+    }
+    return ret;
+}
+
+/* JIC rt, offset: jump to GPR[rt] + offset, no link ($ra unchanged). */
+#define JIC(bias, off, res, ra_before, ra_after, tmp)                   \
+    __asm__ volatile (                                                  \
+        ".set push\n\t"                                                 \
+        ".set noreorder\n\t"                                            \
+        "move %0, $zero\n\t"                                            \
+        "move %1, $ra\n\t"                                              \
+        "lapc %3, 1f\n\t"                                               \
+        "addiu %3, %3, " #bias "\n\t"                                   \
+        "jic %3, " #off "\n\t"                                          \
+        "addiu %0, %0, 2\n\t"                                           \
+        "1: addiu %0, %0, 1\n\t"                                        \
+        "move %2, $ra\n\t"                                              \
+        ".set pop\n\t"                                                  \
+        : "=&r" (res), "=&r" (ra_before), "=&r" (ra_after), "=&r" (tmp))
+
+static int test_jic(void)
+{
+    uint32_t res, ra_before, ra_after, tmp;
+    int ret = 0;
+
+    JIC(0, 0, res, ra_before, ra_after, tmp);
+    ret |= res != 1 || ra_before != ra_after;
+    JIC(-4, 4, res, ra_before, ra_after, tmp);
+    ret |= res != 1 || ra_before != ra_after;
+    JIC(4, -4, res, ra_before, ra_after, tmp);
+    ret |= res != 1 || ra_before != ra_after;
+    if (ret) {
+        TAP_INFO("JIC: last res %u (expected 1) ra 0x%08x -> 0x%08x",
+                 res, ra_before, ra_after);
+    }
+    return ret;
+}
+
 static int run(const char *name, int (*test)(void))
 {
     int ret = test();
@@ -48,6 +117,8 @@ int main(void)
 {
     TAP_START();
     run("BALC", test_balc);
+    run("JIALC", test_jialc);
+    run("JIC", test_jic);
 
     return tap_done();
 }
-- 
2.55.0


