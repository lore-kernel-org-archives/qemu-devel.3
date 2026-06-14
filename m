Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A5BCD98DE
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCL-0006aM-7e; Sun, 14 Jun 2026 15:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCK-0006Vm-6Z
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCH-0002JX-Qw
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msN9YtJ2beDk7iFPqt34oo1y2Ho3ePmmXDQmM1YHnyA=;
 b=YQZYVxqyspujZIvKfrAFLO3P/LhWiLYefiTck1/FOVJkY6IL5fbmaSQaw8syLMm4xV8ZCr
 aoAZc/Wn/WCVKgvIgBhqQDBIqMDmOGrdp5XpoyPdMciCoKwWF0N85fEYfTzkNN4Rr0bjpW
 oX7RbBAu+d3xho6BdmNx3Pg9YwGKfz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-EKe4jW9-NySAqxyPxDIXrA-1; Sun, 14 Jun 2026 15:08:39 -0400
X-MC-Unique: EKe4jW9-NySAqxyPxDIXrA-1
X-Mimecast-MFC-AGG-ID: EKe4jW9-NySAqxyPxDIXrA_1781464118
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso1475528f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464118; x=1782068918; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=msN9YtJ2beDk7iFPqt34oo1y2Ho3ePmmXDQmM1YHnyA=;
 b=W4SObDBGida6ezcNO4SA1w6VvKjJ9nH5eNCJ7hjz6oKR2aGhBWFlzCJd84jQ7Aczzo
 SDCld/6+e2x8H0+iZEAThigLgv+AeQlqs6MAJzAzHAFaAWubBf7XleBD3oDbeYbunRmU
 e7NpI4J0PCB2wKwpwsErHpfujDEpwRTTDkX0iV8cysdlVhB8B7kr65eeK8NhMNt2ks96
 dvtTzVF9L6kOevudS58uIs7DKKlmPXS38+Ok3I+CEwoQBE1n8b3xYC27WtYEcRWt59Fs
 Kcm5u7c3o9Jl/tmSmTFT3eJqtOlGhx70S9qln6Sf0nUDnTwglrse74lk2K5cfn1j+keC
 0xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464118; x=1782068918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msN9YtJ2beDk7iFPqt34oo1y2Ho3ePmmXDQmM1YHnyA=;
 b=ec48h7SWRCD0HRZ+3qASz9iHxsMkMOyJG2bBL7Ft1hco0fO3p/xFNeOfeaqCZp9haa
 PIlaqCn9D172j47/kTWWoCpVydUJ13NQXYrs6ceGS+6orBDBBYCG3uluBUaBNnUX2oob
 I/At4rouI9u29ukJMTrLzWssHmvhtMrOJX5JwtHnEFbMJBH2z5rusCzGxsDJ5nOjA7Bw
 J+WgY4K4FFf5jbQJvhYQ4dx0t6BjYTpLO00CNmAEusISq1djLOVmMRxsk7CKjBTexENL
 FLMwOPNJ18gFxTmeHRSBmF83QPSRoN9bsGXtOKQhfCd6/FMWMgYi9qjEDGinbhihoyHq
 5RHw==
X-Gm-Message-State: AOJu0YwFIcx3bP38dsjvx/5pTA3B1GXo1lQ1G9uBlLmG6XxUXVWhcBFS
 4TX2jnIT38ioFNVbqingYoyuIhPPcSwDft51ZkZDOva15qs/nv5EKxalR1vsezLR7wl3vcsT+jg
 6TF6MZgC3kgyu3noiYfkjvGbt6QJbzIQwU8+anw91bJ7MoNhEXZSvSvhVjxB6Ftq/nN93l4JnCR
 DRJMx1ykvqnz+6puZQW1fWSfEtyO7A4ziBCw==
X-Gm-Gg: Acq92OHxsUCTNQ/WshFrLG9BjPUYkwf1hRYEi5QA3+c4GO193dqzNg8Hz4gL4+x6rFW
 3ChjOihfC6r6cgOSs283N/YcUpD4j/Ur8utGEm27NHJSi4mEIeUyAtEq68lzrMadJ1UroBMqFEp
 eZhAc4EQCuNTeiSCI0Hcctr+wgLEuC96iK8aZJktNx5GhKVWPeULPdFLHAbjB8k7sqKxR2MuIQH
 uupuFq/CCESE9DQCew23eWurxbA5TfCzodH+2IG3wjqltJgnw5CKn2mMjMBbe+fJjUJimdGytBP
 UjDWIx8pO+Dru00ZlRuk6zCajR+eNx3W5rpZVlLnD2xLJtKXVVd5G5T2o6TSBjOfbEiAs5ELbeM
 1gEgNqjcxsQzGxWBYKLoSGsn6GOzYqQ0l/ieBemzi5Ic=
X-Received: by 2002:a05:6000:2604:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-46071e60f6fmr14436003f8f.27.1781464117759; 
 Sun, 14 Jun 2026 12:08:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2604:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-46071e60f6fmr14435953f8f.27.1781464117223; 
 Sun, 14 Jun 2026 12:08:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f4f6sm29141207f8f.16.2026.06.14.12.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aditya Gupta <adityag@linux.ibm.com>, Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 067/106] ppc/pnv_phb3: Error out on invalid config access
Message-ID: <218109781209f9d77242b2cdf743acac8bc3b893.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

PHB in Power8 supports 8 byte registers, and hence the ops structure
allows accessing of 8 bytes in 'pnv_phb3_reg_ops'

Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.

This when called with size as 8, causes following assert failure in
'pci_host_config_read_common' & 'pci_host_config_write_common':

    assert(len <= 4);

Validate that size is <=4, before jumping to pci_host_config_{read,write}_common

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3334
Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Fixes: 9ae1329ee2fe ("ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260326190438.734239-2-adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index d6ab515337..4ffdb4ce31 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -475,6 +475,11 @@ void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
 
     /* Special case configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return;
+        }
         pnv_phb3_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -597,6 +602,11 @@ uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return ~0ull;
+        }
         return pnv_phb3_config_read(phb, off & 0x3, size);
     }
 
-- 
MST


