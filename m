Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E687BD2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknpE-00051b-O8; Tue, 27 Jan 2026 13:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnt-0001nc-28
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:57 -0500
Received: from p-west2-cluster5-host8-snip4-4.eps.apple.com ([57.103.71.77]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnr-0003S9-8C
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:40 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 7AB42180024E; Tue, 27 Jan 2026 18:28:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538518; x=1772130518;
 bh=Um4hCs3ghGfgmqIKr9rVHUYLxND8garmvYDvo+fs6tg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZUZu1h3xCc/TAbviae8vY1lRAMt7qIXXRkvIHHM0vknYxE8b4vQxXwBwFUUlnLyCkZz6+0qJo73M7FrI9MSGkMcVMVMRrex8DsTQjvug1g3SggYewb6PAXvuEeyNE1+P3WELIt7trC+rUY0rw4EzTdL5WRgNtw3lnSqMt3u0cokx2pAOOXJaqGTNj8VIdCm5c1OuASGuD4rOWFNw8AJPx08wWnjbbyvLY4zFIuIbX9r1RdnOJKrDrZNGf7+6Mry6SysdQEdmhOaXGam6IM0Z1GWufuNyPqSbldF4745N+E7ofiExvjurpA8bFtamnDc5Xtsdv9Ib+e3riApLLFqDBg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 A194B18001E0; Tue, 27 Jan 2026 18:28:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
Date: Tue, 27 Jan 2026 19:27:45 +0100
Message-ID: <20260127182805.73212-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HDtcQxoH7na9HS0J5NYecDqr5ytgHFos
X-Proofpoint-GUID: HDtcQxoH7na9HS0J5NYecDqr5ytgHFos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX3xkISnel94lz
 FwIdaKS/71jtRsrdR46IbMZVd5wS+uyGjP37ZDt5Je/gZamEPXgZ8bI27i5N/LZ0sH9zZJQnBz4
 kR8lsrL7/IWnKxcGHnuXIeerTkec7bjLmW2Xgcn/CoOkcoQX+eEOiy/hV1S1F7wAwSYjehpiMfM
 mAwFumaQ/mmj/kTMjZaqN9xnmh5aJWJlibE3DmcHLjOOaO5Xc2ptr6BPZfvjjyJB/XFoheZ3xYK
 MsWScbKqh7CexXLHFZkN3tQiZ6LvCN+tjXo12UizaPFHCjFQ/iS76N8Smn0jg/i3A3rBmwPSOI/
 RgjBCts8TeOBSE35RonGleUdyu60fR2FuTnjSxy0C6O9L++8vS11gCkR3zAw8E=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=697903d5
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=R9vu0HyPPjzH36DpHqwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABHN1FOdBTX5dqk6GX5FcPVyS8HKHYQrvIR1fK4N5hijlZpY4KoymX6aqvKTINfYYubIY+IVvaPItbSI1DsXcgDPmYaObIysKASJ93TCH5lu/PfeJKwYXWGIMCac1XxPopfxvL1YubVm61gO40LaXIIHrvoul6Y7jaTCbMiA44tv5cW3XlVyLLyUbM5oOEcnrFNxh3re9ZTcarVmwxMlw2ZATe/ApypGFp6u3ea/n0Bn6HaedAG+Ct538KARheHe2fRFODkIU0hxF9W3pqhtIe/V+NZL9Q6YGNE11dCtpUvIrwjAkUD4fXgXV5kmf7dF/s/xvxPZNUZflxCXBVvGqTh5Ib+cIYmcBXiUDyC8cZNS/w/Hp0+hQC8B+pB+eBpb1QqcGvttRIW2VIY4FREkJaAHsBFfzT/kd6fwWrOYiG8jC9F0G3meGwRUU1xzTBtHNDLwnGSG9WH9DiDoTELdS6tNk7MENZZRmuAc6erzaQmQDELLznP09lCBufItfr7W8nCR36Br/4jYaObGQrv9oabU/Oh6pYWMdizeTtrR/eOagStJq8CfBkvwUfLk+qydEAowZuaxQ8E5u7OqRSC5lR4rnIz8ofeYaeyAnZVvuP2lUIXL1qf2ZtDBGPa/3XH3XXjB4fIqvBn5H7PpRR8oBLK3+p94z7bvA0ZdZkC+bjlYsP91HBOXyOAUqAzp/JK7X+rsilhQjuhZntKok6h/A+jffQqwan6269Odnnd0TYx0lguejjveUKVR7neS66Ak1Tj4lVUHO9EYXFKc8+bQgmAeF5D32yPBBsbIeYWHT3y5qOxJ7mbWpuCfJai9JpilNizRHVB8Ow1WhDepRYh4dc5NlyjKaWkJYXdGNf7UHehXM+/Kxwh4abb794ykEJBA/hEBKHdhz0e2CX7c8cp18eOP8V1KEr8kGKYGEeDAO3TA==
Received-SPF: pass client-ip=57.103.71.77;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
update the AArch64 ACPI tables for the GICv2 case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index 7efd0ce8a6b3928efa7e1373f688ab4c5f50543b..9cce77cacdda976f64eabcc7213646af25cb93eb 100644
GIT binary patch
delta 42
ocmZo*4B_(h4+;rkU|?Xjo5&?4$_Qi`05J$KsW32u850Ag0fA@))Bpeg

literal 128
zcmebD4+?2uU|?Y0?Bwt45v<@85#X!<1dKp25F11@0kHuPgMkDCNC*yK93~3}W)K^M
VRiHGGVg_O`aDdYP|3ers^8jQz3IPBB

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 67be268f62afbf2d9459540984da5e9340afdaaa..604121e2b25532351b5bd454b832a9f3f923ddb9 100644
GIT binary patch
delta 107
zcmaFE)WXE&=^qrr!pOkD>^+f7N|Kp@fx!TXL4d`Dfd#?>k`qJCc|ig|l@Ks-tvM%?
f4+Aq3kjpfgkx^X+rjJ2@f#E+$5s)r{C}scvit`FW

literal 364
zcmebD4+_a)WME)E<>c?|5v<@85#X!<1VAAM5F13Z0I>lOgMkDCNC*yK9F_<M77!bR
zT_CbNAPOcA5rU8tfYd}Fo(#m3AVP5R|9=P*W*^90CZG_)Tqd06P64W$3dGZacp4BR
z19WqlN*I`#feJu=QvqVAJ3&HV-~grnLnS<*d<Fpq2Cx%>^a7X|(1HJXfgB(Wb2oz^
MQ0yI03`oPo01?F*0RR91

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 41981a449fc306b80cccd87ddec3c593a8d72c07..a0df7fcc4e084a97a6ce7ffd305bd38b4fee984b 100644
GIT binary patch
delta 74
zcmbQjbbyh|(?2NW00RR9v)n{3DM=<E%K(T$fW?J@1;PT76GP28nS2<S8G&r3i7V9^
M4JKX`=71>$0E<}(h5!Hn

literal 276
zcmX|*K@NgI3`M`puy8?wi3^u3IDkhWzycE!jI!Vis5{Ti6^7s1@{>QmeVugXHa@5G
z0SNbY?1op>&X2C5h#<9Ops%#*0ztdHi8G?q;$EluQNrhn>{ys@`b&R|d8G8O{Jrdl
mkP$_?rfr{mN!3^;8w}Q?1auX1XIzvDUSRruoXA!(rn3!nx)K2Z

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 7acaf464dd..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-- 
2.50.1 (Apple Git-155)


