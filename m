Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6246606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U1vAWmIV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hCKsgtSS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4l5-00046f-Oz; Tue, 20 Oct 2026 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4l2-000464-V0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:59:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJ4ky-00077A-V3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:59:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tOsV4032275
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=WkU9iZ1+0WVzIYKoUqkhbV
 u9mIoQ+LL0V0jE+7MKOfE=; b=U1vAWmIVo9tXy2oE/LZJDlopErBbrO91LY+BCI
 vHcAAQVpn3S3qCdmqoeDOs/g6bnv9pLBQONHHCvZM4xRVcMTRQXniuV4FQ+JV8Ad
 hSRucej4RmuQppVXweAji1zVgs8F7u6AkTKA3X9WxKkzqjeZl4wlN87zk/jfmnqo
 BxVEoqqmuNZiXPlbnC+T5uW+le5baqO7bu/aC6opOVmkSEdQuKF59Ab4vQCpV14K
 YLrskheBrw7aR3V/birn5zvSNxw8M/SrsctW7Q1SebMcRL2nCs+uyhQeUaOB8r4i
 H5d8P8gvnOwm4P130VBirbdfK6wZIkPL8Y0RK0uw8eivKp6w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5q9fg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 07:59:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91be1227fdeso58727336d6.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792483170; x=1793087970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WkU9iZ1+0WVzIYKoUqkhbVu9mIoQ+LL0V0jE+7MKOfE=;
 b=hCKsgtSS3/fTj8yo/DeaLPXg/6KyiYJu8J0fVMkyYVdmG8w1J8/W6gSkwKbahGPzW6
 h5HvINOegZyKfjP9lgh1NZG7RzXHfxgPOISXxx9zAsCwwX0IdZaMoMwdAj2+q3I6InuT
 Dp1KeAtMF1X5frDd+4gfqdZ4lLy2B0If7X9YOXpf6kLk+Z+iRzDMjA+8uJBRH5voZ2gi
 KXlVNLtIxqh+0e3lSAMeX7phPoNz+HmgbzxdopWf/FrSMtLilmvXIKYXNrsYcUdUsVd7
 hb/v4aOeTHHMLhhKA1aV2v9AkL6Gc/g3dNFSWXggQI6kp9A/spSOWO4EV4o3HGNKHyAx
 NLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483170; x=1793087970;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WkU9iZ1+0WVzIYKoUqkhbVu9mIoQ+LL0V0jE+7MKOfE=;
 b=LUzOaew/5Cc2t0w1W4rlyWbLWe/NiweAcnox5qG6aV192W4d9D8uvaaFq9RKYTXTgD
 N35gcGttPnp5h71nouki/QmECy11oqW4Dg9oAxBlcm79w83VSTl/jO9ECZAVBb6U9cGR
 HL3MV13eesi9FC/1qqyo3wruSI7cyhzGOaTrC6CZdQclIGknbxFd6qpJR3+41uUHhFz5
 uKxU/uBhTy8rWydYckT2vUMvwd57dND+J25828JsuJyZ4t0xPj1QDKmZov6kjZcYbDpH
 PSxicwnWtBLluRLgFbWv39nXfWDh9I4b3ujQBAIS/6o5Be/ZQ+tK0z671299mIDtuFvV
 GUSA==
X-Gm-Message-State: AFq9FYK3AVEPXwzNOEIGhKTcpkr/GfFh4Xn3Lot9yIGUUi1OZf3ueu3X
 h3pwpzgby3VMIEfq/qnGSOlQor2s58Ec2ovXo6pQv1pKDFgHV/HQchmQUvMAFpbl2BpG2BQ9O9N
 ECqN9jBzzF6nh7rLGI6QNyCDnJSTcAzTPMYdbqbVbyRy1zPlsHkexQU0M60zWfGzjnyGO
X-Gm-Gg: AYBFou34Y5UTIP8sEu2GLCJAodBK5mwdgsL6n7cSGKF+A6m5yNJIat1oYPh/pYgCN9v
 7eptrk7HgC4bW4Banu8t3vxxt8l14OqGZeTmuJnsy/EHJOb/fJhX0l2uTQlM+sNn/ComLZNVOxu
 71QiCB9NbYxj7ABOUHqRwQjXjOLnNAhAKbdChgtyjxs+M2Zju6gvyXoBiB/GQWdcZfwUFEkvtfu
 YOGxgKMZSI4Abn0CfTSKjOVrVL5ZUBMugzjHFVK1kuvZixREf4CyMIKvSqBzOZotKEds71AiFRU
 xBdMinLSyuYTFSioztzK4E/dK/bNDfo0v3jlJK/kByJV/SV9rM/+BkXCm5mGJNGtup4BkoJzxU0
 Hm0jDlJmd3KqnkfbRNFkruT4VLAWmc02z21XiN6MF
X-Received: by 2002:a05:620a:2588:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-93f29cc95b2mr1660362085a.29.1792483170438; 
 Tue, 20 Oct 2026 00:59:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2588:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-93f29cc95b2mr1660360885a.29.1792483169981; 
 Tue, 20 Oct 2026 00:59:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f3833f93sm28131235e9.3.2026.10.20.00.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 00:59:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2] docs: Move RISC-V 'Z' CPU properties section to removed
 features
Date: Tue, 20 Oct 2026 09:59:27 +0200
Message-ID: <20261020075927.56983-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1hzPHuGdmosX6Cr7Ht7StunYOkktV9Ti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfX+qLRpqvkcCTs
 wVHeGihfvV9qFcRAoOAlHxDhRD2j4liGVJdf1Pdla8japxb4GR76x2V+izshXy2ZuARjlrg+DbM
 NXnlnV7biWJ8fAV2cnwG/mrbHtvYaxrqFuzEZTvk7+HEWOO4IKwkrQvAV8NGQ4XHwc7XXoQHsL1
 n/YmBehx/W5LHNHREvaQGYai8A6K0wwUJKNwpTGFHOtJwTQcuYMH6uu740qvyrw2wOmFvaopR50
 T9olmLO7hGoAVPYyhyV4/c8rj2WrHHNqGi8iyp1hd6/vzbhHdydMocaH7yznao1AXzaNfuCvpC9
 KDK0kSEdP+8iuqAUyCp45jF8xXX+NwFEaxryDQdyobhkRsFxf5cRTkpUwcYutW5vC+jRN6qECja
 xXBhvzA9rvGgYzsbd7k6DkUujhjB92Qb/q4zAZ5LO3cMn5HjHquBERbkJKEw2txQaATQWwL8W9S
 euuiSoc+E0qgiS4nd4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMSBTYWx0ZWRfXytjklkN02h1H
 Xe7Ept6s6M28FJP0d0SxNjZETf1W1VH7b0jkOYkyzxbW/1WL9ZoRlA1KYwLLTMsFfPlhticePMH
 8Kz8OSrjKbHIv+JTrlbZN8c7aWJWr4Q=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad71f63 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=zR6fKHwmc8os2Q75lMsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: 1hzPHuGdmosX6Cr7Ht7StunYOkktV9Ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200031
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

RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
for the release v10.1.0. Move the corresponding section from
deprecated.rst to removed-features.rst, adjusting the wording
accordingly.

Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU properties")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst       | 24 ------------------------
 docs/about/removed-features.rst |  7 +++++++
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..368fa1b4ed3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -349,30 +349,6 @@ the addition of volatile memory support, it is now necessary to distinguish
 between persistent and volatile memory backends.  As such, memdev is deprecated
 in favor of persistent-memdev.
 
-
-RISC-V CPU properties which start with capital 'Z' (since 8.2)
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-All RISC-V CPU properties which start with capital 'Z' are being deprecated
-starting in 8.2. The reason is that they were wrongly added with capital 'Z'
-in the past. CPU properties were later added with lower-case names, which
-is the format we want to use from now on.
-
-Users which try to use these deprecated properties will receive a warning
-recommending to switch to their stable counterparts:
-
-- "Zifencei" should be replaced with "zifencei"
-- "Zicsr" should be replaced with "zicsr"
-- "Zihintntl" should be replaced with "zihintntl"
-- "Zihintpause" should be replaced with "zihintpause"
-- "Zawrs" should be replaced with "zawrs"
-- "Zfa" should be replaced with "zfa"
-- "Zfh" should be replaced with "zfh"
-- "Zfhmin" should be replaced with "zfhmin"
-- "Zve32f" should be replaced with "zve32f"
-- "Zve64f" should be replaced with "zve64f"
-- "Zve64d" should be replaced with "zve64d"
-
 Block device options
 ''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6a9944a0c79..225841bd9bb 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1038,6 +1038,13 @@ initial RISC-V QEMU port. Its usage was always been unclear: users don't know
 what to expect from a CPU called 'any', and in fact the CPU does not do anything
 special that isn't already done by the default CPUs rv32/rv64.
 
+RISC-V CPU properties which start with capital 'Z' (removed in 10.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+All RISC-V CPU properties which start with capital 'Z' have been removed.
+They were wrongly added with capital 'Z' in the past. CPU properties
+with lower-case names are used instead.
+
 Power8E and Power8NVL CPUs (removed in 11.1)
 ''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.55.0


