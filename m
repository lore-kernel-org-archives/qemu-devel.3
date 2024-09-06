Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E9CE7B04
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 01:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smjyn-0001vG-21; Fri, 06 Sep 2024 21:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1smirj-0008JX-LO
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 19:59:49 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kennethadammiller@gmail.com>)
 id 1smird-0002Fr-Hx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 19:59:44 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so22739821fa.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725667172; x=1726271972; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FwisAysJi+CBFxFHWNk+FgNN5eCdLrXwQGcO6PlI9CY=;
 b=asF8QoWPT9r2b4+44HxPZyUL39a8l3zdBEFm4MOMUffO4nynMG/GhHkJrmtRHw9wcm
 q9Rp27tOjbM2bq2P5AUpRnku1jF9pW8kNYJyOxCTNs/yLlFSqxBaojmVP+zzgYWDf8E1
 H/ed2ZMjImP23cy/nRv4qDmAVLsVlFA0pOHHr1AmDAObxmoPm1qOR32N025JBienzut0
 dF88qNWpXhHsfLJNwVsV/FHxRVuVaUFCICcgsBDE9AEiqlPzcCryJ0QopWFkKBPm796i
 l930XUEO5pbvL29xCg7rB2b8zxnqkA5XM0OPtoyTD+Q5PUOTnZTs7cMKwTvk54OJV4ht
 2L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725667172; x=1726271972;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FwisAysJi+CBFxFHWNk+FgNN5eCdLrXwQGcO6PlI9CY=;
 b=D4Ne4QcTvbEPF9YN/Ro656rH9fMjCdoJl7iwM35eE8mvNM4UbExzJywAMP7P2BrpE9
 /Q/i069BTAT1wPDYUJcZvFus7GPQ/xWVTNfIV9mKvwkNfmd1CDZC5e4e40ByOGjfnU2m
 jMFYcJWBWLRKI3cxNWyOpXwPmpPa6Dba6fJFJLLL0fIS81yUJCa0qXboyJUtq8XiVoPj
 1NcK9NFKbN6e6epvSuPLyqB2nkwWeiDvffN4DWEyYKmhRnPer9dG3Fj/KLFCISkuk6Aj
 EDF2OW9cz4/L9XlkvNUnlgTHt5rEUToS/AXTzNPKfgeMrP7wNzrxkoFMapsrFF+xZBFA
 kYDg==
X-Gm-Message-State: AOJu0YwaWTOgYe8faQo5y3jRjKdCqOQq2dQ5DGyOU6v7IMamUBH4tPNr
 8vGLkZqkm0W4diaGIepdiC9E6xTo2zLZHF5qKgIo0noF3DYJbiiLYmLYS5XCNLrnX0M++obSB14
 TC5s5HAVGVXzY377f/0hsZ/Hji4g/rzNr
X-Google-Smtp-Source: AGHT+IE0ttRgbzsH37AnW1bi2QrZjx7nqYxzOIw5BzXJS53Lx5eNEGXIUsqhCsJMV60cx7QTbBpeHlwnSco626K31Oo=
X-Received: by 2002:a2e:b8c7:0:b0:2f7:4fac:f695 with SMTP id
 38308e7fff4ca-2f75230c835mr34575101fa.14.1725667172075; Fri, 06 Sep 2024
 16:59:32 -0700 (PDT)
MIME-Version: 1.0
From: Kenneth Adam Miller <kennethadammiller@gmail.com>
Date: Fri, 6 Sep 2024 17:59:21 -0600
Message-ID: <CAK7rcp8YkeRisKBTfV0nenk6WvsG2Vwsqnm+=B=KD6rHuSqfog@mail.gmail.com>
Subject: Build failure due to xen
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000cad1d006217c32c0"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=kennethadammiller@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Sep 2024 21:09:55 -0400
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

--000000000000cad1d006217c32c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm on commit bd80b59 and my host is:
$lsb_release -s
...
Description: Pop!_OS 20.04 LTS
Release: 20.04In file included from
...

I get a compile error:

...
/home/kennethadammiller/workspace/vm_escape/qemu/include/hw/xen/xen_backend=
.h:4,
                 from
/home/kennethadammiller/workspace/vm_escape/qemu/hw/block/xen_disk.c:39:
/home/kennethadammiller/workspace/vm_escape/qemu/include/hw/xen/xen_common.=
h:111:9:
error: unknown type name =E2=80=98xc_evtchn=E2=80=99
  111 | typedef xc_evtchn *XenEvtchn;
      |         ^~~~~~~~~
/home/kennethadammiller/workspace/vm_escape/qemu/include/hw/xen/xen_common.=
h:112:9:
error: unknown type name =E2=80=98xc_gnttab=E2=80=99
  112 | typedef xc_gnttab *XenGnttab;
      |         ^~~~~~~~~
...

I don't know what to do to make sure this builds.

--000000000000cad1d006217c32c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I&#39;m on commit=C2=
=A0bd80b59 and my host is:=C2=A0=C2=A0</div><div>$lsb_release -s=C2=A0</div=
><div>...</div><div>Description:	Pop!_OS 20.04 LTS</div>Release:	20.04In fi=
le included from=C2=A0<div>...</div><div><br></div><div>I get a compile err=
or:</div><div><br></div><div>...</div><div>/home/kennethadammiller/workspac=
e/vm_escape/qemu/include/hw/xen/xen_backend.h:4,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /home/kennethadammiller/works=
pace/vm_escape/qemu/hw/block/xen_disk.c:39:<br>/home/kennethadammiller/work=
space/vm_escape/qemu/include/hw/xen/xen_common.h:111:9: error: unknown type=
 name =E2=80=98xc_evtchn=E2=80=99<br>=C2=A0 111 | typedef xc_evtchn *XenEvt=
chn;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>/ho=
me/kennethadammiller/workspace/vm_escape/qemu/include/hw/xen/xen_common.h:1=
12:9: error: unknown type name =E2=80=98xc_gnttab=E2=80=99<br>=C2=A0 112 | =
typedef xc_gnttab *XenGnttab;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~<br></div><div>...</div><div><br></div><div>I don&#39;t=
 know what to do to make sure this builds.</div></div>

--000000000000cad1d006217c32c0--

