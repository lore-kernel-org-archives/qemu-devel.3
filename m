Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE0C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZgj-0002Qf-Du; Thu, 01 Feb 2024 11:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZgi-0002Pg-Oc
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:13:16 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZgg-00023y-U4
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:13:16 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50eac018059so1380412e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706803992; x=1707408792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4BcKXUT4wD+nTgpAglGjWuwsIVJi2TJzkGpZFrGXB7I=;
 b=oW+QF0avoW3uctj6n9xi6d27AwGG2tinw+xt4sqDecmLduYGHESJdcUZEgNu2WJe4s
 rhnKN5Yn+4Z3U9Hw8bB1tAcqV4t7VW6GE4Yfrgrj85e3+QZEYaPiJ6JGMmoBSM0Fwsc9
 cA7fXdK75T9u4CVblkTrMvyeCDJ4lclyAPLBCeNb5MPyoLVNsbTodhrBxr3nnFdlip23
 t3DbnWF3v95e0euE0x4ZHJNF9Whx7jWFlSyBE9MEwr/CS/mWefIuaUqEnzv7rJx64hGD
 Srgk0LiYH7tZkGjM60Sk++eabVVCQ3gywTY0Z1o79xJYiu1yq8F8WcZ+q/pMRMGp24zJ
 KguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706803992; x=1707408792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4BcKXUT4wD+nTgpAglGjWuwsIVJi2TJzkGpZFrGXB7I=;
 b=k311RrTjKvJ6e8cbPMZ+WRLmY2Nvvd6tdN51h1f048B7cF6rm0cF0oNHpT+giBHJLD
 sJmTnHwWYbxyUeod61xKfY0XiVlL/oaZ7/JBKUdibiMY8g+aAdypSXMFlLPI5NnT+jeL
 XI3ONM0lxjcMR43amHhWoxbN9SLBrVWSxJOqIs1CZ5UlA1XLp5A1MBNhTkSd31TRnz+L
 FuGz9uBPdTNEcmWEH/d9jJSmFC1t/cDyG1YDJ8P1CzvMyh9tMs/gtq5IftNsKxm9JPZN
 g56q2PtuFl2cXDI0MEs3koaqLe3om4JlntcYo+kV9qeK6PCDQ5U+uV/Uji5vqubnUBhy
 0dfQ==
X-Gm-Message-State: AOJu0YyIrynOxc6uzPkb2WyeQtz0Ycv4WR0B7yLTGh5lOTfnWSf5Lvm4
 0w8FjifTT+8eTo6SZV7mXwvRcnQhx+50KFcXY+6NXo40Q7et+ZyRI9DsvKDnIw7ptkg2WdBpHAm
 ltuMdWgKG8+oybuNJ0CTgrSVfd+Jph9jYLTz6Cg==
X-Google-Smtp-Source: AGHT+IEwrp8kPIkrWdVF7gXVYt3uKNnCAIpuaYObHinkiabVh+bRyDURVc0t9I//YYmNmVYPCXbC2uWlRJY0jRl+WC8=
X-Received: by 2002:a2e:7804:0:b0:2cd:ec28:ccc5 with SMTP id
 t4-20020a2e7804000000b002cdec28ccc5mr3614104ljc.14.1706803992614; Thu, 01 Feb
 2024 08:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20240126173228.394202-1-dwmw2@infradead.org>
 <20240126173228.394202-34-dwmw2@infradead.org>
 <a71dfb65-be10-409f-87bf-fa4e71253b41@redhat.com>
 <07fd91de5e438409aa6473caa18d3aab8a13c444.camel@infradead.org>
 <1f75bdb3-7a87-4699-bb4e-9608e291c887@redhat.com>
 <350fb73159bd598c79f0bacd0a9647b10c5e25cb.camel@infradead.org>
In-Reply-To: <350fb73159bd598c79f0bacd0a9647b10c5e25cb.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:13:01 +0000
Message-ID: <CAFEAcA9Pg3Dh=UJOZTMpuZOBPsoS55B8XggianC_mRcb1GjdBQ@mail.gmail.com>
Subject: Re: [PATCH v4 33/47] hw/m68k/q800: use qemu_find_nic_info()
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao <gaosong@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jason Wang <jasowang@redhat.com>, Jia Liu <proljc@gmail.com>, 
 Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 16:07, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2024-02-01 at 11:30 +0100, Thomas Huth wrote:
> > On 31/01/2024 15.18, David Woodhouse wrote:
> > > On Wed, 2024-01-31 at 13:18 +0100, Thomas Huth wrote:
> > > > Don't we have to change nd->macaddr.a[0 to 2] with this hard-coded
> > > > MAC-prefix, too?
> > >
> > > I don't think so.
> > >
> > > We either get the MAC address from 'nd' if that exists, or generate a
> > > new MAC address with qemu_macaddr_default_if_unset().
> > >
> > > Then we override the OUI in the actual device. We don't care about 'nd'
> > > any more at that point.
> >
> > I just double-checked, and yes, you're right, so:
> >
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Thank you, just just about completes my set. Every patch now has a
> Reviewed-by: except two of them (hw/s390x/s390-virtio-ccw and
> hw/arm/aspeed) which only have an Acked-by:
>
> I think according to The Rules I just need a maintainer to *tell* me to
> send a pull request and then I'm allowed to do so?

Yeah, go ahead and send a pullreq for this.

(I have a new board model brewing so it would be handy for me
to have the new functions upstream so I can create the ethernet
device in the right way :-))

thanks
-- PMM

