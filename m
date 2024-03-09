Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E606DC54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 21:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj4Wy-0005Ja-B5; Sat, 09 Mar 2024 16:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joonas.a.kankaala@gmail.com>)
 id 1rj0XW-0003LU-H3; Sat, 09 Mar 2024 12:31:19 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joonas.a.kankaala@gmail.com>)
 id 1rj0XU-00026F-T5; Sat, 09 Mar 2024 12:31:18 -0500
Received: by mail-lf1-x142.google.com with SMTP id
 2adb3069b0e04-5131c0691feso4169689e87.1; 
 Sat, 09 Mar 2024 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710005474; x=1710610274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5SY5eQbGOyL3k0Jv7RfKwObXNkxN20JhiRjwB5XoDUY=;
 b=LFXcb7qys4c3Xb8yCdTuZOpOSc/da8BOnwjQh9+20lCxZZjfhX1qJ/MWjveDj7Ti3m
 iRca7/T1U3OzWHls8R5jOv1j9eFo/04tKl9/OjGhSjH8yKo+300DMIi0gLEF8SoE95MC
 mNCV6fs8o4qlWjDzVt1yMbAy/5yhikZ7V1nG2zhy9co/Dr7f//s6Q9gF/gsoiRAqZmZQ
 XktH0fVwIyfFRT2hEexNyFpn3lNUVydNRna8hlyh/zPsBCZzS6nOhk1agWzM24+Mbjs2
 A56KNhbLmHJMR+IJ0Ckrgq6hAf0r4LcmeVrG/SRZvk39f7nrXdVjmelCxyYcG1vZtkqo
 mzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710005474; x=1710610274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5SY5eQbGOyL3k0Jv7RfKwObXNkxN20JhiRjwB5XoDUY=;
 b=o//kd+M0sp8fZv+i7tijxQ9NL1yYxvWpyixinc6GK9IekDij9HIXWzRNVBsNtJoryH
 YanHZhDUXC2roAEXFIPsr1B51S6DfBbnSDeRaztdusvHKJvC7LdvyrGmitxgOJSMrnbt
 v8UaCSR/wdZNgbkD8d/4Gp6V5/HdcX6BHDWyyxKwMYWvnvbRhUuD446QQq9o9Hi2ZQCE
 21xYr7tTQfii6eaT2SbT+SxdKRtvbjwt6ilKc+Tyry3xo2IcZi9rcQ4J9+ToiMg6Bp+h
 xXVwImlcsQmw5HFv2UDXl71PjLVqbXHbuBsTWztb6Pj+LBW2q87Cw7wsyTyK86SJMzTu
 fRIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1WSvjId9ctq1iWtGhD6PEklYGtzXrdQt0Kx9p6vK8WQwGXy3Fr8W4iaEfG7ew3U4CTL11K0DJ0P7nYt5/B7Y8Sv0ZnnnNcA==
X-Gm-Message-State: AOJu0YzKqTKqVIxZeosDw8sDHisAXJYfhUvTZ9Y3+wllqpwizgCj+SN7
 Y8zeDdkG4yM9N2fEOKF3ZAo3NiA3DJkPFWAbbT3qc9xj3r1AVl82++VtB/EEkR9P8g==
X-Google-Smtp-Source: AGHT+IEE3FR9BT4HcXtvzl3O4bqSdtYpzUGOOPJV8OP94vLgm17DkiNvuhTl8+xiA23/BW+TN2VV+Q==
X-Received: by 2002:ac2:4305:0:b0:512:be8e:79da with SMTP id
 l5-20020ac24305000000b00512be8e79damr1307932lfh.8.1710005474004; 
 Sat, 09 Mar 2024 09:31:14 -0800 (PST)
Received: from bequiet.zyxel.com (87-92-213-99.rev.dnainternet.fi.
 [87.92.213.99]) by smtp.gmail.com with ESMTPSA id
 c19-20020a056512325300b0051360320c79sm375298lfr.86.2024.03.09.09.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 09:31:13 -0800 (PST)
From: Joonas Kankaala <joonas.a.kankaala@gmail.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org,
 Joonas Kankaala <joonas.a.kankaala@gmail.com>
Subject: [PATCH] usb-audio: Fix invalid values in AudioControl descriptors
Date: Sat,  9 Mar 2024 19:29:32 +0200
Message-Id: <20240309172932.288940-1-joonas.a.kankaala@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=joonas.a.kankaala@gmail.com; helo=mail-lf1-x142.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 09 Mar 2024 16:46:59 -0500
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

This fixes the invalid bInterfaceProtocol value 0x04 in the USB audio
AudioControl descriptors. It should be zero. While Linux and Windows
forgive this error, macOS 14 Sonoma does not. The usb-audio device does
not appear in macOS sound settings even though the device is recognized
and shows up in USB system information. According to the USB audio class
specs 1.0-4.0, valid values are 0x00, 0x20, 0x30 and 0x40. (Note also
that Linux prints the warning "unknown interface protocol 0x4, assuming
v1", but then proceeds as if the value was zero.)

This also fixes the invalid wTotalLength value in the multi-channel
setup AudioControl interface header descriptor (used when multi=on
and out.mixing-engine off). The combined length of all the descriptors
there add up to 0x37, not 0x38. In Linux, "lsusb -D ..." displays
incomplete descriptor information when this length is incorrect.

Signed-off-by: Joonas Kankaala <joonas.a.kankaala@gmail.com>
---
 hw/usb/dev-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index d5ac1f8962..1897fff9e6 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -124,7 +124,6 @@ static const USBDescIface desc_iface[] = {
         .bNumEndpoints                 = 0,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
-        .bInterfaceProtocol            = 0x04,
         .iInterface                    = STRING_USBAUDIO_CONTROL,
         .ndesc                         = 4,
         .descs = (USBDescOther[]) {
@@ -282,7 +281,6 @@ static const USBDescIface desc_iface_multi[] = {
         .bNumEndpoints                 = 0,
         .bInterfaceClass               = USB_CLASS_AUDIO,
         .bInterfaceSubClass            = USB_SUBCLASS_AUDIO_CONTROL,
-        .bInterfaceProtocol            = 0x04,
         .iInterface                    = STRING_USBAUDIO_CONTROL,
         .ndesc                         = 4,
         .descs = (USBDescOther[]) {
@@ -293,7 +291,7 @@ static const USBDescIface desc_iface_multi[] = {
                     USB_DT_CS_INTERFACE,        /*  u8  bDescriptorType */
                     DST_AC_HEADER,              /*  u8  bDescriptorSubtype */
                     U16(0x0100),                /* u16  bcdADC */
-                    U16(0x38),                  /* u16  wTotalLength */
+                    U16(0x37),                  /* u16  wTotalLength */
                     0x01,                       /*  u8  bInCollection */
                     0x01,                       /*  u8  baInterfaceNr */
                 }
-- 
2.39.2


