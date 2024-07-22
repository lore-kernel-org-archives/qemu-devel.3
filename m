Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E641C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtRC-0001Yb-1z; Mon, 22 Jul 2024 09:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtR7-0001XE-C1
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtR4-0006E3-KR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721656241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwkAQvs4w9+D8x+XrZ/OEsVc1RQqttmeOws4RPDEAFg=;
 b=OxO7H8JI+L4S2D+A14xrcCH+gKAEinMIAo8pAe7/GNbvY341mu5icz/eEsnZSgYQTp6+0I
 XuRif0tp2aH9QOVV+0dVG8uNoa1PlS/zPzqfMFVvOWpy16qOIo4lVn1HKnWlnIuTukiszA
 FWBmpsa5QZJxykDIvUgAOy1cf6mRaK8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ewguAvVhOQeqyJd_e8ndLg-1; Mon, 22 Jul 2024 09:50:39 -0400
X-MC-Unique: ewguAvVhOQeqyJd_e8ndLg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a164026621so602117985a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 06:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721656239; x=1722261039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwkAQvs4w9+D8x+XrZ/OEsVc1RQqttmeOws4RPDEAFg=;
 b=K00PsK1Tag4aLc2B2ZY8N1jRA3NzG+oHpxdtdU/OsZ/8smAMpX53/AXO+43O2JfIk2
 iiDmD74lNgCTK2PxMTWAuSyxNpMCU4hbSfw3CzMbZNesHaZYq+eJzLju/Grf1YpriCaY
 YrbbB2WzP6rpuIzC6f7C9QLiz8Pu9mDksryZ3pjtGeJI+2PYfSUL7zS8AQomD/dMKB+4
 lYLHHh46tglke70UZIwy3OR6G3FXv+Lcg27fW8TIv9VxWc6MhONl2B3WbncH7UbysdFx
 S+XRJRQQssVN+Xa+F00A10LvHHXubVCgnWypIt7g3bUYSTf+jaAcQiUAZGJJCy02zqF3
 L2ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjiFmSzBD7k8cPirZ08TEfN0x14aTFH8OPxgwMoZGdK+YAAZEK4bfWIGzNSYNhc0grgFeyKUv85mePvenfsHiyPvdbYPU=
X-Gm-Message-State: AOJu0YzEAdviBygzH5istMi+09rTeqKpKvts1MhDdwOP/K2WhLvJZpll
 m3fk2bGyVJVU+Z1STAuvmV6lRsCo+qvrhECRVU9IAEUu4PFqMcGVV9SSqr/UuNVOHIQxNFmNrfz
 KfaTncu8m3MKCB33Thdo4zBWt0faMukurOIO+kWgSrnzDuejBNDOu
X-Received: by 2002:a05:620a:f02:b0:79f:504:3db with SMTP id
 af79cd13be357-7a1a13c5f29mr1115739685a.68.1721656239165; 
 Mon, 22 Jul 2024 06:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2CRdkiJ+SnngRn6lzhPDKpR5VzhJUghbX6wrUB6SvsdztlzJLrBNVjadJgoJMb6qfHy2zDA==
X-Received: by 2002:a05:620a:f02:b0:79f:504:3db with SMTP id
 af79cd13be357-7a1a13c5f29mr1115736685a.68.1721656238803; 
 Mon, 22 Jul 2024 06:50:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19905ecf7sm360068785a.98.2024.07.22.06.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:50:38 -0700 (PDT)
Message-ID: <2cadf05b-fad9-40e6-9e1f-0c28cae75c2f@redhat.com>
Date: Mon, 22 Jul 2024 15:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/container: Fix SIGSEV on
 vfio_container_instance_finalize()
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com
Cc: yanghliu@redhat.com
References: <20240719165011.1751831-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719165011.1751831-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/19/24 18:50, Eric Auger wrote:
> In vfio_connect_container's error path, the base container is
> removed twice form the VFIOAddressSpace QLIST: first on the
> listener_release_exit label and second, on free_container_exit
> label, through object_unref(container), which calls
> vfio_container_instance_finalize().
> 
> Let's remove the first instance.
> 
> Fixes: 938026053f4 ("vfio/container: Switch to QOM")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/vfio/container.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 425db1a14c..d8b7c533af 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -657,7 +657,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       return true;
>   listener_release_exit:
>       QLIST_REMOVE(group, container_next);
> -    QLIST_REMOVE(bcontainer, next);
>       vfio_kvm_device_del_group(group);
>       memory_listener_unregister(&bcontainer->listener);
>       if (vioc->release) {


Applied to vfio-next.

Thanks,

C.



