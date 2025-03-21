Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1EBC35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYhZ-0005yA-Hi; Fri, 21 Mar 2025 05:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvYhS-0005lK-Ub
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvYhR-0000U8-2V
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742549395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iaTTMnIxoKsffEU7MlWTVYnGawZKOVQcTD0AvUNLHZ8=;
 b=IvE6yBOkGr6cFCQ+Z/R6vN0qWIXaTadDG93xdeio3A3ed8phTnabaK8fCkHmjkki/5cv35
 xgaoZz4nExkNP3h3i8NOMF0NJbHTzCvvjmNRDJruCV2Hx/z/f1uAkFkVVqjjdzf3MyY1o5
 TaKoB1Tf6cOEnxF3KjpAVZbZF4av52w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-VOakXsDKNLy9NA4xqxl9ZA-1; Fri, 21 Mar 2025 05:29:50 -0400
X-MC-Unique: VOakXsDKNLy9NA4xqxl9ZA-1
X-Mimecast-MFC-AGG-ID: VOakXsDKNLy9NA4xqxl9ZA_1742549389
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935e09897so11667565e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 02:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742549389; x=1743154189;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaTTMnIxoKsffEU7MlWTVYnGawZKOVQcTD0AvUNLHZ8=;
 b=G91TYmj9bIiSLxScWgPj2qMEP+ih3oGHnWPKhvRwxUyFSqGRq58vzqKMQLCleKQBLb
 8yKV0FufDYjhZHGX9DnFPuth1A6NvxTGqXDMBjn8InQvWwMVJaxKguxACxTwLxKMlqaX
 JAYSvsnAOgMjQjvwdwRG41KiCrQMdd1X5JFe1t4KvmLP0y9sWBZjKjmPhYcGBzbirc6b
 SxACNDqWoj8lhPN00dteqOWiMFxNACMYh57VeB7UCXllOQBopxCAt4lKD5zIRxhin4jc
 zgXj8GmrXXO7h86PqBk1kgQhgC/4o8rt7l3UWXPxrg5kXvjYDSl0sDgriXrd3hObaeNd
 SA1g==
X-Gm-Message-State: AOJu0Yy2/vtyTjvUPM1nFjp93BWWzVCk/Gff4mlpKCt8y2Go+/6R7AaG
 DfDIzXzOK6WE4EMRs89AraT7OV/LXnV4WHH8qpL4BZMtb6wIZ8FA/iShmJrNiHdbCfZCd3r7yVC
 Y5D5MLFRQT4kO1yRnOnW7qsnW28Dwmw51xsM4o6fr5tDf8DS31YEq
X-Gm-Gg: ASbGnctEYOXhlfwbV0WBIOmS6IPmvzFeFqh9BFytHC0xJyrFN9FTeUJGREHm7GGOUQn
 2WOdD0s012F0Gz6Os56W4dYqYqKhpQ8rXTvr+BoUh3wnXKeA57TvvuR4h0wABhI7u7LjKnz7gSn
 dR4jIadXmRuLl8vML1WkQIKPzy1ZEHmiB+KZmzc+5qCh7EAXV9uJ+TDS8cMmaRi1m28ozUNabis
 XutTl7CNBazO9KMcl56XCxuafkwa7noWLlk2+YG0iC81ilTyCnCn3xRTf9LGafuw03XQen9DV8T
 YwvNkJRBUD9tEF4uKvOK8XB1x2kSsrZnJFcjz1EP32OvDdM21cCogQ==
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43d509ec467mr24111875e9.11.1742549389196; 
 Fri, 21 Mar 2025 02:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET7IIKnDaY+sHDi5gQAcnQOXC3P/SszOnBmXml6siHqz9piJ4qlTKtM6s+mh0AKf+1e1YEWA==
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43d509ec467mr24110615e9.11.1742549387566; 
 Fri, 21 Mar 2025 02:29:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd27980sm21298715e9.21.2025.03.21.02.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 02:29:47 -0700 (PDT)
Message-ID: <a29aa643-dea6-470c-a757-a23b04a7c6b4@redhat.com>
Date: Fri, 21 Mar 2025 10:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
 <Z9vkCjASN9y0YPPK@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z9vkCjASN9y0YPPK@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On 3/20/25 10:46, John Levon wrote:
> On Tue, Mar 18, 2025 at 10:54:07AM +0100, Cédric Le Goater wrote:
> 
>> File "common.c" has been emptied of most of its definitions by the
>> previous changes and the only definitions left are related to dirty
>> tracking. Rename it to "dirty-tracking.c" and introduce its associated
>> "dirty-tracking.h" header file for the declarations.
>>
>> Cleanup a little the includes while at it.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
>> rename from hw/vfio/common.c
>> rename to hw/vfio/dirty-tracking.c
>> index ed2f2ed8839caaf40fabb0cbbcaa1df2c5b70d67..441f9d9a08c06a88dda44ef143dcee5f0a89a900 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -20,14 +20,10 @@
> 
> I think you might want to update the file comment from "generic functions used
> by VFIO devices".

Yes.

next respin will have to take a closer look at the top of the files:
comments, copyrights, includes.

Thanks,

C.

  



