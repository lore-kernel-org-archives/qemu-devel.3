Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203ACF34C68
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKX7-0006ps-KL; Mon, 13 Apr 2026 12:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKX5-0006pZ-Pp
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:07 -0400
Received: from p-west2-cluster3-host10-snip4-5.eps.apple.com ([57.103.69.78]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKX4-0005Uo-GW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:07 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4CB501803867; Mon, 13 Apr 2026 16:53:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099185; x=1778691185;
 bh=dugTy6Mycl0V8PO55M7zjkrIKW6irE2gkRf+Eg5CDxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OoAU7QDA417nXkBvZvsaC9TIWHxDuEahpTUEgIqVtnuB0vPF3SSO1FvFYPHgz8mBZI6rcU/61uOKqidbaWOEsuvqj7j0XjJ1YEaO1uasmghJmD1kZWyDfUMto9DEZ9E3OECxTSnbYCuvc3rhQHaGVhY5LLDZmnA+pm2SZHccB4E1M2pPFdMiheBqPzfj+0E5Er05a/GjMUpnHpBDW6timv8MLmuJrH0mLgoGH3HTImpbt0KXt0qSjaXuCNDlnpI3QRWyd1ggxVfc4rspSP47T8vpHofYx/gGjAPHhV+9KrCKdM3yCk4hSY0rBmt7HnnTmQyOcUK2toq/y3+m1hdyvg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 41D3718027C9; Mon, 13 Apr 2026 16:52:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v11 05/15] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Mon, 13 Apr 2026 18:52:07 +0200
Message-ID: <20260413165217.47105-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413165217.47105-1-mohamed@unpredictable.fr>
References: <20260413165217.47105-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX07bLHUGJOf87
 KcOB/kb1h2iVHeKxVHGey1Sq9UqDjiNkRYcNV1NO2tRangfbfsT30FXJ247xgTB2gC8Nz2yt27A
 7FQtY4LWhqzZUGU0955Pw38BcfWEUmxUF9UAukOBHEH5+YKXiu4Xr6/k0FIFEp8LD78WMuDDR7x
 +1AAlZNxhKjjJ3u5bz55tLVZhhXhBy9H0xzO8a1NI03sYZPii1fnWc5MUoFzJ9cp+mTS/Q/f8e2
 cjM7KMohhjisR6pm/FYeU8wC8X45g859GzigFW2YDDwZ5X9h62tGQWOYgj3Jl8V1VlUb+nPyKaR
 PZ8ZUMSi/pDu9zTDLT6VPaelBXmS7Ou2pkvNvpwJjtoJ0O4lWdzRgF1yzVPiAs=
X-Authority-Info-Out: v=2.4 cv=HMrO14tv c=1 sm=1 tr=0 ts=69dd1f70
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-GUID: CzQrjLTzAkOavsb_VOZShRLwS7xgizJT
X-Proofpoint-ORIG-GUID: CzQrjLTzAkOavsb_VOZShRLwS7xgizJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1030
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.69.78;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0908dfd134..66f263558f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2281,11 +2281,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


