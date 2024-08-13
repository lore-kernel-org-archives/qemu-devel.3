Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF19C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkoS-0006FU-59; Tue, 13 Aug 2024 02:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoJ-000603-8o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoF-0003U6-CR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so4726639b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529704; x=1724134504;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=ttHNRHLZOn0ObwdS/CeoMHqzfcMX8tzDw9Zzaj4CO3esSgOWtLRKddn2z0+7b4sjJ2
 BCnOrZlXO6E/kVmGmKvJzuK9xJsegUniA5JrUS2wl8MdM6rA8VSuFDlZKbJrfODi1Pwc
 EqqDzHvpPbOtRAccVDP95YnXEANzW88F8d16akVu/w9T+UFvW0HLOjhSyzen4QPtahO7
 KyUjWBfJ/KpgEKvNZyrfpjV98pexYbjPnLZJyGguzdAfW+bWT6+RQlRhrH95cxRqz9tm
 EHboyx8cxFTJTARekSoNLbceX4PS7ZQaquE6zFWwwFaIktLbutatd8fZrkJS8K/a0Ws4
 Gxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529704; x=1724134504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=uVpqf9QWnW1nVPVnQgPujAVCSilU0SAUsBMz2qnxRMs7Osmr3gjhwzsnAojthZkOsr
 4S+DbNofFkylEBnO1kQXenbyAGZyyCmc/wj865i9DQYJPWWTXmsdEk4rI31hTzNHb0co
 wx0Hc9lLAwSf4aVfstcPWv8P2Y4CAtEIxNUqGdERUZS08/YjYUTpH3RtbN0xodlS6lpA
 SSmd0qk0yNF26WWC5HtbPy5lgfBkGlop2+GeA9AENxLOsCFVkUU+lEnPeZWhK2ZSHjK/
 n8/A9xtGFvOyAVIPO1FuFzFsLcMRHftWfIHEeL7hhDzzwxV74KrAngdXLw/4qPES31TS
 2a/w==
X-Gm-Message-State: AOJu0YzrqUxeomm+4LS9F8GrUa3XKD/Yal/ByufqDZIa9se2wCyD6uym
 o95vfNvJ5Z00QwsgD3VM6F8XNe1jo9IP8j0aBiLDpJGKLfPHiJhN+jtXWBeDmN2G3GT+7ilrjf4
 lcSk=
X-Google-Smtp-Source: AGHT+IHyG35zjlW0rjlLac7KZOGQNnvrgF/m2A/gapkBI2LgTPhlG5QgAAqfG2IrOa19zwDnQTBDjg==
X-Received: by 2002:a05:6a00:a8d:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-7125512f30cmr3443206b3a.7.1723529704149; 
 Mon, 12 Aug 2024 23:15:04 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7c697a728e4sm563722a12.90.2024.08.12.23.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:15:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:46 +0900
Subject: [PATCH for-9.2 v14 03/11] hw/ppc/spapr_pci: Do not reject VFs
 created after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-3-4c15bc6ee0e6@daynix.com>
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
In-Reply-To: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c41..ed4454bbf79e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.46.0


