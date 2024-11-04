Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B755D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Kp-0003Nq-NC; Mon, 04 Nov 2024 16:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KY-0003Ee-Fu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KW-0005Z1-SA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQTkTMJNMys2h5iun+ZazOJo/CN0SrCjY67C1wqtHGY=;
 b=LXCZDZ/Uj+xqGE/WzEEvxwzZ+xkse0awsbo9bwmGfMdyW9pwaM53FtYMZFTCLt1nwFaaXg
 3b5iWAi4XEcBAgedzDILrBabw4Mx9kKcjXxkKrFpqi1QG9o9d5VV7D+9R4qsZylSgpV7QC
 vYwHIPNME0ZdLSf0w6aS1a39JjHtpw4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-66NB40E9M1imQR2TFofaKA-1; Mon, 04 Nov 2024 16:09:42 -0500
X-MC-Unique: 66NB40E9M1imQR2TFofaKA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so32901025e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754581; x=1731359381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQTkTMJNMys2h5iun+ZazOJo/CN0SrCjY67C1wqtHGY=;
 b=AddX/6IgRpdnbn+TrttCW+Sw7UogLni7+yJFefLHk7UcRzw3obUzDLjXNnKa5HjTkj
 dd+lRWvA7UZ9xehZVYe12ADPHjkNHhBpi8XaxgNIMA5/iCCHCbNuiRFaO0WSnlxZ9GX3
 Xjkp+h9SioCwllVOrkAixcFMO1vnl0kw0ZCyK/ADZPVSnlqdQucgpR0j8PlmF+RXs4xN
 mEbfoc4LFn2PuxvRI6MaVewX9TAd9zAeZSjGGPcHAVKOPCIdQWU9d5YHIORlNu9QZLT+
 OBjXAErbEoDpKwQ1aA86mK4SeMP3UIaErIbT+F7F2VHtaAXi++n9nkGKwZOpg8rNYHJR
 3Ksg==
X-Gm-Message-State: AOJu0Yws0xbpm+3SYYrGtAP6VdygmexGulbQGPIp5+WbOEAaH0SWs3oX
 cSHGY2P06+P4XF6RSMfdKmLyqiTDi+t+uF9KJGS5T0taMvI125qzN4kj0sOnwNiuvuFvQbGgx9p
 f/3VpAvdwhaGCLnuxjsXy/w6FtraL5ZhmID1ski9HqvuVkyhenMFePw7M/rya4y12ncPvWCeKpp
 olFNy90ny7ZBabwoI+2BNsyAAgYS4m3w==
X-Received: by 2002:a05:600c:a08:b0:431:4a83:2d80 with SMTP id
 5b1f17b1804b1-4327b6c1c78mr160758655e9.0.1730754580931; 
 Mon, 04 Nov 2024 13:09:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE04MBj7tzcnxqiDhI0MsRUr328JQxLz6fQVdxnWS9xfKUi9yWsX/mJKLXgdipZzAPkN8y7XQ==
X-Received: by 2002:a05:600c:a08:b0:431:4a83:2d80 with SMTP id
 5b1f17b1804b1-4327b6c1c78mr160758445e9.0.1730754580468; 
 Mon, 04 Nov 2024 13:09:40 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e7d23sm193221125e9.7.2024.11.04.13.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:38 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 62/65] hw/acpi: Update GED with vCPU Hotplug VMSD for migration
Message-ID: <65fb66980d3a918ebe1e665cf6ae4ceb8dea2db1.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

The ACPI CPU hotplug states must be migrated along with other vCPU
hotplug states to the destination VM. Update the GED's VM State
Description (VMSD) table subsection to conditionally include the CPU
Hotplug VM State Description (VMSD).

Excerpt of GED VMSD State Dump at Source:

    "acpi-ged (16)": {
        "ged_state": {
            "sel": "0x00000000"
        },
        [...]
        "acpi-ged/cpuhp": {
            "cpuhp_state": {
                "selector": "0x00000005",
                "command": "0x00",
                "devs": [
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    },
		    [...]
                    {
                        "is_inserting": false,
                        "is_removing": false,
                        "ost_event": "0x00000000",
                        "ost_status": "0x00000000"
                    }
                ]
            }
        }
    },

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Message-Id: <20241103102419.202225-6-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index d00f5a6c1c..663d9cb093 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -331,6 +331,24 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
+static const VMStateDescription vmstate_cpuhp_state = {
+    .name = "acpi-ged/cpuhp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpuhp_needed,
+    .fields      = (VMStateField[]) {
+        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
     .version_id = 1,
@@ -379,6 +397,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
+        &vmstate_cpuhp_state,
         &vmstate_ghes_state,
         NULL
     }
-- 
MST


