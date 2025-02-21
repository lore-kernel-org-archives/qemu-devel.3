Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5AC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5Z-0003Ag-HM; Fri, 21 Feb 2025 07:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5V-0002vz-Km
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:25:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5T-0007GH-RJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I0OkFCZq8v0ezATiJzoCyWDoQl7Sr4+CP54xKEjqIMM=;
 b=Ar84hrt6rRC0c7/4PeGtgtXSOXsHZXB0wx8tz6wcVVUBQcQGQ4d0POfBxiirqJMvWtqZAq
 NCEPHkVbNc9n8ZaJSQH1XyZFrIECk8JxYEiSf1obEqMSZyjfKYS7k4sl/VD4+XkpJ3mHYi
 YJNjn+5tm6Hkqx07s91xXm/PNKGHhZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-RKQWpiuiP4eTqM_CqD4sLA-1; Fri, 21 Feb 2025 07:24:57 -0500
X-MC-Unique: RKQWpiuiP4eTqM_CqD4sLA-1
X-Mimecast-MFC-AGG-ID: RKQWpiuiP4eTqM_CqD4sLA_1740140697
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so14811695e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140696; x=1740745496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0OkFCZq8v0ezATiJzoCyWDoQl7Sr4+CP54xKEjqIMM=;
 b=nE/oDWe/KWKW8kT3OIDw1U0Br8YEzV74+uE9N7/M8nZT0wiBBrJkTVDFc9TIjo8pP7
 rbVV5TU/M4NlrlZrVkc5GHKryPi9n2KT9bh74MHCMKrEh5WqBIO1gfOr77ZzY1FUTfly
 8KROW0rmrY9vYxztXPFRbO1l0r7GCJ+rJ5rk3U/9YARA+wHwILEf+bC2SIYy12h+ZtHt
 mwxVUxdil/lqO/hI4mDfyPP0qCfJnCLemz8P31UCtq6lG0z84HeIjiu7v2o8pTzkpOhk
 Qirjvq3CQGh6BpY7LSkkfz0GsASXNjBfaNIiwy3a3hxDMt2dnrNoQ4Gri5QS0qK29+QK
 2ZUQ==
X-Gm-Message-State: AOJu0YwKZ/jbutESI4O95hJ5kdxGLl7QotQ4Xht20v1HSLQWI3ga1+v6
 C5WJ6aUHyF4eINgzVNGVloeH51iT9rKAaPoNyWJnbndoOlTvNjZmxHR/Jeuy64nbCgEV8Iuql4Z
 tyUCy7KjQsNzxm98ZyUH2CtaMMbSb/T0j+s+swdBsuyqyRWGwAM3lyA+5Jh6P0QWhVlY+jxnfI1
 oZEywH2LsbHIsegq106kAfZ2Hv3spdPA==
X-Gm-Gg: ASbGnctBLh0WpD0+6EaijCd92cgXWtE9OC39qS43w58vkOqyvlixkoPRjE31Q9LQMvM
 7rsdiM24cFkUAv9BgGvCxK1Q7EC3aHuC2/DTu73QyoHYQtPvtdnmorgWj3V5Bt36CgR6E/EmQay
 XR2IWf8eX1PhGD4eipglTGSNoLXFIFEEj1fqld5HafYZX/Yv5DiNDG1eMaodAN/otwrZ/+eTUs1
 Bi1WvRt9Gyei09S74Pk3s49R6aWgjaPoLOH5eIgkKttUwsYfV+I/KqBjNtDZy4ll0wbNsupC9aK
 wsSanA==
X-Received: by 2002:a05:6000:1865:b0:38f:32ac:7e53 with SMTP id
 ffacd0b85a97d-38f6f0b189dmr2926310f8f.39.1740140695946; 
 Fri, 21 Feb 2025 04:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1VdlP3nDv9m/QVmbN66yECgtSWRc76CHq+MPgAz5kk0JJkt5SGKyisEDedvAy6RtJeKfIHQ==
X-Received: by 2002:a05:6000:1865:b0:38f:32ac:7e53 with SMTP id
 ffacd0b85a97d-38f6f0b189dmr2926280f8f.39.1740140695503; 
 Fri, 21 Feb 2025 04:24:55 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd51sm23265433f8f.29.2025.02.21.04.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:55 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PULL 41/41] docs/devel/reset: Document reset expectations for DMA
 and IOMMU
Message-ID: <dd6d545e8f2d9a0e8a8c287ec16469f03ef5c198.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

To avoid any translation faults, the IOMMUs are expected to be
reset after the devices they protect. Document that we expect
DMA requests to be stopped during the 'enter' or 'hold' phase
while IOMMUs should be reset during the 'exit' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20250218182737.76722-6-eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/devel/reset.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index adefd59ef9..0b8b2fa5f4 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -143,6 +143,11 @@ The *exit* phase is executed only when the last reset operation ends. Therefore
 the object does not need to care how many of reset controllers it has and how
 many of them have started a reset.
 
+DMA capable devices are expected to cancel all outstanding DMA operations
+during either 'enter' or 'hold' phases. IOMMUs are expected to reset during
+the 'exit' phase and this sequencing makes sure no outstanding DMA request
+will fault.
+
 
 Handling reset in a resettable object
 -------------------------------------
-- 
MST


