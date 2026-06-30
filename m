Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A18C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegXm-00036A-Jl; Tue, 30 Jun 2026 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWS-0002XZ-5I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWQ-0003fh-CT
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDav32873364
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W8kslJw3ZUnEngHyQr3H2ja6FRUQWfjp/nGbHX5sZaM=; b=ISMYjUBDIyv3ZiCd
 mZVDXkR8aph0SQfjJg4bhXmMGlQIEJSJnyGdL9ImMJivSjxgfVsNn1B3cNqElhm6
 +Vahp472nEaXEVpANnx8DI0FgVWYGR4frxgpKBm1n9YakDcbcKpJRuHmvs27EyOZ
 tClGcpdD6nqRdxN0Dny14DmpLHHNkDPav4TtT5gRyW3hjgyafPWTKj0uWJsCAf5p
 XTFtru8ANEAYA0YrQCfx0eIYVUC2KbvRaz1ifnMML7BtFdgwuojpPznzDpo3fRSp
 7T0e8MGl9UMXuaezmrheSKBjmcrCP1E7VTbFuG9SsPpHVqdmegNCYRBwIZmifoVS
 vJKoGg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sgtu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73a1de16ea7so960493137.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856896; x=1783461696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8kslJw3ZUnEngHyQr3H2ja6FRUQWfjp/nGbHX5sZaM=;
 b=O6+7zM2uTw4oStFy0VlJ4U1gj6NSyFnf6KnjGXUJDfc3F7fduxQupRo6aGWvmC2MPH
 /Cp8/XBRgB18gwqZuQP4umQu2e3ubtKVmX4BLTRefsoSy7JIPXJlRi9GgdP7xNblmJsM
 2L0zniuUlIjmLZGimsvxncIm6g4TeQ9pIbl3OLplKgLdXZUo+iPU4jhD/A9QrDK8LOqg
 63qOeskTYNzFNEVCPXujUXx8YFsY/jQyXJd/ppNaVEdPPHV4yNSOFj4jsq7kLoPNkpMM
 Yyw4wP8z3avU31nMwLA1hVTA1+gD0OXqwsmC0FYEMfMJRcqvfI3TsMvv64scqSYGML8L
 7tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856896; x=1783461696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8kslJw3ZUnEngHyQr3H2ja6FRUQWfjp/nGbHX5sZaM=;
 b=e6+lm6EOo4DAoPtcoCqAbJj5aqEWqd6sotJA6L87CqfiJnefSLfZiCccYkHDsVGaJ7
 za3RaYOtOLH5aRPmUnTr+rH6jd1FodSRKNyt0lSf3hvBw8e9sNMPAgfq5sm9XYFC7iEA
 QBdOdqiY+Rzr+i32pHzrdKSJfn04jdrHsVNKMHNNxytOT2645zVRblfFqyzvSNqyHLYG
 qApDH599bo+VkKpl/9p0EeS2yx4UMLnMozXJnSzDHVrR45iA3Pppa+lGM2ycfdpHWTrg
 LPyjA++qyZh1o/8svKQJZBcpsycE14w3gS3/uk0T7rPM+8RVE9DgIEE8Epoym3PwgvBa
 BxRA==
X-Gm-Message-State: AOJu0Yw04XTdXaindisLb3IsHALkxlriJY9e1SjraHGH9BdpYNwhymVN
 WukIXZvHv6h3wd7qkqkssgnngYdoE9gS4oLvf6Qx3obIjOOnbDtcGmffefN+2DR7R1BWf3zZvL0
 pzeeWpwWXY9Mue018xMGU0ip8u2gwWj/QMmjDds5G2B7QrumQq/WcV1Hu+AwAE06Dig==
X-Gm-Gg: AfdE7cl9ITkIjk+MV1wPC1a5T+QSTDSp9bLLCtYYyB46OwQmt0caNLRn76gG2/V6Qjz
 TV82Xl1toN9O3mz5cby8ztE2Lu/4lXa4G9TGeMWRnKeNdczPac9Vix68ZXg4liS8pofs8xK6Lud
 MuzSuiMxG995DMdXfx2hmJhAeMYa6mbjfYHQvI75ai70qAkPMX1BxIaxAbxU4DtfhezxkkxHwZ3
 oT4hu6pkc9DgZNyAOsQ4mxfCMMvkTrCuyKGSQWPrdkN/5BewS1OlXMv1quTj9T0jkIOaWZe/5QS
 ndJHhGJ1yzdLpEJ4ix0K7fl6CePUkekoGejzvOw2XE5HJ6XELJdYlmo1z5BbYT9vmCsRiUjuVlX
 bd64hy601O4Sfwh4IqbsglwPhVQbkyJLVT41wmD0ZMeLBmhnVjKIAXwEmdmPnC2zf/cxV
X-Received: by 2002:a05:6102:5a90:b0:737:b102:c1b4 with SMTP id
 ada2fe7eead31-73bd357de61mr1268346137.7.1782856895735; 
 Tue, 30 Jun 2026 15:01:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5a90:b0:737:b102:c1b4 with SMTP id
 ada2fe7eead31-73bd357de61mr1268278137.7.1782856895307; 
 Tue, 30 Jun 2026 15:01:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475671d0403sm11709605f8f.29.2026.06.30.15.01.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 04/33] accel/hvf: Remove left-over comment
Date: Wed,  1 Jul 2026 00:00:31 +0200
Message-ID: <20260630220100.1289-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P-nQq9adHRCu9D_-OlMaERxi4pYE7L7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX1sXVS3vRx2X4
 IM1JLeIiR1XHsnXDDuxuJR2/Y58h3ZNN0T3eK/IOsQZDIklsnCf3/5mavEOIxdT/TFRS4Us73tH
 hqSZ44j2uHwqH4570b6g4rUaVbYvovToVXA6uT4O2tME7eVeQaM+5PamFuGM5uxgQNkLyL+N3hc
 pIo0+Qb12MMU3hNbN4MmNbK1hxbR7arlVCzF0Znfq2jaENS2NOj7kYLfiPw5FejW4jzKFWfwjvr
 DgZlp+EN54wolr60OCuqqhlUYPVKpP4WwiZ++GylxpZ1GvudL3Q/y2w5xmdwGmhIGMmmkd8FFWD
 52g+UuVfUbuesLuKCCtUP7GRfHtiRd381pzqRfTJn5bcd9WkDfivMP4YsriywXwzMIywH9NaBN3
 Vl3kONmbP1SEifpC8RlkF5KZwSPrHCdUmMdRVwrMkLPbVmPED0sD6KdF0NG4ka5VJ8Ee+2pBxV4
 1fNmNv3CC6aL4BTKIxA==
X-Proofpoint-ORIG-GUID: P-nQq9adHRCu9D_-OlMaERxi4pYE7L7y
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a443cc0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UxKr3doQCuer3U7Pa8UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXw8hbwpH6eqqq
 nxak95O54PVjT1O0tXOmOA7lX+4MuvsGErQz4X5u09FYiJUTZhDvLLm2QQL8+xwLaMkqDnB++TO
 D+5K58Un+1TTgiRf841e0bE9PWVbpUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Missed in commit 6bf331164c5 ("accel/hvf: Drop hvf_slot and
hvf_find_overlap_slot").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/hvf/hvf-accel-ops.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..dd2b45b7cb5 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -62,8 +62,6 @@
 
 HVFState *hvf_state;
 
-/* Memory slots */
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.53.0


