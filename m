Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB3BC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8OP-0000hb-QC; Tue, 21 Jul 2026 07:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8ON-0000ek-RD
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:12:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm8OM-000061-37
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:12:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARVhP1455656
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=x/dpwD/dIEO2/b4WafLEQq
 0d8ciQocT3y5V1sAKa07U=; b=LQWhje7yumIaBeQPiU2qccVo6bWwsz8960mNih
 hHbm7ZrmIhaaVYg8tLMeJWQyowQ1VFrlSt1BNQ2gK8S/sEFaQXKEAMODPjo5jAij
 akm0rSIWTRuC72wNxBafS6xXA4ubDaF27ViUqPtD2YQ/y6lp+sSt5KEBzzzm8M3n
 sXylkR8WT6RMDv+ViVD2GFtHx/hGfajDkgE1DERKbq9BL7rj43Ji6j9DPoUJr3HA
 vaNrTdsJ1Z+sZCEcsEyIrckhwGfa+7Ta9Nh4rvQhB993o2pqCC0ynPZcq3OddyqJ
 d0PfwrnJbM0eXZuX98APJ45116nimupAmg7s3nM8ShZC4dNg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duhw15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:12:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9077b4c35c5so113395046d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784632324; x=1785237124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x/dpwD/dIEO2/b4WafLEQq0d8ciQocT3y5V1sAKa07U=;
 b=FWw9RH48Jh1Jbh/trRjlTV0hi9scTqg4Bq5ETr544ueF8zvVPNgf0hrBW6njoH3ggi
 JDqgMwtiKuRT0EiyzfEpvQqbbohhnL3V2r4c5m+uy6ZZT8B8as8zvLo2W5Ou0FZzXQAS
 X8RTKki6lVSIG53Q1AjUX+BufS901rcY9HqhaigibxtPuuhyAhXbFyliWU4wnA+pnPP6
 61MnxIi3kjfbqpd40V6g+9huJ1IwJl9NF6BZJ2PzpNQMo7nt3Y6SMlZi6nowRB4G9W8J
 2dIIpZP2O9N7VDX73xEYWEC8b6szcVmh7DITvmJhyJTGb44skkI+l8RQeEAVP0Qobzvl
 f87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632324; x=1785237124;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x/dpwD/dIEO2/b4WafLEQq0d8ciQocT3y5V1sAKa07U=;
 b=bI68kP9DRlE7DybIOywKA2cPXk+O4HaCizKBwp68/i7NGW5Cy6YT0KPOZlF4GM6Axu
 3FtCW6pCk8+25k2mLUQ4OgHAB9UrbA6r4RIhtG5r15NOvOrW4MvYzubf/rZ6xjq5Bw6Z
 ZEOA8W63ipMamWxjtGoMtoMSQ1q3Wr8bojCHMKxWkU0ClTjArc8xHblnffxABJYCvN76
 7PW7SeN2bQaXya1BgKMclV/kf7j4KMUq3eBLeqlAJWzZCkpMJp3Z2tkTX4M8oT5I0+XU
 jM00rmxq+rdSWm+gwXyiuCSdehKXkyoHJIzmdl4HfQR/FfipnDrgYrS43lyY0N7MlIfz
 FaLg==
X-Gm-Message-State: AOJu0YwqTVeSRvNNM2ICdNvtR+zrny4dIYrQmQ68DB4t++KoTOJX497+
 BEiXJtKKTG5qXg0SZii9Zh6hsgurKiUrIb3NFywmOwIvphHx0EGGPGe1ug/E8+aOev0W7aeAWs2
 XSSDny1cTblmeY8eEf0NfO3b4IiyM4dX9OKLd/QvcU2x1F7WflOR0jnSRhHMC1cPxNQ==
X-Gm-Gg: AfdE7clytfQQZKRxY/ipFqUkKzZSaA8tq61rpFWqKp8Sn8ZzQdDC3LSky8f74VEDGh3
 JHJHBZFTLn+fscsVqVATBtd4E62pmIyKp0xXvGHGq8JauQEY9Fx7SKpJ0mC1iAxlZ5O14bAcV47
 nYJ39/fUbaff47kUfbAFCMgegpVTJZ7Gium1ollT6oU0xHzXkWy0jB45v5w8M9E0L5mGGVi7R4F
 PnrujFteyraKXzotuQKG3VGpKJsUr2ZaLEswsHisvioYmSAlWhVwn909NqGqEEjxVQbEkCninqt
 Ig9oKj1WE8VaIvVgaoBoDB8vdMhGz0oFz/NXIFgdgLXttB7QApHvSYTRerLQQCR+A9oj1qDyt16
 jLS0UmK2kTvgl72Boj+5u1vxEtP+lrE0aepPC7Wf34h2Jmxb4WJkNe+phCQ==
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-5213a384365mr160582301cf.18.1784632324262; 
 Tue, 21 Jul 2026 04:12:04 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-5213a384365mr160582041cf.18.1784632323866; 
 Tue, 21 Jul 2026 04:12:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm58469755e9.8.2026.07.21.04.12.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 04:12:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] accel/accel-irq: Avoid using inlined functions with external
 linkage
Date: Tue, 21 Jul 2026 13:12:01 +0200
Message-ID: <20260721111201.85714-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XlgR89HkiDuqCxBpRX4RdjDkqoi8KBqC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfX0oVbMV2RaTB+
 zcES3O2YTaIhBXex1SddIfKQ1OKAbtMJTGlPWXm9cEEvHdhy/JN5uwBm5A7OuWEbJyDYDrmvCYM
 Br0iUFcQbWh4juT53hZHsmfH0FBzWuTcQ8lTNNcrwmJ5tkrB43eOIwS7s+jDKEtchRj7St5pEQV
 2bAEuJ3bXR+W328/sl0hjjbjKg6ZxV6coUcNyB6I5Kx/A5Xds4YzeKnW8uGqvZCvSKG7KRTDUHR
 WKlKUseEeElLCrzHrpbR4dw/4QSJOmVE7s9UL+x0ugNmFN+ybDnASigP9RaFvZ7vP5akZsqZir6
 bHF87T6fICHC3VI3sYXC1X3qMpOknc9TPWvp73HFnCJtyNxSPTp4gx5Y9f6LjIPX3JXbmUvIWsH
 JXQdRwk+hZHvilLtqPRXZXrJCBYU5oj1lcL0k8wyIDwjZUEUlDmNQGOEMchL/YjHorW/HtuYF3M
 tWb3oPXGBjDcl8qSCyA==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f5404 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0-0h5_n0kt7SgkJO7NkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: XlgR89HkiDuqCxBpRX4RdjDkqoi8KBqC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExOCBTYWx0ZWRfX/MlFVQbTWLpP
 sDs0KkU6GOPR9XUmDdMpvI0Gx+l7yyfVeYy1tfqnuxQGcNIilGq4lTMV3TTAQsiVXaeNpcsN327
 opgiOyQ3Yq77dVwRSI4hQ73BGXMUfCI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210118
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

Similarly to commit 9de9fa5cf2 ("hw/arm/smmu-common: Avoid using
inlined functions with external linkage"):

  None of our code base require / use inlined functions with external
  linkage. Some places use internal inlining in the hot path. These
  two functions are certainly not in any hot path and don't justify
  any inlining, so these are likely oversights rather than intentional.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/accel-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 830be27c7f9..b687f663394 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -90,7 +90,7 @@ int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
     return -ENOSYS;
 }
 
-inline AccelRouteChange accel_irqchip_begin_route_changes(void)
+AccelRouteChange accel_irqchip_begin_route_changes(void)
 {
     if (mshv_msi_via_irqfd_enabled()) {
         return (AccelRouteChange) {
-- 
2.53.0


