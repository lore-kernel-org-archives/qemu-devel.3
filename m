Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7E606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WFM+IQsP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kxgM/reE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFA-0004NE-3x; Thu, 29 Oct 2026 13:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCV-0000jz-IX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:46:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCT-0003zi-UN
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:46:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGD3uP1143407
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y5BbUd4Bt+30FE/EdTCuRSEx/QWam9clwJ0b3JjotmQ=; b=WFM+IQsPt3JXi+7z
 fcupdgs8KSgj2UX0gdx6lF4HlgVTJHCfZaflXDgRJiEHis0w8qS9LPHLv05tGZji
 ID+k56LNoWKAG/iv5AD3NY7TBG1HArpEOhluzK7Xk1Sli2C6VAzKvyoO07/KheUC
 DDRvfTDMdVH+uOccRsNGSX4czFvv8sTjiCLuMX4i+wo/n1bjInCFIpQPzILNkvbZ
 uaFMPDQEVxNWPXMza45gv8AF0SstNW8Qc/K5rAacfLDCXTIqAbdyp4chJ/Ox+tmv
 0YA63isxm0m+eZTfHUkYlW4vB0zVGArusBdDL1HYtxh6mr/vpy8r+Y3lYlOhWDug
 zOR5wg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76chsss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:46:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c8a517107so38723036d6.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295964; x=1793900764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5BbUd4Bt+30FE/EdTCuRSEx/QWam9clwJ0b3JjotmQ=;
 b=kxgM/reErvTlDN3khsujTpBZEuPYLsmv0IiOv51YrT9AruARLw56miYtxryzWgezrz
 UYUaZmYy9HhlCTuzY0wXg5fXp6TLRB0LWO23kP1FDDe+pysspbrl8WMi/WMtArZ8hWA+
 zKNeEf8Rkbj9NkDe0jxF6mWL9pfWRry11s89ADiTkZMFoVbGlLaGice+GhIUG9w1VS1k
 ksuk9JTvyaPtnOY28NAdDWg6zbEBlX9T9dl2vg4ldKjAUV7JImKvoRVt87zPaaAfE9hf
 Rza2+5U9+IXndab7nA0FigZySYPfrL0RU5ImgnBK7Q7j8CmvIpXLtWDi2Xlljqbfcrkg
 Lizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295964; x=1793900764;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5BbUd4Bt+30FE/EdTCuRSEx/QWam9clwJ0b3JjotmQ=;
 b=lG93hvqvyRo0/etUer4ZZN1UrYkVJPFOLr4qpONPRlRQM5S+Xri/4rTItUFsVReNX6
 SnUpZXU2EwEKe3NK9GXHydWamcyT41CC4eD2KSxuLmQFd3j5KwA1qzrgxYsB1L0/C7ax
 1DbLUp9VG/01+6/eJWzlB8JJi9pR1IMSRYMLC9IFD7w0HVkjlLbkcQdQp//mI+nY9Xbb
 LkJBZaX4NTAUE9xCcGRG503iARGQ09lW1u4ZElsPV8jOBOhDb/kgJjt75UFl3D+VomX3
 z3ubhAFyM7zsH4+2S++j/DsmwfciCDHDY9CXrzkyqDK1KG1n22Ul6bOv6taAqCnXx/jG
 6bAw==
X-Gm-Message-State: AFq9FYIcY8Zy5hE63BpRaz4M9nPqxALf7ZnB4E2vso2EC91mvL25csq4
 31kHbm5IGZkxzW2VmpXwdowLCCYFNUAVcq6sG+3a6LzdgGXQR1ElEPnuwvPSi+ujRoAH3CPCEMr
 hYJ0tSW3WiU8UGh0pfr5dM1b2a2EAYzeRXN+VliMbW32yhqaFm0h9e3mZs4RatPUb5gsN
X-Gm-Gg: AYBFou0v6PxKtA0cySzy+hOk5WiJMWmX+Dd3Mu/E00+F5NMjXG0hXgkeFyuTyxVI5oU
 m0sRZXM4mwLL9REZeYLQV/G4QlVwxUr/oMgiETyDZn2AGvNj3pCBobfgPL0H0MqyieXcuTjG4Sb
 KwOMiUo9PuUBce3BeL157vJ3B8yDqWlnU+o9AiMDUt1mwhuHuKS+TlpBJZ04e8vz+8ExjmNKVw+
 /QnpGWB0xITyaC1Mt0HJJRe0HUXhCo5mYTm2MEOhA/E7FsxBRmEBcOPdMWXHBTl7uQFW2b0n7bB
 1kuDzLZKrYYVmbt0uMPvaDtEqp7rItT2XK2PwXS2yZEJFWMmpwmJkgNx9ARKqM+VGm4rJlmsx8t
 CZ7vD/hftEnaWLRNict+Q8Nwncsf1SGzeAlmB90RVul4hkoG+TMhZ3aHUvlnnESZR4uE/W6Mv5h
 tTdYD0SIgAF9v3Otd8Ap9tbtgeDyMQVw==
X-Received: by 2002:a05:620a:45a5:b0:93f:1437:2e58 with SMTP id
 af79cd13be357-94408d030b8mr896739385a.56.1793295964283; 
 Thu, 29 Oct 2026 10:46:04 -0700 (PDT)
X-Received: by 2002:a05:620a:45a5:b0:93f:1437:2e58 with SMTP id
 af79cd13be357-94408d030b8mr896735785a.56.1793295963762; 
 Thu, 29 Oct 2026 10:46:03 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm63157555e9.15.2026.10.29.10.46.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:46:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 12/12] tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC
Date: Thu, 29 Oct 2026 18:44:33 +0100
Message-ID: <20261029174434.27985-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uPVdvscMGq5rtEd3TsorEBJLbBkasEuw
X-Proofpoint-ORIG-GUID: uPVdvscMGq5rtEd3TsorEBJLbBkasEuw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX+kDOSZtHILCv
 a7Wwweee71Zk3oQ27JMF1wO4XvdL1MS6cVOpgXJxYO5GryEKWxNAlebbj7zUYCSk5g1izNaTBux
 DxidtjSya7yO0ZUhtaly2WqQFkHf7JI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX+6myuMjzKmc+
 8wDRKOpG53ZmkUrQVnFq6iVP8Ht3UfkKUKWN6/Qc13CB3FxwbWnl6Og2dWLSAt9jrJqVgcb5y46
 tx1w2oxKh5+OqUudghUA01V0O1k0uueFQgVWy08AAADmHC6arnfvyaIcA89px4I/8ejvXPCck9T
 Dv9pqCFzC4YBC/79vsE60FpfTqYGUTzemITkRaNj1u7WA25k50H+SthlqbFNbFbE0SuiPu7AP1L
 zhuE7FuUqDs4S2dyQdtKkSpo/zT2yBl6BrQOG13krA1NCdeLtkBk5GhxTB1IsLwrR3ddGUh3JXd
 vOHBax16b+lpFhdyQBIjCjEijKZa8L1OAMwBnBtG2Q1wuaz4RENdPyki/M0x+jLDJtMVwz3PX/y
 gD/fGzHU8QKgMvOxrlBKx/M8jeu2vw==
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3865d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=HFLaNqaFXokG6eVMDVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
 tests/tcg/mipsel/test_mips32r6_branch.c | 73 ++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mipsel/test_mips32r6_branch.c b/tests/tcg/mipsel/test_mips32r6_branch.c
index 73a0036997f9..de2812e954b4 100644
--- a/tests/tcg/mipsel/test_mips32r6_branch.c
+++ b/tests/tcg/mipsel/test_mips32r6_branch.c
@@ -37,6 +37,75 @@ static int test_balc(void)
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
+        printf("# JIALC: last ra 0x%08x expected 0x%08x\n", seen, expected);
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
+        printf("# JIC: last res %u (expected 1) ra 0x%08x -> 0x%08x\n",
+               res, ra_before, ra_after);
+    }
+    return ret;
+}
+
 static int run(const char *name, int (*test)(void))
 {
     int ret = test();
@@ -50,8 +119,10 @@ int main(void)
 {
     int ret = 0;
 
-    printf("TAP version 14\n1..1\n");
+    printf("TAP version 14\n1..3\n");
     ret |= run("BALC", test_balc);
+    ret |= run("JIALC", test_jialc);
+    ret |= run("JIC", test_jic);
 
     return ret ? 1 : 0;
 }
-- 
2.55.0


