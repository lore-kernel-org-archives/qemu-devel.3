Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA91CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SyM-0001xj-L8; Thu, 16 Oct 2025 14:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxx-0001jf-Gx
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:46 -0400
Received: from p-east3-cluster3-host11-snip4-4.eps.apple.com ([57.103.86.107]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxo-00028Z-OZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:44 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 43FFB18004CE; Thu, 16 Oct 2025 18:44:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XXxmCGrw3A7yoY22VdhSWP2DZy3nPyJTDepFV431JiU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Cw/TEzP40W3swutdjWmPpX74JjqrruzhpnQtVL445eEFl4c4s/326WQWyEWUWYx7KGWsNOPnP4ARhSr+P8IILapVKjj/vsKqaHkFqZxxAr1EgvliSqqUHpQI2+hTQ/zcR2YheCNyyPennX7SuI5ms/UrmOTnbaoqJHEbXngOhtvtk7TgU5uVkjppfqwwUGtnCpGVTeySN0AYBavjWCbRAKPylBVyZUuNph9+j/NJrqJ0Wf9oPwa9h7jj5DAHboCyUhLFnjUiolqFVnM4UD9QWi1F0ele44h/0ZlmoxAB+EhL6qYJjOSAyaN88Ax0HD10AKppmL0/SxfuMj4+uo2HcQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 3D8EC180016A; Thu, 16 Oct 2025 18:44:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 23/24] MAINTAINERS: update maintainers for WHPX
Date: Thu, 16 Oct 2025 20:44:12 +0200
Message-ID: <20251016184413.69870-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzOCBTYWx0ZWRfX0Zn8kyw9pWph
 xa96uSJqfDXOqRG/TdNQH5HRhN5hGpfVJuE0CSNtA8vcrxqTBBMsx2TLQdOlZdgmIMv/HrvSP9D
 N+z9uzHPVCSJVfZDlR+H+0Kl10pCQvLWOs5OXQyv4uB+R1KGznyrVC9IJJ6N5016wg1Q4XykHFt
 e5cGB7IFkotGFt/wcZ2Yimed6FxypV5yiauBgftmQ8Y5xqY2tKTBQ+Qt8BEIM8AkFys3qD+57pL
 ++LsTqcwZoMjhH34QAam1VwP3wo7/Bh19XkmDDxFnUTqquGW7o5h3Vd9W1DAo+w3kloQNvNDY=
X-Proofpoint-GUID: xiR9UMQ86UUJc0esBDr_gb4B8KmN4ptD
X-Proofpoint-ORIG-GUID: xiR9UMQ86UUJc0esBDr_gb4B8KmN4ptD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 clxscore=1030 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=783 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160138
X-JNJ: AAAAAAABWBtCAu85RfgjBu5t/54PxrlLDSwzN4LEKNd/0QjSJ0Qzxxo/YWuIDkgLeEw3GputKX0Is8NA7LxJ4UfO0lOw0ezh5Mk3Gq0Q9m53elFdVnNcinNrky3vivIUXoM4JxMYbR7BCUnctLS14PcTD9awnp7JG67OiMKGGdu44IWL/V8CVjXXAQ+7VFt69ARKWCEzx4m7ZKA/CwSDIF2czvuLx8RvNSQuqyCZMz7eWJ0mZrHJYHlCIocmHqMhJSb6i8hHY8cHfkZXhBnny2PxKthy/ltygOeqL80oc+MAFlPdalQ3IDk6XDA8Dz5gsbDAgsbIDt0wRkuhPG6yYwrCOHSztteKAu9m8N5ZDy7khkNnDRqT0IYtmoN/zaQQ1TYl5lh52IF22Fx9Fv3SaBhscUjuGj2P+kpGWFo3d79AjemRMma4gE/BbhCHnR+o3tbUnMFaCC0JOFz8xXT3hlyD21Ne0KRXF/DpTKj8yHQxFEvetatotZKoFJpJyXDqIdkOplPAqI+dbgCPvVWMPgCqJ4uU0DrwTaDtfxHjZkKFD3sBnweAfQYnzZQGpk5uJdj8nA71mvj5jqKWdUlGjX8L4k3aGrqNgpU404A2on+aYoms8UKwRTG8gDbiU9wti+GBSqyeS7eLcUj9ODf4ZsIZ7YCtE49vQ24PSCogCYpeGRvAzF5xjrYjSgi+UO7JArinGdUVRE4=
Received-SPF: pass client-ip=57.103.86.107;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a516e66642..5faa4a2fb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -544,11 +544,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
-WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+WHPX
+M: Pedro Barbuda <pbarbuda@microsoft.com>
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
2.50.1 (Apple Git-155)


