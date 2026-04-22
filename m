Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BF7FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfML-0000Iz-3Y; Wed, 22 Apr 2026 17:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM6-00007c-0J
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:36 -0400
Received: from p-east2-cluster5-host2-snip4-10.eps.apple.com ([57.103.79.23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfM4-0007eb-MI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:33 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 60FE318000BE; Wed, 22 Apr 2026 21:43:28 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgAXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894211; x=1779486211;
 bh=rq6HEVajfOcpJr7IHYS/4PVc8cfDW5A9Y6pS3DgXnLA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VwKPUi2m2z7DZGdzQNB+YkM+ALmKkzBzMqyDkfpYrD5PqVZsrqG36wUq484pcMWMumC4GBhdLgT9U0zOOpX6JcIe7q6/6gV4msn5Tbuu3ZoPhnmsBlAchs66hJEJkskyTbtzZZGS3qFHStt+SHVNHEssYSDPzDcl708fbRgJrSfzcuas0HsexlR002ZNGggHlAAcFAAVRiPUnI5jINbZGn2QJXWmTuF4pQMRABDPy1RUnHl4CCTHgYx0FFg3fRppq7uqorkuRh+GGwXI/vRJh5YYwknio1U692YFalhpOY7WMIrN49uypRRrKdCmkkpGs68u3oq8b8awxcDDMc1RzQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 DADF81800942; Wed, 22 Apr 2026 21:43:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 31/37] whpx: i386: update migration blocker message
Date: Wed, 22 Apr 2026 23:42:19 +0200
Message-ID: <20260422214225.2242-32-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfXzlpqIisaNtu0
 +SaVoxkndWuLdxM84V1TQPVzdm+fsYBrP+egup6WvhHRVx9CawJ/3rvGXUcOu8redx4JGr+b/uM
 pGNCuxUks5xM4Sb+r7+UmrUqADoiDtLZg6UwAXP2+1LQiZdw/Q9MoG5SK+gEVwO4qN1Ilm2Br5K
 O+52uBMe1Ju0GUkcnt6THR2yScx4mwQnh6FlH9HxR0Tsi9Qj0AKgdb4EZxT3dnGlINTA6Nfd8T1
 RCc7JEY1nq9iqchSO5ygmwPW8QsqpIbNgY1DuCKOVf3IhOPjfcms3V/jSH53GdnxlFlnnenqlSe
 WGHqOfn14wLcv4pytlEKVgKbnQZaWSl3SAwkaRTGvgmUucrC8bgcYzPjeMf5TM=
X-Proofpoint-ORIG-GUID: JRgBQl-Dm5rShUcgz6wmvRiiKIezObEW
X-Authority-Info-Out: v=2.4 cv=Vrkuwu2n c=1 sm=1 tr=0 ts=69e94102
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0IeqtQ1xXW1zzRo-U5sA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: JRgBQl-Dm5rShUcgz6wmvRiiKIezObEW
Received-SPF: pass client-ip=57.103.79.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Quite a part of it is from older times...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 53ff0d3f7c..6845f96ea6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2622,8 +2622,8 @@ int whpx_init_vcpu(CPUState *cpu)
      */
     if (whpx_migration_blocker == NULL) {
         error_setg(&whpx_migration_blocker,
-               "State blocked due to non-migratable CPUID feature support,"
-               "dirty memory tracking support, and XSAVE/XRSTOR support");
+               "State blocked due to missing dirty memory tracking support,"
+               "And some system register/state save-restore ");
 
         if (migrate_add_blocker(&whpx_migration_blocker, &local_error) < 0) {
             error_report_err(local_error);
-- 
2.50.1 (Apple Git-155)


