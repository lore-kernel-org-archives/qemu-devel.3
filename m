Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8FBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBz3-0001bs-Kj; Mon, 01 Jul 2024 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOByz-0001bb-U4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOByy-00073G-CQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719820911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5KhnNL/nP3UcC6lJV1dspW3JaH7fn8gPNj1WcjCXffI=;
 b=NwsDSCcGQKEqSXHu1O2zC20hmrIktvu93nPu9pfpe5HhbBeDXOIlRD/rbUqbMvISKMWkwS
 ba3A8pNq39RJ2nuYgd+I+xHJshINuCEDukav1AACqanKW6440oZcAiLNGA1UdCOF1b4WWA
 SFdFSvx8e6QOHjT3Mv/SS09rVfwtpx0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-_pc6aPefNPmJWxUrHetv7A-1; Mon, 01 Jul 2024 04:01:47 -0400
X-MC-Unique: _pc6aPefNPmJWxUrHetv7A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257f95ffc6so5789975e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719820906; x=1720425706;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5KhnNL/nP3UcC6lJV1dspW3JaH7fn8gPNj1WcjCXffI=;
 b=E0yJA7ZiKrySF9OSskslPrLPKHvnim1VFhOYyLSQHeNc3jJesf92gfvIGHhb2M2J8K
 yl++hu7VqwF2N2qT2O8eTu68K9IhcXlldYf5N2Fdi9MiQde0ztpw6F63m85iXgFuZJPJ
 vj/0SmpocXt9cT7zIvKfoDO9qXYYvLPyZieZuGjR/h3L7UFrWk8Tc5bMsEGqWEB0SUor
 PN28lQ/yWzkP97WhFWeW/W4E9jtZzXbd3sZxZjzgPrYkwRQxp9XtmGAlsNEffesVOg8a
 7Fmzp7ijpxhVgU7yVjTzDMyur9IoSpPYjREO4tiKNmYZgN32hBk0+lSN1VsarRay0sGa
 O/2g==
X-Gm-Message-State: AOJu0YyAHlRwsJaVZ7F7Baayfar4QPRGm59b2j7PtiyXoTIx2s7aayHs
 kjK2uSaFTow6B6nnY5G/Rm8wcSGmJWm8tgd5a8z3Puy5mMGzEYMIgz72Y+w4Lmyn3YpAw5nTxUj
 1KQLbAAWM+/1dfj7ylbGeGvj7GVRrcGKPd3Yor8GlHF+/isvQxfnx
X-Received: by 2002:a05:600c:4588:b0:425:5e8b:af9a with SMTP id
 5b1f17b1804b1-4257a0280a9mr34483345e9.36.1719820906551; 
 Mon, 01 Jul 2024 01:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCIEXATNoeuYsokjTUM6Y+ZwjhaQ48wN6zvjNxp1f5HNjDUD2fcvd5yc09l07sE4g/9cGp1A==
X-Received: by 2002:a05:600c:4588:b0:425:5e8b:af9a with SMTP id
 5b1f17b1804b1-4257a0280a9mr34483155e9.36.1719820906188; 
 Mon, 01 Jul 2024 01:01:46 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de.
 [109.43.177.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c272sm144151705e9.8.2024.07.01.01.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 01:01:45 -0700 (PDT)
Message-ID: <caa288db-d8d8-45ad-8f4e-d17011c41925@redhat.com>
Date: Mon, 1 Jul 2024 10:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] pc-bios/s390-ccw: Merge the netboot loader into
 s390-ccw.img
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Collin L . Walling" <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240621082422.136217-1-thuth@redhat.com>
 <a3531d21082e3abf3132a4c95d6c54e8973dd27e.camel@linux.ibm.com>
 <77f2550a-fbb7-4bcf-a6b7-b9b31934daf1@redhat.com>
 <d10e77d9-5905-4102-81b6-9cce6bdaae5c@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d10e77d9-5905-4102-81b6-9cce6bdaae5c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 28/06/2024 20.01, Jared Rossi wrote:
> 
> 
> On 6/24/24 1:55 AM, Thomas Huth wrote:
>> [...]
>>
>> I think it should be fine, both functions are basically just a wrapper 
>> around the write() function in sclp.c, with sclp_print() being rather dumb 
>> while printf() is doing the usual string formatting before writing it out. 
>> I think in the long run, it would be nice to get rid of sclp_print() and 
>> replace it by puts() or printf() in the whole code, but doing that right 
>> now would likely cause quite some conflicts for Jared with his patch 
>> series, so I'd rather postpone that to a later point in time.
> 
> Hi Thomas,
> 
> Converting the panics to returns will require me to modify/move some of the 
> sclp_print() calls.  Shall I go ahead and change them to printf() and puts() 
> while I'm at it, or would you rather preserve the sclp_print() for now and 
> then have a dedicated patch for the all replacements later?  I'm not sure if 
> we want to try to maintain some amount of consistency until we do a total 
> conversion, or if you are OK with a mix of sclp_print() and printf() 
> throughout in the meantime.

  Hi,

I'm ok if we mix them for a while, so I'd say go ahead and use printf or 
puts for the new code.

  Thomas



