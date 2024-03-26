Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF7BCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5z6-0004A1-W7; Tue, 26 Mar 2024 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp5z2-00048q-U9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp5z1-0000Pv-0D
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711456369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/l69Z9rozSYuTRpl9vVHjZZ4EL9Q0nWejf/8b5bGZE=;
 b=Hd80eDD+wZYEcPnNyYlZYWGRwYxB6Qp3TlAWElh3rNHTczuJUyEqB0mY/wZr+BQYhBLbWI
 couYXRWmUcm5LyZCR33M3C279f744xOce/xoXNaeZ6KC9boPCQFfv0q1T2jlwAW1Y3zQ6B
 HAmbA5FxFyNdtoqIf/S/GXgt+fSzdoo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-GBPIzVPUPni0tHb-AQfETA-1; Tue, 26 Mar 2024 08:32:48 -0400
X-MC-Unique: GBPIzVPUPni0tHb-AQfETA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d496045d19so49742121fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456366; x=1712061166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/l69Z9rozSYuTRpl9vVHjZZ4EL9Q0nWejf/8b5bGZE=;
 b=Tas4I3ukOKq8378Q0fSuOe0Cl/4aUKNe9af/BuIRXpbgGw0XISjctwDzC1nbcWgU5z
 eKd9cjhQLwDzguEV500OqzT1TYV+SYpURNyxn14deK2+VPSRCg2reqFPlnnmD+jCUnT3
 aASuVBcaW5Q35oj4Zqipvjy31j7+FZch94XYx1MP2M5rlmxFhTaK7QiY2M73JXeU8S0O
 Es/wAraBeNl8uokerpor7K85Dt9RVML/up32o5Eg5v2Qpw8iHTdkoTTQMpuzdjM4jpmM
 wK8d1AIbapxMhj696HOAM16kG86rKovE9tXH3jhbBYP+8oXr1Pn6yZZhBmsPe17svf29
 urCA==
X-Gm-Message-State: AOJu0Yx1Mg8JGaEmhWj+d5mptX1VUMACwVqdCtdb/nNXvueTqEcBEDBL
 rUwtooBqUii++htrY4UsKFiuLiGjb88RGz+vjUBHeU/bwQG5G5QD9BrkNGCEqNgYP/geGW5tPdp
 0NCCb+ruknWdoooi4uHF2DpKEf1r+Te4ndcNZh8WPcItYaDFGKro+
X-Received: by 2002:a2e:7a0e:0:b0:2d6:cb40:e0a2 with SMTP id
 v14-20020a2e7a0e000000b002d6cb40e0a2mr1846593ljc.53.1711456366544; 
 Tue, 26 Mar 2024 05:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESjtEAYmfJt1gJiZF2rmvxvpDQxZasAbTOCx3ZMckfn+I3orqTCFDD9mhy74BDkNEX3uZKBA==
X-Received: by 2002:a2e:7a0e:0:b0:2d6:cb40:e0a2 with SMTP id
 v14-20020a2e7a0e000000b002d6cb40e0a2mr1846567ljc.53.1711456365994; 
 Tue, 26 Mar 2024 05:32:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h33-20020a05600c49a100b004148090cf76sm1161550wmp.0.2024.03.26.05.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:32:45 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:32:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
Message-ID: <20240326133244.30d0c6cf@imammedo.users.ipa.redhat.com>
In-Reply-To: <604bf457-23a7-4d06-b59f-a7b46945c626@tls.msk.ru>
References: <20240325130920.349521-1-mjt@tls.msk.ru>
 <20240325162049.46c2a758@imammedo.users.ipa.redhat.com>
 <604bf457-23a7-4d06-b59f-a7b46945c626@tls.msk.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

On Mon, 25 Mar 2024 21:01:42 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 25.03.2024 18:20, Igor Mammedov wrote
> > On Mon, 25 Mar 2024 16:09:20 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> >   
> >> When building qemu with smbios but not legacy mode (eg minimal microvm build),
> >> link fails with:
> >>
> >>    hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
> >>
> >> This is because fw_cfg interface can call this function if CONFIG_SMBIOS
> >> is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.  
> > 
> > stub supposedly should have handled that
> > what configure options do you use to build 'minimal microvm'?  
> 
> This is a custom build, not only configure options but also custom
> devices.mak: https://salsa.debian.org/qemu-team/qemu/-/blob/master/debian/microvm-devices.mak
> 
> ================== cut ==========================
> # see configs/devices/i386-softmmu/default.mak
> # for additional devices which can be disabled
> #
> CONFIG_PCI_DEVICES=n
> # we can't disable all machine types (boards) as of 6.1
> # since the resulting binary fails to link
> #CONFIG_ISAPC=y
> #CONFIG_I440FX=y
> CONFIG_Q35=y
> CONFIG_MICROVM=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_SERIAL=y
> CONFIG_VIRTIO_INPUT=y
> CONFIG_VIRTIO_INPUT_HOST=y
> CONFIG_VHOST_USER_INPUT=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_SCSI=y
> CONFIG_VIRTIO_RNG=y
> CONFIG_VIRTIO_CRYPTO=y
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_MEM=y
> CONFIG_VIRTIO_PMEM=y
> CONFIG_VIRTIO_GPU=y
> CONFIG_VHOST_USER_GPU=y
> ================== cut ==========================
> 
> Relevant configure options:
> https://salsa.debian.org/qemu-team/qemu/-/blob/master/debian/rules#L293-308
> 
> 		../../configure ${common_configure_opts} \
> 		--extra-cflags="${extra-cflags} -DCONFIG_MICROVM_DEFAULT=1" \
> 		--without-default-features \
> 		--target-list=x86_64-softmmu --enable-kvm --disable-tcg \
> 		--enable-pixman --enable-vnc \
> 		--enable-attr \
> 		--enable-coroutine-pool \
> 		--audio-drv-list="" \
> 		--without-default-devices \
> 		--with-devices-x86_64=microvm \
> 		--enable-vhost-kernel --enable-vhost-net \
> 		--enable-vhost-vdpa \
> 		--enable-vhost-user --enable-vhost-user-blk-server \
> 		--enable-vhost-crypto \
> 
> I dunno how relevant these are, - it come from ubuntu and I haven't
> looked there for a long time.  The idea was to have a build especially
> for microvm with minimal footprint, as light as possible, for fastest
> startup time etc.
> 
> Enabling (selecting) CONFIG_SMBIOS does not help since it is already
> enabled by something, but not SMBIOS_LEGACY (which should not be
> enabled in this case).

I'll look into what pulls in fwcfg and SMBIOS into microvm only config

> I still think it is better to avoid pcmc->smbios_legacy_mode variable
> (field) entirely.

Defines are usually frowned upon in QEMU and stubs
are typically preferred way to go.

I've just sent a patch adding a missing stub,
fill free to take it via your tree if time permits.

> 
> Thanks,
> 
> /mjt
> 
> >>
> >> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
> >> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> >> ---
> >>   hw/i386/fw_cfg.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> >> index d802d2787f..d5e78a9183 100644
> >> --- a/hw/i386/fw_cfg.c
> >> +++ b/hw/i386/fw_cfg.c
> >> @@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
> >>       /* tell smbios about cpuid version and features */
> >>       smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
> >>   
> >> +#ifdef CONFIG_SMBIOS_LEGACY
> >>       if (pcmc->smbios_legacy_mode) {
> >>           smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
> >>                                                   &error_fatal);
> >> @@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
> >>                            smbios_tables, smbios_tables_len);
> >>           return;
> >>       }
> >> +#endif
> >>   
> >>       /* build the array of physical mem area from e820 table */
> >>       mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());  
> > 
> >   
> 


