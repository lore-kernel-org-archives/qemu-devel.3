Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CEED37E3B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18f-0007qZ-TD; Wed, 14 Jan 2026 08:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18d-0007pa-U1
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:20 -0500
Received: from p-east2-cluster3-host10-snip4-1.eps.apple.com ([57.103.77.142]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18a-0006bL-NW
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:19 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 36C001800312; Wed, 14 Jan 2026 13:42:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hV2Yybxjg6na+16RP+CDNexXZ22gE/2/GrNlo4/7dxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Fy2uwUA5vmQV9wffxSONOPesWYHRZV6XI9e6k4oWdfjWGeLLEHgTblwBKLq+h+BACp4rwFOc6f3pmF4g8L6zNIa468TL+TJqavEjmNVr9KAHUbyxFdq1mCaIDOGQ7Y96UZDki8TRWtiNfKvjLDLMETjmF+QElSUSuuB1xVoGGWpNX6KCeog7fKtjLWZ3aI7JMrW2dNSm740e2aeCvF+jmDn08KColDqAHwRDN0Fk3PQ8mfB3sweqr3n89Wd/wFC+59TMhhD7VYAbFKOdFth7u7nO/DTxTgDcS70KrUQkoq5Gy1RJTuxR6ynQwunB+lb73CBPgeYbpwRh0qPRSuN3pQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 67A081800169; Wed, 14 Jan 2026 13:42:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 05/26] tests: data: update AArch64 ACPI tables
Date: Wed, 14 Jan 2026 14:41:22 +0100
Message-ID: <20260114134143.26198-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gIvDML9fcq_jLTZ3Tq25WBsegMtPOKM0
X-Authority-Info: v=2.4 cv=QolTHFyd c=1 sm=1 tr=0 ts=69679d36
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=CvHhVyPyXxbOnLnphYAA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX87zjh1qsv+PL
 T7zzQaEBWagzcshTdbeg/vsCYEt9B+Ws5TQvnWc7r7PHv3U4KQ+pfjj40GUjDwQ9WjkWaHqbMBi
 1JLWEuRcB0Y7o672yMMeiiXVi3iXOG3rXJBPSCPvE4s95dFyHvOQreXhgMD3SpCSC85Qf9e+xG8
 bncLJnr8bFJk7Q9L2J2nr6ipcSI7u7kROZBm4Kbmgh5YjcV3CWHOVaX4ULLUEEfW1ggwMlLGif+
 m+1K8LGWXb71W083aJSxJ1Hue4paTyStOJ0T4D65gXo5znd8rJOsdjKefI8roM6/y9r9XwHM0Mb
 l6FRHMF6K0SBx0DCl8w
X-Proofpoint-ORIG-GUID: gIvDML9fcq_jLTZ3Tq25WBsegMtPOKM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 clxscore=1030 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601140114
X-JNJ: AAAAAAABMGMm+54UfUzhfDn2ygS4PuLZol0HxOh4Lgmk5BUM6TyHJSflvtYtuul+uYo/9KytVeZFShCptu5wFzSGZNZNEASMzu49BHxVn9h9UKYMsPzZeCA5hVGC6eZVV9uN+RA+eh2T7B+C2FWzWNKOosilExqUP34xXp1sBXdBTE0DEhWcWfH78eVJQNRPxTaj+W9cQyGll79OC0hkWJljqUy5Tk8085yrb4RDE319fv1JXX/rjfQBPH9XPS7Ffx03rZ1Qi7Wle3LdfiEsyY17vbpxoiAHmlTOm/I0sR8viWvUl6Rj/x4O1677dYAWrTQQA2BA9emW4teV+8BYpMfFqyO9Mu591UcE6mdKPC/MBjO4JtBMMFFQPJfDSdxyQ5+kqJA5xJQ5cV4E+gjsZYT1vo8AiOeG3/64tYehREZRT4WxV7xfqoAlXWjGtNY6naZRGoErCGH0me9wm91Cz8URZf6mZKx+E6i3PFa9mK0/Ah/1gnmqWsdV5M9Kp+Q4FdGQjC1JSeVpkhtymiMq8S/Zkmyk69k291bJv7FR3Jqv1W4ioZNNiIeHJFAwTEmTXw+TjcCcYXPl0MJw60/G4bd8stiqqTvpjoYAPE/hdAj5C4B8Aw2W4/NeM4fGb1wY+7eihUMiDKq6om8msCdYHS7kDoozgZEQqESdPjNOBHJanXspbxMvgjAC80EXFIAMBjOk8RyHZwYsvTV/dprpv+CFehXGNL/gVUibbBxH4BPWUeSBOJecRFvuiLEoyG9JDXZAFtG60vZ25WKfCq6ARP6+lYAaXhlJw4zragtqpiWb98YMTl7zURsUxv1b8Huo4tvqCD/xVSqzcFP9qNGTz/SPybWwFOcr79mQ3ysADhoxbgb0X2Uh8zRdqgHnPksaLD3vRbyXtXmw0ljULWlPnF+M/A6LhRmtI0GbWKor/yxqfNRztx01
Received-SPF: pass client-ip=57.103.77.142;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


