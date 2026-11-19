Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3D606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DbUXQZ/o;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aNJnebXb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUANm-00063L-65; Thu, 19 Nov 2026 17:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUANk-00062J-D0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:13:28 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUANi-0006vK-Gw
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:13:27 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Doe3594961
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7vTf0EdFSHNu35rC/vRh1h
 LTVxrNw0yeljN5TDsRsYA=; b=DbUXQZ/otyKpiQcds2YGmd4HGjPvXznM1UrptZ
 D0ZGuxG1I/SieJ77tU/Xt9ZAIiXRTbAzRCqbqd2PrIwAN2OqnPdjq/zzpVZUH+8i
 kCEJ2Ujc14ESH6zLacHr+0rXyE6BH5mgLNF3Sf16tv/tY8ETBnzTwRJX7RiKMc5a
 e482+1wXNRdlfc4ZSi7Fo6RBhBynaJ+3Gby9tTeMJi1WSWXrOzEmtgXz9Gciwcim
 0u7wgpkmRuAcced75RQWmA/+HVFl2SOA2PD34S37qUlc93pgbPxdzHwtj7YLXUag
 //5qYbANq/GBFFvgY0cS6Tr26KwgFFgn1gsyIVnvBRmakC0g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255whk3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:13:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so52644985a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126404; x=1795731204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7vTf0EdFSHNu35rC/vRh1hLTVxrNw0yeljN5TDsRsYA=;
 b=aNJnebXbaMYA6ZeKQQGC1rXK1PfXvEr/CEk2EGB90lr1g1pmBBh7QMUV08Lw7LMNuU
 dOQ61p27K1TlatM33vKwaikiT1YXt1vd31ehTpht/2owFP/ituJO/MPG/yh7wBhX4BII
 rmz9rWdvbvUZIW7Cj/BSTFlaJUFQLVdaxMRpzN592zpWAcjIRtfTgpSZOti+yi7dvhin
 VY/CTv7YZyLlstvRur4K53gXp+MSTZbPw6h5fdDIYaYLulH+KZeg6EGb4V6NX1aoJj7m
 XADtrvYXWO3b5wsAzHHedAubflUTMTN3sYEtPPIhKr8yaA4cgNvEBNSRS0U4PUlU7Amk
 VYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126404; x=1795731204;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7vTf0EdFSHNu35rC/vRh1hLTVxrNw0yeljN5TDsRsYA=;
 b=Pbs8HdpCJBHeu5jgy1a2y5XjYMLK1ABRn4ntc94j2vSKSvGwHNLZL/ON8odVEfCjr1
 9G9vLs/KcvIRLZ1ySyu+mYzlBAQR1stmqhTk1YsYFlsPDfIdAXjfCr+27c7t27S5A6oz
 KgEGLKXtPRafkcPRUT8naSKjcv8Y11BokFZcC2tF9JoOjioNj6dO0vHdGiQb8O1WpO+Y
 BW6ZU/TLwq6+zg7NsuInhFE2I2TqKkuO6dT+kqVc7LTB7qlS3IIMlkZ5EbYhlKFd43Vp
 wzbSouLGbXi3xR98Z0z/lpjQjS/z5Xf7aBnp9MWQbu5E0fD0UaVfGQM83hh076L13Yff
 E94g==
X-Gm-Message-State: APuU4Z9apBPr8TsOwsHNY4N3PYOyhe+KliPh9TS0322SWOMb9AymuSh6
 bSG34b65RaG4Bh+tNXjt8vSg/ti/s+yoA2CNwSNF2Ndho5uFiPDDCOa0rIDYtvph9fl8LV6RpgL
 pXYj4tFp44MVmO+vFtI7bS97LfbKk2t2ctJJ0V6itG1TgxeCOn6OavqCvMOr04rhkr8Px
X-Gm-Gg: AYBFou3lmLUtyzjBGESbz6NGMwgk93oyJEGVArVJDA7lmqPy7fwsWJ6IdtTSkFZePht
 uZWlWuJtAdH7AjX8sbrmGjD6yw67Xc6TXtCFviNhx+3xyHpwnYB9hSHIhPq0y/mima6nvLy7mVy
 wFJCZn169gQyOnDF6vmxgpfs9130/8npHRLa0Y0/Ga4hoi8nJCTiIi/XjlS40VE179oGMTTqFGd
 7njwiaXU0oiP3qoomzkNNZIfbiheCLeh400nypW2dAdNknEVKtyxGHEiU4H45hqbJ0bt8OdGXAk
 uCOZH0GlYfZ8emxusWfe9fFcBcq/UDuJhbry8JnMVAEQm+/qf1ecqiL6E/W/T5aw3J7hwpQ39tZ
 Ea8BlmKz04tUZ5RDtpGw43+RHQOJCmFLdBYzq7CbV4AVWpSnnMZVrsKQbXuW2I5u3r+coDpL3di
 wiMtgQhMu8g4M7iw==
X-Received: by 2002:a05:620a:3715:b0:949:a139:2f2a with SMTP id
 af79cd13be357-949ba7ccbe4mr186708885a.9.1795126403940; 
 Thu, 19 Nov 2026 14:13:23 -0800 (PST)
X-Received: by 2002:a05:620a:3715:b0:949:a139:2f2a with SMTP id
 af79cd13be357-949ba7ccbe4mr186705785a.9.1795126403529; 
 Thu, 19 Nov 2026 14:13:23 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm67830285e9.8.2026.11.19.14.13.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:13:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/arm: Include the overflowing event in PMU timer delays
Date: Thu, 19 Nov 2026 23:13:21 +0100
Message-ID: <20261119221321.62258-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX4qHyPm2l2CQ6
 NAWjwMFTafC43H/NjpPuVPe6vGhGI/V75vbfCowEhe+oM7u6ulJZI/i8gYbeu7CUrvkgQDf7jjv
 VVneYWaqFgA0UMD2hJ3wY/nWnTuawAQ=
X-Proofpoint-GUID: 4CXWy5Vwq3MBgM-7NjX7Tcg7Rkf1SGLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX/3gR2kppLyQL
 VZJa9/iLWq7IV0/xoND2Bo5mLpApadE2Ar5dv6p1yukHrUKxcPvAfZxvW/Mzl5ni7ZYGO3aNtt2
 pAJiHORIHoEO+sJIRW3HDr+qjrubWhXmEbcKoAGRhEjy5NUdUFllRg8eMR40LJZe2kNeSVlO/Th
 jeIQPYdqW3TRk9+NJCtd4/1zve1HAV8CXyHTKKZBQS1wP9GB0WFT85kq7092QdvMxXhN9VQuWvu
 xzhZUDDr8VRxlgUZcLc1FnmbgWNcNesaCjb6O5tcv9q0EiiKaEdDuBL+cpwuKKBYP5gopN/XO4g
 QFUgz4h0xv3VWjDPhYyq10UdBEqlqMRc3F1ZtHvQc5Y/ycdJPVPaCbRT/87CJi4d9LLw9yDNvWj
 voV9LjCrmnVrW8VgNjIqlqSbSINZmgP6E7xZIkHdRJHUUzkAbEot3mQzs4oQ66d8Og8+twt3Let
 nF3QkTQDFVb+wBds8bQ==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff7485 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dubOzblNFW-RsgxzQYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4CXWy5Vwq3MBgM-7NjX7Tcg7Rkf1SGLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190089
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pmevcntr_op_finish() passes the number of events remaining minus
one. When it reaches zero, the instruction event converts that to
a zero delay and no timer is armed. Add the overflowing event to
avoid the last event leaving the PMU interrupt pending forever.

Fixes: 4e7beb0cc0f3 ("target/arm: Add a timer to predict PMU counter overflow")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpregs-pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 46df6597b1ab..9e27c38f855f 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -106,7 +106,12 @@ static uint64_t instructions_get_count(CPUARMState *env)
 static int64_t instructions_ns_per(uint64_t icount)
 {
     assert(icount_enabled() == ICOUNT_PRECISE);
-    return icount_to_ns((int64_t)icount);
+    /*
+     * The caller passes the events left minus one, and a zero result is
+     * not armed: with a timer due exactly when the count is reached, the
+     * last event would raise no interrupt.  Wait for the overflowing one.
+     */
+    return icount_to_ns((int64_t)(icount + (icount != UINT64_MAX)));
 }
 #endif
 
-- 
2.55.0


