Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC8FD58094
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFYKz-0008AZ-0j; Mon, 25 Nov 2024 07:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjavadsekonji@gmail.com>)
 id 1tFYKq-00089e-9C
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:37:00 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mjavadsekonji@gmail.com>)
 id 1tFYKo-00063O-1e
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:36:59 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffa3e8e917so38339821fa.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732538213; x=1733143013; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ao/o4KEII5apUCnc3YYd4kirFdOQ4PNw5GNgmPegnig=;
 b=EAlfVLSAkF6GWLec3HBsFgJBp8MvI1mfdJqE20Txr8WymfBSAhQ+ei7Hm0uFSs64vD
 XyL+9hycevDst1c7oKLOd2M6ZHG0cVklnFCYokeib55b/jY6U5X0EDOU4qsT9Ga7I+b5
 OmtXyMojZHNOVVg++EJbV6snk4Peub8L/PWSysWMQ0GW5oAm+ut2KyvYti3B+me5hYiD
 jUG2wBwf/DBbAKebyNBOVNUGAWJ3cIH9q37eQM6MxDkrdhlXlyliPBEbzP3e+LOvKCYF
 31JqxapuLtHx/BmXL0LGJgaU3TYUnU3cJ737Ar76MxFiObMMEcCpxJCripPDQBK1FcYi
 jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732538213; x=1733143013;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ao/o4KEII5apUCnc3YYd4kirFdOQ4PNw5GNgmPegnig=;
 b=TodSBnq3yzPggbc6+2KnPI557GT1vwWoNuXI6j8RRF33y+FzWZwaknPjPZ8X1y4bZB
 fKVs1hl65iu/GhK/EjKyqc4Y7/iMU6G598r6B8pJXqKlu69V5Kk7JXQNWN1OqpQwJT2m
 qugLyMDxKDk2vVYQ3Yorkrl9Essye5eX6miAcHhc/OjRTU7y3PAUYhFgENoSHn5gnBkl
 SGPDf/yNOYACBKadD8grZrJgNz/lAs6E8ySc3O3ryVgMSCzRzToyLpacO7tTOIXAKQ2B
 hIcSt+qAXGYkjhB0XrQ2MqGGDV3Jw3HhO5Yk0Bj+nq5doJUp/hf5wy3hITD3FMh1Sx2/
 l29A==
X-Gm-Message-State: AOJu0YwyHyfUUw1QUPewt8ySPAIyK+8qoGhIrNb+0YM5xU5DytpfmgsV
 H5BYj1DhjyMxzS2AOTLbWyuiJLG9Yn3LwOPM+uArzShx8klS5dbnrsIuFvLnhNe+7N2BiiRpNy6
 oSRrO1IQh9dl0iST0z4iFnJBv5OIJWPtn32OXL/TC
X-Gm-Gg: ASbGnctzcd8+5uY9+Fpg9CG/D1xZAXlKeOUIkgaH7VEeInse7UZ7X8I8AATnnoSRIJx
 2IRXLUCAdRk2kJCEwet5JL7oA7judOa8/Ag==
X-Google-Smtp-Source: AGHT+IE3LbCwgLmQ4dTO/XmF3ifkoh+0iasoc67pZbzzYpprCXzd8ADg+FyFNMvATZwpIsuCH2Xw011TPv8qbJWNWeQ=
X-Received: by 2002:a2e:a916:0:b0:2ff:c67f:5197 with SMTP id
 38308e7fff4ca-2ffc67f54b2mr10090291fa.13.1732538213040; Mon, 25 Nov 2024
 04:36:53 -0800 (PST)
MIME-Version: 1.0
From: Mohammad Javad Sekonji <mjavadsekonji@gmail.com>
Date: Mon, 25 Nov 2024 16:06:41 +0330
Message-ID: <CAEe4h_KP4Sz1creWtuOk+dMVbA02sbJnycu+Ai3u_tsL=FdZyA@mail.gmail.com>
Subject: Request for Technical Guidance on Custom RISC-V64 Architecture with
 Linux OS
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bf8a9c0627bbfc2e"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=mjavadsekonji@gmail.com; helo=mail-lj1-x234.google.com
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

--000000000000bf8a9c0627bbfc2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear QEMU developer team

I hope this email finds you well. My name is Mohammad Javad Sekonji, and I
am a master=E2=80=99s student specializing in electronic digital systems. I=
 am
currently working on a project involving the installation and operation of
a Linux operating system (preferably Debian Sid) on a custom RISC-V64
architecture with specific hardware modifications. My goal is to use QEMU
to emulate the system and compare its performance and behavior to the
standard RISC-V64 architecture.

I have successfully completed a similar process for a standard RISC-V64
setup and am familiar with the general workflow. However, I would like to
confirm whether it is technically feasible to implement such a setup on a
customized RISC-V64 architecture and, if so, to understand any additional
considerations or steps that might be required for this process.

To provide more context about the customizations I am planning:

   - *Architectural level:* I am considering replacing the standard
   architecture with variations such as RISC-V BOOM, 2-stage pipelines,
   5-stage pipelines, Rocket, and similar designs.
   - *Microarchitectural level:* I am exploring modifications to components
   like the branch predictor and other similar elements.

Given these planned changes, I would be grateful if you could share your
thoughts on any specific considerations or potential challenges I should
anticipate. Additionally, if there are resources or examples you recommend
for implementing such customizations and conducting performance
comparisons, they would be immensely helpful.

Given your expertise in embedded systems and related areas, I was hoping to
seek your guidance on the matter or any relevant resources you might
recommend. Your insight would be invaluable to the success of this project.

Thank you very much for your time and assistance. Please let me know if you
need any additional details about the project. I look forward to your
response.

Best regards,
Mohammad Javad Sekonji
Master=E2=80=99s Student of Electronic Digital Systems

--000000000000bf8a9c0627bbfc2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear QEMU developer team<br><p>I hope this email finds you=
 well. My name is Mohammad Javad Sekonji,=20
and I am a master=E2=80=99s student specializing in electronic digital syst=
ems. I
 am currently working on a project involving the installation and=20
operation of a Linux operating system (preferably Debian Sid) on a=20
custom RISC-V64 architecture with specific hardware modifications. My=20
goal is to use QEMU to emulate the system and compare its performance=20
and behavior to the standard RISC-V64 architecture.</p><p>I have=20
successfully completed a similar process for a standard RISC-V64 setup=20
and am familiar with the general workflow. However, I would like to=20
confirm whether it is technically feasible to implement such a setup on a
 customized RISC-V64 architecture and, if so, to understand any=20
additional considerations or steps that might be required for this=20
process.<br></p><p>To provide more context about the customizations I am pl=
anning:</p><ul><li><strong>Architectural level:</strong>
 I am considering replacing the standard architecture with variations=20
such as RISC-V BOOM, 2-stage pipelines, 5-stage pipelines, Rocket, and=20
similar designs.</li><li><strong>Microarchitectural level:</strong> I am ex=
ploring modifications to components like the branch predictor and other sim=
ilar elements.</li></ul><p>Given
 these planned changes, I would be grateful if you could share your=20
thoughts on any specific considerations or potential challenges I should
 anticipate. Additionally, if there are resources or examples you=20
recommend for implementing such customizations and conducting=20
performance comparisons, they would be immensely helpful.</p><p>Given your =
expertise in embedded systems and related=20
areas, I was hoping to seek your guidance on the matter or any relevant=20
resources you might recommend. Your insight would be invaluable to the=20
success of this project.</p><p>Thank you very much for your time and=20
assistance. Please let me know if you need any additional details about=20
the project. I look forward to your response.</p><p>Best regards,<br>Mohamm=
ad Javad Sekonji<br>Master=E2=80=99s Student of Electronic Digital Systems<=
/p></div>

--000000000000bf8a9c0627bbfc2e--

