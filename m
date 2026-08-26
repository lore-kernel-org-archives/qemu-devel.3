Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E258C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGnd-00062k-Fs; Wed, 26 Aug 2026 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnb-00060R-Dn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnY-0000pX-0l
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDuusg910365
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QmiRMdY/ifXw+3e8CX5UWI8VsAMyLIIebZl
 mht+P3F4=; b=Z+VUwV7jTC6p2OqSRd2pZ0atSSYeiholaoMZHKsZQdhrUDkJ1I/
 69rnUYyM/g8BI/478vpldLuj+/aHCJ0C7NFbJLVpabVb6NYDTXIFWe0vDApIUb4m
 MSYffZ+yGpeUG+h2KXT433QGky2pF8g8O2+7jrHtmviWG8JFTfKZ/uJ73QL5Ho0B
 XDSspyOGUJlgQpdDbbsfdbcOFGbDMKFKeBM51jCm97dsPthHcMvnGi98G52Pxx2+
 LEcVa8erIG6TCQwpAH5gx8yC9qu3fTdOlBJSDrpCEGtsDlzRmYXM5WAd4poN8nqr
 qM0MCFmpErzMNCEm2TB+EteymOLAIpItsOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03a93cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52ce64c41efso19726991cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762900; x=1788367700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QmiRMdY/ifXw+3e8CX5UWI8VsAMyLIIebZlmht+P3F4=;
 b=I6WnSgo5IgVm2BIJda7ROkKpqPE2SBUFrrmvOPhuoD/cABcNwhqn0G53S+tRKbiOnv
 O8gN7mKDSAIATDquv61ojCCnF9d1f6p1qhvaN1oPsju6JEdXSlRrd7ScLobq+ufqzOg2
 Dg4dMtERGV8aKLKHmNBd1tl2RKYc1GJL/dnFY9CQOy38SgxhZd6WH7jC3r2aqcnyzBUk
 Wz4La4Yh7JiLP/0iwz7NFnQSLeR0mwQG4hoclz20WGCye88b4tIwuRSFou8OzW/wvzA0
 GSnz0vkJI1SifswgfbN3lPg/3bxiHbMJi5luZmiR7S9/qHpEFiKVq3i6D40NC8DVysIT
 qGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762900; x=1788367700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QmiRMdY/ifXw+3e8CX5UWI8VsAMyLIIebZlmht+P3F4=;
 b=g4gV5pa/3YYjJrzB6Jroi1dT6OIaesn1SDhY6sHyfBo7VglR5yyWqzv1+kWbUKr338
 XGF8ibQvkZhQpILqQnjrii2F1kud5mSrmHN+jQzt7ply5SUGBIouhj1hQp7h5Kv8il22
 4jD2u7dEbE62V4JP9RBbgccvl9AFq8/l6e18vtjglN/EQz2PXcOp1BZf4MozHI/5knH4
 869aa60wntJmjB6Lzosg0M3GROWAnpvK/lo/xMgoi2skH0jmGQBA3IUeqhmTh4Y8zbAi
 Zd43udXxyRBb7ZhCrSv/MOicqrSlSwjUY49+VDu6bsFQNiraRwqf6iWwL7zF9aT6gmiD
 Bqhw==
X-Gm-Message-State: AFuF++n7PPYHx4GVSem6M/cOrReYsTyThT5FyX2h/ilewqdpHimzIlFV
 FiLrUERKFGQcS4SNvRAsm4kTOlLc85X+gOQRyXH0hG0uMAZ6SpQkOxkLeje/ufVL9GgJQr9KcEh
 bjGTRRgMHYur6cDg/sbMI0ewGnewd3ULSWBXjb5Wf6Lw+VFaqU05o4zuR3YAL4IEGLQ==
X-Gm-Gg: AR+sD118GmtSxSK0uAg2tFy8rO2o6/bERo2X9UVwZZP3a8aFTr3iZbW59fkgIs5AjoV
 BGQdTd1Ft80zqCmUW90FJlEfjKDXsRRQ5ksKpwELiEhEMFGhgqqbRoLR9Pv9+/jaEOZoV4qqwXY
 zLW96nWIOf7+B7HAYBB9RNHccqO49l/870tzTTEI7n4H+rtR/nujVJP1ttR+AqC1EfsICMZCEAC
 W/0XEXd0zy5aMh58gFiCq475smK2MVkVuez5lvb6SWqrNZOAmwBrIWvX6lEepxWKxGlVIOiAUKw
 UPxZwbajwJm0BSyRl+voS8EUC+eL043c+ua/eNWoSBhkwN5EWP4Vdeml61J/Dq4CfrVUZDChOwM
 cq7nywi7SPU9P8S7MFSYWju+sfnsyY+JQm4WmoA==
X-Received: by 2002:ac8:5f49:0:b0:51a:8bc9:2915 with SMTP id
 d75a77b69052e-52e4222dd6dmr85741381cf.8.1787762900318; 
 Wed, 26 Aug 2026 09:48:20 -0700 (PDT)
X-Received: by 2002:ac8:5f49:0:b0:51a:8bc9:2915 with SMTP id
 d75a77b69052e-52e4222dd6dmr85740871cf.8.1787762899805; 
 Wed, 26 Aug 2026 09:48:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:19 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org (open list:Trivial patches)
Subject: [PATCH v2 00/13] hw/riscv: trivial code dup work (riscv-server-ref
 prep)
Date: Wed, 26 Aug 2026 13:48:00 -0300
Message-ID: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mBCU9eRAXdQRb29QO7bbhH-1bftTnvLe
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8f18d5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NV_7vAgSjKoQyGx3fFkA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: mBCU9eRAXdQRb29QO7bbhH-1bftTnvLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXw0iH6blBuyIg
 H+sXPplVNNUDUpJ09p45Rxbn2hGKYJH7eAiTWdq6sRgwbiXtWCrhWzVAtlC/oeUyBKl5FXZ9/lV
 wU7rJ6ryyLg2nj5kFTNGU8n1AiyWibCxKTNrz0guK2c7HFf6K8LUL0e6lYvuRjFjOEUz7xioLHa
 uCt7blQuY29Jz7S6IHmF1mlOicR7aSdNcabtlOvP6dn0+9sr+fZ+bzeJ7X7yIn4eyiTnN95VOXR
 ZJwlDudkiDmgLj9hZJxYWJb8/iTZTLlAHdCOeiDTCkK1jgCkuM4xLAceLY1qt3+fbj3MOV6LXNd
 qvuAS85vaICgXw1n9PjvT65rsV0yWPdDEYYBjvNFehIQQTeCyWzNT5y61QwL4pbo7KpYwSkqmoC
 Wq0SKiAGKdqRkoW6QwFUBlnm/uzQXHeRHTArBiNhrAzu6rEcehpQwXuSIRiGuy6NuVRaiyevaRE
 RP47LEoDPWTXoFifWOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX10Yp1UpYjz1B
 Pn8ZgweUUxoItBirnusbamHhL9m++tbxOCZFIXQpk1t+XuvmkMW5GoBCHuPdoY54n9TfcnO2xcY
 hd7kR+4tBSMRZRb+4gdPpJPx9b70IKs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Greetings,

Here is a bunch of trivial and mostly boring stuff we want to do before
pushing the RISC-V Server Plat Reference board upstream (currently on
v9 [1], not yet sent for review).

Although these changes aim to ease the pain for the riscv-server-ref
review, in the end virt.c was reduced from ~1800 to ~1200 lines, which
is a nice benefit we can have right now.  For riscv-server-ref we went
from ~1450 (v8) to ~770 lines (current v9).

We were able to also reduce tt-atlantis code in one of the patches too.
In fact I think there are opportunities to shrink tt-atlantis board
size, but that will need refactoring logic here and there and this would
fall out of scope for this work.

Patches based on master. 

[1] https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v9



Changes from v1:
- patch 8:
  - renamed 'additional_reg_props' to 'uses_32_bit_spacing', as suggested
    by Anirudh
- v1 link: https://lore.kernel.org/qemu-devel/20260825212326.1907-1-daniel.barboza@oss.qualcomm.com/


Daniel Henrique Barboza (13):
  hw/riscv/fdt-common, virt.c: add create_fdt_flash()
  hw/riscv/fdt-common, virt.c: add create_fdt_syscon()
  hw/riscv/fdt-common, virt.c: add create_fdt_riscv_iommu_sys()
  hw/riscv/fdt_common, virt.c: add create_fdt_pcie()
  hw/riscv/fdt_common, virt.c: add create_fdt_imsic()
  hw/riscv/fdt_common, virt.c: add create_fdt_socket_aplic()
  hw/riscv/fdt-common, virt.c: add create_fdt_socket_aclint()
  hw/riscv/fdt-common, virt.c, tt_atlantis.c: add create_fdt_uart()
  hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
  hw/riscv/device-common, virt.c: add create_platform_bus()
  hw/riscv/device-common, virt.c: add flash helpers
  hw/riscv/device-common, virt.c: add gpex_pcie_init()
  hw/riscv/riscv-iommu-sys.c, virt.c: add create_riscv_iommu_sys()

 hw/riscv/device-common.c         | 168 +++++++
 hw/riscv/fdt-common.c            | 571 ++++++++++++++++++++++
 hw/riscv/meson.build             |   1 +
 hw/riscv/riscv-iommu-sys.c       |  25 +
 hw/riscv/riscv-iommu.h           |   3 +
 hw/riscv/tt_atlantis.c           |  21 +-
 hw/riscv/virt.c                  | 811 ++++---------------------------
 include/hw/riscv/device-common.h |  32 ++
 include/hw/riscv/fdt-common.h    |  94 ++++
 include/hw/riscv/virt.h          |  15 -
 10 files changed, 983 insertions(+), 758 deletions(-)
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 include/hw/riscv/device-common.h

-- 
2.43.0


