Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A45C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 19:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryGGN-0006r1-FI; Sat, 20 Apr 2024 15:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abhi97.rajmane@gmail.com>)
 id 1ryFCN-0005c4-Dy
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 14:12:27 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <abhi97.rajmane@gmail.com>)
 id 1ryFCM-0001tz-0H
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 14:12:27 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6eb848b5a2eso1804386a34.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713636744; x=1714241544; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BZ4H62GPSlGN+lnvy+FxWYMiISpe6dufsOKtBmft/Gc=;
 b=ltDvTsPSHGbls3jUfwzu2PCkEl+pJ2HouRM1zB7pIIoqnKiiavaaJpnVxv6p3eEjcS
 RHq7EwE0cEmEma+r5ry5T6y86xcaljkEADJli17EwC43fhXQ+uPwrYLmcwQsdrSy8/q8
 ORo9rZb6Zret00+GmnHlPOiVJR7Q66pPTz8QMV4j+RETzoPiLV/snUvHg9937sawYETz
 Dt3imJITiOol/iIfnnfTIaZCcv4u50mI69dLu+mbWldpDCuVaY1RFr5sk9hz9KaQPuA9
 qZ07PLtxoDX/FeUjE7QC01T3FvznlnoDe0oIj/nqV7tbpYaktzZb5nZq9by476w9Aky4
 0jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713636744; x=1714241544;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BZ4H62GPSlGN+lnvy+FxWYMiISpe6dufsOKtBmft/Gc=;
 b=h2DEypNTHlK6ICgyvkh8pQ8imwFyldk80mKYULyxo0NWv1o2YWG+mxefnk6PJznQC1
 CY8D3FzReLXTzArF2lY1tzVMbJl4LFKf5kfTPOUjxTPcyEJnb+VsjnaP9zmliJTguv0L
 S2D+ZCYH9/GHdKLggcg2QVpHZOqfacOdrI2uLPGBIv6xae0q99UYp+3Cl8k2/ikGxQVK
 7CIZOruW+jeRyKrkD0VMLm4ZJwBNnHeYHg3uzV5aL2lm1oOxYMQBuxr7PfUaFhjrZoVx
 Q1f3q3qmI4h85QutSZBhbfWZItweRj7VuU6F7OnrMDZoYW3vvQqwTOL6tRx9Y0gT/MSk
 0tdg==
X-Gm-Message-State: AOJu0YwmRjsFRSGvtzHgnKPwFTQWtax5tNbr1q+pdso3G3t3PR0F0al5
 tXNTx7M76w4sonP+VeOcQXgd/ej8Pj6C5EQSHOCqfqgQxKc61D70iNxJ8bzii3RA60qOPfJYD7j
 +3J9KzqpAAXW2g5TeeSWfrj5xot2BKWE=
X-Google-Smtp-Source: AGHT+IH2UoLLRriuqHl9eI0h9hMZfuKfXYLsemxwUTHZv+M9Pb1b1eE6Lm91uKidMOnb23wp3dXBptHBIlEJf1iLVsk=
X-Received: by 2002:a05:6830:11cb:b0:6eb:d349:8c3f with SMTP id
 v11-20020a05683011cb00b006ebd3498c3fmr6143267otq.28.1713636744325; Sat, 20
 Apr 2024 11:12:24 -0700 (PDT)
MIME-Version: 1.0
From: abhijeet rajmane <abhi97.rajmane@gmail.com>
Date: Sat, 20 Apr 2024 23:43:22 +0530
Message-ID: <CANJXYHH_CPc40eR6AWU0pKVgX9LkOg_2DbdOmZ=F1+cKaQwrsA@mail.gmail.com>
Subject: xlnx-versal-virt machine in qemu
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006b716b06168b250b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=abhi97.rajmane@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 20 Apr 2024 15:20:33 -0400
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

--0000000000006b716b06168b250b
Content-Type: text/plain; charset="UTF-8"

Hi,
I have booted up the xlnx-versal-virt machine using qemu-system-aarch64. I
wanted to work with can device that has been modelled with this device. I
have used the xilinx_can.c driver for this device and can see two can
controllers. The problem is I am not able to see any interrupts in
/proc/interrupts for both can devices. I have set them up and running. I
have also connected the canbus device to host to transmit and receive can
packets. I am seeing qemu_set_irq() getting called. Am I missing something?

Thanks ,
Abhijeet, India

--0000000000006b716b06168b250b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><span style=3D"color:rgb(51,51,51);font-family:Rob=
oto,sans-serif;font-size:13px">I have booted up the xlnx-versal-virt machin=
e using qemu-system-aarch64. I wanted to work with can device that has been=
 modelled with this device. I have used the xilinx_can.c driver for this de=
vice and can see two can controllers. The problem is I am not able to see a=
ny interrupts in /proc/interrupts for both can devices. I have set them up =
and running. I have also connected the canbus device to host to transmit an=
d receive can packets. I am seeing qemu_set_irq() getting called. Am I=C2=
=A0missing something?</span><br></div><div><span style=3D"color:rgb(51,51,5=
1);font-family:Roboto,sans-serif;font-size:13px"><br></span></div><div><spa=
n style=3D"color:rgb(51,51,51);font-family:Roboto,sans-serif;font-size:13px=
">Thanks ,</span></div><div><font color=3D"#333333" face=3D"Roboto, sans-se=
rif">Abhijeet, India</font></div></div>

--0000000000006b716b06168b250b--

