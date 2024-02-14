Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A0DC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDE6-00033V-6T; Wed, 14 Feb 2024 06:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE4-0002yC-JA
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDE3-0006vH-6g
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQPq2eB8YlzFRo2yi/9ewINIVLnGxrTHAgWJxfM/5SU=;
 b=BL0sjsmOxNUbLtuNqJZuXFZtaa+qIQmIEEZjENug5V0XRLy0HdEoh4MQJ/gR1zElgGcItD
 4BsZSJKZwblCLeDCkny1MJTwh6JgPGJVCEcZADNdIqZtgOcHQDnFPz+mSefwAZCE9Gn3B/
 YXHdN2Mz+RcIkFVkX0MqpRPX8szS0/I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-youdLG_DOUOfkxdvJJ-OpA-1; Wed, 14 Feb 2024 06:14:48 -0500
X-MC-Unique: youdLG_DOUOfkxdvJJ-OpA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3cdd79d960so114091566b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909286; x=1708514086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQPq2eB8YlzFRo2yi/9ewINIVLnGxrTHAgWJxfM/5SU=;
 b=kjvkN0/vncArA7FBmILzGyKW8Gg3kFNcQkytIZNBuZLB2nhyPDRiDBb/TAqXItG/OD
 Kb3hF+NtjUpLhNtRSqvgalADrk7/qmTbfI4KY+xXQjvTYTmeQjl82CZXtpbjY4/Av3ag
 EleqwsyYfePvCeSNTtfv20j/248KviyzM3nH2PppshsyThzWOU6hCfeHtw7JS+bJiVuY
 u2FdGfWz1bHQNejbp4ZeRKTqSNNbDl5q9pKQ5jqxeGLln9EFYO8Ip9Eaic9ct59FTtxa
 Keew0krryBFLtwbLR1MFKNeFn+VY+FphuHUAQSLguhdpNV5F7H0qfL+Xx9NrDXW/zOHQ
 x/8Q==
X-Gm-Message-State: AOJu0Yz2lWNjdhiZPyAGGgk7Me3KfiHANmKDhCQSRADVPdY8VYxuX0ru
 KqGk0bITwDNAl/mlKRIa8quwJUpskul94AZ8xx+uhvC2bzZqEXvbCvcLaSKoHx/si/uBonq1onO
 JfkIoaPMH8XaAsjn+923vBOh0sw6hvV1/UZo3rybXkweQSTmrJNp4qpM5CpnGrpBXUsQYjpGV8+
 JqrPDw7tilrXN7VgkgyBLq0HASErhr8g==
X-Received: by 2002:a17:906:6043:b0:a3c:edc4:4abd with SMTP id
 p3-20020a170906604300b00a3cedc44abdmr1622496ejj.33.1707909286359; 
 Wed, 14 Feb 2024 03:14:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlE5zsOtDbDpmO+I+yuR2yY/6loGor3xrXhWAZTODGea6RjOPtaXWwiR2yMkgWSveo7a0EUA==
X-Received: by 2002:a17:906:6043:b0:a3c:edc4:4abd with SMTP id
 p3-20020a170906604300b00a3cedc44abdmr1622482ejj.33.1707909286104; 
 Wed, 14 Feb 2024 03:14:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUu1DkKbb3j81+ckBkqyZZl1dUz1gIXrWEqHXS4B16cQpF7w9daVhYssxqEnIai19UNv5kLZU8VMxEJqYiHWJzKmRYfANL3OwSmR5Xi0fZNqnK+KZKd1H7rBBQhb3Q2mwBBBESfoPn7biyCaq0QmDuKp34fX1sxeSmCDQJmZAzq5qeC9j3yibcrT51OEp1SHw==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 m10-20020a1709060d8a00b00a3cd0c09a05sm2194400eji.180.2024.02.14.03.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:45 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 28/60] hw/block/fdc-isa: Implement relocation and
 enabling/disabling for TYPE_ISA_FDC
Message-ID: <8c4d239139e93268884f9d385a0966ef40db422f.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

The real SuperI/O chips emulated by QEMU allow for relocating and enabling or
disabling their SuperI/O functions via software. So far this is not implemented.
Prepare for that by adding isa_fdc_set_{enabled,iobase}.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240114123911.4877-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/block/fdc.h |  3 +++
 hw/block/fdc-isa.c     | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 35248c0837..c367c5efea 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -14,6 +14,9 @@ void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds);
 void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
 
+void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase);
+void isa_fdc_set_enabled(ISADevice *fdc, bool enabled);
+
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 2d8a98ce7d..e43dc532af 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -192,6 +192,20 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
     return dev;
 }
 
+void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase)
+{
+    FDCtrlISABus *isa = ISA_FDC(fdc);
+
+    fdc->ioport_id = iobase;
+    isa->iobase = iobase;
+    portio_list_set_address(&isa->portio_list, isa->iobase);
+}
+
+void isa_fdc_set_enabled(ISADevice *fdc, bool enabled)
+{
+    portio_list_set_enabled(&ISA_FDC(fdc)->portio_list, enabled);
+}
+
 int cmos_get_fd_drive_type(FloppyDriveType fd0)
 {
     int val;
-- 
MST


