Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62162C5B549
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 02:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN0SD-0000p5-Aa; Wed, 04 Jun 2025 22:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uN0SC-0000oo-2A
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 22:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uN0SA-0003M2-Fc
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 22:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749090936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBC+N6dEH6cT5Fa6oWKe/1vnsNcoKLAGwdbtl/+9jMc=;
 b=KMub8ozmg01vkVlwKuyK11J+B8z9dJpIXed8N5RNNA9fcBQOEdCZYpX34fGd2BPSSi7dL+
 fRMtRgDjBHyTGRZbyKeT9GFV8tsGc8Xu65cqRbsPmHxaRLfZ5jiPo7nxIKE6PC6/IpK9Ad
 8nQW+iyYjJtVQo1zwoL6rc6nIkv1xec=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-NMo6QiM7MVK97MQsoQer_A-1; Wed, 04 Jun 2025 22:35:35 -0400
X-MC-Unique: NMo6QiM7MVK97MQsoQer_A-1
X-Mimecast-MFC-AGG-ID: NMo6QiM7MVK97MQsoQer_A_1749090934
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a58cd9b142so8081211cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749090934; x=1749695734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBC+N6dEH6cT5Fa6oWKe/1vnsNcoKLAGwdbtl/+9jMc=;
 b=KsNfXKOabQttwLQZojmZIsG0iL7x4dHjb/wD511VaW9G/dxI2qSBk2xTCUt1MrOOpd
 e0zoOsyZ0UrdZ/wteAKOIipq4h8YyxC6xF7nKc8l/Mwo4nuBbZjV3XJF12dPAemCkwDg
 JRACIprZL440AU6Id/vbgk+eWwhZZabrJyUv5E6up7PKy+rQkbX5tsHxZiVQ92XFZtOw
 CAuFODst7OsG6DFa0rfDmycyhWPYikJKXCBgclgV9qcybMcK6dJSBSZJjng4EbC54aHd
 UbpZrLbJzvWHRn5aqLA62JnUKY+vJWltu1oANQZOKkrpVynWGRaf62lh/WfgI/jQbRC5
 aVsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuaR3lwmVVHXCnRXoMWVq1/7sCrwaKJJfEmMaCCv3SsA+fs9PO9wNoBc7C4xqX8rpD63LTs8rxez1q@nongnu.org
X-Gm-Message-State: AOJu0YxmCFQpL2UYFQcmH3JYkBvXAAj0wdawTgO5h85CMxmjEqKD69DJ
 06AsfUPZxVK1TyqDrI+EbWon+F/wqkuUJJ2i7/eQIQP90e9T3T7pRZloo0F1H7KTj5Ra6N63OKx
 f+NoprQvdZS5bDKAAAx15XRZcPFFHG67+0TDn1Nuc98KHtSnLFAs558A3
X-Gm-Gg: ASbGncvjlB36QD/z800hYEe0vHAPujjmtoWDGakpHOYFe4h0t7GVLtzVEMDSeI+TxKn
 sosQEsdlRztW/fWfevNvd/2FMCw/LqLNh52WX+0vI/fyAFPUGrgxOiHh7FVR6f1oNR2u6ktky9Y
 SRhBOYQs5ROVybvS7vsPJegEDDevOedEVoOj6bYzuX7wCUjwf1kSQ8fJgydrrv6VC2U95Fcdqhk
 5vXIAALjjxyEbHfP//0pS3H8uGHGCISOynq8jbVYZpgak1seS3uSYDE2bHejHpQxkkRko4qPlf9
 HD+WPqA+Zq4b
X-Received: by 2002:a05:620a:394c:b0:7d0:9e4a:e42f with SMTP id
 af79cd13be357-7d21a8cd3b8mr786389085a.43.1749090934490; 
 Wed, 04 Jun 2025 19:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ5D0uf9Drl7s+4bPReGCHkHF7R/vqKV2s9Miffd2oV1XYUCbTMEOldGIu0K48513lcSNzUA==
X-Received: by 2002:a05:620a:394c:b0:7d0:9e4a:e42f with SMTP id
 af79cd13be357-7d21a8cd3b8mr786386885a.43.1749090934191; 
 Wed, 04 Jun 2025 19:35:34 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a1a7579sm1157074585a.106.2025.06.04.19.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 19:35:33 -0700 (PDT)
Message-ID: <ce8a82c0-e8d9-447f-89ae-45fcafdd92e5@redhat.com>
Date: Wed, 4 Jun 2025 22:34:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/arm/virt: Add support for user creatable SMMUv3
 device
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <74d9f7a2-dbf4-48d5-bda8-847d1fc73e38@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <74d9f7a2-dbf4-48d5-bda8-847d1fc73e38@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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



On 6/4/25 10:02 PM, Nathan Chen wrote:
> On 6/2/2025 8:41 AM, Shameer Kolothum wrote:
>> This patch series introduces support for a user-creatable SMMUv3 device
>> (-device arm-smmuv3) in QEMU.
> 
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> 
> I am able to create 16 SMMUv3 devices in a qemu VM with emulated devices properly associated with the guest SMMUs in guest sysfs - verified with some guest SMMUs having two or three emulated NICs assigned to them while other guest SMMUs have a minimum of one assigned.
> 
> Thanks,
> Nathan
> 
Nathan,
Great test!
Can you share the xml &/or qemu cmdline, to demonstrate this broad capability?
Also would be a good reference when (we know it isn't 'if') a new/different config
that wasn't tested shows a bug, and we'll have more info to work with.
Thanks,
  Don


