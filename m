Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B062D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFc6o-0005LS-K9; Mon, 25 Nov 2024 11:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFc6l-0005L3-Q7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:38:43 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFc6k-0005ZV-2R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:38:43 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cfbeed072dso5887830a12.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732552720; x=1733157520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W2PHlqzuLwSu++3qOdo0UFQcb9hDu43m0wkS5CHwmk=;
 b=dXkyMcJZD6tEO78Q6whCbX4m1va3sfA6gaKqIh4w5pZAL7R8eNSNbLdj+obHTohlxo
 ARGrFZXIigmuHc5dG3Oc5SAwVKsNerGepw1p154GcV8QudrapDfY03V4kzDiYD2VMuEV
 TcGkuJg3Coo+Arfcvvzl5fsWT0iAhoYHCiRIW/KR8dbLM591bzkqYkGeJ5PFpR/bb+Ex
 Y1TreqINN7X1B4sRqOfExMK6WxkNhexlVZ1FXgQOTqOuLu3BbHNOUbms3sNVn0hqaPmC
 qccDvcmJ4mwXwcPJj7LhXL+BxvqGCuk2g2P17mkbaqCv+n/QSFw3eVk5a+sH5/m6ipN9
 mifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732552720; x=1733157520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W2PHlqzuLwSu++3qOdo0UFQcb9hDu43m0wkS5CHwmk=;
 b=FVbfBTYLgxjG2NKzB4CUVthldf1sDWrewNorwrgAKJXw938BBECaQddmXEtzxflTX4
 g+7hRuwM9qYJ75olAH/KIlS1Q5MWrUKPBTGoOV2NyPovbxH6caZGB5YXHs9XTBWRy0jG
 s3qVddxhneN7TiVLv1zF7YPsO8KkERCok70rmUBHohhiLwd5gbV4wjXA0/cioyW/zce5
 OTIchW4+rg34sI5F99vLtl5pdXZ7R2UKt7NhbRAnxUOle/iJWkWIgCoMB55Aux+QW55j
 5eroar7C+Wz8l8PiJf/a3uLTimFucn+iJ1V4dlPOY7olQuJIhT6GTX8AhFzcigoW4uv5
 oKig==
X-Gm-Message-State: AOJu0Yw4kB8ukJqDYTRcXAwvySW3aQ1HWhVmoIE1nWat3cyB738NjAkU
 ciTmoiNOlm4Nu4r2uLjiB/AQ0/4pofJu+TNqVlILm/DaweAUW9BOLPyX4COqi3VLl1RFvGU9D94
 f8Tgn7lOryrcgiBH1ihopXTOj/E/9+abLOHe7OQ==
X-Gm-Gg: ASbGncvl2KBU5ryxqwzH9TN6OXS/as8R72UWr6cvx7zGYg4vP2PsWAoXbMsuInJQMUz
 usxEi61tt2gTSWFHoHr/q7aciHM/0+ExC
X-Google-Smtp-Source: AGHT+IHpG4BNQkKwovRSHjcSSztWlba5dB3PINZvZhJcLTuNIqrxSBgvDeVJecoM+DsuSSZygBRxjfRRUePFb9VhGdw=
X-Received: by 2002:a05:6402:1ecc:b0:5cf:c188:81b6 with SMTP id
 4fb4d7f45d1cf-5d0205c7491mr11920947a12.6.1732552720004; Mon, 25 Nov 2024
 08:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20241125140535.4526-1-philmd@linaro.org>
 <CAFEAcA9vS-9u282Jr+_QaGZT6vD4cpmh0wjuYPQSPLZQw30e4Q@mail.gmail.com>
 <748eb21d-4b73-4d2a-8058-b3a79d4fb802@linaro.org>
In-Reply-To: <748eb21d-4b73-4d2a-8058-b3a79d4fb802@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 16:38:29 +0000
Message-ID: <CAFEAcA_NqH5v5Oii2dQqw_Lx66u=Fkbqq6WGnOHF_Z0jfumgSg@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 0/8] hw/boards: Remove legacy
 MachineClass::pci_allow_0_address flag
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-ppc@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Alexander Gordeev <agordeev@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 25 Nov 2024 at 14:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 25/11/24 15:14, Peter Maydell wrote:
> > On Mon, 25 Nov 2024 at 14:06, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> This series aims to remove a legacy field from
> >> MachineClass.
> >>
> >> Rather than a global exposed to all machines,
> >> use a pci-bus specific flag on each machine
> >> requiering it.
> >
> > Should this be a property of the PCI controller, rather
> > than on the PCI bus? Presumably on the machines that
> > don't allow a 0 PCI BAR address this happens because the
> > PCI controller refuses to map BARs at that address.
> >
> > TBH the commit message for e402463073 suggests to me
> > that "allow address zero" should be the default and
> > either specific machines should forbid it or else we
> > should figure out what goes wrong with them, if the
> > problem is caused by some bug in QEMU. The commit message's
> > mention of "fix PCI memory priorities" suggests to me
> > that this is a QEMU bug, and that it ought to be possible
> > to have the machine set up such that you *can* map the
> > BAR at address 0, it's merely invisible to the guest because
> > some other machine devices have higher priority and are
> > visible "on top" of it instead.
>
> You are probably right, the following comment ...:
>
>   pcibus_t pci_bar_address(PCIDevice *d,
>                            int reg, uint8_t type, pcibus_t size)
>   {
>       ...
>       /* NOTE: we do not support wrapping */
>       /* XXX: as we cannot support really dynamic
>          mappings, we handle specific values as invalid
>          mappings. */
>       if (last_addr <=3D new_addr || last_addr =3D=3D PCI_BAR_UNMAPPED ||
>           (!allow_0_address && new_addr =3D=3D 0)) {
>           return PCI_BAR_UNMAPPED;
>       }
>
> ... is from 20 years ago at the beginning of PCI in QEMU, commit
> 0ac32c8375 ("PCI interrupt support - PCI BIOS interrupt remapping
> - more accurate memory mapping - 'info pci' monitor command") which
> suggest the implementation is incomplete here.

See also this thread from 2015:

https://lore.kernel.org/qemu-devel/1444683308-30543-1-git-send-email-agorde=
ev@redhat.com/T/#u

which includes:
 * me asking why this isn't a property on the PCI controller device :-)
 * MST confirming that this setting is only for buggy machine types
   that don't get the priorities correct when the BAR is configured
   so it overlaps something else
 * me expressing disappointment that we made the default for this
   flag be "this machine type is broken" rather than "this machine
   type is not broken", because of course almost every machine added
   since has left the flag at its default value
 * a now out-of-date list of possibly affected machine types that
   might actually need to mark themselves as "broken", or at least
   be tested to see what they do

thanks
-- PMM

