Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5961FC6175
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spClu-0007MS-9G; Fri, 13 Sep 2024 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9Ip-0005ep-H0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9In-0000g5-E6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso307743966b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726245463; x=1726850263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TF1Q0HeDACQCXoujOUikZqdcfOb5UVVw4pb9ALTshEk=;
 b=hxoHjQABCDh9blIg0BYOeeJzQVbsaVMhG4mG3J2GVPRkcPMR51LsU/4trDRVehzhji
 eHWRHWbS2Ut5CWm1BA28XUBbqNnl0CC7tGLBRyPsUrDzw8Vt+vCmx621mrYno3CWeSOf
 ZorrZMtF1T7IDgVM5lJF1+L+5PQ3KU+MbuoK2yguQgO4aRVa1RrJFUT/LxVrihtwuu5H
 K4lisa2/KmaBbHzOUkYuvz4614HkxIfvbf7qjUmmEI0WO9T9E+LXce7C/crwaIa3B8vx
 NNKITl3FQ2PXIGxWFgXCsIeosrFR88dJvPlwYUFb85U1sd32eJD4AHEuUYad/eoYsrHp
 kErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726245463; x=1726850263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TF1Q0HeDACQCXoujOUikZqdcfOb5UVVw4pb9ALTshEk=;
 b=rRZZ7R+TpSgHlfHTzVFhVsgbLC0lxMja1S6yj3LsNvv9qm9NjWcakboYm9/Cdh8lFS
 VPl/qq5C1qhpnR9eIr8U/IiVpr7S2WuyQKVxo5He2MvOBd5MQ74TFCcwtoTWDclh5e5s
 s3JywdCDAPzYwyamiHOuZR0YVvro/hXds4rtZ4qM2QfLSjb9dNBE8P2V82BKyzGAFEPv
 /iAvdmbsWw4D07bVlnKxXXXcm6BY7pF98zD7y1lGJVng50Dk93GYDJrT3Ye+I526eorS
 dyvAgda51iTV545ZNOKtMiK4jZnDsm7GsrJC4/Dlj3T7Tpd8nuLsRPoSRTC133+G3B2s
 dNDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMzhN5f/W2LqqsovC/ab9d8QlDkny+lDWdp3JmYIcPNl6LZbABngmZ49F2W6ahd0pHrvELaIPXCuhC@nongnu.org
X-Gm-Message-State: AOJu0Yxfl23zUX4+JfVtOY7oEwSu10aevpHO0w8joKJLTF0DmMsu6SuB
 GYBVNNf5okHQtU6/B7XqaVKr8qQ0uOL2vVYXfJvp7uRp/w4v/ADo
X-Google-Smtp-Source: AGHT+IGjWnkhvS0Y/+G726mIh+iKEiXNX+reD4dfl+LUZPlZnlUFUPtPH1aB5GSqJw3cQleoGLokgw==
X-Received: by 2002:a17:906:7949:b0:a8d:4db8:9edf with SMTP id
 a640c23a62f3a-a902961795cmr582598366b.42.1726245461992; 
 Fri, 13 Sep 2024 09:37:41 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:24fe:3d15:e808:f6ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm878983366b.138.2024.09.13.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:37:41 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/2] chardev: implement backend chardev multiplexing
Date: Fri, 13 Sep 2024 18:36:34 +0200
Message-Id: <20240913163636.253949-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Sep 2024 16:19:54 -0400
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

Mux is a character backend (host side) device, which multiplexes
multiple frontends with one backend device. The following is a
few lines from the QEMU manpage [1]:

  A multiplexer is a "1:N" device, and here the "1" end is your
  specified chardev backend, and the "N" end is the various parts
  of QEMU that can talk to a chardev.

But sadly multiple backends are not supported.

This work implements multiplexing capability of several backend
devices, which opens up an opportunity to use a single frontend
device on the guest, which can be manipulated from several
backend devices.

The main motivation of this work is to use a virtio console
frontend device on the guest, which can be manipulated from
several backend devices. The following is QEMU command line
example:

  -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0 \
  -chardev vc,id=vc0 \
  -chardev mux,id=mux0,chardev=vc0,,sock0 \
  -device virtconsole,chardev=mux0 \
  -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`)
and a socket (`sock0`) connected to the single virtio hvc
console with the multiplexer (`mux0`) help. `vc0` renders
text to an image, which can be shared over the VNC protocol.
`sock0` is a socket backend which provides biderectional
communication to the virtio hvc console.

Once QEMU starts VNC client and any TTY emulator can be used to
control a single hvc console, for example these two different
consoles should have similar input and output due the buffer
multiplexing:

   # VNC client
   vncviewer :0

   # TTY emulator
   socat unix:connect:/tmp/sock pty,link=/tmp/pty
   tio /tmp/pty

[1] https://www.qemu.org/docs/master/system/qemu-manpage.html#hxtool-6

Roman Penyaev (2):
  chardev: implement backend chardev multiplexing
  qemu-options.hx: describe multiplexing of several backend devices

 chardev/char-fe.c          |  14 +++--
 chardev/char-mux.c         | 120 +++++++++++++++++++++++++++++--------
 chardev/char.c             |   2 +-
 chardev/chardev-internal.h |   7 ++-
 qemu-options.hx            |  44 ++++++++++++--
 5 files changed, 151 insertions(+), 36 deletions(-)

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
-- 
2.34.1


