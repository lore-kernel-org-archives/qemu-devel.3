Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A8AC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU5U-0006CQ-7b; Mon, 27 May 2024 02:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBU56-0005Wh-7M
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBU53-0007Y5-Or
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716792216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gr1mLTPjwzgZ91iRsFhW6H5tUkk7Pr+jkh77+fxkk6Q=;
 b=KVf0VjOmLclwO44AQOk2swmcKohiog4x7U+ZtSDf19C64Z8EHb1mjoVw4RppfNs2zOhC73
 MkqqTQp+FKb0G6vm6xCsjYYDLoNd/ZLVAktlzCAFUF4iiiSVm3b073ot7qPhm41xPW4wmv
 gsL5kC2LOhR+Y2Ovc1j/z7A5wJQOYjE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-4ddlX7IROWuxitJH26IKSQ-1; Mon, 27 May 2024 02:43:35 -0400
X-MC-Unique: 4ddlX7IROWuxitJH26IKSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35507e4c41dso1057677f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 23:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716792214; x=1717397014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gr1mLTPjwzgZ91iRsFhW6H5tUkk7Pr+jkh77+fxkk6Q=;
 b=IkFY43i3M4YSTnSOKXXtt6EhixAYWy2cz9++yP2zGhAlaNY2LkfoZx6229vIs7BLBv
 b8OlWhCpMRVmPYv9JQFfbSqw6yoRQICZjjUOJAFIem/8C0L7hUnuM78tKWwaHYveqoFQ
 9faEL+rOX6zb+OaTi2/kNdDIT4t04ZCe4bwsdsK8jNZoNQBwuPP27exgrhugrKRVepHR
 qlyjjE2BO+ak2quZW+xpLLofzTuRHUdyWX0gFUo8EFygcjfqRxV7+wHj5gdoj88OFjYU
 oyaQEkk/WFLvbQK/izzURu+P+nqnLNoqNSildoYVkJHUuVj+3PwQg4qCiv9qgArJrlpI
 3e5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVygX7q5PfAAT269xGKn1bOYWhD9M3Yxi2ih3NZDpV4yfSvW22GctJQgpOYtWolE10LvkL3BS+SnfdTtQp5Zc1rmMfoU3o=
X-Gm-Message-State: AOJu0Yw6NKi9w0/UgjWJt63wVvhI+eN8u+g6pl9q90ZnBQW+xrlrGdvS
 3Rq5ziCV5XGj9D5a4JC6lxSsHU/Z9vllTAh8VQByGRdwapbIRu67FnnmRn0zdA7NWVtRAa9k1ZI
 wMbRrEkkA0pOkX+QJZF9Wub9AsD9ahnPLIfPPUjwHqdIv0s39Yo13
X-Received: by 2002:a05:6000:1942:b0:358:d9d4:1026 with SMTP id
 ffacd0b85a97d-358d9d411a5mr2134595f8f.17.1716792213960; 
 Sun, 26 May 2024 23:43:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXxuKR0SvDHY8xfZt3kH6riPfPPS1RM8fIqH/zMu+5e4lTmVILteEFvn0q0+0piG303TMglw==
X-Received: by 2002:a05:6000:1942:b0:358:d9d4:1026 with SMTP id
 ffacd0b85a97d-358d9d411a5mr2134577f8f.17.1716792213506; 
 Sun, 26 May 2024 23:43:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:151b:2482:8f7e:1f56?
 ([2a01:e0a:280:24f0:151b:2482:8f7e:1f56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0931c9sm8048430f8f.65.2024.05.26.23.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 23:43:32 -0700 (PDT)
Message-ID: <ad91302c-76f1-41ee-8ea5-3ec5c5ae96d7@redhat.com>
Date: Mon, 27 May 2024 08:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] s390x/ccw: Error reporting cleanups
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <43453697-969f-4013-b306-e4e4e1536861@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <43453697-969f-4013-b306-e4e4e1536861@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/27/24 08:23, Thomas Huth wrote:
> On 22/05/2024 19.01, Cédric Le Goater wrote:
>> Hello,
>>
>> The first patches of this series simply apply the practices described
>> in the Rules section of the qapi/error.h file for routines taking an
>> 'Error **' argument. The remaining patches are a fixup in the error
>> path of vfio_ccw_realize() and some error reporting adjustements.
>>
>> Applies on top of this vfio PR :
>>
>>    https://lore.kernel.org/qemu-devel/20240522095442.195243-1-clg@redhat.com
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (6):
>>    hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
>>    s390x/css: Make CCWDeviceClass::realize return bool
>>    hw/s390x/ccw: Remove local Error variable from s390_ccw_realize()
>>    s390x/css: Make S390CCWDeviceClass::realize return bool
>>    vfio/ccw: Use the 'Error **errp' argument of vfio_ccw_realize()
>>    vfio/{ap,ccw}: Use warn_report_err() for IRQ notifier registration
>>      errors
> 
> Series
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


Applied to vfio-next.

Thanks,

C.



