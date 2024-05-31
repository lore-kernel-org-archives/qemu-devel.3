Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D4C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxNq-0008FQ-Cj; Fri, 31 May 2024 04:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCxNo-0008Eu-Js
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:13:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCxNk-0003el-6g
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:13:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42121d27861so17535825e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717143178; x=1717747978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I9hzmznr64wCKlVpRXoKfhH0aXh3YhZsY8iM4DK8LiM=;
 b=Kux4uQAG9Qr16rTMN7WB0V06hWMPrQxlziVehYXeeg9OUpkEvKTy++5i+rJc+HL9Iq
 ePAus0ZIZOZIet0XtaWtZdSXWQE9xRISA7FF4UNdPkmR/6vMiSHLmtz7wDNXh5sB+0X/
 i4gfDg4AKefRcB+tjaAbGGUAdrzc+B+H56RrDRL621vqABfQpPAsLuubCrVmo8HB6pmd
 iJ7VCiLVZPR2Vyw/cmHiDXPNHPd5XbiXCm+CDApltGNE7UWtyx6vBwBnJ0Zgh3YVJM3f
 njTgBLdt3rD8ZMEDTq6GDvgescgcjDT23v+I7mBckZUyv+yat0naIU+KKUDLkn0B5aP8
 yrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717143178; x=1717747978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9hzmznr64wCKlVpRXoKfhH0aXh3YhZsY8iM4DK8LiM=;
 b=O0SzmXZiq+lPf7doX5d9p8sajsjpMDP8Z3yizNLlJBvnj3Qyi0QTBGXMQwDbpVe0Lj
 odSWIb+tMJeCnnaSpvuzAPoP16ONA22Y416IEd8XgOOGZGl9yGPwakoVzxwrxRI0Fa6G
 nMe+td/nozoJfsU6ADNLZO592F4Ig7RPfUCcMPqyBXvUi/cgaxiM6B0vtRFLN+o5EVHq
 Ab6uMY+twaDaL2qwxnv1vNNkrzPnhopBl73hipd6kpr4WaXrlqQIo9hOhZimO1YQjryH
 PwZVTXqciz7nOT2ERlzPqbtTNOfXoRujPTmPUxFxumZ0c/b+QNSS7rVtjg7CwWTMCO88
 s40Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf+OGY1KJGXL3fSeAtvYe6n7YujkhBlvq90ZGKEHRX0JXCXPFzNgEgpaIsFHERmljLVKlgd4L7GjlK9G88yPdM+SiT1Wg=
X-Gm-Message-State: AOJu0YyFUg2plRAw98ZHhGU7YtkTVVv6oG1hfaZIyg4YY8Cgc9Op6Rd8
 BX4InGDF/goZTh80ZxSbA4oJDchw8350fXXvsvf3MUW8tXPtIgzNdMASy8hke1NPyaDfrbP6CzP
 8
X-Google-Smtp-Source: AGHT+IFfEyJVyi3Ipr9BMI6EgW5T3HU+cHZbwFEiRIG4FlK1O0RLFx/W8MOvV+QsKO1HVSM8n44pew==
X-Received: by 2002:a05:600c:45d4:b0:41b:f979:e359 with SMTP id
 5b1f17b1804b1-4212e0ae5b9mr9729685e9.38.1717143177710; 
 Fri, 31 May 2024 01:12:57 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d5c7sm17284415e9.8.2024.05.31.01.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 01:12:57 -0700 (PDT)
Message-ID: <577f65c3-23d3-44ce-8601-32c067912a8a@linaro.org>
Date: Fri, 31 May 2024 10:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: David Hildenbrand <david@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Cameron Esfahani <dirty@apple.com>,
 Eric Blake <eblake@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
 <e2250aa1d69faffcfd12b6d809d98b0c8157ce36.1717140354.git.mprivozn@redhat.com>
 <81f8c7f8-a4a6-4f74-894f-be3ffbf25f9d@linaro.org>
 <12cba30e-4034-4d3b-a0b4-5e25dbc5d094@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <12cba30e-4034-4d3b-a0b4-5e25dbc5d094@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/5/24 10:01, David Hildenbrand wrote:
> On 31.05.24 09:57, Philippe Mathieu-Daudé wrote:
>> Hi Michal,
>>
>> On 31/5/24 09:28, Michal Privoznik wrote:
>>> The unspoken premise of qemu_madvise() is that errno is set on
>>> error. And it is mostly the case except for posix_madvise() which
>>> is documented to return either zero (on success) or a positive
>>> error number.
>>
>> Watch out, Linux:
>>
>>     RETURN VALUE
>>
>>        On success, posix_madvise() returns 0.  On failure,
>>        it returns a positive error number.
>>
>> but on Darwin:
>>
>>     RETURN VALUES
>>
>>        Upon successful completion, a value of 0 is returned.
>>        Otherwise, a value of -1 is returned and errno is set
>>        to indicate the error.
>>
>> (Haven't checked other POSIX OSes).
>>
> 
> ... but it's supposed to follow the "posix standard" :D Maybe an issue 
> in the docs?
> 
> FreeBSD seems to follow the standard: "The posix_madvise() interface is 
> identical, except it returns an error number on error and does not 
> modify errno, and is provided for standards conformance."
> 
> Same with OpenBSD: "The posix_madvise() interface has the same effect, 
> but returns the error value instead of only setting errno."

On Darwin, MADVISE(2):

    The posix_madvise() behaves same as madvise() except that it uses
    values with POSIX_ prefix for the advice system call argument.

    The posix_madvise function is part of IEEE 1003.1-2001 and was first
    implemented in Mac OS X 10.2.

Per IEEE 1003.1-2001 
(https://pubs.opengroup.org/onlinepubs/009695399/functions/posix_madvise.html):

   RETURN VALUE

     Upon successful completion, posix_madvise() shall return zero;
     otherwise, an error number shall be returned to indicate the error.

Note the use of "shall" which is described in RFC2119 as:

    This word, or the adjective "RECOMMENDED", mean that there
    may exist valid reasons in particular circumstances to ignore a
    particular item, but the full implications must be understood and
    carefully weighed before choosing a different course.

Regards,

Phil.

