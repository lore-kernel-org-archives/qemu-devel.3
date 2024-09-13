Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A50EEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxF4-0003z3-Cv; Thu, 12 Sep 2024 23:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEw-0003nR-PT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEu-00082g-Oj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:44:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-70b2421471aso277145a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199095; x=1726803895;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=sYaPCviWK0RDkJ4Sxckm1QjuQo/FpO/IuDYqEP8DAp8sbzuagZ/nvFsz/Gd0NPFYoh
 1IN9Zw/VoE5PYiGAQJHMCJMVPl3vCLpklnLQ7vASS9hHBssrdLzd2A/1e7veDkY/lr+w
 VOpcNgf/CtL2W0V8E28pDvz7BAWjwBNiI04qQCtWQD7/OaePUfyRtmYjqG4wA1gFo5y4
 ZVYztcS5ivEEVWZE7FVBAPw1kPEnU/CGraLGSVlGRhpsAkV3yVlBHg5j/X4OrN1tVF1l
 tgc9YI8gwiiCMpuTHfyfAjBnYAVrx1D5Pa9qzuVkONJR9vvxx8NZHjeYh0qN3mV2vjqP
 eyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199095; x=1726803895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=KEk5uxUg6nJ0JxClIiVxUANlA9sxb0Dy70+2Qj99wa+qVvwjBqqEN0ZSShoz89OOS0
 2pfjfyMh0PN/Qxcr5dcHhCRzbTkDgWdAzb9YXRfxzEV2SeV+uweyWz/Ht0E+ClgW8T4j
 lUooMwCinNo7WobzvOdwnVjNvfKn6tgIbKRi/qv7ol0Nq+hQCBXhj2asbRGOi8FJ0Zac
 j/D2St+gK5eiA3wmCMOzAERy7q0/xBHJjGKBgOBRKpOk9W/L0q37ae94UCkpM1mhMf0X
 SUTYS5BQ+pnc025VPiKLLvxeA5eGfBwqJzCP4/TzAA9eKeE1V+jGX28YJg9X3gBQM2dj
 RN4g==
X-Gm-Message-State: AOJu0Yy+fhyqa8s1Rdq+Z6A4xLFF3KiHXkmd8bYS7URCOwZJ5/3SOVaL
 CL0TlvV+JyH3ruYloU8WTjAJgHO4Q8RBvEGRx3ZRQYYmYL9YrmLa/Jo8JMuKBto=
X-Google-Smtp-Source: AGHT+IEaQL98eK9SCOZgozOIaJ3StBpCYPYyAwlFSLPV+GJjN0hB34KfQmwc4WE910w/UbXx0FHQkA==
X-Received: by 2002:a05:6a20:bf2f:b0:1cf:3e99:d7a5 with SMTP id
 adf61e73a8af0-1d112e8bf76mr1721950637.31.1726199094868; 
 Thu, 12 Sep 2024 20:44:54 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7db1fddd4cdsm2471464a12.65.2024.09.12.20.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:44:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:31 +0900
Subject: [PATCH v16 03/13] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-3-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


