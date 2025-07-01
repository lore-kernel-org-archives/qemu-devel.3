Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B6C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZCZ-0002L9-Dj; Tue, 01 Jul 2025 07:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1uWZCT-0002Jn-VY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:30:58 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1uWZCO-0007zb-BZ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:30:57 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-32ce1b2188dso38410691fa.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751369449; x=1751974249; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QIG6KFSu6Cq2Q+uTRAiMVLhEcoNdDloV/xPSIQ52UhM=;
 b=h/9xE0BT1WtR5Rt7T8yh7eSLYX0VGaKVPYnN+O1TGvLlFkUzit0vohYcW+OU7K0x5C
 szne+YEsvsfd9ea9VBjH8d70hwAhX6YE+4Z1CbsApKhxSMAkuXf1MftF6i2443oYxoCD
 Yl+kSozKpsDq2qdUPpceU0jIGGqtVOEsGhvXtzOs9UKP8ZCu6MARd4rA4bVIsdTyWjex
 o/va70djCiQFXgAuwvIt/ThxYpu6A0i8mPSm31NFEPs7mOs89FJx6IfJeha0aAVUGFR1
 nxg0C+lwxUq7zL8xLYvw0j4CFXfSOr9c0tJB3jeJn7lEmDw5jmyZgYjoAdyRvnSLjOP6
 42ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751369449; x=1751974249;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIG6KFSu6Cq2Q+uTRAiMVLhEcoNdDloV/xPSIQ52UhM=;
 b=M93YIQgdyJFmhPqMt/U0a9SoMBHPjtdy5PTVthISuQ5BTmyaLPSNZxyFC8zFbDT2S9
 BHUfM3D9Qt9T8+s0Ey65KWYaOJQgmSLuwjuBwfOmbl1N6br2vEYO0hdXalcoQViRV/is
 oheN5QO62JYvCh+HADivCM3vow3l2t041xHKnancBoQPPEkMY1faIpNkrU/1pmWW/z+J
 b4UsUKVz5GChJXC+/OTS0rcY90uddkvjF371blhV3PEexcgC/OgEaKill3g6mNt3D1O+
 w5mTUe3XujEDqNCRzRju+L8PfbW76JYyj48iKfoPLb8tGwud6dzS0M1fXjXnqKzAQzH/
 4zzA==
X-Gm-Message-State: AOJu0Yydtl6vWTACI6CcFcbRM9x0U5CJRqlAw9iMxZoCdwJRGtMHfwX0
 nlR//fTrUpYE+C2ZlXj+ER74LmIvnETsyTR+drPGS7CpoCz474vXxj+7884w5v0osjaMeS0gJOO
 mT2Lc5NCNr99f9y8mJjYH4r7oANbtY/75NIxbAQ==
X-Gm-Gg: ASbGncvchZWV65cF7/+nJ+KGUchRrct0EcTaUoO6igOp2+UaywhhjzEICxPZ6NbJ+RR
 FGinT9jmXpi5Y1HNxvf5DfGyn/ZQEKzFJRKrlRcAYJng+ramHvQBXSUyq2bh9OFENhlYkALlE/u
 sS+cREQc99Rj2Nm8FMayrRLlyelMYNye5nK/x5ayAKKYHH
X-Google-Smtp-Source: AGHT+IGsZmUNZurvjQG731HRvENIk5GwF/4tJzYXKpQa9gR7vo4rqeV9uUX3DebK5mTNwgdSS5ePqoILmTVm740wiHg=
X-Received: by 2002:a05:6512:1089:b0:553:20f2:2e79 with SMTP id
 2adb3069b0e04-5550b803d2emr5184453e87.13.1751369448582; Tue, 01 Jul 2025
 04:30:48 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Tue, 1 Jul 2025 19:30:36 +0800
X-Gm-Features: Ac12FXyKiTeIYoMfM9pAUiY6Uwo4w7O6Qaq2JOH2LX3I48JNSRLnfzq7NgP7lvE
Message-ID: <CAOYM0N1ffwdV1CDCrt_=ZcuQRnNbZ4ZNC3CS9VoxF=Yz4yMdUg@mail.gmail.com>
Subject: about 0x602 in e1000.c
To: qemu-devel@nongnu.org
Cc: dmitry.fleytman@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: multipart/alternative; boundary="000000000000da73280638dc797c"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000da73280638dc797c
Content-Type: text/plain; charset="UTF-8"

in the source code "hw/net/e1000.c"

[LEDCTL]  = 0x602,

maybe should be:
[LEDCTL] = 0x07068302,

according to the "*Table 13-60. LED Control Bit Description*" of the doc:
https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf

0x602 is EEPROM default value, just for LED0 and LED2, according to the
same doc:
*Table 5-15. LED Configuration Defaults*

--000000000000da73280638dc797c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>in the source code &quot;hw/net/e1000.c&quot;</div><d=
iv><br></div><div>[LEDCTL] =C2=A0=3D 0x602,</div><div><br></div><div>maybe =
should be: <br></div><div>[LEDCTL] =3D 0x07068302,</div><div><br></div><div=
>according to the &quot;<b>Table 13-60. LED Control Bit Description</b>&quo=
t; of the doc:</div><div><a href=3D"https://www.intel.com/content/dam/doc/m=
anual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf">https://www=
.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software=
-dev-manual.pdf</a></div><div><br></div><div>0x602 is EEPROM default value,=
 just for LED0 and LED2, according to the same doc:<br></div><div><b>Table =
5-15. LED Configuration Defaults</b></div></div>

--000000000000da73280638dc797c--

