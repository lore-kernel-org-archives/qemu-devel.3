Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A53606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BwqY4V7o;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=taT65RwZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2CO-0002Er-L4; Wed, 28 Oct 2026 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM2CN-0002EI-2U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM2CK-0005iW-Ou
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjmnUGkeyLoXxGVFg7ovRnmwZpAVgjnKV4mAyoDFHGY=;
 b=BwqY4V7ogq+UWeRa43ZRiN3CNIAY1xL1MTfDXucXMlNWGyB5AsAF2aiK7Krl0UHBoEW6b3
 KDmUJapQ0ie+SZRQ3MDgZQB/JXBtc558qXmb5u+RBpoltL5U1ieVb1eQWZfduPsBuJtRG/
 a2uGAqN+2xT/FrT05tWFHWkrSJrWytg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-owFL4B2pMViR91MPOfLBeg-1; Wed, 28 Oct 2026 07:51:56 -0400
X-MC-Unique: owFL4B2pMViR91MPOfLBeg-1
X-Mimecast-MFC-AGG-ID: owFL4B2pMViR91MPOfLBeg_1793188315
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so551882f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188315; x=1793793115; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bjmnUGkeyLoXxGVFg7ovRnmwZpAVgjnKV4mAyoDFHGY=;
 b=taT65RwZ/D2D7vHNO5EjN4hZh2y3lT4xl+hUBm/Ho0KkbSvIupf5YAOPJbTaXJRz2y
 GRPXY70+uqjVvrisQXh4aOJ+X+/Ez0TpegqSRjNqU31QKhaxvwTouig/7si7XFQML8Z5
 eT0+qZIxGzu3CuONOzKNYij/6fXtK5TkzzVhj29uLd98tHSNl9Y41K2JVF0SsizMaf9x
 B0q0nJZfmN+rsTGPZD2WX710UiKpDggDM6by2o/esrLKW1W5L0ab4LKDPFaQ7kMgaN4L
 U1kt8jLV7IcuIcHWEpFBzgTrxATahGDDq+e+/5qxL8qdEcjYB4vNOgnUalqpszMJvJt5
 Jylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188315; x=1793793115;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bjmnUGkeyLoXxGVFg7ovRnmwZpAVgjnKV4mAyoDFHGY=;
 b=2r5lJWScty8zFZiXWOGMHfs+XXo0gp/vmWIX5rYSClNxAXGs/iLcHrjP5iByqm2s2d
 V1ltOdy1PLk9n/KLV9FxFhld7762ANA9ohGHFE0moAT1ej1CtlSVtIi5KrSYxMHn9LnS
 gxGa91KTyscsZH6nbj49tn3Kl+sgO9P6suKmJrrqBcVFeke5y8lrPoH+qNpvw1a7pyrW
 6MPEHv/GbEYUnio4gJeBcQYbfUAW/ubuMxDDnu3cdrT9hQarny9GBmQkkZkDruytAbJb
 RVmmxFJwNMjbgDaJgp0qBcV8mOPy9vHcDzVJijlgMKbk5TPa7HCMTkTXRohmtKwcHqyR
 483A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5phTzvxxONNcveIVXK7nt4761FFmPIvyB9FVVzJ2zbnFFZu3KlhVlDRsC5ck1HzMiItESykyMfB/A@nongnu.org
X-Gm-Message-State: AFq9FYIrabDRWnVBy5k+SDQGfkYf8uP2TXbdiy4IrQZXhME/6cjG5Le/
 fJ/LMlULM6cRUGtMSmVjiO3HVaW0L6kdpV9nmIs1FgVDMTUnT4erElT45ICLdvTxNZ5GyJTR4qy
 LBQn70jSRPJKSaz70c17SY/naLhwYNYEoseJPgwAmXlIYS0NTlc/bkwPR
X-Gm-Gg: AYBFou1JG0B0f8WNFH8gurOfrdU1ORbEc55J7iGXTfigf7nBD7dV+suMDzsWd1DT8EY
 4bWLwQd/BQPYJvgciM2reafwX3Lg/JTL6O0BjfWZevRdo70lb2B/hN/tpzuWEz3Blz+sYX6mKWI
 kBg/TJMzVjh9E6hrpWTSDG7JCuuE57Kj1vVeFEh58E5ji5eLI+LrLPR6b7HHQYBPSIGHOC6Sx0T
 fcBbF9e8nh7wxk5oJNzHKC6PcWAPYYd5relxslwsLGmPQGWpSwqEbnAB9ri6AiyIWkhzjl2QXyy
 blza4BtLTEfYVxsd3E0uuLGpMd3aw6wvLeFkmhQW9R6PzKSFuihRHuICWRvMd7NJdqflOlWwCyf
 ZHu0wpPFwzjZKxwbYPrCQx+q/yjjmEQGc2RtTybcy
X-Received: by 2002:a05:6000:b85:b0:48c:43a3:6a74 with SMTP id
 ffacd0b85a97d-48e5d5c3a6amr4102579f8f.12.1793188314756; 
 Wed, 28 Oct 2026 04:51:54 -0700 (PDT)
X-Received: by 2002:a05:6000:b85:b0:48c:43a3:6a74 with SMTP id
 ffacd0b85a97d-48e5d5c3a6amr4102537f8f.12.1793188314120; 
 Wed, 28 Oct 2026 04:51:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdf9bdsm27014415f8f.55.2026.10.28.04.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:51:53 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:51:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: qemu-stable@nongnu.org,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] pcie_sriov: register user created virtual function
 before realizing it
Message-ID: <20261028074508-mutt-send-email-mst@kernel.org>
References: <20260905122924.53813-1-danielpaziyski@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905122924.53813-1-danielpaziyski@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 05, 2026 at 02:29:24PM +0200, Daniel Paziyski wrote:
> There are two ways of creating virtual functions: by using the sriov-pf device
> parameter (this way, creating a user created VF and binding it to a PF), or
> by using a device specific parameter, where the device manually creates a given
> amount of VFs.
> 
> When a PCI device is realized, the device specific realize function is called
> first, and then the pcie_sriov_register_device function is called, which checks
> whether the device that has been created is a user created VF, and if it is the
> case and the device allows this kind of VFs, it inserts it into a hashmap, with
> the key being the ID of the PF, and the items being arrays of VFs.
> 
> User created VFs are instantiated independently, and later, when the PF calls
> pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
> mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
> the pointer to the PF. This means that, during realization, VFs have no access
> to the PF.
> 
> Device created VFs are instantiated during or after PF realization using the
> pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
> before their realization, so when they're realized, they can access the PF
> with no issues.
> 
> The problem here is that pcie_sriov_register_device is called after the
> realization, and not before. This means that when a user created VF is created
> for a device which does not support user created VFs, but supports device
> created VFs, the realize function will notice that a VF is being created, and
> may try to access the PF, causing a null pointer dereference fault.
> 
> Fix this by placing the user created VF check and registering before the
> realization. This way, incorrectly created user created VFs will be noticed,
> and device creation will be aborted.
> 
> Additionally, remove from the pcie_sriov_register_device function the top
> check. It seems that this check is done to error out if the PF failed for some
> reason to initialize its list of user created VFs. However, in such situations,
> the pcie_sriov_pf_init_from_user_created_vfs function will error during
> realization, and it will be caught before the check is done at all. Moreover,
> since now pcie_sriov_register_device is called before realization, the check
> will always fail for PFs with user created VFs, because the list will be
> populated during realization.
> 
> The rest of the function though, correctly errors out if a user created VF
> is created for an unsupported device type, if a VF is created for a non-PCIe
> device, or if the PF is already instantiated, with now the advantage being
> that the check is done before the VF instantiation.
> 
> Moreover, move the unregistering of a device's acpi-index and the removal
> of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
> We do the former so that the acpi-index is unclaimed on user created VF
> creation error, and the latter to not have extra code on the device specific
> realization error path.
> 
> When instantiating a user created VF for a NVME controller:
> 
> Command line:
> 
>     qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
>     -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
>     -device nvme,id=ctrl0,subsys=subsys0,serial=s
> 
> ASAN splat:
> 
> ../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
> ==91050==The signal is caused by a READ memory access.
>     #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
>     #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
>     #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
>     #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
>     #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
>     #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
>     #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
>     #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
>     #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
>     #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
>     #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
>     #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
>     #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
>     #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
>     #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
>     #16 0x5644c801abf8 in main ../system/main.c:71
>     #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>     #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)
> 
> ==91050==Register values:
> rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
> rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
>  r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
> r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
> ==91050==ABORTING
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>

/scm/qemu/build/qemu-system-x86_64 -nodefaults -machine q35 -device
e1000e,addr=0.0 -device e1000e,addr=0.0

crashes with this:

- With the patch: SIGSEGV (exit 139), backtrace at hw/pci/pci.c:2334 in pci_qdev_realize.
- Without the patch: exit 1: PCI: slot 0 function 0 not available for e1000e, in use by mch,id=(null).



> ---
> 
> This patch is the same as
> https://lore.kernel.org/qemu-devel/20260901153721.10292-1-danielpaziyski@gmail.com/
> , which improves the original patch by releasing the acpi-index on failure, as
> pointed out by Michael S. Tsirkin <mst@redhat.com> on the replies of
> https://lore.kernel.org/qemu-devel/20260805124519.30054-4-danielpaziyski@gmail.com/
> ("[PATCH 3/3] pcie_sriov: register user created virtual function before realizing it")
> posted on the series
> https://lore.kernel.org/qemu-devel/20260805124519.30054-1-danielpaziyski@gmail.com/
> ("[PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes").
> 
> I am sending this as a patch separate from the series, since imo it was a mistake
> for me to mix unrelated patches on the same series.
> 
>  hw/pci/pci.c        | 42 ++++++++++++++++++++++++------------------
>  hw/pci/pcie_sriov.c |  6 ------
>  2 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c15f2b9f08..06c432292f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1223,6 +1223,19 @@ static void pci_config_free(PCIDevice *pci_dev)
>      g_free(pci_dev->used);
>  }
>  
> +static void pci_unregister_acpi_index(PCIDevice *pci_dev)
> +{
> +    if (pci_dev->acpi_index) {
> +        GSequence *used_indexes = pci_acpi_index_list();
> +
> +        g_sequence_remove(g_sequence_lookup(used_indexes,
> +                          GINT_TO_POINTER(pci_dev->acpi_index),
> +                          g_cmp_uint32, NULL));
> +
> +        pci_dev->acpi_index = 0;
> +    }
> +}
> +
>  static void do_pci_unregister_device(PCIDevice *pci_dev)
>  {
>      pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
> @@ -1236,6 +1249,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
>                                      &pci_dev->bus_master_enable_region);
>      }
>      address_space_destroy(&pci_dev->bus_master_as);
> +
> +    pcie_sriov_unregister_device(pci_dev);
> +    pci_unregister_acpi_index(pci_dev);
>  }
>  
>  /* Extract PCIReqIDCache into BDF format */
> @@ -1487,7 +1503,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
>  
>      pci_unregister_io_regions(pci_dev);
>      pci_del_option_rom(pci_dev);
> -    pcie_sriov_unregister_device(pci_dev);
>  
>      if (pc->exit) {
>          pc->exit(pci_dev);
> @@ -1497,17 +1512,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
>      do_pci_unregister_device(pci_dev);
>  
>      pci_dev->msi_trigger = NULL;
> -
> -    /*
> -     * clean up acpi-index so it could reused by another device
> -     */
> -    if (pci_dev->acpi_index) {
> -        GSequence *used_indexes = pci_acpi_index_list();
> -
> -        g_sequence_remove(g_sequence_lookup(used_indexes,
> -                          GINT_TO_POINTER(pci_dev->acpi_index),
> -                          g_cmp_uint32, NULL));
> -    }
>  }
>  
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> @@ -2318,8 +2322,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>      pci_dev = do_pci_register_device(pci_dev,
>                                       object_get_typename(OBJECT(qdev)),
>                                       pci_dev->devfn, errp);
> -    if (pci_dev == NULL)
> +    if (pci_dev == NULL) {
> +        pci_unregister_acpi_index(pci_dev);

So this passes NULL to pci_unregister_acpi_index.



>          return;
> +    }
> +
> +    if (!pcie_sriov_register_device(pci_dev, errp)) {
> +        do_pci_unregister_device(pci_dev);
> +        return;
> +    }
>  
>      if (pc->realize) {
>          pc->realize(pci_dev, &local_err);
> @@ -2330,11 +2341,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>          }
>      }
>  
> -    if (!pcie_sriov_register_device(pci_dev, errp)) {
> -        pci_qdev_unrealize(DEVICE(pci_dev));
> -        return;
> -    }
> -
>      /*
>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>       * associate only Device 0 with the device attached to the bus
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index c41ac95bee..69930c7b8c 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>  
>  bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
>  {
> -    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
> -        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
> -        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
> -        return false;
> -    }
> -
>      if (dev->sriov_pf) {
>          PCIDevice *pci_pf;
>          GPtrArray *pf;
> -- 
> 2.55.0


