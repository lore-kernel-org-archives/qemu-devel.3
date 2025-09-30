Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC8CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3XMS-0002B1-RT; Tue, 30 Sep 2025 06:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XMN-0002AC-Ja
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:13:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XMC-0005RB-MC
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:13:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso17661555e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 03:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759227191; x=1759831991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Fmj4kPweqGagopkTjTJLhrAbweIQr5nzSW5aUdudZo=;
 b=s6Kr2bldxlPhG3FzqwqdB3PK2h+SgpgtJQ9xyWvwHfyx0VJZEgyRz1f5J1CgyEJAPH
 Sn3VZCXHi/HmDduwrGfyLnHVQY1zqPfZUL/tXs7nSKOT/Zv3UQ7qHxSvHQwcUXm1w1Cq
 jZ7ejVqWXl6piXa2lURA1XdSzJFnW1ivR7ZJVY0mdsFX1W2mkPX8M9ECpHkRHGsHLdWd
 JY/q1dc0NgkqYPNLBN9Y5H3bPiaB0xE9Jmw5qfG/lHybGCtYUam0WykR8AfYRuVeioFf
 QeRIuv9VNqdX8oXqGpXlJcSaz9uxr0KeALX35xpdDg2ulYaubfqi6ZmzK/HGwHmiqFbm
 dsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759227191; x=1759831991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Fmj4kPweqGagopkTjTJLhrAbweIQr5nzSW5aUdudZo=;
 b=ZjbKhbgO8RJTvTpJfGuJhwBTiCFAqrH8INPQdGfLyU9GkTYALEHPM0YSrL8tWMvHhq
 53hjSSkqzdn/Q/xEK0rUKf07lWGo1pQ6epLjFML6JTzo64LxGvYEDq2Ctg1d+Zvh0VQt
 rJxhjOlzCPRW2Txbnh7PgUdLMI8S2I/Eqbo4xoboLpX67WGeNIWBBDLCbyq5QgOJRW2v
 5ZQi5uV3bK39kTvZ+WocZpS3SeO08tqxvkpy5dCHOXRTjrCt3GmPOrAE/Uu1CCwarM4c
 95NgIE8cHenaHNhkfnAjHkA/QbVl7jdP+kM51p84YR+URp54civfY6zYP8CTY5ZxF7Ob
 kM8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxfoIq1wcgEQ1ZLnP+qaSlbVQGyCUFvEJywUMVAQqRW+ZJf96jpVC2+hDOF6FcPsxIPUEN1nnCGfPL@nongnu.org
X-Gm-Message-State: AOJu0YzwpI6rvGxefX11VAkk/ifNB4CHMGrfMc9JXsQTz9Ezg67BNCwn
 BRAgbTA3ScHWl3/FBt67iOVD52r/Vs2NkNdhdjlxDl4DPs9NZCNGOtH2twVDzc/gHAc=
X-Gm-Gg: ASbGnctJeBPaRPc39TQa4+MK/MCPXes5gCnV3BaDeY2tT0vceJPo3HXUcphwYpQzPAx
 mfUYAUOtkwpkRBl8PuOpmUMHB+CLoZYPj6xLsgU7MYaUMe+ryW5pfRXUgt7g9XaS6aiq2C9xSTl
 LWcGCoarnwsP5bvnHaJk+TSxFk8736azN+vE6isoi3brXTEg30ZMM3ZHhJgRe/ugwTOD+AR5mAa
 umbBrYK2H1HMhEi9o3CmL40tuLejXdzH65zi+UNw7xl1i2sT9aGeOg2r9pO89RPokVGBu55q62E
 EKWJvPNBvGEVnEJpNasP8Qm3bX9t5II8ZXRwxbrv2DtGbxga4WJ0WFuUPKo1KjZEM9NNVdYgLBC
 p8P1VA+TAx44sqAm+97VXScj0J8SId5ccAVshYiB+xsbOegqpBkkbxg9KOuQTbwy62ovVpWkMKb
 4B7aw7km959gqV0IXBEP3lmKIa
X-Google-Smtp-Source: AGHT+IF+rnMcicNbR48yOpulUbrNdTkYdf+ObbjrIr9iaYQ/1taKuu6ICTWxB4B00uV+sYRmcLDB+g==
X-Received: by 2002:a05:600c:444e:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-46e329f66f1mr159958645e9.21.1759227190642; 
 Tue, 30 Sep 2025 03:13:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm22687164f8f.37.2025.09.30.03.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 03:13:10 -0700 (PDT)
Message-ID: <75cc454b-94d2-45e1-a766-71e6b2d62ac9@linaro.org>
Date: Tue, 30 Sep 2025 12:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] system/memory: Better describe @plen argument of
 flatview_translate()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Jason Herne
 <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-3-philmd@linaro.org>
 <525dd07f-ae64-4ba7-b3ec-b9fcd86aa8a5@redhat.com>
 <ededf937-5424-4cf7-8ea1-e07709db27f1@linaro.org>
 <9993b187-7b44-4f9b-801d-fdfa6b309362@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9993b187-7b44-4f9b-801d-fdfa6b309362@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/9/25 11:18, Thomas Huth wrote:
> On 30/09/2025 10.31, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 30/9/25 10:24, Thomas Huth wrote:
>>> On 30/09/2025 10.21, Philippe Mathieu-Daudé wrote:
>>>> flatview_translate()'s @plen argument is output-only and can be NULL.
>>>>
>>>> When Xen is enabled, only update @plen_out when non-NULL.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   include/system/memory.h | 5 +++--
>>>>   system/physmem.c        | 9 +++++----
>>>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>> index aa85fc27a10..3e5bf3ef05e 100644
>>>> --- a/include/system/memory.h
>>>> +++ b/include/system/memory.h
>>>> @@ -2992,13 +2992,14 @@ IOMMUTLBEntry 
>>>> address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>>>>    * @addr: address within that address space
>>>>    * @xlat: pointer to address within the returned memory region 
>>>> section's
>>>>    * #MemoryRegion.
>>>> - * @len: pointer to length
>>>> + * @plen_out: pointer to valid read/write length of the translated 
>>>> address.
>>>> + *            It can be @NULL when we don't care about it.
>>>>    * @is_write: indicates the transfer direction
>>>>    * @attrs: memory attributes
>>>>    */
>>>>   MemoryRegion *flatview_translate(FlatView *fv,
>>>>                                    hwaddr addr, hwaddr *xlat,
>>>> -                                 hwaddr *len, bool is_write,
>>>> +                                 hwaddr *plen_out, bool is_write,
>>>>                                    MemTxAttrs attrs);
>>>>   static inline MemoryRegion *address_space_translate(AddressSpace *as,
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index 8a8be3a80e2..86422f294e2 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -566,7 +566,7 @@ iotlb_fail:
>>>>   /* Called from RCU critical section */
>>>>   MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr 
>>>> *xlat,
>>>> -                                 hwaddr *plen, bool is_write,
>>>> +                                 hwaddr *plen_out, bool is_write,
>>>>                                    MemTxAttrs attrs)
>>>>   {
>>>>       MemoryRegion *mr;
>>>> @@ -574,13 +574,14 @@ MemoryRegion *flatview_translate(FlatView *fv, 
>>>> hwaddr addr, hwaddr *xlat,
>>>>       AddressSpace *as = NULL;
>>>>       /* This can be MMIO, so setup MMIO bit. */
>>>> -    section = flatview_do_translate(fv, addr, xlat, plen, NULL,
>>>> +    section = flatview_do_translate(fv, addr, xlat, plen_out, NULL,
>>>>                                       is_write, true, &as, attrs);
>>>>       mr = section.mr;
>>>> -    if (xen_enabled() && memory_access_is_direct(mr, is_write, 
>>>> attrs)) {
>>>> +    if (xen_enabled() && plen_out && memory_access_is_direct(mr, 
>>>> is_write,
>>>> +                                                             attrs)) {
>>>>           hwaddr page = ((addr & TARGET_PAGE_MASK) + 
>>>> TARGET_PAGE_SIZE) - addr;
>>>> -        *plen = MIN(page, *plen);
>>>> +        *plen_out = MIN(page, *plen_out);
>>>>       }
>>>
>>> My question from the previous version is still unanswered:
>>>
>>> https://lore.kernel.org/qemu- 
>>> devel/22ff756a-51a2-43f4-8fe1-05f17ff4a371@redhat.com/
>>
>> This patches
>> - checks for plen not being NULL
>> - describes it as
>>    "When Xen is enabled, only update @plen_out when non-NULL."
>> - mention that in the updated flatview_translate() documentation
>>    "It can be @NULL when we don't care about it." as documented for
>>    the flatview_do_translate() callee in commit d5e5fafd11b ("exec:
>>    add page_mask for flatview_do_translate")
>>
>> before:
>>
>>    it was not clear whether we can pass plen=NULL without having
>>    to look at the code.
>>
>> after:
>>
>>    no change when plen is not NULL, we can pass plen=NULL safely
>>    (it is documented).
>>
>> I shouldn't be understanding your original question, do you mind
>> rewording it?
> 
> Ah, you've updated the patch in v3 to include a check for plen_out in 
> the if-statement! It was not there in v2. Ok, this should be fine now:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> I just re-complained since you did not respond to my mail in v2, and 
> when I looked at the changelog in your v3 cover letter, you did not 
> mention the modification here, so I blindly assumed that this patch was 
> unchanged.

Ah I see... OK I'll try to be more explicit in my respins.

Thanks for your review!

Phil.

