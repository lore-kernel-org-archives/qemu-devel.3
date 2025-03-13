Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B367EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskNf-00062H-1h; Thu, 13 Mar 2025 11:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tskNW-00061g-Pz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tskNU-0001Iu-L7
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741879301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USMSyPlnCMSsFnbzxMQqWxLyP2V8Xer7t4cUAjErJVo=;
 b=EPLVEs+piC6N2dup3tTwh0OJuFjhWxCsgNvVPIQ76LiNPyrkt/Qt3uE5ZkKarxbLxHMLNJ
 OkPnIJq4J/bn666E5k+4jmIDlw3/6og3bLflvAZTE0zFrMHsogGOAZ/XfvuD3bTjy/OKte
 0e52P8R4Zb1nLS1JzFlFXuBZrSnF4HE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-sRzAJ-X8M7OX9mT30Tv4CA-1; Thu, 13 Mar 2025 11:21:39 -0400
X-MC-Unique: sRzAJ-X8M7OX9mT30Tv4CA-1
X-Mimecast-MFC-AGG-ID: sRzAJ-X8M7OX9mT30Tv4CA_1741879299
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c549ea7166so167426785a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741879299; x=1742484099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=USMSyPlnCMSsFnbzxMQqWxLyP2V8Xer7t4cUAjErJVo=;
 b=ojgM8Xec+Vg1nSUyXe+uQLIKdBtzO5ayV20DlBQZCAu1F+2uj4HqOH4zugFF2sWVXp
 //2i3wnOZYNhOjpSj/x/8X4Hym2A4LQ5X6si8dSqHeRCiKBxRSgASN9/wdtMzrDNFzdJ
 gLI3UFsYcyPkrdauvUL4KRtGMogZhLQ71BMJmxW6xsjzS6BUlnuWtaJZ15WwNh9QDRB7
 DxjVUxGtzZcIz74TY8E6834u1cz9nZM5hOzD7sam/+nsAm5Doy2f5+a5pFTpSuX6Hfoc
 q4DdEphIa52yvvaBKpPzYWGH9t4LwaMXLwRdb7vhUGnrdkl7aBj7I36MvDLnqFzd8qz7
 6j+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNzfF+eUuV6RXS0lvb6bW1R5a0NnnH6PvjYgn7y2EWolZwl4rViROiOZz8+lGtNiWiRsM7BxzGtFOQ@nongnu.org
X-Gm-Message-State: AOJu0YyjkJbnBnuhGg1F+IY96i23PMz2TV/p8Idzl+4u6joFef+LfIrx
 g3F7C46sUk3SWvGI7AMELl63/gp36j+TIn2jcd4+cbPtSAP3wmlyeSRo6Bksq/nXKZMuQDsFNop
 yyf99lLlEJIX7lEy5c80Dm2eSMQTxGpgmwk4BIXEEH3IX+s/+IUgT
X-Gm-Gg: ASbGncu02oUjsns+c2ArnJUAO8JiJWl/ZP3VamIvJ6kPU1/b8ihY1GL6KfMvVFDqE3t
 PbxaxEWrW3712i9oStPCENgpOUE95S8jjSMa28tjGZ+wBMvu8wGWdMGQQgeAuiXi4cebXHlKbPp
 FBli/aPWwiy3v/fMOKt3rK0a1nBHGaic8d+DCa26tqtFQbI26kc+o5LQYgTspr7TOmhQn1vixxi
 nFxFfewNyAde4ZNt9E99QDEykiTcTPVIzpE3ayg8x4i/kW77snYSsecvZr11wg2YVM0f9nfC8I5
 FuLU+IwqB9V/cLMJVc8DU2pVBo1SME7IDgSR7clTpHWd5kzTAhIJ8aLYLEXakBI=
X-Received: by 2002:a05:620a:26a2:b0:7c5:444e:3f5f with SMTP id
 af79cd13be357-7c55e85d77dmr1921426585a.15.1741879299381; 
 Thu, 13 Mar 2025 08:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED/x29SDKnsuLZyswbtHRUAEtUvWlLyh/qXQWTu+nBOzoM5pNqxtoUj7f9k45ezjYi2jXfkw==
X-Received: by 2002:a05:620a:26a2:b0:7c5:444e:3f5f with SMTP id
 af79cd13be357-7c55e85d77dmr1921423785a.15.1741879299078; 
 Thu, 13 Mar 2025 08:21:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d89b9asm108637085a.99.2025.03.13.08.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 08:21:38 -0700 (PDT)
Message-ID: <64152d6c-4125-426e-9102-ec3e3afef1d4@redhat.com>
Date: Thu, 13 Mar 2025 16:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com> <Z9G4sj9sHNYb1t78@redhat.com>
 <2f44b284cb854844889b9ee8b6239e0a@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2f44b284cb854844889b9ee8b6239e0a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Shameer,

On 3/12/25 6:28 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Daniel P. Berrangé <berrange@redhat.com>
>> Sent: Wednesday, March 12, 2025 4:39 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; ddutile@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>> On Wed, Mar 12, 2025 at 04:34:18PM +0000, Shameerali Kolothum Thodi
>> wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: Wednesday, March 12, 2025 4:08 PM
>>>> To: Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>>> qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>>>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a
>> pxb-
>>>> pcie bus
>>>>
>>>> Hi Shameer,
>>>>
>>>>
>>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>>>> User must associate a pxb-pcie root bus to smmuv3-accel
>>>>> and that is set as the primary-bus for the smmu dev.
>>>> why do we require a pxb-pcie root bus? why can't pci.0 root bus be used
>>>> for simpler use cases (ie. I just want to passthough a NIC in
>>>> accelerated mode). Or may pci.0 is also called a pax-pcie root bus?
>>> The idea was since pcie.0 is the default RC with virt, leave that to cases
>> where
>>> we want to attach any emulated devices and use pxb-pcie based RCs for
>> vfio-pci.
>>
>> The majority of management applications will never do anything other
>> than a flat PCI(e) topology by default. Some might enable pxb-pcie as
>> an optional but plenty won't ever support it. If you want to maximise
>> the potential usefulness of the ssmmuv3-accel, and it is technically
>> viable, it would be worth permitting choice of attachment to the root
>> bus as an alteranative to the pxb.
> Ok. I will look into this. Though I am not sure when we have smmuv3-accel
> to pcie.0 we can still have additional smmuv3-accel with pxb-pcie or not.
> It looks like pxb-pcie will be plugged into pcie.0. And if that is the case
> IORT mappings will be difficult I guess. I need to double check.

Indeed it makes things more difficult in terms of id mapping but I think
it would bring some benefits to be able to plug the accel smmu on pci.0 too.

some logic should be there already because you can bypass the SMMU on a
given pxb while enabled on pci.0:
see

[PATCH v5 0/9] IOMMU: Add support for IOMMU Bypass Feature <https://lore.kernel.org/all/1625748919-52456-1-git-send-email-wangxingang5@huawei.com/#r>
https://lore.kernel.org/all/1625748919-52456-1-git-send-email-wangxingang5@huawei.com/

Eric

>
> Thanks,
> Shameer


