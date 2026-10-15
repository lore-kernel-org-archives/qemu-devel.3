Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105C7CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRBT-0008O7-Fv; Thu, 15 Oct 2026 15:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBF-0008LK-Dw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRB8-0000Wc-FF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI0uUT3202386
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TTw+6Xjq55M
 qno5S2N8hZaQ/jvaMkO65DORFr4JQSp8=; b=fyQGfxSCvbB6v2gsdDI0i6deuKc
 43+QP+96iWzMfVeAyswxjdib6GjKIHZjdb1J6vgGhweTyzJc+TEJgZrRK7VotIky
 3cGRm5yxcOKWGnudZF0CaXs5o6PUys5jA2taBCkXGV93Ac/ZrfcOwjweRoobD+2d
 rOFsvLd/aB/uvIcUpUx43sTKDiYhErBDhjKnJUOnriFieEs5XfQnTkScCfeUzP+M
 +Y0yA0NlhlMpyMucwnmMbNhEI1SPEmOUVEue4vLaUe6odlGHoRPkHZ5eMjiH1w+W
 3x5mbQATx4snlO6NaRMs5arsqbgOEYVpJqrALr0jZD24nNxXdII5hlD7hZQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3r389vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso11405893eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092701; x=1792697501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TTw+6Xjq55Mqno5S2N8hZaQ/jvaMkO65DORFr4JQSp8=;
 b=BLNQrvZ3utQEipAfPLsmr7Wj7FY70AJE7rMBXbObmmp5YXvh+R7QgITozr6PujD+oY
 LcJEXs0EKsgiQRTzfcEM1Ovwo/V3c1cVf0EZh8yCAgatpVMiqbIDWo5X4jxbHtlA8LEl
 Wx17fk1qknaZ2VfWOXrWusFTpMWwR/c/sl+wdb/Ik39ObP0V3A8BkHpGgi0sn0HV+mwR
 T8bgvhm3uSvYbIBG58gBxk/rRfIEsKwyuf9rp/wP1I6xvsmUIn+vQJiCY3cnQ7+FSUq2
 dr3ObUcmd7YiuVWOBBVzr8u7jBz2mhpRHMCa+OSqLGSRu4Xatj+W6rOfvxDwAROMeFFU
 KUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092701; x=1792697501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TTw+6Xjq55Mqno5S2N8hZaQ/jvaMkO65DORFr4JQSp8=;
 b=k3n8RXWVYF/o4JQ91fGALBzCZjGSlLDN6fdvl91u6pizkTHG07XY990Q/zbwXhOaAY
 jo+n+9eEZ0OU6D0SE7ihYgfYX6+o4X9PZLxUo5i8QLI09dzg+NWwVR20DwJrNj+zCfET
 vVb97b7uziw0S31TSAM0M4RQTAjz/f1isQ1DqgGeyAgegUifstwI7MdJCxDWeJIqpuSy
 Wkc2itS8RnYfUTHxxpRTVNDwK1ASj2k1MOyg3UTvSrNRlgy4H3eLTdvjvGxjHmylTmwM
 3y2C9iPHhnmHb/MviB3p+gf5wHB38pF0Xi1Qxai8WFyRKHIspcqtxXbP2BxtdXS2eSMF
 gfQg==
X-Gm-Message-State: AFq9FYJtV5RUzF1jTmUQasPJhQoX2I2jAhAsrzONKk1Y1MwbiZSplKaV
 Lh9v8nsRRlLEuHDj3QDoii7Y4c0KLkQbfV7Nr+/FB57XQfWcNvL9NwVnaZ2WAxf5WihxtG/W/jd
 0WweJXRjvChu4ZPsavLMAb1OeUbxzr9eb5diPzfCR2t+z03agxtd6ZYxc1+IK6uwnQg==
X-Gm-Gg: AYBFou2sqEF2RkhaNpBo340ZC9pTmhlaTNHpVQz9Dl+GGHk5fUBLpP8we/wl8nhw/DH
 /qZCZ458MZNE04Y70VKBl1slE7lTce3HAnSvLaLku8vgVDqubdQ5i1Ghz6T/SkwvY8x806o/L9b
 Yfanu7O7D5WLHrBswMQkFL9cn3LRe4FqV45KTe3zM0RmBn/Hlsp4tq39RZ69U+rwPTX1v3gKyyi
 za4ItMznlDNDdCq47YvCNx0Xr01XFZfmu9wSP7p6CHfUKM8UBhC6ynAeCoAltzhcNdckzKys7x/
 dtCW6iwykXYKRoWCBIxyFxuXH/F5Kl2rvqJ6OCN+K7B21dPU2uF+5GyXKfpUprH+yPRJt6pa1VW
 dZWs3yj+I9TiKu9NOpk6rPBx6kDQktEuwQicsoJIAx6myp37nrbIdnyEbfczQ
X-Received: by 2002:a05:7301:470e:b0:35c:73ca:a1e0 with SMTP id
 5a478bee46e88-35c73caae65mr11938913eec.15.1792092700482; 
 Thu, 15 Oct 2026 12:31:40 -0700 (PDT)
X-Received: by 2002:a05:7301:470e:b0:35c:73ca:a1e0 with SMTP id
 5a478bee46e88-35c73caae65mr11938870eec.15.1792092699867; 
 Thu, 15 Oct 2026 12:31:39 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 03/20] hw/hexagon/virt: make machine available for hexagon
 target only
Date: Thu, 15 Oct 2026 19:30:55 +0000
Message-ID: <20261015193112.145326-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX0JfGkJ0see1t
 H3Z4uOMw0Hp2JSM5Eq10bmAb6AeVIGJYXcT8KSuodXx33Hdsi4vyfK8t4EzlCjU9e74YZGb0fUI
 vu3AxIYc16eobgOYiMlv3oCsfk7KixW6LwOEc8bXSlUiYGr3iPpRKGiYT7mXA/FsSXuMC+Ingqh
 M5lfIHrKv0jQDgzn7IxsHTNCpCKUcLPF3GeusdwVaa25qTpPMxKGMSelno9pAxgEEN6j9GZM/BF
 iKhm0pih8sVpLwk/X59101oXN4K0SU0AEAiF4JhPEM2TDSD12pFQf16u0U+qZe+60idGo0fkbQp
 6NDZHViQRKCg960t1GrE0wfbd9mUOARc1m0Bou6sHIWNr48vbD/EUld9blRsq0ep4dXPJtmfiqx
 WnUJwWOLwdc6sy3JGlh7y9dZ+TEKmMXb6/w/G8cR/tsy65D0uR69C2K2rp4Vz+E6IqZm6vqZ6qy
 I60gXlu/mvIjZgiVCxw==
X-Proofpoint-GUID: TVrxesyszOC4WHf5KsTtLTFRrOQKfqt1
X-Proofpoint-ORIG-GUID: TVrxesyszOC4WHf5KsTtLTFRrOQKfqt1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX2XehMZcOdmaO
 HTUeasvo0HlRMHf7OGqqmw2OrMdqWpMX9tmaJAAY2Ykgp3WBmwouNmENFCvrlOt7L82+p/19k7a
 vS/SpWMh4I7iZ+mIr84phq5fCZfRAtE=
X-Authority-Analysis: v=2.4 cv=INGXmQvG c=1 sm=1 tr=0 ts=6ad12a1d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qlv5defmNkfQSHP61AAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/hexagon/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27d..b601cd77a92 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -20,6 +20,7 @@
 #include "hw/core/register.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "machine_cfg_v68n_1024.h.inc"
 #include "system/address-spaces.h"
@@ -379,6 +380,7 @@ static const TypeInfo virt_machine_types[] = { {
     .parent = TYPE_HEXAGON_COMMON_MACHINE,
     .instance_size = sizeof(HexagonVirtMachineState),
     .class_init = virt_class_init,
+    .is_available = target_hexagon,
 } };
 
 DEFINE_TYPES(virt_machine_types)
-- 
2.43.0


