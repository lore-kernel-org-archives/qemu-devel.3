Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91E606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgyjEfI5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVYiga4O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpv-0006cp-JW; Fri, 30 Oct 2026 13:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqov-0005pw-EZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqos-00082N-JC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERCOM3515438
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zNT2nx81bVOW17acmjHr+AdOddr+C76UPQEnes4fLbU=; b=NgyjEfI5pEx8KvrZ
 h5p566B1PlnPF4qOc4gN7C97QKbFIgm8xYxULZOzTCwLeFM83QUxn3cPHRAzwr45
 4MauOKDJe+nj2AKOGTy8bR7jmJ9k4txtoWA5MpfC2P+3MIE+/kXd+YN0j49HacQe
 BLzwzmMZp60lQt1CtaQ2x9iZXdwe/wDGtn8QP3NFUUlwhqWlzjrTcNtcF2pswQJP
 /xZYqHvau4d5vt/qA2c/Wz0KciIO7d5haNdAn2PWa7ZIc4GdkWUynFL2zco802Xf
 haFhMhDeJ53vgnZ3WObKPGMLFiwL2gGp9ygkmEE1eCauMxvCRBuhVHjE1phs19tL
 qBr99Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmcuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:55:12 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc175cb172so762716137.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382912; x=1793987712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zNT2nx81bVOW17acmjHr+AdOddr+C76UPQEnes4fLbU=;
 b=CVYiga4OsYSkiJZTHgKg5G31ZLBHeunZanDkIW0iWLITCPMrXeIcgF3HNlwSJZWWsU
 RtzgstHjZs8T3PhLeiNNnkn8AlBJneMhgDsXBZsOG/iho3siy9EIQFYhZucIIt2x3a7I
 TbXh4cJ3DuOiX94rRp8Tmcrn/+/OF5sS/BbEXcjb7mvhzMFR5I0mtFihHn2B3trxX+15
 HI8Iqm84RDXlIPkOq5NPOt4seHt+2k8NV26ldhvkU0458OhSKs6y+0nQd/C4yGxBBGcE
 T6QGABXLAKMTStO1fjFFb+Y3JhCAdY/KCKRdOvla8ufP6Vn5bXkNpSGHNKdmawrhaDGO
 wtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382912; x=1793987712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zNT2nx81bVOW17acmjHr+AdOddr+C76UPQEnes4fLbU=;
 b=ZZUvsqwqf15JXEst53VfEFUNSgthUlelGQ4hTLeb+tBDm+Efdnj82xtJ8w7ZI+8O/g
 9+kC+Y4/zefxk1eCB+GkaFNb4E0Kp3bJLeUrWB6ivHnXF40hBBd9YeQ6H/P9ixePYAsR
 O1m4KBoPV5HGKTgUdgZvdifHKXpcsU6d21tFPZx9c8iyoPi+8K0jFRtGt+FFzVPsytgs
 M+Tc/vUggF5Qaei73KiaFaUJvRtQK5IKLJnmWdN8hoMMXnTfUXa5Zl3yV8zGiVjyaWCM
 /DCOI6eOtByO7QfkoIrbmGCfuVDpb3ST2qhXZ36GDfdJGfCtut+uJpNLsVaph/+Oh8Zu
 DmwA==
X-Gm-Message-State: AFq9FYKC5FWc1gnYUssMcqwxlvIU7ZOyLR+Sj+2c4ac1gO1HKak5UeWS
 Bshm5BeUvoMXGelbTfHFZqqHom9QtSpKI8G32Jo5NbhcWSCt92vHXC0mVse58scpGCRy/b2lFOd
 2/HIR8qvvkZ9QfhYuZPtXSXlY7kLR7yBjjg9VlNxF8mJ6CK+IhRjr0+AwB5O0D9MSFvw0
X-Gm-Gg: AYBFou1rjkWwosD4jhrt3RFU+jUN6PqnWrIIjJGOcnchYnBVXmo9nI0p4WDsz+oi33y
 V3b4Ia2lvfSuY0j/urJs86S0vKYwA/saK2+CByW7FLvQaSQg1nN67tNr/1O6CA19VTWmnTiEPMg
 G5tmyg/SfWy4vwiX9Zb2Fba7naePi4O3gBVVRqs+BedMdbz14PfDbVReCw6g8QmoMSoLTN/bBb7
 oGrlJhBVHrzTt8aNQEoKhwdW6Y+2XFz2RDgFS/2x491wR0d0QHwh9iJ02eUNJpIOb5uEU9YcvS3
 OqbTTjVXp2MJ9/Vce+X27LuJSVcbclfBnLXtkUxVh01g6LM72SatpjdiT39EvWxddLAr1pQEBEq
 Qzjfca24XjYpO8GfFibfqsIvixRvtxy2qnOEF4D95wXmE/x/dvFyL80mq367/OIyEGEET8l9cFo
 CG0Wp5fjgVE/9MBQ5d9lTH1DvlCoX2wg==
X-Received: by 2002:a05:6102:3ec7:b0:7cc:1967:5e3a with SMTP id
 ada2fe7eead31-7d072740592mr1734225137.32.1793382911417; 
 Fri, 30 Oct 2026 10:55:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec7:b0:7cc:1967:5e3a with SMTP id
 ada2fe7eead31-7d072740592mr1734214137.32.1793382910859; 
 Fri, 30 Oct 2026 10:55:10 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e77409821sm100762f8f.0.2026.10.30.10.55.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:55:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 09/32] tests/tcg/mips: Group DSP shift tests
Date: Fri, 30 Oct 2026 18:53:31 +0100
Message-ID: <20261030175357.99684-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yzhkETBzc-v1DjDj50vN3U_YYu1vh8yV
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4da00 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PBVPcx0-DJstsYKfvf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyPy+sFHRPm5Z
 vS2coovuwDU20Iurpv8h2HZLRNiPjGRcqKeZ496fyJziN4BbNnLDaRtoeBwHdC4RIASguUuHQ4Z
 I8OKtutnd79o6E3LAopj5zeSaa0T4m/DS4fBoTqNBXbsmF3WNs8EUNLHoJsY12Bhq5BpIoBRokB
 4UtGEXjHKPvx5iO3c8FyzpQuq/ox0Ve7s3D6pL/CbSjU0C6DAgqlz6XEJEf5wATX8ZJZgr3acum
 wM4t1N9lEJ/Bw+znnlDexi6rEpxvmPJjICZ9OVFAOCTxN5DL7e6jUcncLPkTQqOI/mzqa0mesnF
 Ax8LGnEk7y4Ih6kSVmQ0k8nYEVi83VI7NsMH+J7MbZfAuKb58tFklbIKZwmONBS1bNX92TOfw2c
 J7DwfnI6xsiLbLdlcy+ipvL5NtWH2PKLaNJCAlTtSlZHUaP1VJSQNbW/4aQ62zZvAou0cRsu82n
 YYV6xg+SvOoM+ksZy4w==
X-Proofpoint-ORIG-GUID: yzhkETBzc-v1DjDj50vN3U_YYu1vh8yV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX0VoN/nwdaW3P
 HO+beDwfMzzMEMIIqd59BeoIiu/qmfg1Zcmrqq6pJ7CFzdIuUmthfh1/w9qxB5f36e/TJgDs3SH
 cQJZjwIsDx+eVdgnAsC6YYHqO+F1fHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

Build the 22 per-opcode shift tests as a single executable,
test_dsp_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All DSP tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_shift.c         | 124 ++++++++++++++++++++++
 tests/tcg/mipsel/meson.build              |  24 +----
 24 files changed, 126 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_shift.c

diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
index 5fa58ccf6374..336ef50ca8a6 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
index 729716d62618..60cd916766ed 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
index 910fea3b317e..833b1d5673c8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
index 628c7521027b..1848afb21323 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
index f98a6322dc1d..bc1664d70d12 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
index 6d8ff4a259ba..84600fc7fb36 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
index fc9bd32765b8..4c84f3b94164 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
index 350c25617adc..5c06b4411a0e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
index 5b2d840a6bc5..38fdc66e5b66 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
index adc4ae68bdc3..c838f8a32fe2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
index ec0cf2c72ccb..d722cdecd166 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
index 6e42aaf8e1a7..c2cad6e67309 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
index f03b978d0544..ec2eea36b947 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
index 2ab03bb5daae..af50a92af2a9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
index a7e4e6a5e4f5..bf6fab4ceb81 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
index db77f6d0e117..99d7aba6dde9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
index 48193de87ad0..d4ca7430fdba 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
index 29afa0e4b07b..08d22fd4cd6f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
index b21e1b7ca64a..5015a124b89d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
index 9ea8aa0cbb90..1bfc66ec3676 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
index 724b9a7a4691..ea53113568e0 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
index ac79aa69acf0..40edd7cab67f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_shift.c b/tests/tcg/mipsel/test_dsp_shift.c
new file mode 100644
index 000000000000..5b1884188587
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_shift.c
@@ -0,0 +1,124 @@
+/*
+ * MIPS DSP ASE tests: Shift instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_shll_ph
+#include "test_dsp_r1_shll_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_qb
+#include "test_dsp_r1_shll_qb.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_ph
+#include "test_dsp_r1_shll_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_w
+#include "test_dsp_r1_shll_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shllv_ph
+#include "test_dsp_r1_shllv_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_qb
+#include "test_dsp_r1_shllv_qb.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_ph
+#include "test_dsp_r1_shllv_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_w
+#include "test_dsp_r1_shllv_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shra_ph
+#include "test_dsp_r1_shra_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_ph
+#include "test_dsp_r1_shra_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_w
+#include "test_dsp_r1_shra_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrav_ph
+#include "test_dsp_r1_shrav_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_ph
+#include "test_dsp_r1_shrav_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_w
+#include "test_dsp_r1_shrav_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrl_qb
+#include "test_dsp_r1_shrl_qb.c"
+#undef main
+
+#define main test_dsp_r1_shrlv_qb
+#include "test_dsp_r1_shrlv_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_qb
+#include "test_dsp_r2_shra_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_r_qb
+#include "test_dsp_r2_shra_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_qb
+#include "test_dsp_r2_shrav_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_r_qb
+#include "test_dsp_r2_shrav_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrl_ph
+#include "test_dsp_r2_shrl_ph.c"
+#undef main
+
+#define main test_dsp_r2_shrlv_ph
+#include "test_dsp_r2_shrlv_ph.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_shll_ph);
+    RUN_TEST(test_dsp_r1_shll_qb);
+    RUN_TEST(test_dsp_r1_shll_s_ph);
+    RUN_TEST(test_dsp_r1_shll_s_w);
+    RUN_TEST(test_dsp_r1_shllv_ph);
+    RUN_TEST(test_dsp_r1_shllv_qb);
+    RUN_TEST(test_dsp_r1_shllv_s_ph);
+    RUN_TEST(test_dsp_r1_shllv_s_w);
+    RUN_TEST(test_dsp_r1_shra_ph);
+    RUN_TEST(test_dsp_r1_shra_r_ph);
+    RUN_TEST(test_dsp_r1_shra_r_w);
+    RUN_TEST(test_dsp_r1_shrav_ph);
+    RUN_TEST(test_dsp_r1_shrav_r_ph);
+    RUN_TEST(test_dsp_r1_shrav_r_w);
+    RUN_TEST(test_dsp_r1_shrl_qb);
+    RUN_TEST(test_dsp_r1_shrlv_qb);
+    RUN_TEST(test_dsp_r2_shra_qb);
+    RUN_TEST(test_dsp_r2_shra_r_qb);
+    RUN_TEST(test_dsp_r2_shrav_qb);
+    RUN_TEST(test_dsp_r2_shrav_r_qb);
+    RUN_TEST(test_dsp_r2_shrl_ph);
+    RUN_TEST(test_dsp_r2_shrlv_ph);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 247db7d10d79..9e446eed0f6e 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -11,28 +11,7 @@ tests_dsp = [
   'test_dsp_dot.c',
   'test_dsp_mul.c',
   'test_dsp_pack.c',
-  'test_dsp_r1_shll_ph.c',
-  'test_dsp_r1_shll_qb.c',
-  'test_dsp_r1_shll_s_ph.c',
-  'test_dsp_r1_shll_s_w.c',
-  'test_dsp_r1_shllv_ph.c',
-  'test_dsp_r1_shllv_qb.c',
-  'test_dsp_r1_shllv_s_ph.c',
-  'test_dsp_r1_shllv_s_w.c',
-  'test_dsp_r1_shra_ph.c',
-  'test_dsp_r1_shra_r_ph.c',
-  'test_dsp_r1_shra_r_w.c',
-  'test_dsp_r1_shrav_ph.c',
-  'test_dsp_r1_shrav_r_ph.c',
-  'test_dsp_r1_shrav_r_w.c',
-  'test_dsp_r1_shrl_qb.c',
-  'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r2_shra_qb.c',
-  'test_dsp_r2_shra_r_qb.c',
-  'test_dsp_r2_shrav_qb.c',
-  'test_dsp_r2_shrav_r_qb.c',
-  'test_dsp_r2_shrl_ph.c',
-  'test_dsp_r2_shrlv_ph.c',
+  'test_dsp_shift.c',
 ]
 
 foreach src: tests_dsp
@@ -41,6 +20,7 @@ foreach src: tests_dsp
       'cflags': ['-EL', '-mabi=32', '-march=mips32r2', '-mgp32', '-mdsp', '-mdspr2',
                  '-Wno-unused-but-set-variable', '-Wno-unused-variable'],
       'qemu_args': ['-cpu', '74Kf'],
+      'protocol': 'tap',
     }
   }
 endforeach
-- 
2.55.0


