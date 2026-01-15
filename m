Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C100ED46623
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUOk-0005bn-Vk; Thu, 15 Jan 2026 15:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUOj-0005ZT-C7
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:56:53 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUOg-0004oU-VX
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:56:53 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so9129325ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768510609; x=1769115409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZhn7/UNyIxdSAp2QAEnN+LvzdqMK2nI+ujidapkSsQ=;
 b=hmfy9M4stYGm2PK2BgACAkL4I6mWU8MuwBLcBk0Xv6T2Zyo/XufaQzxSaflHfxkTn9
 p6Z5b8YrNppjSdZfWJe4RUEoYwjJFsfMhNqtg58+uYAmLNwUDXRG9SexbDHH5v7GSqEm
 4qQOu2ggxlgezNgOe/o0qI6LWEAiqX2QpxBwQMV0IvSTPF6uvJif7mNVrllL6SHwnzkl
 ckNXuKjGOJJic7T/rU3u1++x7WiOqJCGMDzq8zMlLQyZg8fKgiXtEooofg5SeisilPIs
 dy00qm5hsl7BijoyAKgRhp0WL7/2flPUS4mErLfq/yrA2xRhZWw45uXXEd5NSPSYSd01
 7Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510609; x=1769115409;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZhn7/UNyIxdSAp2QAEnN+LvzdqMK2nI+ujidapkSsQ=;
 b=FNVReYw9JDkxPw+W/Trhvjx2CBxmR3oUiGQu1yr8xIxZAOavYCV/cjKy8S2WGonXzG
 aUL6lSEeIoYDy0oUqrv/OnZ4hfW2eojh5YEdtc8DWd+Q680xqnwV6k4JivD1X50+7bvk
 tvV/C+NDxikV7+7winrCOi36VU0OhRvg53TJ2zsBph4WBfWmINoyYDDfqnqXONLAVndv
 fzkF+VVrKmwNr0oVRxEzrrg2BQyg1w9dA91Gwly3TM2/s9Re1XWF994wafWomkRP7L4v
 WRGGz70uQecyUMBlTjFMITFAXqr41/HgqNI+fYKGvKqOC+0OSD5SJ67nFsLSLzEugyvS
 P+mg==
X-Gm-Message-State: AOJu0YzUF7yLkQO67MLrzx8bTQbA2DAkPNyOWbGv+R3hq//yywbF2Itr
 Un3w7OIXPnsoyVVl0mgHWpI+xfkY2l945PPSKcaT03xdWoRQnSuEV68758LEt7HNv6g=
X-Gm-Gg: AY/fxX4Lmu6SOjZHt7UpSeFIj65bZihIZacGcPDD5Ycr89Vnw16f4z7w4QNVemNIXlg
 4+sXzf4vbFzhSjt7n9b8vwzwFW02xHzoKkdj1ktFJybVqxBL+jOnBaGxFHoA7fH/KxpZGDIREyv
 j8UbH45M+dDoslTZtdxdkT+QWIFfwG9hAEkkXnV4LAtaNXmxjxnbnM2PA39CgsQF4FGoRLXeBZr
 5xIjJf9j0H3KMJow9v0l582f6HkP9NRPKT+eqjBMhByPOsLutMJSEjdxzwz1eEUrsUJK3Y9AcOu
 8dbgNyXJqH4OAuBJFlpM8th7cG70UDPw1X5al2gQHYQ2344AkKZUx5fxu6Kqf5XFCXS6BjBR8b+
 WQ4+wZOr3bxS9a0cFgF4V2dYlHHbs9AcCo2OjGrmkzl9HwF25fxQd1h/5837blK29/18sk5BL/N
 dcsw9YF+KGdGAY9/wG2AzELeB0dhC7y24w3ipui7H7YvLDGbfcfPkV8zxo
X-Received: by 2002:a17:90b:4fc1:b0:340:ad5e:c3 with SMTP id
 98e67ed59e1d1-35272ee0d43mr534117a91.1.1768510609472; 
 Thu, 15 Jan 2026 12:56:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa108bf00sm246347b3a.10.2026.01.15.12.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 12:56:49 -0800 (PST)
Message-ID: <7881bfff-59f0-496f-967e-32a697ff11fb@linaro.org>
Date: Thu, 15 Jan 2026 12:56:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 0/7] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: eric.auger@redhat.com, Tao Tang <tangtao1634@phytium.com.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <6d50c3fe-e235-48e8-b461-fe0689f12070@phytium.com.cn>
 <9fba7ded-d31d-4789-b83d-efcc96f5448e@linaro.org>
 <10e1b40c-2edd-400f-8c8e-e0f3ad4c6f75@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <10e1b40c-2edd-400f-8c8e-e0f3ad4c6f75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/15/26 9:47 AM, Eric Auger wrote:
> Hi Pierrick,
> 
> On 1/15/26 12:39 AM, Pierrick Bouvier wrote:
>> On 1/14/26 5:30 AM, Tao Tang wrote:
>>>
>>> A gentle ping on this series. Any further suggestions would be greatly
>>> appreciated.
>>>
>>>
>>> Link:
>>>
>>> https://lore.kernel.org/qemu-devel/20251224034647.2596434-1-tangtao1634@phytium.com.cn/
>>>
>>>
>>>
>>> Best regards,
>>>
>>> Tao
>>>
>> This version is in good shape and is ready to be merged.
>> Eric, do you feel like merging it, or would you prefer someone else to
>> pick it up?
> 
> Peter generally sends the PRs for the vSMMU. Maybe this can also be
> taken by qtests maintainers too.
> 
> Thanks
>
> Eric
>>
>> Regards,
>> Pierrick
>>
> 

Ok, thanks.
We really need to help Tao to get this in, as it's really useful and he 
put a lot of effort into it, and waiting times between two reviews makes 
it probably a bit complicated for him.

Regards,
Pierrick

