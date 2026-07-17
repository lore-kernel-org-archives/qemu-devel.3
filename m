Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AD2C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkicQ-0001oy-TT; Fri, 17 Jul 2026 09:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkicP-0001nw-LO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:28:45 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkicN-0007J0-TZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:28:45 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ef8255cccso2513557b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784294923; cv=none;
 d=google.com; s=arc-20260327;
 b=GovZdKBV8Fmluhiu6TQkNZprQH1fATs8rsiTg1GCM0hat73wZPRfgS3uGZ0YeOVvMf
 pYZjG+8zQDYTtfKmp16HA4/II1UP4X7aNY0tPduNEYqW3gtSlakkrMmV4RX5tcVH+/nL
 K3UCvZaEL2CMypup1M998hHGSvUaEixXQWh7UqC0jCCTjhFutRCtSzaW95oSsHDU7kMJ
 aIPAs8TNms/4V9Jlm2UmAazRVJHZGlBoRL30pL9J73YXnfDmdbI9cDU0aO+WZxHKFN9T
 WRy2FTwUEzhtUZrRhfkJEbwE2QvUkoDlKfSzGAs9GsCxUjHSm3gR8ILl92hCKzMzvmbD
 wHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zAza6idldi/AmDBXBvhM73YBNaZPDxoAkKRX1lxWWr0=;
 fh=d6Pr2tFHi/w9fuehq65i/yDL/Z9hR8bSe4pGaXmIK0s=;
 b=SUxbTABtCjDSQDotkJ2njxktbn6FBWFeLBKVCvwyWfdN8VwV3B651EiPZEC+vl68pf
 6/jZJVdSQfg44NMATkgwXfTu5rjtul9Y1x2hQS/AoZjnW6ybdi7wAu0xZLgHfNQdHHXT
 JSu4GONYhkdcpyxPHPv4HNmRzdo7uPhuaRILxD8eH9NVfzGYws448DtdKZSAP1IwFC8z
 gJ0TaeBvRzbuuDxolg3Q0CO5nEk6o3JhxRIXMfyWsH2V9Pit2ggYG210/AytFQcvWWwJ
 uwl23gGYncDwHxfECKqlqgcIpp70tE/as2wkB5jmgz6coUT1d6Ak0zVQXAoHoPzpB/Vm
 uhEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784294923; x=1784899723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zAza6idldi/AmDBXBvhM73YBNaZPDxoAkKRX1lxWWr0=;
 b=GvSqIL8qF6G+QYpT5V0PqI2U8padwL9Yk60dsD9D/7VwEy3fN2WuD8LzTP9NpVHNFa
 r+mCqYNavDhM2P70XG1W5vlkkbp5Fhe63QryodsPkR9s5rISzE0xPzdlYTEAIyuaozGj
 PBKOLWHnErhGZlCrc1uKijhLJNi7E8A86fh3DxUG9gIJxL6PsBMrDcJ7/bx6/S/SE5z3
 np9ya0efBSEElF+wyEHX1IUEwBP4zUP1xOz4D8NM4nWkLCZuyowjUH62yzED0wii4E4D
 Sle3T+rJHRe/APpJGccBY5GFynsPhiDhReNR3R679ozOmAt1exm4LNvQ9W5S5nBNbVCe
 NA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784294923; x=1784899723;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zAza6idldi/AmDBXBvhM73YBNaZPDxoAkKRX1lxWWr0=;
 b=TKcH/1bOqPjZxrUxy6D0DgW74so+sqe5w/WSyr3MCUU54clPxdH4PJ8atrIeIwW0Xb
 A4gqnGxMpOXYBOCErT7Dw5gOGJlGuhP32+tbLxHAZpUVdgYCzvmM/3B+rRjvU8HG8MSY
 W/vpT63UvFifXBkB6L74NWozuU4iLgxlHYropShmuWYyKXmRHDHrVhQz63zaJ/6LmBHd
 9XpZj7oSMwalj97JZ0PqZ9PFjn0jNL85rTpKTqkywxPyucEgfJAAqPtIgJynn70ltfYW
 yM9v3dl+LswCjZPNfM14jwYPzc9I0/GaZ0Fe9t6PGGxyheSPEC6CIOXBXmXK5pMiVKXA
 XhpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrv0v3PmhccwvWxz/A1pl2JuWlYKuIvwcKAG/ednzvwoeQR+kbAXHqM0n2xkUCZrr/6ScyzlPjPKEO0@nongnu.org
X-Gm-Message-State: AOJu0YxdWLXizTjEVQGT9K4cfDysWNIb6jzBtdBkGdUk9Rbh58jcb1ps
 bWKAvQGbdaQPfgwfYhZtjV06u5feYS9zvj8eGXarVNjQ/UfDVe8EL8PM21mGC3Z56QjEQLkZXzs
 TbDCRNczlsBC2jkgfAUsqekPYgzFqYkszFvjj4TuOOw==
X-Gm-Gg: AfdE7clfh3Gb8JqsNgjtGHJOs1ng2hW7WDpazT/zK+ObCByDkfqz0FfEhQeWPdXOsyA
 +avywtYWtbTWekv2cm3Mq27d9BYlFtuLhIi+00kAw/v3lob9mlvnloIGkIi+8+te4UmiPh5h7hD
 k3nCNahMI6dzI7o9eMD2DaHrwkCimTKxSPAIeHbDJZ7sG2hPRiQRZlC2Hyw4l/DZOgc68tqKrDh
 mv+ieE38LLtPnA9NKKffK6RjcztX9BVng++TtdESezzopQZW+AFRtwrsBjeCPz7XQy1+gm6A5eb
 WqV5HjjhAWkRDm5R5POv+vNwmNqaR6f6ROpfLdgX1DS89Q==
X-Received: by 2002:a05:690c:c1c:b0:80b:bfee:c427 with SMTP id
 00721157ae682-81ef25a3bc3mr7480727b3.13.1784294922674; Fri, 17 Jul 2026
 06:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
 <D5F0871C-4AC1-43D6-9BCD-C59A07236A1F@free.fr>
 <alomsclAchz2_bWy@mail.minyard.net>
In-Reply-To: <alomsclAchz2_bWy@mail.minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 14:28:29 +0100
X-Gm-Features: AUfX_mw-Rc8nV8LNb9lLOizZTJs6D8LLWx3Kz5bo9OMcga1jzo5qtO3ZYRkLung
Message-ID: <CAFEAcA8dsSKrF3F53SWwyhcNR4XbvRG3N5k96Qkq4RLtpYuwWQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: cminyard@mvista.com
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, Emmanuel Blot <eblot@meta.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 17 Jul 2026 at 13:57, Corey Minyard <cminyard@mvista.com> wrote:
>
> On Thu, Jul 16, 2026 at 07:08:04PM +0200, Emmanuel Blot wrote:
> >
> >
> > On 10 Jul 2026, at 18:05, Peter Maydell wrote:
> >
> > > On Wed, 1 Jul 2026 at 18:31, Emmanuel Blot <emmanuel.blot@free.fr> wr=
ote:
> > >>
> > >> Slaves created with i2c_slave_create_simple() were left unparented a=
nd
> > >> showed up under /machine/unattached with no stable QOM path. Add eac=
h
> > >> slave as a QOM child of its bus, named after its I2C address, so it =
has
> > >> a deterministic and addressable QOM path.
> > >
> > > Should devices on a bus be QOM children of the bus, though?
> > > I would expect that they ought to be QOM children of e.g.
> > > the SoC or machine that created them.
> > >
> > > Do we do this for other bus types, e.g. PCI ?
> >
> > If we do not want a I2C device to be a child of its bus, an alternative=
 parent could be the master/controller of the bus. However as a controller =
may manage several buses, we need to add bus differentiator in the child na=
me, such as bus_num:address.
> >
> > I do not think it makes more sense to have the I2C device to be a child=
 of the SoC rather than its dedicated controller.
> >
> > On machines that are statically defined rather than composed from the c=
ommand line (BMCs, complex SoC-based machines, =E2=80=A6), all the I2C devi=
ces would appear as a =E2=80=9Cflat=E2=80=9D list of devices, with sometime=
s many instances of the same I2C device type belonging to very different su=
b-domains of the machine they instrument and/or drive.
> >
> > I tend to think that using a flat schema would likely make use of QOM p=
aths more difficult to observe and reach a device at run time: one would ha=
ve to iterate the device and bus hierarchy rather than to use QOM path to a=
ccess a device, or special care would be required for naming device instanc=
es. I was viewing the role of the QOM paths as a way to expose the machine =
device hierarchy as a comprehensive and non-ambiguous representation.
> >
> > What are the cons for using the device/bus hierarchy for simple buses s=
uch as SPI & I2C?
> > Is there any drawback to use the device & bus hierarchy to assign a def=
ault/fallback QOM path to a device?
> >
> > Maybe it=E2=80=99s a matter of ownership? Neither the I2C. bus nor the =
I2C controller owns the device for sure.
>
> Well, "own" doesn't have much of a meaning in this context.  It's a
> matter of how it's connected.

"own" is the whole thing about the QOM tree, though. This is
specifically not the same thing as how a device is connected.

> I agree with you philosophically.  From a user's point of view, a
> hierarchy is much more obvious.  Otherwise you will have to create a
> fake hierarchy with the names or you won't be able to find anything.

If you want the bus hierarchy, we have that; it's not the same
thing as the QOM ownership hierarchy.

-- PMM

