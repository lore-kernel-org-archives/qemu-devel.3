Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D8BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaes-0005Rm-Kn; Tue, 30 Jun 2026 11:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weaeO-0005L1-OI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weaeK-0003mM-Ot
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782834322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTIG68u+RKN829e8+UvspXHyVMwJkLzjPyf3W2fXnSg=;
 b=jLDwy3u3nShOHg5jelqhaTqBEnCBTFdmf/7jUqdD/DduM03vLyQZQJfkvbSAk+y8NAgivF
 ftBtDchejNWh9gZvDJmv9odBIdrhPWWbPKo5m7AJ/Kf6jsWxaDCObQX6YkxRAwvvY634l9
 p7julr6WWO3ErH/xR0d8Ru+SixnuzRQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-wPwkb8XTMn-6jYdfJ9RhMg-1; Tue, 30 Jun 2026 11:45:21 -0400
X-MC-Unique: wPwkb8XTMn-6jYdfJ9RhMg-1
X-Mimecast-MFC-AGG-ID: wPwkb8XTMn-6jYdfJ9RhMg_1782834320
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493b0a5e636so20224935e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 08:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782834320; x=1783439120;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTIG68u+RKN829e8+UvspXHyVMwJkLzjPyf3W2fXnSg=;
 b=NViU4dNqYhco3JiQEI++/vZwy1fBcgygE0n6Af4ceAGwRM2iA4WVtlvKfPBgDwSSZU
 5k5JDXAStS95suPUZk49ZasoJ8eVHErlbMAt7hZZqVKJqxRv12z4td43Cvj//Ybz+scb
 dXoYf1w+kN0J4tZIkNQ5A9ndtpv1tJfGH7Et5yTJuAFbZPwBgj9tQh/oYEbBSC6iJl5u
 0z8He2xDpsOTKBhWtmSIaTCbGGKaFllxe5ckXj+y5qSOoxccslqeP8wZOBhnjZBgjnff
 ql1dMYtj14ObCuSKjvHuE2RMz8CzNK+m1nwc/V3lOx8DPuVUfYESjuFR13xqpwFDzkTD
 5sUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cd4G7gIDPIF8Z7tgo4e+J2WqNpC44fxe8pJziGyiA71KbKL068+E8V7dcnLCKJTx6xWqEngG59WUm@nongnu.org
X-Gm-Message-State: AOJu0YwDR3VrsteAuH0jxNI88pbVdOQy4SFQ+QylN9FxBCHOJBvkNngI
 p0yGPekxiPaYU8KqlMYdgIyF+hUJzYSNpRnE4R1DjJGbdvkOoII/fiZVaLSeHV+bxecZ0T8aAjF
 XM8+wDvMO6aj5HavHirVlsXRwqSCxRm2/XLybeIweHfzIJ37szltqpBZC
X-Gm-Gg: AfdE7cl0nL+UmeiJ/6jG7IvSWcPzYHXSl9fG9bLhr+uGk1UDW3aNPkvSz8ZeAt0WmdI
 3JhENSlAZ0Z3qW1/JiwPxeShJg/jdZkS0VqsGccX+q89MUCnCjJIKKt61QRHrvSqhd3558RflAv
 myY1A9BMCOkmruEAkFtzNowdQb+9zmJX+f78qA8DHFD0nWbHmhfmldgVfr0F0Vs1g8jjAER4EN7
 yUlqWKqff+/JLWNOgyJvpgL2NR62uIEdad7Fhn1NbXkQ2vUW6+y9xRFDYlje0d55dbXLK6A/Hpd
 nn0QfSgCU3DU4aQFWHr+ZD62WQSo0k6sWIqiqe0y1fHlDAHBcMFI94H3lM/ky0Zah0DzM+Bxgdw
 4XHVnrKxcNr7BhJ1nGkITE/+2qEh7JJNL2Cs6jZK8vP+OynIAGJl3G2HCDnY=
X-Received: by 2002:a05:600c:a43:b0:493:b2c1:b2f9 with SMTP id
 5b1f17b1804b1-493b827ed93mr65790785e9.8.1782834319937; 
 Tue, 30 Jun 2026 08:45:19 -0700 (PDT)
X-Received: by 2002:a05:600c:a43:b0:493:b2c1:b2f9 with SMTP id
 5b1f17b1804b1-493b827ed93mr65790275e9.8.1782834319469; 
 Tue, 30 Jun 2026 08:45:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be810be8sm3104665e9.9.2026.06.30.08.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 08:45:18 -0700 (PDT)
Message-ID: <0cfb0e2e-d390-4159-be78-257c188b5c18@redhat.com>
Date: Tue, 30 Jun 2026 17:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
References: <20260630083042.2692392-1-eric.auger@redhat.com>
 <20260630083042.2692392-3-eric.auger@redhat.com>
 <SJ0PR12MB8614797527766BD0AFDE5717ABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR12MB8614797527766BD0AFDE5717ABF72@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Shameer,

On 6/30/26 11:43 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 30 June 2026 09:30
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>> berrange@redhat.com; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
>> Chen <nathanc@nvidia.com>
>> Subject: [PATCH 2/2] hw/arm/smmuv3: Sanitize
>> SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
>>
>> External email: Use caution opening links or attachments
>>
>>
>> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
>> emulated SMMUv3 MMIO register interface. Currently the value is
>> not checked.
>>
>> The SMMU spec says: "Except for readback of a written value, the
>> effective LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of
>> input StreamID range checking and upper/lower/linear Stream table
>> index address calculation."
>>
>> So for STE lookup make sure log2size is capped at SMMU_IDR1.SIDSIZE.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0a8d2fbb6a7..db5aca26ec0 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -672,6 +672,15 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
>> STE *ste, SMMUEventInfo *event)
>>      /*
>>       * Check SID range against both guest-configured and implementation limits
>>       */
>> +    if (log2size > SMMU_IDR1_SIDSIZE) {
>> +        /*
>> +         * spec says: Except for readback of a written value, the effective
>> +         * LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of input
>> StreamID
>> +         * range checking and upper/lower/linear Stream table index address
>> +         * calculation.
>> +         */
>> +        log2size = SMMU_IDR1_SIDSIZE;
> We are now limiting the log2size here and later in the code we use
> this for strtab_size_shift calculation.
>
> However, spec says(6.3.24):
>
> "The alignment of ADDR is affected by the literal value of the respective
> SMMU_STRTAB_BASE_CFG.LOG2SIZE field and is not limited by SIDSIZE."
>
> So this will change the behaviour now. Please check.

You right, there is this statement  + the existing comment in the code +
the additional note: "Note: This means that configuring a table that is
larger than required by the incoming StreamID span results
in some entries being unreachable, but the table is still aligned to the
configured size."

and then there is

"../.. the effective LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of input
StreamID range checking and upper/lower/linear Stream table index address
calculation.
"

This sounds contradictory to me.

On the other hand who is going to program an LOG2SIZE greater than the SIDSIZE?

There is no further info about log2size limit and with some of its values spec ADDR alignment computations cannot apply

ADDR[LOG2SIZE + 5:0] = 0.
ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] = 0.


Adding to that, the code currently does not consider SPLIT >= LOG2SIZE case and also the ignores aligment computation of L2PTR according to span.

I will do my best to rework that ...

Thanks

Eric


>
>> +    }
>>      if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
> This MIN check now is redundant here, right?
Yes it is
>
> Thanks,
> Shameer
>


