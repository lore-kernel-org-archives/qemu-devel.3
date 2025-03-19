Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A61C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxCW-00086Q-IQ; Wed, 19 Mar 2025 13:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuxC2-0007qP-C5
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuxBx-0000Cs-K4
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742405216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ICxzKREpWBbFgWJho2MPZIje9dIyhxwCwtK9G9Ofe4=;
 b=BwV2SHt+nIPvYYih1DydUREFSNutOWc6EP/kQf4H4nFLHBzcrjLkCgEqBl6YwKB81qvwRP
 pn7FPItnfogh/TnaBRFH/9PYScPj6E+Qh+lmqjI+c5X4rY6QAtZimS95CXFWI7DMvI5h+T
 29KcrEB4UgJYS5kxnQ8CeDVI1IsEPco=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-j1sovSkxMlG0gLcI8HfklA-1; Wed, 19 Mar 2025 13:26:55 -0400
X-MC-Unique: j1sovSkxMlG0gLcI8HfklA-1
X-Mimecast-MFC-AGG-ID: j1sovSkxMlG0gLcI8HfklA_1742405214
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so29867305e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405214; x=1743010014;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ICxzKREpWBbFgWJho2MPZIje9dIyhxwCwtK9G9Ofe4=;
 b=CuzRhyAoXAiVRoXl/gFWj9n519la6F5TkchU7QoelANxNKobNVhW0P0NQbGNW8oUlI
 6hzOj05aRKfGwpV2lJlXk9iDWdvJww+gQsXj9jDtkI2ljqZTNFyTN/XauyN5mXehxrI6
 la16CgJ/Al3SFm+NvhHR0YoXbxVDakyvQ3X84znSHQB9NnVm+Z1MxFX1rIIhJ/aY7v6V
 eh/IWBIst7l1raa3ySZvFwlBiIogYVeYTD1S7x8Rl2qTyh81hkv2i7wMLya5vk6rceEr
 PzcTvZZC5FD9D6PSTHNKyAwfQI/JRovQfmKEKeJ7mD0TmqWkc7MosqIfya0SAYXzRF4Z
 A+rw==
X-Gm-Message-State: AOJu0Yxzxrl85y52laK8abn32dxx35YFx81VSkofKxcmaLf6cQJU1kD4
 nQWy4EWfnYWn8w8244AB1GujUpd7L/cBVVN61YK3RNiFR79DHoMBsauUNs4ROwQDccGhU4LDtDa
 b2G7wXAbTcf+tlteNwb17DPixN1JBsSeaOGfV3K78xOfd/nsJ4hV5
X-Gm-Gg: ASbGncuTepkblb+HqlU0KFzSY4pR7iGMzo7rcUB/FLHnQmUn5fsqwXj+Io5TRQk1DtN
 +p2qMpOtVQI3orhuRUh8ENqVUfT7g80t4VxmhDQLAZoc7j//w/Y1LYogrvp+8VSilfyrEYet5nE
 jOG56hs0RhAPeAigJdEWY+jiWeOAMir6gthJHbjBMn0cbKyGNFWGePJSoVVJRP3+rrl9vZS4NTz
 RCXlnlx0lZ6+/3qbd7TXmjNF70peAopf//nG48ofFdPpxSEmeRwGnFXZsEexTCvB3h9gEko51C1
 wtO967B1s1NQSjMemwoteja7yiV5naKH4Ddvqltt8IQl1kbEEY2mcg==
X-Received: by 2002:a05:600c:3b10:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-43d4384e93fmr31985715e9.29.1742405214204; 
 Wed, 19 Mar 2025 10:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyKN304MIo8va/R4gs6NWTm35SyQIOmYuqTPhHi/zyd6lH4zF/8pX4SO6N6kMepIEmOyBWjw==
X-Received: by 2002:a05:600c:3b10:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-43d4384e93fmr31985435e9.29.1742405213781; 
 Wed, 19 Mar 2025 10:26:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4d9sm24561815e9.33.2025.03.19.10.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:26:53 -0700 (PDT)
Message-ID: <e928f9cf-785e-4fd6-af35-a8114b4b821e@redhat.com>
Date: Wed, 19 Mar 2025 18:26:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 06/32] vfio: Introduce a new header file for
 internal migration services
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-7-clg@redhat.com>
 <CAE8KmOyy7nLFQ+6Ogr6HT7qA-ThsE7dMm1-AN5L7iHN3WVnqAw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAE8KmOyy7nLFQ+6Ogr6HT7qA-ThsE7dMm1-AN5L7iHN3WVnqAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

[ .. ]

> * Change looks okay. The header name 'migration.h' is rather generic,
> vfio-migration.h could be better. Looking at - #include "migration.h"
> - it is not clear which migration.h is being included. There is also a
> migration/migration.h header. But I'll leave that to you. (just
> sharing thoughts)

you are right. I am not satisfied with the header file names.

It has been problematic and I would prefer all header files to have
a "vfio-" prefix. Sadly, the gcc command line is making it difficult,
or I misunderstood some parts.

When using :

   #include "hw/vfio/foo.h"

"hw/vfio/foo.h" could refer to either :

   ./hw/vfio/foo.h

or

   ./include/hw/vfio/foo.h

I find it confusing that we can include files from anywhere in
the directory tree :/

May be call it "vfio-migration-internal.h" ?

or use always : #include "hw/vfio/migration.h" (and remove -I .) ?

Or rename the "include/hw/vfio/vfio-migration.h" file introduced
in patch 3 for external migration services to some other name.

Proposals welcome !

Thanks,

C.



