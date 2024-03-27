Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C5BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU2S-0001GX-2g; Wed, 27 Mar 2024 10:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rpU2Q-0001GF-PE
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:13:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rpU2O-0008Cj-Hn
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:13:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34175878e30so4876471f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711548834; x=1712153634; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dbKwV1lVh0eDNNl8BfpXJC6IsewNSy8t9cbeao3ZZXk=;
 b=MOcTmIzuCoh0+9zhy94xe8ntLUd+pGN7/cm6uyWyE7ZDTdB2G0qW1fYPEvY7ao9rcZ
 MJtMTWcRgdQ9ZZX4ylyfsf/sKtF2U1wEvpERy5OOZxVm5fCuZ2Y32k+Jo2UZ2S2T2zFl
 F1XVPhRX3syAM028xk6XLaD7waxGzLIZAr/1xW9Fx5NjWaDxKExIkxb2kkFNyxi5xpNq
 R5v7d+D/mg5RSBQYK8q/fCsqWLEmZX+mnJomQTLFxrnirEg7JF6b6s/d4erWd4YWgWMg
 XlFe5uW2pzLFzkyDeDb7/qh73Z0llAzAO/5dZmbH8Q+XUZOZhuWYMG9Oarg2Lky9t5aW
 d+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548834; x=1712153634;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbKwV1lVh0eDNNl8BfpXJC6IsewNSy8t9cbeao3ZZXk=;
 b=K82xlgMCV6Mwkg9+tovylERtypiiIxcvOsxncsSXCwyPrcVV+NQmvC70ajWylyvBVo
 qRYqAqMdpddycsP2xk9BuXOLIMjmRZK+c6ypYBE4CiAKB9M+Mng0O6ZvTv5y87nagQ6T
 vy4QVs0YPStWiPfDMJDzUU7gSvIDtlyzv5QgsKFl9xoGLUCRGpDMdiG11sw7tNy1K131
 EJ+psj1P5/YHS3XnrB+jGG4E3M+rrRiHn4P2sMIbT2nyrgJt5XGY8LEgZldBr21iQMHJ
 0gGVD+uL3IumsdtLhJlRlo5EGIUFDR/1eCYRtzBkf0NtGdqGhJrPONK7WH3f/it00Ft+
 Za9w==
X-Gm-Message-State: AOJu0YxLcn0JvIfcbR+9c4Bmsc1RT6/pPBx3BDtb33AqdPOJawqIS3y3
 XrZDJnB3tEUuntFdpHRy/HwpT67sca8KbsOd3agNiMmd65FRDTZdSpDs0esElaY=
X-Google-Smtp-Source: AGHT+IEOSgYpRxcnDtQGshfZPm76+5tPNKjNQx5KEB+YnMrV2/IpTHybgAl3wCQiDucUdnEtfmajWg==
X-Received: by 2002:a5d:4ccc:0:b0:341:9087:8a4 with SMTP id
 c12-20020a5d4ccc000000b00341908708a4mr74460wrt.13.1711548834092; 
 Wed, 27 Mar 2024 07:13:54 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 bo15-20020a056000068f00b0033ec8f3ca9bsm11633860wrb.49.2024.03.27.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 07:13:53 -0700 (PDT)
Message-ID: <da59863286f014444350d7ecc5523f32fd12138a.camel@suse.com>
Subject: Re: [PATCH 6/9] i386/pc: Skip initialization of system FW when
 using IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>,  Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel
 <jroedel@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>
Date: Wed, 27 Mar 2024 14:13:53 +0000
In-Reply-To: <11A81A35-2513-4433-8965-FE3AC5E0BF75@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <63a4febd571701bb9f2f7511d71fc968ed9205ab.1709044754.git.roy.hopkins@suse.com>
 <11A81A35-2513-4433-8965-FE3AC5E0BF75@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=mQGNBGPbfTcBDAC6lp3J/YYeCtSPP4z/s5OhqX9dwZgKxtnr5pif+VOGCshO7tT0PCzVl3uN1f3pmd60MsobPdS/8WoXyDAOconnqhSJ4UF6Qh1FKQcAHlx1QrwwivYltVHTrhOIAa2gqiUQPPDUkflidvd8BlfHv3iV0GzkPq2Ccwmrzw6P8goLPIBYXzajrHgnXiDaqaLV1fdbExZxzgXhDAHrqyKOxvSdQik/M35ANqhHds7W7/r7EdbYzjZm7/JJ/qJljixJrveXSQnuKI7L09ZqDkjD0z4nw3sBP6zihOUw3heGitto8whjdr3IGoR+hM4V9RYDCUJA1Ynesqr0YpFpUcmCuzVkYP1jmyPz6Z57knbfRnTSC36uUzeUc+oejhJ60U+dFlU3T7r6+0brSLkwRlHz7NkdHValMy6vYxgeKjY1hq7TD2YFmRjwqB/Pf3zCr9yo2TwjnfBktIUCkLFu3AETH7V7NcFGrcZV4Jxlp4Mnf+Fb4z0hSaOj/6grarQQYok3/JkAEQEAAbQpUm95IEhvcGtpbnMgPHJveS5ob3BraW5zQGZpZWxkb2Zjb3dzLmNvbT6JAdQEEwEKAD4WIQSlmXeP2cn9E8gmn9bhiafdRpNKTQUCY9t9NwIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDhiafdRpNKTWj+C/47pI6go70oNLa5g+hSOWdCHlLdr3e4sBJifOj5++ip7hPZ7sGZrcTs+rhOX9TH1k/bPmwg6S/bNaAypxhxQIOgmDtY2Osq0nKUZ73JigSW465D2dNOjAmOV3WUxmeP/N5eipqyN0NSp2GtROd+K7ElbRCv290fS97ux/XLcBT6c/KwyjqNyR1cPqzIAZ4Fgo18Z5kbE3H1uHBojeCFaEBSKojkNg+Xg
 xxM+XCNQ2nHflbK+QCvRky9wZPnACO6VoFjwD89X4GJYvwtc4phnG9Tm5skW
 TjtmBFYuzf6IRxQ0f+N3ixKykJegpS4zRVooD1/W8c6XBDS6UeHlb7PhXm45lIJRZqogPhoua/EqP59WvbEailR0HUSjgioreRwp9Nu308ADsNIVOF1v6kf1OWwVCO7n7imAj8oWcG8CKlTvu7CYl+QPr+di2hjemU13qP10k9vxbHEdQ9oovWWs+4ndlYpYf7aK/F1kdptwLamGCphHBbjwdTkFmn1q9STG560IlJveSBIb3BraW5zIDxyb3kuaG9wa2luc0BzdXNlLmNvbT6JAdQEEwEKAD4WIQSlmXeP2cn9E8gmn9bhiafdRpNKTQUCZABdKwIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDhiafdRpNKTR5gDAC4ziQZWxg1L/H74UxqRYCgY+ub3LZzJT2GzOu3IPZS42/wUbssESo2AsuPoBQEqvnoNPSU3netzURH/Raf6iad4ZHwG71U5wA5Ff10uuvRpERNStUSDFS1/IYmCNhZzUIJBxuT8uwaMbk4eaNaqaxpTJ8ENalipKFUQcLxjjth7HKztFJw/FZE8GXtL6RsNqoFYB6LLj4c+EzXYOwpmQtzQNsjQnuqp/KKeeVn4UX4FFUrZLZ46eJAMLA0AssBvctlxahQ9URBKKqa2X+oDpz+l9uYWg/ColC9z6cr2ohYjUlz+C7AGdXZTF5pBh7uLAjAaD5qYlNEzUGeaK4NwKyvwpdVw0aAamKu8MKkuxDfs08vi7cEeI97K9NKQOISMNkLo/q6WM9yjk5ZoGilqJibzidoI/1P45+fJ/ggvEMqyUY8mN+g8xCR2fJDzHSh77QmVF8oDwnGr1QMYbXMGXGsVza7LXBXYdWIjvvKxqxc8Z8rFdpupOzx0zPMc9bUCb65AY0EY9t9NwEMAL3jxajdfoMhLJ8Ki
 idHEAO0LDMtSq7jpkIA5q2289WB/8+2xTEn3lsjEoWe/IfdxzwiuZunp0yJPe
 9WUhZTuSxMv4+R3NtQIHvuPYGYTshVBKdCGLVR9ojLjzud0g70doI+EnOviF/CkoeCQM0tuIsVFCbVz/1DKc1EmkbQnJSmH77qzZ8mo2M9S/21a7jxoSCexSJ+eYQggwGI9L/zeo04GmH39uGvPnb546iFng1qPHbww7v60QxTOsvz25rFjomuL62DMZT6T+4pYilHUJOGYoqL3tTcpoaR/xHTy26kVKYrS7bGkOivnsxdLt5BWutWoBcDUGoIxA2ZyPMVnfQXssl4zcalcYGXadNBwDyzUSsoMVJTF9l5f8fQhZXK54E675vHQlRaWq3US7g+kfo210SBZWUEhATE81+Z3Y45Hx/WQSlARN41EX3tsQaqr04L5j5Kvx4KHoGMkT0h/lkrWimG5J2qHW7sV258h73tMMji20Eh0yIELF0Qm3EE+wARAQABiQG8BBgBCgAmFiEEpZl3j9nJ/RPIJp/W4Ymn3UaTSk0FAmPbfTcCGwwFCQPCZwAACgkQ4Ymn3UaTSk0ytAv7Bst/mM+r0GNrceVByr6lv3YqYX/G2Ctn5vXmVou7YqR4QKUrcrN5lU17daAp1fGy0P3YYOedHrC0lscd7jQWuBNLCTjIRxq+oJYS/b96LyVp92mki8beES3NU/Ew/8ZW7sArg+SDEnfwmszejR7C317sCulGO9HK0SHThSGPXmyO4jisDZahx7+GPQeXEZ2Fd4XjDOBV4CHJzd4JZIMo1ebKMaVgzE96ucBSctvJuHGbUokP58lj7mbrssfQbo/uTPgqAglr8a8vxrAn6t4LBV9iS63i9CAUxHTmrqrmE6DjOK/Wois1dXb88gYHow24se0s+1xzaeYA86Q8/NIXIDih3YQk2P21hEnf1VkIlH7+tVa1A1B747moWfmQkb6TBjm7N2XsDp7/hdBu5bi/xbdIP
 ee6kYEiujDrEv6DXG/9NSh2ahBMYOgQkwrUaPvdhnt/N0VgC4a++gdaWoQLCPM
 HHaxeHr5n/cWyrSpSRrYXZqcW+FKwESA79arqD2bl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::434;
 envelope-from=roy.hopkins@suse.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 2024-03-27 at 18:58 +0530, Ani Sinha wrote:
>=20
>=20
> > On 27 Feb 2024, at 20:20, Roy Hopkins <roy.hopkins@suse.com> wrote:
> >=20
> > When using an IGVM file the configuration of the system firmware is
> > defined by IGVM directives contained in the file. Therefore the default
> > system firmware should not be initialized when an IGVM file has been
> > provided.
> >=20
> > This commit checks to see if an IGVM file has been provided and, if it
> > has then the standard system firmware initialization is skipped and any
> > prepared flash devices are cleaned up.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > hw/i386/pc.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f8eb684a49..17bb211708 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -63,6 +63,7 @@
> > #include "e820_memory_layout.h"
> > #include "trace.h"
> > #include CONFIG_DEVICES
> > +#include "exec/confidential-guest-support.h"
> >=20
> > #ifdef CONFIG_XEN_EMU
> > #include "hw/xen/xen-legacy-backend.h"
> > @@ -1023,8 +1024,15 @@ void pc_memory_init(PCMachineState *pcms,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0 /* Initialize PC system firmware */
> > -=C2=A0=C2=A0=C2=A0 pc_system_firmware_init(pcms, rom_memory);
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * If this is a confidential guest configured =
using IGVM then the IGVM
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * configuration will include the system firmw=
are. In this case do not
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * initialise PC system firmware.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 if (!cgs_is_igvm(machine->cgs)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Initialize PC system fir=
mware */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc_system_firmware_init(pcm=
s, rom_memory);
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> Ok so this makes QEMU mot load the default fw as provided in the QEMU com=
mand
> line. It does not specify how the packaged fw specified within IGVM would=
 be
> processed and loaded. Am I understanding this right?
> =C2=A0
Yes. Although as suggested by Daniel, I've now changed this so if firmware =
is
specified on the command line in conflict with the IGVM file then an error =
is
displayed. The IGVM file itself describes how the firmware binary is popula=
ted
into guest memory and launched.

