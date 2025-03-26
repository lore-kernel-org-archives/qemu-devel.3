Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1694AC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRjc-00073c-FW; Wed, 26 Mar 2025 10:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1txRjZ-00072p-8D
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1txRjX-0006kz-DO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742999272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjNScxHDjuuALUsgKMO0hkAwVMnSQZap+O6Ro5P/LMM=;
 b=dyW9xuBIydJzX1pMa3a/v4O57JFStcJS3aPgoO9uKfGRQD+/D9orsa4UVT+ee/Awx9P3J3
 0RxPJ1vm7GoLqTEYX6xQ2WfKzSMFT7ZCpomfBZH4MDn/NADWuyWBpqmUjnf0jbh2wHAe8D
 JdLyPJJlQNtDIPUhnnF1pERNrMA6L5I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-BPB7nYKLMmSdpdAWkkJIhw-1; Wed, 26 Mar 2025 10:27:51 -0400
X-MC-Unique: BPB7nYKLMmSdpdAWkkJIhw-1
X-Mimecast-MFC-AGG-ID: BPB7nYKLMmSdpdAWkkJIhw_1742999271
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e63405c626aso6682634276.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742999271; x=1743604071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjNScxHDjuuALUsgKMO0hkAwVMnSQZap+O6Ro5P/LMM=;
 b=si2islI+rXPbcjaMnsCauPxlK85m534Xa3amdLecqv2SovWqRV0xOQWSaPHT0lVcy9
 J4yhKLeOxZhwWIDS5iu21VVK5u+ugw2Mp+Qe4oZZlEhE8pPA95ppe8auxUH6t3zi7L4n
 9DqRf3gpn2G76nEvKHIl9YTSWnUNzmSXqKyna9KYisvXgzPYvM+BBhT1A19w8S2ZPWZq
 /4kCTU0wO2GP5YVkcuiraRy1s3ZGFm2e14Wzu1VDbTU4yeKwgVNwzSOEjaQiUJal/jt/
 XnlAmbRZozzfrVb0YFwM7JyvylkPgddCLH4FpjwVFWZ9fORt3zBu5p6sYGE+fOzlgeNe
 MklA==
X-Gm-Message-State: AOJu0YyxeTLZnZ+JFFce2fL3SaIWZe1FaKX63hIHa67WYhMq+yZwljDA
 3UYWfj+5e/f8+BxRkkYaxsNP365HwrT+/nr5B5uadwFw/IgVhz4Ia+LtcCN170oRxa9Gmh24NrA
 jy/eZOnns++AsWnfc+21g9kYnpYikq7nW+X4ABWWt5TWKsQbkMW6riJUTffjXMx0ygW5dZlgGaE
 La2CWDxMpgwFkV/zHqb49EZ7D3Y4Q=
X-Gm-Gg: ASbGncscn9DBXYAmo8DH9bXFY3oZq++ZBxYyQSxEN6qQDIVIP1PwsdcmU4tsLEEhTnA
 QZmAYrBp2+XuoDjLqJqa9+xnKR9z8+uh+WWkYZuAsxvJEPk+6cG/sBJW2zqm/Rf5gfKWwlUE=
X-Received: by 2002:a05:6902:2304:b0:e5d:b9a0:a14a with SMTP id
 3f1490d57ef6-e66a4dbda95mr28158637276.24.1742999270684; 
 Wed, 26 Mar 2025 07:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeDGhpiv072ez1GuWnLez4bzWphjdQrPM5bzzjmoa68LpkGvOo9phBK3fa9/DxGqNalEF+/ktrLejZzVnKIP4=
X-Received: by 2002:a05:6902:2304:b0:e5d:b9a0:a14a with SMTP id
 3f1490d57ef6-e66a4dbda95mr28158599276.24.1742999270288; Wed, 26 Mar 2025
 07:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 26 Mar 2025 16:27:39 +0200
X-Gm-Features: AQ5f1JrlHi5mtE-KcIw1RlTpKxb4fz4ba8ptO_Fbv1bKPbYzdlWUnltpYLSsKZE
Message-ID: <CAGoVJZyrJ=we7K63v99gqCj1kwVUp666m665Q9a5s52CRw0=CA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD
 IOMMU device
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, 
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com, 
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 25, 2025 at 4:13=E2=80=AFAM Suravee Suthikulpanit
<suravee.suthikulpanit@amd.com> wrote:
>
> Currently, the QEMU-emulated AMD IOMMU device use PCI vendor id 0x1022
> (AMD) with device id zero (undefined). Eventhough this does not cause any
> functional issue for AMD IOMMU driver since it normally uses information
> in the ACPI IVRS table to probe and initialize the device per
> recommendation in the AMD IOMMU specification, the device id zero causes
> the Windows Device Manager utility to show the device as an unknown devic=
e.
>
> Since Windows only recognizes AMD IOMMU device with device id 0x1419 as
> listed in the machine.inf file, modify the QEMU AMD IOMMU model to use
> the id 0x1419 to avoid the issue. This advertise the IOMMU as the AMD
> IOMMU device for Family 15h (Models 10h-1fh).
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Changes from v1 (https://lore.kernel.org/all/20250304183747.639382-1-sura=
vee.suthikulpanit@amd.com/)
> * Use the existing device id 0x1419 instead of the proposed new id.
>
>  hw/i386/amd_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dda1a5781f..b006ead804 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1767,6 +1767,7 @@ static void amdvi_pci_class_init(ObjectClass *klass=
, void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>
>      k->vendor_id =3D PCI_VENDOR_ID_AMD;
> +    k->device_id =3D 0x1419;
>      k->class_id =3D 0x0806;
>      k->realize =3D amdvi_pci_realize;
>
> --
> 2.34.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


