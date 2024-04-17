Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC7AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 06:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwye1-0006JF-UJ; Wed, 17 Apr 2024 02:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rwye0-0006IR-Ec
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:19:44 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rwydy-0002gQ-OR
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:19:44 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso6603680e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 23:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713334779; x=1713939579; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i5IxVdBkOpL60OxMR9ngXkhh8mZjNRfWDHGThY70twc=;
 b=gAuKhoJWrJ1HL8AY+T7MTjzsfH2meUbDXOtDPfu5A/S3DXafwi3WpuB+n9C2Dx7Qgn
 mfFaIPF8Xz2FkRIDAdR5Lx6KT/4cjGkcyCVoF03yjFoaOQVLNJqae/AwNxbK7nqOHweV
 iJIuZCaVqRnKlgUgXx4WPS2/LcHiyNmUFMtmQcFz5fesr2pQRq7IFrjI2sRSzTwqjOtt
 EebOWMioy5K17qy/VdhvekJZw/TuL1+Pf+WE4Q3ZRb0gvOzCLOM44sZau78VEqGc4C/F
 WVdSiPmttmNC0cFczvmb9z/wwKLy7yru6J/9YRvitpoYfE2jW3KV2SHk1kXsZa5g0kYJ
 piLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713334779; x=1713939579;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i5IxVdBkOpL60OxMR9ngXkhh8mZjNRfWDHGThY70twc=;
 b=HIJMHppA9N1reZ7+Of308VQKJuukTYwYETvWOxqz6pKBnzPM1Z6L3jWhXOsYq0C+U6
 8kT7olhOrYkRz58azdI3UAFbOmG1jNOpoCzaYyPhAWf59mKHNAw1PUOjGvRlrj82EWBu
 BqTaqzluDgsW/5aIxbN3FfZAkWd8fhCN8kVZjl82l67CKppa5W6J45jRh4O0tMv4IsdD
 DAAaS6GOzvy7rZ8M0d9TwN/QoVTySnVCSuVZpNnTndTZ0XjAdFiB/eoIPnP/dQo1+LBg
 jqFv6nUeh7+EWDkmqoqVCaAL6yxaN8Kn3QvqzIbn4/4JI4EmyGc9OOeGH726NrxR6NyQ
 Ttrg==
X-Gm-Message-State: AOJu0Ywm9QXJDGNElM+I7yzN0D9pTKAH0TEUwdOy5zNRP0M0GdPjxjsB
 gEiNhrazNHrW3ufJO8MIwyrvIKhD6pA5+MicAvJzCgFpcsrZsooyNCvIpvrl4O2Nu+9jQT84c5a
 +iNQ7mj1R4GKubjlVZ0W0+bLcWBSBLe8wcTE=
X-Google-Smtp-Source: AGHT+IGyrbvLATxa1ubG9ON4GBp6Xh+Ch58z2CsJal/NlRx7Y5ow3yl5m6SO09N/xgRjWS66S+zM9ht8zWdBTG/fnVA=
X-Received: by 2002:a05:6512:3b9d:b0:518:8fd9:7a55 with SMTP id
 g29-20020a0565123b9d00b005188fd97a55mr15007403lfv.35.1713334779441; Tue, 16
 Apr 2024 23:19:39 -0700 (PDT)
MIME-Version: 1.0
From: Junho <junho920219@gmail.com>
Date: Wed, 17 Apr 2024 15:19:28 +0900
Message-ID: <CACrrvNQqHxxSmT85oKW6bM7cP1GyDucp68217KpqCiQysMjOxQ@mail.gmail.com>
Subject: Questions about calculation of executed icount
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e8fb50061644d6dd"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=junho920219@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000e8fb50061644d6dd
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm a QEMU user and would like to ask you a question.
I see that, in QEMU code, the current number of executed instructions is
calculated by:
cpu->icount_budget - (cpu->icount_decr.u16.low + cpu->icount_extra);

Can I know how this calculation can be the number of executed instructions?
What makes cpu->icount_decr.u16.low change and when it does?
It seems that the decrementer is eventually updated to insns_left every TB
exec, but I would like to know how the entire calculation works to do so.

I'm looking forward to hearing from you.
Thank you

Best regards,
Junho

--000000000000e8fb50061644d6dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hello,</div><div><b=
r></div><div>I&#39;m a QEMU user and would like to ask you a question.</div=
><div>I see that, in QEMU code, the current number of executed instructions=
 is calculated by:</div><div dir=3D"ltr">cpu-&gt;icount_budget - (cpu-&gt;i=
count_decr.u16.low + cpu-&gt;icount_extra);<br></div><div dir=3D"ltr"><br><=
/div><div>Can I know how this calculation can be the number of executed ins=
tructions?=C2=A0</div><div>What makes cpu-&gt;icount_decr.u16.low change an=
d when it does?</div><div>It seems that the decrementer is eventually updat=
ed to insns_left every TB exec, but I would like to know how the entire cal=
culation=C2=A0works to do so.</div><div><br></div><div>I&#39;m looking forw=
ard to hearing from you.</div><div>Thank you</div><div><br></div><div>Best =
regards,</div><div>Junho</div><div><br></div></div></div></div>

--000000000000e8fb50061644d6dd--

