Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31401CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBw6-00029x-Dg; Thu, 18 Jun 2026 08:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBw4-000298-He
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBw2-0001Qy-UX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArhtB2611781
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9DS+NB1WKQmLmJfw2ckG4PgTnITQCdJ8hODvwwiNUWU=; b=Hn0Aa6B/vnYpDQO6
 hzb1wJtPbuenwMKG0WEKdPMaQuoiL2kiR0gjRRJnUTIw0zd2YqCzq/NhSc0eWEXG
 qFQScGCiA+e+CiHBXjkIyHlly1fznVWnyotjRQyjCMGIaGgVQ4ATKp97mSCxPj9f
 8qvV1ONp//Gu7hquGEZFI4Tl+wrmx95LtpF84o3JxTGIrpGjfSoPo2+RwXS/u0bs
 7FB7nvRO4qbK7CXI7hMqYdokbLlLu9XliqOO2jv2oWL+OMdXxK2FDbF1vlTuYb8P
 cSo/4s9QXDfvsJMd9CZPjbl156kHYu82qvf0WHWArObjai6dpiOacbMReH+/nbOM
 aCMdUw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmuvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8dd6d58b606so15403216d6.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786008; x=1782390808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9DS+NB1WKQmLmJfw2ckG4PgTnITQCdJ8hODvwwiNUWU=;
 b=QSwcTSdWS6XfLJkDMTR8PCHRpHcQ7w9uMUZ5YjjIla3Iicg/nsQZc6JY44dqBA6u1e
 uA3wjKTxIpd9lln2v1nep3Vv4qLjJbR1eifkmTp7zAuTtlUi4rC5qnk5O4ccxE6Ia2nX
 1+5BV8ffJ+iZ/C7ndwkm+lMSFdq0NPV/pimDRyYeK226QdKXuhtfkCeHmfLx8uv/GHU3
 +5881i7GOgBDsLSbM2mhP22WW2Nxut12l0CxIsYMcngeNeGleGSLo90L65p8ygSO9V3e
 q7XXobFh3annW9J8LbQbpkO+sLTMOgNKBi8X0FkCsWoLYS68KIxCe3cQP3mrMxFfn79J
 VzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786008; x=1782390808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9DS+NB1WKQmLmJfw2ckG4PgTnITQCdJ8hODvwwiNUWU=;
 b=brbIwMm2z31giwY23cayAeMtJfdmScElKS1xDtQtNZ+CfNFDDbOeANKJOylFScWiKE
 zznbxnCfz/aUgy4+2nGUNlMwPHib/GRonvWV7+7ug6vFenV0qJ9gtjf9RerKfDTTLmzh
 /ZjdRemETGyTgH3KKUlypgizeFFoHp7P6EyIo/lHj6ZKk0aruxGSRmRCvO60QjAl8DLH
 2McxWGozdSr8htAVupDcjyXbtiY7brl+tKRsNalLwK8FS5fyoJ3GfZa6Z+TL0PgedppG
 gEK1Eaxn1/Gs6/UA0hd8BY0dcmSZboqvZnxVMq7k4WVc6PUyZY+DCXQMWqT4s1J4ucZv
 xBIg==
X-Gm-Message-State: AOJu0YzI81aCovnXudPIfr1poYEc+nmqReScXOrJxV40cxUig1M4u+1V
 LlZwlihxuFzLu3BYe4ZyGhnUuVf0iwVkLouFkkprU0uCiacmhJREphIEhDKeYN+CShkfxUQ99sJ
 AC/Wy9HGTKzmQNVASWepDzXU0jPJdfMHJSJLetb2Rfojb8wMUBma7JYLTWjVxFeYqmw==
X-Gm-Gg: AfdE7ckKLxCugK9C61WL1y49U7/t9t0voQGGZXg+e5H3bb2mu+0p7MlepVZ7bF0pI5O
 vnXquk5IY/wfxQXVanIhAaLJL5CcCllwQnZg2dxFTVUw6NLmxxmndGaMR/UbGK7LEeU5Xv73F6M
 DUea3Wtcc3UFY+7FZSfUAmdiVVVe13vGn6ikMME1d4fkIwpeyPuKedhCk0Tp1BpM2K+67RC1tpc
 1X25gw9ghZ8nBT0sYyYX0REo0wqsJqDyg9EfNWqnL39XZoseglkLcJZ4a6oO6lnHFecPSaph3DW
 ueT6ozLhnAh5GOH4s3zM8aQWvl5uLyPXPN50RhYRcVTy2cweelZ4nhbssx6zVREw5hQIzT9m9GN
 6psZ0vdwpzBBqnjUqjTY0lVA3JP78KXtfvb9hjNmZkSSM0D4KyShPVEpdjAH7DOOGLa7s
X-Received: by 2002:a05:620a:6989:b0:911:1a2c:f953 with SMTP id
 af79cd13be357-91db9e7c823mr1264240785a.20.1781786008293; 
 Thu, 18 Jun 2026 05:33:28 -0700 (PDT)
X-Received: by 2002:a05:620a:6989:b0:911:1a2c:f953 with SMTP id
 af79cd13be357-91db9e7c823mr1264232885a.20.1781786007658; 
 Thu, 18 Jun 2026 05:33:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4631217027bsm12529242f8f.12.2026.06.18.05.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/48] accel/tcg: Remove cpu_loop_exit() stub
Date: Thu, 18 Jun 2026 14:28:18 +0200
Message-ID: <20260618122825.90331-42-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FVH3Aa5gidxJ5GZHejHs4nMuT2TiER2l
X-Proofpoint-GUID: FVH3Aa5gidxJ5GZHejHs4nMuT2TiER2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXykptxs5Ik7rn
 cwqDhdRnK3JPAaIaTF7I7D7XmV4Nito5ZbEXvgunFYHBvn3kbu6kBGKeVPoIU1WBiZSNqRQLZnC
 GW3yBitA1P5oQNuQSudr0Z/HwsnseaUvEfs8l5+Zk+8OOAFH9M0uD5Fu7QdyY2ovZULdgUgjo0+
 bvk1KOIDwivBtQRDARGu7dAzTxddj8jg7pA25hh5LvZxVMH7AJQJtGW+to35mR7s6h+1vkAgCKi
 S8w6araieqFpSlVvLwtBdKFLD+hLHlXD1i6L0TgMy9A86/Cv/pz8Ll1kzsRzstWX463WwjeGrYF
 ShkFWN1TUcV4ZoQu8BK6ulZmDePjf7bjoZLv9x/n1AeE6XlvnipXTVSpuNbvJi/nW6OLVE35kaY
 RlEbao8YKdDAz2rkgNtMxQtlIhderNdBEpc1fGcxU2lpNaFrY9mmRg813QbjKvYsDO0lIkuZxhX
 IusSdxjYut3XhHeNCKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX9acKely9uiRT
 svxtcklkVfFw/9WjY3eYaSOlHNLoT/Gihx1m26nibzcRYBmJfjB0zz5hiP/g6CA+UCTKdluoPrq
 FJGxAsIzohcZg6HyJhh9W7dQ5DkiVHY=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33e599 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=nTtTSeO8Bg4HjSiC9DoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

Last commit removed the last non-TCG use of cpu_loop_exit().
This method is now only called within TCG files, so we can
remove its stub for non-TCG accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-4-philmd@oss.qualcomm.com>
---
 accel/stubs/tcg-stub.c  | 19 -------------------
 accel/stubs/meson.build |  1 -
 2 files changed, 20 deletions(-)
 delete mode 100644 accel/stubs/tcg-stub.c

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
deleted file mode 100644
index 77055e39644..00000000000
--- a/accel/stubs/tcg-stub.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * QEMU TCG accelerator stub
- *
- * Copyright Red Hat, Inc. 2013
- *
- * Author: Paolo Bonzini     <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "exec/cpu-common.h"
-
-G_NORETURN void cpu_loop_exit(CPUState *cpu)
-{
-    g_assert_not_reached();
-}
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index ccad583e647..7c6d7ad9432 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,7 +4,6 @@ stub_ss.add(files(
   'nitro-stub.c',
   'mshv-stub.c',
   'nvmm-stub.c',
-  'tcg-stub.c',
   'whpx-stub.c',
   'xen-stub.c',
 ))
-- 
2.53.0


