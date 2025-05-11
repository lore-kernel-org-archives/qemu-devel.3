Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1855DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6iN-0004C8-LZ; Sun, 11 May 2025 09:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6iJ-0004Br-Bc
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6iG-0000QS-CT
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746970046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj+Lk4l+sWZvgFq5gUyC7aTVzxq09sc1tmLYLOGenhM=;
 b=i4eGkyzCtVQhQsKXRIsF9rc0o1KrToyQVno5Y9dyZzVMSbo8GZVvMsUhrjO8RbQXgQ4+rW
 1x9s0zhlhekYGpQUFgsoqiDG46lw9z6ktd33HRV2oZIzSQA2sIct+aI/WCCBDQ+LV00+ny
 SW6tHbFi9njdHFHHQQ9JCBUZa1gfh90=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-ueVAmAeXPkSwY_3ZYxHGyg-1; Sun, 11 May 2025 09:27:24 -0400
X-MC-Unique: ueVAmAeXPkSwY_3ZYxHGyg-1
X-Mimecast-MFC-AGG-ID: ueVAmAeXPkSwY_3ZYxHGyg_1746970043
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so18007115e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746970043; x=1747574843;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nj+Lk4l+sWZvgFq5gUyC7aTVzxq09sc1tmLYLOGenhM=;
 b=ZN4tn7hm2Hdx2RN9YZxxUyYh3zMBR5fr4v/2/ydSfsM7jRLN/B0uAAiKWM1S/wLT9k
 Dmp1JzlfzjSpS8K4UcPNSZLoX3QjtzBmOASk21xFNtBdcO8bSXogOxg2NwVgBxPvxcLQ
 Jg9PH96z/wE66CvvDiF7ahppNpZuigr9dLzlhj96C/I7NLVfs83RiKcYnxYLy+3fw+Kf
 4QtdQ8BmbhxG+v/qearg/mo/Zi3DCTuyNbIBi6QbO719qv0YoSdgLOqSFv5kNiG9sPNC
 dRoMudaAggbRFPakdQyj6b0/mN5LHBjs7HeimZKpE4jLfQRukUWMbFBRZNWurjKYOHfT
 A0PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4wVOH3jQupvllgSCsHQ7SS4uSM12NNGWVfXSi+yUhsz9+q8qZlihtAopy2R+4fDiifjEiLc+xbGBy@nongnu.org
X-Gm-Message-State: AOJu0Yx9jxVqzWh+ne4pZ8Rovassdk33v6GAw+3TPEYfUxxxxN8SG9SR
 CVdX58DM27UVcyQFAMLz65D8n9RRyjsffmRe/uzhp5smwiyWfCYZo0Yoe++nAQeNwH1DrPt3LaK
 BcNh2oiiHnnQIW72aNI0Qvf95cbiUOxS8e6YMdgvbFGKUC0ivT8+S
X-Gm-Gg: ASbGncub/99xNpUZXNxuvNb/L82FSS0WH4blxKXAowh+0ZAaYo924299CB6q9IZdc1f
 /FAE7TCDz9fzMFq+TlRHE06BRzagaiyE9E0eKWJDZumEQsfR3Xl2qoL8MWX2ork03e/cq7eazRJ
 Lx8gEl3GuEy1uped8NZ/TAk/WqrUn+v+IGCz/0Zm2sSNN15eUWFc3Ya2oeYVQEKUt+XYkbhWo1O
 rk7PIIb2UIJYw4Tor2/XCRS8kz8q8gFZEv6JzGA0OV4ZSWH+v3W66vrABNwdT8+gY1uqPKCrRPK
 QuJDDw==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr74318405e9.17.1746970043437; 
 Sun, 11 May 2025 06:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKUBLdxfeGamwbyeBjIm46IjqmrI/adQBsalDPxKZDAka0gguZPUvg4EjlqjbqfQBp/WUteA==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr74318205e9.17.1746970043034; 
 Sun, 11 May 2025 06:27:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2a07sm9468193f8f.50.2025.05.11.06.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 06:27:22 -0700 (PDT)
Date: Sun, 11 May 2025 09:27:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250511092651-mutt-send-email-mst@kernel.org>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250309094039-mutt-send-email-mst@kernel.org>
 <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
 <CAGoVJZwg0KvZX7_OCFYp+RBk_fO4kBV3MmY3FxUC=RbnNKLtZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGoVJZwg0KvZX7_OCFYp+RBk_fO4kBV3MmY3FxUC=RbnNKLtZA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Mar 12, 2025 at 02:43:52PM +0200, Yan Vugenfirer wrote:
> 
> 
> On Tue, Mar 11, 2025 at 4:02 AM Suthikulpanit, Suravee <
> suravee.suthikulpanit@amd.com> wrote:
> 
> 
> 
>     On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:
>     > On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
>     >> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I
>     /O
>     >> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
>     >> device is platform-specific.
>     >>
>     >> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
>     >> undefined device id.
>     >>
>     >> Therefore, change the vendor id to Red Hat and request a new
>     QEMU-specific
>     >> device id.
>     >>
>     >> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs
>     /specifications/48882_IOMMU.pdf
>     >>
>     >> Cc: Gerd Hoffmann <kraxel@redhat.com>
>     >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>     >
>     > Will the existing drivers bind with the device then?
> 
>     Existing Windows would not recognize the device ID.
> 
>     Actually, Linux and Windows does not depend on the PCI vendor / device
>     ids to probe devices and initialize AMD IOMMU. Instead, it depends on
>     the ACPI IVRS table.
> 
>     Checking on a real system w/ AMD IOMMU enabled booting Windows Server
>     2022, there is no AMD IOMMU device showing in the Device Manger.
> 
>     In this case, I believe Windows is not fully initializing the
>     QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe from
>     the list of OS visible devices and therefore expose the PNPID to the
>     device manager. And since the device ID is zero, it appears as an "Other
>     devices->PCI Device (with warning sign).
> 
>     Therefore, it we have two options:
> 
>     1. Fake the device ID to 0x1419, which is current appear in the
>     machine.inf as an entry in section [AMD_SYS.NTamd64]:
> 
>     %IommuDevice_Desc% = NO_DRV,PCI\VEN_1022&DEV_1419
> 
> Considering that this is a "null driver" (no actual driver is loaded for the
> PCIe endpoint according to machine.inf), I recommend using this PNP ID.
>  

So this is the status quo really or did I miss anything?

> 
>     2. Figure out why Windows does not recognize the device.
> 
> The answer is simple: the PCIe endpoint's PNP ID is unknown to Windows. So
> technically device is recognized (it is shown in Device Manager after all), but
> there are no compatible drivers for it. And in anycase, machine.inf specifies
> "null driver" for AMD PCIe endpoint IOMMU device. The device will get a
> friendly name in Device Manager and considered to be "installed" by Windows, by
> there is no actual driver associated with the device. 
> 
> Best regards,
> Yan.
>  
> 
> 
>     Anyhow, we should still assign some PCI ID value (instead of zero).
> 
>     Thanks,
>     Suravee
> 
> 
> 
> 


