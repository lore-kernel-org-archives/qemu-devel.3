Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB276CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkh-0007Yh-BY; Fri, 02 Oct 2026 16:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjke-0007TD-B8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:04 -0400
Received: from mail-pj2-x18.google.com ([2607:f8b0:4864:39::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkc-0005pm-AT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:03 -0400
Received: by mail-pj2-x18.google.com with SMTP id
 d9443c01a7336-2d747ed9866so55391115ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972461; x=1791577261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lpj0IMfahKj4TBxv92N1eLG7yRPCpkT9qnzra+mUktE=;
 b=VfjPgtCBNFyfgxAy4eKwET4dKN3Dt09uIfV81rG2r7m8WWrj3NoXktZ7BztUNTD3fK
 iWZc7OaH4LDOVsvjEBOTB5/IUFxjUZtZNL7BP5JUxX6zcA/7H9vhyyx/knhfwR1fYvpt
 JFD1/UrwrPnWnpAwNNNjFO9u2rgIQ4pKgP0YHxpoty61dEnb4N7E/O1obflPa1vWKbx0
 MxHSSaCldtnO/U6ah7S9EMji+qtS+YxstSnt2+Wm+skixnQbigM8amXuAQrGLPWMXcRr
 7sAj5X3BZi+79ZJB46iDrVSsPnTOWV7rli/dAAQoWGIqYrGE7GdoXrzYgUeW3sPrPAxt
 eO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972461; x=1791577261;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lpj0IMfahKj4TBxv92N1eLG7yRPCpkT9qnzra+mUktE=;
 b=OYX5DWhDTsCat2TY4UVcj746VgDvL1JnTIq8t3Y1Itmdrzmm2K/O0TYcLckloYTPU7
 e2blTIgMdZPxi2QU+L3uXgt0fhLYvjJxFUgOZbH04yE0NoFlEO2QC3qN547PEW6wTIOr
 Pp7B2SBt6Hy/tL3iIHbDLQZAGKUKPWUVUjcucLVn3X8W86/rWs5f4joP6A+RTrZKbyua
 6hNqw8xrkD3Utn50D8pJ0VCtKQlberzmzVQbkc224Xs+mGGL0vnuuJK/h/lTXtiF1uav
 tU5cgU7GmlGG8yBm+pVgKcXaYssa9RMZeLZjc7YQ3fkvbHOU8uiHBa2GHa2cQwTFFJ8/
 7INg==
X-Gm-Message-State: AFq9FYIvz2TEP2mrDyII8G+tnXg1y9eKphAL26JAqTgTlEQT5BLEzgfR
 hzU/iLdgooh7YMWwlg7MFVJ4T7Ljs/eS2vSd/RIJpivsqtULCpTineCox7A+XEzaxr0=
X-Gm-Gg: AYBFou2zVgaX3MINZwpRmfL1K686+I+z8ceMgA6A0KbhTYzjwnUJNqFTEQRt30RwWSg
 qp1t2eLc6vEv0XXC7reG704PsfgjCKaMSQQe5R8YCKVr5PWtbRwEsBW1p/ksy9nbjjq6wayRKbL
 +jLnE/qyUJcZgMSDRJ8bwUoEVZh44qXOAVh+SfXnxrqQ570jx8/IiHZJJdaAbtsaprNrV2k4EfT
 lSxpJc9nHRCgn7NQv+h7mlkTHE18vAR3W359u+toR+cVlSMNKOHeY5wR2yZ5h7LNcrZsHOf4WfM
 uA2RzVXA/GwaHr9N5Vp8RjvlUoa0J43hpeW6h1wp1rE0QO6bMfIFNVame+cIJw+/Z9/HeOm8J0C
 DNIo1xbJxqOmr4PL9jOM7IUm3acS8+ofOG2TBLwFSakqB9AEo5q6hHxWPLpzaMkcJOHeLPl2sQI
 DIeUmhJvldrsuKOv8FqMzg1P8QoASKD7VzfAJK3lXj/WEYeCV0JzHABKP0EfoNUIOUiS8d548tF
 L1JD+cXtiXuichWX6i5bt4C
X-Received: by 2002:a17:902:d98c:b0:2e1:2f69:b6d4 with SMTP id
 d9443c01a7336-2e49b4e71c0mr35497965ad.15.1790972460656; 
 Fri, 02 Oct 2026 13:21:00 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:59 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 17/22] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Fri,  2 Oct 2026 14:20:21 -0600
Message-ID: <20261002202026.1204110-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::18;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x18.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 35e76951dafd..886ea7a97ea0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2904,6 +2904,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4429,8 +4431,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0


