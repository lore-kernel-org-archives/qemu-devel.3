Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DA606A33D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WAoRK5ob;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y+zeoFJP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2F-0003bB-1g; Tue, 03 Nov 2026 06:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2B-0003aL-B1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD28-0000Ji-At
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJfs1agcLVWNKY9WfuxjZM5yPYkv4w0s3t6dLQQ+mPM=;
 b=WAoRK5obiEqWxwBMSvUvc/QNrmUJAcvFgzmkGmOwh3G53sZU6ZNbrxv2Drl3ChtUgI+wFG
 ECYDI9xKzGLr9n3nVy+3CnSQ8VFPaEtoQJWe3SeDD/L3bXyj+OLqEyfxSdEY+/+DQiAUdh
 PBqA1IDUcwZZUPEjGYQ9qqhGTMo6rIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-AfzpXS8MMG-ig6DpwTsdIQ-1; Tue, 03 Nov 2026 06:50:30 -0500
X-MC-Unique: AfzpXS8MMG-ig6DpwTsdIQ-1
X-Mimecast-MFC-AGG-ID: AfzpXS8MMG-ig6DpwTsdIQ_1793706629
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4ae2756fa7aso21580385e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706629; x=1794311429; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJfs1agcLVWNKY9WfuxjZM5yPYkv4w0s3t6dLQQ+mPM=;
 b=Y+zeoFJPfyJjl5NnA18ylX4gOJyhadh4PLsfd0aY0T9BccmY/OIAIENGpaPX7gvAcM
 T9+kgGf3QkKxLlPVnuoeda6Ymn/RP7YkzZYPk4i/T4MMOwy+lScUf3nElzZZN2pdP0i4
 wcRouOmKZ7lYWnFVpcEkwTf0MVocb6cU8Z2c9L13oHfupTD3nkjKR762HBJCn/PY296c
 madCK8337MM3vkEA9f5ME0S0LF7Wzjo/0miz5wUcKIv1aAhG1poN2UfV98dlFwuorVDP
 S+ePdVuIloz2x+1+tnDX8JYw50KN5MrDj+R3CTicOfh+bUMN/IC2PgAbytMmaovAOdqG
 Wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706629; x=1794311429;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZJfs1agcLVWNKY9WfuxjZM5yPYkv4w0s3t6dLQQ+mPM=;
 b=EW0gXt0U+/OhOXdQlHU+FEIOzhJl93hyidfIAPNUvZki3QGbxFlVYT7ALE7HQVFqhL
 rVZMRmEvyMY1B8l0PewPlvkLUM/ge3vuzsVcUcoW39YuE5srupn8F9CiIuamRfga4uxM
 zKM7jSqUFdsZ40iJc7ehz1HDgnnSahQll91VjlYiYuUFOtaajfeIfMr6fYxD6vu+Rrgu
 6N4922t3k4ut+IdCkyMZYgx9rqCvFq+lMoomtIWHM/B9QNkHfjntirrIR8IEd6kBS+O3
 sFlerscd7XaH5FYPTXOVrGhC4Ggk/Z1Nxf51RG/mnBFt8CS1Hj3ulY+LG3uDSLPJNQ/r
 NEuQ==
X-Gm-Message-State: APuU4Z/4trqA3pFoQYbOeZEcEb7+rjYmaIMtm9zeZgQfH7eSKKC6ThuK
 K/35aZnJwB4GRsIRPoypgdsq28FIBOmLlNSGjlv50hQKxd4DuZxgCoptEGpxRKeBhDHxE+nq7h6
 +RY1ZMcqIw9BCGeCYmMnFYvA8g2bYUlTxNrLNr/i4su0ygTznkdAHXkVFNcLWJDj8Dvo29euCKr
 IT15S64e6I0o4foXn5GgpBmXAueupB+zu7ig==
X-Gm-Gg: AYBFou2yf4L/YrLljWq59Dj9Zb/FkJLO6Rmg53m/ypeHvCyFZZs6D3tsa6IjAmzdHAa
 wmearO02LeeWsN7e1QTtlumBO2YJTo1hWNpi45YjsknL5aLJ1KuFvljs62jvI6jHnmfUF9RzhgE
 N0Kn3lSZx7R1SbnIMLiEJ4vPrVDVL/Ys5yVsiiGthT2nLDWBOpQ4lqE14wrEajJz4rDzuIdHoOu
 Sm/Nec7X4/h10+q8XmfdD7bAl983hvsTAIyC0nlf+0PLc3uAgzjuLOyCVIckTbs5kuF8ip62yOZ
 Ewp8d5/S0sE4hZu9ZX6svk/L3rhR7axdp8fH0JmnaiTTh+qsbnQVFy95c779TGZ/CURkvlDIx7c
 9ZLdJiuYuEPYG3skCaCwq7N96p6uY8J+m6rzITSi41w==
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4ac1970b9f7mr285799965e9.34.1793706628947; 
 Tue, 03 Nov 2026 03:50:28 -0800 (PST)
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4ac1970b9f7mr285799485e9.34.1793706628407; 
 Tue, 03 Nov 2026 03:50:28 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71baa1b3sm23678876f8f.56.2026.11.03.03.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:27 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Subject: [PULL 02/17] pcie_sriov: Adapt bar type array size to the number of
 regions
Message-ID: <fde9c56973ffd70818ef6f7967050bf5dcf86494.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261028144539.691098-2-clement.mathieu--drif@bull.com>
---
 include/hw/pci/pcie_sriov.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b0ea6a62c7..5f81e3b1bb 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,7 +16,7 @@
 #include "hw/pci/pci.h"
 
 typedef struct PCIESriovPF {
-    uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
+    uint8_t vf_bar_type[PCI_SRIOV_NUM_BARS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
     bool vf_user_created; /* If VFs are created by user */
 } PCIESriovPF;
-- 
MST


