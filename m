Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18D606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=cvpPE1jn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0TX-0000fs-Du; Thu, 22 Oct 2026 17:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0TA-0000Vm-Ch
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:05 -0400
Received: from st-2006d-snip6-3.eps.apple.com ([2a01:b747:3001:203::2b]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK0T8-0005rQ-Qj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:37:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id
 2B8D118000A0; Thu, 22 Oct 2026 21:36:58 +0000 (UTC)
X-ICL-RepId: 01a1658b-b92f-7080-89d4-da91bbd133f3
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQghLBVkARQBBD04GQAFGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792705018; x=1824241018;
 bh=3a0R2LK+JjuqJIMKD3JH2WtIzgfgHLiVfjX7qyoemac=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cvpPE1jncQRMuGy3oSWV9+TWuu7abf6cgunB1ozmnYA8bSpKrOwHqOEyXFyVEaSlTJSm7OSzgNYEwGCBfcOavsd0kXM85sfzZ5KB5cLfuIis0C7PQY+1c/a3AakMYIk/Rf+Ef54Uch0+bhIWFnMfQ1X6PjVloKF6xGj0mx7A6IWUqeEKRCA+aTIwPg18DbMBWF3aKlBI0jLfaOH5c1euccEQMQmSipAS9z2Ntt3geWdPEch6CGxALcob2DMxyQoyo5+Sxx77jEKgfRhpGTkAJT6PbmCavbfH57YZScxYfuOKIl9WFjZGE9l3Vcg4Gh/tt77QGTdkwSDWBWX/pEcGkA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id
 1F88318001F1; Thu, 22 Oct 2026 21:36:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 5/6] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
Date: Thu, 22 Oct 2026 23:36:46 +0200
Message-ID: <20261022213647.21665-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022213647.21665-1-mohamed@unpredictable.fr>
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=YqgChoYX c=1 sm=1 tr=0 ts=6ada81fa
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7qsRFXLxziyXjOXhidgA:9
X-Proofpoint-ORIG-GUID: aBJqzMFxAfdNb4tWj_pnbEdnYzpDRi0C
X-Proofpoint-GUID: aBJqzMFxAfdNb4tWj_pnbEdnYzpDRi0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX9/Hhjxf24ZXM
 6vRA87cxhDt01YJx01E4StOz4XyEWNjh2MfeT5d2TbElUvblHgx1zy5DWKPWZ5B14Y7V8cJ9e3Y
 jGOaofoSZ329E5wLZDO8yOEX5eaHVuHNIOmnJUMNr1C9DcdyVdOrbxTli+dPdvm6SymyKG6r5QH
 WUesdxtNOMdLwZKVRUJRd8sp7N54ffTHnSXrONEIpUDTwOyqjtNxJ/M/FrLthB11JFI0HcG56aT
 yPTPK7g8akejhdUjORizD4rvame9MPHxsfT59G693gcn1hX0H2dHAx31lvfdTPGSoa5EdkuGhxU
 8CM68a+UbPYmC6l1gzaDn6EpCBDGWK6RkCoEs6M55n50af06CgN/ObCWSw5R0I=
X-JNJ: AAAAAAAB5lq7D9fHARea0Zmqwg5ORVm7mRfguK0kBtq3iFS/Uc5yF4aK0kguRoOHxYcpX0U+oIYtdcdrfT7XXiGEmqwNQkt6ZIltcCr2cO5Mgu9sywPzjtUksjJm1gAKRqVlzqoNiUsQj0Kn3ePHg3yP3KHtcJsYeV1wl69zA+ikqmbyd/SJg5aoJxH4pybGDvvIFQs+q1mcEW/1fTCtC2AZepKx1Jt9ehPlLSt0TwQxv4VCluDRJR8RtiMn5LwKc7auTr1RzGj5ukp5+4o0+53O+mER5M42wxzCcQGFBGdi0lTyhncWyspSvp+JqUKCSNfW/FcpclaiIg10TWNj58p4VEZcWQK+ybQWltRR1zUW58NUd3gIuTwLG/qjDmlH3bxXquRXEX8McfXvGe/QWGNqdLIZKUJxmIqMTI3n26IQ8k37gw5mJT5iy6cFhDIBdO/TF5zGEtwDBGVzbd1B3/vYbFTtN9hWJdTGVeyjt4h3hw05PqC5J8Eii0wNvhUzDoL8TGvJI/M/vw5V+SXEo2XXvqshlfPnbh4dyaqN4ehxHDGNjRdmg4zEiOyC5fxRBHfYYYRGZhROEfrJ2X8h49ArD7xefXcO5YqRF23u8etKTw6v16+xH9HmyVOHVga0T4ELsM8qPQd9VNKqZ+2xso0iW1zNUTD+LbDsOK0fz+jEB8/I2nSNomZte8NOhIjNF6A7cGAdmsRfpZJj+rsiVLlmIVQOUW6j5eKCIpltJHKzYPvwQIIlqL9Tn/VwkiRWJ2m2hTmnkQ7jqiC0wVAdR1CqY3PH1kdyU1hHueMMoGye7IDwG/2xyRhy6g==
Received-SPF: pass client-ip=2a01:b747:3001:203::2b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1237077603..e813f14ed4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
+    /*
+     * On HVF, kernel-irqchip implies GICv3.
+     * The kernel-irqchip=off,gic-version=3 legacy case also supports
+     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
+     * is not implemented yet.
+     */
+
+    if (hvf_irqchip_in_kernel()) {
+        /* Advertise the GIC system register interface */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.54.0 (Apple Git-157)


