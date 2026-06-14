Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A322BCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAT-0007gY-Rc; Sun, 14 Jun 2026 15:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAR-0007fa-Gh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAP-0001m4-Ll
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZsopqGpLlK7+7VYJodV0OGH/y8AVf3Uk2G7CPbsNOgc=;
 b=iFeiLbylBH/ex4kb/vHp2fLFMqp6eFP3oWwNGKT1Nept8Xtb0el8z+tZ2DpP+0YcnecykV
 eRHFEpRijJBi4HlMujgILRFAhCkcRZJejAlCQ4oKJ4+5w0wcOGiL7ojnMydc4VYYQT4Nbs
 Wx7Pu7885NjCs3790wzRU/KNlbFSKxA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-yAOlQWdaPuCp4T7E9kN2sg-1; Sun, 14 Jun 2026 15:06:43 -0400
X-MC-Unique: yAOlQWdaPuCp4T7E9kN2sg-1
X-Mimecast-MFC-AGG-ID: yAOlQWdaPuCp4T7E9kN2sg_1781464002
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so17528705e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464002; x=1782068802; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsopqGpLlK7+7VYJodV0OGH/y8AVf3Uk2G7CPbsNOgc=;
 b=X3Uz6pvsk5t9i8aikfXMwamjzxEwvJyWeWGdfUFzhuhspq6Tk+/eO5whDFqXr1XbRY
 uDYIRwqecoJsDwPH15a72/bJM0PAnXoGd20cGV2KF7SjvfDuQnFYtBUXuPrqG221WBGg
 3it6B28Gon11rx+2aUvWj62lE+6DDdVEVDx75jwwjvkfy73SMI7TFS17zVp/s4EtNh3K
 PF4TGt0udEMJCr1QitnZ/0DHiTIbH0HJel3mCAC04NwYg8d6wYGuJarZr/BxoEgJmrvt
 P385Lw7PliIAksbavyyaXOXuV8rTRjPbsMpUSP6m/akd3UODSFov1gizuTSEsHy3P1BJ
 12zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464002; x=1782068802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsopqGpLlK7+7VYJodV0OGH/y8AVf3Uk2G7CPbsNOgc=;
 b=kbe/63WrJRKUuZJ4li1ZjJQ8/8PmhQ65vDe5eTvkRchrFg/wgr1mBAi5ZsZKsuQ/gp
 TKFzbJcUgWpXruSwmqUOayMPEKFeMWilNI6EMi2WP0XD0wjBriHYtuOiJQ1+2yGEV6hq
 Gza8mtpPE6t0Qc6iyKqd0Sx67Hdgwyf5t0DlDLvQnWVnlzVGcoaOCcfSwLXfICurXfXS
 ksh6onAd5dd7+juez8cYfD8Jf/3b2ZZL0vC+xH5x5dnmCdNa4w6rxQ8JllkGjEZYU3Ki
 s25ZMZsBXgNGKKh+iBkRfoXF1B4IgMqDifssTwE5jOLZwGZqaoGZEsJG3Bgm4Xof10RH
 K5hg==
X-Gm-Message-State: AOJu0YxeDKkcqK4WkejopyvCwgteuphQMVQjanwSpA6ZaweU18J+bJEB
 faiTr2UIASyjreFhkDCOHDHLYLN2EN9zd3M7ToIeshzRkzUCUKqvh3EWDE/hqdKe4x2cUyzkiIb
 643IGrhfhVd5g1yYflwqcIsxMs+mmzIdBpJc8SBNf2SQ5tzNIFBE4J67/gGfFyQLxXacG8ABwwg
 b2/BMF9vnOv3xM125UQkZ/djY9+HE9FwY9Ew==
X-Gm-Gg: Acq92OFKnzlU3mtTMW/sFaKNprlKk0TJUf2/YspnfnpU/QAkvY8mhljefRldZUZWOAa
 XHWF/RV9xxXUYd8V8uYr9dEz0UwarTCTWp0mwpgSfIZ/nS4IuOzdW6HJ4bKizw+YjfhIkwF1ZZf
 oj8Pg+3iXEqt0sqBDyqDze1pLNR6v9LubkCqFXBmUv673/nxthHQorL977qJpXfJ0rzpTSNQYr4
 xIsLVRIX/DcYk0NOI1e9/1aobDcBb3XufW07ZDS8ypRc3g9pSGNlB7li2x7vtq8fWcI0/DGHe88
 3A+i0fi3HPZ3sMYesdXqfhGE/hF3pQCagbod0qRXF96WHS78BpVGHJEOskf2R/n09/ONh6uXiUj
 CVafvb3yVzz8L184/myXNnT5EtSh9lH9JcGSVuJNya3A=
X-Received: by 2002:a05:600c:524b:b0:492:1f06:ec9b with SMTP id
 5b1f17b1804b1-4921f06ee55mr104877355e9.24.1781464002344; 
 Sun, 14 Jun 2026 12:06:42 -0700 (PDT)
X-Received: by 2002:a05:600c:524b:b0:492:1f06:ec9b with SMTP id
 5b1f17b1804b1-4921f06ee55mr104876935e9.24.1781464001752; 
 Sun, 14 Jun 2026 12:06:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edec6sm202482495e9.3.2026.06.14.12.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:41 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 023/106] hw/acpi/aml-build.c: add aml_irq() representing the
 3-byte IRQ descriptor
Message-ID: <a50499350010ec0d238185f3c835f3fb39e58032.1781463125.git.mst@redhat.com>
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
the interrupt information, however newer Windows will only parse the
standard IRQ Descriptor when enumerating ISA serial ports.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260515150634.2637533-2-mark.caveayland@nutanix.com>
---
 hw/acpi/aml-build-stub.c    |  6 ++++++
 hw/acpi/aml-build.c         | 27 +++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
index 89a8fec4af..3180c7c962 100644
--- a/hw/acpi/aml-build-stub.c
+++ b/hw/acpi/aml-build-stub.c
@@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return NULL;
 }
 
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    return NULL;
+}
+
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
                    AmlLevelAndEdge level_and_edge,
                    AmlActiveHighAndLow high_and_low, AmlShared shared,
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7edc8aed42..413d9b6240 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1061,6 +1061,33 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
+ *
+ * More verbose description at:
+ * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
+ *           6.4.2.1 IRQ Descriptor
+ */
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared)
+{
+    uint16_t irq_mask;
+    Aml *var = aml_alloc();
+    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
+                        (shared << 4);
+
+    assert((level_and_edge == AML_EDGE && high_and_low == AML_ACTIVE_HIGH) ||
+           (level_and_edge == AML_LEVEL && high_and_low == AML_ACTIVE_LOW));
+    assert(irq < 16);
+    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
+
+    irq_mask = 1U << irq;
+    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
+    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
+    build_append_byte(var->buf, irq_flags); /* IRQ flags */
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index e70e0643b1..eaff025d26 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
 Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
                           Aml *offset, uint32_t len);
 Aml *aml_irq_no_flags(uint8_t irq);
+Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
+             AmlActiveHighAndLow high_and_low, AmlShared shared);
 Aml *aml_named_field(const char *name, unsigned length);
 Aml *aml_reserved_field(unsigned length);
 Aml *aml_local(int num);
-- 
MST


