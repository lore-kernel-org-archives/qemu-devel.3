Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CF606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n9QFYysx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jdATA9P5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWhud-0007w5-S8; Thu, 26 Nov 2026 17:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhua-0007ro-Bt
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWhuY-0003ph-KN
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:25:52 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwmOJ162587
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8G/ur/H8JjVUicQENqO3IPR5zu9pxivVsVGhfwssq08=; b=n9QFYysxB5vJEf9V
 eB2mESU75stUtpTXUZ+NbZ6WJRRqt7bO8Mkk4bFK2cL6j74q7q8pER9aVXXepP9O
 TleuUp0wyCNr0dOK9Vsr/yY1X/qqgbOa5/gpTUpEBT57gYa9uU2XiMMYEaTlZ+zv
 hgJ+Xn1ySzB5kFfcTTwGY4x0bQZcWeLFCMk3xYjWkntRcz/LRpLBSmcfhiWupk02
 N8Jc7X5IkgXtzR+2mtZ1eGpb8PFwOBd9b+7KRIiJjPSg2X7RtMtyVxsdT2UVRTpO
 qnpShG2h6Tv/tNClt+jdiOAO6p/5a0YAR7N3OK8ZO+lVRQII+dWsfUH8YZQuq420
 JxCJRA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7gamvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:25:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9211d51dcefso135103296d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795731949; x=1796336749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8G/ur/H8JjVUicQENqO3IPR5zu9pxivVsVGhfwssq08=;
 b=jdATA9P5s6bWSYM283ad6HBdKx9D4hCLFapxM/ISL5sTlgJSzxzVYsVjYPMTxk3ARi
 8HEwmZ6MF7INWa0idKRwEYD/+AvWGNHdjJdfIaDXHQdvn4+Elrs/Q8uJqD9qXcQ6csaX
 /Mge6jI19atwEG3cRpDcJUzGtjbs19vj8z21DQVXm7uUm+OSG2CQyl4i81jeR4jmH6Yy
 iwtYri73NLpLvFcqIXJC92PQxdatnGIx7kvrLZrBBt0ZWu7hoFDd1nPjccb/mdHZeVer
 tUqbdp9xj/hG9D4A8tTb7OTY09pmAzt2/2+ChgeUkKrCK6COIt7ulQWL8/byn7W4vKdb
 bxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795731949; x=1796336749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8G/ur/H8JjVUicQENqO3IPR5zu9pxivVsVGhfwssq08=;
 b=qmz7LTxZAwANRlnZsHR3gUGOMJ1oNrakK6fMeLK4+mJYPqn70lgDC7MKUetuqz1tf4
 NSGqZNitgcD7Uw3KzE+Jf6wb6SHAD6IaAex5e4ziFUqUBOatIWJ+WHR+4mPUptlfOj/p
 EIURDTSHj3NDAJS8qRsV/4wgtv4erycbHmSAy4FcI4m/jaehySt47xXDIUAMq85w/BVY
 fVC4i/y2z7Gmd2UjZOlbaSiglMHTi4L4PcIg/J5XKs0StzCHIpHZ+32a+/ER2zivyrIJ
 0rEk/Xwet6vi6K+TCjEY4o+UyjcnOGQ5FEICc1+UR+UTm4SVIIfZLF67tt57dhycD2rv
 yU3Q==
X-Gm-Message-State: APuU4Z+knWyMF6YO44W7JgFXVSHlcD0feytC+v0uz5IZOmQS5Z2HKfs1
 clBc8PlAacatNMdYmjb43frUiwSznyB4xezCFYqqbHAOY4RmFjMCKxGpWSJ+pSopuiLtNcBeRUv
 Ns87X1feX6dfvEZc9BpkQmVmRd8VETQyCtRBv3X6G4qZGU95cUcgg5AzDNpF9JgE0SA==
X-Gm-Gg: AZFdTZciWG/p0UUpLZoMYZ7ZHVMt5OxeJY5ZMLr8c1iWJi7sc7bMPsXcPRYJUS2t54e
 LcOmeywKAqRHnmjQFTnoNCGFlQ9bd2Xe7MuiC4RDYRfZREJ2GtesXtpJxjbkLB+d7hiWBln6oFf
 k0IFvF1+mo3p1Fyfw1M0pgSsJySyJ0n2IbROVpS0awEUGSUFM+7S2P2tYMJ/pwJc8kQAqVGGkZi
 3c2gK71w66Ronl/kYYpL01zMhd5fy7ygO6HlXz3Bw3XmejDgctwOhtl5IvjJZr7Nor1Kd6ooLzU
 spxt0TFQ32Yz5z7/rQCrLjb9+3YQO50VRidn/vInBVFcAF+rMcIEVQakZMg76+nAs85XI0uCA3M
 +TvKldtO/afLxakYmbvQoF+s3L3af+ii3eojUqFzEY7F0SmDYx1RxAKmH8uXGgXsY0E17bxLIzz
 qeWw9MSi8XtYfT5w==
X-Received: by 2002:a05:620a:6910:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-949bab2a96bmr4052170285a.70.1795731949141; 
 Thu, 26 Nov 2026 14:25:49 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:944:12d5:fd45 with SMTP id
 af79cd13be357-949bab2a96bmr4052167585a.70.1795731948747; 
 Thu, 26 Nov 2026 14:25:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm43122109f8f.51.2026.11.26.14.25.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 14:25:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/3] accel/tcg: Factor icount_to_virtual_ns() out
Date: Thu, 26 Nov 2026 23:25:29 +0100
Message-ID: <20261126222530.62175-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126222530.62175-1-philmd@oss.qualcomm.com>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p_Z7Xf_DB4KvifthYF5ug29j71cbnTsM
X-Proofpoint-GUID: p_Z7Xf_DB4KvifthYF5ug29j71cbnTsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfX+tDuUyVHC/Pw
 94CW5MLD1JqWgWMLvpkGqmW1R3zUFNRfNROHTakudpThH1726rP4G1PL1RpnEIBnZ3yLn9CfaWy
 ZXbVzjafiGpnrDZAAYlam3ijfw4WcobxNimZXjioWJuDlpNsuKob3R2tiQADwy6XWwbv5/sypm2
 uqIptkFI+ZKlT5IY7ug8PnqZAskL8+VwC1ffr7Vrvr6qukDNWnzT0rOSbO5Mi4sEf93Jj/N4bBJ
 IBgIx/EggCS6Rmb+UCCkE0J0X2jFHachTXUDkT7AOUqC0D9g+8ezI5g5shWVleoeDq9OauPwaS0
 IE1JDth3VC6hs0rdteYhugd38NWt2fZoA4+EYCdMYMvYAa+w+4W4c88PLBVKZvJSuDL/fRffKHE
 tqqQy9Itvmh1+3zS44TQxmGbY47We+8Mv1wliExwWBh8N/on+hIYpVuDChOacqxz1zLxnE4WMyQ
 XDUF/EFFNkeIl9u5pQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OCBTYWx0ZWRfX3+33doGhxXCN
 kWXegmB0iEXFJFQ0TvYGRrQbmNrZpef8Sb+etZraQfoLnChi1hxh/b3/t3Qd1tZmO6Qmx6FPJ+p
 bV1Aqz3bKs6dWyZGvlE7wsulAbfj5e8=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b08b1ed cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=f-NT7oDAcE9xrb1U978A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260088
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract the QEMU_CLOCK_VIRTUAL computation from icount_get_locked(),
to reuse it in a following commit.

No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/icount-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index a11f2397489b..b52d22f3a1cf 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -119,6 +119,12 @@ static CPUState *icount_running_cpu(void)
     return cpu;
 }
 
+/* Convert @icount executed instructions to QEMU_CLOCK_VIRTUAL ns */
+static int64_t icount_to_virtual_ns(int64_t icount)
+{
+    return qatomic_read(&timers_state.qemu_icount_bias) + icount_to_ns(icount);
+}
+
 static int64_t icount_get_raw_locked(void)
 {
     CPUState *cpu = icount_running_cpu();
@@ -133,8 +139,7 @@ static int64_t icount_get_raw_locked(void)
 
 static int64_t icount_get_locked(void)
 {
-    int64_t icount = icount_get_raw_locked();
-    return qatomic_read(&timers_state.qemu_icount_bias) + icount_to_ns(icount);
+    return icount_to_virtual_ns(icount_get_raw_locked());
 }
 
 int64_t icount_get_raw(void)
-- 
2.55.0


