Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treVZ-00059H-4h; Mon, 10 Mar 2025 10:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1treVQ-000584-Og
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1treVP-00042N-1G
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741618402;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxz/OaJuhC6GhUGumNx/uHsZxcbpDpKiH1dHsNDzeX0=;
 b=RHT81fQscEAQnVMVILkgFZAW+ieqtroxzov1gS40gZAdlbhfNd2FOJvL1+yfvnaMBHdPAH
 ZLAfUDTx9jXk/mOPnR4Nk7nVaUEppKj5vFy0Xr+KpSkxhhUkRBQqqQ+5BGNtbTxh8xdA2o
 N1OCPSdtP+562RxD4p9NXlQAjvlNaEY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-GcBsjBacPMe33N5D9j_ovg-1; Mon, 10 Mar 2025 10:53:19 -0400
X-MC-Unique: GcBsjBacPMe33N5D9j_ovg-1
X-Mimecast-MFC-AGG-ID: GcBsjBacPMe33N5D9j_ovg_1741618398
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so6171975e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 07:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741618398; x=1742223198;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxz/OaJuhC6GhUGumNx/uHsZxcbpDpKiH1dHsNDzeX0=;
 b=G4ZCEydapdeoo0gELPjfDdpDoaUCrs9Z7R6eSrV5kQQGPm1mBaTRm8tuY4Emehl5D1
 TiKmtdJaYGBiwH3NgZRv5tPN1Q67kMFuUCoDT9CBa/OEXDvlwWjenHkzLlILxGL12HUV
 xbS6afeNCPZVUxXSBdcD958nktlsj6D2sV0t7Q+t873ZK049KZF+jU4RDfygFNOJksjr
 EuksQEqUSoKgl3QyV9DL6eCO1j7Fa/f1nVUx884zi9o7cqHDmvyAHffHHBk3vedeMFm0
 Mz+2ixoQsYxVdNHK9vvcgZ6EF5DfciDiKG+sXCMMCSU6eKOMmcBdadxN7A9XZZKJK7B1
 0oQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmRlTZ5tDpWNxxKwaPsbbM21TaAJ28CgHrf9HlYMEizyRn6mS3BujnaMfsPhEq2bVvMqyfDGBGTIRR@nongnu.org
X-Gm-Message-State: AOJu0YyM8KffWBTG5KKoc44CyZyeY2f9tkc6ieYuthF05PJRLYwgwdm/
 RyvJlpPxNgcYdamaA8eo32B33xAtwnnMaarFuzFmx5U52Hzm5kiV2ZkgPiFtCad4q5dtDO0nqfk
 PxeHGE/jH4kswfBBDa+qKH8KDmt0AI5kpC6qHcnYCsYW0TfGh+5fd
X-Gm-Gg: ASbGncsk1JHegTPpEzB99B/T6nZJJ+gOrzBCtdObLj78TUYsY4F26jhA4nZ0kcw76m4
 ANAKMVNdNpjv569J7myEAZzXjUWVknqI+rELGnLgjhHijmFs05M+MhwIzbdqyG9V6DOmvYMD+Fx
 NHhSyCeVZiLsNqPQjBQFGqxRkd4B+R8tTAfDqn2Qq63VTiz3AE95C45RKZZ3y2+73KnqOUVx0sh
 2CKJiR4C/GHpON0z8Ht0ZmD/VDN5d/8fALh/WxGlpSYQIJh8Vyej++5zce3lSzmTLtdaRRtNtuA
 Cs9D8MV8mM3LcKz+xiH7u9ZUXzRaPeYSp4Vu5tNdOqwlQUgze+sHj8PBiHzxGCA=
X-Received: by 2002:a05:600c:4fc8:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ce9f7da7emr61674145e9.13.1741618398440; 
 Mon, 10 Mar 2025 07:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKJv0iWINUjecdWh5HxYRHgHCN410pWn9r9n4RosRzrFlf5wSLtClZ898kvNWrTYk8Bi42sA==
X-Received: by 2002:a05:600c:4fc8:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ce9f7da7emr61673825e9.13.1741618398095; 
 Mon, 10 Mar 2025 07:53:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfad9b823sm27522235e9.5.2025.03.10.07.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 07:53:16 -0700 (PDT)
Message-ID: <e90443d8-11e9-400e-9421-7cde30ebaf47@redhat.com>
Date: Mon, 10 Mar 2025 15:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] hw/vfio/pci: Convert CONFIG_KVM check to runtime
 one
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-10-philmd@linaro.org>
 <28c102c1-d157-4d22-a351-9fcc8f4260fd@redhat.com>
 <2d44848e-01c1-25c5-dfcb-99f5112fcbd7@eik.bme.hu>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2d44848e-01c1-25c5-dfcb-99f5112fcbd7@eik.bme.hu>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,


On 3/10/25 1:54 PM, BALATON Zoltan wrote:
> On Mon, 10 Mar 2025, Eric Auger wrote:
>> Hi Philippe,
>>
>> On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
>>> Use the runtime kvm_enabled() helper to check whether
>>> KVM is available or not.
>>
>> Miss the "why" of this patch.
>>
>> By the way I fail to remember/see where kvm_allowed is set.
>
> It's in include/system/kvm.h

There you can only find the kvm_enabled() macro definition.

I was eventually able to locate it:
accel/accel-system.c:    *(acc->allowed) = true;
in accel_init_machine()


>
>> I am also confused because we still have some code, like in
>> vfio/common.c which does both checks:
>> #ifdef CONFIG_KVM
>>         if (kvm_enabled()) {
>>             max_memslots = kvm_get_max_memslots();
>>         }
>> #endif
>
> I think this is because if KVM is not available the if cannot be true
> so it can be left out altogether. This may make sense on platforms
> like Windows and macOS where QEMU is compiled without KVM so basically
> everywhere except Linux.
But in practice we have a stub for kvm_get_max_memslots in
accel/stubs/kvm-stub.c.

Eric
>
> Regards,
> BALATON Zoltan


