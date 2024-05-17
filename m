Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA5C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7pmP-0006HI-K0; Fri, 17 May 2024 01:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7pmN-0006Gw-Fp
 for qemu-devel@nongnu.org; Fri, 17 May 2024 01:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7pmL-0007yC-Ed
 for qemu-devel@nongnu.org; Fri, 17 May 2024 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715922311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0RJbLFBu60X72nayksNyWN1wJifmMi30CTFlU1PUBZ4=;
 b=d3OR1n0hAMLGmHSvJ6daTN/wyB0lxRra9dbKVYOnGnUD1PrFP5h88W9PPTYtgtU9bogkUP
 uc6CecZUL8uIRsGze5DVqF2reCG92QKlK/rdhSYwCW4MXlzvvK3+/kPLQoHHBGqBqREQZm
 D4O+miT0BDx0SGseztMEXuftcwGuuFc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-lb4rgZnTNDW0psIMd56djQ-1; Fri, 17 May 2024 01:05:09 -0400
X-MC-Unique: lb4rgZnTNDW0psIMd56djQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so3081346a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 22:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715922308; x=1716527108;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0RJbLFBu60X72nayksNyWN1wJifmMi30CTFlU1PUBZ4=;
 b=diQzU6vxK5gErqPx0sno5RGNDuFkdW+AT7GGKn94oUfS9g5wOBnH1Pl+VHJ9IO3QkR
 zRBwpdEoXZwDOTc7ZA7ABXnua70ywTM7RHDVIObcyly7KSLCQnm4h5VT4CK3UKVVe/+I
 hy0BjLyRNB1Rv6XsChkvCIhxFrfPkXApYsCzyehGw/9RVQJtQrRibC8vMzF2n67uUvZf
 OMOerisp/syXk6dI0+GjSVxcJaWQWvtXKivt3yidv4ShkjVWqPiOXx8SGNQf8QC7A3RI
 /uUEluEy2yxnBhnZslkVa7wMrEcOA8lmJUUW15giDVN72hQ03npiRyickkzaYjJk7xxU
 Ibww==
X-Gm-Message-State: AOJu0YysaQXYyq1Vdu8+qJaUHw0gQPq0HB5Ygdujl9C6cJMqhnHo1p29
 q14gBkEVLaPjjd3vCulbFIr/zhjFToOHUsTCIrqeP03ly4zFUSTjnMiyrmlPxgGa/3GVH29iwJo
 iTQQBHhCAfADouPm7mkEBba1ZQuis8CtiWK414M6RWixm21y1poqO
X-Received: by 2002:a50:d702:0:b0:56d:c40d:b921 with SMTP id
 4fb4d7f45d1cf-5734d5cec7bmr15078819a12.20.1715922308644; 
 Thu, 16 May 2024 22:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH69QK0GrP5eHqbLckECGqy7tRR4AAnwtYagV1ZPVO8nua5zGtjSpcBC2qJ6NPOBMi8W7tAPA==
X-Received: by 2002:a50:d702:0:b0:56d:c40d:b921 with SMTP id
 4fb4d7f45d1cf-5734d5cec7bmr15078795a12.20.1715922308290; 
 Thu, 16 May 2024 22:05:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-52.web.vodafone.de.
 [109.43.176.52]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7e18sm11598037a12.76.2024.05.16.22.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:05:07 -0700 (PDT)
Message-ID: <7d4e8342-05ac-474d-81cb-e1b4386363ce@redhat.com>
Date: Fri, 17 May 2024 07:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
 <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
 <20240516133334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8bYowZnE8B5JivSecSRyZLwo0i3cx1tywOMLNd190Kow@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8bYowZnE8B5JivSecSRyZLwo0i3cx1tywOMLNd190Kow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/05/2024 19.43, Peter Maydell wrote:
> On Thu, 16 May 2024 at 18:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, May 16, 2024 at 06:29:39PM +0100, Peter Maydell wrote:
>>> On Thu, 16 May 2024 at 17:22, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> Currently we have a short paragraph saying that patches must include
>>>> a Signed-off-by line, and merely link to the kernel documentation.
>>>> The linked kernel docs have a lot of content beyond the part about
>>>> sign-off an thus are misleading/distracting to QEMU contributors.
>>>
>>> Thanks for this -- I've felt for ages that it was a bit awkward
>>> that we didn't have a good place to link people to for the fuller
>>> explanation of this.
>>>
>>>> This introduces a dedicated 'code-provenance' page in QEMU talking
>>>> about why we require sign-off, explaining the other tags we commonly
>>>> use, and what to do in some edge cases.
>>>
>>> The version of the kernel SubmittingPatches we used to link to
>>> includes the text "sorry, no pseudonyms or anonymous contributions".
>>> This new documentation doesn't say anything either way about
>>> our approach to pseudonyms. I think we should probably say
>>> something, but I don't know if we have an in-practice consensus
>>> there, so maybe we should approach that as a separate change on
>>> top of this patch.
>>
>>
>> Well given we referred to kernel previously then I guess that's
>> the concensus, no?
> 
> AIUI the kernel devs have changed their point of view on the
> pseudonym question, so it's a question of whether we were
> deliberately referring to that specific revision of the kernel's
> practice because we agreed with it or just by chance...
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> 
> is where the kernel changed to saying merely "no anonymous
> contributions", dropping the 'pseudonyms' part.

FWIW, we had a clear statement in our document in the past:

https://gitlab.com/qemu-project/qemu/-/commit/ca127fe96ddb827f3ea153610c1e8f6e374708e2#9620a1442f724c9d8bfd5408e4611ba1839fcb8a_315_321

Quoting: "Please use your real name to sign a patch (not an alias or acronym)."

But it got lost in that rework, I assume by accident?

So IMHO we had a consensus once to not allow anonymous contributions. I'm in 
favor of adding such a sentence back here now.

  Thomas


