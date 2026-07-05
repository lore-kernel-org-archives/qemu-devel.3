Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA98C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwB-0005FH-M4; Sun, 05 Jul 2026 10:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwA-0005F8-Q1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw8-00019o-Td
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DHimW6kdYatJs0jDdZ1l1I3QjMcND/ZKDaeWLIUlzU=;
 b=VaKE6xxL8zXKQhJnZzd10oOxn5NKOvHJpneIq5ZRmuysSfzcnLEWrzDRERNnAeoEvn/Qs6
 71m45JUquYOk/nKyvzsTB2LvEzblgDzYhVOuvRo01ssWUycDF8X1tIiRLWe25RDpMwdMxm
 PcGQXGFj/nU8P35GQZMj40XVf5BzTCw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-cHRAV9X-NHy-VmH1SGb5Bg-1; Sun, 05 Jul 2026 10:35:07 -0400
X-MC-Unique: cHRAV9X-NHy-VmH1SGb5Bg-1
X-Mimecast-MFC-AGG-ID: cHRAV9X-NHy-VmH1SGb5Bg_1783262107
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493b0a5e636so20534535e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262106; x=1783866906; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2DHimW6kdYatJs0jDdZ1l1I3QjMcND/ZKDaeWLIUlzU=;
 b=DY+mfuXw52j6/T1INrGLgTpkSxSFE6t4bMCZ3wKpiayYiRJk09eOXifliOVTf7rU12
 7sE37S7+aJ+wtfMuvOaBgTuZpiaHLmU8sK0EE630jfdYK7LqY4jCNmivb0iQJJZSDwOe
 la4dn1CWIFbiJaHNdMBa3tV1U0zhT0w9bPxOrZmQWNRo6M2wcFKMyvQhrNj01/weBThU
 kWYKaUEyMhz3CVqNGYkGBkxLN7pSNJN8BE+pt60oF7wHMS3F73jml3o0i5s07TlCkKSB
 XaD6YIwu0dGF9kj/vTN6k6PrhHJ6jkr4J5xN8grYgR6etKEj9qzwiCuB1/gdghjZjO/2
 vpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262106; x=1783866906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DHimW6kdYatJs0jDdZ1l1I3QjMcND/ZKDaeWLIUlzU=;
 b=mAOSUHZQXiE4K+Ek/akiSz1rahERqxixwPnq3UeZsFthgnkdgybGj/PrU99YZcLLb/
 CMHj4YmzgGUazBkTQ7/UI+O1zYukOdNgaFfsRSEwgDb6+HtGlKRc0bkmMde58EsdeI+D
 bB6E91l36hRaxnlejWYbUcwKukW5NQ+gO8oaZuVQ7+fNlMwf7QqRvGJ95M3a4MywFHwj
 hzBLUdnVt4CtTWTuT1I5D6lHpALFr+YylQEOpqahZvLULWwkkkYduFBhF/yjtIV83ZcX
 IhDO3nWeWleaESjOvdSF5i7jpeIt7Tg1uKPt2nwXsZPtqRdQHopmhsvCU6rK5NcgO/uz
 JRwg==
X-Gm-Message-State: AOJu0Yx4mjdk3Op0lG5aOp4JGyQNXW7hOE2d8HazxsSSqEfuUlXZNsIP
 NC8f3jA2BJmmaNXC/LPf+hDEP11FGFxA4Y1zCCzKgdOayEp+eTtPfSLFCNYTtsV9IcieMUuHIbF
 IcqSjdRcuUSSomwUZ6Ou/rA7NqsGrc4CEV7rodCad9uG4puLGiwP/icwIy0OTD9NO/e/+3n/a0e
 6ZV8LO77yldtYQo6AdBaRkGJ4z9CRb4iTZ/A==
X-Gm-Gg: AfdE7cmNjjTUGcPknO1S00SGJoT/lYE0qM0RyJTL+vGzt2w1QTPMjADcGblWaui/Okf
 vlWv1HeiRnHESyI1vwUzotqVmetrpCMPdzST/w9kKYhT3TnVKww1Db75DmmD4PUe/QtA97qN2XB
 lNegO1CSUNvmMK/r9nLIztdAA1UMGR4oE2ePKWcQaerUxF3JEQOxUxgXetLh+auXjVSlsds7fOt
 MNGi79Pb711Pf+2D8tYmgCsfkwshECGLCaaFVjwS21PaurgV/CXf40KolEk48IRinZ+VRQsPXZl
 h2vON5KZFX+uf5DmboeKzadOR0SffxVM63YLhPXh7NE84RQ0IJjNyxLoa4puN56XSNAKmNdhR9v
 hSyEH3CgUG3bf7iAKZR/scmwNwORE/f+3
X-Received: by 2002:a05:600c:1554:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-493d11f0598mr82524465e9.19.1783262106536; 
 Sun, 05 Jul 2026 07:35:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1554:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-493d11f0598mr82524015e9.19.1783262105969; 
 Sun, 05 Jul 2026 07:35:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm231746015e9.6.2026.07.05.07.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:05 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/44] MAINTAINERS: cover sp-mem under Memory devices, add R:
 tag
Message-ID: <ca44fcee5a0d49cc4cf2feae6adacb57d7936f02.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: fanhuang <FangSheng.Huang@amd.com>

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-6-FangSheng.Huang@amd.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..5ee7c1f601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3417,13 +3417,16 @@ F: tests/unit/test-ram-discard-manager-stubs.c
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
+R: FangSheng Huang <FangSheng.Huang@amd.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
+F: hw/mem/sp-mem.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
+F: include/hw/mem/sp-mem.h
 F: docs/nvdimm.txt
 
 SPICE
-- 
MST


