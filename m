Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D6FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 12:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4fao-0003ws-7k; Tue, 15 Apr 2025 08:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4faZ-0003v0-9X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4faS-00008E-Fs
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744720822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hyE4GDDGNdNM+JQzUzBuWayb2Em6KH211u72Sx1q6IY=;
 b=VJPMmaEkLOxU3Zr3cOCJ++tKmsR37NgHYsV5pIgUtJI8GI9YWCHNbI7pK6q1csmpz/ZKrk
 75C0GefUI7j0s0xVFblrSIg0hypwJB2p5Ewtb3WAVx4jPgd5ak1jsGadKMUrxtbk98SgLT
 OweTwPbL8Aszwkf8ketyriGqruuSvpo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-HlX0pIu2M3CrzaDV20qlIg-1; Tue, 15 Apr 2025 08:40:21 -0400
X-MC-Unique: HlX0pIu2M3CrzaDV20qlIg-1
X-Mimecast-MFC-AGG-ID: HlX0pIu2M3CrzaDV20qlIg_1744720820
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d733063cdso44819665e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 05:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744720820; x=1745325620;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyE4GDDGNdNM+JQzUzBuWayb2Em6KH211u72Sx1q6IY=;
 b=UuYwZgKOICJmaLkHi0faJ5teC5Iu0xvLa8CEikYxSjxxflqlbyzTtg5z8vAlfAkuZx
 pM6+sRXSeR6Zac4V0YcKjWgiqr+iBlI+v0TuVCZBmRhQNuVtppnBFAbZu+d2YHZq/gZU
 GJHZ2O3Z0WEdKZ3FFkBRBmYg4e7AM4+5wH9wQLSxqk9kucJUR6xoeEixk84rz5jk19yH
 DDIlwvxwD3i8bG66sH8czN1RJKZTnl+m/PTQLeRGqvpBUIbGdmBoOtryv1ObXOyx0m2m
 cozJlg2ZrWAJRUw5TCUxUOVHWY7JMLJS3Fy7Z77FdSHLMwZt6MOon6oiBomT2XOHskHf
 6nlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrx/67Vu8vURUotquG4Xv0mtGN+Yyl2nktmWAx9BDAjWRJttSc7gpcdj6SRLfU19hjaVJ7c6u+ymku@nongnu.org
X-Gm-Message-State: AOJu0YxaLpVEiZPA4h7eCOtXuqZvS7Ghe/3yMtFPjdLw+iKzP8jEaxKf
 8PHeWtFk6ec6fbF8cS7Qd5fDRXX+jk0TyRA1KOVph5mxEbKNzk51fIRmNGYHxCFLQ+kBmfYtlev
 Olr5/z6t4wWPoZm1QEu2xzyMTiAsFHwsbCpEPEMkIOjhmoemKWnWc
X-Gm-Gg: ASbGncuxpKGfbrp9/GY1Sd5dJt1T3RSuhYgjSnWHWedrxJucTb5dgBy3Kv8XK6Uc/7G
 CqVNGc7Cn8oTD3+2zwru8l+imAXz8OoeOhZMcfwoSFp7sGHsRRpeUh9pf+TAOETld3CgsNlBiLQ
 qtMZpBUvT77naF8IoJ+4Xe4WVC29Fw/SamRnDDBmhV1RRTC9V2yMGgTBKzGWBcMPKJ6wmE7wBL4
 n6tJ/US7SRpqAkF6c6F5LN14Lx9nBc29p7dwkFRLvmIOt62Z+6WcvnepG7VmxMRqsfqB39k6kA+
 87fgD2W483D6DJHKwIxSdL0zzd/QKd+n4/a5mbfoSEo=
X-Received: by 2002:a05:6000:4313:b0:39e:dd1e:f354 with SMTP id
 ffacd0b85a97d-39edd1ef43fmr2627341f8f.35.1744720820204; 
 Tue, 15 Apr 2025 05:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTkeX/k2gCHoCvbrDkoHjWO9K331IWLCWpt4FnIMmb80CgsTyHgg4m9zg47AvRJePbPyBfMQ==
X-Received: by 2002:a05:6000:4313:b0:39e:dd1e:f354 with SMTP id
 ffacd0b85a97d-39edd1ef43fmr2627309f8f.35.1744720819812; 
 Tue, 15 Apr 2025 05:40:19 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-176-89.web.vodafone.de.
 [109.43.176.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c684sm14263201f8f.33.2025.04.15.05.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 05:40:19 -0700 (PDT)
Message-ID: <dbf26552-8d21-4c3d-92a1-d3defe50fbd9@redhat.com>
Date: Tue, 15 Apr 2025 14:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: introduce function when exiting PV
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, seiden@linux.ibm.com
References: <20250414154838.556265-1-ggala@linux.ibm.com>
 <20250414154838.556265-3-ggala@linux.ibm.com>
 <f96a9e7b-2bb9-4f0e-bbb2-3aca8bbbab02@redhat.com>
 <20250415120459.592492-A-ggala@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250415120459.592492-A-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/04/2025 14.04, Gautam Gala wrote:
> Hi,
> 
> The change is not really necessary. The existing macro looked almost like a
> function, and since I was making changes in the area, it felt like a good
> opportunity to change it to an actual function.

Ok, makes sense, but please add that information to the patch description!

  Thanks,
   Thomas

> 
> On Tue, Apr 15, 2025 at 11:44:35AM +0200, Thomas Huth wrote:
>> On 14/04/2025 17.48, Gautam Gala wrote:
>>> introduce a static function when exiting PV. The function replaces an
>>> existing macro (s390_pv_cmd_exit).
>>
>> You describe here what you're doing, but not why ... so may I ask: Why is
>> this change necessary?
>>
>>   Thomas
>>
>>
>>> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
>>> ---
>>>    target/s390x/kvm/pv.c | 14 ++++++--------
>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
>>> index 3a0a971f0b..66194caaae 100644
>>> --- a/target/s390x/kvm/pv.c
>>> +++ b/target/s390x/kvm/pv.c
>>> @@ -59,14 +59,12 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
>>>     */
>>>    #define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
>>>    #define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
>>> -#define s390_pv_cmd_exit(cmd, data)    \
>>> -{                                      \
>>> -    int rc;                            \
>>> -                                       \
>>> -    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
>>> -    if (rc) {                          \
>>> -        exit(1);                       \
>>> -    }                                  \
>>> +
>>> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
>>> +{
>>> +    if (s390_pv_cmd(cmd, data)) {
>>> +        exit(1);
>>> +    }
>>>    }
>>>    int s390_pv_query_info(void)
>>
>>
> 


