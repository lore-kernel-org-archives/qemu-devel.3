Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF9CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 15:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE8iY-0006A8-2b; Sun, 11 May 2025 11:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE8iQ-00069m-Vg
 for qemu-devel@nongnu.org; Sun, 11 May 2025 11:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE8iL-0004Sh-53
 for qemu-devel@nongnu.org; Sun, 11 May 2025 11:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746977739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dGZSm3Yz1zx4Xk8PBJBGVFbmWafRGsNAmrRbygIjgY=;
 b=SExGpDysSBozgrAEucpcLrIJ2J9uUVqMfV9Bx2BE7sMlSx0h4dkFYMinWHotMI4DiFvMZs
 CH7Q2vVaR3NsVgMvCDHG9dlBwiSP4Ao+vowxqlrGJv9L18IwpLh7vlEkn26oIqkEi8SLZL
 XKaCqePS8CNYdRlZ/BmUXKnlbZdpEJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HJYSCwWJNFmaQyfJ-JFNnw-1; Sun, 11 May 2025 11:35:37 -0400
X-MC-Unique: HJYSCwWJNFmaQyfJ-JFNnw-1
X-Mimecast-MFC-AGG-ID: HJYSCwWJNFmaQyfJ-JFNnw_1746977737
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0bd786a53so1434089f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 08:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746977736; x=1747582536;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dGZSm3Yz1zx4Xk8PBJBGVFbmWafRGsNAmrRbygIjgY=;
 b=bn8ZSjon2f2T60g35A5uQvMdmoqMhk+IF1DHFT9RmWLkZrXSlxuDUfYnwYBKkuKnWd
 3kGZAI2bwySG8NlKzm8gEtW2GvjWJSJD0JyAVvhVXo2vifAoCiEfvrQUejhxtrtEQUQu
 i/YGle7A932QnSlijyJnm5Q+ZuOpRJs7Uq7RjpO97Q4oC8q8JAXiwEDhug1kqDm1mFsL
 oafwFI4xeTdIPOpu4g/JZoB6pKLsu/UC8jUakkLrKIfUlpPJztSdo+tPaG7HB80VGoOY
 zrzcOMJYtsTzOsrtORaoQ5mqLV/XqXXNQF9OMkV0OCS4LQ7ysB6PPKMWa+crWWqA4rmR
 v5Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVzAcNCIJrdQskUKCp8ZKnV/yQd3MKKpoiGLehw5yqG2HimKY0pd5T2AfQ1ES+BO00qR9gER9lU/cB@nongnu.org
X-Gm-Message-State: AOJu0YyiSvFaskOxncAP9QBHfxw6awhh2kgxM8elE986JXPbD50NOA5q
 71X5/nOKXkGBYKfHNy2juWpRzGZuaq6RCVZIEdDCm8il3Y/GuQ4/RFEnl5Cwz10NX3vtigvn1ez
 JYC02m+FoOZt53iprltGrGjcYgZlx41WMsfpDwtFxULtXZK1z7A0J
X-Gm-Gg: ASbGncvMsM5G0g8/cU6/mGy6+PoKF0FUOy6rj2Kr8cudPpKwZW3yw/aWk7rxVHTgJaz
 gQkXFgc6rrHWqLFsvDEAiRUUSaYfMnQ2IMyfybs9MqoRezwfGSUox8W3dWiNzfYdD4ExKnEbYZM
 ZdX/Z9HTkgbXAOmpXX2+1j3RJVutLmIaV2O9z5VLRHxEtJ09X19nE6/mmgpgulRd+EFlzPRyIAj
 KoYd2hiSenVup/zbqyp/9TrBdt6URJHozEqUDE94n5H5T03VAiLC8CPlw51PfJZgvTuaEo9UpHr
 CUkPww==
X-Received: by 2002:a5d:4807:0:b0:3a1:f653:85dc with SMTP id
 ffacd0b85a97d-3a1f6538611mr5653469f8f.58.1746977736598; 
 Sun, 11 May 2025 08:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ycwjgRjqziI65+pULxKGTc0dlw2SMTOg50mM091k/Ks21xjHRlD+Y1viwUbus+NVE43a6g==
X-Received: by 2002:a5d:4807:0:b0:3a1:f653:85dc with SMTP id
 ffacd0b85a97d-3a1f6538611mr5653450f8f.58.1746977736205; 
 Sun, 11 May 2025 08:35:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddd5esm9458022f8f.6.2025.05.11.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 08:35:34 -0700 (PDT)
Date: Sun, 11 May 2025 11:35:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 kraxel@redhat.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250511113520-mutt-send-email-mst@kernel.org>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250309094039-mutt-send-email-mst@kernel.org>
 <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
 <CAGoVJZwg0KvZX7_OCFYp+RBk_fO4kBV3MmY3FxUC=RbnNKLtZA@mail.gmail.com>
 <20250511092651-mutt-send-email-mst@kernel.org>
 <CAGoVJZw=okgUdmSdWWc+iU7cQ0M7B-j0s66pWtqygZdYtJCgrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGoVJZw=okgUdmSdWWc+iU7cQ0M7B-j0s66pWtqygZdYtJCgrw@mail.gmail.com>
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

On Sun, May 11, 2025 at 06:20:41PM +0300, Yan Vugenfirer wrote:
> On Sun, May 11, 2025 at 4:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 12, 2025 at 02:43:52PM +0200, Yan Vugenfirer wrote:
> > >
> > >
> > > On Tue, Mar 11, 2025 at 4:02 AM Suthikulpanit, Suravee <
> > > suravee.suthikulpanit@amd.com> wrote:
> > >
> > >
> > >
> > >     On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:
> > >     > On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
> > >     >> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I
> > >     /O
> > >     >> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> > >     >> device is platform-specific.
> > >     >>
> > >     >> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> > >     >> undefined device id.
> > >     >>
> > >     >> Therefore, change the vendor id to Red Hat and request a new
> > >     QEMU-specific
> > >     >> device id.
> > >     >>
> > >     >> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs
> > >     /specifications/48882_IOMMU.pdf
> > >     >>
> > >     >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> > >     >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > >     >
> > >     > Will the existing drivers bind with the device then?
> > >
> > >     Existing Windows would not recognize the device ID.
> > >
> > >     Actually, Linux and Windows does not depend on the PCI vendor / device
> > >     ids to probe devices and initialize AMD IOMMU. Instead, it depends on
> > >     the ACPI IVRS table.
> > >
> > >     Checking on a real system w/ AMD IOMMU enabled booting Windows Server
> > >     2022, there is no AMD IOMMU device showing in the Device Manger.
> > >
> > >     In this case, I believe Windows is not fully initializing the
> > >     QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe from
> > >     the list of OS visible devices and therefore expose the PNPID to the
> > >     device manager. And since the device ID is zero, it appears as an "Other
> > >     devices->PCI Device (with warning sign).
> > >
> > >     Therefore, it we have two options:
> > >
> > >     1. Fake the device ID to 0x1419, which is current appear in the
> > >     machine.inf as an entry in section [AMD_SYS.NTamd64]:
> > >
> > >     %IommuDevice_Desc% = NO_DRV,PCI\VEN_1022&DEV_1419
> > >
> > > Considering that this is a "null driver" (no actual driver is loaded for the
> > > PCIe endpoint according to machine.inf), I recommend using this PNP ID.
> > >
> >
> > So this is the status quo really or did I miss anything?
> 
> There was a patch fixing it:
> https://patchwork.kernel.org/project/qemu-devel/patch/20250325021140.5676-1-suravee.suthikulpanit@amd.com/

Ah, right. Thanks.

> >
> > >
> > >     2. Figure out why Windows does not recognize the device.
> > >
> > > The answer is simple: the PCIe endpoint's PNP ID is unknown to Windows. So
> > > technically device is recognized (it is shown in Device Manager after all), but
> > > there are no compatible drivers for it. And in anycase, machine.inf specifies
> > > "null driver" for AMD PCIe endpoint IOMMU device. The device will get a
> > > friendly name in Device Manager and considered to be "installed" by Windows, by
> > > there is no actual driver associated with the device.
> > >
> > > Best regards,
> > > Yan.
> > >
> > >
> > >
> > >     Anyhow, we should still assign some PCI ID value (instead of zero).
> > >
> > >     Thanks,
> > >     Suravee
> > >
> > >
> > >
> > >
> >


