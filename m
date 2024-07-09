Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B692C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4DE-0000RW-Tx; Tue, 09 Jul 2024 02:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4D0-00088W-Ej
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4Cy-0008QB-Ma
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720506011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HP+lJugMAryNjMZXSUCR6fafZigO0nNDLPdWBAB6oU=;
 b=fQnYOF3FoObKxD+dE6JPndEWhXCZfQORSP51iHLzG4/DJsG1W+FS2c1/aJmURUe9SH35VB
 Xq6mudtzh28ZwT0MJt3zPJ1c1CQVFBWNQPjAwuOkfBxo5xWDTO/aUJk5x6gC3VNkW+YuGh
 RstTdybcX9yrRom9cn0+OPUDrJXIRr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-d7ectimGMEePHoFrsI5cvQ-1; Tue, 09 Jul 2024 02:20:07 -0400
X-MC-Unique: d7ectimGMEePHoFrsI5cvQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42674318a4eso3059765e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 23:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720506006; x=1721110806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5HP+lJugMAryNjMZXSUCR6fafZigO0nNDLPdWBAB6oU=;
 b=G9DGDueNZhe5JAlBgPIWXfB7uhx5nC1AHBg+iFHU6gR9KC4khLUaoPUSrQL6Tt5+Vm
 HQkFxc/THtbuXxUxvhJ1iZB+RTHqefxb+9hFBN85XxsTx80k/UsthzKuN6/eyMPw+7EB
 FhzNfTPvo0PxQYaebVwfvSbNnyWouetFYLrEckTqZ4rBi5SFIjQRe29XRF6nISuarwaN
 qrofhArtenkLNpu30zWBWilG1WccXr3LrkySGIFmIIzKSF5LKqTQuIP7c3DPzGT9eynL
 W7Ea1qmSa7s/gPqkiVa8YeqiYS+xkTyK7pShNaKe4VoH5FX2NkD/7X9sUPgXOtW7GsX4
 m7OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhg0JcCVuDrxXlPUucSByxso35ZIooZzsBhK2Wi0rWqdfkV8vNmenB305p8jxhVSBjwM4eY3gIpajgEjdj5TuQysWDIco=
X-Gm-Message-State: AOJu0YzZPJBdgJZFt/b0vYO5f3N4uYNpBC8qpev6WSUo6F/kn8HzRzWj
 pTFLTkjjHnQgPKmd8x+G+HJaBOQlsjruB7mtPRAWHj0T6sikIm5ivvEQpNP8ooT6WL464gzQhsn
 76t8qGVGT/38rK9+x+idwUGEEXxcZ6pWf3gntjOJLPBX2rxDCxY++
X-Received: by 2002:a05:600c:41c4:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-426708f1fabmr12523145e9.35.1720506006530; 
 Mon, 08 Jul 2024 23:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQQU20NLDE5Ebkd7Q62cnIibq9Fsv72Z/pTmgfcUXBjllHzBPGWyT7xg0vHHHGQut2w5qSVw==
X-Received: by 2002:a05:600c:41c4:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-426708f1fabmr12522995e9.35.1720506006231; 
 Mon, 08 Jul 2024 23:20:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca4b7sm190982165e9.37.2024.07.08.23.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 23:20:05 -0700 (PDT)
Message-ID: <8bf7de43-1e1c-4c42-8a1d-8b2e920b8afa@redhat.com>
Date: Tue, 9 Jul 2024 08:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-4-joao.m.martins@oracle.com>
 <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
 <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/8/24 5:32 PM, Joao Martins wrote:
> On 08/07/2024 16:28, Cédric Le Goater wrote:
>> Hello Joao,
>>
>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>> In preparation to implement auto domains have the attach function
>>> return the errno it got during domain attach instead of a bool.
>>>
>>> -EINVAL is tracked to track domain incompatibilities, and decide whether
>>> to create a new IOMMU domain.
>>
>> Please leave the return value as a bool unless there is a very
>> good reason not to.
>>
> 
> Error* doesn't store the errno, and thus I can't actually test the number of
> errno to know when to bail to the next hwpt. Maybe the commit message wasn't
> clear enough there. But not sure if we have an alternative here? Or maybe Error
> does store errno, and I totally missed it.

OK. Let's do the 'bool' -> 'int' change for iommufd_cdev_attach_ioas_hwpt().
I see how it is used later on in the series.


Thanks,

C.




