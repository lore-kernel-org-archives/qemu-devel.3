Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B6ECC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g1-0006xC-TN; Wed, 14 Oct 2026 19:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fz-0006wT-B5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fw-0006QN-PG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENRLNO586467
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yqurs164a/V
 ICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=; b=IxcjVtNFof43sJOlhJRQwaasSFV
 VB3qAOH23XUruPlrkQQP5Wn+pZjXQreLZyn9EUqP1yeCngMfPsQrXosS8dLwUzZa
 D6/YuoDrsa7bCm4TobffHif8aUjtoCu9H/Fsm3A0Anz7AN4rsw5NTPGScjFbCCdD
 eJn/S4F7BM7Whq0WjImcI3gyYiD+TbaBOKKHMRZb14qvQ/mx8RLcqxyOgZhRrykU
 FDG/JsH9cThxZJKaCUersm94RgiW/dGbCUUwN+UkmNuHSf3XG/vFebAx+wh7JOQ9
 nRnQXbDHpwAKNEhv0sf9wyK5qCduAFiacfIrFDygTeAgMICF6ClSx5fBzbQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1wr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3592749a017so1467913eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021583; x=1792626383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqurs164a/VICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=;
 b=aCySNZme7FXSFXxTlgUZCSV9LMqOq+jZmO4eBGtt34DMrA7EXBqWF23trCB0RxF4ri
 ueqgAzjrDhRpgND5U2TF3zU49kKjC0fn+0bby8zXUVe0/U6Qk/BIGVGaZ8pilvF/oMar
 6rokfnaKhdj4rZ3LQXYy58isNDf6Ob9cbhkeB8byf9BxULQickZ+bYwcTi3NzyzaSurP
 WgpP3figJpDfbnDHTE+h0rWXdNNWWYOJRIoJBOKxKKv0BrmVExJqRB9pGmrrfETj2IAc
 cW6dgKVz1Wish1JzFgl0s2XXRgnsiq2kGrXljiU+p+CnJd3MK8Q9OsntfVG+PrONGIK0
 Td/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021583; x=1792626383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqurs164a/VICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=;
 b=DFZ0u5I9fP9Tz78KDhvrBC05fdK2ZtRMn2VeNvg1VPjTHsg1cSB4gRsoDwAm7LEkgz
 4lttfXkvKSE7Wg3trrVCU0fti89RJdID3nTbG+MbSaHtLvnM5eLf2GUgb2yWU4YXoKfu
 1zicijMYDpviZGA40hukrMUT/EjYV23b5/ahdX/LTXATj1HM8p+oMyTlQjlqAGB+dYq+
 4ABH9jlSspKfB/H/LtIfzBw0+HEA7AVmRP7xjVS0o84P6xX1hiwm+7bNHSI83Hw4PxFb
 coEuUdOy0812q0682+g+qoEcrLxv759R8UdIrpp8/je6+qtjSC0I+qtd8AQnBTBx0WJv
 Xykg==
X-Gm-Message-State: AFq9FYKtQwTFfojBuQRzn7lVclna893eQHoI6KcAu/yzNFlloQnz3XPN
 5J7syvMFiC3iIbczS7YfQYr6i1zHjxxrEo3Qp6EOWKSaN7PvwfMtilKR2ZCPL8LrKVQ3dw4ZB2o
 5JSBQJlXpyfQos+etFeTWnnFZEHOUWl3yUwC62I/408t7epQzTmBe3pSRL+umMHx7NQ==
X-Gm-Gg: AYBFou3Y9xZ3vgUfV6izoyB17iyXbDE33OWu3pQ6iR8Yvsm0I0FpYHS3u6UNYX2wUj2
 6Fm0dksgC4cD4WIrdWEJ0iL0Yl6Pvhnm9+9k89KTJWmypKCZwTd1dEXWbiiSu8LXEyRfWEnyeJ1
 9zKVh98T4AfQeZABYiALXKg6Y5ydpnf22ia7pp/6RaKfcZkCQ9Lif7nXisLsfk44TV2eumCtF2h
 oOw/ewnvXemNm34iB1OCNYyPUW9boy0egSPf407mMQ6rZebq4YdyVjvXldOgV8X5RJpFAuTn5BY
 G+hZSbAA6TJh1S1swVmyERmMZhgTWkgum5S9M5KJdU1K/UvxGQ405fmbD4zJXBDCUWfHdplY2B4
 Onu0Z4qsl0pGtAzRtEwibeu0JJommc6bnkLNL4SQj/FvfBqKt6UPhn6g8Tz8K
X-Received: by 2002:a05:693c:8819:10b0:35f:4948:c13c with SMTP id
 5a478bee46e88-35f4948d20cmr245843eec.9.1792021582864; 
 Wed, 14 Oct 2026 16:46:22 -0700 (PDT)
X-Received: by 2002:a05:693c:8819:10b0:35f:4948:c13c with SMTP id
 5a478bee46e88-35f4948d20cmr245817eec.9.1792021582359; 
 Wed, 14 Oct 2026 16:46:22 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/19] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Wed, 14 Oct 2026 23:45:50 +0000
Message-ID: <20261014234605.209084-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0144f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=3tol9ANpHmc3mX4GjWoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: bN8m0oPreQzZaCyj4yAc_QghgBFtF7e8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX6lWNIOJ1JvV2
 T8h13+kWxEaBMJWLLVrcEu10OO2wzfkWGkqIkPMO0BwaJ3qTYwd6LLtacO4eHbnSQ/TYeWcYVvG
 aDrMNbLFqIQi3YX+zPvnyDfSpy8ycWQxAUx4gxDcWtpvH7WJwiyaLRtQqYjPLHOJgmE0AD0jpvJ
 5gTlwVDPof9lnjLNXhyU6uwHQunLrOf5hNOMi/F+IKGdXYD6YL4qIfPvF6lj4lRvYj3BqFX7w5s
 ZCIxlUj3MKSQZAetHg4Aolq6v6Wn0z5ZsRYrSoRCb0qgNG7FnL5yjNAfYw2fZfhFwwJuFnBJHMl
 mEOc7JviVf/R6golBwiLv+u2ZnTvAXYU0P3XRRNgPoLOE1q1z+Htcu0ZZBJfuOteDl1J/wi9VO7
 2mzQ3HUAwMt9PF6IP+DAg08h7Pu/MKekJJI1CESOEMF+RgTtfnJKo5KdkNHpctvIf5IBZb+P1N1
 1Y2WeXiog5hr5Xo2iWw==
X-Proofpoint-GUID: bN8m0oPreQzZaCyj4yAc_QghgBFtF7e8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXxooxD+CWi4eA
 TAw0eXFocWjyHaOmLIIgjsMFqyjo6ReNsxEhIk7BF1H0FtH8yKtVAS4bOVEBjgtaJFPtAQBH9ka
 dDXC4yh2YwTs3QeuJWq132SVOCEevEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..fbffc9b3005 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3048,10 +3048,10 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
-static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
+static inline bool ppc_interrupts_little_endian(const PowerPCCPU *cpu, bool hv)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CPUPPCState *env = &cpu->env;
     bool ile;
 
     if (hv && env->has_hv_mode) {
-- 
2.43.0


