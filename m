Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE94C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 08:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7VJ-0007Jf-CG; Sat, 02 Aug 2025 04:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rx-0007qa-OJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:42 -0400
Received: from p-east3-cluster5-host8-snip4-8.eps.apple.com ([57.103.86.209]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rw-00058H-5J
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:41 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 C247F18000A4; Sat,  2 Aug 2025 08:18:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=OlK4R47u4AAAXgW6XizaUWynoJylvp0tNc9/rAb2RFQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Cpc97coEFOjsZ+ejpAcjaX3KP+SshmacGdldsJG82S2oLOwIsTuazjS9p4X3EQhxxBopbS8aqq43hXiHJxkzepH0X1Nhr9CdNRBUTYPrI01bMAPmFC5PEQ6wWN0z2K7wG1aU7Ysby4nNvKXJlx8W1p1WXpmZ0BvsACvpsdSUmXa35gk2iHW2uLMkpoSp068hr24i4x7Vr/7lROkuzs41siBgc6vZRuKLDjgvHYVwKNF4kZ4t5lUIULuikbJB5FKMRvzvaoRlw8OkGzKWrGNp0f3nsDWbbiiK1/wZgSVkrcaTmNEKSYLC4mD4rerlJ80+DOJ4IqFZsqG+5UO8lueHdw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 64A6C1800148; Sat,  2 Aug 2025 08:18:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 14/14] MAINTAINERS: Add myself as a maintainer for WHPX
Date: Sat,  2 Aug 2025 10:18:00 +0200
Message-Id: <20250802081800.76030-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MSBTYWx0ZWRfX5hoUibfXTj5f
 ZUyljdCstVlqNjNtGWY4ulygB0yQGVZSFvOCqZW9oqCi7SQ4FbqGgxZ4QQJB3H+ZsiTDDY68znO
 wsnUlnkc7RwCjAZgLzoB5Ktt63SjmrMorhvG1R4MXpEWIrM1LwMAen/LRves/ldwWPiAZTy6SIU
 ujmPyq5BCyy9TMpCjFxNkUBQ/J/4TIDNGMLtuvHa5UeW3VOLXuekCLZ7WlZhwtCy+NadjnPtqOn
 PonDgjJzqHjExrRi2cAYZALRgWI2lTDw+nOoERHbOr5Djo7JikH+mBtJXnJiMk54MxNv4ZuPg=
X-Proofpoint-GUID: UBOwc7kPtDxQFI9nxTIY-4hHq_iLgmY8
X-Proofpoint-ORIG-GUID: UBOwc7kPtDxQFI9nxTIY-4hHq_iLgmY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=914
 spamscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020071
Received-SPF: pass client-ip=57.103.86.209;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


