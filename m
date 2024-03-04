Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFTb-0003Yb-66; Mon, 04 Mar 2024 16:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arvinlin@google.com>)
 id 1rhCxY-0007Yn-GV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:22:44 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arvinlin@google.com>)
 id 1rhCxW-0001eY-K2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:22:44 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc9f4d1106so12865ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709576560; x=1710181360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tyWDI0H73U/36gvkGcdKJjGZS8qYmDmdT3O92xjozfw=;
 b=BwIRMDocA1pv1sOWk2HvAnFtrJjnxHGDHbFLJxjWNbC3chibjDEc2PSDF5ThVC48R5
 uv8b5qy1ZJRR15cdGkvsxWQUHa+8tKc11BRTHHT19D8G5Q1rr7wNOg00vrC2XmYBA1+U
 irvAutDWl7pa8qBInNZTvmlkxP+oimCJUXJjpmqd5ZrATTpCjEHZqGqIWeQEdDU4RRxg
 7CbIYCjQYbgvw1duJ5xiaUMS6R4OqR5y8hEzv7sM0IoQEPxdCsUqBKQ0t5eqseL2i3K5
 LV4Zzw90Y066UO1SVonwZ6ndEuKGVGrUol7TAJIflc4x5HPhlWBZydA3N3fx0PwG0PZv
 7zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709576560; x=1710181360;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tyWDI0H73U/36gvkGcdKJjGZS8qYmDmdT3O92xjozfw=;
 b=OmCIE4i2Gy6Lvh9AhuidWaB9oDnBUCJJPWAvuvkEwlSyQcAgwWYjgFyS/MBzWyYnxe
 Az9G+u2Z/YIsn+v1iZrujksehLRQC4RHxiZBm4B96xDZZUHAsi2KU43nWxiJ85+/8eZJ
 DS030yqgg42Htwjlq/hrB53bIkTZ+5LNG2ypkhB73nX8RUr7ixlVwhs83N4gnD/dhF0U
 JSIqPdwpgGj7zBGmZo7+QDlxCuIim9KLR3KeNTuhd3f/tDuyvs6JUl8NnNIE/Vjb3VGe
 We/9K4p32H1oWFDQnimBiIasnx4hDl7gf4h7c2HSiscABDbj5VL6CPo8E2Vws0C1JAcs
 uhuw==
X-Gm-Message-State: AOJu0Yyb83iYGlCTHtqRJ3hIQOO85EYMY1onDmL1eWEp1BGW2qYGIJB0
 zymtKHCpl+X0tpUA3y+eo07a6rSRKqc/qOmfaRwkOrKSlNZUK8KdRe2poyk2dLH7oR/z3psBmkh
 vrWA4IqmKFRDmkfqsEPmHfH8mvKpWIF32L0eX
X-Google-Smtp-Source: AGHT+IFvHo1bku8mO2dO71/6zkjI2lA7KX+lf0hW3oezQWhSZ9ZSlX8WwTXgMsdT2yHtIcOdgK00CzMi6dR6r0B38AY=
X-Received: by 2002:a17:902:cecb:b0:1dc:8841:43f2 with SMTP id
 d11-20020a170902cecb00b001dc884143f2mr17647plg.26.1709576560061; Mon, 04 Mar
 2024 10:22:40 -0800 (PST)
MIME-Version: 1.0
From: Arvin Lin <arvinlin@google.com>
Date: Mon, 4 Mar 2024 10:22:27 -0800
Message-ID: <CAOJ+zFWsEYHiJObWvW4rt9OKOM_SzMPyJue-Ejui=YyETtCwcA@mail.gmail.com>
Subject: Consulting to create fake object under tests/qtest
To: thuth@redhat.com, lvivier@redhat.com
Cc: qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: multipart/alternative; boundary="00000000000094ae4c0612d9cfb7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=arvinlin@google.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Mar 2024 16:03:58 -0500
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

--00000000000094ae4c0612d9cfb7
Content-Type: text/plain; charset="UTF-8"

Hello qtest maintainers,

I work on QEMU with Patrick Venture, Hao Wu, and Titus Rwantare at Google,
and I am developing a Nuvoton USB device controller model that uses
usbredir parser (
https://gitlab.freedesktop.org/spice/usbredir/-/tree/main/usbredirparser?ref_type=heads)
to redirect USB messages over the network. I want to create a qtest to
verify the behavior of the device over the network by starting another
usbredir parser object to ingest the packets sent by the Nuvoton USB device
controller model. While I could create a fake usbredir parser object and
set up the tests all in one file, I'm wondering if I could create a new
file (maybe fake-usbredir-guest.h) under qtest for the fake usbredir parser
object. The separation of the fake object and the device model test would
benefit the maintainability of the device model test code and allow any
future remote USB device model to reuse the fake object.

Thanks,
Arvin

--00000000000094ae4c0612d9cfb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello qtest maintainers,<div><br></div><div>I work on QEMU=
 with Patrick Venture, Hao Wu, and Titus Rwantare at Google, and I am devel=
oping a Nuvoton USB device controller model that uses usbredir parser (<a h=
ref=3D"https://gitlab.freedesktop.org/spice/usbredir/-/tree/main/usbredirpa=
rser?ref_type=3Dheads">https://gitlab.freedesktop.org/spice/usbredir/-/tree=
/main/usbredirparser?ref_type=3Dheads</a>) to redirect USB messages over th=
e network. I want to create a qtest to verify the behavior of the device ov=
er the network by starting another usbredir parser object to ingest the pac=
kets sent by the Nuvoton USB device controller model. While I could create =
a fake usbredir parser object and set up the tests all in one file, I&#39;m=
 wondering if I could create a new file (maybe fake-usbredir-guest.h) under=
 qtest for the fake usbredir parser object. The separation of the fake obje=
ct and the device model test would benefit the maintainability of the devic=
e model test code and allow any future remote USB device model to reuse the=
 fake object.</div><div><br></div><div>Thanks,</div><div>Arvin</div></div>

--00000000000094ae4c0612d9cfb7--

