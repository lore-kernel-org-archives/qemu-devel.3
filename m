Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0954FC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Cy-0002rg-Ot; Tue, 07 Jul 2026 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1Cu-0002qt-6H
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wh1Cs-0005GM-Fz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783413065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unAiXO7cmYlJvW+etRFTby3V4Sx+xIzamQPGznRiikU=;
 b=OInP3K506FC2oZTREzB60FkMMzqmOqkVqq5axitX73Oecu6QrIx0AhYOmUhyLXjLbFE2tZ
 EB9Cpz8zNJGvwunTijb82lVdm4TRC4H4nyB1DZa6KGSdpNyQq7j6G3bJBfU1XKsDKLB+dV
 +4HLN+m3fTqGPRU6Gum7KVd4A2S5s5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-1xm1pGymMk2AWAaf7qeKRg-1; Tue, 07 Jul 2026 04:31:03 -0400
X-MC-Unique: 1xm1pGymMk2AWAaf7qeKRg-1
X-Mimecast-MFC-AGG-ID: 1xm1pGymMk2AWAaf7qeKRg_1783413063
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49244130073so26529615e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413062; x=1784017862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unAiXO7cmYlJvW+etRFTby3V4Sx+xIzamQPGznRiikU=;
 b=r8IILPEJ0gpU7oASp1t0Z5fnGQOzKVpISy3wl6t622I8SZXsFImP3PutgL8QPYkiiq
 YL+ezogKN/vG59rUG/x2jOc8UcElSD8NIie8kZWKVdl+ltkdPDvemRaKguzMXWkE/CSF
 7hVRZxZrZjQ+Nq2CyHBu4AVU4VZB9DJBOWLbsBIFyBr39UamOKR+nErCSNmCeA7FRQVa
 o3rP/GcUu0p3DIcMFTtiOmmb5kuPRSOgqiEuUQeLh+F3y/t5jwScNCA/2dnyvbWD6nye
 u2YgO3F6McVNTrOTm9JspHpn8O+CjCprDT/Obn3sR4j633X16c6AzaXgxlRqjuItdu3r
 Ay0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTnepSJAVecsLLxq7nRpNDS2aYBqRH0FPiILXmkp/qy1qyA/M0vNl/HnelGqDnjBUNBiQGZ3xr6bA9@nongnu.org
X-Gm-Message-State: AOJu0YxIzdjO3AlncqV/h9/0BWpz8vuisqtBKDHu62YoiZnWJr7BqjGY
 IHlRj5cnrzFQIKcRfVGC2EtlpcQpADVaRvj5vE5zVv9k1h3ZQGL4Uxy/1ntE5uYdK+YwZtDDKEc
 HOylnx35qxzVL9ja+SGmpPWoioeyu3CpvPDJPaYsChWWTAuVetjol0VHb
X-Gm-Gg: AfdE7cmE7NbHF1onGgUX4K/5ddbHSyFrwiiNvGbwgtNRUp0Ymu/kvsKIAnAdCZE5Rph
 vY44LQxzXdhBhiv+Bh8Gl7ThiceUVogN79HWrfrOL9BXe7fNoggUsNYqOl3NLXR6oZCxQScQCLf
 jBgbdJI3Q1yimpnbyY0eXBPX1c/YaxuJPliDz4n4UGNVOIyBYDO51Rjq9FItvSQMV14HPHAsuk4
 RY1ho6K1bw+LpkS9wlX8Ndo3j4hl8dAt4Q6qXlNrohJxgbnKOY5ZY/2rofLHqABYX2+TWxzRLIW
 wnIB06nkfT3tZGqGJVr0IuQTlr0ebxqIVTb3nKfgwZr5fLrVBNuaG3J8D3Y/P8uwvcXDpUnXfis
 wbeTxIOpT36SZxNFYo4l3yCCQmE4t88xPZxmyfTQSa3m6GBiDrYdHHXMXFWiCSQ==
X-Received: by 2002:a05:600c:34d0:b0:493:bfea:2780 with SMTP id
 5b1f17b1804b1-493e2a69591mr11561945e9.9.1783413062688; 
 Tue, 07 Jul 2026 01:31:02 -0700 (PDT)
X-Received: by 2002:a05:600c:34d0:b0:493:bfea:2780 with SMTP id
 5b1f17b1804b1-493e2a69591mr11561265e9.9.1783413061920; 
 Tue, 07 Jul 2026 01:31:01 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3?
 ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0aa7da9sm39974375e9.1.2026.07.07.01.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:31:01 -0700 (PDT)
Message-ID: <64455e5d-4b1e-4cf7-8aec-0b1aacf89cce@redhat.com>
Date: Tue, 7 Jul 2026 10:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 berrange@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com,
 nathanc@nvidia.com
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-4-eric.auger@redhat.com>
 <CAFEAcA8kHPouGSrxb7+NkTRonEoJiub4JNuThSJBr6hncrX0vA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8kHPouGSrxb7+NkTRonEoJiub4JNuThSJBr6hncrX0vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer, Peter,
On 7/3/26 2:54 PM, Peter Maydell wrote:
> On Wed, 1 Jul 2026 at 10:12, Eric Auger <eric.auger@redhat.com> wrote:
>> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
>> emulated SMMUv3 MMIO register interface. Currently the value is
>> not checked and used directly in smmu_find_ste() for strtab_base
>> alignment computation with risk that MAKE_64BIT_MASK() runs out
>> of bounds. On FMT==1 the strtab_size cannot be greater than 64 after
>> the SPLIT being at minimum 6 (log2size is max 64).
>>
>> However on FMT=0 path, strtab_size= log2size + 6 can potentially
>> exceed 64. Let's abort in that case.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 285e6164a07..5ec3700d0d5 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1696,6 +1696,14 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>                  s->sid_split = 6;
>>              }
>>              s->features |= SMMU_FEATURE_2LVL_STE;
>> +        } else {
>> +            uint32_t log2size = FIELD_EX32(data, STRTAB_BASE_CFG, LOG2SIZE);
>> +
>> +            if (log2size + 6 > 64) {
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "Invalid STRTAB_BASE_CFG.LOG2SIZE: %d", log2size);
>> +                g_assert_not_reached();
> This doesn't look right. Either:
>  (a) the guest can do something silly that gets us to this code path:
>      in that case we mustn't assert, but must continue (doing whatever
>      the spec permits and that is reasonably straightforward to implement)

Sorry for the delay

OK. Then I will just follow Shameer's suggestion and cap strtab_size to 64.

Thanks!

Eric
>  (b) we can't actually get here in practice: in that case the logging
>      isn't needed and we could just assert(log2size + 6 <= 64);
>
> It sounds like we're in case (a) here.
>
> thanks
> -- PMM
>


