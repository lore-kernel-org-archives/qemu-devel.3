Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13154C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 05:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgTf-0000vt-3E; Mon, 08 Jul 2024 00:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sQgTd-0000uD-FL
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sQgTb-0006mr-Ti
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720414786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F/0RLhDM/4YDCJv+vBrVEtlYZ2qvfBtaVkTs6xAgNns=;
 b=coXoQ7MTIdRb0AOOqAh4kfpF7XjgiFxEN9Iv5G2oWwDq7jCOJkCvDZD01jQq+Ix20CYEZv
 z/BgNdOsvCyesY6QQyaMnXa8fwm/Tob2TGNcKOrCCG3XDoHv/RtbrV4bHVPxGRXY0oR9Zw
 m2H3OvUNzXboJe1aAu8/Edh1HojlE1U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-L5zpKSWZMcioPfgSgnzSkg-1; Mon, 08 Jul 2024 00:59:42 -0400
X-MC-Unique: L5zpKSWZMcioPfgSgnzSkg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f571c3eefso152936966b.2
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 21:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720414781; x=1721019581;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/0RLhDM/4YDCJv+vBrVEtlYZ2qvfBtaVkTs6xAgNns=;
 b=u+V0jGLjduKjhjEpD/tHBN73VPsFEb8tgOa001njHUTKREQFRueXQXUMyv7ekqtQ72
 qvPnprdycaGhLN2rivuCTQTy8lMHnvVhi/x5B6G6LyR/l5p3o4iNwKn/f5vTQVWM1zFr
 NaTZQS41kc88ik/UUXPrG5eJMjhCTeoB9Nnx+gaSYMRnFqIxoESOcfy2Ib/YOaaPU5gv
 OcQCeVFa24qmGtM0SjMVHdsKDOOE1NGwAjdz+fjqzBCK5k1vxrhmkhnsHenGrx+f2/z4
 7/FDNYRUMcD2i0A5memXT9PTU8mRqO1fb9UEt1rGLNp15ribzBc1aIODNcESh8ntgRvB
 9s3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQCxN9h3JMYOLPF+fB4TLu6M5dNoozSufrkCrQ8LO6jqxPnGAMr6bwmnKY0JyuBtMfvtO4q85I6hIqg5kNWqKV9lkg0nw=
X-Gm-Message-State: AOJu0YywyYwCVgz1DjpOAX9rfSZxQ0pRzEY7r1bUPnxTEMp6R1KFYO3R
 SnncNwgOH1oHYO8MDo4i4ReFW4dkf6nN7ZBoioIwY9J+yD1eTd6xm3wQ0xW5DwVM6egTINTvH3C
 uNPpW9lHlnF24EvPvU+6mP9+yS+hl0DUuo4yWpgCY+LTmOaf0OZ/u
X-Received: by 2002:a17:906:5798:b0:a77:cc6f:e791 with SMTP id
 a640c23a62f3a-a77cc6fedbfmr504515866b.38.1720414781519; 
 Sun, 07 Jul 2024 21:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESAxrh41g2tdUx/HTiXLY8k/AcgMHNHGKgL4UrKvDH1DAr7aNNPrSEzF/bG+yCYlXB9HWXig==
X-Received: by 2002:a17:906:5798:b0:a77:cc6f:e791 with SMTP id
 a640c23a62f3a-a77cc6fedbfmr504515166b.38.1720414781053; 
 Sun, 07 Jul 2024 21:59:41 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-179-211.web.vodafone.de.
 [109.42.179.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1babesm898231166b.17.2024.07.07.21.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 21:59:40 -0700 (PDT)
Message-ID: <0edcf260-aec2-4ba3-a315-3c0438322147@redhat.com>
Date: Mon, 8 Jul 2024 06:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/40] gitlab: don't bother with KVM for TCI builds
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Mads Ynddal <mads@ynddal.dk>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-21-alex.bennee@linaro.org>
 <07195265-2a54-4396-9724-2a63c98e45fb@linaro.org>
 <5d3be228-1dbb-4e4a-8e20-fb76e4c90134@redhat.com>
 <15191eac-49f4-47bc-b450-1385b3d7fe18@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <15191eac-49f4-47bc-b450-1385b3d7fe18@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 05/07/2024 23.44, Philippe Mathieu-Daudé wrote:
> On 5/7/24 18:49, Thomas Huth wrote:
>> On 05/07/2024 18.34, Philippe Mathieu-Daudé wrote:
>>> On 5/7/24 10:40, Alex Bennée wrote:
>>>> In fact any other accelerator would be pointless as the point is to
>>>> exercise the TCI accelerator anyway.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>   .gitlab-ci.d/buildtest.yml   | 2 +-
>>>>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>>> index 425fc6479b..e3a0758bd9 100644
>>>> --- a/.gitlab-ci.d/buildtest.yml
>>>> +++ b/.gitlab-ci.d/buildtest.yml
>>>> @@ -635,7 +635,7 @@ build-tci:
>>>>       - TARGETS="aarch64 arm hppa m68k microblaze ppc64 s390x x86_64"
>>>>       - mkdir build
>>>>       - cd build
>>>> -    - ../configure --enable-tcg-interpreter --disable-docs 
>>>> --disable-gtk --disable-vnc
>>>> +    - ../configure --enable-tcg-interpreter --disable-kvm 
>>>> --disable-docs --disable-gtk --disable-vnc
>>>
>>> Shouldn't we also disable the other accelerators for completeness?
>>
>> No, this is a Linux machine, and there's only TCG and KVM available for 
>> Linux. No need to bother with the other accelerators here.
> 
> I noticed this is Linux. If for some reason the Xen libs get installed,
> Xen accel will be enabled. Explicit would be:
> 
> --enable-tcg --enable-tcg-interpreter --disable-kvm --disable-xen
> 
> But I won't insist. Anyhow Alex sent his pull request.

Oh, drat, I somehow only had the hvf and whpx accelerators in mind... You're 
right, --disable-xen is certainly a good idea here, too:

  https://gitlab.com/qemu-project/qemu/-/jobs/7281510036#L583

Mind to send a patch on top of the previous one?

  Thomas



