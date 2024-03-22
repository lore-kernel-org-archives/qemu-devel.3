Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3F2C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 21:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnmUb-0004tT-Hj; Fri, 22 Mar 2024 17:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thenetherhack@gmail.com>)
 id 1rnkke-0007Cz-6P
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:40:28 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thenetherhack@gmail.com>)
 id 1rnkkc-0005MM-PI
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:40:27 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dcbcea9c261so2695972276.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711136425; x=1711741225; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tTtSitcoE32wXynKMxI7LEQf+sMQhIAqajaLdxCbdHc=;
 b=jIK8EY5bs37i6eek/cCaKZBIwO9NKWlwTZQLuu7+2ss7D9Udk6ZUSRsws+Hd/rvklu
 uEcX1IzRQWZHAmD+O4gU866hpzIAtLoHz9Uf5HsUAbnmUAkvVQ2ZvX3ClRpZgM5hPfFK
 xAwRIysm5pzSMcrSdeaoVbw8fJnsugIZLIr2MLf7N3dmkCzBUxxDiuwvstzElxUpeBWM
 peyJM69uhVLgRmYy64koIAg7NFJsfvaWDZXLMLE6BP/gOm7ArVHFM9NDjpuOmpenG/q/
 s8s4WfvIFnFhjYP6jnvN2yrPcn8n+4RNz79zOT3b77YQLSMhOLhhiPTqt/lvm+P2gMEU
 sGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711136425; x=1711741225;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTtSitcoE32wXynKMxI7LEQf+sMQhIAqajaLdxCbdHc=;
 b=KMC08szj6TtQWJOsazy7AIWl70WG6DMfHrbxdaELujSZxgbq3E5NFjbcrcMSPD3X5Y
 CclH8sgBEkapIqvOKdEojiA6SpyAZsTc40xVbJKP+ScmX7Nm1Eg1sNmIYvLeIhIta6wo
 D9fAQFO56xE3/7+Nlm95Yl0y/Ey7uYyt4YxfjC6Q1yR+ARRDBXZaxaJ0QnzweXORgbaK
 icUgtuH5VgSGq2jHWE6vcZwmfHQdbDlQDKutUI/QPXYxnvH1iu2+UsFMef1WxpvWGK10
 hY5TcUMdtb+KGpKpW4t5802PLyyvAWKPFAXIl7lo8PBLcnvhNhQN160WMm/wZGb5l80f
 46IQ==
X-Gm-Message-State: AOJu0YyvYiiPrXaqKp0Qyd9/DWqjulGIi/pZoSxSN++cmkpVTWE9VDs5
 mvHVYBAl5UFgCs1Vyb9XT8TmRvTyaubxsq2PGqFwSiQqhrbd3B5uig1mDzB4bFp3F+H2FZ3FLyz
 83xrJHy7RpLK855rm0dk2gr6vKdh2TO3aRH7ivQ==
X-Google-Smtp-Source: AGHT+IFec/YEhxHxD+veczL1mUwFvzoh5j4EQTGph2GAbk9ta49Sjk9IH7ORGxtH7GhUz2hnLyD4pr1j3vUcT9xUmSQ=
X-Received: by 2002:a25:9d91:0:b0:dcd:df0:e672 with SMTP id
 v17-20020a259d91000000b00dcd0df0e672mr336876ybp.47.1711136425290; Fri, 22 Mar
 2024 12:40:25 -0700 (PDT)
MIME-Version: 1.0
From: Mister Nether <thenetherhack@gmail.com>
Date: Fri, 22 Mar 2024 20:40:12 +0100
Message-ID: <CAO4tOPJg-tAGY6b+252UguZDMmPhP5ojLjaToijy8Qkb2n=sww@mail.gmail.com>
Subject: CommandNotFound on QMP Protocol
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cac046061444fe65"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=thenetherhack@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Mar 2024 17:31:59 -0400
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

--000000000000cac046061444fe65
Content-Type: text/plain; charset="UTF-8"

Hi. I am trying to take advantage of QMP and automatically collect some
data about vms. I found a nice list of qmp commands.
I tried to use them, but many of them just sont seem to work. For example

Request: { "execute": "guest-get-cpustats" }
Response: {"error": {"class": "CommandNotFound", "desc": "The command
guest-get-cpustats has not been found"}}

or

Request: { "execute": "query-memory-devices" }
Response: {"return": []}

Even though the vm is running totally fine and it should return at least
some kind of memory information. I tried to compile the latest version
myselft, but it didnt work either. Pls help!

Version/Build info:
(Standart Debian 12 repo lts version)

qemu-system-x86_64 -version
QEMU emulator version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

{"QMP": {"version": {"qemu": {"micro": 9, "minor": 2, "major": 7},
"package": "Debian 1:7.2+dfsg-7+deb12u5"}, "capabilities": ["oob"]}}


Thx in advice!

--000000000000cac046061444fe65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi. I am trying to take advantage of QMP and automatically=
 collect some data about vms. I found a nice list of qmp commands.<div>I tr=
ied to use them, but many of them just sont seem to work. For example<br><b=
r>Request: { &quot;execute&quot;: &quot;guest-get-cpustats&quot; }<br>Respo=
nse: {&quot;error&quot;: {&quot;class&quot;: &quot;CommandNotFound&quot;, &=
quot;desc&quot;: &quot;The command guest-get-cpustats has not been found&qu=
ot;}}<br><br>or<br><br>Request: { &quot;execute&quot;: &quot;query-memory-d=
evices&quot; }<br>Response: {&quot;return&quot;: []}<br><br>Even though the=
 vm is running totally fine and it should return at least some kind of memo=
ry information. I tried to compile the latest version myselft, but it didnt=
 work either. Pls help!<br><br>Version/Build info:<div>(Standart Debian 12 =
repo lts version)<br><br>qemu-system-x86_64 -version<br>QEMU emulator versi=
on 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)<br>Copyright (c) 2003-2022 Fabrice B=
ellard and the QEMU Project developers<br><br>{&quot;QMP&quot;: {&quot;vers=
ion&quot;: {&quot;qemu&quot;: {&quot;micro&quot;: 9, &quot;minor&quot;: 2, =
&quot;major&quot;: 7}, &quot;package&quot;: &quot;Debian 1:7.2+dfsg-7+deb12=
u5&quot;}, &quot;capabilities&quot;: [&quot;oob&quot;]}}<br><br><br>Thx in =
advice!<br></div></div></div>

--000000000000cac046061444fe65--

