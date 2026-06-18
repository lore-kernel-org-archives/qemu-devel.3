Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C842DCD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa8GT-0002Z5-P9; Thu, 18 Jun 2026 04:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wa8GS-0002Yx-KB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wa8GR-0005ND-6b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781771898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KwHyiyBt0SHfx7Bm/NO2ouQKWdz7vxLroWR8DpDWZyY=;
 b=W40B/iDUAKdV7Cu+q+QW9eb5rjKg/MPTqzPD9/eCGcvcWOyrXqxqGBw/Tk5479LqFYeByR
 KeL/U3hhn9+7iAxR1rYOHNwXP0c8bVr4PQPgBsbFaN4jRm2zjBQGGAPeCjlxunK2kSGj08
 fDCU8jk0QpcNI3VbJqFzV+2nYCEARe0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-yAc17wauPQaj4IqruMnECA-1; Thu, 18 Jun 2026 04:38:15 -0400
X-MC-Unique: yAc17wauPQaj4IqruMnECA-1
X-Mimecast-MFC-AGG-ID: yAc17wauPQaj4IqruMnECA_1781771894
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so3996005e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781771894; x=1782376694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KwHyiyBt0SHfx7Bm/NO2ouQKWdz7vxLroWR8DpDWZyY=;
 b=dnoPd6KY92xgMNuwU3AmmLg5+slPXryCwyD1VshBzTu5S28bXITQ62dwadK7UcOOmy
 7pC5uvl2t+mn3QcItykwOAz+W3+xhrOyO409zFHyVKUS1CvelYK3hVqaUokdJQI+/Cyk
 EjachBf7gC7a0p5tcfoHenld0pOtY0i6q0hWHn5Qp5IxstUavZ4yCL19NQ3dE2EEGWWY
 1e7+Bg2+esyfvPhQGCh1NEtGktd+DviRvcRkPQVGOJMdlnuORrdTDXoNmY+R95YMt7Jj
 nH9derjOfy02I0mLGDF5ik2w/wwvAD0difCxKIM1NF/yQMiLcw7WHp9mHeVoPhUzWhWk
 AmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781771894; x=1782376694;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwHyiyBt0SHfx7Bm/NO2ouQKWdz7vxLroWR8DpDWZyY=;
 b=TdhcmwE5V7C0d4JoRiVKtqEV1DTet/PDjI91BAGZBQ/9kgGQXWdxKaqRLvhvfD0vym
 vA1Bofv/k2WxbUrVbMYypnp9y15BMgRvNniRygg/taRmjl/U+wpZ9xyX4B1MBGL7IrFb
 JsOEBudVzOxUzSvWAeWlhhuIfCg1+Vz4ih7yWX0STHY+MOpwBeIHRkzM+PMCZfB3Y9zg
 j/x/mnuOvBwf69oNx25MbNhi2mHI5/ukQiRP0B7K7+iESbB34LnCsABP8dIvxBcBIoup
 EywYBg87XsrFSdkBAyywvGg0SD4WCr/aUzsX3TL0wW76atcjIDLfIt53ewLRzsrrfwe3
 Y8mg==
X-Gm-Message-State: AOJu0Ywx/D8x2Yvutm25qG4j7uewTWeCnxsEQQJvDZY39EvMZJKNrqdQ
 91G8QqNx9JL87r96qC7wQ27+3bo+a2d90mhuxkemzlrFyOjeDSZGXlKGKnQVsJ5ngZpEGO8pZ2h
 aBycwE7aUdWjuhxbKGgOYK45aq/2+zRHYvH44T8gOnkpW7Mie32G0TxgM
X-Gm-Gg: AfdE7cn+En/+QyRdsX87cRzk4kfkxA0hZc4aoMS/8GRN5v1S64RVUOc6t1OBL4gfEJL
 xEuKgV8J47mrQ9LZNxjZSOEbM4IQDcw0BCrZ/0ToHE/6VxAYfVt16uagxZZ9ixC+6TDaniINSQ7
 g1DUS+zQKhCVD+4f6W6S+fFOGi6zorU1rznTwT3mft2dZEpO1QouB52IR/ji8x0ohqNpjAJD5nA
 dXPWzR4apk1XSfLJaz5Sca49r9JSqzZoA+4gLzNzQXLm4T9osQGDuS7ACJXHrNQSY3JlT2gpHpr
 KQNjbSuDyf1xxLUEhmh9xlBmRLeu0hpQcMeVPlfnxydhD8ATu4WOoQ7vN0Q28MpPfOZdXd1tq2V
 eVlehujMulVlhWmglnBph4bEV554WlVRBruzifF+i4G9FnRklwQ==
X-Received: by 2002:a05:600c:4e54:b0:490:d32b:39d6 with SMTP id
 5b1f17b1804b1-4923412f17amr117379835e9.19.1781771894069; 
 Thu, 18 Jun 2026 01:38:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4e54:b0:490:d32b:39d6 with SMTP id
 5b1f17b1804b1-4923412f17amr117379205e9.19.1781771893491; 
 Thu, 18 Jun 2026 01:38:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d585esm33693675e9.2.2026.06.18.01.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 01:38:12 -0700 (PDT)
Message-ID: <61fefad6-af44-42db-8913-14bd274b4833@redhat.com>
Date: Thu, 18 Jun 2026 10:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com> <aiww8tN6dRLA3t_R@x1.local>
 <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com> <ai__gjsVcZs_ecLc@x1.local>
 <9605d542-f797-4ac4-bb62-966a77ffd361@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9605d542-f797-4ac4-bb62-966a77ffd361@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>> index 4d8b15d99e..8219f13779 100644
>>>>> --- a/hw/core/machine.c
>>>>> +++ b/hw/core/machine.c
>>>>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>>>>        { "chardev-vc", "encoding", "cp437" },
>>>>>        { "tpm-crb", "cap-chunk", "off" },
>>>>>        { "tpm-crb", "x-allow-chunk-migration", "off" },
>>>>> +    { "migration", "switchover-ack-legacy", "on" },
>>>>>    };
>>>> This line needs to be moved to the last patch, or people will get very
>>>> confused on last patch flipping default without caring about old behavior..
>>> This patch Implements the compatibility flows for legacy switchover-ack
>>> which use this property, so moving this line to last patch sounds even more
>>> confusing IMHO.
>> My comment only applies to this one line to change hw_compat_11_0[], not
>> the property itself.  It won't affect this patch.  It's common pattern to
>> do this in one patch to "update default value, but let's keep the old
>> machines unaffected".
>>
>> Btw, since this value still has a default value ON in this patch, moving
>> this line to the last patch won't change anything except making last patch
>> clearer.
> 
> Alright, I'll move it to last patch.
> 
> Cedric, would you like me to send v4 for this?

Yes please.

I think this series is ready for merge. So I have asked our QE
to test it a bit. Should be done next week. Once done, I will
send a vfio MR.

Thanks,

C.



