Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093B5C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5NLH-0000cJ-03; Fri, 10 May 2024 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s5NLF-0000UQ-7Z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s5NL5-0000VR-0J
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715336332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5+ENNkiMenRVoDACceZVQb0Vc6Y9v1VUu46MRWWdLo=;
 b=S2+Ke+B3CkgC3O5fa+gouNtjzNEMDskP0hVbeMffohacXXwVLp3n5lhs8JePwUQDh6BQ2E
 dT8WQNY5bTJun9KGqJJn0TaUB8q8KNO02r7A/cI/bIotX9ZN/msbSoN+nQvQHtjTe8ckiv
 1CQmCTueLsUyeVO/fd2Q7ay1d4Zq27w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-YoU4LFGpPUm72Gpjgue8Tw-1; Fri, 10 May 2024 06:18:50 -0400
X-MC-Unique: YoU4LFGpPUm72Gpjgue8Tw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41ff1a36e7bso4658385e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715336329; x=1715941129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5+ENNkiMenRVoDACceZVQb0Vc6Y9v1VUu46MRWWdLo=;
 b=rF9Gvr5LElQTM5rM7SGireYM2BgIfap52jFnp86Z7TnGgNRXFKvyNo3wR8KFqXq1Q8
 aPqcFWcaoaLIU7vAliL/npMtbSdZaii6F1IENXit+FtS+IHBfLw59n7+GoU9ttK7KNsV
 I0NI2yeqBxoNxHrVxzx+GyoWcUCUKnBllySI+DCTSfSG8Q9XNCeV7oRFPELA2Kt7AIk6
 N93t7xsH9sFttLDWiXpq6XzveirAJBlX68SEKtPkCDu1Szyh1StuQuvxH4/fr7XUkNjW
 2Dy5GtufmEiAr5vrlFgsd+64DOQ/lG871E+0f/xJQUDw3Yot7WRHlgkNM9h5dpldmFYZ
 l9eQ==
X-Gm-Message-State: AOJu0Yz/Twf+LGThMQCg/QuimfthpGA7kjxWU1LN1RV3QRt/AXfaptUC
 0NF5egoRTCF/v5yWuuaEIB3pQfGXR6LK9BHN2vkImjNHo+bPCh9hBSHLElY+2G32I6zy3F1RjSO
 uyYF0H9f9BDu0bkrqPluGkoFKuSIa3xLzbmvzRiJ1WBFrYs9cCvLU
X-Received: by 2002:a05:600c:3b26:b0:41a:5521:d82c with SMTP id
 5b1f17b1804b1-41feac55e1bmr20041315e9.29.1715336329583; 
 Fri, 10 May 2024 03:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC2uCV0jZWbq9lZ5QZehvN5OMDcvDZHnAnx1hMToineJ6/7WckijLlStej8AHtX4I0uYupzA==
X-Received: by 2002:a05:600c:3b26:b0:41a:5521:d82c with SMTP id
 5b1f17b1804b1-41feac55e1bmr20041075e9.29.1715336328968; 
 Fri, 10 May 2024 03:18:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8e3csm58887155e9.1.2024.05.10.03.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 03:18:48 -0700 (PDT)
Date: Fri, 10 May 2024 06:18:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v9 1/2] virtio-pci: only reset pm state during
 resetting
Message-ID: <20240510061603-mutt-send-email-mst@kernel.org>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416070127.116922-2-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, Apr 16, 2024 at 03:01:26PM +0800, Jiqian Chen wrote:
> Fix bug imported by 27ce0f3afc9dd25d21b43bbce505157afd93d111
> (fix Power Management Control Register for PCI Express virtio devices)


should be:

27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"

Pls include a bit more info about the bug: after this change, we observe ...... .

> Only state of PM_CTRL is writable.
> Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.



and here, add:

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"

> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  hw/virtio/virtio-pci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index cb159fd0785c..a1b61308e7a0 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2300,10 +2300,16 @@ static void virtio_pci_bus_reset_hold(Object *obj)
>      virtio_pci_reset(qdev);
>  
>      if (pci_is_express(dev)) {
> +        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> +
>          pcie_cap_deverr_reset(dev);
>          pcie_cap_lnkctl_reset(dev);
>  
> -        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
> +        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> +            pci_word_test_and_clear_mask(
> +                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
> +                PCI_PM_CTRL_STATE_MASK);
> +        }
>      }
>  }
>  
> -- 
> 2.34.1


