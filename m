Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE48CC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 13:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbgPt-0003h7-Se; Sat, 25 Jan 2025 08:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.phone1122@gmail.com>)
 id 1tbbN4-0005Wg-GB
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 03:18:26 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <john.phone1122@gmail.com>)
 id 1tbbN3-000789-1c
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 03:18:26 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216634dd574so35245455ad.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737793102; x=1738397902; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DDEiopxlqyugb+kGNF+VwgWDeHHvy7eMNlkZRhRFcyY=;
 b=kQZygDpG+KF4tZXygpDvCHIBFqR0gTbsVJSUynwG3JGE6GsP+LsX9pYW/BEmvVb+pw
 Gy1osjTlfjvaNF2tXf1+C4KNj8U7Go4RAa0lnY2ZGnWI6temzKFayHXrAtrK83YJxL/j
 WX3mswR0t+YImYuX1ETLOtlXicKZZCj791+7lE50FidFxXyJYvzpzqJy8B6EjWmaUQf9
 TUyplPXSXtn8cdXVzW+jQJUgFXmROlq79GMDIA7WBIZzmSHNeWDnqq2TGYf2gZTr9Ghw
 z3Ne9m0ylhLi3eIQAOxmMkjXKOl5qAKr1Nmg+ydCtQltz86lKidvZ8LhcRhKGRUD5ENa
 Cj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737793102; x=1738397902;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDEiopxlqyugb+kGNF+VwgWDeHHvy7eMNlkZRhRFcyY=;
 b=okdrcbNjga175KqSNAM66DJMdAA9Kvx6TafVXv2YxcWURavURwm6jW8/F8FBKuz72c
 gPBHQAWN37P0DZ1FhicPO1uwAIGPiotfBUCMcaMKAG3i5KzuiFbJVpvhD6BljuYCRgnm
 5dP1rfEaqFgySsIDlmXBQMQmzh+A4T+axcoslskRg+VIDZArXW5ZMUHSp1715TXnErF4
 OBeR8XDYtHY4eGjTNhdWUrWzqMTElQaSip/SYNsbrBpI/QWylTOtwLn41llFhTPlyadg
 lKDRJdFZPHcJisddI9NWTTEA3CVo1F937IWNyyVA5lIucoDqivVxKb1eMSzfdhCRShnv
 2GLw==
X-Gm-Message-State: AOJu0Yz2bjTHJzOVhJTkwYyqQDt5Kix0XAaO2VNKLZjHl2ZPxbzr5OgN
 sMz8kzrd+8fAavg+YfrLzG31S7yNDCqAva7GDqGnKa2MKG03pUsvtmSlpuMzQcSwOf+0+Ch0tQd
 8KrgZBtv682Il6XgTzIPSI3x6fWUxOlQm
X-Gm-Gg: ASbGncvjC4awLjvFUmvKDn5RmR6Eu47T6Q1F2pXjhdhfbHgmeSK7pSZOUqvWrgu4arT
 p8Hhf9TAgOhmjkzNQQ9giRKpzONj4RftrWxJCunfMCFKHmwZ+Yj+SLMq9a9R6uKbuP0KTfeehMF
 uNqC6McpAaiY9J6s/aAw==
X-Google-Smtp-Source: AGHT+IFQgNcGcXcrKDAzEODPvQuZ37BkmMTC+cGtlsvXGWgrC581j/IlVBeeVrUIcH7SF91kSnEwqL4z/YmcXvWTyVM=
X-Received: by 2002:a17:902:dacb:b0:215:5ea2:6543 with SMTP id
 d9443c01a7336-21c35546dcbmr533679965ad.28.1737793102426; Sat, 25 Jan 2025
 00:18:22 -0800 (PST)
MIME-Version: 1.0
From: John Phone <john.phone1122@gmail.com>
Date: Sat, 25 Jan 2025 03:18:11 -0500
X-Gm-Features: AWEUYZmB9pKqPbXmR_Jj0dHGe6ZxtfVQtkOuY54_DDpqz0nLlVekUppFccbh6BY
Message-ID: <CAOOLYF=e+u_+h=dAWz3ZRXdxJM-093C-JRCp596RdNm6L4n=7Q@mail.gmail.com>
Subject: Problem booting windows 11: "tpm_passthrough: Could not guess TPM
 cancel path"
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000090383c062c837c5d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=john.phone1122@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Jan 2025 08:41:39 -0500
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

--00000000000090383c062c837c5d
Content-Type: text/plain; charset="UTF-8"

Hi I have a problem trying to boot Windows 11 using Qemu.

When I try to start qemu booting Windows 11 I get the error,
"tpm_passthrough: Could not guess TPM cancel path"

qemu-system-x86_64 -enable-kvm -boot d -cdrom
/home/mydrive/Downloads/Win11_24H2_EnglishInternational_x64.iso \
-tpmdev passthrough,id=tpm0,path=/dev/tpm0 -device
tpm-tis,tpmdev=tpm0,cancel-path=/dev/null=on \
-m 4G -smp 4 -hda windows11_100G_jan242025.qcow2

I also tried "cancel-path=/tmp/foo-cancel"
Also changed permissions in /dev/tpm0 to 777.


qemu-system-x86_64 --version
QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.4)
Using Xubuntu 24 Lts.

Thanks

--00000000000090383c062c837c5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hi I have a problem trying to boot Windows 11 using Qe=
mu.<br><br>When I try to start qemu booting Windows 11 I get the error, &qu=
ot;tpm_passthrough: Could not guess TPM cancel path&quot;<br><br>qemu-syste=
m-x86_64 -enable-kvm -boot d -cdrom /home/mydrive/Downloads/Win11_24H2_Engl=
ishInternational_x64.iso \<br>-tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm=
0 -device tpm-tis,tpmdev=3Dtpm0,cancel-path=3D/dev/null=3Don \<br>-m 4G -sm=
p 4 -hda windows11_100G_jan242025.qcow2 <br><br>I also tried &quot;cancel-p=
ath=3D/tmp/foo-cancel&quot;<br>Also changed permissions in /dev/tpm0 to 777=
.<br><br><br>qemu-system-x86_64 --version<br>QEMU emulator version 8.2.2 (D=
ebian 1:8.2.2+ds-0ubuntu1.4)<br>Using Xubuntu 24 Lts.<br><div><br></div><di=
v>Thanks</div></div>

--00000000000090383c062c837c5d--

