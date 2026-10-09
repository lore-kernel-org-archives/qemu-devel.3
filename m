Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7045BCA9EC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSf-0006Yx-VN; Fri, 09 Oct 2026 18:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSD-0006Vh-FV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSB-0002cU-At
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhUZp3371066
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4l8x1o/7JZ1
 gxlZqyFfP+gVjY9BN9C60XRtXLRAvSz8=; b=DQIaCJG+SpuDufm0wtC+2njWNPK
 bL2KOK7HzAgk0UsxpNqZBvXRgpwS7TQXWNdBx0rMjnePbbCu0VKOkiYvywkOXjhK
 ROZigZuo9VQe1n3oTyJITzChP86XGPDhU7kpZrCh8LJGTH3SW1mNBOBlvQQY0Aa+
 CymDCvagxFeZx9TCQ/Kfub8SN+4lLKZHmyq4Cehg/9J00hnlgAwfYJFAsWfo8hXK
 P0mK9j4gXQ/gN/INcD/cCBYcIFiLxDxT97q9BcVGV0yMO352xiUhykt6YrK1RWsa
 lYlO/Jy4DvKVsi94KPskZQcdYf2BEU1SP2EoUPcG3X06RLBYyYQ8rsJqcjQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8h0cc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so586548eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586356; x=1792191156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4l8x1o/7JZ1gxlZqyFfP+gVjY9BN9C60XRtXLRAvSz8=;
 b=hA6tT8sZ3q1HnEbg6PFP9WZmLjBStc27xBWmuD6WEf7NKe3ud3Hd29dNWxRd0H+qSS
 XSLV5TJRxqqkCRc9yzSAHldarBKWjwJZM/K+q/7nvdOQH+4RQAG0KwN9guxfX87bnBiX
 a1VDeM2WSltIPpZhFyCI1hDYBYPokZ129xgeUnYlBIpXcn87yuwUBCOM8kXoI7JngsU9
 TvLFYxXHl3EKQbfL1sF525pAsYg7nDdj022Tvj4088c5MvH4idwTm62rbT5TrvUc2x1O
 1M+i4qev9zJQZpWWJvfS9nbOR5c/ow4HxLUA/eCvTt/VVOLVZNApfwkH8lHByqxmMyKk
 o7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586356; x=1792191156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4l8x1o/7JZ1gxlZqyFfP+gVjY9BN9C60XRtXLRAvSz8=;
 b=rdI4dbBclJK8oqrJSQZ0xTwxsgSAVZybqs3an/30su0r51rzXOBPQ7Go+fsDm8U/tT
 BbeavBAgOOSRb7DSSlKgxcNuaRH04OF3jQrulSCWLmZkmlGlkyJdlFdKD1U9I0Kfw13I
 rCubudhdtAiultXYXuG04jQMb+KJIWPhojSqRYcrLwdnAl2TP0yocg+4mVViPx8pH2cv
 ru91/gvLT18dp47csBkSG6K428PrWMwXGPte5Fs61ebqYR4j8PUlDOSyDygva6U0NEUI
 7qyX2Wkx8jjyeKgCxGp3U3plKlBig8bnUfIX8eYtAeJaOtIQiep/WWMYeB96JJ/ZCjV2
 TACg==
X-Gm-Message-State: AFq9FYIPaimBJcuGZRunhhjInJXVh0Lc2gA2tFXQF0VJyuFeK4Kmt3Vs
 WsdimwkFSgzryIKwl00/oGmY/6JXBicDe2IsFkDzIuzXZE7/oaeQbEEm8l5crXLDODD9snYOyM0
 lVHgJhortcPiGBUuKLzYsjSiCxWaw/pEx4focQL1X3Stu6ConX76FrqERkBQ5vgHNMQ==
X-Gm-Gg: AYBFou33A6iEmeySj7a58ZoBQE/+nIsaetI8TkkjGGJjyp11ocPrrs0xSRe722Oza/o
 8Jmxol1Arnpw3YHRBaqpXcZwKvh2Es19h3mZcCeq/il3l5bzHSC1IHTI8h4WLEYrQthXZA+fy5P
 nJmIkvW70Muor/iS0rd2IWG2MUt4sZBfJYJ0kzfkDoL6GwfUC20g0WjG1bGv6WAFDnX9y26QFdI
 xW3tFCGt2DyGZJ9Pb7B18wUh1JkCyOVXCwvQ4P4KVGk9fsmy8LnsPR+F8YJlf4O+wMAIZMQkAjm
 x07ksQU8kAWlUBP1GOB6JLuxvurre2DfT9UA78ijGJ4l/iO2ZB2aS0hn7RFvD/fIlJkuYIIPYFw
 IRtPEHGegHjE005GjjihMsumIMEec7mKDHIoMas2TviaPhEeOhN3+3bcYddrY
X-Received: by 2002:a05:7022:1584:b0:14a:725b:7b40 with SMTP id
 a92af1059eb24-16a6203a4b8mr6037808c88.44.1791586355546; 
 Fri, 09 Oct 2026 15:52:35 -0700 (PDT)
X-Received: by 2002:a05:7022:1584:b0:14a:725b:7b40 with SMTP id
 a92af1059eb24-16a6203a4b8mr6037767c88.44.1791586354913; 
 Fri, 09 Oct 2026 15:52:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/11] hw/hexagon/virt: make machine available for hexagon
 target only
Date: Fri,  9 Oct 2026 22:52:18 +0000
Message-ID: <20261009225226.10657-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXya9xebfuBD/U
 VugOftxDzPMsTgObocB1k7S7jjr0Q6u9y4D6kxFN2PKNauvzAnxOCLUoEjPow3adxQ+F9C/TFhc
 jXbTn4bPmKpoFOYfE63sqHGezfQJj5E=
X-Proofpoint-GUID: PpKGzbsWucH2kMLVXQM6f9zcQAIqxm0V
X-Proofpoint-ORIG-GUID: PpKGzbsWucH2kMLVXQM6f9zcQAIqxm0V
X-Authority-Analysis: v=2.4 cv=AMIlxa6n c=1 sm=1 tr=0 ts=6ac97034 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qlv5defmNkfQSHP61AAA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfXy3ScPVJFz+2p
 OmTNlpOgv/VzDZrBE+9iDbAr0w/01RPM4Qdd0WsPo18zvKux8M4uLugAwnQ06ipnCYwGr9u4GmJ
 /JG5J6yjmKFsGd9EpzOGpOq622bA6MV9V01umVhGC7qLjz3J5Dlt/JyM+0K7IIV92wMWrKPpymD
 eBKZxK8ifjTnjwkFisy288UGR9g7NdfHMD0n0f3rtGV94tdn/G2s90yHpfrWnCjao3TWYzFWF04
 m1sR+c3yBi9WFxF+jjIqyxwFti5rvNfamtdwb+fm7gKwqIJSt7tVREpd6/drlBca4qNa0QFSzGm
 Wpfb8QfpO37hjCMURYrLVQ8D+ryUfjRQ1QwQd5fWlGocINAFqTTJIhwDrVlw94uHtWwF6CzznrQ
 hvNgLiHokRIpigZZ8jm+2CdUD+WFthB6ROONRHqttst9F/td25kdN8fzPKEvFd/TfDroyyyFipH
 hfcF0PyfE/cWCGcmkkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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


