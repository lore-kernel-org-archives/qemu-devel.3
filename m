Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41558C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpO1-0001fg-6a; Thu, 11 Jul 2024 04:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRpNv-0001bj-Ex
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRpNt-0001KL-AZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720687356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLLQQ7u28thkrvI9T+RnLNtMUCZqBAgDD8Z7nQYjl5Q=;
 b=ekgj/L5VFpiSPRcK/7A+uoVjyTmROLKZVyrFlpM5Uub2gvnlR3nRyTSJby40nu6Ipdh0yU
 IiGKzLhHT78mGJovkW+FP/f01wjuOFyl1mVnLR8E7/tM6uuJTyzsLnLvsTACGv+P5G2ywe
 hxZJm483bX+P3lrJlQaEVq2/SRZveY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-WrZ-hChaPA-FdKbuz4qlcw-1; Thu, 11 Jul 2024 04:42:33 -0400
X-MC-Unique: WrZ-hChaPA-FdKbuz4qlcw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-426679bc120so4298355e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 01:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720687352; x=1721292152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLLQQ7u28thkrvI9T+RnLNtMUCZqBAgDD8Z7nQYjl5Q=;
 b=kHQIjHCkwM/5BIhjWq1w5gayRpZKYXcBpRS99PwihBo9+xv0wCg2vGlf+eAF4ICEnV
 zafF2slIVZ/05934VBlP+oNjAK3PIRVMIRUfYO4L7mERGAVZgISO+imgjFacVpBbywwW
 UcGSKHHbhtbmxdJqqtrhkuopGnRKJR0HT1iPa0cPRMYqV6ol+DeidI9Ds+GeWXBkQDyX
 6VZG8VuUM5zKMBFlV4wMA0ZeX61JZr+avVLM5eCcU8kpDXmYEm5Fvzhrw2pybuEwIcGg
 Ltrlbo3kH/Jxowqm0eEyO9drMVIPuA39lRfVIrYwycyhzIRasKVpTN6tZSbH/Yj53oQg
 u34A==
X-Gm-Message-State: AOJu0Yx448ry5bnsjs8NaidUC7qqaWvM4TkD0ML/rTPckPxYBsGdeP4r
 Xv/lXIHkSfX80kzS4Qo+e71KJDCGtUBq9hIQRodYI7eiiGvgurPDmG4v/fkZ69XaMc03ovQNyZK
 ZPHGhTcYTO1jtekS1b0xGaO8YhIyFbe+yqEFmfuIkptoAPL4+cVr4
X-Received: by 2002:a05:600c:6d6:b0:426:6e79:fa31 with SMTP id
 5b1f17b1804b1-426708f8fb5mr46693405e9.40.1720687352274; 
 Thu, 11 Jul 2024 01:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CWYzNHstA0VzT69dt+WlUQvckkr4nGOwj+b3gaAe6uuwnmExD6zTwyHdHKRdnCStSNQEVg==
X-Received: by 2002:a05:600c:6d6:b0:426:6e79:fa31 with SMTP id
 5b1f17b1804b1-426708f8fb5mr46693345e9.40.1720687351905; 
 Thu, 11 Jul 2024 01:42:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279554cae1sm51671155e9.8.2024.07.11.01.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 01:42:31 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:42:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 wangyanan55@huawei.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 anisinha@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH] smbios: make memory device size configurable per Machine
Message-ID: <20240711104230.1582fba0@imammedo.users.ipa.redhat.com>
In-Reply-To: <d921c3d3-71a9-49e4-9f28-1ff3f19b9c48@linaro.org>
References: <20240711074822.3384344-1-imammedo@redhat.com>
 <d921c3d3-71a9-49e4-9f28-1ff3f19b9c48@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 11 Jul 2024 10:19:27 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Igor,
>=20
> On 11/7/24 09:48, Igor Mammedov wrote:
> > Currently SMBIOS maximum memory device chunk is capped at 16Gb,
> > which is fine for the most cases (QEMU uses it to describe initial
> > RAM (type 17 SMBIOS table entries)).
> > However when starting guest with terabytes of RAM this leads to
> > too many memory device structures, which eventually upsets linux
> > kernel as it reserves only 64K for these entries and when that
> > border is crossed out it runs out of reserved memory.
> >=20
> > Instead of partitioning initial RAM on 16Gb chunks, use maximum
> > possible chunk size that SMBIOS spec allows[1]. Which lets
> > encode RAM in Mb units in uint32_t-1 field (upto 2047Tb).
> > As result initial RAM will generate only one type 17 structure
> > until host/guest reach ability to use more RAM in the future.
> >=20
> > Compat changes:
> > We can't unconditionally change chunk size as it will break
> > QEMU<->guest ABI (and migration). Thus introduce a new machine class
> > field that would let older versioned machines to use 16Gb chunks
> > while new machine type could use maximum possible chunk size.
> >=20
> > While it might seem to be risky to rise max entry size this much
> > (much beyond of what current physical RAM modules support),
> > I'd not expect it causing much issues, modulo uncovering bugs
> > in software running within guest. And those should be fixed
> > on guest side to handle SMBIOS spec properly, especially if
> > guest is expected to support so huge RAM configs.
> > In worst case, QEMU can reduce chunk size later if we would
> > care enough about introducing a workaround for some 'unfixable'
> > guest OS, either by fixing up the next machine type or
> > giving users a CLI option to customize it.
> >=20
> > 1) SMBIOS 3.1.0 7.18.5 Memory Device =E2=80=94 Extended Size
> >=20
> > PS:
> > * tested on 8Tb host with RHEL6 guest, which seems to parse
> >    type 17 SMBIOS table entries correctly (according to 'dmidecode').
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   include/hw/boards.h |  4 ++++
> >   hw/arm/virt.c       |  1 +
> >   hw/core/machine.c   |  1 +
> >   hw/i386/pc_piix.c   |  1 +
> >   hw/i386/pc_q35.c    |  1 +
> >   hw/smbios/smbios.c  | 11 ++++++-----
> >   6 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index ef6f18f2c1..48ff6d8b93 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -237,6 +237,9 @@ typedef struct {
> >    *    purposes only.
> >    *    Applies only to default memory backend, i.e., explicit memory b=
ackend
> >    *    wasn't used.
> > + * @smbios_memory_device_size:
> > + *    Default size of memory device,
> > + *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
> >    */
> >   struct MachineClass {
> >       /*< private >*/
> > @@ -304,6 +307,7 @@ struct MachineClass {
> >       const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machi=
ne);
> >       int64_t (*get_default_cpu_node_id)(const MachineState *ms, int id=
x);
> >       ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> > +    uint64_t smbios_memory_device_size; =20
>=20
> Quick notes since I'm on holidays (not meant to block this patch):
>=20
> - How will evolve this machine class property in the context of
>    a heterogeneous machine (i.e. x86_64 cores and 1 riscv32 one)?

I'm not aware of a SMBIOS spec (3.x) that cares about that heterogeneous
setup yet. Are there anything in that area exists yet?

> - Should this become a SmbiosProviderInterface later?
if/when SMBIOS does get there (heterogeneous machines), introducing
an interface might make a sense.

>=20
> >   };
> >  =20
> >   /**
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index b0c68d66a3..719e83e6a1 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
> >   static void virt_machine_9_0_options(MachineClass *mc)
> >   {
> >       virt_machine_9_1_options(mc);
> > +    mc->smbios_memory_device_size =3D 16 * GiB;
> >       compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_l=
en);
> >   }
> >   DEFINE_VIRT_MACHINE(9, 0) =20
>=20
> [...]
>=20


