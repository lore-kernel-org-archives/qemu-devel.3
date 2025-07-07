Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C8C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmjh-0008ER-7N; Mon, 07 Jul 2025 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uYmax-0002r3-Vb
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:13:28 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uYmav-00022k-0z
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:13:23 -0400
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a16e5so5814411a12.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751897597; x=1752502397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O+oP4LEradE+JtosemTV6D0FIu410eDhH2Vo+Z6ahsE=;
 b=CaIifZ0DfSt1Si51fUSEJ6mEJyTV1cETtGIXLV0Z5DTmtQHmCjP+cLgdMP280r3wXq
 Tnl93ViN8HWCOiC2C4g5WlPKIlIoQmcFHs9uBb6OsXMAunyYvDTp3BSWx9iov1FfOugA
 O/Chf47PdQ9I4hLQaCjxDbcp0yZ2/5hpcvQYAC8ev4tPzvqnncJ0C4xrX8zyM8HzWJka
 Sgsv1Tm5wGKkXATQjmEFpSsF+70RiY0DeAmU2qlyIpLC8zisvTtIqxwJwxC0eTTarMif
 TkDPx4vPxS+HzUn9qlffjqt3np+1ySY+1h+hvT+hI8J++bxe87YTo3a0LqDgvu3vD7ds
 rPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751897597; x=1752502397;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+oP4LEradE+JtosemTV6D0FIu410eDhH2Vo+Z6ahsE=;
 b=MBuLsPvsgtoat/DbsroHbYyDbPv3rmxganE2az6937uplAF5EHCEL2v7GYoANP3Xyw
 /mwbGYVruM8mD5FsihEU3n87igZ9NlxN+CNgitH6536Dlsmz9lweaIPLScWkfCTLP0oh
 KKmGPOCQOukuNW942kp2BHBCPBKxsJOcQSpQRM9cDi6aoMCRzETNpWtt1dbQEAa5J6LQ
 TxrfNjQzAT4Nn0Rw5gxMdTbC00BKSEFRPoTU2OjzES6tiNnQ6XDvSSHDCgzJTetUsFH0
 jRYcRMl6GmZjs/cjUSsL+MD9NgS+QBOP8HIPnBTe+WV5PpxHO9Xf2unVNR1KJFUu2VEQ
 dCLA==
X-Gm-Message-State: AOJu0YzVV3CLVXs2uWrg+PBBOSGO3ZZtMCzqfpx/UUmXkmtb/tJSV90y
 JuPPF9PMgLKVyUpQHPVkQ+R9azZLsrJiSStRWiFzr+AX53JwUVkCwmvmjD6a2X/znwnu0+VqLXF
 xzglvSrGZo2Bb55Wj/32tuLFpVn+1VoeI3HHNY9cVDw==
X-Gm-Gg: ASbGncvrxqdHtNH0GdOj4YblmQJPE5F4hsZr+ZuQ/u5JY02BYzPsbnp3uaQB9pj5NxA
 mwZsELH7zDVsV09KwcYEJQWDYOi12HIX00ouNzrhPC87FyXynEpJiz6y7fgS4M+98wXrYWGjo6q
 4oyZmbb7ivKBBgXpJxHH+kq6w2YX8B1qr3MY6jJ7RCc/1jpZW1BSfSJ/12CNt2C0eN6Aq/yhg80
 6sH0EyW35Vl
X-Google-Smtp-Source: AGHT+IEu3U1EGDo6+uDj26dlAuMYoi7cMHxAtO32Sfg5YMvctCDt33/kUmgRbXIxISdJLePQkwZJznevwB7hnScu/p4=
X-Received: by 2002:a05:6402:847:b0:610:3378:3d97 with SMTP id
 4fb4d7f45d1cf-61033783e0cmr2337521a12.28.1751897596645; Mon, 07 Jul 2025
 07:13:16 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 7 Jul 2025 10:13:04 -0400
X-Gm-Features: Ac12FXyjTOgz3mkenDtDODM4ArqKDs8qwAkfy_4Yd955I9Bv8xuY5uiOm0jpitE
Message-ID: <CAJSP0QX+WARJQ_6oN=vPyzkotQ01W0Jk5S65Z=Npw0BYp3jdpQ@mail.gmail.com>
Subject: Bamboo ppc Linux image URL is 404
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x544.google.com
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

Hi Thomas,
The following URL is 404 and is causing the functional-system-fedora
CI job to fail:

qemu_test.asset.AssetError:
http://landley.net/aboriginal/downloads/binaries/system-image-powerpc-440fp.tar.gz:
Unable to download: HTTP error 404

https://gitlab.com/qemu-project/qemu/-/jobs/10592622177#L1047

Please take action to make the job pass again. Thanks!

Thanks,
Stefan

