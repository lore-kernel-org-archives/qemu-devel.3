Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9E6C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsKj-0001ys-Nf; Wed, 06 Mar 2024 09:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuyb845@gmail.com>)
 id 1rhnBE-0008EC-T8; Wed, 06 Mar 2024 04:03:16 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liuyb845@gmail.com>)
 id 1rhnBC-0004aq-SP; Wed, 06 Mar 2024 04:03:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so569051a12.3; 
 Wed, 06 Mar 2024 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709715791; x=1710320591; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2A+eXIP61nOObie+6hF7GYVPiixHlwF90K4X7zcmbs8=;
 b=E8Eef9HsppaxwHN+fcIumAjCYNeP5my8Ty3L3RJxcKVw3vkKpQvXR9vjpWc/1uAwhc
 Pzp0yH0vEwNHwodsPEJYxetfQTqnB4jH9NjZmNSrF/k1O3HKvJbS9EOiNtZTx3pf8iLQ
 VkzQGRyLDDdwHN3PvxtKpFHQeC1dC1IDWHiDpy8vy92PaIzINl97y1eowE+sg6xdQQDG
 toD+MPWgxZ+dFpfk2qYkQ4qvE5cOI6yMoY4mI+ggND1nckTmyO+KEfuMeNr630Qpp2QC
 J69TdXS7V1fcZSExvbU/ibLciNOFlVanrZgiLYmXTaZtANF3iKK4cqA8AHEuuVRcJyv+
 Op7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709715791; x=1710320591;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2A+eXIP61nOObie+6hF7GYVPiixHlwF90K4X7zcmbs8=;
 b=B+QjjH6NzlAXYqqkMCK9YXwTQhVRbCZltkoeBMBXa7k2/Byxpc30QZEdE7talLapG1
 szua+5fxgB4IR6mKjb1SbzYkVk60qlAqcOtqfTI3OnTDali2A0Z4gRzL83+QGehVz2u7
 2iNGh8XjhM+/mX2tyNLChF+otJFx+PIqDkC4UDtTfg62avQQj2RdYYkGsMpjzWB2749P
 EK5EmGLhtcyS6wQSfhg6yzAGNDkIjiXJnEMKGmm/En9qnFPIRVppVC1HT+mzzeBty5nf
 i2DfqMMryiHUpcVcJdgGBeu6oodRpFT07buKvHElWw8YVzuldeCF+o8t9NjjVW+pZxC/
 ovDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyK4ttgKchIG4DGtndEGAGUeKdngJ/88AgPPyMLTbs7F94ndu7UTMOzBPXqd72I7QmUUFaJQDETkXXIjl88wgYUBEOULDlMwNt3YiMT2xcOXxlr+9JO3H2qSg=
X-Gm-Message-State: AOJu0Yzzq0Xs1wpYHysUH5LlopdAZTuo3SMG49NTyibWf92VPPVKwUkE
 FmC+QqvJ3VJq2HICbfLuwX3VF55LrC11AdiIwF84pIEEwgei3IKei2ra31sEsS1SHj1Wm3rO6AX
 y2T8c7ACoL6LLxGNHcwZzNtOWHIp6GD602g1VnQ==
X-Google-Smtp-Source: AGHT+IGFhEU9ifTXSLf07485ZBhqpzwW/dxZkOoVgfQxlFp942rpgd3SApAW44R78jcad4gQFGrYuxlKtBiH7GLnKMQ=
X-Received: by 2002:a05:6a20:7343:b0:1a1:3515:7006 with SMTP id
 v3-20020a056a20734300b001a135157006mr4819695pzc.31.1709715791417; Wed, 06 Mar
 2024 01:03:11 -0800 (PST)
MIME-Version: 1.0
From: yb liu <liuyb845@gmail.com>
Date: Wed, 6 Mar 2024 17:02:59 +0800
Message-ID: <CAKstcpWLhcNswkippmDyQQz2bPKSN+w9F0jZzcZRGpuNWvW55g@mail.gmail.com>
Subject: QEMU Compatibility for Cortex-A55 AArch32 Firmware
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006a1dc10612fa3aa9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=liuyb845@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 09:33:24 -0500
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

--0000000000006a1dc10612fa3aa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear QEMU developers

I hope this email finds you well. We are currently facing an issue related
to QEMU and the Cortex-A55 architecture. Specifically, we have compiled a
firmware for Cortex-A55 and would like it to run smoothly on QEMU A55 in
AArch32 mode.

Despite our numerous attempts, we continue to encounter an "undefined
instruction" error when running the firmware in QEMU. Our question is
whether QEMU supports this particular use case=E2=80=94specifically, whethe=
r it can
handle A55 running AArch32 firmware.

Any insights or guidance you can provide would be greatly appreciated.
Thank you for your assistance.

Best regards,
Eric Lau

--0000000000006a1dc10612fa3aa9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Dear QEMU d=
evelopers</div><div dir=3D"auto"><br></div><div dir=3D"auto">I hope this em=
ail finds you well. We are currently facing an issue related to QEMU and th=
e Cortex-A55 architecture. Specifically, we have compiled a firmware for Co=
rtex-A55 and would like it to run smoothly on QEMU A55 in AArch32 mode.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Despite our numerous attemp=
ts, we continue to encounter an &quot;undefined instruction&quot; error whe=
n running the firmware in QEMU. Our question is whether QEMU supports this =
particular use case=E2=80=94specifically, whether it can handle A55 running=
 AArch32 firmware.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Any i=
nsights or guidance you can provide would be greatly appreciated. Thank you=
 for your assistance.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Be=
st regards,</div><div dir=3D"auto">Eric Lau</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><br></div></div>

--0000000000006a1dc10612fa3aa9--

