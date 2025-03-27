Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A687C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiAl-0005GK-Pq; Thu, 27 Mar 2025 04:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txiAb-0005Dy-6S
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txiAZ-0004rl-9d
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxfaTQSdvHZjS7LjY13E1smQ5Ve382WxRDisOF5oFTI=;
 b=AS9xwMCaKjPx8jWpzIdf+nCVmlUVco/ML/GZ0aky4jGEZ2msWjSPP1MSb6YWKS9r871kLD
 hVwD8WFc5iVCthqw+LfSVofIkdSNJFdekbpnsafiNdxvNZBWhW8nwiPkZJuSxsFT1a/ng3
 A5cXHtA9ibbLFsTMR9XSGpeQyt/eLQs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Y70aC2MJOAaA76WpmjynpA-1; Thu, 27 Mar 2025 04:00:49 -0400
X-MC-Unique: Y70aC2MJOAaA76WpmjynpA-1
X-Mimecast-MFC-AGG-ID: Y70aC2MJOAaA76WpmjynpA_1743062448
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471ddso531933f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 01:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743062448; x=1743667248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxfaTQSdvHZjS7LjY13E1smQ5Ve382WxRDisOF5oFTI=;
 b=LYzKhDGYzobwEKrcq0thFbkHVPWtcAbhELbkupfmoAi4ZVHRgaxPRzpTLpNI/9NCLJ
 S3/XyBbSTBF+v3H/temOL1NjqEKqGNBD17cPawvaq+S+3+1t8DFOMKdsH3mu/UKAfDoR
 7d06xI2RUk/VCqKuNC0nMbD5F8TUi9HrIJ9iqYfn4Luy9W3i+misJJ8kGVTIhOATa9/K
 PrInd89+AikciVjBe3SU9RlQG24c8Bw2VYQkGWkSHByH9il8L5vtrzmOLe5du/JYd/tJ
 5Be5AZRk0QwUakLesSNykoGIvNy/TSm9S1Y3zRWhPVG5ajye3fUMYGGdoKLM7M9C/imH
 WgHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGnyghbX0upuCHIDeuyVJDTG1qLYTpU5m3V8qUTk3r90hTo7UwOf4vtO/LLBlkpDm9UfP70kKiw6oz@nongnu.org
X-Gm-Message-State: AOJu0Yw9HY8VhMe24yoWobkrcpesJzssIAADpzI18r79XtVGUXKaoPhs
 DH7h9vA3+T9gl3bysLgv8KgmzeyAEDyo5V/X3AeCNHQfmz7oGuAnRTEKVBKJBAE8F0v++vLOPOR
 k2vJj/rEjF6/BYvXGkkZFBh8C7EnVxLCx3UJOQRqZQeSvdsPee94R
X-Gm-Gg: ASbGnctsv2pNqX+HrMuwxoHdGZI8w96KGrmzFg9xDfAoZi7VkU4wNFqc3yZQMevrS7h
 tiT7GCPR+XX0hy3prAymOdFnfJyhZ7tu1uaqL/2bk2P6mGo6F9KOjiW+GPMiCLSayUn3nFUkHtV
 oFvGCYzw0DTlBhAtH4q/ob1RTbFCnOzFpWCqdE0TgRzaZp5qlmSCswXM5698fMdUGzwCS+ChHE2
 Mqvclmm4AqaEtmiesfIcMfjKvUU5oLoGm218Pqlvry6GLLfefvF874f0cLf2twc0AXitRs/or+X
 PcXpbghTv4K7Qsr1Bvzed8hrrExG85P8QoIY1/9tpMPZtxXvwnrCbJPB9r0iqDE=
X-Received: by 2002:a5d:6c6e:0:b0:390:d73a:4848 with SMTP id
 ffacd0b85a97d-39ad17890d7mr1679282f8f.47.1743062447594; 
 Thu, 27 Mar 2025 01:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFImWHHKPP2XVOKF3TWzwH3mT8wImobp+z9D6Zm6z916TMvv9iqaThYMrsAPO2Cw9+AOaSG0g==
X-Received: by 2002:a5d:6c6e:0:b0:390:d73a:4848 with SMTP id
 ffacd0b85a97d-39ad17890d7mr1679225f8f.47.1743062447108; 
 Thu, 27 Mar 2025 01:00:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39acb5d0c33sm5861863f8f.26.2025.03.27.01.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 01:00:46 -0700 (PDT)
Message-ID: <deb9fd73-fc27-4eec-83dd-71f3f6908aa4@redhat.com>
Date: Thu, 27 Mar 2025 09:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 13/20] hw/arm/smmuv3-accel: Introduce helpers to
 batch and issue cache invalidations
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-14-shameerali.kolothum.thodi@huawei.com>
 <e23b4803-02d1-4850-8b6e-ad398a66a31c@redhat.com>
 <Z+RSeDAuUFtryi4E@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z+RSeDAuUFtryi4E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/26/25 8:16 PM, Nicolin Chen wrote:
> On Wed, Mar 26, 2025 at 02:38:04PM +0100, Eric Auger wrote:
>>> +/* Update batch->ncmds to the number of execute cmds */
>>> +int smmuv3_accel_issue_cmd_batch(SMMUState *bs, SMMUCommandBatch *batch)
>>> +{
>>> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(bs);
>>> +    uint32_t total = batch->ncmds;
>>> +    IOMMUFDViommu *viommu_core;
>>> +    int ret;
>>> +
>>> +    if (!bs->accel) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (!s_accel->viommu) {
>>> +        return 0;
>>> +    }
>>> +    viommu_core = &s_accel->viommu->core;
>>> +    ret = iommufd_backend_invalidate_cache(viommu_core->iommufd,
>>> +                                           viommu_core->viommu_id,
>>> +                                           IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
>>> +                                           sizeof(Cmd), &batch->ncmds,
>>> +                                           batch->cmds);
>>> +    if (total != batch->ncmds) {
>>> +        error_report("%s failed: ret=%d, total=%d, done=%d",
>>> +                      __func__, ret, total, batch->ncmds);
>> some commands may have been executed (batch->ncmds !=0). Is the
>> batch_cmds array updated accordingly? In the kernel doc I don't see any
>> mention of that.
> The uAPI kdoc of ioctl(IOMMU_HWPT_INVALIDATE) mentions:
>  * @entry_num: Input the number of cache invalidation requests in the array.
>  *             Output the number of requests successfully handled by kernel.
I was rather talking about the array of cmd itself but I guess it is
left unchanged.  don't know if we are supposed to retry sending failed
cmds or not.
>
>> Do you need to report a cmd_error as we do for some
>> other cmds?
> Yes, we do. And we did (in this patch)? cons would be updated:
> +    if (batch->ncmds && (dev_cache != batch->dev_cache)) {
> +        ret = smmuv3_accel_issue_cmd_batch(bs, batch);
> +        if (ret) {
> +            *cons = batch->cons[batch->ncmds];
> +            return ret;
cons is updated but error is not logged in this patch.
> +        }
> +    }
>
>>> +        return ret;
>>> +    }
>>> +
>>> +    batch->ncmds = 0;
>>> +    batch->dev_cache = false;
>>> +    return ret;
>>> +}
>>> +
>>> +int smmuv3_accel_batch_cmds(SMMUState *bs, SMMUDevice *sdev,
>> I was confused by the name. The helper adds a single Cmd to the batch,
>> right? so batch_cmd would better suited.
> Yea, it could be "smmuv3_accel_batch_cmd".
>
>>> +                            SMMUCommandBatch *batch, Cmd *cmd,
>>> +                            uint32_t *cons, bool dev_cache)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!bs->accel) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (sdev) {
>>> +        SMMUv3AccelDevice *accel_dev;
>>> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);
>>> +        if (!accel_dev->s1_hwpt) {
>> can it happen? in the positive can you add some comment to describe in
>> which condition?
> I recall this is for device cache specifically (i.e. CGFI_CD[_ALL]
> and ATC_INV) that I had in smmuv3_cmdq_consume(). Perhaps it gets
> here because Shameer separated the accel code from the non-accel
> smmuv3 file.
>
> This condition is to check if the device is attached to an accel
> HWPT, particularly to exclude commands being issued for emulated
> devices. Surely, if a device isn't attached to an accel stage-1
> HWPT any more, we probably shouldn't forward the commands to the
> kernel? Though I start to suspect that we might need a lock for
> accel_dev->s1_hwpt?
Yes worth to dig in and add a comment

Thanks

Eric
>
>>> +/**
>>> + * SMMUCommandBatch - batch of invalidation commands for smmuv3-accel
>>> + * @cmds: Pointer to list of commands
>>> + * @cons: Pointer to list of CONS corresponding to the commands
>>> + * @ncmds: Total ncmds in the batch
>> number of commands
> OK.
>
>>> + * @dev_cache: Issue to a device cache
>> indicate whether the invalidation command batch targets device cache?
> Maybe "invalidation command batch targeting device cache or TLB".
>
> Thanks
> Nicolin
>


