Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715B606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Q0QFnZRt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZr-0001nP-1M; Tue, 27 Oct 2026 11:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjZ0-00010J-PP
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:15 -0400
Received: from ci-2002h-snip6-11.eps.apple.com ([2a01:b747:3005:206::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0005pF-Bg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 2DFC1180015E; Tue, 27 Oct 2026 15:58:05 +0000 (UTC)
X-ICL-RepId: 01a17e15-4704-790f-a1d3-8c21ac4746da
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZSHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116688; x=1824652688;
 bh=G9dSVSmpfPjL4JSrrpeJfdulgeFJtL2zLncLmhWQPIg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q0QFnZRtJBV+9Sne7qwFDdhLyBo5sKuY9vUxhCS6izMPLJDLxwOsTDelr4b7owsxh6vMWyGDBymHbx/D8wI6h9ZVVSnwlzwJ7uDvn+7jkiW4CYiSQT2fTFpYjrtaUC48ohsMFTjx0ZQwNP+YSqPPmnvB8Q4jDRTy8KSjVl8XrTkTT86sRK1ClGUt9nRzOLOTQY26n0dG2of4Je7Fy1XfpU/KNGQnBaujgfrjuI864osAPjFvM372S3aIfZbal9W1JL8AbYSCOBVMGluR5ExsYaWpjBJCTGonvA7qNvh4v94965R24/EJkCJAvadn8tr8MmUmVefZTDd3lQmudVgtwg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 5CBCD180049C; Tue, 27 Oct 2026 15:58:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 18/18] whpx: docs: update for experimental VM save/restore
 support
Date: Tue, 27 Oct 2026 16:57:37 +0100
Message-ID: <20261027155737.59271-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX+WMLC9Uw4Ftj
 vOAV6Cm6r8dDwJNs7b4uc8lXSNBnP6hdhYo5r+yrfLsH08Pa7Xvu2nMfgTgevBhtjW0VwdDLXVn
 8G/rlxB0zNAcf1p6sjE25nroQ74ip+5tR8djGzBZD5x5bSIRlCSaZAH68B5I0c9nqFB9WzO49Og
 ZzMIWuSIf3+eIZICU3m0SNcxTfIxhtwF0948MIo7V6A9w7jL0aeb5OkypKWqMCQdsHfzYFQf1UK
 6TbCNyU5dYktE4G43nU2k8iFWo7q3g0gkFbXLSkk+8MsFU+BXmV28Rd69ZJp+XBWGxnrmIWIuJH
 uBN0XWLWHbWehanuk69HOwHPTYkGtfC+YQctMtB1NUifizVYxpgbCVJX4a73pA=
X-Authority-Info-Out: v=2.4 cv=KaDfcAYD c=1 sm=1 tr=0 ts=6ae0ca0e
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pFNGRcf0QCHyMLCsL3gA:9
X-Proofpoint-ORIG-GUID: T_EgRzVsBHJZgGW9O11hxl0kRyJcbRuA
X-Proofpoint-GUID: T_EgRzVsBHJZgGW9O11hxl0kRyJcbRuA
X-JNJ: AAAAAAAB4hq/IJBzrdjPXpCskXHPyg6J1f4b6f0BEYDOpnsTPMOsjXJ6PlX0gwaYD4RFrsn1Huv+eSafTlFUyhCEHOJCqRyn2F7RfRKrXttHwL7hteFRakt5c/QRW+VdXAzV04sQrBKV267Kx47/6v9C2fvAR08GVhEDD0Hzrpgn97xLXNsdizGI1im8smp6m+dHL0phEhJmOA6bOQxCug7xaeNxCLMPsjuVVQEUN8vun1xw0/QsUnc8ihKJsdQMPA8TK+P8OhlhaxlXpeP2pFkKKu0ZpguAMxyTeZ82XCIql42JEShruC6yt4fS1W7X4/IhGwPivzPzU0fANioOwTRAF+TyMjJ3VSDmA/NdIYsITEXOcl1Iie+AxwBtaXHlaMqv5sSRmXDI7nRghdwiqMhW+lUqwZ+7UNcU3LIFbZ/KQgaYRL51LffHs6aohWEf5yJ5y6ng4OAZg/o13k8y9h1isM5o/msw5sah0cmp9lcXfuFiAl+eFvVEk8gRuwoH1f2oKwOSfRqGyqf93r3a3uXusDoQEydVD5+IFJsKdBkOMmxDgk8FJgHbTDfMIpAtpI3xIimm6NhI0neNHHLbBncf1kYIBUbKPVU9JVcBOjgL5CXGAYf8CZwH+5MTmw/HrnvJXVyaoO5QgVgVP1FP6km2mHjNcXZDIlj9UM+uPw0efPPXYYjPT1HXTr6LWA8JgIxkaNfwiO5U1c+8Hx7OgcUHcqBGwLzDx8SXZYeksMVnDgJewZ+j0m9ANlHVrt9kbDcoO3m7b9GE5Q1t8zNtCpPg4RPce1UGmSb1dqOHaDXkOfvQP9T6
Received-SPF: pass client-ip=2a01:b747:3005:206::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It's there but still highly experimental for the time being.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 docs/system/whpx.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 9909e86831..9ad1448d04 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -80,6 +80,8 @@ as in a BTB flush when entering/exiting the guest. This results in a
 significant MMIO performance increase at the detriment of security
 mitigations.
 
+``-cpu host,svm=off,vmx=off`` disables nested virtualisation.
+
 Known issues on x86_64
 ----------------------
 
@@ -114,6 +116,16 @@ disables the PIC. In that configuration, using a UEFI is recommended.
 On this release, ``-M kernel-irqchip=`` is not expected to be manually
 set during normal operation. It remains as a debugging option.
 
+VM save-restore
+^^^^^^^^^^^^^^^
+VM save-restore is currently highly experimental.
+
+It's currently blocked when using Hyper-V enlightenments, which can be disabled with
+``-accel whpx,hyperv=off`` and is blocked when nested virtualisation is enabled.
+
+Dirty page tracking is absent and it is currently best used with ``-M kernel-irqchip=off``
+especially for SMP configurations.
+
 Known issues on Windows 11
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.54.0 (Apple Git-157)


