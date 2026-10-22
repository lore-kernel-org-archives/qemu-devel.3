Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E6606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=RhWdF2D5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2gx-0002oF-Lc; Thu, 22 Oct 2026 19:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gw-0002nY-AA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:26 -0400
Received: from mr-2004f-snip6-7.eps.apple.com ([2a01:b747:3000:203::3a]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xK2gu-00029e-O1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:59:26 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 741E41800267; Thu, 22 Oct 2026 23:59:21 +0000 (UTC)
X-ICL-RepId: 01a1660e-1532-78a5-bee1-ac531334e5ed
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kAQgpNC1gORQpIDk0AQAZZHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1792713563; x=1824249563;
 bh=kxmNHegOdqS39PStGHBKsfXuH+urTRW4BQhGb2i385I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RhWdF2D5ikFe/NkNDdAfQXAFjbEs7McuEZsQaF9DtdplS7F90jTxkodM5kRR7Fp032AO/hxomr04fOy50af89PHs+6uSYs8I+yU9FAytf3Lo7PxB0YCZOD1vXOyHRC0DMXfASm1zAY9Y/mYcOp1XyBCmaA8Qw9+eRv7oHspk1CHkIVNGsRDijPsft/Yuq2oBh+0S9S0dm645MN8WO2z7DEaWBVpx0ztxOovUvol7L8kpkEzAyitnVUltPI6upZEBhUioFhiv9YfQ1jPd+M+rTSehkUs+V/a+12XWw+cLJMFYRowHnfTDziWLmyJiCBbNfS/HB0x1WmTLleQmuydRSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 A8C2F180011B; Thu, 22 Oct 2026 23:59:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 11/11] docs: whpx: update documentation
Date: Fri, 23 Oct 2026 01:58:59 +0200
Message-ID: <20261022235859.88753-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022235859.88753-1-mohamed@unpredictable.fr>
References: <20261022235859.88753-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0NUEIOKbChs55LJ4Z2cde82Wh0AzVxo-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX+ZqxBadidtXV
 G7uBiLPmKPNWPujod7vJ0Ydlnz7P0fy4ta9xO7OX2hPLNvPTG4yESCo9tacbqa5holghQwrIMAi
 6HaJ5moQ8156z3yJxsAlCyUQ5+YJAsIF1EpIDpiMHEpHvBrjXGD8SFfwpggo3xUgGkpk3ctWli5
 cPHR7dK6vD+kDwrhE71MkvnIG2DYn/lXNh/kzjePVYavYTbt0TT0pgbt0d+fohF/CMBniNs8mCR
 fvVx+IEJskD5uFazUWBzDJIOy1bbINxRMBaWLacGPuZI/GPyHAll9Z1jngda9kh3sAGoRPCPe5M
 3qtNqqWcR6DuvoW2UTLLVZs8VDD0WuU9URCjEggKGKZVjzagXzXbEdjesyIk7o=
X-Proofpoint-ORIG-GUID: 0NUEIOKbChs55LJ4Z2cde82Wh0AzVxo-
X-Authority-Info-Out: v=2.4 cv=OYeVzxTY c=1 sm=1 tr=0 ts=6adaa359
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i7kv7obA9RsThL7PjB0A:9 a=ZXulRonScM0A:10
X-JNJ: AAAAAAABGvDaR4I7Ms4Xzd2mEdCOOqLUz1AX8e4/HiDdcP0u0wUr65GQvBdxlzsy2t/pV0THxmqs+Af95zoN6QY6AJoYrFwGKiNXGXQSFqLDxkyjCZwiIh7NUto/olxdbH8ZeOjt0Bq3/AaslFCXkC5qdl9w7uNVugEpOevKBSIVDpLjWY/wPPCGKli7GOzdkCxymypVLxMYHgOIrqgC/jfplNlejvaOuPz8n+zwxJaBE23Ck9Ea2NvffYa2/8keaQAbKT/OZIIzguG4Jyg22q4zfDlGSsORS2at7POMiY1iiuC6RpI8uTWZhOU7OCx1dm/2047+ctJBNCb9E7w6IrA+tXU5mMiS44XrgnJo/vO3fhAAUFSUdWnB888wmr3eRzrhd3vQ2UQ5JHF/EwjZeyH/LCXPG5h03YJdQi3o4u8raidSorWcBkklO6CIrlteYndBBHQPwHTwfEm1T3IlX7YNkJ293b4EH9kTBIIl2TguLbkXxn09u2zZhgvBDenZVyC9cAq5cODYrwtEYxACt2E6zsDn/0ePBjWXWbZcCKD70/3zUSrX8Ua6xhsVF6zY9znDdtb6yS67+W3nG7WPLHRlqLQUvsLHUoepBjEJhL7msiZqlNgYlDtmUYCOh7l0TRuKWJ1pW9tMARTtpjBNYFqQoBEfNZCdlnHbQfwy+L9FvpIsiRWFmro5Ij1YZOflYn9s/kCC66cJWNxyHua3/vI0mpeuLkmSRFJnyzY0359SJKlnF6DFz7/tcHizp3kSsyBNKqhc0Zz8ZiudXe9XG5p30jzcs38=
Received-SPF: pass client-ip=2a01:b747:3000:203::3a;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mention experimental VM save/restore support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 docs/system/whpx.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 9909e86831..086193e0b6 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -66,6 +66,8 @@ expects a linear framebuffer to be available.
 Accelerator options
 --------------------
 
+``-accel whpx,hyperv=off`` disables Hyper-V enlightenments exposure.
+
 x86_64
 ^^^^^^
 
@@ -80,6 +82,10 @@ as in a BTB flush when entering/exiting the guest. This results in a
 significant MMIO performance increase at the detriment of security
 mitigations.
 
+``-cpu svm=off,vmx=off,x2apic=off`` with the Hyper-V LAPIC being used allows
+for experimental VM save/restore support. Currently, this does not cover MTRRs
+or debug registers.
+
 Known issues on x86_64
 ----------------------
 
-- 
2.54.0 (Apple Git-157)


