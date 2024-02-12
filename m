Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE4BC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRnK-0000nk-OZ; Mon, 12 Feb 2024 03:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRnG-0000nK-RQ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:36:03 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRnE-0004nL-2d
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:36:02 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d0b4ea773eso38565011fa.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707726957; x=1708331757; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHWaZQC14eQgQ7V9TCCZcxR6JY4opVWHHIIpaZIohVY=;
 b=TfXbxy5U1gTBBRQu05Ln9+LvOyX6hc9J6BLh0USCF++S8RlXiwPVId/J/weNvN9oPk
 0Bj7qYHaRGPFNPI5XC0w0MemR5+9UyBd7uAxpcK6Egp0TuVE3zqscf/miYsCOYmQ9FVx
 3wJnOnfnwcnw5imu10nFhTXGg1kb8efrsqzpgr9+3KMvOTSm0tiMfsc7awhv7Mr1rOI7
 EC7VdisGuf2/y6rOc8bnuG0sikNEdpccZng0NMj9z29H+beFbHWiLJ1AxWbQ9yNG0XW3
 TEWuh6l8dVSOHQ9ZGIDnAEWWiTaRl5sZ4mLywGBRMQ1urY0FQBx7Ng618qZY0hpEKkKy
 LmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707726957; x=1708331757;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GHWaZQC14eQgQ7V9TCCZcxR6JY4opVWHHIIpaZIohVY=;
 b=Lx4H8s16vi4dhcwdgdWyvwv4Xfjb5fVz4l6tNLDTm2eMtH6MfAa9NmuFxYIk52Udxi
 XulAv6wwT/1HzIzZdvyVb1legwOELEXB9h8Hvdp9tcQQdFTek3BPNNZofzS5gVZrmB1t
 NKqfmYr+CWmGbl1Qy/9G5LNNjPzYHzJcSmtbrZBVglA95/Jmk8fT5cdZPfXPymfXZ9Yl
 QEvhTiygyCi++HFELYflW9VcJwmYrBbZYbAXYJwRMbTeKTe7ziPP/mJVQh0ut7vkgMUd
 KkVo4cRU0dNwjP2J/tyZqM6PhJcG8TM/sSU2W0ovff/69BmLygDTNMOgnm5+wA/Qf+Th
 WI1A==
X-Gm-Message-State: AOJu0YzTbxQI4DuIarajt5zN+3rJVx2pGDTrlpuCUmzUdLfwmgqU1v1A
 TB1LMiT2Lti9Ke4DvWyb5BoFUQjxNVODT7IWTeoKnZEa4G6hRXL1QplflLaAKTWa19kDJLm+fqI
 w
X-Google-Smtp-Source: AGHT+IHu2+KkA7pZ/SrA+ijiebm8xF59L9pjcrWzg1gULV28qpgM20ouqj/G+498N6qoBEkYMW7PMg==
X-Received: by 2002:a2e:a4ae:0:b0:2d0:e35a:3ba3 with SMTP id
 g14-20020a2ea4ae000000b002d0e35a3ba3mr3422177ljm.49.1707726957324; 
 Mon, 12 Feb 2024 00:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXcR2Yt4F2u8/zTs7nLDuiEkrTSdK193bqfQlr802Zv1MOPSKUefoCy2mHCV3vetkEQYb8K9jmFwoFWMey9RKm1dWiIf7TXXwZ9F8qKJbHQoz7bFjITlr7zIVlOvoE9zpE6NThdeG3bbjkPLATuGIRi74Plx6CuKoqHTV2/t75qGcBqLWOjqgha/XGJu2QDNVqcS5aJICgWTvq/5iiK9cEbyWJx/ZM47sNr9zT89UIoz7Z/I4d6IFmPt58DGXdeLjmVYzi38afce07ysifFeJZinn8stHAFQzWFUttFFrQ9Yb2WqiKlJje7D7R6iu/b0T9lC+bps9nVaMgMn+frwfmLDHWX7lpWy+QQlqeHKFN5++pIm686GIUqekYhWdNtVpsEUoGB4iSfGWNfgfvSAw1c5Ciw6nqiWjlrq0F/qg95of93UtTcEY6b3p2Fbu80IHxvrmWsim/uUOM0KAo=
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 t37-20020a056402242500b0056104738371sm2552026eda.65.2024.02.12.00.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:35:56 -0800 (PST)
Message-ID: <152c09f3-c33e-4bf7-92ba-516dc4c128c7@linaro.org>
Date: Mon, 12 Feb 2024 09:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Knut Omang
 <knut.omang@oracle.com>, Knut Omang <knuto@ifi.uio.no>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: hw/qdev: Can qdev_unrealize() ever fail?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Hi,

QDev base class doesn't expect UNREALIZE to fail, and this
handler is only recommended for hot-plug devices:

/**
  * qdev_unrealize: Unrealize a device
  * @dev: device to unrealize
  *
  * Warning: most devices in QEMU do not expect to be unrealized. Only
  * devices which are hot-unpluggable should be unrealized (as part of
  * the unplugging process); all other devices are expected to last for
  * the life of the simulation and should not be unrealized and freed.
  */


   void qdev_unrealize(DeviceState *dev)
   {
       object_property_set_bool(OBJECT(dev), "realized",
                                false, &error_abort);
                                       ^^^^^^^^^^^^
   }

   static void device_unparent(Object *obj)
   {
       DeviceState *dev = DEVICE(obj);
       BusState *bus;

       if (dev->realized) {
           qdev_unrealize(dev);
       }
       while (dev->num_child_bus) {
           bus = QLIST_FIRST(&dev->child_bus);
           object_unparent(OBJECT(bus));
       }
       if (dev->parent_bus) {
           bus_remove_child(dev->parent_bus, dev);
           object_unref(OBJECT(dev->parent_bus));
           dev->parent_bus = NULL;
       }
   }

Now apparently some devices expect failures, see commit 7c0fa8dff8
("pcie: Add support for Single Root I/O Virtualization (SR/IOV)"):

   static void unregister_vfs(PCIDevice *dev)
   {
       uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
       uint16_t i;

       for (i = 0; i < num_vfs; i++) {
           Error *err = NULL;
           PCIDevice *vf = dev->exp.sriov_pf.vf[i];
           if (!object_property_set_bool(OBJECT(vf), "realized",
                                         false, &err)) {
                                                ^^^^
               error_reportf_err(err, "Failed to unplug: ");
           }
           object_unparent(OBJECT(vf));
           object_unref(OBJECT(vf));
       }
       ...
   }

(Note the failure path only emits a warning).

So instead of calling the QDev unrealize layer, this function is
calling the lower layer, QOM, bypassing the class handlers, leading
to further cleanups such commit 08f6328480 ("pcie: Release references
of virtual functions") or recent patch
https://lore.kernel.org/qemu-devel/20240210-reuse-v2-6-24ba2a502692@daynix.com/.

I couldn't find any explicit possible failure in:
  pci_qdev_unrealize()
  do_pci_unregister_device()
  pci_bus_unrealize()
so, what is the failure unregister_vfs() is trying to recover from?

I understand if a device is in a odd state, the kernel could reject
an unplug request. If so, how to deal with that cleanly?

Thanks,

Phil.

