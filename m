Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C350EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhM-0006Cp-JA; Tue, 03 Mar 2026 15:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWhA-00061F-Gg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:22 -0500
Received: from p-east2-cluster6-host6-snip4-1.eps.apple.com ([57.103.76.222]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh8-0000kv-7d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:19 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 ED4D9180041C; Tue,  3 Mar 2026 20:50:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571015; x=1775163015;
 bh=3JX8beg0C2Np1egU4bEnkRFyLgIrgwrt1tvpx/K3/Vk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WYQZ9wgcleZhj8mATsjr1ltdlZpJIOaw+WvAkykMX3VvGyHfQxplW6MJUNuDq/oVAFaB9puWdPRhWhcSo1c82lJK0C+zLzCYvGFN4Eg8q+BmY9bPKqXA6TAzfOrd1ZcvKjrPifU2kw4qGoMLj+rlGRb0e7feZRNCrlRMnAYXzVYfWld0smMJTAcGu3SeSkKAkqQ/LPdhTgDDKWSTIxzkOhIk/JUlQyWc31XhIKzpkxobpE2oB9HMvFCnKhSsgav1V0ugVYGDD/3/pGWypFdaIllAzGUys9SN8/73zZypd6nPcn8RL7jvleOp9jkawLZas0zGCjvVwgLJMGGB/SZyyg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 F3FF31800580; Tue,  3 Mar 2026 20:50:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 6/9] whpx: i386: enable some more enlightenments
Date: Tue,  3 Mar 2026 21:49:56 +0100
Message-ID: <20260303204959.31156-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LpyfC3dc c=1 sm=1 tr=0 ts=69a74987
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-ORIG-GUID: aqPC19KbimsLHDXoxe04_R1bnaL4qrYX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXzghHMpMtRy0v
 83nwvlG0hFFX9M/lN5Kgqv0uM9tcnzsvfHFxkNkyIhTS5e8WbLHEwhLwktW7phxSCssJDmSk6je
 vePUambrfkbGrw8xiqJCu0PVp4KVh7e/W/rDYI1K3uGXdAI0RdmCYhf0qSQIZfMTFReLC6ABZtr
 PpXUpyHt0O5b9H9DOEf1tMIP+4EhfTO3cuAPrPkN6V7KwRyqj1AVcBDUPmBiit2AcI50rPEY+wh
 hn/Cvli821jYBYQ20pVjFLb2GDoWpmGNpVFbzPIAq3GFaYVAd/45ZaouDpDmsEtsnWrRrFyJYxj
 FDm5mOd6QAgoXjU2+VxmTttmbx4gRFDqGx/t8Zt0s3A/If81Nlp6I+KDUudgCY=
X-Proofpoint-GUID: aqPC19KbimsLHDXoxe04_R1bnaL4qrYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=875 adultscore=0 clxscore=1030
 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAAB6K6/FQJ9dE+HWiLZXvUBq/zEsO7z06wa+Voi/q+6KW1ufhoUvXlhJovC4TYYHm0WyYIX/c9MqCsp0kH2RpStIgBI6msfzrDvf/d0AbrqFzUVCBZRVl4NeAZeeWZXB1Pg+yYuIifvXcHRhTs+xo+CSVO2YFizTqTFjwnlhc+ybw/Qvum0Yc8+j5gZD++WiB3xacsKVTWxCG35JTlX8FeverHqqs4TdZnXZDfaIAnDcrrAn2DOfC/S4kbNG9uqeDnH4REYW2PZA5obSpflr8cA1ub1CMGEPhPpUq4tkKNMzgzPFu6F5VhtVSKYj99rvHwBEAL0V46/NoA07LKNH86cs7AGMhgHqs/+NOMxjtpGkjLTWcVNGBR7fhEInNMa7w5NuPIO5N9mljGyKdzDgpYTImF2VqFfub/qyppOri71haIeFEOim3+yI603gMY3JdgQgccsArqTzHrCjBxjIW0/qaBx/K/blyAi9zXu6ue+pWuIYH0f3BHsljfaEkTK/qXuziWvzfCdra80wJ8OSoCMNV2E9JDdksYvrg5Ns+cbwHtM2hT9iyOyzSEdHlug6pW1LQ0LwfM/sRjubjv0nkNjOMcWfbKeqicDQEksxQoUlI3qdMpAOZn5gyCTYz40kHouz103ZpCEEj8ZjCTDwYWyPCOso/v5tnLqtVPRQJEQwkVTVZ5BhKUF38h0QkU3sJE/5HpvPwEquYahBU7ejXgak+UjRIlzU0kKR0uCsP0m8y0G1IF73Q7DRw==
Received-SPF: pass client-ip=57.103.76.222;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4afcbbae25..915d79152e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2201,9 +2201,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


