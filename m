Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB45C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZxM-0005DN-5m; Fri, 21 Jun 2024 04:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKZxK-0005Cb-Nh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKZxI-0007bo-Iz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718959751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76/V6swgpHnDoZ8iVwTqMIe++HZ42+WUnelUV+JjMg0=;
 b=fOxhKyQ6wfv1fxMjQh4mAxYWPWoHvjede7FR0Pf0uSy1s6ruwBNk6vabejjvx595mBMfM+
 rUdPC3dNekQFLGkSmpjX5NrzaOFgMfG3BFCr8vfnOjanKKVNjCtK3Lux3LkEAvenQacUrT
 Ck1WUsonrIYjbP/QGhupqrkPVcF37s8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Sq7CazHTNSyrZF5UjGcpXg-1; Fri, 21 Jun 2024 04:49:09 -0400
X-MC-Unique: Sq7CazHTNSyrZF5UjGcpXg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-797d167a402so188467285a.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718959749; x=1719564549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=76/V6swgpHnDoZ8iVwTqMIe++HZ42+WUnelUV+JjMg0=;
 b=Ep/VFHz2NwNFaIpu2OXsYv165zrJwu7AEgxGvhtYSiVTBaIOraVQEI0hjEPix0T5iw
 SQwKa/lcMzGu+MvLiQwZG3n0r+fFCRO62qoAydJTNWYFf13iQMcirpAUMYEqP0fQ5kfG
 QZ2lxtJeKrw9o9tqB5Kh9h8DzaeiSozLcWWaVF9oI5aHbIvmvDuicDK/qiwnMsfzxNoG
 fyXKZeE94eqRJq27ea2oEvIVrg9K7C7XZpkLjxpYBO8My9DUr+iiLC0IAwsalYzFEION
 F1n+qqcr4PgZ+aiRU6N1NH+X8oXi3a4xbI2Noco6mqY6pdcCfKHxLaGJduk3Eb7WHOl7
 1qEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsN2DFJ8LgVmlkSm7/hb9HAia4JD6JuEZ73zNnBM6eqZ/0WHkKXKWFgj9vkgP6Y1hhgUvVVvjn21Yp9TaKS8/4b/NOPaw=
X-Gm-Message-State: AOJu0YxFVKJmSbjgFBGngKM0esXo+dzELP4voJYS3rdL+T14abx81hj7
 fey+sXwhZGb+/eT7L793j1y0wtMD4OugSWoYUIOAgrtrqFrfsJjdAfNm06LYIE7WYXcfTiKfYz+
 tBNOju9Syd/6xLT0UDkfr2Ple8v6Tp5DICbXXnBCb0qJjerDgAQJW
X-Received: by 2002:a05:620a:1720:b0:795:54d5:300d with SMTP id
 af79cd13be357-79bb3e10a23mr860189185a.12.1718959749031; 
 Fri, 21 Jun 2024 01:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1qoQzlTTVug+jjRIjGV6zrZEDx4DnrHZcpLp44vNQe1VJ21rH/5uT6JOE8uh7g78AV9/5Bg==
X-Received: by 2002:a05:620a:1720:b0:795:54d5:300d with SMTP id
 af79cd13be357-79bb3e10a23mr860187785a.12.1718959748661; 
 Fri, 21 Jun 2024 01:49:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79bce8c0016sm65677385a.55.2024.06.21.01.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 01:49:08 -0700 (PDT)
Message-ID: <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
Date: Fri, 21 Jun 2024 10:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
 <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/21/24 10:17 AM, Shivaprasad G Bhat wrote:
> Hi Cédric,
> 
> On 6/20/24 6:37 PM, Cédric Le Goater wrote:
>> Shivaprasad,
>>
>> On 5/9/24 9:14 PM, Shivaprasad G Bhat wrote:
>>> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
>>> spapr container)" began to use the newly introduced VFIOSpaprContainer
>>> structure.
>>>
>>> After several refactors, today the container_of(container,
>>> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
>>> not allocated. On PPC64 systems, this dereference is leading to corruption
>>> showing up as glibc malloc assertion during guest start when using vfio.
>>>
>>> Patch adds the missing allocation while also making the structure movement
>>> to vfio common header file.
>>>
>>> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr container)"
>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>
>> Could you please give vfio-9.1 a try ? Thanks,
>>
> Yes. This is working fine for ppc64.

Could you please describe the host/guest OS, hypervisor, processor
and adapter ?

Thanks,

C.


