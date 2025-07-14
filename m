Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36E1C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGn-0004PC-DL; Mon, 14 Jul 2025 19:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGH-0003L9-IF
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGE-0005RL-SJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlEUxu0QbathLxyjzGMenvHrSMIjCRY18hRcRGld0Wo=;
 b=WU0+FyteLBY4gDHorN9qImCXMq3qh4Vi4LhS95ztbUSWwzvbvsA5UHFtw+WK5WtzFU11KJ
 /DG9OxwuU10Y2yh+waumNC7uHJWm/VyOl4LC+qWXnyt8B+azn64pmb9m1YuNwh6W6imF2k
 l+rdHtVL54PkAEsDpbf1B8VvqZF+GLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-0yaRP4AwMLKb8o3fi2-8nA-1; Mon, 14 Jul 2025 19:07:01 -0400
X-MC-Unique: 0yaRP4AwMLKb8o3fi2-8nA-1
X-Mimecast-MFC-AGG-ID: 0yaRP4AwMLKb8o3fi2-8nA_1752534420
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561bc2f477so9105705e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534419; x=1753139219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlEUxu0QbathLxyjzGMenvHrSMIjCRY18hRcRGld0Wo=;
 b=ZEjLCd+r0uz+16pWzBbcn+xVB8e6CL7w09vYDsjaPYAc8aFzdrvVz1Z1RzPhSWOc3s
 UbhnZDzH91DuFd5Q8mPxSIS5hWCTzKKYr67bppjRfirzbvcwf5EFVdkGJDdhndeyQbyW
 dDgzOf+GSmdWyp82bdYL5WcSVW8rV+oMc5hdqJb4O4/gl2jk3TZYkLJzEIJbGretfYaN
 Yxp6EWoxdVWualiyEysGNLOTwntl1lT75Z5pTu0cJieJPp0p+PXM5YK2YEbEN97kFWBy
 xdYwY7mEp6yWUajTN1OXMP5Ghelk9BgvMEf+QLyNRyZTHcrgM6Yhg4o12C0JVgAYuJcv
 exmg==
X-Gm-Message-State: AOJu0Yyzjmr4btO+yJO3Wklx6nsExy3o+4zKsPl/lNbx2yc8Iu67hH+1
 qUWlUgHU+4Yn8xd8Y4abW/eRVbzOXEEgj0rGUAQ3iwtjpNOhULsRwul45mskdOV+pQcdSM8X2zi
 ta0gdDpUuse09ZfXm7yyqMK5J8mVVQgL66ivIWozxAmPWu+ZohuYBsmyJhHBOJD9cfS00LHHh1D
 YAqEBDRsrGvYvYrQy3LaO8yXbTwVLqlk+uiQ==
X-Gm-Gg: ASbGncuK1zizgeYPwdpfqs/OU+QgVaXfyVH71aCwy6sdzIaT+vSRZQGSKDKck3vBevm
 jTT4VzN4Ik4GqNMFLTogJhdp5FcFJJnA8cwPkNc05LlOkiZkE5jmvrCiDt1IjCKqBpaVoL1TF2i
 dmKB34keRMu+uIivNDb3eryPmhXbJM11MvclSRlviM7cmov0tTeQbKZFixG+lLJNZOuYaMAhDoZ
 txb/kBf5W0aci+17nBHjtbOJgwJp5nGLvTySyYq/SpXGGObublb3fbP2YKr83nyAiq9iuozCus8
 R/RKwAZZiza/NDEhN876qcEInhMy6luo
X-Received: by 2002:adf:cc0d:0:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b5f18fa89cmr9869178f8f.53.1752534419552; 
 Mon, 14 Jul 2025 16:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6oPEoZhSA/2g1EzuNJXD0K3wMcq0JXAeoP446l1a7/lNpn1Jw/S4+gLOvNyPOQu6Gt6f70g==
X-Received: by 2002:adf:cc0d:0:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3b5f18fa89cmr9869157f8f.53.1752534419060; 
 Mon, 14 Jul 2025 16:06:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ee3sm13793146f8f.96.2025.07.14.16.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:58 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, Ethan MILON <ethan.milon@eviden.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 17/97] amd_iommu: Fix Miscellaneous Information Register 0
 encoding
Message-ID: <091c7d7924f33781c2fb8e7297dc54971e0c3785.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The definitions encoding the maximum Virtual, Physical, and Guest Virtual
Address sizes supported by the IOMMU are using incorrect offsets i.e. the
VASize and GVASize offsets are switched. The value in the GVAsize field is
also modified, since it was incorrectly encoded.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Co-developed-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Ethan MILON <ethan.milon@eviden.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Message-Id: <20250617150427.20585-2-alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 5672bdef89..3b1d2e9da5 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -196,9 +196,9 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
 
-#define AMDVI_MAX_VA_ADDR          (48UL << 5)
-#define AMDVI_MAX_PH_ADDR          (40UL << 8)
-#define AMDVI_MAX_GVA_ADDR         (48UL << 15)
+#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
+#define AMDVI_MAX_PH_ADDR       (40UL << 8)
+#define AMDVI_MAX_VA_ADDR       (48UL << 15)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
-- 
MST


