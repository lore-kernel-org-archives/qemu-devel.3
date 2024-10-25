Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A228D0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4K3T-0001qi-Fv; Fri, 25 Oct 2024 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stest6905@gmail.com>)
 id 1t4Czh-0007Sz-OJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 01:36:17 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stest6905@gmail.com>)
 id 1t4Czg-0001AX-2a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 01:36:17 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e5ffea2699so1270647b6e.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729834573; x=1730439373; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1hsFhprj+EVmsewaGyAnDovq+HwLa9nlVD4mzDv+Bg8=;
 b=WPxR6vsTPDlokMrl1/BFmV84f6JJXC2p2ilkax8wfRiHwgPnfqFLLQQ2+nEe7cE9GD
 evZiX+6GQriWLx8rLk+2jYxt1XdH05V45h5fESrvWM9RHLAsLegyLWHAwkKyyNLl/Ccv
 BQMhxnxSZEhOxEutgFr6yyEoUYQNopVp1MxdHPvuhKf9qcHPmfMbVa1vcKlD5Rqh2G5c
 mFDL9oJal88Fzc1WapOkAMw86DJlKCSRM//Qz9VfdfsMGdsc4/qRg7KR6MiWKE48718S
 3mVkxmjvROUX22hPb5YfADlitH0E9SBaQC6uThSx1R83y6pBuKYD7s9e0uprSNTcy5dK
 kzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729834573; x=1730439373;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hsFhprj+EVmsewaGyAnDovq+HwLa9nlVD4mzDv+Bg8=;
 b=QPI6gzpmYb+Pxks0UZ6oteLftfaXO5QyAfHeFJRRGYUGa/q/p72a4snIzSpW/aJi69
 W2nrrFkFkyCD7ZRTzuy7VPpyn1EPFOPMqLLeiqraj7nqVgCNgEG7oxDmIgV7lyG5Vf9C
 Fae56GKBRcqIsTFDnO9VrH0Gf9xktHDGz4JLfF5mHOlnlJMbpT2LG2CtdaPUfiHgex7j
 h2MMbYJJPe6LL+45mtYwolhCz73v8qAVCo3+1czWwrTkAfkkRFhENPs/zioScRe0VqRs
 KRTn8HcHaLh6B5BxpI3DxVmyUiSvwgqYYXUjcdF5lB7831nIWeglGwn1C6RQ37oRRA2V
 g4XQ==
X-Gm-Message-State: AOJu0YxdBd4dM2tU/vn6N3CgDVhUskWm91zmOmveLheI306jbW+pMNkH
 1L2kLski7HqOHKkG1Vy3ksbn+LfnQSwgYnqkWiYHcawUADhOY6/e5HqZCPlUWcNSFY8sXG3ApuU
 MEhdoD9DeWrXTPD8lRVazy/9zNXZajSs7
X-Google-Smtp-Source: AGHT+IH2SPgyCXpBdkd1b4bICLM2W7qasrOi+fzxO+mUcWIbuFo9Bl3qiGWC3K+WMxwHmvsrzcX7onNZ5PDPhNBSZFE=
X-Received: by 2002:a05:6808:1597:b0:3e5:f9e9:43c4 with SMTP id
 5614622812f47-3e62c5adec5mr2497187b6e.18.1729834572905; Thu, 24 Oct 2024
 22:36:12 -0700 (PDT)
MIME-Version: 1.0
From: Test Inventory <stest6905@gmail.com>
Date: Fri, 25 Oct 2024 08:35:47 +0300
Message-ID: <CAGawYL8BdRnc_O7R-bFyc6py7E8kM7MGaUXgjSRxqfOOUv3xww@mail.gmail.com>
Subject: Problem starting emulation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003d04e30625467f1f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=stest6905@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Oct 2024 09:08:34 -0400
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

--0000000000003d04e30625467f1f
Content-Type: text/plain; charset="UTF-8"

Hello.
I recently discovered your emulator, I mostly use "VirtualBox". I wanted to
run an image file from this site (https://solar-assistant.io/) with the
following options
"
*qemu-system-arm.exe -M versatilepb -cpu arm1176 -drive
format=raw,file=D:\2024-08-14-solar-assistant-rpi64\2024-08-14-solar-assistant-rpi64.img
-kernel kernel-qemu -m 192 -append "root=/dev/sda2" -dtb versatile-pb.dtb *
"
but I got this error
"





*C:\Program Files\qemu>run.batC:\Program Files\qemu>qemu-system-arm.exe -M
versatilepb -cpu arm1176 -drive
format=raw,file=D:\2024-08-14-solar-assistant-rpi64\2024-08-14-solar-assistant-rpi64.img
-kernel kernel-qemu -m 192 -append "root=/dev/sda2" -dtb
versatile-pb.dtbdsound: Could not initialize DirectSoundCapturedsound:
Reason: No sound driver is available for use, or the given GUID is not a
valid DirectSound device IDqemu-system-arm.exe: could not load kernel
'kernel-qemu'C:\Program Files\qemu>*
"
Tell me what I'm doing wrong? I will be grateful for any help.
Have a good day.

--0000000000003d04e30625467f1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello.<br>I recently discovered your emulator, I mostly us=
e &quot;VirtualBox&quot;. I wanted to run an image file from this site (<a =
href=3D"https://solar-assistant.io/">https://solar-assistant.io/</a>) with =
the following options<br>&quot;<br><b>qemu-system-arm.exe -M versatilepb -c=
pu arm1176 -drive format=3Draw,file=3DD:\2024-08-14-solar-assistant-rpi64\2=
024-08-14-solar-assistant-rpi64.img -kernel kernel-qemu -m 192 -append &quo=
t;root=3D/dev/sda2&quot; -dtb versatile-pb.dtb </b><br>&quot;<br>but I got =
this error<br>&quot;<br><b>C:\Program Files\qemu&gt;run.bat<br>C:\Program F=
iles\qemu&gt;qemu-system-arm.exe -M versatilepb -cpu arm1176 -drive format=
=3Draw,file=3DD:\2024-08-14-solar-assistant-rpi64\2024-08-14-solar-assistan=
t-rpi64.img -kernel kernel-qemu -m 192 -append &quot;root=3D/dev/sda2&quot;=
 -dtb versatile-pb.dtb<br>dsound: Could not initialize DirectSoundCapture<b=
r>dsound: Reason: No sound driver is available for use, or the given GUID i=
s not a valid DirectSound device ID<br>qemu-system-arm.exe: could not load =
kernel &#39;kernel-qemu&#39;<br>C:\Program Files\qemu&gt;</b><br>&quot;<br>=
Tell me what I&#39;m doing wrong? I will be grateful for any help.<br>Have =
a good day.</div>

--0000000000003d04e30625467f1f--

