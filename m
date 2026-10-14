Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCB3CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6Aa-0001MY-Hg; Wed, 14 Oct 2026 17:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AY-0001Ls-Gz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH6AW-0000hO-VM
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:05:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEagK3500328
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VBs/W/maE4T
 OHR15R+od0gMic/fqSD06bHPzgrW12q8=; b=nZzj+FrD+QhiPd7kga15fTRxC8E
 AONqKw4bpKXOEOnfuXLO75MQUQ4RTtNNIfk+2XTcdGv6juMoeBrZRXMAhNZJz/O0
 tp2obb/HEK1K1uwL40nj+PTa35MP7s3xl7A0SIM/EKN5gBYPwMRC5Jrndtv+Afd+
 SMWe/U50iPI9mQlaPxbofT8vgAiqOWMLKQZznDTj4OqaITs+ym/lvC3kdQOT4jbk
 lr0hAyv3VAe3nIjJUQ5HTouUxhxvKFxJdtymh/wkvwayTgxoL07lpuykSGPB+Hc3
 MGIMvPaFcMt7PQgndlbWvOYstav+qUELL7li8eG6d7fRsCu+uZZ4zadAXVQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1ry5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:05:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso6962679eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011947; x=1792616747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VBs/W/maE4TOHR15R+od0gMic/fqSD06bHPzgrW12q8=;
 b=bWtmdYVUDyjyw3AVmQZxPGQrtPZUHwRs5gmhFR4s+IbKhYwqQg1+IfDVpHQue3fEfy
 Qx4YTzfbn8E70xZXNEvQKxQ3o6IUq5fGgQPCLfgXbOha2ZNRN7uodx2TMSGXFjTpCSvI
 7hVbfIGrQmNb6Apx60OAd30gWiBjQrAW/nKYkEcExUu6UdT7omHud+Ar/PQ8awkhxEtS
 0570CU4LAAiFQLFU7h0SnFfoT0Bk1g8nZ7mqlX/6g5uLzJ3F0vJ285g6xrKxM8l8y9RR
 0DaALPxd1Ta6lA5aMmj6BzjJEbZT3XIMRE6+LTP5zJ1kT4GgUG0SiUlEfruMtiSLGwMS
 n4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011947; x=1792616747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBs/W/maE4TOHR15R+od0gMic/fqSD06bHPzgrW12q8=;
 b=VLf+ZDwdOs+Ae7m+8udde9tDV6D23d5PyC5rxoOo7xgmjx4KnlQN4pAzHUzJEh9M+U
 uWc7bjKaADQQYtndFgB54/X60zOmmsJL+IXqfKzGWV+ua5zuv0PGZ4Sp1mbfi81hnD44
 EmFyRGLe4IkmBWnBvVBIGmQJuhJ+VdAfA1+kDyKTCK7papiweYiv8JuZx3JA5Bq5ICJ6
 DH/PRuybm7KgwAvajnKilWIAnn7I89Y5hVK9NKg8cI/K8snbAVd+Y+2vtTgtgsLfUaFL
 rXCOOlUo30vVSlunt1dgrkGLpXsmOTwoZrkr0scTqLFjP//Y5FLIJYaUpaZIrowz5mr1
 lU4w==
X-Gm-Message-State: AFq9FYKXQOvLrtlKXtdJVFLjBfj4GWr+3nDn0JVQXouyufaksoY3ik6r
 3x/LjPjiW+jEyuOVbMLWM9pDbiltNW3W9i6YoIvAMOKr5n8RWkwUmhn5MQrm4QE67LtIiiUlhdv
 st984kXBEPMnIq0rPdLC5rUCAXyeGxsOYOUptjeMf0nvOt+kENUh09sI5OX4hsYOAlA==
X-Gm-Gg: AYBFou3CwyxayPWneVUWuMGHVHg0KIdfwB+tB7f0q+SePAlcNdmqr1POHDWWLpYZzkb
 D3ucTxWnZbBp1DpIMZSuVR7rWA6Zcrjx+SggAaFeVKvfg8XO12UmDb0ZhOXEgKUcb5bRq5zJVDq
 xRdoE//hxewkn2sDcT6LcwyLUTo0uLsIpb0mAPaqUdb1Vq2F9tSaFh80S7OzSYQuK/FM++IkghJ
 KsQ11RtsVLW7tHL/vPGsmbp94/TsSFUiFX1Olk7cKJM1l2IGI8au+63JkH2JSeMqOOes4m1M/8y
 lo2RuYWEfjGhu2WpXS6jXE25gUOOQt9upOTbY1yEWEMSuiuavHS7N4hVONwywgZ7ouISvWPoVmp
 HPJOxs/FPwPWdlMGXa/aJnpXz539Pqvuyi7N7ODQWWVfrVchfcUNhDG3OnvgS
X-Received: by 2002:a05:7300:430b:b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-35f2858ab4fmr240729eec.30.1792011946992; 
 Wed, 14 Oct 2026 14:05:46 -0700 (PDT)
X-Received: by 2002:a05:7300:430b:b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-35f2858ab4fmr240694eec.30.1792011946396; 
 Wed, 14 Oct 2026 14:05:46 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358ee8a3387sm46562092eec.15.2026.10.14.14.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:05:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 03/12] hw/hexagon/virt: make machine available for hexagon
 target only
Date: Wed, 14 Oct 2026 21:05:17 +0000
Message-ID: <20261014210526.104215-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX075tbOhMX9B4
 zdK2pMR1ZWlNLQNvr/vYON9Bzr2csrMFRDviHxo8PsgWZkIKK8WaDfpQvyI5b5TiQSiEmnwln8Q
 trA0/2NxkgqeGFnm4yX2njlK75Pf0W0tNJxqO/oeewit1woZ2VkwVQUDEK2MzDdz5Dt4m9VCNAp
 7S19hkkloFgQ4bPTrnMX435iYSGmxdl1q9tEC0JyhZUJzT0ktLNwrFqaKCcr9qDG/gDfC14wZ65
 zBZb1PEK0jr7xnZK3mg4BtzaAw01ZreICgk0n9Bjkzrmxv9yaD5xXawNqRXN+E1usZzLf1YG+bu
 LJiq5KrBeryXPsyBVLSzHa9NEI4HnR22bQki/rVr2TgEc3ctqs0Ynh9Nf00gQAGUVqZiYn2YAXx
 DYD8/PAWqPTFGJ9WDPbxPuboGYjOahzvXR3+WuvpaXHaXqQh9LJQPOv57j1I2rzsyeAztmjX/hp
 eDPkPQyo97v/vcpFM/g==
X-Proofpoint-GUID: XUOwE3iuKmzzvw97PhPNuXpzQdhIkj8i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4NCBTYWx0ZWRfX4F+6NPUHKNJA
 1A930uyReX0oIOjJdsohWWogmaac2WuTNR1kbtIRr0QMTnU66+oR3PEs93lCIRBpOlkQX6xFEhL
 v2nKxcTe21KQzydmvuDiT4e5MQXLcg4=
X-Proofpoint-ORIG-GUID: XUOwE3iuKmzzvw97PhPNuXpzQdhIkj8i
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfeeab cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qlv5defmNkfQSHP61AAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140084
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


