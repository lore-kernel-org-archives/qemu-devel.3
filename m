Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D92C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonTB-000405-EZ; Tue, 28 Jul 2026 15:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSR-0003Tk-Pp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSQ-0001c6-7P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so210403a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266837; x=1785871637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k1OKTxouEu3ExdbBGp8MAamXpMFfZiX+8/wuyJN0otc=;
 b=kDUuU7EYJKbvlcrKC1Pitug/tRwnvkvU/+zGRFviXmL6qgqAixaLkZbSLsGOh3vQ8u
 W7AJX2TsrDN/rIVSJaDDvNN7JawIo+2zlElJpAhn4n8m7fRLbR2AySactO9Yg5oCZLT8
 vvvNvphfosvVOo/qtyW7Wx0fSUNf/+fBwW6IOSGvCd0NkrewpbrrSqPB8o4HB+n7lcZK
 Jlg6ZazstsPYd0qXKbo1zhR62Cn6RiR5wEi07DvoIxtbEQquJ+CaPNSZMasdLkKxAxnh
 FjWn48YxRM6iH1c8fvypPUbN0tlxQsNPevV28VPQPKjVh+vlhDIneEWSFL3qx2Wg0au5
 1oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266837; x=1785871637;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k1OKTxouEu3ExdbBGp8MAamXpMFfZiX+8/wuyJN0otc=;
 b=Dby0R0CdtNNLPmVGXXn/Bbe0uoPUeFVjzOAbuYEgSnhMIiXpUCYZVMEB/tYaieMIDO
 BHMyxQ+0Fq7F2l8Dt0+t2UBrPB9sI3gemvNqUlAfyOfd59ErhoEmhRX/cICk0YkSsT3e
 GIglDresNUvGZ1TA6uV2GTHI+AxUIkppMk1wEO6XQDGI1/HJ45CPp4evNoIR1xYDrAhN
 /1EpuSf4n8RO7eB41FwPLVRYt6cT+KmiTxG9/z2mPv/SQVwZO7+m2ryzncMMT5Y7IfOb
 PjVqzefjsX1B6ATdKPv6BYyKexB3j2kUKTAD5Xj21v8SRLJTaeeN3T52lFHdXOpNibHE
 YcMQ==
X-Gm-Message-State: AOJu0Yx30VQaRr8OplcXER0Y7zHa3iHUqK//+oYuTj0pU2T3AIKX+PAQ
 w/C0nOROPLJHmSz3O6h0kuKt1sgnpY/IA5eMeYb0Qod8/wMIKFd7Ql5CCaxi6psJGqM=
X-Gm-Gg: AR+sD10n7ZDDns8seNyzjbHkCfqZw/SeEWHGK0eeXAoyg02rU/2hBJ0anTfvxKSe2VH
 qM3bpazTbjyInCAgm7xSu2bvtnSanMrBcVntvcnM927vgyuJoo5ar3WmHjGaRbjvRTakJ5i7qse
 WGQ031IXgtxQQ5BE0viGCC2hKWOsVAeUgelzVlp4NGHmABCUvq0McWGmaIhmE7viXKZ6z0fztR7
 qleYQ59tW41oxbAh+xNL3iZYE6RCnyAZtGlmIeITn4wnCG+ifRfJfLIrwENIDzq072/Z0oAOes4
 bOCjncjkqpvdtm7qHi/dh+IdWZ3XMtqm9PSbbqa2ae8tAySWizHebhAkk35ZWHJ5C8nqhBTaISY
 D42I84AWnJG5CSzx6t6/IKqk8cpHUWhPUe5Ep/eS/XcQcDlcxGKUReKJRhuUxM3Ccwh913DoXFc
 bUUyO1bqGS3HL+7H/eQf1E2N1/1j5m
X-Received: by 2002:a17:90b:57cd:b0:38f:23d6:b4a9 with SMTP id
 98e67ed59e1d1-38f6a518021mr4060765a91.21.1785266836872; 
 Tue, 28 Jul 2026 12:27:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:16 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 19/24] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Tue, 28 Jul 2026 13:26:25 -0600
Message-ID: <20260728192630.240375-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 65ed8573f8b1..74fe21712d4f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2911,6 +2911,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4433,8 +4435,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0


