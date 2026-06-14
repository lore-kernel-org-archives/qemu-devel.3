Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6CCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCE-00068F-9E; Sun, 14 Jun 2026 15:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC4-00061t-58
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC2-0002B3-QK
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fM+6MOhv1VsWlyXc3NgGA3Lyz4yYGMByriNOzqqlJGA=;
 b=SEWKlPFMlkXKJg/vHTZ10RStkciTe/NAgx/Vh2lyqVlx+8fn/4qjWAtkTbDvi9t3nsw54Y
 VBo5kD6Dy4oOCeAqFpFuqeSkMMzDn9ILdaNTO3n+kpalxnodJf4fNw85nlJgrgNtQckqM0
 8s57/PHygIkSGJhjdW+pKQld6R3bbZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-XJrigv4TOOC72OUvek5ysg-1; Sun, 14 Jun 2026 15:08:24 -0400
X-MC-Unique: XJrigv4TOOC72OUvek5ysg-1
X-Mimecast-MFC-AGG-ID: XJrigv4TOOC72OUvek5ysg_1781464103
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so22030885e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464103; x=1782068903; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fM+6MOhv1VsWlyXc3NgGA3Lyz4yYGMByriNOzqqlJGA=;
 b=ZT0iTUsekcjXfvjwlVpK2jc990QggF1CJ12p5DkUlOl/YvcD6eQ9HlVFw+dfbaiT0L
 dxgZShfGLitJP91DloHyTFoNKp8COvZ/zu1srbhWM2fh7a2w930a3p4sBKFKxmVuUBZQ
 Cj15Du+BZMTJszXwu0EzfkmdpOsSzuMrnf82hOw5VGXqwMPf6bbhaVaPxIJe8j3ZwOgp
 y50HHEugU59b8u4F+xal3PLojWvskFEGuFOOhR9Fo1mmSP5JjYSP0sEyY1L7vzE6lH0N
 RdK/psjTGeaLGD6lnZ99XdDijES+3SoHcFMATpwezhTgY6+Nwmug6gq/N1DOYJ8R+4v6
 NQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464103; x=1782068903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM+6MOhv1VsWlyXc3NgGA3Lyz4yYGMByriNOzqqlJGA=;
 b=qRZisfN9Ffk/Tw5T+3HyJ04POQ/egZ10Rs1MGHtIvplx4MSWj3bpeef5+S1x5DoZau
 ksOqGlxGGnRn3LebXp+fG/tPxvOyiiz3IfWEnKPWXZqq/lEruV0F0Wg/BL/1pzlCkrB5
 yAgiE+968DXZPpkUr0Flm9GOa7qrCX/NekhCVOsPIfebirJ2rkY4c/Rhi+aKQ6uhDON2
 +VNP4XvKmznDY4Pom0oLLc5l84zM8CObPPIdv6rEqZiyrkM/0CcVYt8zGSci+T/cWrGy
 /AtfsHxdaqzor9w0b8B9qTvUdJrpTQKwKHzEQ8ruY6J09SRy+TCWSjKTEW2UAgUZJJC5
 nhkg==
X-Gm-Message-State: AOJu0YwDbcZSbzgqUw1ytslD+kBaqszEYDJvLJN7FMReFGW6uUnblZsW
 WJZj7KBko/4V9SuGvGPXzjSFV+/HfxU78V2X+T9dQoYLHtP4135qEpEAtPGlXsOmMNySO4SA4i6
 7X+ERdlvHm66BtEycJnsZ4kzdXzwoxr5fiY8nSvfvmKXbRG+k8YuH+uOWSa0muTMr4hR+yjLeNq
 HgYtqsN6eyRTakIMFCvYd+EFdHTuIT+1hh1g==
X-Gm-Gg: Acq92OGHxOq37T+/7RgKahB4fQulEketKapO5KDumC+5xmHHwEuaSgasllYqb0DXn46
 pKtkxiDolgCRHqOEeARlVHNQK16S9wJVpAFk9bT1pZgtuBRC+c6T91wzQ5wXJhnVef0I7UYXqMx
 B63LGvFvYeyh1/XxCaq3jN4Dt6g7lI9ycvXmkChJRnp/kP3Lk7bk9hGeTUNjLO6pAsrpFl4nID/
 rRy/+JioxroM52e9s6mRHzDLtffX70+AB1Xx8OJiUFSpQtExYGtPN3ZCByUGQgtfsduZsX2SJCZ
 wjw0wzbGhqZJO/ZjvJzCjdAlo7cUEPm1BEKbAmy2uKN9aAafxNDzsFPJhV3nfJKfgMZVL3sbAab
 M6jt8p5hHqeWWy6dEX6rR7uelHMK2oezyi6gaM1sSInE=
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-490ec503f0cmr127714045e9.31.1781464102835; 
 Sun, 14 Jun 2026 12:08:22 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-490ec503f0cmr127713715e9.31.1781464102262; 
 Sun, 14 Jun 2026 12:08:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm27198427f8f.18.2026.06.14.12.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:21 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 061/106] MAINTAINERS: Update CXL maintainers entry including
 adding linux-cxl list
Message-ID: <7f79ee47951bd263b1447ab0281d92b69e2b70ee.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The CXL maintainers entry needs an update.
For a while convention has been to +CC linux-cxl@vger.kernel.org to get
better coverage for CXL aspects so formalize that with an L entry.

Drop Fan as he has not been at Samsung for a while now.
Switch my email address over to my kernel.org one.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260415143040.22223-1-Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b768fc080..5a82aa3a05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3203,8 +3203,8 @@ F: tests/qtest/migration/cpr*
 F: docs/devel/migration/CPR.rst
 
 Compute Express Link
-M: Jonathan Cameron <jonathan.cameron@huawei.com>
-R: Fan Ni <fan.ni@samsung.com>
+M: Jonathan Cameron <jic23@kernel.org>
+L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
 F: hw/mem/cxl_type3.c
-- 
MST


