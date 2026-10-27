Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5B606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GMc0Ku1B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K3OkIILw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrJ-0004PB-V5; Tue, 27 Oct 2026 15:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmr5-0003qr-4h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmr3-0002QR-HE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHV5u2088774
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 asW0fnKgIrl3DPjD+Lpdh6jkySRQYntuOG0pcCHmNCo=; b=GMc0Ku1BDH0CDEi6
 nnQVecmmVL6n3+22v7yZeFpHr2JUVR+S5mVw/OXuoTWug451ZBLu6JRscoOr3MB7
 d48trJrOiPMn6dwXDVi36qy8YyYpuybBl/fZpXwfcHKIZNfXwqk4uV01Nwr37Zmn
 ylm9KjDgoR8l2p+NJatHwDOX6SXr7MiPVdN5WwZZaTUc7/4l5vShwgXJ7kQwaGX9
 gqHLYgi0MjOyybTCdJzlPGuPWHukyYvaNVTMcIyOAsLhvtWlD7RvP0GJGzid2pw6
 wH+4UqtiGgKj4hsABgXUbHrjr2/F0/5mWrOpl7mQ4EW9QS+tsxndIBR+kOrA97dt
 MKumcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2tbb90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so18734885a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129338; x=1793734138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asW0fnKgIrl3DPjD+Lpdh6jkySRQYntuOG0pcCHmNCo=;
 b=K3OkIILwKluWfSIOhBV2pDdfIJ+pI1NUmR6lJm8GkynCfM0UxzGZdY+C1yIk3cioC/
 YSKR2fJlG1zD+enxN1fDIs80XAMlOYxmgEOl7dqq9bD7iDyx2pMsxWO2YQI4igMzRT3y
 IK9ghjppo43KAm2nTEy8dGnaH+I2zmYmrcR5e7tKLV7teUpycT8eFTBlXm/OofqE6TEr
 FSepB8zQff/7/JD1vkixNaZ1NQ3vCuGRIs40GSxkh0w37gpQ9qFV8v63djACpy60pcY7
 ZxrqT687qtDXYKY6k0mde908ORZx8tQR3ZPbN6ZZeWKRX6QipWzo2DXuMoshTB2Oj8bb
 4Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129338; x=1793734138;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asW0fnKgIrl3DPjD+Lpdh6jkySRQYntuOG0pcCHmNCo=;
 b=RKmsNQb/AhZZU+UGSUM9S/x38/Uh54xTRf0ItexSIBwF2tFKwfeSbzKpNnlTLEVYC8
 BsEMekf0Tspg2NjUjQ7opEGMz99BzWuFOiXednOq6LdOQ/UJQ7Xf1D1eE26jlEUCiUjV
 KTvPnPx13OdgzCoGXJrsLq6nd757g5Jpltxd8u2fQmwJaUOoU4XAdvaipg5qo6VOYHRR
 UYBkFEFD4WTix73vf13aoRBQQg1nPVEwIQxUyN5uDaNOq0ts1E1khQKu/dKCYMgzJJ+S
 l14PfR5OwmEHa0SgetCis4JyrTzC8RGukoBEicgnGe1jaM/YCd4clteaScU1xXsbfWG6
 YDDg==
X-Gm-Message-State: AFq9FYICAYvcdwZVgXAH3657F2gsj78OMRmCT82iQzLupcMy/DxGIDJ6
 hn958LQx7KDF7qK8k9VgMy5rNN/7DDKQdGVuaT9z5P4oLNdQZHmJoMtGFpWfMxqmbd068q5zv73
 72js2GTQ7lVEKwVAhf5ZZyco04nP5ttQ0Z78Eh8JV2md5b5f5Ld2szgtk528SwC5jSA==
X-Gm-Gg: AYBFou2ginEzrxKgcEN5lsjy29BfHFfsNCxUXIiWglazBqLveQbngmlZNXWv9hUBU7v
 4SK9cO2mJHgV33K3AWNac8U79Ag8jfSqZhY850oH659GnplsS7YkZ9zh4A+RrypoZVRUu7z8K+i
 0DbTs+21RMP7fqwHfBXaqR3M7aIN17P1Ax/L4Rr4R6toGMb/cudHM5JCMg2UHnUslNisWXyMiY4
 EqGagtz+AUBeSLxjBI5Yytvylq5YhOmFW/GlAaE2bFM4hyGnObA5KZLgm3+3FXY9PAp716SAS65
 KY1vl+ZCs9F6/c7NttnNmdzsGgVauhjiQTUmqVimNUppbaUgLvZ5bLg7oBnjMFaCPLa74rHH0Ze
 Re/f1bw4MiUCFHsEBNS+x3R169W6j4sbvGU4+hT/W1cwVK3AkRmxt+DYS
X-Received: by 2002:a05:620a:2a03:b0:93f:3a43:2771 with SMTP id
 af79cd13be357-940ef9c0385mr1738137085a.78.1793129338315; 
 Tue, 27 Oct 2026 12:28:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2a03:b0:93f:3a43:2771 with SMTP id
 af79cd13be357-940ef9c0385mr1738134185a.78.1793129337776; 
 Tue, 27 Oct 2026 12:28:57 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f37csm19873557f8f.8.2026.10.27.12.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/59] hw/arm: remove pci-bridge/pci_expander_bridge.h from
 virt.c
Date: Tue, 27 Oct 2026 20:23:27 +0100
Message-ID: <20261027192341.9197-47-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0fb7b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Z-43qC4QWUjs9AUqhlYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: aRGcJJ_ThBjJ388tBH0fZJMvQdKmnHBa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXyEDi04ygvMrV
 KQLk5GIxjryX4NAgJE6FyOxajHf6Czts41oPYwcG47hN2L3Fu2c6XUwMIFHhEymlw+AQFoU+vzT
 lVqqWZjMriXaqcfW00QpIHSmZPHGd4s=
X-Proofpoint-ORIG-GUID: aRGcJJ_ThBjJ388tBH0fZJMvQdKmnHBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXwaL8NRGyErPY
 81Z3KVdbQLr9lwBlWPJMmru6WxGXDJBop1rzBD/AD9C/5E6XGMlQxsL9+QxvsUZKHLo9wTihyiV
 RShsU2nRBVIIIX7BD625KoBRSzzgZnQJ3YJrg8ABFxeISaV6iAn32LSm+pCHKKZUB/4fmJ645gJ
 dMpFvLlizAfvuv6VfXAbooddhaYGfFplBbXZ/GhE5cUGVI8NxjHvXVQjPwvwcO/FtMjUhEqlTKz
 KTJNy1TdyjMbVjyb2tSAciuMlZ5Rzp4meeSnMkjBsbqZyKD7giyGg0cWgBKdHtBYGmvyRq/Hjzp
 7rc6T40bvCJtWcNsqE5u5gj64hiaiJacJ14WTfaPdQLkI1Z1D0Bp8MitN30MXwqXsuLhT+igL/X
 34o6Qj27j5XOlt2tU01XwO0uKle1L8y2cur2EZ4VZyydO1MGT2AzwkegdyFci8KYQ1VelB5b43i
 0EnpRG8/2DoTmRZb3Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

This include is redundant as the function is declares is not
referenced.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260928095646.3555447-2-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d56197dacee..3ab3ad8c3b64 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -58,7 +58,6 @@
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/core/platform-bus.h"
-- 
2.55.0


