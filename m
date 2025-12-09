Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FAD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSuoL-0001Ax-VQ; Tue, 09 Dec 2025 05:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSuoH-0001A1-Pz
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:19:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSuoF-0008KT-1g
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765275545;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKI/cbDBHbKZsK9LoLRPEKXmj7kEki7sWCgJioeY/8U=;
 b=ghTCI0AsCNYz363h5UAz4SdpsaWH7/EuJdF0098jFsHcZ/K46u6sEjkXsAYQmjHOEXvL3R
 70xM/+onWBkKUAA70Hj2rOdjFnSEqCzAQ4SY18HkbKGeie2f3QXizJSVANNRk6Z/aNKVvK
 gmemVP2vBNZXkDB2sKj5LTLzdVA5CfQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-IZWDCLS9O8Scz5oPwY0TsA-1; Tue, 09 Dec 2025 05:19:03 -0500
X-MC-Unique: IZWDCLS9O8Scz5oPwY0TsA-1
X-Mimecast-MFC-AGG-ID: IZWDCLS9O8Scz5oPwY0TsA_1765275543
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso6390598a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 02:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765275543; x=1765880343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKI/cbDBHbKZsK9LoLRPEKXmj7kEki7sWCgJioeY/8U=;
 b=M+D6EWyyquYmWBRKsXCLX+kZlXOPgX8w5jTuVZREnib/pFS1E5zmlD0ulinrAYhKmO
 lZC9NwQ/50l7CsU9Av4pr3Kydtyi227O9yfF7Rg42T7qdJrQGyTo+QCUpLKBO/WRKcJJ
 G3SrfF2cApYNCCcVPidwt35DLoOv34ecAgdoUl1cNk6uDksns1jioZBAJzjvckf9NfXy
 kbbfHu0I4KWbkXAcX58OsuWoCE2WpehvzdkJRmP+lmZh/xZvbdpSMHIZhPm17qx5UgfY
 42O/ww1SJgdv2TYbHPtMTrK6fVmAu/qhfp7wYa2HvucPydxPasgVX1yPS3B9HZsqCfxa
 LcpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpLJgR3tW0NDfckO/DvLhvNARdgDJ7I3Ne8sDQT88HVLZlBwyguIiTIPMoa4B/tnXM+xKQ2Bv66zGy@nongnu.org
X-Gm-Message-State: AOJu0YyHc8ptfsv4mUYEsR6e5pUwkRpVquuxgFhEC1Nj73KSndjyT58o
 2+R/VlSsOE9ZBOdo5kvgKGSCBApVKDB5sIiu5aBrvv1/8RIBr+7NDTEe1NMoMZx5q5FSfbHR1xk
 j/17ZROBztrfapo5X16eUEccWrxeCUG94zRnvDrhs63wDoBWW7f7i/TeL
X-Gm-Gg: ASbGncvvP35ZS2xxYNPIxcgUekDKdntr2OrFkT/v8GYVwCYlTjh+6O+ZJD6fNHBrhPE
 mawDWVPDOZKjDwRn2+7uwRdHN8+6F+Cn8wWxCWOB9ZSE3jtb18MP8KEcG4zf6LaantxS1xfBkdB
 V/8vlSqfqOKjsIyRPjatPs5fi2Pr8JtTYudur6RQzUB4Y5lAhVY9RBJpMILjTIIHv+6uF8pk25w
 SezfyZinojftRGR88H/q4F4bjGxBv/w3kawvzM4Din2CXmODku1JJC63JXKwtkFiuZT/WIQj2Kn
 hYdgWS0B2oU5ahFn2Wz1uSCaeIHij1Mh1skZdZLRrrCvAIITNlZifzGBncplgmYSEtKsRwG28PZ
 GLKWb4ApZoLUeVmdFuHky9rmwSc36gzjTod+wsDxWQB4wrugWbrcTGdMl1g==
X-Received: by 2002:a05:7300:d210:b0:2a4:874e:70cb with SMTP id
 5a478bee46e88-2abc71f59e1mr4987808eec.26.1765275542653; 
 Tue, 09 Dec 2025 02:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsMdzDgO7XLcWCc/dU5ng8es1aGNx40R9q+JTVzbUGAoTYqa4SM2GRfY7gHOYyxD4YcXTN+Q==
X-Received: by 2002:a05:7300:d210:b0:2a4:874e:70cb with SMTP id
 5a478bee46e88-2abc71f59e1mr4987794eec.26.1765275542107; 
 Tue, 09 Dec 2025 02:19:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2aba87d7b9dsm56031890eec.4.2025.12.09.02.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 02:19:01 -0800 (PST)
Message-ID: <69e9ac12-596d-415a-a669-980ba67d22ba@redhat.com>
Date: Tue, 9 Dec 2025 11:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vEVENTQ support for accelerated SMMUv3 devices
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251204092245.5157-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 12/4/25 10:22 AM, Shameer Kolothum wrote:
> Hi,
>
> Changes from RFC v1:
> https://lore.kernel.org/qemu-devel/20251105154657.37386-1-skolothumtho@nvidia.com/
>
>  -Rebased on v6[0] of the "accelerated SMMUv3" series
>  -Addressed feedback on the RFC. Thanks!
>  -Dropped the RFC tag as the accelerated series is now more mature, and once
>   that lands, it makes sense to pick this up as well since it enables the
>   delivery of SMMUv3 events to the guest.
>
> When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
> may generate Stage-1 (S1) fault or event notifications that are intended
> for the vIOMMU instance in userspace.
>
> This series adds QEMU support for receiving such host events through the
> vEVENTQ interface and propagating them to the guest. The implementation
> uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.
>
> I have lightly this on a Grace platform using some hacks to generate fault
tested

Eric
> events. Further testing and feedback are welcome.
>
> Thanks,
> Shameer
>
> [0]https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/
>
> Nicolin Chen (2):
>   backends/iommufd: Introduce iommufd_backend_alloc_veventq
>   hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices
>
> Shameer Kolothum (2):
>   hw/arm/smmuv3: Introduce a helper function for event propagation
>   hw/arm/smmuv3-accel: Read and propagate host vIOMMU events
>
>  backends/iommufd.c       |  31 ++++++++++
>  backends/trace-events    |   1 +
>  hw/arm/smmuv3-accel.c    | 120 ++++++++++++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel.h    |   8 +++
>  hw/arm/smmuv3-internal.h |   4 ++
>  hw/arm/smmuv3.c          |  25 ++++++--
>  hw/arm/trace-events      |   2 +-
>  include/system/iommufd.h |  12 ++++
>  8 files changed, 195 insertions(+), 8 deletions(-)
>


