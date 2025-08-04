Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D244EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixS0-00045t-Iy; Mon, 04 Aug 2025 11:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw76-0005t8-U5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:33 -0400
Received: from p-east3-cluster7-host3-snip4-3.eps.apple.com ([57.103.84.154]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw6x-0000Vv-Ns
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:31 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 51F9A1800097; Mon,  4 Aug 2025 14:24:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ORjIq98RNqAt2myE+K1Z1bn0jWLRyUgvyM5hgDBgD7E=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=DbrakEGgh1Pa59joMuqFblQwbfPBCn/8Bkh5Tj+HSRkDgbLMAs12jLxrP1Vzkb4AyCrKp4qzGWQJCrtY2EHBIdAWyVMuCH0pXZkinDE6HMsrMUTKD+/20FdI/aaApeJlOX8Tz5ezDiQnO5YKU7QlqNoljy0MBdUDsk1zvCatkbarBguSG1lQIkZIGSn89tfqCKclpcKghkHqqr4ahCvh5TH0QJl2xGs4jHWzOaly51k7+yoO065rB/m928o87Ccc9HDELu0l4j7hdfoSbOVnnc0iYFYStslKa8Fkks4YbExL+hsK5Ax8LGVDrr+5VEMjCpex/x5aTbCTR3XVubyokA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 51BEF180033E; Mon,  4 Aug 2025 14:24:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 17/17] MAINTAINERS: Add myself as a maintainer for WHPX
Date: Mon,  4 Aug 2025 16:23:26 +0200
Message-Id: <20250804142326.72947-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250804142326.72947-1-mohamed@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: J7xs2gv3Sd4dP18bhbGm9zO3xDvxMYpO
X-Proofpoint-ORIG-GUID: J7xs2gv3Sd4dP18bhbGm9zO3xDvxMYpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfX5PeP4T0aNLWH
 N35wu2U72BoJOnd3RX/ellWEgX/+xWAqiPzR62AuVoovFYwQuxlNR/47GYGLDvdMR59b+hRqyP/
 RtTHIWSRxjDTm1t08GMgAqkY8qv0f0O1KXcG5+YXK8QFU+5e1L4tMIzaSUQjTf6/g+GuhVkXLFF
 wFDHTd1Mtv64gXSk1od8yp6qdwvbT7+oJvJlBS3jTnUgF8ru4mBx8jrguMj7QeI/R9Pu5eJ952y
 IKS6pJsPm1Alt+8PJ4ShapglSgMRJVttpl6lJyx+hjWT8Dcv+3AYG2s7cZs1YeX8QNV7XqlVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 phishscore=0 mlxlogscore=920 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040079
Received-SPF: pass client-ip=57.103.84.154;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

And add arm64 files.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 259b010f55..9397e55c4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -539,11 +539,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
-WHPX CPUs
+WHPX
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx_arm.h
+F: target/arm/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.39.5 (Apple Git-154)


