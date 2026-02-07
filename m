Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7C7EE0AEF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 18:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vonCs-0002xx-PK; Sat, 07 Feb 2026 13:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manishyoudumb@gmail.com>)
 id 1vomqt-0004nP-AV
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:16:15 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manishyoudumb@gmail.com>)
 id 1vomqr-0006Z9-P6
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:16:15 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-59b6c89d302so3101785e87.1
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 10:16:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770488171; cv=none;
 d=google.com; s=arc-20240605;
 b=kbAdbVxo827izQq/KZkBOCdIW2UpDE77mcEmiTTLQGoq4AR/8mn5jxotDbnh0xxF4A
 /OtDHI5Oa+qrKIe1ITYXNfPpm4raBerLWKTB1srqx/KFqnBkX9Xg8AdLGMuwPSgqwlIS
 I+cbzuitmYQaLILonGf97mqtkWdJKsjCB5r2QyQ5Ma+juzenMOhyWbEwg/qBCOrHXQji
 xMGMRVajuHsDXPKzqXcqP7Yw6VkoiHZf0AzdE/4IhKRTBZt1LeRW7JpPcjR41CPIl7ET
 9O2KQ8vJ0CM1SPYcvpIPeRAps/rpvBCwz2TyKrQpAAPVShTGQtYIc/cnB+beBYdiIrJW
 JyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=ZgixTViAtrdxO0C/zeUJ4rvmnaCLfF0qzwhwfsFGJrQ=;
 fh=n52ifZ/kDzZwlv1aVLOWxsFdC6ImtvNa6Ol5F12PhDE=;
 b=gHYzifzqVor4oXY8olaTqQg7aHaGkXqwP8BP0Qu/8X4X4vrC0ycR/ccR9pMPQLICSs
 JuLsaw0RRIcJs/IhCsG30wgppelILuMVGH95uxT+dZ9E5MBvzVK7R/UzW8jfwpDmbRIr
 2rkk2HEne/HwdjdWkgSh2oCzIGo2fKxnIQh+n3NDZeOCvwAT6YODSQ82lf3NGQYRWZKv
 6BpftCv/6xiRw8FgyhnLYJ0Eb6SW9U46TQZwsjNBJ7qJJ/GstaV1qEtlTt1FYwxqScID
 //cUuPebMn7ZbJ2GPs6I6iDrH/Zd8d5SSUmdR5SVRKG3SlQGS/EU9VJVCdlfR43YshOb
 Al6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770488170; x=1771092970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZgixTViAtrdxO0C/zeUJ4rvmnaCLfF0qzwhwfsFGJrQ=;
 b=Iibuc5jgXL4bzx8FN4WxCKj3V0d4A5pfO2fq7U/ETkExj59YPVnnUFinLpnGOhUsO7
 hS2ceiSf+vfZ/yAYBp8umW6e8F3OJCv13qvvUlvyBkHfHKypnyrhPYXdqtWQxkZF9aZj
 spga+rKIyXpuIcN3sPajLjN6V0FI3/nzvGPqbC9nH00VXit+hFWDmhS40xgv2x6bSa8u
 3kIvSHfAkNsw16++1EJjGl7o56iqiDS1kx+Kxet1M26ybvl+WOG8A3npYg4MAd1QaTpw
 J9QYs/B+xWPwg4XqnUm16wmMOQr3WUsyHI/F3Ds9ZttpuPPW11kUtofxIIq4qEoDF75Z
 MN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770488171; x=1771092971;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgixTViAtrdxO0C/zeUJ4rvmnaCLfF0qzwhwfsFGJrQ=;
 b=Myt91mZVXm45wOieLTEE094vvmAyNwxszh9x27Qfuqd3yFukoy5JyP+8oMnHXsjOnU
 WWUYItr0vj61XmeGU622BMzQj4OvE6Y1S9b4HRG6pIpum1FzMklZCyeg0DRglfPtuYLn
 Qb4AASmw3LH9T8QGgz3IAxV2w9KSM6cnQ7xER45Jo9LJfvqPmKoel8MXTshunyYwEfVC
 EyL/prRH6Bj0BDlb2UrgwXMdcED3ZHjMvgvUy7JUbb1NG3sOs3+O+ZiwGo55ZoTfsfxj
 o/nFEHsAQNw6eGY0g7DwTq/1GnFuPIi9piXw45Z88UmiUJIjjoCeKa9zH4ag9Yl73usi
 WD8A==
X-Gm-Message-State: AOJu0YzeqITsZep/n2iPXMn3vhGyBHqqFUHWwS0Gi4TmXrOXYt4pJBLo
 OChmT8OBaII53YVAkBbN14mrkh3xwFWmVySeP+k2NdqVV7rAFq2LBVAfGvHPT0/T8dDFXkXZThU
 WnSJAC439hZ5h0jQGfnIdo89HZal/3OTYaSCKwkTTQcJN
X-Gm-Gg: AZuq6aIUL8nSprrDGLQVXFfuzymng/IjHAfWEpKbHiQRP2Bc3T++YRvSSZZ0le76Cxl
 5tEis5E1s9WvNYAoiLXPgMWKcUkjsLTnSBYVIrJtux1umB/Zal2DxZOnAauSuhWukIg1twXgV/P
 qhUQM5NxljlfrTU2kGKvkcBZOlNMigcc37GnoxNsOgNXTOV8vwDp63H0GSbYIUypjEgwDjVxt7k
 /ia3O90jSAaY8hZ/Roq66ToZcFbA3RlrTWzn974C1aekGkacP3cV0PBRj2cE0IczNTiJwelQMFJ
 Vzd/7AGlqb233F+51qhy0udNFEmOBer52heoS7q/rUU2UBdo1FRBt1oFAguFyogy5Bo1apTop76
 6uN7ggNgcgBvbsJwv9WY5YnSAIw6CUV8MMXm1A5Ya3a1L
X-Received: by 2002:a05:6512:12c3:b0:59e:144:64b6 with SMTP id
 2adb3069b0e04-59e4504cdc1mr1828336e87.21.1770488170292; Sat, 07 Feb 2026
 10:16:10 -0800 (PST)
MIME-Version: 1.0
From: Manish <manishyoudumb@gmail.com>
Date: Sat, 7 Feb 2026 23:45:58 +0530
X-Gm-Features: AZwV_QgSjo06gVqFqgUtC-LJ8Ll07y9n6d6FW253DgC5No0r_GtNcKbH6AWj0Cc
Message-ID: <CALjG0Qw_MJ2sgTSiCB2UJ6jS+zMcsJYVTCzh4s=CSvrrH9ySVg@mail.gmail.com>
Subject: [PATCH] hw/xtensa: convert calloc to g_new0 in mx_pic.c
To: qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manishyoudumb@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Feb 2026 13:38:53 -0500
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

From cef7f1f3d7b47338b7359ad4b815e04bc965d427 Mon Sep 17 00:00:00 2001
From: "Manish." <manishyoudumb@gmail.com>
Date: Sat, 7 Feb 2026 23:26:09 +0530
Subject: [PATCH] hw/xtensa: convert calloc to g_new0 in mx_pic.c

Convert the calloc allocation in xtensa_mx_pic_init() to use
g_new0() for consistency.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798

Signed-off-by: Manish. <manishyoudumb@gmail.com>
---
hw/xtensa/mx_pic.c | 3 +--
1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 07c3731aef..ab308c9490 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -316,8 +316,7 @@ static void xtensa_mx_pic_set_irq(void *opaque,
int irq, int active)
XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
{
- XtensaMxPic *mx = calloc(1, sizeof(XtensaMxPic));
-
+ XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
mx->n_irq = n_irq + 1;
mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
mx->n_irq);
--
2.52.0

