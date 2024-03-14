Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA86C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 08:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkgM3-0005JP-8L; Thu, 14 Mar 2024 04:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkgLu-0005IM-DJ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rkgLo-0004rm-Qo
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710404527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MiXOVN+cjJ/Gf7ZXssMABZEA5Q7t06q2gSo+QMAIK0=;
 b=L0lxdFG97pf29QFSXMmJ0y0lJJ1S67WFaB4tnctUd4Gn49Vx3t63VNmUNeSTHeZ9bs99jl
 rI/Z2jQU3XuvTUR/zkP5Uj1QDN+0BIrblKNtgEFqn5Xmb8Se2y05N9iu7ECjn3AwQI/trL
 uZzp2DPcumHU4Z58W33kqUyvq0PDPtQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-qbfdjT-tMjWt1CWVFudSgw-1; Thu, 14 Mar 2024 04:22:03 -0400
X-MC-Unique: qbfdjT-tMjWt1CWVFudSgw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4131c96569dso3270685e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 01:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710404523; x=1711009323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1MiXOVN+cjJ/Gf7ZXssMABZEA5Q7t06q2gSo+QMAIK0=;
 b=Tj+VaVaF0wNVHR3bKI/jDLg6fiTEsF4iXyOUyYXGlPa3O/eNB/QomL9gAtKhvgi8db
 0rHw2TgVWEizpF12Eibj4Xdpczp4h2yyHnVs6jqNPezrG/eFuBFDW6byOMZqiT3WoCTn
 uEknhlSMv+Iv+zTdlVR7JrsdgKwxhsx7ChZhNXm50Reuy73UItPf37biSkSwQJoQkZX/
 l21sedTJrzRpT6+whYvpm6YtF5EJMjW92YNxgGcw2slQSbapcTjOAPyiS6JUtDH7Dbb6
 ydZvr5m/PgamooDIsVhBvdx+t9vXUA1/ch5LMse0SLRJ3DJgCWpOdq1Hm8xjrZBNkuui
 zhow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjnNveMG7+SEai0Dp90ZcaS5l03kZSvx2nhIdCGIialIpn/yyUaIRKxtO/O6yRD9TNLcLuLSdl9jkbXdiy3He6mIz1gg=
X-Gm-Message-State: AOJu0YwCiHgBqZ5Hvf0+L9CuLiW5qdNmADxhd/bfSfuxVi+eKcwiVf+M
 chIsK5M5RtK+T4w8tmASKocOIaFkP4a+Itz7b/rAXrbveslTzhillG9x9Z1pdKTtWLeOQsKQXYX
 AAqvzkJ8FT9w5a/3linqSwM9BFJ22LSn+cr94DasJgH9m3AtltY9e
X-Received: by 2002:a05:600c:1f94:b0:413:f296:980e with SMTP id
 je20-20020a05600c1f9400b00413f296980emr699324wmb.31.1710404522897; 
 Thu, 14 Mar 2024 01:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGstUBYrYo9kNmSADagwXQg94vY0J17v7po6oTVzOlFXLcRK4ZmPyPt2jlwAA5NI/o+lxV3Gw==
X-Received: by 2002:a05:600c:1f94:b0:413:f296:980e with SMTP id
 je20-20020a05600c1f9400b00413f296980emr699312wmb.31.1710404522620; 
 Thu, 14 Mar 2024 01:22:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 he13-20020a05600c540d00b00413f7a2b33esm214027wmb.1.2024.03.14.01.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 01:22:02 -0700 (PDT)
Message-ID: <c3eb60f5-0c85-41cf-84a8-a19eaf017b8c@redhat.com>
Date: Thu, 14 Mar 2024 09:22:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Fix memory leak
Content-Language: en-US, fr
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20240313210628.786224-1-clg@redhat.com>
 <SJ0PR11MB6744F04B74DE66C9A4A3B46692292@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744F04B74DE66C9A4A3B46692292@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/14/24 04:31, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, March 14, 2024 5:06 AM
>> To: qemu-devel@nongnu.org
>> Cc: Alex Williamson <alex.williamson@redhat.com>; Cédric Le Goater
>> <clg@redhat.com>; Eric Auger <eric.auger@redhat.com>; Liu, Yi L
>> <yi.l.liu@intel.com>; Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Subject: [PATCH] vfio/iommufd: Fix memory leak
>>
>> Make sure variable contents is freed if scanf fails.
>>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Yi Liu <yi.l.liu@intel.com>
>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Fixes: CID 1540007
>> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Unrelated to this patch, I see there are four g_free calls, not clear if it's deserved
> to cleanup with g_autofree.

Ah yes. This is much better indeed.


Thanks,

C.




