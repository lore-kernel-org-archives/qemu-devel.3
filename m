Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86415D58E4D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtts-00049K-8A; Sun, 01 Mar 2026 22:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwtto-00048a-1g
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:48 -0500
Received: from p-west2-cluster6-host3-snip4-6.eps.apple.com ([57.103.70.9]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttm-0008Iz-Le
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:47 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id
 1FC93180014B; Mon,  2 Mar 2026 03:24:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772421885; x=1775013885;
 bh=9l5pgpdno1+ME50mWO0AryTvHBGwI33pwK6V+Ah9HEU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TmrekDvdE10IMPa99Nr4vAK3WYfHBEWeADYigdKwuyvsQA1g1jBb4/Sdu0egG57l7ULn4N/IZLH7fVEPH/Ol34anHaXD8KR5Itxc9mEmdBx8DlN9i9ix7ueg2jM2eNCPzBmgd2A+RDBL97/9Wa8/I7yiYwfclcY7SPnX15Xj2CnzKAdsKz1OByzf0Vj43zKWpyNir38QTafk1UT2LEsyxXP3hZIUW7ARUtcBb1Ltq6ERyHPtrpqXJbW2NxyTlYFRDCS3jyt5sZLkGiU4XXr8Lvuc5l/kmXozvW81HIzPVYkSpX1uuu5tjJCawzI3orfhpuIlBSU2fg/ja4sP7yW5EA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id
 190F8180017B; Mon,  2 Mar 2026 03:24:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/3] target/i386: emulate: LA57 fix
Date: Mon,  2 Mar 2026 04:24:34 +0100
Message-ID: <20260302032435.42698-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302032435.42698-1-mohamed@unpredictable.fr>
References: <20260302032435.42698-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOCBTYWx0ZWRfXybcbEQQttsc4
 TxgwLej7UrhxC12BHENkK4jUv7085x9cAVxQvpM7Q6ESNfHX1LmJXFa2+otBM8iPxoB4rXi6iVx
 4GJ10C2Xw3EZqyGepHINm/qqfXnWLKwY7K8eAjsP0sRi1FORqBch8DRIkgFdQ2BA56bljzglH0l
 K51KMtCNE5QXsaS0fwwXLbkznO4qvfsyCoGcIOGSwvvESIQlGPW51ewEux8wrLIeMpIEMGqJoq8
 ab6xf0p/6Sy7nkKy/6HqcZQPSjNd69mMWcB3ZkHaHV7O4PGXK5gBasU0NzNW/DF/5liZm1sDJP7
 YUFDmzsH66Wx4ok/TMDS95Lw5+eqyxBABTdM23bjhPcSKVw8hr6SRahOLKh3fM=
X-Authority-Info-Out: v=2.4 cv=R54O2NRX c=1 sm=1 tr=0 ts=69a502fc
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gy8mmgNRbJmCihZvwREA:9
X-Proofpoint-ORIG-GUID: mqAqu5RGurumxadTef7ADyZIfF7XvX6r
X-Proofpoint-GUID: mqAqu5RGurumxadTef7ADyZIfF7XvX6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=789
 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0
 malwarescore=0 clxscore=1030 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603020028
X-JNJ: AAAAAAABgxrCbq28i8YOkaWTlPbnuY5L+ihVRGqe6Yxva0Hk5tl8INcbH31nJ5Ra5Zi053jl7kPTsUhMZuwDo++tdeEfh4nENG91147gdREjWvEfZjhzmaVlC81lDSYVZdhu8/H5FJsOwpLej321aFtzObj8IHtFRC/1aIi+61/TQFEfaal2aab8DaX4TlHoh2Rf1vo3Uh5eBxFXrHDhkQr0nvG06glhbI+nOqb5a32z1rIcBDPZrEn1AX34Cbt9R4n1NS2cCQEa9/cgwk1mrwsIOrvvxIFk6EVoXOLH/rOLEMl+ConcVTWPnEiS+EHQgTpBAXqipVlNp6puwYFvapGtJu08W0o7LGLz/2xjPrTRuYm022TmvRsA4cJNoNPgvRorKsf0IedSUrCUh+7XHaCPTXK2OgvuzQAh4lQtUmoauY+eFz3wn7w7IO7kTukMnVPA5NMb1rwza/Y4EkUVxcOjZukJM8pJR4HlPvULgEpM1OqZwZbi3Oe2prGZX5pNtm3vaKy1gtMwmZJgLmiyHiu4ldlmMEFSzoWavtooYVN4vCmHC05IzoFxJFKT+jQy4kFc8mb5LqG2gP3LXnJvidQogJvHLe0P40Nn5Mq5n0YLwqz83fhEUjvo3aqAbobRQ7oO9ay9CP/PXWUHW7Iy0R1gtZ9R79IU9OOmgX3xM6pWvtYONjE=
Received-SPF: pass client-ip=57.103.70.9;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seen on a Sapphire Rapids box with LA57.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index d30f6c4a3e..3546609a90 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.50.1 (Apple Git-155)


