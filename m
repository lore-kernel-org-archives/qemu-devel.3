Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10335C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW9-0001Vn-KE; Tue, 07 Jul 2026 18:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW8-0001Up-CL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW6-0004ET-RL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso942375ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464229; x=1784069029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O86QJm1XxClMyzD31RebPc3Pom31UHvgzzbgIM9gz34=;
 b=NtsQxGbU8QBnvDHome9b5+6rO+5HcNMRxjVbin6dcSl+DLevyJntxQ1xM5xj+drZ6A
 nJ2Et3C3pJ1Cdb+YWW2icSPp8iGypnk3tvqCoQmhglQioGCUKd8oo5fYCQh9Yu4CQUCo
 UNGE/mJTIywAwx8qNxRr9KUPaA+dNQzuJCJl0j0sRW3xy9xhwfZ0VUAP8dn0xcN3sAbh
 i6iQwB+yEYWbPEaV3W99stug7X1qtxFFjoEbTT+JDM71XJnUrYVwIcSc7dWSQebJjylF
 MvPtV3woL6Z9YegJl94pV10+dJTKTf9vrMz4wvMHmZ9ZZXFu25zD/2WsNckytd753uBM
 p9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464229; x=1784069029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O86QJm1XxClMyzD31RebPc3Pom31UHvgzzbgIM9gz34=;
 b=iNs8WFLQ9W0CBTeCMA2UsGildKgZ8O2QYRvqyNAAHuhK/nmgcSDwwJCMDuaaWK3e3Q
 HuiutwzYld7HgLaANX7PzXSXFCw22VDxd9gXVIrVVEWXy2M8gil7xHfFoX+HAgAGE4so
 VOwomfQ6gpv+2XlHRj2Hf+DWc4zIupKRl1Cn1TrRxVfRZzj5Gz1j7Ky8Q4WXQx/WKXAd
 VG5pRN90nOvN/qG80A57iJeLnaxg+ePDYu4vLjeACYsCZwyafhCwNQYXXgT6AyzVRELv
 lE0kwsK8kVFZQfzRCg92gC0gX+ifzBYyxuz3CnIF8eXZ3arX6uDJ5wc2o6LkIAz0iLhw
 WllA==
X-Gm-Message-State: AOJu0YwAhZ6oOWMnd9Fo8GccB5O+m6a7g8sKGjltEPy+/83gMyJ0p2cS
 rxkQgdYbx5vHUX7HDwmF30QEu0T8CvclkjoGyZa9okwgJxfryEMvyE3B/LYZGRMxtoc=
X-Gm-Gg: AfdE7clat6oPvzTvvqGBuIXuKnhYYjEUpRo1gsDv9dJBAKegYZ4qEnNQIQ3+yoxFL+U
 v+atBCKZa2r1NS6BSGqjXEm0UG24UJ2IwNVMuAyPLcrPfkiRDGgJEWbRQxWjZgYBhBZcoi6RT0j
 cNmECzX+uzQx7IMwM9I7LWJuXcndzGq4JyHn4lylYGRP1WAyfZAwAEP9KeD9hCectT8Oa/IAFNq
 lKlY6jMgOiX1NRzWmyPWnLP0tYImah0q5fBpqeqjnQoR0DMQ5pnW9DAMDu1/N9hk8jdEyMVT55F
 KDA2bbkv3nGZJ4jcolCifEZuGMhVFLTg6WUDlBcvS7u2F6h1kTtkFjwiSbbQiG6waGTuj6uIQiv
 ZsrhCRpBDctMRWaX+XvKlDcK5+U0ltOOnDLv85bkIahvs0GZesymfnNRx8zbCh9SxM9o+vo52Dw
 Mtpj0sF1DrIFylzm9uhZSkrKzHT2d/02M1Op9bshU=
X-Received: by 2002:a17:902:f789:b0:2ca:281:27f9 with SMTP id
 d9443c01a7336-2ccbed22936mr61406255ad.27.1783464229346; 
 Tue, 07 Jul 2026 15:43:49 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:48 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 20/25] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Tue,  7 Jul 2026 16:43:01 -0600
Message-ID: <20260707224306.1202330-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62c.google.com
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0f104447e008..2e8e29244284 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2909,6 +2909,8 @@ static void machvirt_init(MachineState *machine)
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


