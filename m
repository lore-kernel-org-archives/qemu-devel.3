Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0D606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ChIxXjPR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuE-0005TQ-Co; Mon, 09 Nov 2026 17:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtv-0005GT-HA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:47 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtt-0003vW-F7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:42 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so639148b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263500; x=1794868300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i9nhvaLoCHlCTOlMzemv0u9BHztHblZnwWmHlsR6Hmc=;
 b=ChIxXjPRfKBcn69HvVdL150NKm3BUU4pQWnACbKEHnpqaaLvo97wzsFEo6XmayKIv/
 0FcHLIbC++Ndjvp91lMCpXnnkuCapj7gDfBiQSYuZhlEzeQRCuLYsOuRokv63Ui47p16
 XXZAIRHNjsVnCDPBlx5rnz3BnvkxuF2PCtMySzRDa/F39vpHsLAJz/07u3dJop2oYqCR
 nRgLiZZQ41djwrDp0EPK1nFIpSDW1dlcjcFKvzryIEZU35jDHnD4sAuobzOvk6dDWmtX
 tfDq7Hatk4m60O1awexa2gHg9iuPz6PCTL2/k91r+zrisH9fal7XJZKPi38+7dTPxD6Q
 ++5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263500; x=1794868300;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i9nhvaLoCHlCTOlMzemv0u9BHztHblZnwWmHlsR6Hmc=;
 b=k4miQeTTRDO7D75nohUq3DmtUhXVaIqMd7/6sxDjMEPMm9G9DT5DTaZDaTJXSHhUZG
 VMj0DSfc8HxsN65JO7NtcENygxIDicPoZPijJ1yE7fWexTljUOk4L8+ojJ3k6wTlOexx
 77p9zTnfdJP03qDdzCxSXQ56AqNgnlcs4i3N8KFm+6MmB7q7j/mSCQF7qcgFVvS1UF6v
 LZIZ1le3Nz1wXNPt/gDWHC+aOleIRqtUM+bq2EyasG0Y+QyH6xKRDLb6PQnQF6F+18Pp
 40r5RmrM94vQZ4PEi8yhLgqtB94xjSteoEdhnM/1fHZywRVlvEIwppAz52sYFtOvQbGz
 8a4g==
X-Gm-Message-State: APuU4Z9K6aS28YBiL0e+n8nC7q0n876ov/Wk3qLVMI6PaZfvt8nAI1CF
 H2MAPyUbRTjLcL9T18IW+JFZqYFZAhR2rLNLPciKIAXDwWLKtBiM48fTl6pdsMwvEMY=
X-Gm-Gg: AYBFou0g/kv3392xc+tTt9tsOgawVLzUAREyk9oidLmp2WGfYAmWaCRBTIefeuP9arn
 Cv40NYEGg0FfXUIceHLqPMHnRw0K+6mi/zXouw/gTp8/Euhr6p6w9glmOW0S1Wg7WI/CETwvqFD
 dKyLUoOPcb5Ck8zKqWBODIURn97S7CopIv6HTHHyWFYTPQ0Y7x+GOMgT6zzui2vHf/KIJcYberk
 KKxjiW+QYIKHOxNaZURYXe9u3bSKW+3tgmGQwJwGzJY+TTbCPnuXx0J9+BpDUNrLxx4h3r+IKT6
 1sSRWM7buBL5Vqex6DWuBJtZiLBHITAJBqAVDMgh8CzjrvAk2Cc6e+72ZhL4XSMYqe823vIP4sl
 EkL3ADctTnpc8SMNSw/+aqHjfVJSrYdoKoymGDrK40RFNoM5gtdfYz7wCIpuMUMtkEWnN1zNMQe
 vfSI4LxBabLiHWVHEvYwboYG3LgOHxjZ1S8KrlymncDGg1PFni0Srj0C0gzobH2ELqolbsJ4m9Y
 ILhq5ZC8gx4J9WiPYzE0T+ufbcte8Op8IX3zzlUVNE0Rgj9TjExtzGUhqM93caWUPdmOxY+vwL/
 GFLteGl8dnv2AAXsHdZOHFMMwXBivBKzeDp+dmj52jpg8qvJt2OG0YM=
X-Received: by 2002:a05:6a21:a43:b0:3e1:c58d:aaf5 with SMTP id
 adf61e73a8af0-3f190f972e2mr456442637.88.1794263499500; 
 Mon, 09 Nov 2026 14:31:39 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:39 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 14/23] hw/arm/virt: Set proper conduit method for Realms
Date: Mon,  9 Nov 2026 16:31:01 -0600
Message-ID: <20261109223110.1619504-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328cd..0ed6df4b9b9e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -273,6 +273,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2963,10 +2968,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
-- 
2.53.0


