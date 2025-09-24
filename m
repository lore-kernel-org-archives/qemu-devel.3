Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C72CAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LpB-0005P6-G7; Wed, 24 Sep 2025 05:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpA-0005Op-0G
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lp4-0004qn-A9
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/XW/L14MoMb/+kv4FvaAffCMOO2k+fD1qoCEwPIK8o=;
 b=XpqBW5+nLwIWEnKctTtxiFhzrPPFjgX9IrslpvuRve2CVqoI2VSzOhoPs3/yMBBMJzZmN7
 DrnWEz0Ixh90NuYkLVGmAEUOxAq359m9eKQiz8rLiejgtuVRSG1mSoSbTuA6ZAnLiEpN7S
 7gzZfJL/20uSDp4xJ4mXzSbyfhDJSt8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-55Ts5bbpOO2AO5uRU4fJAA-1; Wed, 24 Sep 2025 05:29:55 -0400
X-MC-Unique: 55Ts5bbpOO2AO5uRU4fJAA-1
X-Mimecast-MFC-AGG-ID: 55Ts5bbpOO2AO5uRU4fJAA_1758706195
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b04a302fb7cso591013166b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706194; x=1759310994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/XW/L14MoMb/+kv4FvaAffCMOO2k+fD1qoCEwPIK8o=;
 b=X9WeE+asxCacvjRRG6Y+U+DAhHik2kgDa7P7Uh5kPWB2fY5l69naQYNtFF3GsZqO/r
 mYzS9N3E0XZMoWPA7523FH+6OYHIir5wgtqVzJnp/xOxRxsewl7EcLX3Q28VRyM43lR5
 uGAVCbs+XJiycn8jtyMUL2TVf7koRGktZjP+JxUjwyezLQQ7MQTt9fE+dMzraKdX2Nib
 fZMEQt0qLCYh8o8rJ4+c6fOOgccX0MKo/lkcDt459Id+rbZLu64m1O/Pu+/++ush9aFR
 MxKqGOBdpSwPMx4g9mJ9c+W8tRQWN9KKxDQp8Q7ESWzGFjZyQ4vNeKoqvfnnyW2nN8xM
 2vww==
X-Gm-Message-State: AOJu0YxgnpAK7/MshW6KQKQLOTDjFRtvXpF/fTGFYdE15PWr6QcYPRrY
 Qd8DDjez2ZLrz7qx96azAjLCcGFDzvW5FZWMtx7ucVw7gzEAcFAExAYyL8ajMZnjwsKEeIrW40D
 WU7nOeyRmVeE9A3h/25i0ZnAFJZpCDgYDitERroK+WSjS6FSuv6R7h665pq+fm8FBdYTkbf+9zd
 Qz6+PoPVBPwjg2ZNa59inc1oFbiaQQGSEoKljDqfgO
X-Gm-Gg: ASbGncs3kGnSubtOzAzuHCG+aWRbtzxTrESqqtjVj7d7gNY+WmC9MqP3Ccz0mkhSigm
 D5RQEea/FvhpQzPwoLOMs0XMzbcTSm8dkbROEkuaeA47eONLwO7XvcaiJvfHH0QFa3OEyjmTGOV
 n2yhwi0QqkmWDWfvHBIGxws0L1yv9pZ/lFXdLm1abChC1vUixu/fRTVT2gJsI7m1tocjK79OAsU
 lxciTJ0HED0dvgootYQzpcZXoXyDJuW7Kn88foMDXdJ62Xi75yOOjab3wdDDm7jhXKTa/Cl4dxj
 5SjH2sEOp9zm28184Ezgc4os25HI/53cbY1mTjaglQrc/VohmYr5yvoBHPNhPS/8ISSIZz5FxPO
 LpgSxRjXWlWVrYUpOdAzHPZH4lJ31NWQwN5KlY89mLmG/tA==
X-Received: by 2002:a17:907:2684:b0:b2d:e514:5348 with SMTP id
 a640c23a62f3a-b302af25c48mr612513266b.33.1758706193756; 
 Wed, 24 Sep 2025 02:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsr/n0FH4WBt5zip9OnDytlsECvMZdytAy4u8yZUMAQ75jFafqmkuG1D1zLAJUSmTSuMAztw==
X-Received: by 2002:a17:907:2684:b0:b2d:e514:5348 with SMTP id
 a640c23a62f3a-b302af25c48mr612510666b.33.1758706193208; 
 Wed, 24 Sep 2025 02:29:53 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2a660738dcsm842067166b.84.2025.09.24.02.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 21/29] vfio/pci: Do not unparent in instance_finalize()
Date: Wed, 24 Sep 2025 11:28:41 +0200
Message-ID: <20250924092850.42047-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the insntance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250924-use-v4-2-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d14e96b2f82..bc0b4c4d562 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2025,7 +2025,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
         vfio_region_finalize(&bar->region);
         if (bar->mr) {
             assert(bar->size);
-            object_unparent(OBJECT(bar->mr));
             g_free(bar->mr);
             bar->mr = NULL;
         }
@@ -2033,9 +2032,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
 
     if (vdev->vga) {
         vfio_vga_quirk_finalize(vdev);
-        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
-            object_unparent(OBJECT(&vdev->vga->region[i].mem));
-        }
         g_free(vdev->vga);
     }
 }
-- 
2.51.0


