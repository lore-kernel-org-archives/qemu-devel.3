Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D588C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnQ-0006Zp-8Z; Fri, 01 Aug 2025 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhP-0005Rc-Pn
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhM-0002hg-Ph
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Le6Lc/zgcKxFCuW53MWLO1Ha7klLf+FruZHCeB1RbYs=;
 b=WIDTRQAAXP+08gWdapMmO9XbLwv47jb/0kZj7qS8JDPoRJm2YKSbu5RaIQNW8EuYywqY13
 VtmcPBhUk/fhZ/IF2qCFLjHfvTRsPRX1sfmEFsr5H9T8p7u7qOwk/Mnk91KLn4TDUtkljp
 3cNAca675QVG4fKeF6wZkUFxQQQYN+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-Zt9SDS73OcKVXl5egUa3ZA-1; Fri, 01 Aug 2025 10:25:21 -0400
X-MC-Unique: Zt9SDS73OcKVXl5egUa3ZA-1
X-Mimecast-MFC-AGG-ID: Zt9SDS73OcKVXl5egUa3ZA_1754058320
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45896cf24fbso8840905e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058320; x=1754663120;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Le6Lc/zgcKxFCuW53MWLO1Ha7klLf+FruZHCeB1RbYs=;
 b=NA8E3yurOKjyokiBDyl5tkFpk+oik/8HuxK3aKT4FUCAf5Rkbix3Tb3yovgKxdFdYC
 VuZ119G8vV058UvHacOXl/ooIqaR/YlY1cxRYIXo9j1ILTwmnLQFOYIYa//hUsetIaA/
 lu2DTodJOEuteB9nwqlpNaS13OqcGe7gVvYElnBpB002GLQHAl3IhskNvxs3F5Z03QIl
 EVuKYkD4QXGLbpV/hMQ6wVzxJD9iniIQHYfIX4oI1/cWenzVFSG1JQubG8RDFH/WS6l7
 n8k++CcG/cnCQPlu5OGKQeUCOIhhL4m3EVjLgfIzlKiv2WdtcbydVIeSJ2gHuoxbLy01
 XLNQ==
X-Gm-Message-State: AOJu0YzHuqRyJKyAN3DuIIhC3FHHF/rl9kuecHVoIYBi6ru+UV/NAXP9
 SMUoNxOL72WkfUelIKKetvu59BU5a1hAxMdzuOPJlKKuWcCQU2f0rh9ZJiHZXWCNkO4FDmZcNtW
 s+IuKDQT6WzugUtyIb9l1BCk7vb5Oin+USTgrfqhz8+Opgq2T/qeuY+fvNuJjyV5J2nNtvX2Swy
 KjY7BUIxovuN1Twa6SXB3F84O/mGKmyx8HQg==
X-Gm-Gg: ASbGncuiTPGmpWkiMv9vhfgm/DuCF3mzQ3PGM+tFXONHOLs4X7ez0+LPV4QqNTeNSjl
 ChDFNG4xwMDIUX4DJHwK2QsU9AaFtd5QtLHiRnhr5kJ44EBR5hXZgztr2nXyTg+AC61DWAiofpc
 6LE6NrCOYT9XIxEyaKYESbG49Jy1UEw2ZXJux9dgf1/an59atZOCdR027z/imv7OtEAwtu/JTgk
 swVAuZi2fiMCT3ikSNnoWKCilXYMLk+MB07Cj58OLJLaUgJSbEwXb1LiLqCMN8bsGWx5jUhMtL4
 RENeaXVGO7KKhV1MOeDV708Dw5RRm+ok
X-Received: by 2002:a05:600c:83cc:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45894ca4e1cmr93284345e9.21.1754058319707; 
 Fri, 01 Aug 2025 07:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnAa0qxkeCi/LltrEUId9RU19B+2oEdn/a0TcTBb1Jck+i8wy+8TWvlTodEgjov54muF7PBw==
X-Received: by 2002:a05:600c:83cc:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-45894ca4e1cmr93283995e9.21.1754058319196; 
 Fri, 01 Aug 2025 07:25:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a6ff7sm6154540f8f.75.2025.08.01.07.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:18 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 07/17] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
Message-ID: <47d50cc421b832650822d73431d920bb8a80bc38.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The ats_enabled field is set using HTTUNEN, which is wrong.
Fix this by removing the field as it is never used.

MST: includes a tweak suggested by Philippe

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250801060507.3382-3-sarunkod@amd.com>
Message-ID: <948a6ac3-ded9-475b-8c45-9d36220b442b@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 1 -
 hw/i386/amd_iommu.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8b42913ed8..67078c6f1e 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -322,7 +322,6 @@ struct AMDVIState {
     uint64_t mmio_addr;
 
     bool enabled;                /* IOMMU enabled                */
-    bool ats_enabled;            /* address translation enabled  */
     bool cmdbuf_enabled;         /* command buffer enabled       */
     bool evtlog_enabled;         /* event log enabled            */
     bool excl_enabled;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7fb0bb68f0..037e78056d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -646,7 +646,6 @@ static void amdvi_handle_control_write(AMDVIState *s)
     unsigned long control = amdvi_readq(s, AMDVI_MMIO_CONTROL);
     s->enabled = !!(control & AMDVI_MMIO_CONTROL_AMDVIEN);
 
-    s->ats_enabled = !!(control & AMDVI_MMIO_CONTROL_HTTUNEN);
     s->evtlog_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_EVENTLOGEN);
 
@@ -1555,7 +1554,6 @@ static void amdvi_init(AMDVIState *s)
     s->excl_allow = false;
     s->mmio_enabled = false;
     s->enabled = false;
-    s->ats_enabled = false;
     s->cmdbuf_enabled = false;
 
     /* reset MMIO */
@@ -1626,7 +1624,8 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       /* Updated in  amdvi_handle_control_write() */
       VMSTATE_BOOL(enabled, AMDVIState),
       VMSTATE_BOOL(ga_enabled, AMDVIState),
-      VMSTATE_BOOL(ats_enabled, AMDVIState),
+      /* bool ats_enabled is obsolete */
+      VMSTATE_UNUSED(1), /* was ats_enabled */
       VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
       VMSTATE_BOOL(completion_wait_intr, AMDVIState),
       VMSTATE_BOOL(evtlog_enabled, AMDVIState),
-- 
MST


