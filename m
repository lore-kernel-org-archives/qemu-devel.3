Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B62D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMj5-0005m8-8r; Thu, 15 Jan 2026 07:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMid-0005iA-2p
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMia-0002LN-GX
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=diCN32yadw+M+p+dim/v/PRbRLDey/3McuQQoWLNtzM=;
 b=WzwqIQ3t97DSQMSOY5lNEQFfz73f9WuUXWZF+h0m62XnwFQNkb/jo7CgkIDsDaZ1uoQr+l
 ZQd6bW9XbRDdtiCpYE1MJj4ABgONFtDgVtqIcNwCUxPnR4LlclVexFBez5kh+vVt3dh7v5
 IoUBNXsvt1ejnyu4C8VY7joWYavgqRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Egye2dG1NSWgww1uDCbaNQ-1; Thu, 15 Jan 2026 07:44:48 -0500
X-MC-Unique: Egye2dG1NSWgww1uDCbaNQ-1
X-Mimecast-MFC-AGG-ID: Egye2dG1NSWgww1uDCbaNQ_1768481087
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so4763395e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768481087; x=1769085887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=diCN32yadw+M+p+dim/v/PRbRLDey/3McuQQoWLNtzM=;
 b=cdc8ieU6cTW73+U1ioMFsCD5WuIe62LrwDoBUSFDRFcCFHYLIloH/oNVx4U+GtVYPM
 nW87a+xxk+pcS/ZBkgZVfELQIXidONPwVJDTG9FuGldlkT+NwVTKD2+lv2W15WWiDUUg
 DDhS0gJk8tYMEp5Uwy9eMdVN93O5p97ETw7vzu4e766NyPTke/wKWiES33u1089lqgWE
 p408mMP34NKwxGTfAOJYFoNMRrX9p/bSTkiP+L1GKNvfcl0AqkZRbpUKcbyX0r3tZ37a
 LRUHojJC0aSoxbipDkygWZ/CqlwGPN3sT68wt3isPxzWNrhKbnvVO2/uHZOOinLGTNXf
 ogdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481087; x=1769085887;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diCN32yadw+M+p+dim/v/PRbRLDey/3McuQQoWLNtzM=;
 b=hUSd/fJFnDxws+k9/ydztbO04/aNFqhAPzym/daDRR1XEDsy2LkfYNGp699M8P5JFG
 eW367ANSSOfZ3drQXIzrgFvOSvjoPOHQkOlySU1penQHffn2BHmg1VuOkgsvzz5f1UQv
 cyGCQFzn1UwgfnTWlUcdXtuLqVPWI82c13VeG2zgBO/z+Rp6GclI9sA62lhICwm5/OGR
 3kHbTzS6VOPv1nHHbbPrqcjI8q974gKzf4svKsB/j0X1g1e2Ho2wnydeovGEq+thpQMx
 /7cMQW1djlRb5RuhIXeVwH+7se86TI9OTkeRiJQ+sz8TiaIh1SbOO7jO/bDzmaQyr4W3
 ejhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfyppyIpqkn7zZMmH4CUliHhcpxM3X7zVeAdTg//mPMtiEj2fG3LKtqR/C9rrmlOlqZlweXUbOKQwl@nongnu.org
X-Gm-Message-State: AOJu0Yz4F/sLRT1YdZKOot0KbIXT/8PjVFG62kQvlRQyWktS4U3NKih/
 tmPgjMdlvtsRBeSIS/D+qbckFAQJpsu7Rh61kCn7EgLZgdY28VSDfMm12SAEUemdYVhkFx0VHbJ
 4sIFwkj+PVdDLzsIOrJCg23i1P520OM9tkYbBLCTtLaK/CM1O2NRoeYUZ
X-Gm-Gg: AY/fxX7zrx+Fo3H9TXr9zYQu71K+AzHepVXFFMxsxEDa+X8vytkYAsCNnkwPwfSKoWf
 YNTEacwEA09D55L1+UGxF7t6a+IiPlutWOx35S9OCaiMrY893EF5rGKsMrUaK61NP46zHdDzoDi
 xNh+QfgIQGSiLskllPLMKERvl7ObCnvtSR2aeJirE6tjBEZFtP1fyCg/GOZcvaF0pVlKVqkRla0
 T+yfEvwMKLaiBsMR2DEx2qhFqZgF9wVYNvNebJnoezi6ZQhX/ESuh4BG5mm/XzZMnr3IjgvJTDd
 7+leeGwg5tG5/cDRALX1nhBFkq6NAroZdWYrufR9cP400ol+RCKa+LD11omjXNqWz9KbCBZ+ZeV
 Qze01H9x0FZ3i06PMwP/JHds6hslzsoct4WqQsKSaWznGIwtY
X-Received: by 2002:a05:600c:3544:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47ee335494fmr77437245e9.15.1768481087465; 
 Thu, 15 Jan 2026 04:44:47 -0800 (PST)
X-Received: by 2002:a05:600c:3544:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47ee335494fmr77436825e9.15.1768481087111; 
 Thu, 15 Jan 2026 04:44:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a5bbsm5572550f8f.2.2026.01.15.04.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 04:44:46 -0800 (PST)
Message-ID: <219d7d36-65da-4638-91a3-f26aa364ffc7@redhat.com>
Date: Thu, 15 Jan 2026 13:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/vfio: Add helper to retrieve device feature
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex@shazbot.org, cohuck@redhat.com, mst@redhat.com, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com, kjaju@nvidia.com
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-4-skolothumtho@nvidia.com>
 <20260114101949.0000669d@huawei.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260114101949.0000669d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/14/26 11:19, Jonathan Cameron wrote:
> On Tue, 13 Jan 2026 11:37:53 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> 
>> Add vfio_device_get_feature() as a common helper to retrieve
>> VFIO device features.
>>
>> No functional change intended.
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Hi Shameer,
> 
> Happy new year.
> 
> Trivial thing noticed whilst glancing at this.
> 
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 100532f35d..0d9f42a1f0 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -516,6 +516,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>>       vbasedev->bcontainer = NULL;
>>   }
>>   
>> +
> 
> Stray change.

Yeah I can fix that when applying. No need to resend.

Thanks,

C.
> 
>>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>>   {
>>       VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
>> @@ -527,6 +528,15 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>>       return false;
>>   }
> 


