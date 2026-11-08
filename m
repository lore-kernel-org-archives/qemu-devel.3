Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71202606A33B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=ksFn/+9z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzd1-0006X5-Ks; Sun, 08 Nov 2026 04:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbO-0005Rv-B8
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from st-2004k-snip6-11.eps.apple.com ([2a01:b747:3001:201::6f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005yw-55
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:18 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 802E518000BC; Sun, 08 Nov 2026 09:54:12 +0000 (UTC)
X-ICL-RepId: 01a1ba94-6f55-78d7-ae20-4d6392faf1b2
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGBV1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131653; x=1825667653;
 bh=dSrwibXLl61KPeY0mbb9Kw6Bj1BM0S+HBdlSgsEMB5s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ksFn/+9ztwWApahzihlqqitxs34IkzR5cTFGoNzsMre8BvnnYJhp20lagxU5gOestG883hJZpA/HVgL9oOauwox5CqgkB1/hz+uzxgTGzkmvO+0nn1QjL+DTP+rMe/AvFouHyxIXnNGT0CGDJ9sbtpCIUtMZSdmO12lV/KNFDKN3bE3Oha+5je+Ezpx8vHU/5XEmfpo4s8W55ZtA6Iu86QtfzGYfaacT92q+4SlBSVraBEK2qcVv9PO+3yulVwaXARPERJD+Kf2q89AkoXqpVqJwUk8pxZk7cLAdisV6/1lI89Hcy9aVGKHNdg9PF/lXBTa8A2N2mcg5SHuIUSR5Hg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 480E418001B2; Sun, 08 Nov 2026 09:54:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/13] whpx: i386: make nested virtualisation init failure
 non-fatal
Date: Sun,  8 Nov 2026 02:53:56 -0700
Message-ID: <20261108095403.70813-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dx9k0bRejrq_TBDawj1GdvmSTfySXjGw
X-Proofpoint-ORIG-GUID: dx9k0bRejrq_TBDawj1GdvmSTfySXjGw
X-Authority-Info-Out: v=2.4 cv=c8CmgB9l c=1 sm=1 tr=0 ts=6af046c5
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p5XUOwc6s_shZ6Vv324A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX1leme134/Xgr
 lBfDE5NjHkPt/BEXQMkYoPgTv9mVpxw5+hMqQz5SsqNglVUcc3rNR960YGZpynRtr8k3wYk5PJF
 +BrUSmQPlt6XuflcCpToWQBEt7XUTV7zDpz/Ia1yucRqNIVCV1sbwW6qZowUdPq5587trxjL3A8
 nwxfPJazNzGI/LubS5y1JXRBA414RGpm1Nz/biTsB8JxvsoeD4ADf3/fTEJJOP8TN85P76MS6w1
 3IO+qzul9BfbuptF+EMz10uH9Nts8iXH2oL1m6kS9q/BoDNSFqlYMruRFOy6q6zBNmuaEh8U/2u
 8eVrvbjna0PaMjpVxjBuNQuHTuwbBdC0FQ0EV5Z0e/1C+bQJFxZupOMwhJyLb8=
X-JNJ: AAAAAAAB0L7r4DkCP5ezPWfvXYgQw9nEUcLGXN78M2av6qFs0NPKmJzUhvfegFkVuxb8C3
 otxu2TBkMqvL1kSyGPuoaq7fPSpLEVLR0ojAsyMSZ4nqj563rFT7eusrlv+nuy7StttxG/
 4Nl6s+WF3SAKEw2k14aQlre8X+jPN7PJqkNZL2IsrzQJ4CFJ5S485X9BZrxp0PKaiC4+2P
 zAfmlLinVFOV3ac3dQW6Y77uPK2bEZ0HAZSmD21OEQ+PIeLFW5GsYiFghl9s0ZN9f3g+u1
 fBh1KeowldZn2bUFTp+OS6WV2WujZIeLGZtlc4OqZkdjatw0/66Q1WP3UA7SffPZKBqkOC
 cZwOJ+bo2jkJlzF/Pvh9wm96etzgZ0Imaf7CLyxHvKNNUVDPg6KbaWuGrvVPzSBVqspjnV
 uczcQxBWduc4cGEl+9wbve238E/rmkiqry5XN6kA9G5PuQgj2C+mR9gt6z6AWVTxp36OO4
 cWTreQcXeEwZQE7ow+UFrMhtWjEC05gJAITJ8Q7VgAW2NQX/xZ9vPjmySS3WaQvmDKIaOO
 YzoK3suLwx+boLqzIVcKsD0Jls+RU5jGX60W61Dm6YKAF/nZK5+/uX1kdQQWrG4F68tjzy
 Rk218/BLwJEy9NeV1HywEZ6e+Bcp1eB2pDj4133uW3ZVrRuW5dDXqWW3WrgbYa8s6ErtVr
 vffR4yrP49AwpQ0nU1xoECeRRQeomUMnFsHtJtm6fNWB2toYGtsK8gUJXlSgvIHRkDzoRa
 RR6n14ui7H3d+dbmd0qD35oSarOQ8ldekc84R8X/3ooSU=
Received-SPF: pass client-ip=2a01:b747:3001:201::6f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On some CPUs too old for Windows 11 (Skylake) support but running
it anyway, WHP advertises nested virt despite it
being unavailable.

As such, make failures to initialise nested virt even when advertised
non-fatal.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 408a1667e0..d13513985c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3302,9 +3302,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
             if (FAILED(hr)) {
-                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
-                ret = -EINVAL;
-                goto error;
+                warn_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
         }
     }
 
-- 
2.54.0 (Apple Git-157)


