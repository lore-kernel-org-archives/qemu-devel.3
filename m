Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TsKdz6vZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gOZEC+g3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmn7-0002HW-Pl; Tue, 27 Oct 2026 15:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmo-00026k-Et
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmm-0001pW-Px
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHOxF2945716
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZzoOvsBmnfntGKUtY823SYpacEpuzz8xMV9bPYU9ojc=; b=TsKdz6vZT8WTJ7Xo
 MQnOHfohLOqXyOhhBQ5w1zzgTc8g9QI+g4HQQleDCMHDhuZHgoEUxOjb6UT9GA3c
 xW2Yn/eJ3l1uOcWNV5DaS840ugriggnlvD4zNI4+Tn/nxzqhdxeb3xFxbTdqFsrn
 q2ACp9MiczAN3HTL4g12NR5OAcGN/G33g3XXk5MnCUtaT/ogUAw8C9oY8h2xVkXH
 KZDA9BWp2pNgYo3dlqnbi1mUdikip5SCiBiVSWypss3NDNQE4WIqaXVWZd9WrihT
 JThD42UfQBQwAmBZ6ktSkiT+yCJ2vFiLZzVnIlqjFQUR16uzlwiV34EtTJGlgvTs
 Dz9Gdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6ap95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so19873685a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129079; x=1793733879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZzoOvsBmnfntGKUtY823SYpacEpuzz8xMV9bPYU9ojc=;
 b=gOZEC+g3IwOT1ZFkJEexzsPYxQC3uIlOR98qsFomSiqtLiro5TlSu1u59wlu3KOqpD
 O732JBv9h7u8IUx0/R4SeGNIt+WcNwb+wiI5zQJXXKmj9CTwDtPtsi4mcBNGbIJGkBbJ
 6eLGOjS9hXcyitlFMbsmtVtMWg6Lt+jUav6vdfkCPfCOsPSYySbU8ngvym7ngXnAzyRn
 kzMghp/DL8Iew/6C7Ud9aNlAkRzylHNZLUQaw0q9TqwE7a0y3KTSBFUuasnO+cOERg5I
 1ZCH7gi8Adz4Psa7YZFM2J+5OX6eD/5e1wnYs75IuF7wtZeQo76KJLpC8iYbT6edqo08
 azuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129079; x=1793733879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZzoOvsBmnfntGKUtY823SYpacEpuzz8xMV9bPYU9ojc=;
 b=IhNj9Js3gdF9obQkRJBQDpTyMmqxFHWSJUay7UTicwAQgfKqknNxKusyTHl+Y74Lmq
 wg8K9D5d+croazFQxdu3i4Lz/6sZ0sSOqGsVbL29Imm/pm5ITByLBC1jp8GYeU/8rxMR
 5oLdHkEy8D2tZ5xv9Mo6odSId8tKYRvin5OYYANuBh7uCvIELkSU8oX7uzl8E5zSfOIb
 X0IywSPieOLOUKDGpU9sTmlOLtvgiXbMbyZDdjUVybNtXfzwIwNSqi1dt/Pd6Y8I8c2T
 6ke8TaX5Huu8kPyi6SWfJEU/hnJ2mRv1/Cfj5Ema/dm2GOuCVWObPezCfi98SRKmHW8i
 G48A==
X-Gm-Message-State: AFq9FYLli2XsJjrfAzfPd8MLXOe8goV2fTwcYQsn0TCyQ8zb7u9721o9
 NPu6tYnKMWbNYPoAyT1hVIRcYSrOlzpLQPg+G6keNWUWzRCivt45c2EJNeE+VhlDcX5PLzRC4RW
 Ihv36ENemG/kS/8JlHvXE1FJMJAwHNsx7+Dy2IptfwwXI+SlXntaiIANlJfWq9hDZHQ==
X-Gm-Gg: AYBFou0C/2SJUGjjdT/0rH+i1vaW9C7cBvuHhkaFqukY8Fu46LD5GsPMn6FUz6J9Qwd
 dqWstTJPtmLTPdQdsHPEDfecP4ngMA5k0h6+Z6MYf59KYkANYwpmrfyqsB99oBMyqDuBIo5hmqS
 an7BjLdigui/1Ke/37rTsL1Q/d4oox34MX6fF1ckd/Aey4zCO1xyxKnda/k2gBqGBJwCPeRj8+d
 cvB8EizDWMLCHTguO2oK3jlCbKbm5Vu1P0R3lsaZVqbdBj5QmJgl1gFVrdZ1IRnOhiRjmNgxoxj
 cUUi7H+Ae9vyjGNz9NWo10ftSAn9U9pMA+cYUH+DGo3UtnS2AWhd2M3a6qnkEBtE/hqnKNiScy5
 AA62VdpPLir8vquK6qzldT5gANUw4RQe+Pvc0FCJzefdcnr8aUZP5HKJlYDAqXDMB727odDWa3e
 jwtkSNG29BN9bw72s2lv+6nAp9paHKpA==
X-Received: by 2002:a05:620a:2806:b0:93f:1936:b20a with SMTP id
 af79cd13be357-940ef9b179cmr1654856685a.76.1793129078999; 
 Tue, 27 Oct 2026 12:24:38 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:93f:1936:b20a with SMTP id
 af79cd13be357-940ef9b179cmr1654853485a.76.1793129078489; 
 Tue, 27 Oct 2026 12:24:38 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm25829189f8f.18.2026.10.27.12.24.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/59] docs,
 tests/functional: Drop redundant CLI arguments in imx8m*-evk
 invocations
Date: Tue, 27 Oct 2026 20:22:49 +0100
Message-ID: <20261027192341.9197-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0fa77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=FRSEYCzRAAAA:8
 a=E3Kq4i6MJonbbSQa9EIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: CYWYdZAsY8NBC6Bg5CTkFcDXRiJwmLoo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX1Q31Z9sS7X9F
 C+UmORisYiP6Eq2wQJcWomk6ZOBhNm5BpRamVj8RgFaP73mk1dvYdNqMkIgV/RlE4pWlmK5BP6D
 HCiLXON+AcncG1XyGyEVuVkkJEKHXfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX9qGjaWJ1Tr3U
 gMV35yyDptrcSHxhPrGs2sekQ4LkWVDMmZ8ljDc5bMNzODCHE2c8rVutkrJiJHwF6pWgIlwpVUf
 MKrIhaZKowO9Y97hJFEgZAkomQI/AzmsNMCAzuTHg9nh213rpEhqMiBLZGyG360x9tO7mT4gIsn
 YB8O5LF5siu+FhaV7rXwvNuqwWAQcdVw/Sa6AQ+ZUdkUL9KSorDX/lJM1dZjkrz7kjOAloNwwVy
 QM1XI+XO/hBPpSkFb49TI8XJcXGgyZP100Can11iOGeJGduR+PHVdzDTR0I+DZlabi+uWktTjNI
 COgvE1+BeBrIuo15qkLi7e1rSTtY4pCXa1dqsWjwonhJBMMyQ9qZMCkGo26TuGAND5LJcvm5UhX
 tpu9/7hVF20ZP1gpvDAygNRyu3XokBY5GMeDvfMw6UnjIT9FXs4xV7D4o1LCQ7oaxLs1Qbg/4kx
 eNe/okAnRtQzSKhb0sw==
X-Proofpoint-ORIG-GUID: CYWYdZAsY8NBC6Bg5CTkFcDXRiJwmLoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270077
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

From: Bernhard Beschow <shentey@gmail.com>

Both boards provide defaults matching real hardware. No need to ask
users to repeat these. Also, remove these redundant arguments from the
functional tests such that the defaults get tested.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/system/arm/imx8m.rst                   | 2 +-
 tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
 tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 1bcb8255be57..5348757089c4 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -79,7 +79,7 @@ For i.MX 8M Mini EVK:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 2G \
+  $ qemu-system-aarch64 -M imx8mm-evk \
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mm-evk.dtb \
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
index 86725991f147..73d286167c55 100755
--- a/tests/functional/aarch64/test_imx8mm_evk.py
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mm_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mm-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
diff --git a/tests/functional/aarch64/test_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
index 99ddcdef8350..2ec421c32632 100755
--- a/tests/functional/aarch64/test_imx8mp_evk.py
+++ b/tests/functional/aarch64/test_imx8mp_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mp_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
-- 
2.55.0


