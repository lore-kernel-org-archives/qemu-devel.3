Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260F2C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFy4W-0001Hw-Si; Fri, 16 May 2025 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFy4U-0001AW-QJ
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFy4S-0007Vx-I1
 for qemu-devel@nongnu.org; Fri, 16 May 2025 12:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747413480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tiuq7kBnNesUutz/zGoF5II+39+EXnGpZyQPpuHM1Bw=;
 b=Wzlb5tGKwF1KhsDGBWZMJ5J+ttEacBLgm4p9zdCG4mOot+XxiS5aqkTPGIGfJDgFFCPuhU
 E01EdghxXrkFgm8y3Jd+zjVM/iRa0HOk7dEKE/YBi5UQVb/8tNIDtwBrU5Ut7G5IbxszKl
 WzwotmcOETR2Z2arBtV0IHQfVycMR74=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-dYfJd893MZ6AFOBxt7z76A-1; Fri, 16 May 2025 12:37:57 -0400
X-MC-Unique: dYfJd893MZ6AFOBxt7z76A-1
X-Mimecast-MFC-AGG-ID: dYfJd893MZ6AFOBxt7z76A_1747413476
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a364394fa8so212429f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 09:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747413476; x=1748018276;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiuq7kBnNesUutz/zGoF5II+39+EXnGpZyQPpuHM1Bw=;
 b=gRuQLO8a/aWMlaIQVMD8jaRrQ2T1PIiEnNuc9EjXYugJXchfqpoCbH3L4zq+m7UV8t
 IR2J0s0tahYJ0vZ7MG7a2BhSR6rzDGrvT/AkMadsURQQglrteEEjWR4oGfFGNDrGiFtG
 VAK2LOskQjmtOjsdsCftVfJMTOg0CS52UqA4nW/9ZYwVWyVSW60CA3KMOMnfG5szBA0i
 Pv1UvDa+xH03f2YIH96OeaWysbHWMIKxzAtYA0srTLVhd2+rMy/0vuQsF4L3TxNFdqcd
 UmwE/qnZys7O1s0GNhesW+jMhxX+qXIbUl41mlGdTx0nT4PNXcfgrLhXsFTnUEw6HT5g
 dF0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/lnseUmKLG7lhTGh4YACvEaLE8YC+M22AH5gTvuR53bLbUDKpRsQJGCHAk42nSHdwyZB1aeab3vtu@nongnu.org
X-Gm-Message-State: AOJu0Yw8xfiKuOIch5dbqtCCJ5sRw8oGQwuG1YO9UJ8k8TBKyRA1w6L2
 KdFJzWvm2G2VtbDgHgh90PuBd6f2C7XWk85KDmSSuaTsunf+RnhVFMHd4sR3+XPj2sovl4fNSbZ
 fpavi70DBwfk/dAFx4adGIfJb8CoeUjgjikwHO8BAmEzDX3qykaLXet7c
X-Gm-Gg: ASbGnct+jrJX5K8RJ0MUktUVdyIHVpHYfmTdn+cmCenlGiKZI71XRI0F3veWT9Y5miz
 QCMm7IqXzJMxMlyybjwYtQ8yHORJhzm/RovAfDBTGGHwb43NUH3n/2V/NMrkOvKq7YMtqumJEAN
 D3O1ZvJU38GpqlzeN+d0HwcOaGPizz3BafRGdQY3YHEpUk2Oj9X1SGcbJT8YbIvv5zaY46PTROk
 vKlBwpV/q8vc+qSHez2Bu6hrLvMmzQqfo6Gp8h1zwXu90a+9wRN2549o90V1tJVPtt8ephlRfxy
 Gv3sAvq6WLs/gUo4Rdnp2/wmBjKcNYJ0hl768m/KDvASn7E=
X-Received: by 2002:adf:f650:0:b0:3a3:61b8:a644 with SMTP id
 ffacd0b85a97d-3a361b8a679mr2078454f8f.19.1747413476152; 
 Fri, 16 May 2025 09:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7H2ucu7skbIni8Ysh0ZYnBkEBwKPlXwzwoXekai3ExL31HqW8tCVHHiHq5qE7DWR1kDPX5w==
X-Received: by 2002:adf:f650:0:b0:3a3:61b8:a644 with SMTP id
 ffacd0b85a97d-3a361b8a679mr2078427f8f.19.1747413475737; 
 Fri, 16 May 2025 09:37:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d2d1sm3451953f8f.19.2025.05.16.09.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 09:37:55 -0700 (PDT)
Message-ID: <1ad33986-dac9-4d89-ae54-e2ba31cee748@redhat.com>
Date: Fri, 16 May 2025 18:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/42] Live update: vfio and iommufd
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Levon <john.levon@nutanix.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Steve,

+ John

On 5/12/25 17:32, Steve Sistare wrote:
> Support vfio and iommufd devices with the cpr-transfer live migration mode.
> Devices that do not support live migration can still support cpr-transfer,
> allowing live update to a new version of QEMU on the same host, with no loss
> of guest connectivity.
> 
> No user-visible interfaces are added.
> 
> For legacy containers:
> 
> Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
> skip the ioctls that configure the device, because it is already configured.
> 
> Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
> regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
> QEMU and update the locked memory accounting.  The physical pages remain
> pinned, because the descriptor of the device that locked them remains open,
> so DMA to those pages continues without interruption.  Mediated devices are
> not supported, however, because they require the VA to always be valid, and
> there is a brief window where no VA is registered.
> 
> Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
> and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
> vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
> data structures, and attaches the interrupts to the new KVM instance.  This
> logic also applies to iommufd containers.
> 
> For iommufd containers:
> 
> Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
> backed by a file (including a memfd), so DMA mappings do not depend on VA,
> which can differ after live update.  This allows mediated devices to be
> supported.
> 
> Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
> QEMU, during vfio_realize, skip the ioctls that configure the device, because
> it is already configured.
> 
> In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
> locked memory accounting.
> 
> Patches 4 to 12 are specific to legacy containers.
> Patches 25 to 41 are specific to iommufd containers.

For v4, could you please send a first "part I" with patches [1-20] ?
I think these are reviewed, or nearly, and could be merged quickly.
Even if the "Live update: vfio and iommufd" series is not fully
reviewed yet, there are good signs that it will before the end of
the QEMU 10.1 cycle. The same applies to vfio-user.

We need to bring together the proposals changing memory_get_xlat_addr().
It's important as it is blocking both the vfio-user series and yours.
This can be done in parallel.

Then we can address the iommufd part.

Thanks,

C.



