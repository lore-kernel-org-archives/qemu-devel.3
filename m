Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D9EC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoTd-0006ob-9z; Thu, 27 Jun 2024 08:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoTc-0006oH-F2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoTb-0000Gc-02
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FE1m8HHupndS8gQfUnBtBTuPulGMiQueYJJuEC1QPYw=;
 b=TrW2fbQuty6I4Z6CzOx5+KiMUBeHu1WwHRUKv5Vm4Q4++to4G55c2th1I/u/2FDBljRsvT
 GS0PNFAKBeArN9IEeZkak1nbkSBPGdYr992nKE0gyQ5sGVRH1NaTqsOiPJU6GJbYCU1ZyN
 i95BLlyFtikICS3sLJe3j/E1kMgh2QU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-W4jfnmFDPVqC3Ep2fY3ypg-1; Thu, 27 Jun 2024 08:43:44 -0400
X-MC-Unique: W4jfnmFDPVqC3Ep2fY3ypg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3653f54d94eso3971119f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492223; x=1720097023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FE1m8HHupndS8gQfUnBtBTuPulGMiQueYJJuEC1QPYw=;
 b=uAzhZAWxRQlRo1FxRD8Exky76FtMGOJ22gw0dTWYiAqwZewsFiy/aWTxy0L7tlHxmD
 CwyViRPZq0JBGIV9JlNHr7gb2V5nZu4yInNBGmCqqgkU+fkD1mUtRGTWDxybxrhc8ZC7
 epipqChRl1wJr5Cf4Or4RnhIxBhAm1NAM6kgfj7fHfWkJS9V0k4AR4hi8sIkaSOcrfP6
 372TqZvhbXn9vL0t+6ZCncPl1WHoiDbijOyeX0JXHHVkv8lX1jfuKqry8F69mwHuYFNT
 za7ZKS9APbjGsEaryekSNMjZXXMUFYD3be1tXzMNPnI2JnU/n8O5xyPyjJEKLAfjFTEW
 KvTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz8D9zXu/g+3u9KO2+wcZvorCt2sU/Ae3FNp87jYrW8ppVbOn/aKjiw1cxDpB3k7ZXPZPEnJ3LM9B14VoCeSUTovOtU5Y=
X-Gm-Message-State: AOJu0YwzfUG7Kq38GVFS40bYpMtciLSGyvWm9fsvF1+HPFKGQ1x0uC5w
 fGf6jD37y5w7NfK0218bGlsfJ10WHkiGowBTFnqU4pSp4QIRvPq/rtzKfkNIhF9FW1moPzKoiUH
 vzowXe5ccOiZ3boVTY8g0g+npmCuAMZEyUZAmQJU+yEqAadWyR1HU
X-Received: by 2002:a05:6000:154d:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-366e9463da3mr11749964f8f.13.1719492223631; 
 Thu, 27 Jun 2024 05:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdKOz+9xVZtelsna+VHcHlYkK8bCfxlp8Fg130Z/g2ItSS5fpHtYQ9Gb9K+MG53F8fxlA+uw==
X-Received: by 2002:a05:6000:154d:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-366e9463da3mr11749944f8f.13.1719492223303; 
 Thu, 27 Jun 2024 05:43:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674358548csm1757836f8f.64.2024.06.27.05.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:43:42 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:43:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 02/11] hw/acpi/GI: Fix trivial parameter alignment
 issue.
Message-ID: <20240627144342.33352809@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-3-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Thu, 20 Jun 2024 17:03:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Before making additional modification, tidy up this misleading indentation.
> 
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v3: Unchanged
> ---
>  hw/acpi/acpi_generic_initiator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 3d2b567999..4a02c19468 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -133,7 +133,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  
>      dev_handle.segment = 0;
>      dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> -                                               pci_dev->devfn);
> +                                   pci_dev->devfn);
>  
>      build_srat_generic_pci_initiator_affinity(table_data,
>                                                gi->node, &dev_handle);


