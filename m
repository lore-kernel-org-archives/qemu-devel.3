Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F9AC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 21:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reMD1-0008Qp-J6; Sun, 25 Feb 2024 16:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1reMCz-0008QU-UU
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 16:38:53 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1reMCy-0000u6-8J
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 16:38:53 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e49812ba77so350721a34.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708897131; x=1709501931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=us8G/Byu5G78tf+FwbD6ydw9ev0wN0j/EMModdVh+mk=;
 b=c4UzA3VB34Cf5iGXs08/qnU6PK139uvfO583CnPR6/x9kFsQrlDsdhTm8vL2KD2qZ6
 X5zN/XSAh6EUH6lg5MR0Xo5exXDghu5MNoHqaCfna0xQyEydiZRQGcEMv4SX7ZD3XUWL
 vGLVB4ASeSymJ0r8PvJT0vAOpk5r+p3xBOWwNHLApkOPhdui/u+4IkpA0R0NE5mqL4/6
 MirK3AWa7VTCQ7gsbARkoR38Fp0BH67QKs8kliVC/UoF2T1gycWp6M7RB4vQKEEuKzrM
 GgGp/V26badV/+ENb0mWHj0j7VmDIEm58FhAj6wfQwjkgEe1pzHxPdjIUIfitb+5bA+2
 vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708897131; x=1709501931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=us8G/Byu5G78tf+FwbD6ydw9ev0wN0j/EMModdVh+mk=;
 b=ky6WtXaJ+JmIZGPdxgwywJ4zSHDPyR7F+22yhPnXozoIkoax6DmqdHmxcI/xZW2fK+
 lfc4cZ9rkvGwVWS9lkbHiRy8YOIw8v/ZgacbHmqNEi4eP7eZxVV5czHAzrueC+/FuRL8
 OyMXOfIR0tw87NE/ZOhUwYlr5rvQzdVZ9kuhE4Bahul73CsdmagE+g3kr6IaCtMxj571
 2HnMgipKZgIZdoxrnZGnKf7JAs9bRwWdOvVYobol6R8vaVH3ZpBVmiYDHoxse35QAs7Q
 fmGZhBUem1kXlsuEaiiTtHkkPDykXff1S3WB4dpMJejHvQFjp0OUPhJM1haUkHWXBc6u
 kHqw==
X-Gm-Message-State: AOJu0YwWMUim8r/SGv7ODwhU2SkFM2USFJlomIHtVPg6jy9Z9jynFCmd
 RKsIu44hkZipQyPtjrdzzFd1D01lNlpnLVuKlMqL0HpUS2WUctYR
X-Google-Smtp-Source: AGHT+IF2Fz+F+Y4vW7TK4tjNf1/qHV4U19cfyNcP56TOeJSV5tKs1oP236bnMn9CW9U5i8poLik/pA==
X-Received: by 2002:a05:6830:120c:b0:6e4:7be4:393a with SMTP id
 r12-20020a056830120c00b006e47be4393amr6977458otp.5.1708897130697; 
 Sun, 25 Feb 2024 13:38:50 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.82.79])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a63f746000000b005dcc8a3b26esm2716500pgk.16.2024.02.25.13.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 13:38:50 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: eperezma@redhat.com, sgarzare@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Intention to work on GSoC project
Date: Mon, 26 Feb 2024 03:08:47 +0530
Message-ID: <13625712.uLZWGnKmhe@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=icegambit91@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

My name is Sahil and I go by the pseudonym 'valdaarhun' on Github. I have
never contributed to QEMU before but I have used it a few times as an end
user. I developed an interest in virtualization during my internship at
VMware and would like to dive deeper in this subfield.

My current full-time job does not allow me to take part in external programs
that are paid. I would like to work on one of the proposed projects outside
of GSoC. I have gone through QEMU's list of GSoC '24 projects [1] and am
interested in two of them:

1. Add packed virtqueue to Shadow Virtqueue
2. vhost-user memory isolation

Based on what I have understood, they are somewhat related and are part
of the migration subsystem. I feel the learning curve of the first project
will be less steep and will make me better prepared to tackle the second
project as well.

I have read the "Getting Started for Developers" [2] wiki page. I have also
built QEMU from source.

I think my next step should be to read the documentation on the migration
subsystem [3], the blog posts attached in the first project's description
and virtqueue's implementation. Would you also recommend that I work on a
QEMU issue that is open on Gitlab and related to virtqueues/virtio to 
familiarize
myself with the codebase? I went through the issues tagged as "device:virtio" 
[4]
but can't really tell if any of them are good for beginners. One of them has 
the
"bite-size" tag [5]. It also has a patch attached but hasn't been merged. 
Shall I
work on getting that merged?

I have worked on a few smaller systems programming issues in other
organizations (eg: strace [6], htop [7]) in the past.

I look forward to hearing from you.

Regards,
Sahil
https://github.com/valdaarhun

[1] https://wiki.qemu.org/Google_Summer_of_Code_2024
[2] https://wiki.qemu.org/Documentation/GettingStartedDevelopers
[3] https://qemu-project.gitlab.io/qemu/devel/migration/index.html
[4] https://gitlab.com/qemu-project/qemu/-/issues/?
label_name%5B%5D=device%3Avirtio
[5] https://gitlab.com/qemu-project/qemu/-/issues/230
[6] https://github.com/strace/strace/commits?author=valdaarhun
[7] https://github.com/htop-dev/htop/commits?author=valdaarhun



