Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8130BC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSvO-00018G-Om; Mon, 12 Feb 2024 04:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZSvM-000174-M6
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:48:28 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZSvK-0001Ek-LC
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:48:28 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e0a4823881so665538b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707731305; x=1708336105;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzt/Vb/jV8DpfjMSuqtPrLBrMdfboK3yk4hVp3a2nQE=;
 b=u9JvPTEy6iUlQQftzu/ngvtTHF1D5Z8DXIfOkouWZfNNVYoYOsSULtei8PpMHr+jZ2
 UoaniakQRoKpWGbuZRSj1ye8lmKmFg2FxzWLWCyRnPBXGOrKj63O4bz69iAs8Iy0V5xv
 54O8dDOu/lQ5SjSx6D4zwiJUKYTxkkOsZZf0a01o+pyVDtQonW9qfy0CxyQEB0L0xnUL
 aWiXsAqoXVJtbrKDWfuxz1QcVpsrIuhOpiJY1JEGvoaMdtUlBW7s02seQ0ze/fAZFe0z
 24lI9fTaxse15/aLaUgePa2RNu7Yx2xg0SqYpJBaA/38Jl9Hcw2mcRA+OyCftqPh8qfu
 dP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707731305; x=1708336105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzt/Vb/jV8DpfjMSuqtPrLBrMdfboK3yk4hVp3a2nQE=;
 b=MZmVo1TWvLM2Wg21I4YVomfxjSPixLN3sP9sY4E7futfNLk1lkLR3XMY15xL6kLIip
 BCDhp1daKrUlH5u+rJbTk8V27Gb7yp2As7MmbyesiTFvzqo3RDH1fWG9xdap7KtnZIII
 JisQCDkeRNthucXmwoM44GH8aL1nUHYUcWLDgt7xJpHazBOoee6YK+Ri3Q4b0CVWm+/Q
 H9Y1mEz54+00YnUGoYAUlR25cyJyXufbABFYqykHRz+Vk4S9hNMNOkz57nr8NJ6etBBz
 0BIOrheocKUxIYJaaN2Upw99tpyuR2DMGE4LSn3gA518dBR0LT8yB71R0jXZYOsdz7PE
 qOOQ==
X-Gm-Message-State: AOJu0Yzja26D3a0mwEGYGlnNVW4cdoMXC7EkhrbcNHBIwSHZQjhB8L8K
 ijDkZtSt2JkHuXEaqES1Rxby9/jHxI1MFhfLId5fC/X3Q77jNvrO+guwyMF621A=
X-Google-Smtp-Source: AGHT+IHlTPvxsqfcYHre3VhlvXeFKfZkNP7amfmBTIgNilluuwss9HoFGg6DUXXRMBKU/qnn3xGJlA==
X-Received: by 2002:a62:d441:0:b0:6e0:d1e5:1336 with SMTP id
 u1-20020a62d441000000b006e0d1e51336mr2267372pfl.28.1707731304944; 
 Mon, 12 Feb 2024 01:48:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXce8dePDhgCG7rar+yGKxaWMO0PuTfq9sFpf7t+abybP5LgL6uTOTVUriUausAIBNou1+8f3OfA2TYKyar/ejDqlUgohKe2SxHYrNlKGRCHThJcF3Sk4/c1Wr0F6iUrBNMmCZZItrGnHsaqZHclSuP+P8QhTrvveV1T35/W2WakdYOV8tmqUqimrDgtYiSV7LnKc7Uvcf6Y9YzGikRu09TbPRdesJQ1EScgy+f5XMZmTgpdhMTvaydvZX1yMoFUcWdCYhr866+KYQh5l5F515e5xRrPSakZshXawOGp0lXPOMeuh4GKKCtj/Zs18p35K/q3UOQxMSggXjgKR8Fa+Wwtke7d/npst6ZFdzLGcRSt3Z9Qfa9seYlVy5/NeUIrddPnaJMWEXOfh5FoDnWXHaME1397Lmbk3NQLpuWqOTOEH94NAPRJDJAZbjmqMPc/9tmJQrtqNluMg0=
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 t27-20020a62d15b000000b006e03a640007sm5339750pfl.71.2024.02.12.01.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 01:48:24 -0800 (PST)
Message-ID: <bb1a1651-3181-4c7f-ac2c-e2c4a5267347@daynix.com>
Date: Mon, 12 Feb 2024 18:48:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw/qdev: Can qdev_unrealize() ever fail?
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Knut Omang <knut.omang@oracle.com>, Knut Omang <knuto@ifi.uio.no>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <152c09f3-c33e-4bf7-92ba-516dc4c128c7@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <152c09f3-c33e-4bf7-92ba-516dc4c128c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/12 17:35, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> QDev base class doesn't expect UNREALIZE to fail, and this
> handler is only recommended for hot-plug devices:
> 
> /**
>   * qdev_unrealize: Unrealize a device
>   * @dev: device to unrealize
>   *
>   * Warning: most devices in QEMU do not expect to be unrealized. Only
>   * devices which are hot-unpluggable should be unrealized (as part of
>   * the unplugging process); all other devices are expected to last for
>   * the life of the simulation and should not be unrealized and freed.
>   */
> 
> 
>    void qdev_unrealize(DeviceState *dev)
>    {
>        object_property_set_bool(OBJECT(dev), "realized",
>                                 false, &error_abort);
>                                        ^^^^^^^^^^^^
>    }
> 
>    static void device_unparent(Object *obj)
>    {
>        DeviceState *dev = DEVICE(obj);
>        BusState *bus;
> 
>        if (dev->realized) {
>            qdev_unrealize(dev);
>        }
>        while (dev->num_child_bus) {
>            bus = QLIST_FIRST(&dev->child_bus);
>            object_unparent(OBJECT(bus));
>        }
>        if (dev->parent_bus) {
>            bus_remove_child(dev->parent_bus, dev);
>            object_unref(OBJECT(dev->parent_bus));
>            dev->parent_bus = NULL;
>        }
>    }
> 
> Now apparently some devices expect failures, see commit 7c0fa8dff8
> ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)"):
> 
>    static void unregister_vfs(PCIDevice *dev)
>    {
>        uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
>        uint16_t i;
> 
>        for (i = 0; i < num_vfs; i++) {
>            Error *err = NULL;
>            PCIDevice *vf = dev->exp.sriov_pf.vf[i];
>            if (!object_property_set_bool(OBJECT(vf), "realized",
>                                          false, &err)) {
>                                                 ^^^^
>                error_reportf_err(err, "Failed to unplug: ");
>            }
>            object_unparent(OBJECT(vf));
>            object_unref(OBJECT(vf));
>        }
>        ...
>    }
> 
> (Note the failure path only emits a warning).
> 
> So instead of calling the QDev unrealize layer, this function is
> calling the lower layer, QOM, bypassing the class handlers, leading
> to further cleanups such commit 08f6328480 ("pcie: Release references
> of virtual functions") or recent patch
> https://lore.kernel.org/qemu-devel/20240210-reuse-v2-6-24ba2a502692@daynix.com/.
> 
> I couldn't find any explicit possible failure in:
>   pci_qdev_unrealize()
>   do_pci_unregister_device()
>   pci_bus_unrealize()
> so, what is the failure unregister_vfs() is trying to recover from?

When unrealizing, device_set_realized() is only used to report that the 
device is not hotpluggable.

> 
> I understand if a device is in a odd state, the kernel could reject
> an unplug request. If so, how to deal with that cleanly?

The guest kernel requests to unregister VFs so QEMU shouldn't ask it if 
they should be unplugged again. I think that's why unrealize_vfs() 
doesn't use qdev_unplug().

In any case, with "[PATCH v2 5/6] pcie_sriov: Reuse SR-IOV VF device 
instances", the runtime realization/unrealization code is replaced with 
PCI-specific device enablement code, which derives from PCI power down 
logic. While the patch was written to deal with realization errors, it 
also eliminates the need to unrealize VFs at runtime.

Regards,
Akihiko Odaki

