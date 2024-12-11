Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4991AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLFr3-0007lm-9H; Wed, 11 Dec 2024 01:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tLFqw-0007iT-W9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:05:43 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tLFqv-0005Rs-6M
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:05:42 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3022c6155edso19905401fa.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 22:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733897136; x=1734501936; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q7jSPiyOAnWEvaqqfdvtmdFV46j8WQz03/SUwBAFoB4=;
 b=Ic5iYHrrqg3IVGTDg9DLoCmEDxUNcZ+7JaQZcC5TtmHmQ2GxjanJ+eg6ZUV1xX6VGJ
 JMIV70xNOWuFGjZ87KwVmIw2llMr8Efl+ATmpQyyuItAkV/atFeldXeZCEQqZiq49640
 fbomw6vMsb/Ak4CjCkQsovhqbDlVOKE+/yc1U6gSnXFc6R3MKrsudrI6zzKXzKgE6SU/
 1rSdDNgOA+sR2Geu73uwH0bM/gCz8yqZtfbQ4syCAVFg+VET5TtIWMDkKwR+n336gZ/2
 3RfyEvF/CQ5eHPzUnyl7WWiPczJXZN2Ch/RzjfTjaSy0+TjY9tQYzxOouDcRLELsdyUF
 wlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733897136; x=1734501936;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7jSPiyOAnWEvaqqfdvtmdFV46j8WQz03/SUwBAFoB4=;
 b=Y4/et4PYqpOlv28RTOq1Jmv/mf5UQKDEdRCO081dCKtxua4u//qs5qBn1qNUsyKrYM
 trg9I2XkNMCezUiWlsKj/BzVVWu69eMCvow9RqVfbDe9hiRmlAy0eD2I1dJChxR2SEeF
 LD7zw1t2eTsTmIxtbPjE9dyHwQ45+q5OROIKYdruTyEpyScGVrYApoWnvLGrgKotWanZ
 8AqCQsVSrcSLwK+DmQe0qjNqH/TMWZBobItaE1mKB01SYN9UdAsuHU+7/HsvMNzMXg+t
 vyQllI0kIVSBufizeaPaRZYOvKL8OCkquwhM7Qckic5Bp6jt2iVieAiO2WAWpWsKDxW2
 ODAA==
X-Gm-Message-State: AOJu0Yx3kTno+/+ErplzFpYdrXF7hDra2JVC5SBqjjUjVboDf/JY9u9y
 ebEoQt1MYjB8UUcdckcFZ3dbIf5OjjE3ORIYFyc2LNML8EPbNA2M+Zs1gkrmg8vAcsavgWs3zss
 cHgM01Xan7QwjyIeN905BXEqTTRwwBbfgZ2wVxraMcg==
X-Gm-Gg: ASbGnctKvqUSkhOiw0M2TLkP13ZGtZvt1oiGImEFiH/3kwwZ4uWu7w+g9BujJ7fhA/G
 XPULfTmUoMYN2ApmiSR5h7ud2nm+KpIPS6QY=
X-Google-Smtp-Source: AGHT+IExrhqTj4apyZPVCYqib6X7YI0mPOMcJ+RBZJyycMQVLV3eSbE7Ij0eG++ZmU7HX3uAkrebsU/GXzyikrON91w=
X-Received: by 2002:a2e:7211:0:b0:302:2202:14dd with SMTP id
 38308e7fff4ca-30240cfcad9mr4169531fa.20.1733897135895; Tue, 10 Dec 2024
 22:05:35 -0800 (PST)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Wed, 11 Dec 2024 14:06:36 +0800
Message-ID: <CAOYM0N1vLhE-wdKUX614BJPgZ1pj+ksTtYXfutWMGZF2t1QE+w@mail.gmail.com>
Subject: 8086100e.mrom vs. efi-e1000.rom
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dcba9b0628f862dc"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x22f.google.com
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

--000000000000dcba9b0628f862dc
Content-Type: text/plain; charset="UTF-8"

Does efi-e1000.rom come from 8086100e.mrom?
If yes, how to convert it? Thanks

*8086100e.mrom*: ipxe/src/bin/8086100e.mrom
>
*efi-e1000.rom*: qemu/pc-bios/efi-e1000.rom

--000000000000dcba9b0628f862dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Does efi-e1000.rom come from 8086100e.mrom?=C2=A0</di=
v><div>If yes, how to convert it? Thanks<br></div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><b>8086100e.mrom</b>: ipxe/src/bin/=
8086100e.mrom <br></blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><b>efi-e1000.rom</b>: qemu/pc-bios/efi-e1000.rom</blockquote></div>

--000000000000dcba9b0628f862dc--

