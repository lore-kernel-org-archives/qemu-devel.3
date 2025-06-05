Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AF3C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAI7-0007Z8-Nm; Thu, 05 Jun 2025 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNAHz-0007Y2-Pn
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNAHp-0005Ji-LX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749128735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLrI+nMGD2N6i2Cey2hmv9MFnuunz6SJvgFilWhKAno=;
 b=V7rl+eiljKWx7rM+Kxp7b7VdMnKL5OaGPcIB4BnRZ0LBipHZNZrQaTJLjjkXTta1/NKY0z
 c+bogadsjjtRqbODI7AV7vzR8L7tZYv6ZPn6MbLUf+/6taDkBMIHj3vvTTiAhTNjkOTZi3
 4HW5OylkhfGiQsugv003H9la3We3+AA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Q566RDFEMc-hDyvgBAYCGw-1; Thu, 05 Jun 2025 09:05:34 -0400
X-MC-Unique: Q566RDFEMc-hDyvgBAYCGw-1
X-Mimecast-MFC-AGG-ID: Q566RDFEMc-hDyvgBAYCGw_1749128733
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d886b9d5so3512355e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 06:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749128733; x=1749733533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLrI+nMGD2N6i2Cey2hmv9MFnuunz6SJvgFilWhKAno=;
 b=QYxnn3SkuqeanjHp6AebNpnpvcaPpLhA8hweOVGLnr81rFYtbv4BBHCI96DozFtRu4
 zNe9XGTH+G8itHPYVJx7Sg9Mk2SysLdm932MO0dz26D2cMBd98n12+14R2Le1jOeJ473
 bggpbl+wQbEikA10BLWBEZlGNjnJPzuqvHfK0Jr78Pk1goQE/U/Ru/kkRGP6fQ9FDl51
 F+OVPOTsWG+DuU6U/c/61sg5GBf8VcV8CXs4kqtwyMmm5mpMFOUrBSkQfE971YQdD2Pi
 bzhjZbSPBzmSgH5X8ejv/21hjJnZbYqQJOUCEJUetPoGbQ6nMUJ6zqrToLfZct0IEUQT
 9pmQ==
X-Gm-Message-State: AOJu0Yz2ZVCaDa8m9suZTrVdbGR6IwhOeePeN2r6d1Fs51UOchOUSR81
 94tfWxv0LIC9a1JTNX/HkvBblpeF4/6QFCHiKGa/aXZX65118nQNH6Hwn+SgDavefvPJjCto42e
 aziu2OcjfvOhPmZKT/fvDxOIJK5sVxl4H4zqiEIuT1/OU/Ex/fa006pjX
X-Gm-Gg: ASbGnctN4BfFAMP43WCnRM+NtjmhPMCOclmNHRYu52NCTjN94/DIrnPUA6wfcBkIOwx
 kTrUPKaNpdDQIdaGBxwckViro6p4ylNikmmDXZOH2nMnghMJRfOsjtkG2Wr++O+CJBfQ9oQ2YOo
 s5+f6XMLUMDgzB2Nlm+mhAWEJKp3QUfmeuafgAqVRnKlcVnRluG559Mgaa7iTOUzhm9NpECbvZU
 sptn8cGDz5V+aSv34HPmJeMEjSuPzkVNFNmTZASiRRrdBMX/2AMWCo7e85AjCgjHpfj0P51DhNc
 4UpY73APkRulnlR/OWXse8lV5jlcV18f
X-Received: by 2002:a05:600c:528e:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-451f0fadeb5mr49864385e9.28.1749128732614; 
 Thu, 05 Jun 2025 06:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7PxyDKlN0hc0q3rOgHloVQ8cBTXnktqn4iaiSp5AMW3n8p2oVuLrOelWNdVABGTJ/ee7Aiw==
X-Received: by 2002:a05:600c:528e:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-451f0fadeb5mr49863745e9.28.1749128731974; 
 Thu, 05 Jun 2025 06:05:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c7adsm23987373f8f.26.2025.06.05.06.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 06:05:31 -0700 (PDT)
Date: Thu, 5 Jun 2025 15:05:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Shameer Kolothum via <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
 Complex association
Message-ID: <20250605150529.0d0cbb8c@imammedo.users.ipa.redhat.com>
In-Reply-To: <83a0966672fc4785817784dbdf08aef3@huawei.com>
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
 <20250605125518.138f5172@imammedo.users.ipa.redhat.com>
 <065bbd4ee15442b58e15b298614cf5dd@huawei.com>
 <20250605141931.1704c6a5@imammedo.users.ipa.redhat.com>
 <83a0966672fc4785817784dbdf08aef3@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 5 Jun 2025 12:36:52 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Thursday, June 5, 2025 1:20 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Shameer Kolothum via <qemu-devel@nongnu.org>; qemu-
> > arm@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
> > jgg@nvidia.com; nicolinc@nvidia.com; ddutile@redhat.com;
> > berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
> > smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> > <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>;
> > zhangfei.gao@linaro.org
> > Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root
> > Complex association  
> 
> [..]
> 
> > > > in QEMU with PCI, usually we specify bus to attach to with 'bus'  
> > property,  
> > > > wouldn't it better to rename "primary-bus" to 'bus' to be consistent  
> > with  
> > > > the rest of PCI code (and before "primary-bus" shows up as a CLI option,
> > > > so far (before this series) it looks like it's an internal property)?  
> > >
> > > That was tried in v2 and since SMMUv3 is not a pci device by itself(it is a
> > > sysbus device) reusing the default "bus" property to establish an  
> > association  
> > > with a PCI bus created problems,
> > > https://lore.kernel.org/qemu-devel/877c2ut0zk.fsf@pond.sub.org/  
> > 
> > that was an approach was trying to workaround by patching dc->bus_type,
> > which is obviously wrong.
> > 
> > I'm not talking about changing device type or something similar,
> > but about renaming 'primary-bus' property name to 'bus'  
> 
> I have tried that earlier and gets this,
> -device arm-smmuv3,bus=pcie.0,id=smmuv3.0: Device 'arm-smmuv3' can't go on PCIE bus
> 
> IIRC, the above mentioned patched dc->bus_type = TYPE_PCIE_BUS was used 
> to avoid that.
> 
> Or am I missing something here?

sigh, but you a right.
qdev_device_add_from_qdict() && co can't handle that without heavy refactoring.

 
> > so it would be consistent interface wise with PCI or other QEMU devices
> > that are attached to a bus.
> >   
> > > > > +    if (!bus || !object_dynamic_cast(bus->parent,  
> > > > TYPE_PCI_HOST_BRIDGE)) {
> > > > Also looking at smmu_base_realize, it has NULL pointer check already.
> > > > Which also rises question, shouldn't smmu_base_realize check for
> > > > TYPE_PCI_HOST_BRIDGE as well (aka can smmu be attached to anything
> > > > else but a host bridge)?  
> > >
> > > Not at the moment in Qemu. Though the SMMUv3 specification allows it  
> > to  
> > > be associated with non-pci devices as well.  
> > 
> > then perhaps move, the check to smmu_base_realize() for now?
> > 
> > if smmu + non-pci ever materialize, it can be refactored at that time.  
> 
> Ok.
> 
> Thanks,
> Shameer
> 


