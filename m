Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C033ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKgJ-0001BJ-9v; Mon, 27 Oct 2025 06:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKfz-00019F-9N
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKfv-0001eK-Un
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761561726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggc9Kl5RED4VqQC3cCXuhQvZwtc/ehSI3z2ToDhGaVk=;
 b=RrkrgqiGVLNQx/ao43r+quLmsP/XedPqLg204QfImmC3x4CRD8Oi2hZWi6KFjZRLJ9NQ+C
 j252+UiVP/YXtisvYysiQGqV3780MFp8gnc1tzPJdU9FzXkvKSPzHsHH/Owab3LfT+s/Kv
 /uNS7sRC9AG2iqZrBnTFd6GtlDyfVPA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-OlsfqCbqMkaj3qH1FDScmg-1; Mon, 27 Oct 2025 06:42:01 -0400
X-MC-Unique: OlsfqCbqMkaj3qH1FDScmg-1
X-Mimecast-MFC-AGG-ID: OlsfqCbqMkaj3qH1FDScmg_1761561721
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4298da9effcso2298475f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761561720; x=1762166520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggc9Kl5RED4VqQC3cCXuhQvZwtc/ehSI3z2ToDhGaVk=;
 b=IPpkgJXyhULPn160O2X9wCldcYS10395rdSwuxEosxXOB0apUjNbEOVCxABoaaQhyP
 7Hp762T/30fRbRJmSiS0YqjuXEUFySyzsuCgCUlNajbpUi/ulo1D/qrGWSvrgEWw2b2j
 fbT7gzXskl2b3pKNsHlCNje4N5diEviyucrNHW50DMexUmGwMjD4DnsD8LJsFITRlsqd
 P4kvJM19Y3lwl6z+cLfKiktBIi+WKEV+YZHecFJdGTWNdUJw7RxM6YXFBez97J3JmRqu
 shtxbreAqCzvPNkdBctfISfWjlfwRMUrcAig0JM5ifSqAl8jKjuSpJ0wvyIZlDjHGsW4
 WLCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjk3j4mBvLn1gGWRPKPUiBwLRaTUs85vis8+9F57k47umodujs3IDY/IB22QykZscs4iFxlEHrHilz@nongnu.org
X-Gm-Message-State: AOJu0YyJ9h8p2nrQQGjOscuwpx81RU0rqtVI+xr0ID6WJlzALhYpdnss
 /ogKfIyC6c6BEztdbUz/tbUDQaXYhQvNpbo0VLweSkEZGeANqbRmp60cN9ggiDatdBok5YDlkNt
 rMFKO40swHXZIdgLallU7xDMtlaHIZfk7sMKgUZOMVyPIbgwM5B0IUYxl
X-Gm-Gg: ASbGnctSw3yZXmJeYzNEVzhdRqApPnj4zZDE04HkTwRU0x70XrsxFp6QnD/hB2o7uJi
 D1wUuwuP5GvcMzKaZmg0O+CKDM3qKUteAppNVjhfNazwF3WWsnQuKNJR+SrTcXdipTVmPSEZ9Z9
 Dp8jzGmEURYf4GoQH9Usa91LKRuDeQTDX1SnDmoSl5S+KCplS0ooVUX7mBx7OenD5Z50ZV6ylg3
 1n74d5Xxzck2CD3C7iZiF2F1LvJR++IqN0LxW1k3BYu+AEk/NQoKU/xw1r0beIMkR1BP70Np9Fp
 hTbK9TDs89x33WdY1253o3Kt4yfbuCT7W5tY9w1o1bImzZ5aC6jqTkOMwB41DC78iMaRlvsgYAq
 SC6aLV6kbcvxtCDZffWaJVyrCT06aJPvfzzcPZ4DrYcobHA==
X-Received: by 2002:a05:6000:2dc6:b0:3ec:d78d:8fcc with SMTP id
 ffacd0b85a97d-42990709209mr8727409f8f.14.1761561720474; 
 Mon, 27 Oct 2025 03:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfvd/sB9b0esZvz/GpS3GBe7DnAoRPrdKfhSzVnKcMCtpxhLjomzc8Fu2Lmbq5E2nLEBIIfQ==
X-Received: by 2002:a05:6000:2dc6:b0:3ec:d78d:8fcc with SMTP id
 ffacd0b85a97d-42990709209mr8727369f8f.14.1761561719901; 
 Mon, 27 Oct 2025 03:41:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db839sm13904322f8f.34.2025.10.27.03.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 03:41:59 -0700 (PDT)
Message-ID: <c7253b37-23bb-4147-8415-3c05aa7c15e4@redhat.com>
Date: Mon, 27 Oct 2025 11:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, nicolinc@nvidia.com, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
 <20251001135604.00006776@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251001135604.00006776@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer,

On 10/1/25 2:56 PM, Jonathan Cameron wrote:
> On Mon, 29 Sep 2025 14:36:30 +0100
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
>> Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
>> features are compatible with the host SMMUv3.
>>
>> Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
>> Only the following fields can be used:
>>
>>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
>>   - IDR1: SIDSIZE, SSIDSIZE
>>   - IDR3: BBML, RIL
>>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
>>
>> For now, the check is to make sure the features are in sync to enable
>> basic accelerated SMMUv3 support.
>>
>> One other related change is, move the smmuv3_init_regs() to smmu_realize()
>> so that we do have that early enough for the check mentioned above.
>>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Hi Shameer,
>
> Back to this series...
>
> Various things in the checks in here.
>
> Jonathan
>
>> ---
>>  hw/arm/smmuv3-accel.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/smmuv3.c       |  4 +-
>>  2 files changed, 100 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 9ad8595ce2..defeddbd8c 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -39,6 +39,96 @@
>>  #define STE1_MASK     (STE1_ETS | STE1_S1STALLD | STE1_S1CSH | STE1_S1COR | \
>>                         STE1_S1CIR | STE1_S1DSS)
>>  
>> +static bool
>> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>> +                                 struct iommu_hw_info_arm_smmuv3 *info,
>> +                                 Error **errp)
>> +{
>> +    uint32_t val;
>> +
>> +    /*
>> +     * QEMU SMMUv3 supports both linear and 2-level stream tables.
>> +     */
> Single line comment would be more consistent with below and looks to be under 80 chars.
>
>> +    val = FIELD_EX32(info->idr[0], IDR0, STLEVEL);
>> +    if (val != FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, val);
> This seems a rather odd side effect to have.  Perhaps a comment on why
> in error path it make sense to change s->idr[0]?
also consider s->idr[] are not migrated. I know there is a migration
blocker set in 20/27 though. I would simply return an error here.
>
>> +        error_setg(errp, "Host SUMMUv3 differs in Stream Table format");
>> +        return false;
>> +    }
>> +
>> +    /* QEMU SMMUv3 supports only little-endian translation table walks */
>> +    val = FIELD_EX32(info->idr[0], IDR0, TTENDIAN);
>> +    if (!val && val > FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
> This is a weird check.  || maybe?
>
> Otherwise if !val is true, then val is not likely to be greater than anything.
> imply check info idr0 ttendian == s->idr[0] one (=2)?
>
>> +        error_setg(errp, "Host SUMMUv3 doesn't support Little-endian "
>> +                   "translation table");
>> +        return false;
>> +    }
>> +
>> +    /* QEMU SMMUv3 supports only AArch64 translation table format */
>> +    val = FIELD_EX32(info->idr[0], IDR0, TTF);
>> +    if (val < FIELD_EX32(s->idr[0], IDR0, TTF)) {
>> +        error_setg(errp, "Host SUMMUv3 deosn't support Arch64 Translation "
> Spell check the messages. doesn't.
>
>> +                   "table format");
>> +        return false;
>> +    }
>> +
>> +    /* QEMU SMMUv3 supports SIDSIZE 16 */
>> +    val = FIELD_EX32(info->idr[1], IDR1, SIDSIZE);
>> +    if (val < FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
> Why not
>     if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
> 	FIELD_EX32(s->idr[1], IDR1, SIDSIZE))
> I.e. why does the local variable make sense in cases where the value is
> only used once.  To me if anything this is slightly easier to read.   You could
> even align the variables so it's obvious it's comparing one field.
>
>     if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
> 	FIELD_EX32(s->idr[1],    IDR1, SIDSIZE))
>   
>> +        error_setg(errp, "Host SUMMUv3 SIDSIZE not compatible");
>> +        return false;
>> +    }
>> +
>> +    /* QEMU SMMUv3 supports Range Invalidation by default */
>> +    val = FIELD_EX32(info->idr[3], IDR3, RIL);
>> +    if (val != FIELD_EX32(s->idr[3], IDR3, RIL)) {
>> +        error_setg(errp, "Host SUMMUv3 deosn't support Range Invalidation");
> doesn't.
as Jonathan suggested you might avoid using the local var here too and below
>
>> +        return false;
>> +    }
>> +
>> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN4K);
>> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
> That doesn't smell like it's checking 64K
>> +        return false;
>> +    }
>> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN16K);
>> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
>> +        return false;
>> +    }
>> +    val = FIELD_EX32(info->idr[5], IDR5, GRAN64K);
>> +    if (val != FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
> Nor is this one seem likely to be checking 16K. 
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool
>> +smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>> +                           Error **errp)
>> +{
>> +    struct iommu_hw_info_arm_smmuv3 info;
>> +    uint32_t data_type;
>> +    uint64_t caps;
>> +
>> +    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
>> +                                         &info, sizeof(info), &caps, errp)) {
>> +        return false;
>> +    }
>> +
>> +    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
>> +        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
>> +                     data_type);
> Alignment looks off.
>
>> +        return false;
>> +    }
>> +
>> +    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
>> +        return false;
>> +    }
>> +    return true;
return  smmuv3_accel_check_hw_compatible(s, &info, errp)
>> +}
>> +
>
Eric


