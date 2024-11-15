Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1643ED68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0WR-0002Fk-50; Fri, 15 Nov 2024 12:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0WP-0002FR-Mf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tC0WO-00056R-Co
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731693255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddoR2CX3izn+ln5p7zqyfo1EvpSDqIUCq4zxwNZ+i5o=;
 b=fQFmfCHVt9+/9FB5ve5bdjAgSm27QrXNbvDSakx4Ui+mBQE/b9IH/WbnuejYyDZSm8nAoB
 AymWrXdOzR8qzGYiuMkUl90UWHsO62YzLlgSfJPP/6UvSFHveIx2aKGsxnPB9DqOeCv4w5
 gwzvYh550PYE7NIhVDC0vi0t41BH4Ds=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-vk5l4FiqNOKJ6sBduYkXnQ-1; Fri, 15 Nov 2024 12:54:14 -0500
X-MC-Unique: vk5l4FiqNOKJ6sBduYkXnQ-1
X-Mimecast-MFC-AGG-ID: vk5l4FiqNOKJ6sBduYkXnQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83abef51173so203620539f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693253; x=1732298053;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddoR2CX3izn+ln5p7zqyfo1EvpSDqIUCq4zxwNZ+i5o=;
 b=jfQXTT9uy3CBOylhBT8cQUFetyn9fEB2SO6hldSuj39HvRFdSoYI5cT5gUzc0XlEbe
 ccxmuONK2mMm9DAUgEL1bJdLoaG9C15WDV/TtUkelkUg8LgFuErMnNMyH49iIxig4Qu0
 9uk0j3aQNiTfrkDaaYqI5zPrd6vph2ea5lopiSs4XEOj5epvxfcM24arjZJpiqjnSEk2
 5WcHPXVBCmIQx2ksCVyEilS4h5B+5hL4RKEmqvE6nl175NEB+Qi9+wlud1nIhDJRGjil
 lFvz38YOPwxzGhKRWmXnFwwK3urJfZRP4C0vAbof+kf1SIGuxCfGUnmX7hfRcThV/80G
 rqxA==
X-Gm-Message-State: AOJu0YxqilXRf6yjMztBmSIu7VvHv9VJHEKsIFS+e7/TVNCPanQElL7t
 SFkZ6Uj2+Y2Py+VXGZJpRs0qkNRZ1ZX4XpVO+BSMz2kj3SVRISVRm1mPvx1ypIRdRHqrN/90CYM
 loFgU0d+uOh1IHtycyTR6GJ7/UWsUea9FuJxJb3UiT97cIRiLVbjj
X-Received: by 2002:a05:6602:1486:b0:83a:97e7:8bcf with SMTP id
 ca18e2360f4ac-83e6c12ffffmr411153039f.11.1731693253697; 
 Fri, 15 Nov 2024 09:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcwSrxtWshUIrxKrX1+pvZP5zDX4NywYDi8CSSDbZxsmJZQPINiH9gySVBkvCZguo197l7wQ==
X-Received: by 2002:a05:6602:1486:b0:83a:97e7:8bcf with SMTP id
 ca18e2360f4ac-83e6c12ffffmr411150839f.11.1731693253383; 
 Fri, 15 Nov 2024 09:54:13 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756f5f8esm443357173.161.2024.11.15.09.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:54:12 -0800 (PST)
Date: Fri, 15 Nov 2024 12:54:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/9] hw: eliminate qdev_try_new, isa_try_new &
 usb_try_new
Message-ID: <ZzeKwvuYPRfjaP-X@x1n>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115172521.504102-2-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Nov 15, 2024 at 05:25:13PM +0000, Daniel P. Berrangé wrote:
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 40b2567aa7..558f17d3ba 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -922,11 +922,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
>      Error *local_err = NULL;
>      DeviceState *dev;
>  
> -    dev = qdev_try_new(TYPE_S390_PCI_DEVICE);
> -    if (!dev) {
> -        error_setg(errp, "zPCI device could not be created");
> -        return NULL;
> -    }
> +    dev = qdev_new(TYPE_S390_PCI_DEVICE);

This one used to allow failures, but now it asserts.  Especially, see:

b6e67ecc7b ("s390x/pci: properly fail if the zPCI device cannot be created")

Would it be safer to use module_object_class_by_name() too here?

All the rest changes look sane.

>  
>      if (!object_property_set_str(OBJECT(dev), "target", target, &local_err)) {
>          object_unparent(OBJECT(dev));

-- 
Peter Xu


