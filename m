Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272EDC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWVh-0003Wd-Iq; Thu, 01 Feb 2024 07:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWVf-0003WK-Jz
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWVe-0006G8-5o
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706791777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w/8fCT1fksQe2LR91l2dUGXItVn38mkcWVytu+qBlO0=;
 b=TE5pjxKcOC/0ARsW4JXmlB107k+KsphBXwxyvu8os15ZHFrqlFlbLaZ+5qTMnUxI2zxutE
 s5tlSPBRX1olilYK6xxqgPeXJe0IeK13UWIJY1w/tzpkX9SjzwA0/HsnGsCo1LfJiBnI+X
 vh9elHAMQnNIvsLesZFsg27xkbrKOAM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-4qKA77EZMnmcCinUcSb8Sg-1; Thu, 01 Feb 2024 07:49:36 -0500
X-MC-Unique: 4qKA77EZMnmcCinUcSb8Sg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c4f4411f8so15818786d6.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706791775; x=1707396575;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/8fCT1fksQe2LR91l2dUGXItVn38mkcWVytu+qBlO0=;
 b=FLG89UV9zIy1uygwWIXDyEQIie+A8Q7wfeg18kRp5JLd7aq+ZEqzZBUncSBrOO98c+
 Sge9kO1VGwZSTLlgKc0CF75x3O68EP4au9jXb1O3JXNSaOWdr1BwylpBlpWL5VBzNPA+
 S5hinSuAG5TagrTQidKNUduxv8oxOh3T9QYb6kCa2cVkbyuJc1H47K31d/V7PV+csivT
 OdqiWIgWyKxIkoTKwqixvM0cZL1VGBhiY2U+xBipL96OgGZmi0ANRJkLOFd8dcqTMm2S
 2cfGFMCNw38JK06EmZSqRHksEIIEay9HQlXcu8xrtRbLnmjkUlQlRzJmN7kjd5//b7w4
 cRHQ==
X-Gm-Message-State: AOJu0Yx6VXQ+ckh2xjFLZcYfHTjvtd7EHx7l7xENTA+kwUmpn/7agJau
 8/jxikox90xSpXxUjmWDbzmbm+LNFR8JrsxtZ4Z0gxjnntRQqoSY0jagQKEMAeB0cWgtla6SGbz
 pm204m/BZsWMcbZHr3mR9tPVsVT8wS7d2K3KwGnrxYfwQ8kE7gy3R
X-Received: by 2002:a0c:df92:0:b0:68c:8220:fa46 with SMTP id
 w18-20020a0cdf92000000b0068c8220fa46mr152324qvl.5.1706791775587; 
 Thu, 01 Feb 2024 04:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2SgvUJY+0Ov6m88ncHhL+HYcoMMZxZoVFuo50Ye4SAcQxfwtc9CahH+pcg2bYXvOhRTK7/w==
X-Received: by 2002:a0c:df92:0:b0:68c:8220:fa46 with SMTP id
 w18-20020a0cdf92000000b0068c8220fa46mr152306qvl.5.1706791775309; 
 Thu, 01 Feb 2024 04:49:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWdrgHa3xiVnkr5P7XUgve1UMCqWrCf0ivr1nFqoSY42dJk25BKgq4HHXJjWT/lk73zxKD/ir5FenoqZDjN42VTsBOhoZeK8b+LmdFKgQiR1WD8lzxZ0/C8YToMuX1kMqSCRhtmLJ48NR7/fSjkrXmC9LiQM38DrwjQS5bQf0oB2h4=
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 oq7-20020a056214460700b00684225ef3a0sm5856186qvb.93.2024.02.01.04.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 04:49:35 -0800 (PST)
Message-ID: <13ab647c-df89-49ab-8f76-8ce57d519aab@redhat.com>
Date: Thu, 1 Feb 2024 13:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Miroslav Rezanina <mrezanin@redhat.com>
References: <20240201082916.20857-1-thuth@redhat.com>
 <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 13.39, BALATON Zoltan wrote:
> On Thu, 1 Feb 2024, Thomas Huth wrote:
>> For distros like downstream RHEL, it would be helpful to allow to disable
>> the CompactFlash device. For making this possible, we need a separate
>> Kconfig switch for this device, and the code should reside in a separate
>> file.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> hw/ide/qdev-ide.h  | 41 ++++++++++++++++++++++++++++++++
>> hw/ide/cf.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>> hw/ide/qdev.c      | 51 ++--------------------------------------
>> hw/ide/Kconfig     |  4 ++++
>> hw/ide/meson.build |  1 +
>> 5 files changed, 106 insertions(+), 49 deletions(-)
>> create mode 100644 hw/ide/qdev-ide.h
>> create mode 100644 hw/ide/cf.c
>>
>> diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
>> new file mode 100644
>> index 0000000000..3dd977466c
>> --- /dev/null
>> +++ b/hw/ide/qdev-ide.h
> 
> This may be unrelated to this patch but we already have 
> include/hw/ide/internal.h which may be a place these should go in but that 
> header is in inlcude because some files outside hw/ide include it. I've 
> found three places that include ide/internal.h: hw/arm/sbsa-ref.c, 
> hw/i386/pc.c and hw/misc/macio.h. Only macio is really needing internal IDE 
> parts the other two just uses some functions so macio is probably the reason 
> this wasn't cleaned up yet. In any case, maybe this could go in 
> include/hw/ide/internal.h to avoid introducing a new header or somehow make 
> this a local header where non-public parts of hw/ide/internal.h could be 
> moved in the future. Such as rename include/hw/ide/internal.h to ide.h and 
> name this one internal.h maybe?

I don't like headers that much that just collect a lot of only slightly 
related things. That only causes problems again when you have to unentangle 
the stuff one day. So what's wrong with having a dedicated header for the 
stuff in hw/ide/qdev.c ?

  Thomas


