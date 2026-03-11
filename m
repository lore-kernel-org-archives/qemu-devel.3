Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27451125833
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KIE-0002NM-Q0; Wed, 11 Mar 2026 10:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0KI0-0002Mp-8V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:11:56 -0400
Received: from p-east2-cluster1-host2-snip4-3.eps.apple.com ([57.103.76.36]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0KHx-0006Ln-9F
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:11:55 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 15E43180015F; Wed, 11 Mar 2026 14:11:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773238311; x=1775830311;
 bh=MhnkV5c/dOH7V/+SH0BEkMY4F6uembWguGSpYqFssOw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R5gO8LXzuI07CRaz81UtN36atOTD6u99sMFH59zh1eboVrH0YbMZlvL4O4hc4gbmTE/HExT8k7Af1J95nDIiQpURCAlu12+4puZuE37DzCH6xKderUBjEUCx9ACNAY4kngv9IfQ0Srr36iSdlBui5UZKlV/rtl3IJcIYs/wzcgwkdZE8vwGN7j4VlaDuueojzhH5wCpnRv+uckxAGztSL3mzQtIqQqApKPcWzkH0aXI/6t5PlxW+9sjujo5LcYxImDH8seFqulUz5fY5uvCRIB/QrZIiB1DI304+coJ26pfh8q3vgumjLykvXlraKpiVIKzSHCGIPOTsCYAJpuCEJA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 7880A1800304; Wed, 11 Mar 2026 14:11:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] whpx: arm: fix -cpu host
Date: Wed, 11 Mar 2026 15:11:37 +0100
Message-ID: <20260311141138.30267-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nl7wxNmNFs8Hao9RtHGzqFCdnBqnYpLk
X-Authority-Info-Out: v=2.4 cv=RJO+3oi+ c=1 sm=1 tr=0 ts=69b17825
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XosdkutOKJZ40ZxHwN4A:9
X-Proofpoint-ORIG-GUID: nl7wxNmNFs8Hao9RtHGzqFCdnBqnYpLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExOSBTYWx0ZWRfX7tZzeHWvz0iT
 4xJzZtLyaMhqlnMNBaRs7Uu92Q2Q8On3845fjFDY2a4+HzzH8mH7Lbv5e5FoCVIMlyR+exqMTKZ
 9I3yhwVVGDoA3LwfFm7EaG1+H+XeVfCO2zkSLcAHWj2tW7sS39b6+3dQPGRtwfTgTnRm9nKFTbt
 97+cbitN8XbPX8DB0sfYf8o3Rjrj5MuEnu0IbKBSYlEeZVOdlYwXn16L3l668WPW/9IUmXtTlpo
 Cx58ReI1KxJ1oS5WdpZOi6AYil0P7wsAdNNGY6oQ0Umr4cPNwiCS/OY0rP+dfe9Wf0Pid023bgp
 YyQx4LypgYjnd13TQj6VYfMRhxPprrLlBL6kupmE5NTQZzUUBCurfD7Zz6b0jI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 mlxlogscore=951 suspectscore=0
 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110119
X-JNJ: AAAAAAAByzjWnpg8Ay3mc9QmTl60IPUfmgQ/Tmdv+UDdouTW5OtbbgYdUdq1Ms3wakiKcHfnZ8GdUGuuUilQYj1B5h0GVNz5VLXtpVi9q2gLJCMpwE9B3LWjPWqmxDAsHvoSOo2+MQD35iZXFSDTRW3/hajVFcATGorGCYJAF34VZDoUS6INnEjWRtohms2ybV5AoIMInPiRqorMP551B6Ml6dMlbBuFPqTzyftFnliiX2yoRO6nlU6mPFuzn3exDrICZXbTQlkCvVmrIvO7AqZEr4MRuMJZ64sBcTDY+PyB9H/FZZiznTKeYuwd1Aa6HTMaMjtpQ94759r/Byw3Z9URDUAqI2qT2wpqQEO/PZC8iU64ggsaSPZhXSDbdVcveDALlmvB6J7SruMsDy690u+fLjl368CbagpVGU6KqlhUh2+apOUkWj5CNk8pgWpskb7WFWeQD66D7JhhRXBPxNXiisraFArM76KbhZhA3iEedGB8ncFlIZintRaqd30Tf0pAjhHgUv+3+anmmnkIUxX7PWZZeaSqhLCk3OQ4aPS2WrrffDrG111HthX23rTpkjJAOVQbTeK4Lb3xP9LVZkOOr7TzPVamH2O4VxP94p7GWKd/vKx8DVpl
Received-SPF: pass client-ip=57.103.76.36;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

"hw/arm/virt: Register valid CPU types dynamically" went under my radar, so fix this for WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bced9f67f4..af3f03ced3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3477,7 +3477,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-        if (kvm_enabled() || hvf_enabled()) {
+        if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
     }
-- 
2.50.1 (Apple Git-155)


