Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C4CEC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8d-00058U-DH; Tue, 03 Mar 2026 06:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-00050m-LV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host9-snip4-6.eps.apple.com ([57.103.67.89]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8N-0001X0-VB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:53 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 63F5918003AA; Tue,  3 Mar 2026 11:41:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538107; x=1775130107;
 bh=gBxNQ3TjAYTeogiJbh69cd5jTUQ5SWnQGrtlwC8PRBY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LazU0yilVk/axwl4yclOi++VSFHVI+Doodc56e4jwTRc24Oms925XYNK2Ak6DAgNgoRchDV1T2kzyV0Su8Iy5t3JTaGy8PBWQZb9CnA/J9UWKT7UwBxMEmheE7gwqokQ2w2mPtGujfwq1IgPmUP8n2ea3Nha29jbJ6PuW7PA+tUfaiZ9/UujBP53RlYAVaHf+KP/9IYWohWSZ2qVAdUSmq8ZclDFHigeIq0YY0YBohXd7DAPxtHUM/NqDAVaeitZeEEOkSYtd2j3MM0krSFUp6XGOxSXbKfnY9RXJaj/rqyZGt0BZgwBS8FFge35St63snI3COScDeTFEPmfRltiuQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 EB99C180019D; Tue,  3 Mar 2026 11:41:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/6] target/i386: emulate: LA57 fix
Date: Tue,  3 Mar 2026 12:41:31 +0100
Message-ID: <20260303114135.15390-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303114135.15390-1-mohamed@unpredictable.fr>
References: <20260303114135.15390-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfX5vF4xxSJbU/A
 Ok5LCyZBDBMwujehYBaOjnGK1eGQNV1wKcDUpyuEu0NEezXbbwtmsnUsZeD1D4jGprFsK1h+/He
 KlQcZPOlWv+JzMyPLixK9HDOORHJSVvn8ZzrVFPkyYjmTYt7XIm/TqtieviQC76Q7jrBmKjQbdg
 LsdFmg7p1rx+flBrvYYBIEvufutMXPkhhVEl7TyNFn7DJWCqMPcMlKj+X8OXyvvGRAP225rGU7T
 oeKOdXeqeDSgI0HE/1FLDtcHkz+XQEhQibgGozx5/0ZpJeYpGDI8jRwMDCUrGYttVpNVpPmuAOL
 z/EmYV22PuPqLVJxCNbH8JRchLKYNn8H55HjieM+RTkJ4WBSuk8MCmkh3AhiVg=
X-Proofpoint-ORIG-GUID: VikLG5vIp_oNXXB1Ew6PkGcWpzU5bwz2
X-Authority-Info-Out: v=2.4 cv=XbKEDY55 c=1 sm=1 tr=0 ts=69a6c8fa
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=AJrqCOfVdMXzVqk_6-kA:9
X-Proofpoint-GUID: VikLG5vIp_oNXXB1Ew6PkGcWpzU5bwz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1030 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=781 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABO4/qCN+wzhHdPgibQyVFJRCpD5XTftRNtAmidjqXTnfxch9iwNujtehQDvPZNgqcZx0KgzcreHzR+UsUxVh3y0n3I4p5WZoc4ColFESrC5oTIH6sc5/zxidCETGW+Xqv88uL8yYvVZGeB5YHnn5KC2g7+iui6CtbOmzOPk43a+9e1/EtQJKecKciADpAWI+9Vi3t8S3M1T7mA6OPm8QZZG7S+3eARz/trIO1dGepApYnR+qV+92uPoiKOuNLt51w0dkOeqQZknWtaCT00EymDOkwbtZ9f4Efs7YmG5gQ0M8npYj4bahLjxjdVurm0dGuWxWozV/T/42/toXixZx1zwTdnW2pvhFLqSGpjoonJ7mx8awJkMbvupfyqXnOmpoC0/+ZA/1De0eCUGZg51ePUuuRlbd2MtTHylgPycuZgFTWYTMXZBMTswy/bCEziHdEQxWo0jVciPzJNRe3H8UJW9Wd8fvNqLmUbhTPfQqj+liwGF76eUJ+gHrLKISS6yR5Lr2DpOKPT1Euw2kKNoD1y1TbJgP21uypaLX1CMxtegEwgDV3ZtGRSHOYFHJB2kEO3mnaqMWOV9UMReNrwy5S5KS0jtxh13UirWSgKP+eSN2yf8HrzN8vdC46sdOJRyn0iBaUkuy6HLILmVaaRhHz4vrmQDBQgoBLhSeQi2F4Bn3unJALzVHV2wMYebThXazZptC1BlZQIw==
Received-SPF: pass client-ip=57.103.67.89;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
index 8261ca1635..4e39bae025 100644
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


