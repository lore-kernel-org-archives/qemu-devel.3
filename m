Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2192CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 17:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL2eI-0005F2-Vt; Thu, 07 May 2026 13:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2eH-0005EO-5n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wL2eF-0006Sh-N3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 13:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778175390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFfb8ukSxjrvab437Ml3VXB4JIB0eoMU0nLv+cfuzAI=;
 b=VnVx3giX6bBC6Ha0CLFkLWXQxzAdLw+8/xNyKAPCTCi4r3GvEnRcj9uNxBz/+zwuMQSZCM
 inr6XF/+ILu1i4ZH1r/HdbpeIMYGQgo6xvFEU4vyfvcrLr3zs0x00iIr517ZyPkBQVIcE5
 tpIZGwutggRJB6AVDD6bJ+Gx0A02QJs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-uVYx3oNQN3uRSiNHlQP9RQ-1; Thu, 07 May 2026 13:36:29 -0400
X-MC-Unique: uVYx3oNQN3uRSiNHlQP9RQ-1
X-Mimecast-MFC-AGG-ID: uVYx3oNQN3uRSiNHlQP9RQ_1778175388
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so8376515e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778175388; x=1778780188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFfb8ukSxjrvab437Ml3VXB4JIB0eoMU0nLv+cfuzAI=;
 b=EhV0iMMG5Xk7Nuyohht2g+nDJD75MiQDzHv3pYDcvB2WIk3uQyskPm8E8Lx1fAwuhu
 swy9DKvTUGRiDjgcYxZ9ONurwRWxjGTD6zK/wra3HWKaGUHgsuBA1TFpraxDFRjHeXcB
 +3PPdhXQe8TUtMh/wFQ6XoSijs+cmQQxnEjqR/TtLa9M55RUnQjCuycihzMJsrhJ4B7p
 BDnerqM8G3A/4l01QvrteJiiJs92xhRrUM9mR9/5GFkVu6EigHTJ0j1wJlLs9KfAwm81
 vGHIYsyHXcjrv94SCQKHgJfqJaP7b6nlEDIAvh7MoUwxEkWakfjjm06SGDGaX35el78E
 s8Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i2ipqn/n7v+rqbAVZISg2SHpK3QL5agcLLbSRejoiQUytcCdw66IrTG7WNAe0fOALs1N/EnlnvHzx@nongnu.org
X-Gm-Message-State: AOJu0YwRAI/609EqsXeX3nCMoz88O2fspSd82XdFZP7mlXIj27FcAheT
 zewaJJcdRmkSdloLtFoML4ndHsr0YROP6CswkVaWwVlEcBEkYiIRTYS8jkzMEHpquFeqgP50UEO
 Iw1vLsBEua2flD7tk3unxYOYW5zPHttVUdvJssc18PSRi9NjPJ9WAnd7RFbbyz2cc
X-Gm-Gg: AeBDievLKy2YzesiodfFeDCH32RQDYfDpwXoRTxs6rmAvesv04XZgMAiZ805g2Oj8Qy
 3+qIvoQSFIzXPtqp1JJ74zEDMXbHhJdu5iJpzIbY1J00CXEZ+36EJCcCvDKnQLQPwBOtVS8Dx/n
 bjtPNYlWuAhDna5rlcC/3Y5ItygO04Y/r25M8ffCLSpEzf+y1usc3jXhcbGiQ5rABnk1rtlQ3Uf
 0X1mjjvYEmT0tL4+x7tjnXWCbsdbLGGxH/5/DGM8WgIoPRqW1TGxbWd7BnWOz83zcAKVEcMpTNu
 WyEgN0R6VUnv7HGEjBEdwB7HFIiQyVAG0T99f1Vr6mKtCk9WLOunxTfuQ2HCXVq7nzcgnUYoK54
 4/qOgGSMUZZlPKbo1y/ZUjcacbGZ5r/V/valOaL5l8R7y2mcNiSw/a2kB53gk6omWt8nHgw==
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id
 5b1f17b1804b1-48e51f2f91cmr140833065e9.15.1778175387789; 
 Thu, 07 May 2026 10:36:27 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id
 5b1f17b1804b1-48e51f2f91cmr140832705e9.15.1778175387337; 
 Thu, 07 May 2026 10:36:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b6e9bsm232490925e9.10.2026.05.07.10.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:36:26 -0700 (PDT)
Message-ID: <ff92645d-4501-4881-8ca2-47299968f0ca@redhat.com>
Date: Thu, 7 May 2026 19:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/31] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 kjaju@nvidia.com, phrdina@redhat.com
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-31-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260415105552.622421-31-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/15/26 12:55 PM, Shameer Kolothum wrote:
> When CMDQV is active, the first cold-plugged VFIO device establishes the
> viommu to host SMMUv3 association. Block its hot-unplug to preserve this
> association and the guest's boot time CMDQV configuration.
>
> Also abort at machine_done if cmdqv=on is requested but no cold-plugged
> VFIO device was present to initialize it.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.h |  1 +
>  hw/arm/smmuv3-accel.c | 12 ++++++++++++
>  hw/arm/smmuv3.c       |  6 ++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 3ed94ed05c..c4441d5b3f 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -65,6 +65,7 @@ typedef struct SMMUv3AccelDevice {
>      IOMMUFDVdev *vdev;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>      SMMUv3AccelState *s_accel;
> +    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
>  } SMMUv3AccelDevice;
>  
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index a58815ded2..f381702a08 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -754,6 +754,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          return false;
>      }
>  
> +    /*
> +     * CMDQV is active: block hot-unplug of the device that established the
> +     * viommu association. Removing it would cause the vIOMMU to host SMMUv3
> +     * association be changed via device hot-plug.
> +     */
> +    if (s->s_accel->cmdqv_ops) {
> +        PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +        error_setg(&accel_dev->unplug_blocker,
> +                   "CMDQV is active: removing the device that established the "
> +                   "viommu association would break the guest CMDQV");
It is something that is planned to be fixed later on?

can you provide more details about the nature of the breakage

Thanks

Eric
> +        qdev_add_unplug_blocker(DEVICE(pdev), accel_dev->unplug_blocker);
> +    }
>  done:
>      accel_dev->idev = idev;
>      accel_dev->s_accel = s->s_accel;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 1d6fdd776c..c9ff6298f5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2020,6 +2020,12 @@ static void smmuv3_machine_done(Notifier *notifier, void *data)
>                       "at least one cold-plugged VFIO device");
>          exit(1);
>      }
> +
> +    if (s->cmdqv == ON_OFF_AUTO_ON && !accel->cmdqv) {
> +        error_report("arm-smmuv3 cmdqv=on requires at least one cold-plugged "
> +                     "VFIO device");
> +        exit(1);
> +    }
>  }
>  
>  static void smmu_realize(DeviceState *d, Error **errp)


