Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BB8C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD09b-00066J-4q; Fri, 31 May 2024 07:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD09Y-000666-Qb
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sD09W-0001Fm-Nv
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/wsyIIZriaAgEzvJXEY0sMNiXVYt+4pstU5P3M9gOU=;
 b=T7vkvy7331L+GcFqW5kZ78Adn7Bl/PnRgnCFNbainctbpXpoNNwAv8neCa058e1EJ8cSEe
 uu4rUG1+6pXL+l1SIlBgsBVLwscF7zPipqahbrc8wRhxpmpK4zo5Rr3pApKkFX0uKtm4L0
 y9jxwNbZsYyZMtDga0PvD+obhgwalvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-zR99--2XNQ6VLkyC9iRJJw-1; Fri, 31 May 2024 07:10:27 -0400
X-MC-Unique: zR99--2XNQ6VLkyC9iRJJw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-420eed123a2so13844065e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153827; x=1717758627;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/wsyIIZriaAgEzvJXEY0sMNiXVYt+4pstU5P3M9gOU=;
 b=XMqDPzJle/xk6fnwIxRq3LlE7bLtVMlsaOhA409XdPrjMC5Bhc0y2Q62lgxM7WnlUR
 HyuNIG8wKR/vdpdGSTPqrKIQs5WzGRI83LWLgmeH2D4A5OnPb9/aSpMNx8uQl1f460RP
 l+B7qLC7JSCqrXoINa/5bn6P153oA4fHZM/BUhKTEQImRHAx7l6wd21a3mZWEHnu97tE
 ML7L2ckqAdIfeYnduSl7ezgErBAQ732cZDEPhySjHoD0fHjch//wY95n3JpM0ecQ3aH7
 HbJWC2KvyX3bHm9Uups8iAGFsOxrRY/bM5r3zAmeS3kqqy1/xkTDUh57MOkRS3d/iB8I
 984Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqmj7TKnVfr4B/qXI306d8HVsYJAie+Fy3pUgBVYuYBQupKy0cpX+WvIMwpk5TGuoZtn7kCd35aNTPvOXNnXN4E2UCQxQ=
X-Gm-Message-State: AOJu0Yzu+zAWF1LFmQUESuucrGNE2f0s7ODcuJqLaQXN88cBIk0ASrtF
 u3S8HZJFNrWgcXYs1ruSO0yZi/cqtxLJ/amSeIH+HFfWhvd/QloczhxiAe1e5NXrrm2BblAPnlX
 iz0gKGYsJ6Abf038gnKdjyePhzoa79ZXPvdhb58VWkee4nm23djSn
X-Received: by 2002:a05:600c:34d2:b0:420:177f:c2a6 with SMTP id
 5b1f17b1804b1-4212e049938mr14780485e9.10.1717153826824; 
 Fri, 31 May 2024 04:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7f3IGPVUpz4rz/LXWyF4rbuPxD4RnyS6qhUHf/WjBTRnfew2HgTcb913jI0dpW1rvtO5/gw==
X-Received: by 2002:a05:600c:34d2:b0:420:177f:c2a6 with SMTP id
 5b1f17b1804b1-4212e049938mr14780285e9.10.1717153826380; 
 Fri, 31 May 2024 04:10:26 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8b283esm21432675e9.44.2024.05.31.04.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 04:10:25 -0700 (PDT)
Message-ID: <103abb49-bcdf-4013-bc9f-df85abe1816b@redhat.com>
Date: Fri, 31 May 2024 13:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Cameron Esfahani <dirty@apple.com>,
 Eric Blake <eblake@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
 <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
 <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
 <12cba30e-4034-4d3b-a0b4-5e25dbc5d094@redhat.com>
 <577f65c3-23d3-44ce-8601-32c067912a8a@linaro.org>
 <370f6594-882d-455e-8b45-5d6cab7fcb85@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <370f6594-882d-455e-8b45-5d6cab7fcb85@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/31/24 11:08, David Hildenbrand wrote:
> On 31.05.24 10:12, Philippe Mathieu-Daudé wrote:
>> On 31/5/24 10:01, David Hildenbrand wrote:
>>> On 31.05.24 09:57, Philippe Mathieu-Daudé wrote:
>>>> Hi Michal,
>>>>
>>>> On 31/5/24 09:28, Michal Privoznik wrote:
>>>>> The unspoken premise of qemu_madvise() is that errno is set on
>>>>> error. And it is mostly the case except for posix_madvise() which
>>>>> is documented to return either zero (on success) or a positive
>>>>> error number.
>>>>
>>>> Watch out, Linux:
>>>>
>>>>      RETURN VALUE
>>>>
>>>>         On success, posix_madvise() returns 0.  On failure,
>>>>         it returns a positive error number.
>>>>
>>>> but on Darwin:
>>>>
>>>>      RETURN VALUES
>>>>
>>>>         Upon successful completion, a value of 0 is returned.
>>>>         Otherwise, a value of -1 is returned and errno is set
>>>>         to indicate the error.
>>>>
>>>> (Haven't checked other POSIX OSes).
>>>>
>>>
>>> ... but it's supposed to follow the "posix standard" :D Maybe an issue
>>> in the docs?
>>>
>>> FreeBSD seems to follow the standard: "The posix_madvise() interface is
>>> identical, except it returns an error number on error and does not
>>> modify errno, and is provided for standards conformance."
>>>
>>> Same with OpenBSD: "The posix_madvise() interface has the same effect,
>>> but returns the error value instead of only setting errno."
>>
>> On Darwin, MADVISE(2):
>>
>>      The posix_madvise() behaves same as madvise() except that it uses
>>      values with POSIX_ prefix for the advice system call argument.
>>
>>      The posix_madvise function is part of IEEE 1003.1-2001 and was first
>>      implemented in Mac OS X 10.2.
>>
>> Per IEEE 1003.1-2001
>> (https://pubs.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html):
>>
>>     RETURN VALUE
>>
>>       Upon successful completion, posix_madvise() shall return zero;
>>       otherwise, an error number shall be returned to indicate the error.
>>
>> Note the use of "shall" which is described in RFC2119 as:
>>
>>      This word, or the adjective "RECOMMENDED", mean that there
>>      may exist valid reasons in particular circumstances to ignore a
>>      particular item, but the full implications must be understood and
>>      carefully weighed before choosing a different course.
> 
> Agreed, so we have to be careful.
> 
> I do wonder if there would be the option for an automatic approach: for
> example, detect if the errno was/was not changed. Hm.
> 

Firstly, thanks Philippe for this great catch! I did think that "posix_"
prefix might mean POSIX is followed. Anyway, looks like the common
denominator is: on success 0 returned. And then, on Darwin, errno is set
and -1 is returned. On everything(?) else, a positive value is returned
and errno is left untouched. So I think we can get away with something
like the following:

int rc = posix_madvise();
if (rc) {
  if (rc > 0) {
    errno = rc;
  }
  return -1;
}
return 0;

Plus a comment explaining the difference on Darwin.

Michal


