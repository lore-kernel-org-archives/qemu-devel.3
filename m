Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE3606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g9n5sR/G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDQ-0003xE-Hy; Mon, 02 Nov 2026 08:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDK-0003bB-Gy
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDI-0002Ls-BV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so1350419f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626599; x=1794231399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=urexpukjeL615f3Ic2x2a3PTILhWiWJyF4tuEcI3kKE=;
 b=g9n5sR/GA+vBLfDBOklwrGPG5m2kpxY5QbHa3TPTtb9ClWLEmKzaerqEym3kid6GN+
 FKxbKp9kYNKwUSSaMMB8DY64Gh45BmN/ZrDTja9iBL0ACvL4Gx4RXZeaLRmNg9sAWeka
 w6RxWKa92Nq31b7fC2DBhaiJMdlZonxcjkiDFr5mVYnDrI/siAfunhyFsgu7AFyehaEm
 ntyDLMeSSPr9DE4dO5zXoApfg2ckp1BvNlo6if+IyGkxigOxvNycZNckSVYKTDDCNDhx
 Dr64J9jeXJDyiiwig+ls4hIeOZQD0JHM0Jb73XbmIx1/aCHQ7Gxc433pTDHIQNHOrOTA
 uQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626599; x=1794231399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=urexpukjeL615f3Ic2x2a3PTILhWiWJyF4tuEcI3kKE=;
 b=LS7S8X2nXR3G24yYrJyNg32kiNz+Dm1OQkouy0HsZV7kSg3P738uzWeiSB/On75O78
 UnlXdTf509MsTDTn6gloLjiSdhOwRIltRZf/8Y0s9HwEivh1WGnwZKkme8WJdIqmBD5n
 6bw3NC7Lva3xVj+1dEpFlhGlLQ4MOQVXekpiJh4P1flcqLiDVX9pfLdGD6aANgNi0b4y
 /wCPtDq1vVlDEuDwJqdoXP5Kinb9RHMhjriC1XvgZQwCy1nJzTMxS7S+4EdopsOslCGx
 H6oaLLYRPT9bVNfThfYQylQrdmDNA/rmUqPdWO+BdCbvFT861lDVYABARQukKPh/4b9R
 TT8A==
X-Gm-Message-State: APuU4Z+wqwvPB3pplbm5v9BBA5T2OwJrGy07iiPvjlK92l+UsxAb0vGH
 vKFK4pGBNhPkLjVIuJmPN4ywOrWRk+07AkJqGvsWfGXsosu+qp4k7LdQ6drlzuIDP6H1sFIWe/W
 W65oeMQk=
X-Gm-Gg: AYBFou1gZyetrVQgNnV/MvRS8BfOokMdk0nf+njGq0/NjTrYlvokHhvlQxgJrNrKMCu
 nALEO40QuFzhpAspogWaLNIwIXlKh+JVbNuATsceIwjV9DoughnXldvHnrGm2AzRIw5puFBCT1Q
 Xfg5hp3DShAJ1GjBQJtDm0hWOgPuYqtie5dv7vF10iygGyOVOVX1SGN97m3dxP8YusEN5rOqnOn
 RgGq8sK8+/Tvow6xwzgMC/HvQgV5DgEaStMcdQSIDiIiAxPwYyr6Hw7AbT6ZUzI3FSyfRa1oxVi
 alThYrLBGYCUdyU7GgjP/xa69MIZdDY0D9NpAfMBHY/MUjDNBEVxsxenUWLxVtud/WfI7CzVAKO
 9gXX003E1fugH1ORUC3VwduqeEPQA+hJLBVgMvrXpy4hRYGrVQYBgQGOCT5ylU2qcak/vRFXD9I
 qnk+OdX9h0P8w8hVae2rBV6xAnpeRWeUTMhsrPc+VOiRzEuGi/TF94gO+K351yFEw4Mlwg73z2D
 RGRXoaZFguQ0Y7jjQSyR6b+gYZxvBmDb3SvpQErSx2oGRkgNbJkIwXdJUojp5d220bW7dZB+JM4
 rnd7yXFDTo472Rtad1BI0oMHPl6AkF0/x5+NCdWwx9fRuDVWOaWqtkbsADGkj8KVOkX2SE2Tchq
 iQeBZIefHuo9VgVFZ7q5WFUEmwOQjiD60NA==
X-Received: by 2002:a05:6000:2884:b0:48e:b8f:f7d9 with SMTP id
 ffacd0b85a97d-48e6e2bc041mr22745615f8f.6.1793626598651; 
 Mon, 02 Nov 2026 05:36:38 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/47] hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0
Date: Mon,  2 Nov 2026 13:35:44 +0000
Message-ID: <20261102133547.1375701-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The GICv5 specification allows implementations to declare a
MIN_LPI_ID_BITS value in IST_IDR2, which specifies the minimum number
of supported LPIs which can be configured (both for physical LPIs and
for virtual LPIs in VMs).  It also notes (I_ZKLJR) that it doesn't
expect most hardware implementations to require a minimum numberof
LPI ID bits, and that this is mostly useful for the virtual IRS that
a hypervisor might expose to a guest.

QEMU generally prefers to offer the guest the highest-flexibility
setting when it comes to this kind of IMPDEF value, so for instance
we set our supported ID and IAFFID bit size to the maximum the spec
permits.  Since this value is a minimum rather than a maximum,
"highest-flexibility" means allowing the guest to configure a very
small LPI range if it wants to.  Our current setting of 14 for
QEMU_GICV5_MIN_LPI_ID_BITS is the least-flexible the architecture
permits and requires that guests always configure large LPI ranges.

Set QEMU_GICV5_MIN_LPI_ID_BITS to 0, as the spec suggests real
hardware would.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/intc/arm_gicv5_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 59ac1c3880c..a47f639e84c 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -146,7 +146,7 @@ struct GICv5CommonClass {
 /* Number of INTID.ID bits we support */
 #define QEMU_GICV5_ID_BITS 24
 /* Min LPI_ID_BITS supported */
-#define QEMU_GICV5_MIN_LPI_ID_BITS 14
+#define QEMU_GICV5_MIN_LPI_ID_BITS 0
 /* IAFFID bits supported */
 #define QEMU_GICV5_IAFFID_BITS 16
 /* Number of priority bits supported in the IRS */
-- 
2.43.0


