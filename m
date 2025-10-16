Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253CCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RI0-0000sp-Vf; Thu, 16 Oct 2025 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHy-0000qT-Jy
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:18 -0400
Received: from p-east2-cluster3-host8-snip4-6.eps.apple.com ([57.103.77.247]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RHn-0001ZQ-8n
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:17 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 5440818000A2; Thu, 16 Oct 2025 16:56:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Gzby4UYUzpY3g8LA3ulEXCMPcPTQQUS2RUpDEfng7KV8eR/8kRatU59mCSf6dDHjSHWSxYFofepPHbZwQ1kDiEiLY3F7avCgMyhtvhdDcATPd/eL8MVBt5QQC41ntQuZVK1Ka0kUozgmvxIhWXHhZm7xOttxBPEQ4APdKXOPwEXpapTbqdcmd2+5X0Bd579pPpcZ0/aB/KQNMc9dqfrMcVJHdmaCV2HgUlV/gT8bL/9dW9i5iyTibQ+pSAmyobB+legHBSy+Lyc3b/iQGijtFivpEdJ6w2HV6neQPXnwFQ0sYAtkrR+1JVkS6DINoRW4OHPEMH/UbaN1vpFq6r3BLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 1B4C818015F7; Thu, 16 Oct 2025 16:55:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 05/24] tests: data: update AArch64 ACPI tables
Date: Thu, 16 Oct 2025 18:55:01 +0200
Message-ID: <20251016165520.62532-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nL2f9-qVKTAOT-czoVdv_a_CelvUcbF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX7McmO7U0ku9C
 Vo7zo9TnQ7Dqp3OkEkuK8UHp8I1ZYgSxc0nMeTY9GVSTrf6junCxUfKvo5JVGudhpczISVV+YAT
 TNN5rPnhJplCJvbIQFPcCkF+9yuWXnu/mmH+vuAZyPRkg7/gIr5qOvwr9Tb6hm/J2z1RqzTZMP9
 ra/1O/wMGZMKKVNArF1TeE4xZEoTQ7NmKALced+StQz3O2H9391SQP98v5a/KkLoRABCwm/y/IF
 jOujzwEP+/mHcDxTAffFZbHHZxZtwlcf+PQmoEVihccUzUoEpWxnyxPJl1IPizaZnepNw9Ymg=
X-Proofpoint-ORIG-GUID: nL2f9-qVKTAOT-czoVdv_a_CelvUcbF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1030
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABrUdMCKki9ilHdx9Qzz2Bf5D66wXh2PwhbP78n2nI7EphiiJDoEK87mNlONjy7lPHd1aEdwxgT0usOUl1I3zjVuEdkDhzLTrqMcby9qzqmYG81p5T9RNSyN+TilfYEcracdJZ2NR1oK0Vlll5o8r8Tlm11NNtFlRv5DnmbvCiyyUWE2yRGRolW66qziVSfooOhnj1NIU+xM0QHKRsJWMrdT0eh+P6ghm8WX1z1pfGgRCUR8rGh5CDb6IgizU4iBwigB6Z3ccn5REYtMuZZzLQl2nlr4GB/MbcgXWR7rW0c21vJ6WeK26jPbskBEyuQ3wph+crGO7HNHBUd2PW0JG8uLkJdn8XN3dY1h7meqF4+AE1W6IUUhpxKfbgDjiLowHSZI2/s4Y7kjQWI7PnjH0+mABacJjO9Fj99h0sBKdCD0ENVPaYuxmNrrm2TsdfA46afg2Ct7iW0LOzTVDBHMO0jdvCkYKzSUFsDV4zL1VxCiQXXkjaasaPTI5igGuWb1Yncv5c17XMJ8gjC/Qoz3eQKZWKhde7P4hf2whmVwhBfh3JvYKa9xkYnDOgDGslhq2bitykTIxre7frd0WB2f2hUUOf1KxdbfOanjZv/wWCU4CXYAKqop/SIUOWOvZJ3VZlyDf6get8y+iOI7GIwuFnIM6So/ryum2o/O0V1hyvHq3ehBFaBeqxRfgdD9//SqskkEhuTOwmNJgTU9+HTjEjMeYtQoyIxp4PbGD/TyL+Tl7m9BYMY1CgIxV3r0H0SxSilsLet5jrTpHmcpyXwah4HhMlf6fCxuWZWC5mZT3kXTeeV6tStxu3AYM+JRPvKFltM/RujVcuuPxchEpgG/kQhyt78C/T+dq12C2X3E3VB2WGVGa3hARyveO24sGjQ3CE1poSNAlg/HpUfMPyIgbzdt6f
Received-SPF: pass client-ip=57.103.77.247;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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


