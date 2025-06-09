Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4081FC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfSe-0002M7-J7; Mon, 09 Jun 2025 12:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOfRs-0001Y8-CQ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOfRp-0001Xr-1k
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749486845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TyzyXP1Jyl9iO19x+rAhTwzE0VDj1TzyHo5k0t6hCJE=;
 b=ObXBjPfA5wjripZAMaQyTjsB5BomYJ2Nujvmg4P3RVCw4PGh1ORnw2gPIE+TqxBMyvS9sO
 jqRoYw6kafd4G6k8s7P0X17mlW0Rg6ic7ze7oc5BMLLWXgfNPo4YxvXFBB0ifJG+SF2sRw
 Ii2tM4EXgd6tLxN5qxNPBKnMejoVXAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-GUTqaxAjPqK54sFUHMnwzQ-1; Mon, 09 Jun 2025 12:34:03 -0400
X-MC-Unique: GUTqaxAjPqK54sFUHMnwzQ-1
X-Mimecast-MFC-AGG-ID: GUTqaxAjPqK54sFUHMnwzQ_1749486842
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453080e4741so13128135e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749486842; x=1750091642;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyzyXP1Jyl9iO19x+rAhTwzE0VDj1TzyHo5k0t6hCJE=;
 b=h8xSIWlmiPlWkV4yDQl3b0SOFfIhuzXSsOY2ZA8YotCE9JsD8XbcUHEk6CRHqwSJJ2
 sjo2rhj84tlTAmC66a2ivSyZyALhhHqzQNUowPoh5Fd/+ksA8RLqujWqDJU7PFye5GT/
 faZsumulWITunTHO0UrCHb9niPd6MIalvx2HBwbgDpohxPemBd79HvK2qerC+t8G4t9p
 dYrGw68hpYV/OsoHvza3Qd2tvbta1UGY73GtkjbH9PQ3aOAIrotwnu4/ZZUG6y9yVIHg
 WU9d84pPy9puqI81BBKtcaywoV+mr+5d08pTkZQ2c9X8ezfeqjsdUydpeMnEXbkJQS0f
 jfRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW357uEjeLJhSteNvXSiGAjXapwv6fBhyoRvzSkWNhMCxPzx287+ANyYIVZ9997ODP7mmCMYcAREyuS@nongnu.org
X-Gm-Message-State: AOJu0YwBq/4KhHmtSurAbapCHf0187Hj2lyOP8HbdmhU67P0x2QnTlrv
 a8mwaHlKUWSZeRKodGOIqzEQG7GM+HsnA8zInusc4ImCDvbHVvHC7NA326xlaVM437xvIljhA63
 HZn1kJq5a/OJNcUM393Qfbq9Yc24JPXQ/uiWMGXpxolcfgJtpRYpnMVpx
X-Gm-Gg: ASbGnctBV9FcPktpeTVf4QGPM6ZC8+8H2fHlBMMW2hDb73xi1Da83sh/lzYl9gILXXY
 /PnOtt2oXAv6QZ1VBWpwNttVFVNbDN+eR1S1v+0qebzFRkdt/BCyqwzGnI91AaX8bC0enFJ730h
 QpKiiM63651mKmlfXbfjtzBDcaQa86SIo63YrtbRBDGkLXfU5YL49TKIwqk6Ja5178InHwTh2na
 ReyYsE4lt1vi9sEywAFgXhaawVs5VuEMWhyR3cTQ4V/dx1SgmEBW/l8ojBDofUS437UlnDdE6HE
 txjp2Ig8cVSvpFFxDN1ZZplXQLVNH2EbvCLZbXKGg6wbLuvUuWkc4lwkuxgW
X-Received: by 2002:a05:6000:2503:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3a5319b17c0mr11985019f8f.5.1749486841455; 
 Mon, 09 Jun 2025 09:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpiLvMFS5AXQwp5AJh9bxc0jwh9AcpOOaCsUZhpXwdDWs41Up1sjNyHVKXRUNSVxEMlT4CnQ==
X-Received: by 2002:a05:6000:2503:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3a5319b17c0mr11984986f8f.5.1749486841011; 
 Mon, 09 Jun 2025 09:34:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229df09sm9941204f8f.6.2025.06.09.09.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 09:34:00 -0700 (PDT)
Message-ID: <433391e7-47d7-422d-ad24-b5a1ceb354b5@redhat.com>
Date: Mon, 9 Jun 2025 18:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Fix vfio_listener_commit()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, chao.p.peng@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250609115433.401775-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250609115433.401775-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/9/25 13:54, Zhenzhong Duan wrote:
> It's wrong to call into listener_begin callback in vfio_listener_commit().
> Currently this impacts vfio-user.
> 
> Fixes: d9b7d8b6993b ("vfio/container: pass listener_begin/commit callbacks")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/listener.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 203ed0314e..735b5f21b7 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -437,7 +437,7 @@ static void vfio_listener_commit(MemoryListener *listener)
>                                                    listener);
>       void (*listener_commit)(VFIOContainerBase *bcontainer);
>   
> -    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
> +    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_commit;
>   
>       if (listener_commit) {
>           listener_commit(bcontainer);


Applied to vfio-next.

Thanks,

C.



