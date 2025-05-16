Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BC0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFncy-0002A0-0Y; Fri, 16 May 2025 01:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFncv-00025i-T5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:28:58 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnct-0001Rg-V5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:28:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b24f986674fso1674226a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373334; x=1747978134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vZXAWGTdmcCiYm91a24aahiWHhOHG8aHh1fzG/CfWI=;
 b=Qlg/2HGXgd6InG9ueoGd1ZUW1GVJa3KzDxAAJwl8qmT1nsriv0qPUV3xyVfXlc797m
 4aaULw+Ymc139IvhUlkzQFddMxGz3qlSlJpTzFjM5O4mf9vUCJb7N0qhE7uXxZXFtkCT
 UxUXrS0iDWG8ycBvJv4cRGfTpSZ4zvMkcNi7oUdAGvOr8JVOeYwhLUe1RRduH7dJeYu4
 4USYZ3jUH0FXlQQ4JW3aR4X3qATA10ov/A64div0ikcUBzz7EHczrTBzeUl2IBNo+aah
 3YsDCkvpG7C5HAjPBLKAJ/+Q33KicC7AZqY0sIk0gPSP/wCBdk/xY9hpwLA7VF1gg6/K
 553g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373334; x=1747978134;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vZXAWGTdmcCiYm91a24aahiWHhOHG8aHh1fzG/CfWI=;
 b=hPeu6mquX485t5WdQI7Z/TFIiLbCKsYUh0n/Kgb0wtY0Fxk7rnLyzz4P3hWMixASfg
 +nL2vk6UVrtAQBeJiDf3PXPs+Uqhsvf2Vqe7e94L71csnc6EPYcd5aeAzHlnxtXhq+Vs
 mK6MJnF1M1lEksAix3u09ubxw6HG47n68L50SUFzSNZxNwgPYhT9kd38BWnwN94Ve/XW
 9OIjCzKL5smgIU/utva4WTB48mVqkYpdueUjcKGGVuKMbIFpoG+WN3vypRfBBQfl1+74
 XjNVT++AqY3ZGVS+7XPdtL9yJNPaizA3CWrdZep0drjBm4HxixiW7F894mzSjNwy5rHh
 mzxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3NEsKhfNS9Z9q+Wc5akgQQljUGfqNmU5lLrYkY/kfECMbEUlTIdRqP7TxTRoZwV1ycQ/1YAH6gAP3@nongnu.org
X-Gm-Message-State: AOJu0Yw6UlpqL9GdcleCQSL80eYhCCDlNC0RScRAryScLbGbQvG7PjmN
 NHFd1gZWbcJtq95bqWfcdAy5w2EVcwyOToL+fBG1K6jykqdZ8zAvxp03MQeMSEM/U7w=
X-Gm-Gg: ASbGncuWGFgTXjnlsojP0HXwsGFCJ1rEtNVezfUJY14kwEJUF43vBdFBaVsbdQpa8M1
 6MqQrxyULCqafS6Cxt1pBdvBYEPEWnJxP9AELrtYDqOc/Th99bxNUQok6LH93ALCRpAHdlvillC
 zBz0iy3KQIJ6VP8QuzmEzynZa4EO7xzX3Wx4ISWSDJOcc/lAQY3FMOg3K9nqXVYQlx0nWElSeRv
 S8rDXEg0FKIfzhTxcXIOXyn8radbU9XBK2m+2TKgpS0Pf5j/QstjmzdSgICjBuzNRTKmHLvge5Z
 yiOoh78fh4GM/p1NWgVIhRxfm58mYqqyg0W39Prliyned/398rMHj8/XFg7CMmgK
X-Google-Smtp-Source: AGHT+IEAv+IPGN2Fstb4M6N9fpkRzyteuJ3Ouy3J4AIsBfzfbhGSsIf2sra8vHxFkHX5uvFp6RYKhQ==
X-Received: by 2002:a17:902:f68f:b0:224:3994:8a8c with SMTP id
 d9443c01a7336-231b3959febmr87205085ad.8.1747373334309; 
 Thu, 15 May 2025 22:28:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4edb0d0sm6511775ad.254.2025.05.15.22.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 22:28:53 -0700 (PDT)
Message-ID: <63e18089-44df-411e-b413-be0cacebb74d@linaro.org>
Date: Thu, 15 May 2025 22:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] meson.build: Compile hw_common_arch_libs files with
 right header include paths
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>
References: <20250513115637.184940-1-thuth@redhat.com>
 <d1bf2e99-7320-4a20-a5cb-2e7ce70036b8@linaro.org>
 <1a89a793-1db7-4b3e-926f-fbd390d2f714@linaro.org>
In-Reply-To: <1a89a793-1db7-4b3e-926f-fbd390d2f714@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/15/25 5:35 PM, Pierrick Bouvier wrote:
> On 5/13/25 4:20 PM, Pierrick Bouvier wrote:
>> Hi Thomas,
>>
>> On 5/13/25 4:56 AM, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
>>> common"), compilation of some arm machines (like musicpal) fails on
>>> certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
>>> don't reside in /usr/include and we currently don't add the right
>>> CFLAGS for the common files to include the additional header search
>>> paths. Add a loop similar to what we already did in commit 727bb5b477e6
>>> to fix it.
>>>
>>> With this fix applied, we can now also drop the explicit dependency
>>> on pixman for the arm musicpal machine.
>>>
>>> Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> [thuth: Add commit message + changes in hw/arm/meson.build]
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>     v2: Change the subject of the patch according to Paolo's suggestion
>>>
>>>     meson.build        | 27 ++++++++++++++++-----------
>>>     hw/arm/meson.build |  2 +-
>>>     2 files changed, 17 insertions(+), 12 deletions(-)
>>
>>
>> Thanks for the patch.
>> I didn't run into any issue when building for {linux, macos, windows,
>> freebsd}, so I assumed it was safe to do things this way and specific
>> dependencies could just be listed with associated sources.
>> It seems like there are cracks in this approach, so adding all the
>> dependencies per base arch is a good idea.
>>
>> Any chance you could base it on this commit [1] (and add it for new
>> libraries as well)?
>>
>> This is going to be pulled very shortly (as part of a wider series), and
>> the same fix will be needed.
>   > [1] 20250512180502.2395029-4-pierrick.bouvier@linaro.org
>>
> 
> [1] was merged.
> I'm working on a series integrating your work, and doing further
> cleanups on meson side, so you can leave it for now.
> 

Posted here:
https://lore.kernel.org/qemu-devel/20250516052708.930928-1-pierrick.bouvier@linaro.org

Regards,
Pierrick

