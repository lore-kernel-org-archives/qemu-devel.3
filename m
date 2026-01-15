Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8DD3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB1l-00061y-Gw; Wed, 14 Jan 2026 19:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1j-00061C-6u
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:51 -0500
Received: from p-west3-cluster4-host3-snip4-8.eps.apple.com ([57.103.74.159]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1h-0001sX-Mb
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:15:50 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 39A321800457; Thu, 15 Jan 2026 00:15:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hV2Yybxjg6na+16RP+CDNexXZ22gE/2/GrNlo4/7dxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NHBZ8uA8xLrbwLmcf6UJkzn+1spZXoOl5Wgbnuh3v2ll1KxOJFDqk6w9yEBmxZnoVFX5Efdoa3v4hylyyGLDaXjB5zVDLmIVqkE3R86BX6qtuinWNrZl1b7zvQBQTVLzyL1zqL9czUHTnwb26kwAIm7raZTeLRYfVxVr5U8IMV5xluVyI0bJ/lKQvfVgEiDM9ap63prsqal2OXJfhm5nM1vN8lfYrvguCRHqBNFKmpeYDchIm3AAKEzOwdtwppBiNRNvsiqs9Z3ZVmJHDOPWUvRYejmLZgTiKl2JffwDmVBbc5rKe8JRugs6P7EMo9KVZvXwiy5s57w+OAaiaXbuOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 A4AE21800429; Thu, 15 Jan 2026 00:15:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 05/26] tests: data: update AArch64 ACPI tables
Date: Thu, 15 Jan 2026 01:14:44 +0100
Message-ID: <20260115001505.57237-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D9PAkjc3qTxiQGKM1DbUxhhZyjQ7nG06
X-Authority-Info: v=2.4 cv=aNH9aL9m c=1 sm=1 tr=0 ts=696831b3
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=CvHhVyPyXxbOnLnphYAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXxdZ7H4LYbSX3
 II6D8Za1eC9JNXoCjKnm9JIBTYv7ByMsbMLnO6Iid/KVbNWIzdtFG7WOB8fnOphMgXaOozjaAIb
 fVwrRMhFJbQNO5da+ocdCoOGW5haN2QSzCF4/7BZgst+bRe4v1cm4RJGTgTrhusnK7Qs59GWSvO
 gfFNDFQVYngUhnes8EfAyCceVefB+rGyE94xXucDXTrun+fsmLXkHxjOuF/OIwrcpoecYVom0/P
 v4JclZMFJsLxV6VlNiUlD1M7Mn8twG/ZdC5lGzRTE4PzMRbxEhvk+G+fwDiE++JZvoqnzYBgZXH
 DseTMKQ3GGoV/T1reRs
X-Proofpoint-ORIG-GUID: D9PAkjc3qTxiQGKM1DbUxhhZyjQ7nG06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1030 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABI8VYlyxJxxtAMw1tFGJKH1yNEqdaXwRQh6NK6JkU8kX66SGsmCfWa2a8IpLIrDblszjxn164N1+Nf52QOdZvyAJxjvUWzJTZtXFUUkinK3j9UyID1UCqQQfUIsxh9AtGZpieBKCmlonG78pTsgtsfindKwQKhgdjS851Bg50rFIQyVfDtxwAMfBWyyzDXPi50/kKurkjzr+DtM3IQg/d/v8go55Lc9cgACQX4bO2qjA6wH9oIELX9KcnPOYzfoFkQsWnCpduckDmdX0Y6LqhK+WnOn81u604Eepph3MQ/iCz9QbUG4IhLTQKK9sdrGgdcKHRQkMOuYRSwJ4C+Qij8PIuWZNlSlltFPuAnesHZEZ0cMFnWEfLcLZI3xyyCAgauFTGqYT1wyyCYRIOn01HM6ZjQqx3Hbd+6xFKGoTstjoz2/W+V/1L+CvCUV+Qi6EZBkKiFW95U9cdXdhXr3dsNs1hvdknof5ZtqAUZzpk3VcOFtABBmc1SVNfyHrrM5zV0v8/DS3GzNFM4VWD470YIk35TrUq7IaoI91T6UmdDjzNpjTNXUx8mXQp0gVZzDVek9xG5FaK+PjCbvMJPE/NtbOP/AswTS9WygOK5QNxRKfqp+rK9rWgewHFkrKsZCYM3YFrHp4Uv8vxkauJJmL/e8QSoI/qsUBuQZ3B3dV3OzLVAuuzlFh7Kls/zj0Z+21BUlkkNioO+iAo5wUI1AfF4k5/c2F2F5XV7M8pgxJmS7cNN7GtHJGWnGc51P4t7wCvYEeRR4vBUczFO/halvNhJKucsHsXT16vX/EaM55S3hhLYQQOa4EmT9ZSVex4uxMksErYFvH8IZxnj4dVR6O7KKItBkq2PiokakgF9UGeRbFEq8O6HeHFVe72PK/WAIYyFlbn7GNtWgTp8K0oU18LUs8TeVWgNUE9vn1pz9vspvdhh9XPlImz5fT8Empl2kkMJMjeMs4Vlw==
Received-SPF: pass client-ip=57.103.74.159;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI table for the its=off case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


