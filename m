Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F7CCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQl-0001ko-Ee; Tue, 28 Oct 2025 19:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQh-0001hA-91
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:43 -0400
Received: from p-east1-cluster6-host7-snip4-2.eps.apple.com ([57.103.90.193]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQQ-0004jz-Dd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:41 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 9A83B18034D0; Tue, 28 Oct 2025 23:48:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DI29hqyXtXcv8KugvO+q8P6nrX2ZiV7WMfm4bRhv4Brllh99/XDn7tK4kgkCiGZieQsiMf0dpe9tRlcYwN9HI4bmOS1sIKaZI612vQXPeG8oF7wTZTqLnrHf4002GDgWyLONEcPQlOGGaAVT+9XbCI7ZZf3QbT/kwKnbKA7Vo+Y9Catr5tMEb1kUvkbO8mowASDXBO+ktOL8ke7vDaTmmN3neZat/jdvXAkEizpKTcedFcgTvEepuq/dVwFpTXe1agiN8SXrbE4x+xvkKbXpmF4ztgx/+0XrToNZe5PguTuBD9wy6Q+3m3zLZsgSq1P8hPpeIyPGGCngE2TZCRV+OA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 7A1DC18030F8; Tue, 28 Oct 2025 23:48:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 03/27] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Wed, 29 Oct 2025 00:47:33 +0100
Message-ID: <20251028234757.39609-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX9P1O8Y0V9xee
 x8LCwN5Surb3NkYu2NAMB1Iuxx0wbD3D+DeXZhPWLeiNcZ8VwYFQg14Irb3/P2PYNBOKujl/L2/
 hsqKY8oOZTDwNE8p2xz5WAbDooqH2xjEHmhNDKERMfBiFRL/KvPPagHbfDCJQzd1AJaXlNsJco/
 3ZCzsz9D4NxRzvE6FLQaqA5J9Ml3W/6aKyT7wz18/bY1dsvkm9hICWdKOI/ASAgaYqiFZr/VToy
 kr5wGLplZSW6AqHO88KUdeKFGtJR/OwDvPAZXFlRa/rdMUInzpzuthM/rV6vZUgFaZgEL+jpQ=
X-Proofpoint-ORIG-GUID: fMLaDL2ATY4n43BQ93L1MiUXjSwmIx-G
X-Proofpoint-GUID: fMLaDL2ATY4n43BQ93L1MiUXjSwmIx-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0
 mlxlogscore=908 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABzx5mUj7GeILM+WtnaLgl42XA58DPMX4QiFWKzRrrQIIJ5TwmLKoFSG9QcD/rMgcVcnWx7oXSTJucsoXOz6/Lf7bwsSFNodwbPEmNULtBMXw4nChW2L1u6Lxrc69nN//16m9i+z9dq9a7xL2WZMgAxbtmSp0NbcuswWvS8+jj0f4i8m+bqRDRGIROTxWUwJts4CSVIk5GFAuppJQJACpPA5TysGeGtxawoMG5CgkuSYwzrcpBYC3T+hvrFsX/ybqSldVKoJUr7pn1ElJ9vv+AWVT/6EuedkPkpFSfH6lzZigB1RIpIu6FscondaR0hk5KvMMFaxmWEzk9yUF2AFuULgoM9hsdduczDKpUPy5cGpLdHuMS9Scd/WzABInkjzZ8wfPZtZRZFCEMShcRd6c2+QuAVIiZsf0tKBxeAYgiBUgLuNe7y7imbRuHrfKSu7qwemTLH7AqCRBAWdFVLPTJ0I7ydQ5cfvjZhWwHhRd+bSifVgtBxgU88X0/gyCWwiR/BZNeV/gx9qd4qzNxOR8gDzCQYDuE+RSH9CVKI2VoqzhEt3ESVgc8eo5h3BKxoVP+k5kvcQ27zFTMZFwDmZ3ocqcd5WGJsAKet2f3JZBvNdC9ir1xoL/xtJyPwlhjZ6GAXVIH0WceUPMtdPXe6ZLWtfYF6koh1ydSIdZmIT7fNI4GAuRNc7oaSp25EKQRMpXlAe3q/yaZPxUniNseQdP4P9Wra3CdGkXOo4Yf4p3LiKmKwcdORwyi1THFmFpR9pJJlsFmLdISSshOBFYqfp8yrlyBMImY1qz2
Received-SPF: pass client-ip=57.103.90.193;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


