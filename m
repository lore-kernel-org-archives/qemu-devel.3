Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63028C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmr27-0000QJ-2I; Thu, 23 Jul 2026 06:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wmr22-0000Q0-1J
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:52:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wmr1x-00018H-Kf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:52:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49571fea44eso2923315e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784803916; x=1785408716; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IehoXc+YaA1sm90uWcURWtG+mLW9T+WEr0+9SHHFF5c=;
 b=hITQkI/qBbw0jiwtdgHRy+Piu7FSSbzkIQAGmzHIoXnT4QsHNiKiQeJIep0GtV+UP0
 TrWw6DAi68sHjzNzxnQftbXssB2A1spfzcvcVNcXtTUJPPSdohCiloVvlDOI0+TeRPAd
 DEoOEL/COV/IZyBch1mz6hTZYoeueJalikZASQad+8iPLhVknhF3VHz1iXD1ft7xA8Bb
 UvWqWb8vTadIVxC4L62efrorx9SBLDlRXwFANmIfTJc1UzMcOCfIkuwnE6XgFobSDEud
 64Ie+TLVebLatMFK4P7088psQPnJInji363Z0AzQrC9FbpEQewN+OICvB1CqN6CMbUnJ
 jwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784803916; x=1785408716;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IehoXc+YaA1sm90uWcURWtG+mLW9T+WEr0+9SHHFF5c=;
 b=d4ka2Hx0LfoNj6Wr81/5rF5yAW2ul37ouUo3V6sTHi4CZxotFdsmucV7pJkU6gTCMU
 kBAvWb6iP26GU7IPkHNAvsiO2XlU+LTNjh8Y7P49tX8MFrOn6ijuSMPnoMG4c8ilVrA8
 w5RQ0XqDxf12ogJEsdxtVbyPNW7bU7iw7/b6X0DoXWXbXxLhCXMTnTF0vo9ffyFE9Sp6
 +DTIielO3GW3pEM+XiooYZkI5JJaV/nSsxVlqkjRLAShSzP5V/BPLM5RvCVK52kPnxpj
 gw8xEqp1wHiB3VTw3epu0uCDBIWtegJGFO2Y7idA1RNx6RU7ALgHcR6Tlqp+6aAcXWBH
 2Rcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdxHGVln73d6f5k8tK2Upz8jqVKdKL/bURD5EiGJOWSO6+Qfh3UzcW9KtCreR6EI+opMyvqfoyF4Bo@nongnu.org
X-Gm-Message-State: AOJu0YzVxeU/yFrRJCJKw0IBC1pLa6rPNiWNdwC4j9Xdmt0wMIcRaUSP
 T8zgMo3JUTMPlUpXjFJhxw73L+fRyrqdoUj8+D9Xa4qo9WU+d/qHhKBh
X-Gm-Gg: AR+sD12oVOb3b2BAo94L7oeyUiMzDp+R291K8LjMhBzgAZ7pQxCLrqcL1Gx3cZZoeCn
 +ioHiQm9zvG+UPbRyfa7aMskdnGzkCv2Fs0l9/H+kzL0OGZ8v0fWVtDqSqehqj350SXS9v3Xd3p
 6fEJRHMXuILEdP2R3HsLc4my8DkCk8R6//lHZVO+a5vUhqdhcPRY6QLmYgnxLQmirXSyy7SzCYd
 1FBj3X8gMsetcttdw7HInbAG32Z5w3BsI8s53mfKz/xbwNdFJTFt6V2JHb7JCd4AWFaf+4AoXCM
 Ft/3TMPf96VGdG4Jv6ENCxL09o1ShBe2GhtnCJwJI60ITwt13Ah/0L/U67di/KxKhNwUq2NwfsK
 mb2YZjfiSyhMkNeO5EswgS5Q8g2NPY3xgKMkGxbJ/JnGLNTZwisTryYT3RC0s4/gbgHE4LZJHOj
 iqqJZTDbAQ5ygxJzc0S8tu6WTY8r1vc9k0
X-Received: by 2002:a05:600c:6303:b0:495:4730:15b2 with SMTP id
 5b1f17b1804b1-49573d088b0mr26417795e9.31.1784803915345; 
 Thu, 23 Jul 2026 03:51:55 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab22e74sm123636345e9.1.2026.07.23.03.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:51:54 -0700 (PDT)
Message-ID: <75ad04f4b6367262a5174245deeaadd32ba317c8.camel@gmail.com>
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
From: =?UTF-8?Q?Maty=C3=A1=C5=A1?= Bobek <matyas.bobek@gmail.com>
To: Bernhard Beschow <shentey@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Francisco Iglesias	
 <francisco.iglesias@amd.com>, Jason Wang <jasowangio@gmail.com>, Vikram
 Garhwal	 <vikram.garhwal@bytedance.com>
Date: Thu, 23 Jul 2026 12:51:52 +0200
In-Reply-To: <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-8-shentey@gmail.com>
 <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
 <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2026-07-23 at 10:26 +0000, Bernhard Beschow wrote:
>=20
>=20
> Am 23. Juli 2026 08:20:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9"
> <philmd@oss.qualcomm.com>:
> > On 23/7/26 09:00, Bernhard Beschow wrote:
> > > As indicated in the comments, the `mb[]` a.k.a. `mbs []` views
> > > should
> > > cover 0x400 (1024) bytes. However, the `mb[]` array covers four
> > > times
> > > the size since `sizeof(FlexcanRegsMessageBuffer)` returns the
> > > size in
> > > bytes instead of counting the number of uint32_t fields. This
> > > shifts the
> > > subsequent register offsets by 0xc00 which is not intended. Fix
> > > the size
> > > and thus the offsets by dropping the now unused `mb[]` view.
> > >=20
> > > Note that the different size changes the migration layout. Since
> > > the device
> > > model is new, no change in the version fields is needed.
> >=20
> > typedef struct FlexcanState {
> > =C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 union {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FlexcanRegs=C2=A0=C2=A0=C2=A0=C2=
=A0 regs;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 regs_raw[sizeof(FlexcanRegs) / 4];
> > =C2=A0=C2=A0 };
> > =C2=A0=C2=A0 ...
> > } FlexcanState;
> >=20
> > static const VMStateDescription vmstate_can =3D {
> > =C2=A0=C2=A0 .name =3D TYPE_CAN_FLEXCAN,
> > =C2=A0=C2=A0 .version_id =3D 1,
> > =C2=A0=C2=A0 .minimum_version_id =3D 1,
> > =C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32_ARRAY(regs_raw, Fle=
xcanState,
> > sizeof(FlexcanRegs) / 4),
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^
> >=20
> > This "consider this structure as a casted array of u32" is very
> > fragile
> > anyway, and will unlikely scale over time.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST(),
> > =C2=A0=C2=A0 },
> > };
>=20
> Any suggestions what to do instead?


The oversized mb[] view is my mistake, it should have been the same
length as mbs[], i forgot to divide its size by sizeof(u32)... I realy
meant the mailboxes to be an u32 array, and the struct laid over it was
just a convenience. It should have been

uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COUNT /
4];

The regs_raw entry in FlexcanState is the same idea. We tried to avoid
any endianess-related bugs by treating the registers as an array of
u32's, and always accessing them as dwords. I see now it's not the
ideal solution, and I should have documented this choice.

Sorry, Matt


--=20
                Maty=C3=A1=C5=A1 (Matt) Bobek

    Email:      bobekmat@fel.cvut.cz

    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home


