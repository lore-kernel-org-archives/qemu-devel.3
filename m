Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E492C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYbV-0003rA-Ef; Tue, 17 Jun 2025 11:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYKo-0003yF-3K
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRWKt-0008Sh-L3
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750166803;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN5hHjMIPHO/GMteEkHH8lxx5y/cl+D15tG5+ZrsW+k=;
 b=Zq3ASuKmQU4HSu2L9X052Ys3T/iZfQrsqJHylbGExUB+0ddnlLB4/5Sziq3uFv8FAEgYHV
 HYJr06+SyPVPbYVSqaSKsSujeVrNiFoXpdGqmmtq00Hd2pU3gBxaoVmkp3fGeUBP+bevoQ
 EMX/ZEsXoLnZfIUPwTmW0Wr+R+5m5Aw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-p0PEONmJMhWbHWj6cGV-kA-1; Tue, 17 Jun 2025 09:26:41 -0400
X-MC-Unique: p0PEONmJMhWbHWj6cGV-kA-1
X-Mimecast-MFC-AGG-ID: p0PEONmJMhWbHWj6cGV-kA_1750166800
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so445967f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 06:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750166799; x=1750771599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CN5hHjMIPHO/GMteEkHH8lxx5y/cl+D15tG5+ZrsW+k=;
 b=ICjJ7sJ69NMEbWBtgfEe1Rq929+rv8IOFyZLn3RktNAHD42oxVBnQoJ2QWpU/zHKN8
 Dkt+x73s7S+FZzS1iJIRsxe58uKaJq3dBfX2qyqj+ngcmHdAR4qEWPOZdrRf2ja3Pazl
 0s+2R23D6e9Ao9HVhPBqS8GyP771qKkQfAtRDdIUNxokKKz8xrul0JdDJIKjOHebR93Z
 nmu/NRvMTxFNClO2QEHzTR6O6s4cTLt5JdJ9C7m500UtHY5rEVMO73ku6q+4BAebr02a
 AS8MhWoLHq8PhP6sTF5aXOV6fX/IOVPT9WjeGv279H51ggOo+CJSRZPqtOlp0iTJ5BE2
 KfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHHZOKp8dbqLSl1kIO7NpsV0sL6OWus+aWxr/ttdVT175cgTIEGZ9awGx4ac5Ltso5cxV7oiiLhta@nongnu.org
X-Gm-Message-State: AOJu0YwO6bv6SrrxZoRyKAKrOieAWG32fSc2hPbpwj9AM0A/xdci6P0D
 K1bBvuUdQFNozs6YY2nnJkY2s0X2CnqItjC15KrFse8ItnblG7H/w4Locq493zW8BQZZ7EUcriw
 oYZRj2AN3D2Qtm5fGsgdrVbM3Ed30vC3Q0YKlQ9rNSOnviOQp02ZFr87TD5knMwiF
X-Gm-Gg: ASbGncsdKUHjNAd5LE9watNd+Nb3ty4VTXzjKZLfJZH61YufwFBCxWP9RwhOAAevh1R
 ZS/dMKNmyJgdATqBrx6gC6l90OI/dYcoFWUFFzYZhQvWI4oH3ZzmXsPvHw0veQPJ5U0YKCElJBP
 FX2wO2A4Wjfy5Lf6QwUOCcpzoWu3OZXLvYzGnEmo0Cd1+5+Nq/21Aod6boRNhGSYcfV7mO3KkvW
 NcPC93XLcvShS7WdPlVIX+eLQSttFnMihIIQo+J1TtQctQXP2Hz3LieW12bUnS4vxX7VKBH5S39
 14t6rWsOS2cJ3W8eRi1Ib0jJWP3vfKY0VWiG5ipprv1r8sLv90GbwmnMqonGIlVFCmBSew==
X-Received: by 2002:a5d:64cc:0:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3a56d7cd56bmr12345016f8f.8.1750166799283; 
 Tue, 17 Jun 2025 06:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa31fOt3M0d6C7ClYd1TOlgYkmTcpt25oTo6RJDjebAolkbG7VQ2/u00E5i8kWG07dzqN0dQ==
X-Received: by 2002:a5d:64cc:0:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3a56d7cd56bmr12344992f8f.8.1750166798808; 
 Tue, 17 Jun 2025 06:26:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b62ba7sm14314490f8f.91.2025.06.17.06.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 06:26:38 -0700 (PDT)
Message-ID: <cd38280c-6f5e-4c58-b40c-3391d121e557@redhat.com>
Date: Tue, 17 Jun 2025 15:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v4 0/8] hw/arm: GIC 'its=off' ACPI table fixes
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <5b0f2250-e521-4172-870c-0384c5ef2382@redhat.com>
 <36ac7f90-d946-439f-ab20-123f542291b6@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <36ac7f90-d946-439f-ab20-123f542291b6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Gustavo,

On 6/17/25 3:01 PM, Gustavo Romero wrote:
> Hi Eric,
>
> Thanks a lot for doing a first pass on this series!
>
> On 6/17/25 06:35, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>> Since v2:
>>> - Fixed no_tcg_its inverted logic (rth)
>>>
>>> Since v3:
>>> - Fixed remappings in the IORT table when ITS is no present
>>> - Rebased on master and resoled conflics, like no more "no_its"
>>>    flag in VirtMachineClass
>>> - Dropped patch 1/9 because we actually want the instance flags,
>>>    not only the class flags, and the instance flags are the ones
>>>    to be used often when deciding about the presence/absence of a
>>>    machine feature, instead of the negated class flags ("no_*")
>>> - Adapted the other patches that depended on 1/9
>>> - Dropped patch 4/9 in favor of using the instance flag for
>>>    checking if ITS is on or off
>>> - Simplified VM options for the new "its=off" test
>>>
>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
>>> v2:
>>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html
>>> (Patches 6/14 -> 14/14 in the series)
>>> v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
>>>
>>> Fix ACPI tables for '-M its=off' CLI option and resolve the issue:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/issues/2886
>>
>> One first comment is that this series will collide with Shameer's SMMU
>> multi instance series which has been lunder review for quite some time
>> (adding him in TO):
>>
>> I think it may be more future proof if you could rebase on it - I know
>> it is a pain ;-( -. Or if sbdy objects for Shameer's series please raise
>> your voice now.
>>
>> [PATCH v4 0/7] hw/arm/virt: Add support for user creatable SMMUv3
>> device
>> <https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/#r>
>>
>> https://lore.kernel.org/all/20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com/
>>
>
> ayayay, life is never that easy! :)
>
> Thanks for point that out. Sure, I can rebase it on Shameer's series,
> but also
> I'd like to have this ITS fix for 10.1, so I think it's a matter of
> understanding
> if Shameer's series will make the 10.1 release (thanks for asking the
> reviewers if they
> have any current objection so we have an idea if it's close to get
> accepted
> or not)?
Peter was the most annoyed by the usage of -device arm-smmuv3 option
line. We'd better ask him.

On my end I don't see how we can achieve this more elegantly.
>
> Meanwhile, I'm pretty keen on if I'm correctly generating the IORT
> table pruned from ITS
> (patch 7/8 in this series), like, are the remappings for the RC and
> SMMU nodes correct? That
> would make me more comfortable to start working on a rebase.
sure looking at it...

Eric
>
>
>> Also I understood Shameer intended to write some new bios-tables-test.
>
> I see.
>
>
> Cheers,
> Gustavo
>


