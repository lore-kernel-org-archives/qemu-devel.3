Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C3EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVvL-0003kS-Gg; Fri, 08 Mar 2024 03:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riVvI-0003ju-7T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riVvG-0006vc-PN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709887786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pzv7in/SYP2w/qBa51YqARE4NVhqtRRLjFoeoRDXZWI=;
 b=ObX9Vk1r69B7iVNcuRiC/Z1VRr5Mplj5jrEWJkFq3E4JhSCoeapt/I3w5fnN91lXF1BZqF
 KCPU1wfbbpid1G8NEHHFgtDe3l/uyXwAwSFN/6NugXQyhb6hz0GaT9i16bld/HJ36iKYfq
 tMMxrlQnqCERk8m6HUmi77CsuvKQUEE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Jej7ux6aORqxtrn4x9X9cw-1; Fri, 08 Mar 2024 03:49:44 -0500
X-MC-Unique: Jej7ux6aORqxtrn4x9X9cw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a032e40f41so1496047eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709887784; x=1710492584;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzv7in/SYP2w/qBa51YqARE4NVhqtRRLjFoeoRDXZWI=;
 b=FevCWH8Yv8WVGco6SacrbxqqMa7kNCwd6Qzx55j2hWq7b9EZIPV+3ryU23BQuLyWip
 tVZ6Att8LIlq6g+OYUdv6grgx8jDfbnWvwuIREEipeRpJy5l34hL16m+rmuf6iNek78D
 /kIat99YhVlXtzjrZnQu9o4meV3v7KFL7K34dYDed/YcFoqJ0cwnTwuBYO1ENgt2mFds
 C4s5DnMXBo+//cFYBN20hvCVN4ZMSTIvjrANH+dvZsh2xllxffBckYrlXDk1gMJgDYX4
 f5UW19tmAbZ2RzJX64ZdJyBX3hOh4BNmB38sBuiEHZtKZ+9MCjfU6L6lfnoSUqndb+P7
 GI/Q==
X-Gm-Message-State: AOJu0YxBhV8DEay/EzKRXzn/V6aO822+JFqLjDupB6yibYnDqXsxavnF
 6yQ7zxOvA+NaIUKKBXxiOQy4U7XjTonNJ/7UZvkiv4/SGtlzfBCpzaDY0t1fUb2JjzSN06wNCSm
 Qj5rBIt9IEx4UmPfL+hZbXAFQm5WkY5gkO+4ziFYgSvMjkw45iT4c
X-Received: by 2002:a05:6358:6f9e:b0:17b:f4cf:f51 with SMTP id
 s30-20020a0563586f9e00b0017bf4cf0f51mr12729980rwn.17.1709887783881; 
 Fri, 08 Mar 2024 00:49:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGABUDvjrkfg30CMAZFAWksbkY2Uy7OC6GvzKZekqaRN+Zr7dCF5qTa3p4XlPb+aw9Y6u2sJg==
X-Received: by 2002:a05:6358:6f9e:b0:17b:f4cf:f51 with SMTP id
 s30-20020a0563586f9e00b0017bf4cf0f51mr12729959rwn.17.1709887783540; 
 Fri, 08 Mar 2024 00:49:43 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 g11-20020ae9e10b000000b007883a071e67sm3175902qkm.63.2024.03.08.00.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:49:43 -0800 (PST)
Message-ID: <9b70c85e-0c4f-47f6-ade2-a227c5b70401@redhat.com>
Date: Fri, 8 Mar 2024 09:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] scripts/kernel-doc: teach kdoc about QLIST_ macros
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-2-alex.bennee@linaro.org> <ZerA34BH9NNf_K1Y@x1n>
 <87msr9taac.fsf@draig.linaro.org> <ZerK2iI7FAGuQH1O@x1n>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZerK2iI7FAGuQH1O@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 08/03/2024 09.22, Peter Xu wrote:
> On Fri, Mar 08, 2024 at 08:09:15AM +0000, Alex Bennée wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Thu, Mar 07, 2024 at 06:11:01PM +0000, Alex Bennée wrote:
>>>> The kernel-doc script does some pre-processing on structure
>>>> definitions before parsing for names. Teach it about QLIST and replace
>>>> with simplified structures representing the base type.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>   scripts/kernel-doc | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>>>> index 240923d509a..26c47562e79 100755
>>>> --- a/scripts/kernel-doc
>>>> +++ b/scripts/kernel-doc
>>>> @@ -1226,7 +1226,14 @@ sub dump_struct($$) {
>>>>   	# replace DECLARE_KFIFO_PTR
>>>>   	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
>>>>   
>>>> -	my $declaration = $members;
>>>> +        # QEMU Specific Macros
>>>> +
>>>> +        # replace QLIST_ENTRY with base type and variable name
>>>> +        $members =~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/gos;
>>>> +        # replace QLIST_HEAD, optionally capturing an anonymous struct marker, and capture type and variable name
>>>> +        $members =~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/struct { $1 *lh_first; } $2/gos;
>>>> +
>>>> +        my $declaration = $members;
>>>
>>> May need a "tabify" here..
>>
>> Ugg that file is a mess. Any idea what we should use for perl, tabs or
>> spaces? I can update editorconfig.
> 
> Indeed.. not perl expert here.
> 
> For this one it might be still good to keep the same with the code around
> before an attempt to clean it up.

I think this file originate from the Linux kernel repo, so it might be a 
good idea to keep it in sync with the version from there?

  Thomas



