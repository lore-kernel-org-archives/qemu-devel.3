Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AE5CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RwB-0006PE-4K; Thu, 16 Oct 2025 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rw1-0006HH-3d
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:41 -0400
Received: from p-east2-cluster2-host4-snip4-10.eps.apple.com ([57.103.78.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvr-0007d9-Si
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:38 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 1A54718002D4; Thu, 16 Oct 2025 17:38:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=C0jbpw7IwCr8AyIlvSXaBo7hdHNJXmFGv9xpdhp3YYBtRPTCNicSVUzD7Gos2zptDlfGqjfjPck4Lf39/s2SNxDXEg2bzC1ZLME6KEjrQLV8trBMRZRbpVtZpgYMjE+iW37H4LBjrNLpZ6IjL3slAtULlo7sJ3LHuneUewKNRommhESpUX/8sshaZxhgGjarKj8+xowZuq+WX1xUzmfAzZx1mtdQJg0QSqctf1SMM0aDa+OD0EACQAFwhimItBZnp6lZ7h6VO38VBMCCrA4J29U2/gdQzEk+BBGzmog9sozsvw2F/DwwLMIl/Lx+tPEf7LpCEzuoijgwIU/PjhrQYQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 7C70B1800155; Thu, 16 Oct 2025 17:38:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 05/24] tests: data: update AArch64 ACPI tables
Date: Thu, 16 Oct 2025 19:37:44 +0200
Message-ID: <20251016173803.65764-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX6GdROmTpds6P
 i90Dyw68606tCqXH1PFpC1Jyc0CEaRZIGwpZXNhMehyVxxhfNabGNPZtgcfslFvbMP+sKNDw/rI
 3t4xIZNMxxgxgpX4fE4gkxaBjGUCgUSSXDcT0G0G5iZvwq3uB+z3t0nQIGmiY/qmpJDaOk5x8p1
 2qtOxn5vW9OrpcyWH4upq8Jz72VF7NXUA5Sf57UwDoxFVjtL+ok7GJB32xYZqlh43f12XZYjLCT
 ArzDIkjdDRqmtuKEwOJD29D/KMp+dMRVTKvXBrMOhZnJPR/+hsUbgnMOnR4nLzjxkBmY1PmXY=
X-Proofpoint-GUID: iTAcvuZeL5un4Sml6QXsiwRkb8b9IaBP
X-Proofpoint-ORIG-GUID: iTAcvuZeL5un4Sml6QXsiwRkb8b9IaBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1030 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABl1P07TQrPn51v/3GM3yGdxAuKJrhM5B6RuIFfV6Tpm1lXjrmJjd4Lx/cfqGxwgrAgoS9qv0A5XanJ3xQodRaRm0gbYyLgol6mwYlw3vpyQsouKyCp6ODTKXr2PFKN5qiUXoo85a8gl/PhpdZdcKT9YReX0q65ROEasaBzvX5ZnmRjtD1lrrxE4oVD4bHdl1E0GXksj/uOgZQdISj2qQtjWBZCT/n8Mq/FqL3GnN2ST51xre1OOhAdn0zmblab0gD/Xl1betnpqKQWr6i7QTXYG3wMoFLPDp7aaiomQpheFiFM3FGYgLXSTXZeTqIQSf+N/27yx1287wGj2y65TGQB1vG5gE6hLjkl5jsp1eDtK3VPWeGsBKjSQRRV4YJU8GJG9hLbw2Dudjsc4hg7vflD6PAd/WWf6XedHNLKMUIPvmhK2oSUbSgLAm7rwd3m33TKZRFgM23pSRZGz725rNH0nW9QCCivmmJbMXTnryJ4Wx6rhUJI7qKewdZA7bh4qIsAs4vurIBZJ5CxhhR3Zeh61IeMxQ/LgMxqjQuYYJs5WKC0YqgmQnRFOXDT6k5IvM4NBlRwjzFgW/oDqIovPTmuWLNWtCdbNfdRTzwBKcl6UbxhTAKqcU0MDns1eCUCib6ANPxDAdaoCfeV5A4h22aJEMJT5f4jz/MSpLa9D/b6HvYc0ykqpIbslGa0Fm1kUcQYmVzx+TOnFDVo/0lZmZNsHLeZkK+sENmYNLQW2MJzT8aXtjSHvpcEdFRSMGh/3oGbxTwBe0jdYmmIW82yrkDI75paapaKNTyMOqA26sxbFExMRIvCfRL5ftQ0j7YXsP76qxJ5xJQjWnz/7tlK91f+Fn3hQ8Mkc7tlA3+EK1/6PBvorZTb63gJEjlqJi2Y56zrK/2pLFIAHSZlRNMuAmFshJh
Received-SPF: pass client-ip=57.103.78.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI table for the its=off case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 164 -> 188 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index 6130cb7d07103b326feb4dcd7034f85808bebadf..16a01a17c0af605daf64f3cd2de3572be9e60cab 100644
GIT binary patch
delta 43
qcmZ3&xQCI;F~HM#4+8@Oi@`*$SrWVwKqeS4aeydBAa-B~U;qHCpaq8j

delta 18
ZcmdnPxP+0*F~HM#2?GNI3&%vRSpY3v1aANU

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bfc4d60124..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


