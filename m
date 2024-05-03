Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0FBC25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 04:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2kpO-0002rm-A4; Fri, 03 May 2024 00:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kpM-0002rE-Ho; Fri, 03 May 2024 00:47:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kpK-00072G-Tt; Fri, 03 May 2024 00:47:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so8409347b3a.3; 
 Thu, 02 May 2024 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714711637; x=1715316437; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TsX9RuDUKXFIq/RmTc1B8ohJFIJNTcVT0EVfTQknp4=;
 b=WPNrkwUMjWV3qzoumj4FBVSA2agUVMw86FPgOIub3iCYdTgQyBzaLd4Yfpds0nypb0
 s1R5zZjwh0Xv0IzCUOYsHyHKT59snrmFa27AClYd1nroaM/WcWfD13/f+GBfABZs6hVC
 AuXmAitJJh0uXzxhJgZnx3lUFRX8ZsXkZpNc4cLZfaQU3a8Im4QvfAC1AvUdOI1N4tqz
 l+ncxy2Vq8++eFITtQNWuNGzKIQMVapln8vGER2A/KvkZcyCuTVf3sEJq4653H8Ngd8x
 HmVD9bj2mrqhKHQ1mNFQAQy529ex5cK4534p1MmWqcAPPN8gT+JhEJ9fBeoH0AY/Re/z
 FB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714711637; x=1715316437;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4TsX9RuDUKXFIq/RmTc1B8ohJFIJNTcVT0EVfTQknp4=;
 b=qjT8qUHfS+1nJJnf2EV9qPBZ9rvOvEiCSqqi7ZD9iUsfQEnNmea3DXsDrmAQ/AG2TS
 7bMSPAZjWmd45KlGIT1q4aUJMI80YUItHEwjGWyyox7Z6N2YLSrQYNv+jSArIPUSdcOm
 a3UfeKjovsEm+BdPu81xAph4QdfRIBwFKbadVT+OiaqitAoc7dvBrCCWrEdVpVv6VjEz
 y54IvRCQ+iZNREcx2kQkvU2kKEjLZKehsy1/Xv5eojHB6Gdbw1rSHEECrlLmbMTpvWms
 fEx+nEhYt315Bibqid7Gljn11wamGVlUodq7nTxvOihO+nTdtfEAUD93ne6DzLNYpGyQ
 TNqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2tqjDVZGX50p4lEzNCvs0qP9Or68zmdylsz1BgCnIyP+5Z1ANUMCC/sS1fltGiJJmNyozZVRipkv17tiBVsm7MfjH
X-Gm-Message-State: AOJu0YyLr59weBb8j0gKiEVG8uzqKTuvUre9CML70/4J4x4qN14xR4XC
 QGmHNKCQt05ATUj+HvbMpbL/wGK+6yrvEybhCP/sP4L8A1QZllFD
X-Google-Smtp-Source: AGHT+IHWlKPOpWSPWdr/Ufpl316XZaC4O24Tz4JX/ydd+VUNvGK0dIicVG+AcBg3r4HZJkcpW7fSSQ==
X-Received: by 2002:a05:6a20:745:b0:1a7:549e:ab80 with SMTP id
 l5-20020a056a20074500b001a7549eab80mr1350617pzl.47.1714711636792; 
 Thu, 02 May 2024 21:47:16 -0700 (PDT)
Received: from localhost ([1.146.23.181]) by smtp.gmail.com with ESMTPSA id
 x6-20020a170902a38600b001ed3702f786sm524682pla.169.2024.05.02.21.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 21:47:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 14:47:10 +1000
Message-Id: <D0ZQJK6S2OV1.1S3QIS1VZYH0A@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ppc/pnv: Implement ADU access to LPC space
X-Mailer: aerc 0.17.0
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-3-npiggin@gmail.com>
 <f8b689f4-50b0-4f96-bd64-21b9eda6862e@kaod.org>
 <D0YBEWF2CP6Q.121MBJ0QG4HS1@gmail.com>
 <1911763b-53ba-4816-96b8-f8720b8c5634@kaod.org>
In-Reply-To: <1911763b-53ba-4816-96b8-f8720b8c5634@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

On Thu May 2, 2024 at 6:32 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
>
> >>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >>> index 5869aac89a..eb9dbc62dd 100644
> >>> --- a/hw/ppc/pnv.c
> >>> +++ b/hw/ppc/pnv.c
> >>> @@ -1642,6 +1642,8 @@ static void pnv_chip_power9_realize(DeviceState=
 *dev, Error **errp)
> >>>        }
> >>>   =20
> >>>        /* ADU */
> >>> +    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chi=
p9->lpc),
> >>> +                             &error_abort);
> >>
> >> I would add an assert on the lpc pointer in the ADU realize routine.
> >=20
> > A assert !=3D NULL, in case this failed to link correctly? (Maybe if it
> > was called before lpc object was realized). I will do.
>
> It is to make sure that an ADU object is not "realized" without
> the pointer '->lpc' being set before, since it is a must-have for
> the implementation to operate (and do LPC transactions).
>
> There are several :
>
>     assert(s->chip);
>
> in the pnv models for the same kind of purpose.

Makes sense.

Thanks,
Nick

