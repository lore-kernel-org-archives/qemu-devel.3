Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8424410A88F1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5okp-0005gP-OE; Thu, 26 Mar 2026 13:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5okm-0005fc-30
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:44:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5oki-0001L8-Di
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:44:19 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-358ed696623so633315a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774547054; x=1775151854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WwW1K4bktHy5eDDQhq0Qpi9uKoWFG03M9/UJfzndlQY=;
 b=ZGc7F0tjQhstL5ygGzEFDKz4S4nhdXkiDWbhPOqRRSyGVnJqRyuKxHcPZ//xSeL7G7
 qZPJz1IVFjhhIhcQizpciHkU4gQhOL/RVPmuTwgU85a93ilBz30WvFzy+xfnfHQIHhZQ
 Sw29PRl5nqNkiuZsrH4DGEIbsBK6K3uMHfA7jMsmw2gQAWRwoStwJQjimECgn97hnvW2
 TkvTwpBBpDKgDLJ2qVQHvMkMNhJqL40unKf55Zv4VZWrQNAyKfflUYLzMZG3Ny+SR4b9
 O5abyNBnEOSdD7JO6fGJE1H0Xv3otbdJtAfkjswwnBckhTTShFIAFsaSkCA6WLEZIxiP
 Zdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774547054; x=1775151854;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwW1K4bktHy5eDDQhq0Qpi9uKoWFG03M9/UJfzndlQY=;
 b=WDspHmzZTjIlkmsKg1ZFsi0ATr22hDqXew5g7KrFmAmgs5KVbdF9HtbU4wrH438SC3
 G5NUQCg+vUxETtaH0qfU2dR5CNreutbKHA/9qSBp4JxgBAV1Bu079v1jVEPi1kv4GtSP
 yYHEMaU40vukGRKEyCMeMGeccghbOXo9jAqe05E8mnqGR9OG9mygXYECEOiy14emNLvS
 LaZpOIeq+7Y3T//e0lgRp3XWHMdeJLUZbrOHCdQLPA6YktIQWKs/vfbo7QqMZQAb7wkj
 6aYGA/qL14SgW6GWgbT2fd6fZBNfyD4AdZ/0U9ijYVTxmBSiKJF8MmpYBcmzYA85jKSC
 EJdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAmGdNQ+USdS4uPAA9Jm/9Fvl/DahxBGC4IrremC6CPbxOTsc/qg1iNeRg6ZzijNeV5kTeSiX0kSGo@nongnu.org
X-Gm-Message-State: AOJu0YzeFBwyWnvvoCvCAX+3iAFRMMLK7mWgf6sJcIUMddt7+RNPYohz
 LMq8OFdpi5G4lItIi1AErZ6RTn4VtPGDqMKfaUGm4TaKYBx3GBXbkfVNxOL/ndbCY8E=
X-Gm-Gg: ATEYQzyBEy14z5C+Q7p8+maHpIIrXqbW4+WTxojTEYNGioJav8fAeetLkUSM49slfEx
 UR8t96S0wbVZHKIY3HVpwqaZ7ie+CCGQS9nLjQZAfeMahwDTvmomWJO71R1sxfTr/6PI+8qUinM
 W+bzZMnDRUEzhU2rwRq1ByTE6MCJMTFZSNWi736V3oCN3aDJ5vHzSCIy9Wn8eEfEFsCCSPP2In1
 clLi6Pt7tOre8K6rrzRPin38nUpUnt3eI++DpBe9VVZrjwf2r4VWHQQeCtXkMVYZwYcQlj0zxen
 6Two3IPUGb+ubSzvOc6+KtM5/55IYeVrlY1OFpOOtEjXlQnsMpCZWkXnLnexGf5tNLZHE1UWQDe
 LaskyKThJ0RmTvZJpSEyxckA9gCmck3AE6okjvTDn/zWO4ox84sdV5PcyX4gJrlmEJABbWwQLLr
 mKQzuUGpwi8xnPcSeeUuaBl/BI4GAEy6DYSY2QufoGh2iY0HoB7Gup+SYpXj7EuyK7UAvyzUnE5
 jA7t7A=
X-Received: by 2002:a17:90b:4cc3:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-35c0dd82ecamr7897640a91.29.1774547053499; 
 Thu, 26 Mar 2026 10:44:13 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22cba9f7sm2393930a91.11.2026.03.26.10.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 10:44:12 -0700 (PDT)
Message-ID: <81ba1e13-5dca-488f-bfd9-19927ed9dbc7@linaro.org>
Date: Thu, 26 Mar 2026 10:44:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
 <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
 <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
 <CAPMcbCrwv-Q=iP04iYHi5QTfE9RjWjJwEnLmH-9W2vghfOHEpw@mail.gmail.com>
 <1760bba7-04e6-441c-aec2-96bf722c93c1@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <1760bba7-04e6-441c-aec2-96bf722c93c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 3/26/26 10:38 AM, Pierrick Bouvier wrote:
> On 3/26/26 10:11 AM, Kostiantyn Kostiuk wrote:
>>
>>
>> On Thu, Mar 26, 2026 at 6:48 PM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
>>
>>      On 3/26/26 9:43 AM, Kostiantyn Kostiuk wrote:
>>       >
>>       >
>>       >
>>       > On Thu, Mar 26, 2026 at 6:35 PM Mohamed Mediouni
>>       > <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>
>>      <mailto:mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>>>
>>      wrote:
>>       >
>>       >
>>       >      > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk
>>       >     <kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>
>>      <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>> wrote:
>>       >      >
>>       >      > This is the first set of changes to allow building qemu-ga
>>      with
>>       >     Microsoft Windows Clang.
>>       >      > It includes some cleanups and fixes that also make the
>>      code more
>>       >     portable.
>>       >      > The main goal is to be able to build qemu-ga with the MSVC
>>      toolchain
>>       >      > because MinGW-w64 is not available for ARM64 Windows.
>>       >      >
>>       >     Hello,
>>       >
>>       >     MinGW-w64 is available for arm64 Windows, although it’s more
>>       >
>>       >     mature with Clang as a compiler instead of of MSVC.
>>       >
>>       >
>>       > I expect to use clang from the MSVC environment, not the MSVC
>>      compiler
>>       >
>>
>>      Is the difference that this clang does not come with mingw
>>      preinstalled,
>>      and thus require using msvc headers/libraries instead?
>>
>>
>> Yes, the difference is that MSVC Clang comes with MSVC headers/
>> libraries, not a Linux/MinGW one
>>
> 
> I'm surprised you don't run into other issues than the one this series
> fixes, that's great!
> 
>>
>>      In all cases, it's just better to use msys2 environment. What is your
>>      limitation with it?
>>
>>
>> This requires additional maintenance of the MSYS2 environment.
>> Also, MSYS2 is a rolling release distribution, while we definitely
>> need to know the version of dependencies and control them.
>>
> 
> The maintenance is quite low in my experience, but I understand the
> concern with the rolling release aspect of it.
> By curiosity, for dependencies in MSVC environment, do you use a package
> manager (vcpkg, winget, other) or build them from source?
>

As a complement, you can use msys2 and install manually the versions you 
want for dependencies, and mirror them for reproducibility if you're 
concerned they disappear. I would not worry too much about following the 
toolchain and build tools from the rolling release, and you would just 
have to do it for libraries QEMU use.

See for instance index of packages here:
https://repo.msys2.org/mingw/clangarm64/

>>
>>       >
>>       >     Is it more of a packaging issue with distributions?
>>       >
>>       >     Thank you,
>>       >     -Mohamed
>>       >
>>       >
>>
> 


