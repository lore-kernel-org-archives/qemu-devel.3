Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB913C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuy2-0006ag-0X; Tue, 27 May 2025 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJuxr-0006Zn-B4
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJuxi-0006kC-3E
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748354840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+5kxvmEYFekHGHzkSClLIJuIds5hcNymT+Rj8w+7+M=;
 b=bI+eOvzS92jaE4mtdW4Fwn2PyjTzCd/EOaLAcK/iBebNdSjnNji9+taomdOwRnoDm/R8oK
 aSYUtWG2WfTry3YHPQFCMkEZdcQ48eacdXKcdu64aRAV88b/ZymZKK8LJ2I+eAT+obcGOm
 0bvBz1fLWMMnc98GXt8NMXmPTeKH3pA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-KrkQAIKFOWOFjBt0wwkJiw-1; Tue, 27 May 2025 10:07:19 -0400
X-MC-Unique: KrkQAIKFOWOFjBt0wwkJiw-1
X-Mimecast-MFC-AGG-ID: KrkQAIKFOWOFjBt0wwkJiw_1748354838
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4d95f197dso1321826f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354838; x=1748959638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+5kxvmEYFekHGHzkSClLIJuIds5hcNymT+Rj8w+7+M=;
 b=QiAp0HEvdTzWDP/ujkZqFvamHNuUattzelY2Rihl6FplJuba5YBYLL4x0aU5lt+MOn
 D+uyhmd79x82jtu4XFyLgko6Xn8jdpwXyenjACKaL1rKy3UpihPD6IwbBDHjNOOp/EJc
 ChUpkHAS9e/Jcs15aG49GvzuPwsEb0DNzkKXCA6d91QgPo5zrb4FRShDg3LX3n73esmZ
 W5YL4cw/KJcd1HqfOz3BAKQMFjcslNfuVltYSDDQgK8O7m7GUWPlrfb8TCYwfAfuRnxJ
 mf+Y4KyKcr7ZtYQhcct+WsIJWSysqGdrmCOCtukugk9kQYBrUBhWIBS9W7AU5AgfnBak
 5gGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8+nO1qQZDeaay+Vm4cVYu1RXr4f5lJsu9Uau+eZVcMHnCM2u9v7rsK7iGSKaBH5YVprnvLjrtwuQL@nongnu.org
X-Gm-Message-State: AOJu0YziYH3y3Uk2GhwGLbw4Jc9IkDrfx3lRUPA+k64yPvXKjPdS94WV
 9ozl5oALze9sSY1neMrm16roYl4jMA712lXrhAZZPlJxpxE5edcUwS3Fi5+zfQNy1lVesfWt/fu
 x54XJxpD8xvhMdEvnFJxTql8SL3zefPQAK9c7QpuDgQt9ikl00f7r6gPpX9g/wkYaW/g=
X-Gm-Gg: ASbGnctGjNGMr06/RkyW0WNBXrEYONQVlqbud+zmAhPUBRizpByyKLddI+R4keQUin3
 BWJ3Zoauo/KKZ5pDcAuG6dyADENNC6pwNO0HXinUA4db9SOzZzBAC+c5KqXpf6OnukR0+JztZbN
 m4pOE5ul9NH817xm+B4r/fut2ATWDANyzI2zQGze9i/p9Pi2Pf4BS4lRb1XARuH/NHmSMF2kuOE
 yFiQqGbmHUHEn0Y9/0nlGmSx2ax79EsRv+atkDS/Sn7YCFwuqoIV1VnkCa7bBazNik8Rp92Gtbn
 +eG4T1TiEVdCblQ5p2O+NwQfMjl82FRK
X-Received: by 2002:a05:6000:2890:b0:3a4:d7ba:940f with SMTP id
 ffacd0b85a97d-3a4d7ba9678mr6282682f8f.8.1748354837819; 
 Tue, 27 May 2025 07:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn/OHYAIcm2iBNMXeImeEvpqkYDBo6n7I3Kx7RouWE/xxzB8lbL9ARYl7qKkkIgCfPR09eeQ==
X-Received: by 2002:a05:6000:2890:b0:3a4:d7ba:940f with SMTP id
 ffacd0b85a97d-3a4d7ba9678mr6282629f8f.8.1748354837292; 
 Tue, 27 May 2025 07:07:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cf211828sm10247188f8f.61.2025.05.27.07.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:07:16 -0700 (PDT)
Date: Tue, 27 May 2025 16:07:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 16/25] hw/i386/acpi-build: Move aml_pci_edsm to a
 generic place
Message-ID: <20250527160714.4b82f776@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527160040.5641920d@imammedo.users.ipa.redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-17-eric.auger@redhat.com>
 <20250527160040.5641920d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 27 May 2025 16:00:40 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 27 May 2025 09:40:18 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Move aml_pci_edsm to pcihp since we want to reuse that for
> > ARM and acpi-index support.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  include/hw/acpi/pcihp.h |  2 ++
> >  hw/acpi/pcihp.c         | 53 +++++++++++++++++++++++++++++++++++++++++  
> 
> edsm is for un-pluggable ports,
> a more suitable place for it would be hw/acpi/pci.c

or maybe hw/acpi/pci-bridge.c as its owner/call is a bridge

> 
> 
> >  hw/i386/acpi-build.c    | 53 -----------------------------------------
> >  3 files changed, 55 insertions(+), 53 deletions(-)
> > 
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index 5506a58862..f2c3558654 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
> >  
> >  void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
> >  
> > +Aml *aml_pci_edsm(void);
> > +
> >  /* Called on reset */
> >  void acpi_pcihp_reset(AcpiPciHpState *s);
> >  
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index d800371ddc..57fe8938b1 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
> >      }
> >  }
> >  
> > +Aml *aml_pci_edsm(void)
> > +{
> > +    Aml *method, *ifctx;
> > +    Aml *zero = aml_int(0);
> > +    Aml *func = aml_arg(2);
> > +    Aml *ret = aml_local(0);
> > +    Aml *aidx = aml_local(1);
> > +    Aml *params = aml_arg(4);
> > +
> > +    method = aml_method("EDSM", 5, AML_SERIALIZED);
> > +
> > +    /* get supported functions */
> > +    ifctx = aml_if(aml_equal(func, zero));
> > +    {
> > +        /* 1: have supported functions */
> > +        /* 7: support for function 7 */
> > +        const uint8_t caps = 1 | BIT(7);
> > +        build_append_pci_dsm_func0_common(ifctx, ret);
> > +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> > +        aml_append(ifctx, aml_return(ret));
> > +    }
> > +    aml_append(method, ifctx);
> > +
> > +    /* handle specific functions requests */
> > +    /*
> > +     * PCI Firmware Specification 3.1
> > +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> > +     *        Operating Systems
> > +     */
> > +    ifctx = aml_if(aml_equal(func, aml_int(7)));
> > +    {
> > +       Aml *pkg = aml_package(2);
> > +       aml_append(pkg, zero);
> > +       /* optional, if not impl. should return null string */
> > +       aml_append(pkg, aml_string("%s", ""));
> > +       aml_append(ifctx, aml_store(pkg, ret));
> > +
> > +       /*
> > +        * IASL is fine when initializing Package with computational data,
> > +        * however it makes guest unhappy /it fails to process such AML/.
> > +        * So use runtime assignment to set acpi-index after initializer
> > +        * to make OSPM happy.
> > +        */
> > +       aml_append(ifctx,
> > +           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> > +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> > +       aml_append(ifctx, aml_return(ret));
> > +    }
> > +    aml_append(method, ifctx);
> > +
> > +    return method;
> > +}
> > +
> >  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
> >      .name = "acpi_pcihp_pci_status",
> >      .version_id = 1,
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 6feb99e9eb..e8ed335fdd 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
> >      g_array_append_vals(table_data, reserved, 40); /* Reserved */
> >  }
> >  
> > -static Aml *aml_pci_edsm(void)
> > -{
> > -    Aml *method, *ifctx;
> > -    Aml *zero = aml_int(0);
> > -    Aml *func = aml_arg(2);
> > -    Aml *ret = aml_local(0);
> > -    Aml *aidx = aml_local(1);
> > -    Aml *params = aml_arg(4);
> > -
> > -    method = aml_method("EDSM", 5, AML_SERIALIZED);
> > -
> > -    /* get supported functions */
> > -    ifctx = aml_if(aml_equal(func, zero));
> > -    {
> > -        /* 1: have supported functions */
> > -        /* 7: support for function 7 */
> > -        const uint8_t caps = 1 | BIT(7);
> > -        build_append_pci_dsm_func0_common(ifctx, ret);
> > -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> > -        aml_append(ifctx, aml_return(ret));
> > -    }
> > -    aml_append(method, ifctx);
> > -
> > -    /* handle specific functions requests */
> > -    /*
> > -     * PCI Firmware Specification 3.1
> > -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> > -     *        Operating Systems
> > -     */
> > -    ifctx = aml_if(aml_equal(func, aml_int(7)));
> > -    {
> > -       Aml *pkg = aml_package(2);
> > -       aml_append(pkg, zero);
> > -       /* optional, if not impl. should return null string */
> > -       aml_append(pkg, aml_string("%s", ""));
> > -       aml_append(ifctx, aml_store(pkg, ret));
> > -
> > -       /*
> > -        * IASL is fine when initializing Package with computational data,
> > -        * however it makes guest unhappy /it fails to process such AML/.
> > -        * So use runtime assignment to set acpi-index after initializer
> > -        * to make OSPM happy.
> > -        */
> > -       aml_append(ifctx,
> > -           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> > -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> > -       aml_append(ifctx, aml_return(ret));
> > -    }
> > -    aml_append(method, ifctx);
> > -
> > -    return method;
> > -}
> > -
> >  /*
> >   * build_prt - Define interrupt routing rules
> >   *  
> 


