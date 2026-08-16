Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACEC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcEx-00033I-Mn; Sun, 16 Aug 2026 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEv-000309-Uf
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcEt-0002Yo-VR
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDm7kU3611749
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G6z1n/xvrQOL+ylmbf2cH/3jRtJrUXQKyzDy2Pqxz48=; b=n5gJmpm1fB5hc8GE
 Ex9EV6ckhSbricK/zL25Qtf1dbSzU4T0/1+3kuPhVIqjPvVVt2g45W2tt+jbPodq
 w/OY1SUJdx/hybVVC6+KeHYREK/iav5G45i0lqpBHn5TLye5ey0vR8mf8ijwGvys
 kuIhOHtQqancACk7ozPjp9c7K64djfTj3Z2QOU/FGCXwLNlTOKeLo0cwNneek/wx
 gFUAI30uGl5r8Mu6oIJj3zNaZS+U0k4OtBUSwrBmqnXPKdKq5Yp1MBbwarpjE5UJ
 77fte/jZYpYmQPDFxnKJzEFgaZMDe4pEOkfkRyBJqirVEcEYo1wIAN8rJmiZhu5f
 VDvvXw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfukad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so37015541cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892009; x=1787496809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G6z1n/xvrQOL+ylmbf2cH/3jRtJrUXQKyzDy2Pqxz48=;
 b=PJmJH3uDet+tQ/m3It07+ToPLszKmHuGlX66s3toNYTKjYOw+MoIIsg1p5nJYl1RvD
 i0rdR4F8LcfsMkolMhkFhokEQtzv1bZAWS97xmZTmd51yHGBnPfCAIO63BuxFGgIZc+N
 KRIfkczIJXevsUUTts+N4dpyNYMbMzRb3ZKxyV65rdRrI8zU256W105At0LRoud2+uWQ
 M+wQ4f5CIJJhH/nl5qoWvMQ56Be6IVon0NJgEI2kHfliB3G4xgfL8nnnc9CrriWJg1bZ
 aes+iwP0QvkOUh/DeorMQriVE2gX2M2Ds5gARf6gJlTwc7/Csu2+nJYTMwHyJ/EtTack
 tC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892009; x=1787496809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G6z1n/xvrQOL+ylmbf2cH/3jRtJrUXQKyzDy2Pqxz48=;
 b=cKlpf+wjZ7V0SJiQUNX0Pf7sUYDkaz7dSKsf1AIqhOWiDNVF61NXToT3lJqm9/QYpC
 RUxlI1P3eOhOV6Uwzx9PVfAkJpEjR9P79LpwuHRxo97kO1Wtt6VisnOoZ4tzL0AiaWNY
 QqKi2dobNeM1nZ/Tdjiw9x7Tgs5Bd9IHVLiYAdIIcvgwegDCqsVq80eO6XoBEaoOCGRX
 FVvqKYI36EOVkn8zaVGnw6GG43R4dn4uwvP5upV6iZ4LA48s5mx+NaXHcnH4P6UdQ38M
 y9I4SgVRA3TVyE2AqqbwlylKgksycE6bunt7HymGTH365mRC4z1tkgnekQllM/iEouD7
 9ifg==
X-Gm-Message-State: AOJu0Yxzfl9rsPP5X7B/OVtMPneZ2kLO1r0YGwPvHTWILs47wqV/vpES
 yuAWefOKyj7sCGjwaVlBxViJe+F7zwh+usHAquoHRgxEXcAUG3a4Uv7EXPLHsjUeAPmwm7JITxA
 SQ6etD5G8Gmp5HsDpofD8+Hd/v2nYbAAIp3h9/jNhEhVuFNm5QtALoFv6XJN21JzLGw==
X-Gm-Gg: AR+sD11OLQdIfpzy7IF03jZ05O8MtDb543AgvmnPjdYrDCbSs9kO1xjuxsQ/vXcuXQ1
 41RCR8JwJMLGk6o4ZdYd+hIkBhOnvmM3qi/AE5937MsukX01+qVsH+OB1Iix6mBWS4zCpO9ccpq
 XT25zEy4c60A6O4YLDSayHz8VKBxBd6eijoN+0Ac1gEb+nMhdoAQXIWvEPLY6JmnhAFi81ykOFj
 wHkAgHWj8U+ndl1NUkkHpfVMfj1djOlp+YJQp8wJDQ0/LCJeZUMifybpSydt0UVAcv1vQSGOhzC
 EuNJ/2E/5EY3C//fMohZ5Gm5bbGrloKQa9Im5HmAW7C1O6/98yL+PgQDFTxwVrilO/CuRkW/0+8
 SfnGKnEuuFFBwHNurNsf7ngSx/8oE2IPFEFtyWHqcTQ==
X-Received: by 2002:ac8:59c3:0:b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d8547d028mr209403651cf.29.1786892009498; 
 Sun, 16 Aug 2026 07:53:29 -0700 (PDT)
X-Received: by 2002:ac8:59c3:0:b0:52d:6afd:7d9c with SMTP id
 d75a77b69052e-52d8547d028mr209403201cf.29.1786892008980; 
 Sun, 16 Aug 2026 07:53:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e54b31sm135796695e9.4.2026.08.16.07.53.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/56] monitor: Better express monitor_read()'s opaque arg is
 of Monitor type
Date: Sun, 16 Aug 2026 16:45:52 +0200
Message-ID: <20260816144556.69009-54-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXxzTHHIPDOMNo
 VlLMXqfoUjsStKmDuLRStGOSYIM01XOhNM74/btAIa5rLvAMVuNWodn3akR5eYHqbzLUrR2smmx
 osViOSIdeaePTGbEisreo2wTsqeN7lw=
X-Proofpoint-ORIG-GUID: Qn16w8XnMw2BXVANYix8xgZDkRj4GD82
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX0hDMN2bphy9J
 Yup6PGtyJaJfSbkmx8rYk2ajvr/89f5EgbHV4MLtGFx4j+xUyfl6R04V/OxgVyYf1t2mhZx2caG
 NOal0h4N1UOuQWY8ydfT6no+VpS5oHR7fCxtQcXRANPhHMIBG2oCQaukTCV5+mvkC/eLh4+IduX
 BiRAXFGODEp1mmYMOxA/xAaWpPvYVahV4BEZkCbFwHWA9aPOm1P9vER8rElV2kzuTucXfuML9AU
 RY9PTiiRjV6h4eqL2/OKAsmZkGVKj6WuPIIsPYUrZ6Ig/ogn6WiRGtP2rLGrfsgSGtCFfW4pJDv
 OFQeSo0r8eZBEAMl70qxl5syMTZPidulINWaVo1acJlAVADSY5NgfrNwoNxJzcSaernLx7oEn/P
 kPFIZVgsPjh+pma3ky7FjYKK4gdAl5RDmaL+bcsJup1jHuJZ+uQaIXIKRITGgRcKeUPpif81gsz
 dHaAZSGUcVBieoAWhSw==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a81ceea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Qn16w8XnMw2BXVANYix8xgZDkRj4GD82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

monitor_read() is a IOReadHandler handler, called by
qemu_chr_fe_set_handlers() with a Monitor* opaque argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-20-philmd@oss.qualcomm.com>
---
 monitor/hmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index cbf7a114c0c..46f8d4a6ede 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1519,7 +1519,8 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *hmp = container_of(opaque, MonitorHMP, parent_obj);
+    Monitor *mon = opaque;
+    MonitorHMP *hmp = container_of(mon, MonitorHMP, parent_obj);
     int i;
 
     if (hmp->rs) {
-- 
2.53.0


