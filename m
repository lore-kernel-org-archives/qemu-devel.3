Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9591091919
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KTE-0006hb-Qg; Thu, 19 Mar 2026 16:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTD-0006gu-6W
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTB-0005s5-Di
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so1123633a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953992; x=1774558792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ir/Gt6emdsq9JA6pjxJ2hRDANL1XoU83i0s7uDAsSk=;
 b=s5X5JFoMV/k1fXyxClwIKPQosLh5XG51H4YsnQvwz0nCYEmzMA/DA3OfVrzIfsYcPX
 rmkRAUembv4eSWKGYlcTvwq7RjgD1Mk08V8M13mVmkF3dtJKBq07nwE71nSAEnMJouLL
 Ij897w/oiDj3LQfEt7Id6AO7kB7E1IAZimKf2IgLTF8jBK0OKdMiaUelLFQr8Y4yQRCQ
 GEqkZil6BrYwX/w1zVck0pCHpmWqtVFFrTbAMEj7NO+sVV5NcPv3asTmrQSm9Zb2CLly
 8YudRETeX2RUI/F3n3go0+4T6jI7Zms09+SLc6zf1u5NuApKf2Y1ib1Y4ds6lydncZiI
 kT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953992; x=1774558792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ir/Gt6emdsq9JA6pjxJ2hRDANL1XoU83i0s7uDAsSk=;
 b=G5Rq3yZU75pggsbJoVKILJHOKn7PrL0BzmkGoBmrZJ7/2r0rK+z1rUcAJ/flXYOvOu
 tXMkjeDrzEb336NjpehO29xP9r+xnTmG/cfrbnIaD+sQJTQi5hjS3OtOxO9RJPxSWFx5
 0PQH+QfjipYE40sLDTJpl0vsjGPuaRiiI550T6L706FChH7dL0yjJAmin7BZab9JZJ+5
 WYcCz4xY+xXgdJnJ9L2+X3X+SrPTqvArNEcEVOhijv2EGcxsSLQBUkwlR/8Pcs1u4n1a
 GqyVS7vIQ0QYynny9dk5CerT21A5vbNBWdu4T3IcapEQYe1W0e51XJISvKkGZBHib4n5
 0D4g==
X-Gm-Message-State: AOJu0YxWpZZw5fvsCklrYPjFuFZZeaDQJ3zizH9gaLuRPKjx7GBpr4gX
 1a7o2XclIk+LlBbQoIFHuMe+38sEN+R1t4PXhyDluoX9wgnZBihN4gTI5cBcyqgg10cnTM0ahV2
 4b49qc/0=
X-Gm-Gg: ATEYQzwhfKA8n7g/ob3uZb81R9MMsI4OB9bcBMTdkhKt/siIrvCqbTQFkmIn1/ZwpYK
 cwujZmVZcrndn+Qb2tX8GhgSE5CEjls/7K387H97dO5vOTXJL6zKrjlBIhG/+G9ik4BHo2x/kYV
 ww1uQwFW0NEyoF9YBk3ZjpORtPYTZpGGeRtpDJLSa65p0/IlEcQRRqG2eD4s7AhtLnXfLTsW5E8
 WAawODmYwgQWj0pFzva4cvPRtqEEabivbVbLLLPpFfmVJjs7hfTV3YZvA2rSD+oBJ8RLeR+3oVv
 xVElQ73rMok1t2XOx/cqMr1eYcCimVf5FgIsbiq4GH6HbGDind+edbufw9jiPWub59/Y2lJKc/N
 wNvhh7+zMh4XztT9I9xev6aDiNH4dkInwWRji9qEUClCe2XNjDsaZ453sBCTzMRiXLKD69Hqo9S
 0hztD4ogD0PXDfY9QLfBwl1FG/4GPv5avEKnT7/HcJTD++iKsFD8JR9qYfxJGvM6tLAEkXy1Yi8
 T80
X-Received: by 2002:a17:90b:2e07:b0:35b:a0f0:8327 with SMTP id
 98e67ed59e1d1-35bd2719d1emr450993a91.2.1773953991838; 
 Thu, 19 Mar 2026 13:59:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd40e4bfdsm31273a91.9.2026.03.19.13.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:59:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Date: Thu, 19 Mar 2026 13:59:41 -0700
Message-ID: <20260319205942.367705-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
References: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In case current kernel does not support /dev/iommu, qemu will probably
fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
since QEMU opens it before /dev/iommu.

Instead, report an error directly when completing an iommufd object, to
inform user that kernel does not support it, with a hint about missing
CONFIG_IOMMUFD. We can't do this from initialize as there is no way to
return an error, and we don't want to abort at this step.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 backends/iommufd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c03..e1fee16acf2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -82,6 +82,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
         } else {
             cpr_save_fd(name, 0, be->fd);
         }
+    } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
+        error_setg(errp, "/dev/iommu does not exist"
+                         " (is your kernel config missing CONFIG_IOMMUFD?)");
     }
 }
 
-- 
2.47.3


