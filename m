Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA2FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUiw-0004G4-Ap; Wed, 26 Feb 2025 22:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUiu-0004FF-KL; Wed, 26 Feb 2025 22:38:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUit-0007O0-5i; Wed, 26 Feb 2025 22:38:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-222e8d07dc6so9455205ad.1; 
 Wed, 26 Feb 2025 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740627485; x=1741232285; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ss/uPBwz8DryOg9D8ZY4d9vS3pZtz5ZqKLsUQ+BpsLk=;
 b=Wzu/PT687Bt+3oDAg72LIJfL/E7Sipmam8oIM1FEzdZOitsFyztOYKAdTLkJgDaiH+
 SVry+bEBRMjRcFLlUdjsOwzzLHCvkN8Mb4EuWRxS/NozAfjbtjCCzrInW99ikS5tZbRS
 oj1dV1O+PFIHRKprhE1ExAoABRSMqSGeAA9VjcrHaoJVfKOqDV9cB+O6jS0eSEuv13+j
 MSDeAH8ujhMyzCwBBinEJ/3iUdRey6lQVny2ZD21rrABaf2Vfg5C3eML5Wqh0XrTtTr2
 3wZZxNyj12xWfUS3kFHx1Y7EiHfvohyZZdbxwiFK+i6T3GIPU84drSX2awuYPTwOnHN5
 XvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740627485; x=1741232285;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ss/uPBwz8DryOg9D8ZY4d9vS3pZtz5ZqKLsUQ+BpsLk=;
 b=aEGsC2UBdl+t/MqoEETCRYBISAmNls25fsiFobeREHl2KP9t8k4bcgNulHFut1rACf
 6CF2cwBW9f9wSWumLziViCsPpIbDfYEhms6uLX8DSpGZ0cRLuf5ERMrp4/8m/khtmGCE
 VbNSVbLMXwnKiHQZr3idSOSxtlP14lvJu81gQs8XVOhZsWhmWaxb+8jvoPBO7/5djpre
 uCgtad+fCco1x+4LzyzOkn+UgYwbqrhtwgE4hemZeUBmrnN6eG28sNinwPPAx+5b7bAy
 pWQfoD0EkWob+tEec6tGy0GU8dxpdI1mB1EJbf+ikb5R4S6c5chhrWCIkv1PEH+/At3K
 YfmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqM4uu7vUTM4xepSNPhbfRk3yyXIqhCYoAVWfl2FdcZL6cGPC33TdItykkJcxo7EQFvi9qseHCD4RU@nongnu.org
X-Gm-Message-State: AOJu0YyuzJlxMohhmgSqfuqzAEEsTtd4iJ3XoP4mG1qnyu8QKI+ug4Qk
 i3BaGAw0OBzIrfTIC1Raxov/g/xzNj39lV4xla4V34N9lq07/7SK
X-Gm-Gg: ASbGnctpUXr+4R/jYoqg61TrmKIzXcAZyeX5OOQFA64WngDvCKZcffsX3+3BJdBS7za
 Kbz8PzXB/kPVCCQAZ8mU72K1hs2Xwx4XlEq1CRozOUFBBHUFSUxMt6zvmsqwlflmiK4qvgumIVR
 CvKNzG5nEE2RY7VEa9awNCgumgEHpMqqp+EKn4GkJRH9UNT3iOOltVDdfBUnmqyw/Us9f39wbDy
 aDX/gz37xhqJgDo+IpjuhO8JMSLJae2oRy7Gd0lmNctlfrxCKfR4/eBuSeMD9NmYYQ7Ita5bW6u
 lQfQDVy9AxFeJ8bwug==
X-Google-Smtp-Source: AGHT+IGrjiED/gOwjtdWgl83LtMj2dRv34D7gvpZ0upZ88TSRTagoaAP4MQtKBaQkBlTOkbujYKiGQ==
X-Received: by 2002:a17:903:17c6:b0:215:758c:52e8 with SMTP id
 d9443c01a7336-2234a489106mr30568865ad.12.1740627485327; 
 Wed, 26 Feb 2025 19:38:05 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f972esm4387295ad.58.2025.02.26.19.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:38:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:37:58 +1000
Message-Id: <D82WY0RYB30R.3M0B68UOLV0EK@gmail.com>
Cc: <qemu-ppc@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Sourabh Jain" <sourabhjain@linux.ibm.com>,
 "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Hari Bathini"
 <hbathini@linux.ibm.com>
Subject: Re: [PATCH 0/7] Implement MPIPL for PowerNV
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071934.86131-1-adityag@linux.ibm.com>
In-Reply-To: <20250217071934.86131-1-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Mon Feb 17, 2025 at 5:19 PM AEST, Aditya Gupta wrote:
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
> in QEMU.

Wow, that's a lot of effort.

> Note: It's okay if this isn't merged as there might be less users. Sendin=
g
> for archieval purpose, as the patches can be referred for how fadump/mpip=
l
> can be implemented in baremetal/PowerNV/any other arch QEMU.

I would like to add it. It helps test a bunch of code that is in Linux
and skiboot, so it would be quite useful. A functional test would be
important to have.

I've had a glance through it, but better review might have to wait for
until the next development cycle.

Thanks,
Nick

