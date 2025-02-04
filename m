Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB90C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfN4L-0006P2-8B; Tue, 04 Feb 2025 12:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfN46-0006Mn-NW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:50:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfN45-0001Fy-AM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738691424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cCAfUQtOu7IcGoh9whRLfLqU6KGUvoUvxjONbv3P3nc=;
 b=g+Kfig3KQwESAph+yHmRK86AjiURy+aOOkYFH46aFEET6QDIt1gx59yGQXa4aw+reNNWS+
 YiYC2yhHOmEprIyzP+nId9EMw+vODckMYFi34H5QMU4TGMB8k/UsJYprP4tzWejozVJRgl
 TlbMh9unZJ0ERCnUtYElqjxTSFYvO60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-sHyNgF71N5iXk87lOXL1kg-1; Tue, 04 Feb 2025 12:50:21 -0500
X-MC-Unique: sHyNgF71N5iXk87lOXL1kg-1
X-Mimecast-MFC-AGG-ID: sHyNgF71N5iXk87lOXL1kg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436379713baso30883785e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691420; x=1739296220;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cCAfUQtOu7IcGoh9whRLfLqU6KGUvoUvxjONbv3P3nc=;
 b=EQL/2p+umwFb4E+QzjcuusCJE/krwA+C4FlOJuuI4zczWyh1IbiKgHN2cvYFv7MznW
 exA+uHyLEBr96WSGk9p045nTaNiwSNI881EtM10WiEa7gElBnhCU0vnS8QOWgjujCilc
 3wXd/AV7ex2l9EZ2Amdo+CXUA9UqoTeDIMkzrIPV0Wjt3eCeXQvUsRObIW8AdyZv7iX3
 emttbgecI86Zbr2dzKj/Xd61Rs7gyd6g1Y+yrQ7aNcmtCVYfJQo3ZBtw3NexZ3H628Hu
 Z6/AIXYEEd1pudLA2oejrq7CibS7/AxEDLLIvDPurrq74PFlU1Cm8xvBzfe3dBnD7UxB
 Ct+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9HlQ6CUPQcilRG8s+in/fx1hGF4+2lJfoVSd34SGjsSRNkptxqompWfibenaufXIhgRKwhokbwhNE@nongnu.org
X-Gm-Message-State: AOJu0Yw4ca7isiTRKmUJcRQm73zO5dokCvfRKKopgjaA2lokrCG9M4mj
 Svdi/ui/vGveSEz8wzcYk4PeMeWkJF6EhqykWNWhcLP8/Ia6k0j0YsCw4LSNcAfpOjta3HEVUS+
 RIdp4fx+vfHv1cESmvAfIp1uV0w3G1/s7vLSBoQiPRlDpxd36SeEC
X-Gm-Gg: ASbGncsucWsOrMop433nKc+FSEKubt/D052zmzgrOlNAdeeMdb78PeVcXx8SSx7O5zP
 Sm6hAFZ/Wxm7T+JSXHRN1N9I8oSCBGFVT2kVSRG+np3uAOViYeu1/ZTzToObT3WwuQLzdVQiIkG
 r5tTuGGo2/zvCNwtVQwJ9MJ98/+Ouwd/43bGtw06FEKXYg0NztcLYkkzWrckSGSU6rltC1gj2i4
 aO/UMtbnU/wj4KQCTJkEUOt7XOjbhngU3oTdw6F8CiyDvis6UCcLXMGeFi6119ej6fIP+3MllL/
 5aZrY82MBV66+p/R3TbuiWhiaf5cPDAzZbBarWuFk8NjrdQz/KhDrXgkb5LDbP13NgOpEIqARiM
 FqPOA9wQuYCXyHnrOLRkKy3qOLfI=
X-Received: by 2002:a5d:47a8:0:b0:38d:b1a5:3f7d with SMTP id
 ffacd0b85a97d-38db1a54457mr897906f8f.5.1738691420556; 
 Tue, 04 Feb 2025 09:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKHaQ78txw70BlPWkqNs3FNC+578qbzMprMfPcUy14Rd4z5YUhWmjXpg8KqoyDaBgkv2j1BA==
X-Received: by 2002:a5d:47a8:0:b0:38d:b1a5:3f7d with SMTP id
 ffacd0b85a97d-38db1a54457mr897890f8f.5.1738691420179; 
 Tue, 04 Feb 2025 09:50:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:300:3ae1:c3c0:cef:8413?
 (p200300cbc70a03003ae1c3c00cef8413.dip0.t-ipconnect.de.
 [2003:cb:c70a:300:3ae1:c3c0:cef:8413])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b547csm16633215f8f.62.2025.02.04.09.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 09:50:19 -0800 (PST)
Message-ID: <7a899f00-833e-4472-abc5-b2b9173eb133@redhat.com>
Date: Tue, 4 Feb 2025 18:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] hostmem: Handle remapping of RAM
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-7-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250201095726.3768796-7-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

>       /*
> @@ -595,6 +628,7 @@ static const TypeInfo host_memory_backend_info = {
>       .instance_size = sizeof(HostMemoryBackend),
>       .instance_init = host_memory_backend_init,
>       .instance_post_init = host_memory_backend_post_init,
> +    .instance_finalize = host_memory_backend_finalize,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_USER_CREATABLE },
>           { }
> diff --git a/include/system/hostmem.h b/include/system/hostmem.h
> index 5c21ca55c0..170849e8a4 100644
> --- a/include/system/hostmem.h
> +++ b/include/system/hostmem.h
> @@ -83,6 +83,7 @@ struct HostMemoryBackend {
>       HostMemPolicy policy;
>   
>       MemoryRegion mr;
> +    RAMBlockNotifier ram_notifier;
>   };

Thinking about Peters comment, it would be a nice improvement to have a 
single global memory-backend notifier that looks up the fitting memory 
backend, instead of having one per memory backend.

A per-ramblock notifier might also be possible, but that's a bit 
harder/ackward to configure: e.g., the resize callback is passed to 
memory_region_init_resizeable_ram() right now.

-- 
Cheers,

David / dhildenb


