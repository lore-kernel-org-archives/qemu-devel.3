Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1C606AEB2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fUPAHVdK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ALW2uVc6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRVPF-0006Eo-DV; Thu, 12 Nov 2026 09:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPD-0006EE-5h
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:03:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRVPB-0007Pm-MG
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 09:03:58 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACAUnRl1629431
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bi/CcAI+rvmm6cAUvvP/Z0IB5bzH7SCWH1tuI55uIAY=; b=fUPAHVdKnCegmG7a
 1/WDzkp2jOm+99kDgT9FaOptMUHO/y2byO/D2h310doa/q0WGGSWwLmJbud+I/iJ
 HfMHGRiThyEHn5d8fxYVyuwlxKL6E7YBYUQ0iXHgJ40QTiIATBRe6VxI8cyUtG7x
 83T0IQU0CsUImHakuNWtFQxONCYTAp9VGLxmTuNk4aMvhlZMZcYqB7KPJdqaPLQW
 ZkE7aa828O2w052tNnbeBJolwSo64QfWaurLOQhnNNqLFOtQcKsgRg0aXeU9HBxP
 j7a0KmXqWZs5b1K5r0ZYwp8/Yi0oq6cLc6Igv9CQ9KGG2wmVTBmV6hqOQ3agmvOe
 oPB+LQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00q4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:03:56 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so5631090e0c.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794492236; x=1795097036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bi/CcAI+rvmm6cAUvvP/Z0IB5bzH7SCWH1tuI55uIAY=;
 b=ALW2uVc6o6/hcZ6vb2nzEsgY3IKkimZXFwzKvhl0eenfJY/xAf3HqwKm6mb00nIrfo
 uXgik/17/nwdt/BLgny8Vs+yxu+M9TXncWeiBjAMmTIyLFwad6L2vtB/HCnO2HP0LHzy
 s/SOYTZS3d2QCCW8WtpaY5wGLt5HK6rkDHlAKgnI/0TJlMqb0JAN0pJvtOIU5dB/yqAU
 OY/ZJ062JOQTfkJdf3eJmgMD0QqL4UpAnfm3e6mZaTiiga4yyOPuaquXFzLGH3OtUCfp
 IOuuFiNtMOWL1qqlGFvXDi314iXDpqBbdEMn39UMq12eJqW3HYW49KhIUeE6kaA2oOoR
 1gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794492236; x=1795097036;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bi/CcAI+rvmm6cAUvvP/Z0IB5bzH7SCWH1tuI55uIAY=;
 b=NVTNMwzjy/iru5Cf5ptXDL+wHnPbssXpSqSu5M5JwDoYz1rLYjdCNLe3wlJAKiYGUA
 OKxH7iyWElGriOqQFxlsZUvpRhsEtpSAlEeTmWiFlAVSZulPnfHTuYewL40pasvH9f7N
 QGCuX6EqCkcnmNSrM/LYBbrGRJ/UqmidZAy1QyOz5Q6YHKX8TIbatyvm8W8DrYi039a0
 DSPEJAh1YFzOlJvd5N8OVdytR6RmcVCygI2hdBa+t0Ueum0dhrIftb8vW9TJUOSJR/3W
 CB/CIHJsUTMKT1jtNIOwNRXuiqQ1Y06xtbeOFpXDmWyWIi3zrbRpEC+c6L5QMFg8lvDk
 enfg==
X-Gm-Message-State: APuU4Z/D2u1WF8k2wTZabxW09KmkL2TwsSHfjx9/yzC9FDTmBt1PYcsS
 cIQIljxmHdKFcRdRR6UvMGlfUeft4dUQ6Ubob/7qxe4H6ph5/qAsleDaSwexz0GSBnIflVuOAzO
 lN8BrjUmMpHTgsuvAwSHgiI79EHVEzKRUNFkyiUKuD3zhjRn/ZgcEzmOpIxbbgT+y5Xlq
X-Gm-Gg: AYBFou2s2aEl4pXBzSc8qy8KopkG/4XydbqRCGn90H7qd//ncbWJZ8SW9BJSGVlNfw/
 VTCi2CdQirb+nGU4ytRhO0G7MoYKStrjgPTv8vAFW2VNas3Sidh8PKQ8x0AoOiA0/n4zTO0xVtb
 nTat1s1X7xo5Ux40jsxMCKDwgxSooOnA4XGkUI7JAs+SCym0ugSy+1VrJrW+lqN9AE69evhjF8K
 J3fPOghobrFpjoQ94ilmXc+Rm2QH8MdLWBgVjg8j4ppxwaagpqLLuPZUEk+7emYkC1Mcf5Ff8fd
 QnfhwDPmVIzeQDqcKy98ZxArw/0FNIuVpvRe6o9mT+ieZj4gGq0WuCqUzhcKp0PeSpdS4BHCmYr
 3WCgUEZJL5Umv/kFVoyyHgV46YxwQ6QhHNGMsZ/SX8FdTh5tlIgPSs0ItH38Vc8pUFSPV+ybTqF
 DRoNhWSzwVuIj5Ng==
X-Received: by 2002:a05:6122:4d0e:b0:5ea:cc3c:9449 with SMTP id
 71dfb90a1353d-5ee1c48ac3amr2756839e0c.19.1794492235853; 
 Thu, 12 Nov 2026 06:03:55 -0800 (PST)
X-Received: by 2002:a05:6122:4d0e:b0:5ea:cc3c:9449 with SMTP id
 71dfb90a1353d-5ee1c48ac3amr2756755e0c.19.1794492235258; 
 Thu, 12 Nov 2026 06:03:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284c9b1sm15501498f8f.6.2026.11.12.06.03.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 06:03:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH-for-12.0 1/8] tests/tcg/aarch64_be: Check data byte order in
 hello
Date: Thu, 12 Nov 2026 15:03:36 +0100
Message-ID: <20261112140343.61634-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112140343.61634-1-philmd@oss.qualcomm.com>
References: <20261112140343.61634-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXxgzfmdEaJPfi
 rCbJlVyR/giCbPITltZrXhPJWKWno0/d55lOgHb+zF9dexXFXG9uc5XObPtOw8z6ZvBmhbmknHq
 TH+Lhiy3E5pqCxc5owPWkvK+JIkG3Jb3wgzMmCprqlLRV0miltd2K8H4L6hqNOLDN5n1BsJW34S
 kE5R3W/SRLMdWSpcsHsIW3NffqWgAVa9QAilzw+eO9hAmKOXmfLv537D4UHRhPSaTps6fj+0IC9
 rTVHhheWx0Qb04EVUE9nW7mqlWZEfP0R310ZCoTusR7IQ6n5BtFi4CI5kIWq44AAMwLnTqcgSbo
 9P/arMoPOoMHQaWD/eF6phFWk5SESWEGILoULUfTLyfcFi56v4oJBz2zjGKuS7NHU0uAsRKHZTX
 KbZkzJiywwTmZVMh75WofzhdhASbxCzTf/CZSbetFLAXeSxis+B8m+GkgO80p5TShd9RiaeY+oO
 XBUyaswoOrhuCqotJ4A==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5c74c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=apfC6Sr15dbh0XQO5jUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfX6V2WJCtfuZ6Z
 3fccqxwtwOvVvKfQxieDahPHD87jAtpDMaMUnR8gi7EsxEdJ4Q+9ajU077Ms0ZdL0YC8unjzAs5
 pCDxQiZqHfa+HAHxH4kTw512sxhrug4=
X-Proofpoint-GUID: w5LQ_sRCRrwj3gjAwXl-hhn8dnziIjOg
X-Proofpoint-ORIG-GUID: w5LQ_sRCRrwj3gjAwXl-hhn8dnziIjOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055
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

Load the write length from guest data instead of an immediate,
and fail unless the syscall writes exactly twelve bytes.
This detects incorrect CPU data byte order rather than merely
accepting the ELF header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/hello.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/aarch64_be/hello.c b/tests/tcg/aarch64_be/hello.c
index a9b2ab45de9b..4816635d1704 100644
--- a/tests/tcg/aarch64_be/hello.c
+++ b/tests/tcg/aarch64_be/hello.c
@@ -14,9 +14,10 @@ int write(int fd, char *buf, int len)
     register int x2 __asm__("x2") = len;
     register int x8 __asm__("x8") = __NR_write;
 
-    asm volatile("svc #0" : : "r"(x0), "r"(x1), "r"(x2), "r"(x8));
+    asm volatile("svc #0" : "+r"(x0) : "r"(x1), "r"(x2), "r"(x8)
+                 : "memory");
 
-    return len;
+    return x0;
 }
 
 void exit(int ret)
@@ -30,6 +31,8 @@ void exit(int ret)
 
 void _start(void)
 {
-    write(1, "Hello World\n", 12);
-    exit(0);
+    /* Force a data load to check CPU data byte order. */
+    static volatile int len = 12;
+
+    exit(write(1, "Hello World\n", len) != 12);
 }
-- 
2.55.0


