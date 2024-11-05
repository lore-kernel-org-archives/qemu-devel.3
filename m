Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EFDD1CA0C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 00:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t87Cz-0006ms-Gx; Mon, 04 Nov 2024 19:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t87Cw-0006mY-6t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1t87Cu-000679-1V
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 19:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730765642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIAS6+midGNCR8Ettd89A2LqtAZNT8rANSQ6Lqjg6/A=;
 b=Znx1cm9djrU/nvnRtGFX5oYCD1dS9jiXCf/3NAIC1EAgIme5cdNRXAfUJUDsCffh1WCoJ4
 eZg6ea/ntizw/FDdq6xqbmQKnMvri4fAoISL12PaKH1+yMXff4AzhMDf3vG0HpE3wzcm+/
 LvX3IzzLK39TljE08tQ3I62f5aSSh4g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-e02_lXT5M9Oqi4TNr4s9Ng-1; Mon, 04 Nov 2024 19:13:59 -0500
X-MC-Unique: e02_lXT5M9Oqi4TNr4s9Ng-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e3b9fc918fso5868398a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 16:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730765638; x=1731370438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIAS6+midGNCR8Ettd89A2LqtAZNT8rANSQ6Lqjg6/A=;
 b=lyrjh034NoH0lQ/NtOYfqUvqs/CaVf3q6TUitIHthoDs/O9G/gF7eRtOPPovZE+wh6
 m2VFZYRChsz7UY4dAJkVbrXNMwRpfHM1DN51UXGpfi/ux/zBq50DSl7oAVARJz0jnBBc
 MzrbsZwfrILF1ro2+6HQhV4zDYGM0Aamp4ljaBtkyoKQWvXaEY1fU3I751A+DZx/hI9S
 kSaJeNo2ihCOwMOhjNsJnJaDMvgpeg/LYbx13bEdjy7ujoM2KpNCwwRV/gxrw9CAKCzI
 9tOK2zkbZm6yCYelO6rjLRwFkbfITZbqjjrICgcD8+cgQaDMVibujh9jt79DY6j3jTSE
 HKkA==
X-Gm-Message-State: AOJu0YyEP7b0LWfUeY1oAi9OIYCCxQsnOZItTqtdFM4mL4KEyVHLCvca
 wVI9gUF617hvoHIT99aag7aeb6/u7H+D4v89rrPisUvTju+pgzeBT0KUA9JGg5+0ooaEzhxRJ1s
 IT8Ow7jCDqxp83CaCb8vVguIyHdVP3F0ejosP8UqQSu/wdhIF95BG
X-Received: by 2002:a17:90a:e01:b0:2e2:d82b:d144 with SMTP id
 98e67ed59e1d1-2e8f11ba066mr39098337a91.37.1730765638039; 
 Mon, 04 Nov 2024 16:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIusnxEvdM395g9H7nmcLUFIxlOzMn8f99/292ek+ZLoE9ckLb3ovsXRuc5AcBHHwgSDy7xw==
X-Received: by 2002:a17:90a:e01:b0:2e2:d82b:d144 with SMTP id
 98e67ed59e1d1-2e8f11ba066mr39098294a91.37.1730765637696; 
 Mon, 04 Nov 2024 16:13:57 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e92fa2606dsm10472665a91.20.2024.11.04.16.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 16:13:57 -0800 (PST)
Message-ID: <3d5d60a9-dfdc-484b-a1a2-a34bcfdbdd85@redhat.com>
Date: Tue, 5 Nov 2024 10:13:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
To: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 richard.henderson@linaro.org, jonathan.cameron@huawei.com,
 alex.bennee@linaro.org, imammedo@redhat.com, pbonzini@redhat.com,
 maz@kernel.org, will@kernel.org, oliver.upton@linux.dev,
 jean-philippe@linaro.org, lpieralisi@kernel.org, david@redhat.com,
 philmd@linaro.org, andrew.jones@linux.dev, eric.auger@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com, gustavo.romero@linaro.org
References: <20241103152455.202462-1-salil.mehta@huawei.com>
 <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/4/24 11:26 PM, Peter Maydell wrote:
> On Sun, 3 Nov 2024 at 15:25, Salil Mehta <salil.mehta@huawei.com> wrote:
>>
>> Extract common GIC and CPU interrupt wiring code to improve code
>> readability and modularity, supporting reuse in future patch sets. This
>> refactor is benign and introduces *no* functional changes.
>>
>> Note: This patch has been isolated from a larger patch set to facilitate
>> early merging and reduce the complexity of the original set, as it
>> operates independently. All original tags and author contributions are
>> retained.
> 
> I would prefer to see refactoring patches in the context of
> the series that makes them necessary. As it stands, there
> doesn't really seem to be much benefit to this change.
> 

+1. Please include those 3 (refactoring) patches into a series where
the background is given.

Thanks,
Gavin


