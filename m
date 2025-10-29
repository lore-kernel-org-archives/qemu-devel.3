Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9AACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5F-0003Pk-BT; Wed, 29 Oct 2025 13:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA58-0003NO-5i
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:35 -0400
Received: from p-east2-cluster1-host9-snip4-6.eps.apple.com ([57.103.76.109]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA4x-0003Fc-6w
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:33 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 B7CB71819DFF; Wed, 29 Oct 2025 17:35:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UstOJnhK/+7HSOCeSb3QX26LdpoZlBq9oWD/6OBgmCNxCNFBCE0qECtkjAtNu8iY7lNRBEt+Fvb2TWyurncRemuHaWk9m3p4SoRUKPkafR3CPlo/ISAUu7tBNYbSoVg9mAJ6l+BXlFfbOV3VqY5tvSxr3QDsuwiTMbCJsszYwuRjW3LGMNPsNHBPSPVVaLUfgdFFAhDgllR8HaWK6nM/niVrbvxZ09y/GhXL3nokYnsfbibArPGA3dlX441rpe3XHA4mUnM9gZ4zzMhF3CU4jxq9JO8bFSt/oyp1lOR8UFggkotrJ09OiVStT//botiYW7xF/jjDBg86C8FWxnk1mw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 3AEAB1859E4B; Wed, 29 Oct 2025 16:55:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 03/28] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Wed, 29 Oct 2025 17:54:45 +0100
Message-ID: <20251029165510.45824-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xTADgFWmv7xhy2aejrbm0uVmCKHXaiEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfXye64S+Kio2Pw
 dld5bpAium1xHbktoqFuhNpu+t7cQZU8PKM4GRCphgdFAmGXrdZtxFsypzcD7kZEH9j68A4F562
 sqlQ3faR7xyqZ4QsTzdebPaDyAMyQiqh6G6QqHA9thluLkT91JZkm/q15ijPMbXcXFItwhmwStk
 hvWplKKmp+MFvu5p/bhtuloFE67B/8DHG+tQTkWDYxAZxsMITUPr7q3clXTdXGLpDzsJ6wG+krs
 12e78bQscpgyLscqBRoOPY5COLKbmRbU13SDHRehzaJl0gT2yZobo58rUGKVQ2NDEvNNHrdL0=
X-Proofpoint-ORIG-GUID: xTADgFWmv7xhy2aejrbm0uVmCKHXaiEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 adultscore=0 bulkscore=0
 suspectscore=0
 mlxlogscore=774 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABVZ9HcTW9oAxeUbUrQ1o27a5PgxkR3/USwiNQGPoeSpy3OcmGZO0w8LyEr8e6UGPiTfoUVYQSCFGK1PiAC1vZckjesYlmi7+0OKF80q/33DhKwVOjxqroe6Cmx2erts8H6kfdow8trUUVnLpPIdCrkkiW8x8cNDL66tjTj/0Fp9reQLt+cKPgMk7pJ82V3IWlJkecnPJ86+my9gsWGHm+HBaYr/Ria/Cme7dy/uUpoXSrTL2sOPSYkttVPVAybOA/6ljonqvAs/JJsdctsYukp2B3BaAY/2Ojto3l3KrRWS5W7ueBOtU7TVj0965Gvr6jyIFbH9b+88oj27HiODCf0qmAWK0mW8/Hpw0iO9A2lsKOuroz0LT+i3chA//dN9FAwprCezGoeBW7jz21KwZ1a6VZ2msHwa8QDj1DM7MNHQRZqCERYYd1/20Lr9NgMiquHRgVeRciuNsPaAK85lr8jQZrt0PqkQy/Kuy5hUVRHJnY56lpY32ZsP2a+w0NSotYgFjDfh5XPJY5Emz04xycqZZZuBjjqSvWX2Zf9qQ/zzPG637Gx57U5bwvO4HDcBZozwYH4wgmAYLxOUNptRhreZ9RR+LdDNbVk9tweJvenL3EaU1rf2jMeIcaSxZcPNlzAuIk2v+j9ePzoxJJ1y8r5F3hyWnZIKuRytH1/odemQrvHM7k5M8aLOSEgQclcaCedJTxbh+CR6Nn0RX4AGXTJjnSdX5tzMV40g4OUP7I66UJ+KwmbIyLcWTHdsxZU58kfi5GZrR3nT+Ylh8=
Received-SPF: pass client-ip=57.103.76.109;
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


