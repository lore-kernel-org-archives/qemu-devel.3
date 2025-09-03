Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2403DCA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjnP-0007wq-Hg; Wed, 03 Sep 2025 05:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysf.kya34@gmail.com>)
 id 1utjnO-0007wb-2p
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:28:50 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ysf.kya34@gmail.com>)
 id 1utjnM-0006XW-14
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 05:28:49 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5607c2f1598so2723976e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756891724; x=1757496524; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LICDs7KnPkE2Fr+5AoSGw8r8AKcmZviS+ge2JF/hxdE=;
 b=LaT5BykIQtAYqimhNalhT/rYZyfuD4xxRct6o9XHW20vfVuRLn7rmsfBeCkJuoBAsd
 f9DbD6GwW4T+Jf4HZ8m6PgDJydXyfj2SBbyahC7bj3egQyWKWCvpoPUI03v0rdHvJ3+Y
 keoYv+EjbBqsmUQVvMR27uoxtsgn/WXNGNhN+ButWCTnHdsmMKV5TopWo0Zj/W0SI0UP
 k3ssCn25NjWbACF2QJPzz2ze+FcTtCd7pTRAqI76mZD+bbi9KHS9EXXflv5pwX7sgtHB
 mv0oa/cmLDaJ5PLxY6k6J3Q7U6At5Jtd+lDrgEn3MV+yIdnrPTsoJYsYBXPw8qGeKQk8
 ad0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756891724; x=1757496524;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LICDs7KnPkE2Fr+5AoSGw8r8AKcmZviS+ge2JF/hxdE=;
 b=PV4PguyeXVlxTFSNPjudYLpAjrl4EU2nJLfrAXQPk/BSI367j+E2YRqrUoSo6q+Umb
 dVG2hy29HxktgpVLO6/AanTlF5T74SKGekHwS2bN8NMklgouUSsP45RKiz4lz8aBj566
 WlqkA9F+dAtUAFCpZxeWMU2N3EmO1M6j75WwHXdhGvGE8AKBxvKGEa/OP/Y/Rl7l//f3
 1Zuas6qYD7ERKzmgHQNBiNj2l8g58VJbiwOWpfRJ7cxaP4s4PaCfp2/L5eTH/N9J3NDR
 7XnTWTRjNw/uB/UcYWOyUSGHURurRb0Xb2mEaE9kFIbqtihIaA0OrNyPtbSurLBbmquX
 4pGQ==
X-Gm-Message-State: AOJu0Yy0OcrsktriGcgrkW9rgHhWFSuF9jGrZEEqoIRLhacZwGSms42V
 EtVLx6+iCPe6eB1Y30Dvbzng8LeIwKW1uVJawiKrzJWXVk4oy5v++/xavhO/3X80VgHbnKclQvi
 irYosjf8lwhWviLJPjqwcJWwf87xLZFxiMg==
X-Gm-Gg: ASbGnctnl35FKZX+XewKyRHSnJ8kuIBCgqvpFETJCasFF80lQvznim+Vvp10s1UnHYv
 TJArJzDij22bxUW3vF1x0KS3JOCrsKk+yZOoWQHzIrFv2+7lt7LrqYUlWlZ6YpB1fZsrqxW8vNn
 RqEgpUl64UnNECDfKECsG2bzWwrwc1lyk1DbUsxas0z8eXmJpQfskznZWqbLRLVraBXwJd0Sfyt
 2qVIs5m0oWtju7w6MhuUVGDwL3O9bxFISB3IfJxvoFl91P9Og==
X-Google-Smtp-Source: AGHT+IGOsyU50jwHVcRtTYW/aWAJRtVrGvYKEdzvz9QFl1OJghClDyYgEStGgeeZPkYpTqntH2E3eM1O2vWvvGFjOA0=
X-Received: by 2002:a05:6512:639a:20b0:560:8b56:5dc6 with SMTP id
 2adb3069b0e04-5608b565f03mr376701e87.19.1756891724027; Wed, 03 Sep 2025
 02:28:44 -0700 (PDT)
MIME-Version: 1.0
From: Yusuf Kaya <ysf.kya34@gmail.com>
Date: Wed, 3 Sep 2025 12:28:32 +0300
X-Gm-Features: Ac12FXyfepmnTdaYS3gsi4NgceqUaa3XT_-AlELVkB3A4sJ0kUqEd3V3xd8r9bE
Message-ID: <CAHd9c1rBcf5SZFYQ2z0E86pmo9NPDTC7ScLMLzfg2yETz1whpQ@mail.gmail.com>
Subject: [Question] Interest in IFC modeling or missing parts for T1042 SoC?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001e9aed063de23b2a"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=ysf.kya34@gmail.com; helo=mail-lf1-x130.google.com
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

--0000000000001e9aed063de23b2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi QEMU developers,

I have experience with the T1042 SoC and I=E2=80=99d like to contribute to =
the QEMU
community. I couldn=E2=80=99t find any existing model of the IFC (Integrate=
d Flash
Controller). At first, I assumed it might be missing, but later I thought
it could have been intentionally left out. However, I=E2=80=99m not sure.

So I=E2=80=99d like to ask: is there any interest or need in the community =
for
modeling IFC? Perhaps since QEMU mostly targets systems at the OS level,
early hardware bring-up stages (like IFC behavior or RCW loading) were
intentionally not included.

Also, if there=E2=80=99s anything else that you think is currently missing =
or
incomplete specifically regarding the T1042 SoC, I=E2=80=99d be happy to he=
ar your
thoughts.

Thank you,
Yusuf Kaya.

--0000000000001e9aed063de23b2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi QEMU developers,<br><br>I have experience with the T10=
42 SoC and I=E2=80=99d like to contribute to the QEMU community. I couldn=
=E2=80=99t find any existing model of the IFC (Integrated Flash Controller)=
. At first, I assumed it might be missing, but later I thought it could hav=
e been intentionally left out. However, I=E2=80=99m not sure.<br><br>So I=
=E2=80=99d like to ask: is there any interest or need in the community for =
modeling IFC? Perhaps since QEMU mostly targets systems at the OS level, ea=
rly hardware bring-up stages (like IFC behavior or RCW loading) were intent=
ionally not included.<br><br>Also, if there=E2=80=99s anything else that yo=
u think is currently missing or incomplete specifically regarding the T1042=
 SoC, I=E2=80=99d be happy to hear your thoughts.<br><br>Thank you,  <br>Yu=
suf Kaya.</div>

--0000000000001e9aed063de23b2a--

