Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6000C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJIp-0003Fj-Q4; Tue, 21 Jan 2025 13:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI5-00035v-Gi
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:01 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taJI2-00055i-SN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:47:56 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dbe8e62407so1356005a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737485272; x=1738090072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Nesju9X6p+NFxhLVMdf2JYbIJ9FHseiolXicW/bOKs=;
 b=nDxB2DRUvmpGIjppGK+7lpWnQpemwNsUAnZTx83GrGmptpqf6FG2aCEQjCTB4+tX/B
 AwC6O7ty1FliaCSXTyyya+Duco7s/iRf1UU/CpD8Aj2c1WS6GKCFlj91xWAJ4YaabqXz
 uwnxpePD4xG9u42iLidvH/8oz850a0qWlPNcjVsZg4IoiszeD70CktynP5dKPm1lTU60
 DcP/Xr2frVVoO66PZ/ml8rTF0o9MqPDMt3F1q7BXRG9FsLIxSUPWEOs4xLjdB//lDA09
 ZmGYro5G9CYFLvopy7qATBsrz81OXXElN2keZknXtTx41uW1dHwzPMcVpNd62v7d/Lhi
 SD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485272; x=1738090072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Nesju9X6p+NFxhLVMdf2JYbIJ9FHseiolXicW/bOKs=;
 b=KZKTitcQuZYZGZ0J9T+E6aK2lHXoGqYzNb11lEXhNfMcc75zxKfGTFMZyNbhwB6oAP
 xNKkT11q1ZouiOX/WPfy7/2h3MChsOPtYs/YEOexnCUjRnu4iCmQVrSA2MvnDzf4V4uL
 ub3rzs8zZNoZetF4LY9YZnNgopS2RiAxJTqdVfmyM2kvpOuUsQTUmqw207tHlfBm8NJ0
 rluFK7W7uTQ61SlkV0F/mRFHRoi9sa8G2BpSB2tIgRjxdpHejRm85yBRXxEACp88fbs7
 GSLHyaEZKEEwylCnYhT+vUHJynrErgwleRjMZGCttiaflbuXT0MrA2wC2juPRmG1EDFh
 MNAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZnFkstnQ1G+sqY6MdLOysBpcEaKzpqiAuYzpch1X+Szra3dizsw3b5JGdER17oPVmtFsSs30oYDhO@nongnu.org
X-Gm-Message-State: AOJu0Yw8UPoHYOYij2SVA0m5cAoX54A/D7pXzGm2pe8/ssCKYmhRpmAF
 ZZs45QQtUHp+2GbudxnIHExE38iAXlJiFEs/aJJKJkt5H7nOVZsg
X-Gm-Gg: ASbGncstR4UA70HuougYIC4d2nbI87zQIU1Zn29aORfdrOsHVPja8KsdKJRLsJQSzLm
 BPmMUXBGj6/tcL5WW98H1LamJYw1ZJkNjYQW+Gu1zwtByPxdy8YsOnSYcX37JuQrjWvKf8I1OSz
 LsT7hgfHhzwEZk73ClxQLsMX5JXk4h05HvCd2VLf1tNRx9GowRYrVto1o2SGPNRJbpZ/CBeaLkJ
 jgXUBezIOcBZ9qJ90J4oDHW506VxTsw9em4YtbnNiWH/k9wDWAQi5GebOVoBCbmyz6q/FKRx3w=
X-Google-Smtp-Source: AGHT+IGKVaPz7AsY1tZKN7me2w9WwxNA5PON4CzqDBAsyehMIIoZu7UwtxmmaEg+61Pr0+zRmLZCog==
X-Received: by 2002:a17:907:7205:b0:ab3:88a0:b71d with SMTP id
 a640c23a62f3a-ab38b2e734fmr2030102366b.34.1737485271593; 
 Tue, 21 Jan 2025 10:47:51 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:381c:a1:b53:524d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223e7sm785745166b.111.2025.01.21.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:47:50 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v8 4/4] qemu-options.hx: describe hub chardev and aggregation
 of several backends
Date: Tue, 21 Jan 2025 19:47:44 +0100
Message-ID: <20250121184746.920841-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121184746.920841-1-r.peniaev@gmail.com>
References: <20250121184746.920841-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds a few lines describing `hub` aggregator configuration
for aggregation of several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f10..8e28bd41a9c3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3720,7 +3720,7 @@ SRST
 The general form of a character device option is:
 
 ``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3777,9 +3777,10 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to aggregate data in the opposite direction (where one
+    QEMU frontend interface receives input and output from multiple
+    backend chardev devices), please refer to the paragraph below
+    regarding chardev ``hub`` aggregator device configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3879,6 +3880,46 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev hub,id=id,chardevs.0=id[,chardevs.N=id]``
+    Explicitly create chardev backend hub device with the possibility
+    to aggregate input from multiple backend devices and forward it to
+    a single frontend device. Additionally, ``hub`` device takes the
+    output from the frontend device and sends it back to all the
+    connected backend devices. This allows for seamless interaction
+    between different backend devices and a single frontend
+    interface. Aggregation supported for up to 4 chardev
+    devices. (Since 10.0)
+
+    For example, the following is a use case of 2 backend devices:
+    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
+    a single virtio hvc console frontend device with a hub ``hub0``
+    help. Virtual console renders text to an image, which can be
+    shared over the VNC protocol. In turn, pty backend provides
+    bidirectional communication to the virtio hvc console over the
+    pseudo TTY file. The example configuration can be as follows:
+
+    ::
+
+       -chardev pty,path=/tmp/pty,id=pty0 \
+       -chardev vc,id=vc0 \
+       -chardev hub,id=hub0,chardevs.0=pty0,chardevs.1=vc0 \
+       -device virtconsole,chardev=hub0 \
+       -vnc 0.0.0.0:0
+
+    Once QEMU starts VNC client and any TTY emulator can be used to
+    control a single hvc console:
+
+    ::
+
+       # Start TTY emulator
+       tio /tmp/pty
+
+       # Start VNC client and switch to virtual console Ctrl-Alt-2
+       vncviewer :0
+
+    Several frontend devices is not supported. Stacking of multiplexers
+    and hub devices is not supported as well.
+
 ``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
     Connect to a QEMU text console. ``vc`` may optionally be given a
     specific size.
-- 
2.43.0


