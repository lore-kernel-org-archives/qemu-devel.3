Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBABC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHl2-0004qf-WD; Thu, 20 Jun 2024 09:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKD9e-0002FF-O8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:28:26 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sKD9c-00059l-8s
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:28:25 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6fbe639a76so99632566b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718872102; x=1719476902; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HVY7kz4o5AJEzQoHDnGHl7B3DMBernvumRCFXI7Sb6I=;
 b=Wyh2/esZwV/D08qqDHcZWsFWPrxW6Z2/sEL01Zmrm2I/smnWIiWGhQvM5SksWzutlC
 JhIJ2yEDG/fiXTCIw/8ulLiytZ67oH+RG9Ag1Qhvf8/J5Glm2Z8B5olXlWiW39K8fC+a
 md7q10cEZmwzXbP3WoOBG2ZJho7CdSDfWZlAX6V/OdFK6gryw/Vl4oG9hIVDKAFovnk6
 DdoHMlZ+rlhBsK+T/tQdpeF3tuEzZKo1qruF2qMDkcwqInN7N+wVKz/Slo27vJ3VCuu5
 06WMrYyDpTzlE2x1O6aC9+pwefAn84AdagVWUUwSMY2eybCT7Z+gtEtYV89yGsS8jQIE
 ig1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718872102; x=1719476902;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HVY7kz4o5AJEzQoHDnGHl7B3DMBernvumRCFXI7Sb6I=;
 b=qf1I4j5YiskDsfl96cdqGCImwmE+THc4w5qS9NIeXw4bpGDUBGwv6wpIvGCOhvVvIY
 zwblk/4a68qlySZwsOWN2u70vd5q8lD4enNdKPcfiWGZJhxNB/SZiKOkjD6auDjusrbX
 bMsH6hxxts8ih0wsR96ajXMMrU6E6+ms4sujqkLiN3c6skmhpt7ztgPS6heWv+UDDb3W
 W/njayUfyjpsOJx70J0ZJ+lXUhrWAqZmd2DnFC5DHMEc3sPUTCP5lu/GNoA1EymAEuJw
 m92XODMxK6Y4iEVwTdXzQ3lFhPk/tJQu4MliGNrW/uhbae2CvNHq9ei5cOahzW2U01vb
 W9vQ==
X-Gm-Message-State: AOJu0YzQHBKWKFdceu66MQjgc3qdp8HDUD2A3A2V0CW0qCqwTGapd/0+
 6mZfW3d2nnodQpLHPICt7I6HeXVu2PhFvbmn2fBsc2JGqSRSftJCHCFYCu/EKZPMqxWAWKUmV6s
 UTUTxfdiQ7e10D1zIfDYE6x+GG1jrh7d8
X-Google-Smtp-Source: AGHT+IFQmXnIWjljxAynXr0wPcDSltNljLas0c9fop5KhOe8oxM3oKHhp2XCotKhR4qb2ab76KVTUxhE4JPqO0Fy9ko=
X-Received: by 2002:a17:906:144f:b0:a6f:935b:8777 with SMTP id
 a640c23a62f3a-a6f9506f561mr470208166b.25.1718872101709; Thu, 20 Jun 2024
 01:28:21 -0700 (PDT)
MIME-Version: 1.0
From: Arthur Tumanyan <arthurtumanyan@gmail.com>
Date: Thu, 20 Jun 2024 12:28:10 +0400
Message-ID: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
Subject: How to use designware-root-port and designware-root-host devices ?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000096d51061b4e19ed"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=arthurtumanyan@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Jun 2024 09:23:14 -0400
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

--000000000000096d51061b4e19ed
Content-Type: text/plain; charset="UTF-8"

Hi all,

My question may sound stupid, however... Currently I'm trying to make
available designware-root-{port,host} devices  in linux when I run it in
qemu.

I try the following way to run:

qemu-system-arm -M virt -m 2G \
     -kernel images/Image \
     -append "rootwait root=/dev/vda ro" \
     -drive file=images/rootfs.ext2,format=raw,id=hd0 \
     -device designware-root-port,id=rp0,chassis=1,slot=0,bus=pcie.0,addr=1
\
     -device e1000,netdev=net0,mac=52:54:00:12:34:56,bus=rp0,addr=0 \
     -netdev user,id=net0

but it seems designware device is not enabled by default: qemu-system-arm:
-device designware-root-port,id=rp0,chassis=1,slot=0,bus=pcie.0,addr=1:
'designware-root-port' is not a valid device model name

when I enable it from Kconfig/meson.build it says the device is already
registered and exits with abort().

From the other hand the device is declared as non pluggable: dc->user_creatable
= false;

Can you please help me to use designware-root-host/port devices ?

Thanks in advance,
Arthur

--000000000000096d51061b4e19ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>My question may sound stupid, h=
owever... Currently I&#39;m trying to make available=C2=A0designware-root-{=
port,host} devices=C2=A0 in linux when I run it in qemu.=C2=A0</div><div><b=
r></div><div>I try the following way to run:=C2=A0</div><div><br></div><div=
>qemu-system-arm -M virt -m 2G \<br>=C2=A0 =C2=A0 =C2=A0-kernel images/Imag=
e \<br>=C2=A0 =C2=A0 =C2=A0-append &quot;rootwait root=3D/dev/vda ro&quot; =
\<br>=C2=A0 =C2=A0 =C2=A0-drive file=3Dimages/rootfs.ext2,format=3Draw,id=
=3Dhd0 \<br>=C2=A0 =C2=A0 =C2=A0-device designware-root-port,id=3Drp0,chass=
is=3D1,slot=3D0,bus=3Dpcie.0,addr=3D1 \<br>=C2=A0 =C2=A0 =C2=A0-device e100=
0,netdev=3Dnet0,mac=3D52:54:00:12:34:56,bus=3Drp0,addr=3D0 \<br>=C2=A0 =C2=
=A0 =C2=A0-netdev user,id=3Dnet0<br></div><div><br></div><div>but it seems =
designware device is not enabled by default:=C2=A0qemu-system-arm: -device =
designware-root-port,id=3Drp0,chassis=3D1,slot=3D0,bus=3Dpcie.0,addr=3D1: &=
#39;designware-root-port&#39; is not a valid device model name</div><div><b=
r></div><div>when I enable it from Kconfig/meson.build it says the device i=
s already registered and exits with abort().=C2=A0</div><div><br></div><div=
>From the other hand the device is declared as non pluggable:=C2=A0<span st=
yle=3D"font-family:&quot;JetBrains Mono&quot;,monospace;font-size:10.5pt;co=
lor:rgb(0,0,0)">dc</span><span style=3D"font-family:&quot;JetBrains Mono&qu=
ot;,monospace;font-size:10.5pt;color:rgb(8,8,8)">-&gt;</span><span style=3D=
"font-family:&quot;JetBrains Mono&quot;,monospace;font-size:10.5pt;color:rg=
b(102,14,122)">user_creatable </span><span style=3D"font-family:&quot;JetBr=
ains Mono&quot;,monospace;font-size:10.5pt;color:rgb(8,8,8)">=3D </span><sp=
an style=3D"font-family:&quot;JetBrains Mono&quot;,monospace;font-size:10.5=
pt;color:rgb(0,51,179)">false</span><span style=3D"font-family:&quot;JetBra=
ins Mono&quot;,monospace;font-size:10.5pt;color:rgb(8,8,8)">;</span></div><=
div><span style=3D"font-family:&quot;JetBrains Mono&quot;,monospace;font-si=
ze:10.5pt;color:rgb(8,8,8)"><br></span></div><div>Can you please help me to=
 use designware-root-host/port devices ?</div><div><br></div><div>Thanks in=
 advance,</div><div>Arthur</div><div><br></div></div>

--000000000000096d51061b4e19ed--

