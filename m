Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8636BC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhd3-0008R2-35; Wed, 06 Aug 2025 13:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ujgXN-0003qD-U1
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ujgXL-0004G9-AZ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754495922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQ2l8rbNCrdGaDdUCyrQIuRiDqEktXznMl3SirioDtQ=;
 b=WnzniO3bmMEZ9tLIRNjSwwEwJkEy/ZBkyRQBIc79Od7M/EzagbUTczhkYMM00wU6a7zjdJ
 F8El86DfKBEdKuBkTB3QiN7tkWtSYf2dUU8E3531WtMJck6ONpErgSfj27E08576jDDKj+
 uV4+X0DOAliv2cQftJxIsNX/253gOeo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-GeLhlvT4Ox2KZ0C0h7ZRZQ-1; Wed, 06 Aug 2025 11:58:41 -0400
X-MC-Unique: GeLhlvT4Ox2KZ0C0h7ZRZQ-1
X-Mimecast-MFC-AGG-ID: GeLhlvT4Ox2KZ0C0h7ZRZQ_1754495920
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b065932d0bso1075981cf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495920; x=1755100720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQ2l8rbNCrdGaDdUCyrQIuRiDqEktXznMl3SirioDtQ=;
 b=iOPs+HPSuPWKnFm1htbKzLKfAjZ5lvaok3sGuD5G5tJ6bCjOQmGRDN5SsfAvi7kIgE
 jkXjVIJKTYSSo6+NMIPOx1+ZeoGuENbYBStg9nwWI02qQ83XfOvaThK7IMI4j+OeP5ut
 dXkPRGlanYhv6vTBeYyjwu/kCNs0CAmcDbYAvvK/qDeK6eM3KnGVLzK//S6w0f/pKSvV
 l3iGvt4zj5MwpczgcxL5cLsqM7NLS/MR6nFOzO64am5qw5yjchBLoJXpRIpIaEJ642w+
 aIpljbt3TEmcfA3EI2/6bOsdtjPeMxjS67eQ6mYzElLFWHIvNxsBo4EbK5eb6Ri9evcG
 BReQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpE98zJokFmiT///n/kV/RYeo4uVvaQs1Lnwfa8+d6VE9tU9B5n+b9rsGH2XroW6J1JiFR4pts9VuI@nongnu.org
X-Gm-Message-State: AOJu0YzI2umgs6DcSR3LoP0jo+SFG1c9f3oxPBxMHl+m51d5nZq0oItM
 AulpT+yyGVO+ILnXDgI+t3qd9qSO7Vr6VtiQzY4BDZ3pkV8l/Cd/+Y0K87uT4qTOPtnxTz1zu6i
 dSt65LJ8J3l69HacQJFmiffzi7bJKShmSp/WB+DqZK7AJA4RmJ0YUOEAG/mCwmtGI
X-Gm-Gg: ASbGncu7MCk+zVWjxRgGxIbqCWsXFfaKrfDpweR1ekNc5cd/74qRBlHQ/ERMGcSZ0b7
 0RNE8RNnIdn0UBugjcpo93is00hsSoPRDCtyzTMc3vB3j3CfzzWs09KSsAimZUj9Q7uHzd1YXg1
 Zf7kxXyoreFoXD141Q9f3w0cu2sZfZKrhbtdyAOfne1Ub1G2jR/Dn+zjlHK/XmjZApaDjm59/4A
 maOLzenRSYXSXMoV7PjZNRwt1dIGAbE97+elyC0cIV7oWIvV8u1sxF1VPZtceskG9Lo3SDmRvQK
 ki8zMFea+v1q53aGjDLaS2E0vrEL0mMCghnGPIFriJbn
X-Received: by 2002:a05:622a:1f97:b0:4ab:9586:bdd9 with SMTP id
 d75a77b69052e-4b0915f70efmr61351391cf.56.1754495919659; 
 Wed, 06 Aug 2025 08:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa1Ulkz2YxhR8EOuU6ZXPPtp1giJRP/e0/mJP0Qd6KUk+U0glq5PijgXEQPZ3EamRvYsIedQ==
X-Received: by 2002:a05:622a:1f97:b0:4ab:9586:bdd9 with SMTP id
 d75a77b69052e-4b0915f70efmr61350861cf.56.1754495919204; 
 Wed, 06 Aug 2025 08:58:39 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.28.57])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4af230d8a21sm49389101cf.51.2025.08.06.08.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 08:58:38 -0700 (PDT)
Message-ID: <c8721e0b-58e7-43e7-beab-410de5aa5486@redhat.com>
Date: Wed, 6 Aug 2025 17:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2 0/4] vfio: Remove 'vfio-platform'
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250731121947.1346927-1-clg@redhat.com>
 <22bb66b6-998c-4cb9-a16b-386ff88bb197@redhat.com>
 <0a634c90-847a-4b75-b36a-bca923527060@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0a634c90-847a-4b75-b36a-bca923527060@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/6/25 5:54 PM, Cédric Le Goater wrote:
> Hello Eric,
>
> On 8/6/25 14:51, Eric Auger wrote:
>> Hi Cédric,
>>
>> On 7/31/25 2:19 PM, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
>>> timeframe. QEMU 10.2 is the time for removal.
>>>
>>> The last patch moves vfio-region.h under hw/vfio since it no longer
>>> needs to be a public VFIO interface.
>> "tout ça... pour ça!" as we say in french ;-)
>
> It was not for nothing !
>
> vfio-platform explored device passthrough on DT platforms.
> It had limitations which were difficult to address without
> common FW specifications to expose devices. The result is
> neither good or bad, it had its time.
>
> However, the wrong choice would be to keep unused code in an
> upstream project. This would be a burden for the maintainer
> and the overall community.

Yes I totally agree. Especially in this situation where we cannot test
anymore.

Thanks

Eric
>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
>
> Thanks,
>
> C.
>


