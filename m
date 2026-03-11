Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853411049515
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GmD-0002Lh-6V; Wed, 11 Mar 2026 06:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm4-0002IA-Ay
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:44 -0400
Received: from ci-2004f-snip4-3.eps.apple.com ([57.103.89.56]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm1-0001mX-Rx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:43 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 E0EB118000AD; Wed, 11 Mar 2026 10:26:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773224793; x=1775816793;
 bh=tqk9foTP5rMRlVCG5f+Zfh4A83KKwlPU+qNO5PuHkzc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Sqh+mCMxutzCbRG1zk0dj4b3W/YE1ZatXOZM+MnetxmKhJyxrXnZc5h481tXuvPYUhjeKmQoChB2qr5WRcBE2oAa4IoQyfScQwYvpo/rOkH8AfoieNOFCjCjBgQrx6QvaB/bwWUb/re5zVh6gpdl+w1uG7oFFiIlhyxW1lC+sjIr/phrkRoZPv7nKJBUNy6iWGF65HH6/i9y9BmToI4aSblvBH/nke+gc+cRQZ6Y8Sc/WQiM+N/VP0XiClfw2rpnF49SfaLaPsKE7Rq+DJpF9He22T27Mr8+cSSikdmvJWRgk9q6Iayb2r9yjP646yWkoLlrSM9qnp5iwDZ5yhEcgw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 C9122180013C; Wed, 11 Mar 2026 10:26:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 2/3] qemu-options.hx: document Hyper-V enlightenments
 accelerator option
Date: Wed, 11 Mar 2026 11:26:25 +0100
Message-ID: <20260311102626.46546-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311102626.46546-1-mohamed@unpredictable.fr>
References: <20260311102626.46546-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rKARxzlrcOwSzk6AwyP_tZBSOIoTWyap
X-Authority-Info-Out: v=2.4 cv=ULTQ3Sfy c=1 sm=1 tr=0 ts=69b14358
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YxDeTozNR0V_yq-76fUA:9
X-Proofpoint-GUID: rKARxzlrcOwSzk6AwyP_tZBSOIoTWyap
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfXyj6mA5vG0PK2
 QpbD1saVcJkNUeyLtJY1xpdzVYvLP1nAcWo1VouFOnfyi9eSM82EgqPXJSEG+nbaSw03YNipMoM
 cyY/z//Mn51dPu6NZaGd6u39IGzwU0R2O5IoVs7/U67m/ZkVARDloBKLNkizUVUb5rcBw57qnb0
 UD+qi71OZREkLBt/MIa6Tl3iQXyfhzDiLL3H19LhemRSlyU1vCN/xUeH+PVf+WEMXdmQ9sUeyeN
 Aa5cnsKp67KqR9xOvqxpwwq51iO326tmCO1gVHQUFJnPXLDtTO9+L4/iWWYWtM7umIr1n/Wp15H
 AiUc8WxxK6P4n8JMCT8kzLQrzKeP5GwELKlWAp1h+lNo6jVzE2Dc3WHEW5amdk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=751
 suspectscore=0 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110087
X-JNJ: AAAAAAABSoUSmmquvJj8zi8WGJm+u8/MmaSLFfYaoia7iI4lQWzmeJJZ7mEMZKRzoP5nFt+O+R2yDrNfwEt5yQS8yFClUWsCUfqdswJsEGohTmbEBQb9VeQ9R/7ZDmp8unh4vyxPc+CN6A3qcymNBYbcuwoFzIpUyHWHifwEIkNx3l+jXBHMR9iVo0u5i0eG5QDJ5BhVwPj9Qkng6FJuEEhddexf1h03QlSVF1fjdww4bf2JebW3pwToFldYo7S35Rjpi85omvFqZpafcONVSvD/ubI3wFPe4q5Keevt2c5mTczcjr97zodx2XhDrDYytdcF06p0cWH0JOYSKKVQvT6r0DyE3jDNbX8XXpG2haDvmqC80NsrDhdY3vuW03Bzsus1VAbN9J2ZtHhUC0+kWQSYzaQEPK7bpo7SB3CIa6+GY05HCZEL7d8EIpIwS6gk96WPNSfmnM6tBEg6RUiTW0qRDeM1AmgCxTXaYHa96DS2qXAxo+zL64kVwV/RWjD39N5VBMElCSNj+q3qGDncbgDuX7/4uIyKLPM6lj4Dg+YAHRAZ4jyA8jLfmQSdwjxbGOIWDGSUC5+JGfvgndjgDcNXrMWwFKqxFQLyJdEbzCoWa6SmdZsHs4ysUWyjN3C+iKErxzOfTvpUfgjn
Received-SPF: pass client-ip=57.103.89.56;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

This option is WHPX-specific and controls whether Hyper-V enlightenments are enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 qemu-options.hx | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 890c4f1d23..69e5a874c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -325,6 +325,11 @@ SRST
         option can be used to pass the KVM device to use via a file descriptor
         by setting the value to ``/dev/fdset/NN``.
 
+    ``hyperv=on|off|auto``
+        For the WHPX backend, determines whether to enable Hyper-V enlightenments.
+        On x86_64, Hyper-V enlightenments are on by default. On AArch64, they're off
+        by default.
+
 ERST
 
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
-- 
2.50.1 (Apple Git-155)


