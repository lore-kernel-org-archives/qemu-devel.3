Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B88AD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0cS-0004Zz-BT; Sun, 28 Dec 2025 18:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cQ-0004ZG-JH
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:14 -0500
Received: from p-west1-cluster2-host5-snip4-10.eps.apple.com ([57.103.64.221]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cP-0006aD-3K
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:14 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 9BD401800752; Sun, 28 Dec 2025 23:56:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EhdKuuGXovxeBXiIk/XxQnw2XbcgWFsNaH+cudmNtIVEjkU8O2287kzrXPbIDU0NVXFK+zPayzVDL/D/1iqI8fTSSLC8VVytxan2gyYM0zmdBJUxevnBpUcmi1yB1rpEJdCmMZEvwze5FnLlAhjq68NZelc/tqiqxTtXiRipoj3/Po7/QnYeQ52mPSyAQZN8W3I2zlfnE4HxZ3Igzoe90ByViw5PsDWvjx8s5o1L2reuzNkMkGh3OUwE7Wlk2J4HpiVR0GL6Z9lrOwKhnoUZL5jBcpoTC52m5dmpN3uZWwzE85LlMVRPDAwjDhM4FwOYrEb7VCfwBhIzgriMCkupdQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 00D851800751; Sun, 28 Dec 2025 23:55:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 05/28] tests: data: update AArch64 ACPI tables
Date: Mon, 29 Dec 2025 00:53:59 +0100
Message-ID: <20251228235422.30383-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3Fqo5mFiZUdNWyghND-AJYPNa7DPn7e0
X-Authority-Info: v=2.4 cv=V51wEOni c=1 sm=1 tr=0 ts=6951c399 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=CvHhVyPyXxbOnLnphYAA:9
X-Proofpoint-ORIG-GUID: 3Fqo5mFiZUdNWyghND-AJYPNa7DPn7e0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfX7VsxU3CSRPKI
 NJok2jisspRCSCFNMKmZOTnyPNp+p0yr1r6iScWOdJprK0fFj6emxXzHo32udRfp/D3cUV81yGd
 hsfeP7gjxYAwwjX6rOxydf806NyvSJULJf9io7DruToQJv7Wh82f/dk2FaKMzgQIlimIlMt/oLy
 e53CdhSUNrluN2EKoUSKPk5oN2EwLU0MV8B1Z8ybSUxt1Mb2tiqjvJSXdDU1D5UVK0PCzWp0NLz
 yuJ1go63XWkIXXGcc1ogVCoVJS1eOvmt4kHVZ7y2lzKqEZdMZNklDge55OGA8VJ00nhngiC/oEl
 1QjlgRxYi911uqEi1uF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1030 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABEjB1YaRbMQnIopRYR2Oy4sdzRQNcFSDc97vaA3HjoHRwLxKLy8brYs/c71ZTJK13JJyd3155E0pk2FEXtKg5iXXeesfi0SumHx0H0zfX19NMmqCmfSBi0fnB5YNDaUrJ42CgqZ2LHLpyF9SGG3zJznJb9SVWMJ1oRwJzCXBFM+It37tgoIe/kfkQqZ4bAylbuW2FdQPrdDxHPSZ4E7E2xnAmgJkHqf4D9t1yYGvAVXoX1fYyLjU1OeEBkGeDA4nqtkbdLYm5RA8SJJ7iiYgCqHrZzwB7x7FOuFPo+rEaHM2XUTnNupXDFFfnuC771pNDPOBn1PkjtKzX253OlYBHmrYmWIPoJfDm5dv8DOfCaBFDxwFOwQAnggHL1Iwdft5CfVxaC9/uLBrTa1imsAI/jsjuY5pS8pp1N13a2OdqaHToJ4KMOAM73pyp3NqmSrFh4cBIDcbZZIthkvMoQnbUOkwJLFlBddr4MF3cEiKktfKMKBxZijDCHecmuwJJBGcff4Ai1TqU+QUBoi9JOtCGMHK8fwAkstlOrb7DkHN7v0gofs5WKWrI60seRt+i1b3jWjJt9pcellvVBCPpdh+esEvVoZl96zewPzYMujcXw/wqdKGd6DhLjTLb9Hgz1xg4DcCZugFSA4KGlmUQFPJ4cLc8KRfRs9GKFF2Myb7ymYroGV56labMsF/EVsS0xCouAeRDcaESUd6MPvcmsYRP7VuysAFRPeco9HfYmBFOC8dVKFqvVgz0P4PZBmqbCbUhP3c48S8wKrx0V+bOL9Fnyn2d2ZBp2o0SWa190Oz7Cq5ugiUttacN/DqDkbGtsySdCF39acHWPXClVkvms1E/nj6bvKWv2j9FroQwNh5jYHvD8I+ygKINMgqNJuzfuYhQC9yGpysnl8hWthdrIPmdbZkvWZRam46euWatGB/cHnJJSgOb4VwV0KRrT9Hh4wfteSCNslKvPNc52zI9ETQZDhd
 7154XiA4h
Received-SPF: pass client-ip=57.103.64.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


