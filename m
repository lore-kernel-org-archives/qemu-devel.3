Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BE7E92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNEJ-0006BL-JR; Mon, 29 Dec 2025 19:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEB-00069C-JU
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:43 -0500
Received: from p-east2-cluster6-host11-snip4-10.eps.apple.com ([57.103.76.241]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNE9-0003gn-3N
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:04:42 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 A11AD180010E; Tue, 30 Dec 2025 00:04:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hV2Yybxjg6na+16RP+CDNexXZ22gE/2/GrNlo4/7dxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LWqnxoehwIouIJKzVFdnVgGgrcd6+I55ZGmrGbB9X6LBX8RtBJL/z3k1Mp4VLsrzMw2o7Ea4d5Bm4K5rYxMeX/kmwmxlwt4Ntoo6Y6MYReIsCeTXfYuiVuDwr+OVet6cBj2g40EW/P7vfLh8qlYU0Xkp/IcrDozVN1qYiYgrMkoHle2uX62sK/LA3+Hzr3SnmptzvSGL/hyY8qLW3jZ2J9TjnQowZA82F2rJb9scTXGv4FQv9FjjHYRkPYEga1lu1rzvlS+fVhVuaVeJhhi1DbDcMmdDVo44f3WlQXmIsGnSm9wYwd3GfsS4FU+u437NiAri3TbCB8KzkmtHbI8geQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 95FFB1800470; Tue, 30 Dec 2025 00:04:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 05/28] tests: data: update AArch64 ACPI tables
Date: Tue, 30 Dec 2025 01:03:37 +0100
Message-ID: <20251230000401.72124-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXzr0n8kjFQ0Rt
 3jGuee6JRWluTouaBl+hF9EhSv4YrkHN+6FAmuVyZ5BOziohAYR54DXk2wjo5XIJG1Uqn5tSXSz
 IGt+2uba1RRIYEjUev7voh9lXpJu3AiKmd2YMlePR8VZSJheVftWMJ4SdZsFcBDN1jKSvhGNwv3
 D9gYHTI8L/FzO4P+7p5YO54zChLqd4Hmphmr3JxoDAHysQ7AMz09z1p+KXyzG4B0eClx8qTB5hZ
 jEKPbYsBoFENDoJkYHTKK+f+oqsxm5Pce2NWfobVwgupxx3qWd/mYKCqx/EZ0M7sNp+WOMbfnJw
 z6bh56pn9EhCpZHAiqt
X-Authority-Info: v=2.4 cv=U/yfzOru c=1 sm=1 tr=0 ts=69531718 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=CvHhVyPyXxbOnLnphYAA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yryoRvJjgk-Di2T_fQuzoPwibFl7TpTY
X-Proofpoint-ORIG-GUID: yryoRvJjgk-Di2T_fQuzoPwibFl7TpTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABw/acp8kOWOfo3bcp1IUcb6PCvVXY9axmqwE6xsmq4aE3Ucqukr6557JdaC3ubKAUwbNALTF3Uq+NTd1ddx9xz58cayuA+IEAGky7jVhFfMLdNnqEWgaR3MNrzo2ZCkGs09hdZG/pnNVS31G+MOV0MGtyvFNgX9rtAu1+bCupToe6wvCyB72rmqRO/hnlxDmWu0s3Kx8VxGRXufksd5HcegB/5AS+8SJgqiZO4gMkvU3zZ1cuchmdaQMyShkWtRUNsjbFy0GazUlwDGIOTnnO6qzomLPH/nOXbOx+TCLSF4Pt9pli35+JDHje7cgPRof6dUFmVELtBGuB2gfDBx10JU8MrKHxlBwNtqU5kGyZBxaSscKdANXUu+N4Q1ZSz+zXgUcz3KowGEMoAgXLV7T+2QwfZ9xdyw8+eGYB1NzTJK5T0cAt5pw0id6fk40ZpBdsTpa8QiElTStkaLnsGYvthxd7EaGWk6V3AZQv3swSvNnkqLlaKO29xTPFeJd80SrZ5ueXebCALfGqqQLkGvCE2F0+Cch/aFyjl/VBE3jZEnX3PpRzLESXjtNODCyQlrRv+b9hNv3USIxaRaYA2fDrAypN7Q8VeN3dboD9kvCbqeq514F02MB77Q+vYUBz7B70UttUUGXNJ9qmHrgPhZSpkZxtHNJSrYChk+zWgv7LiJmpmz0CJ4vM8HJuWR0F28MXUiiwEssDm82XJ2wLL8lL4g8/wscR4hBH7G1/Y4D454d3QY5r7s0dRs6XRwb0VMGJyUSffR+fLxbcwFJNGYtLile17KjemTWK0oL9LIxDbK7bRB2pSHbmnMgGk5zovsX4m8JG1/Tx3v0cOZvMDehywcHV8PyERALP49h6UayYP7leYDnCo3ykBdXlnHdFzvYeW0GeMutdQdZ2siRVA+K16Ds2EMVJAffqJtkjsp+CrXxW231KDhIJ/1RVpFHw9p+hZxjEiEuOYg==
Received-SPF: pass client-ip=57.103.76.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


