Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAF9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNrw-0000GE-Qo; Tue, 02 Sep 2025 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utNri-0000DG-4s
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:03:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utNrf-0005Da-SL
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:03:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b8e28b3c5so10607105e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756807425; x=1757412225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OSSSkLbtwrpSayPhABOlJXP/hr+0H1D9/YeUhYzlcyI=;
 b=TDDGgQl8wcDisF55DmVWb/VqcpWuJL6SawKp7W/8Q5DUvvEPjg+BNvV3mYKg93VS1h
 Vpsgi4JRzQN/H636kakxBNEDqA1y6+sQj2eQpYJKpqZK2f7g6y4MT+eB9V5dQnROuja4
 ucJN9trddIjzB++yRPfdMo+mnRMCikPX93GF9K1FTHcPFkWWHsQIOBTdJCzVc1VFP2SJ
 I39b4DifPut5/OEuMGRVtWHl8c4IzXd/sZ4pKMKK4WYkeNkVHWF/B0Cjk5F6g/rEveQ4
 jQclScwKRWlhijFtMbFI8b67nD44yo3gr+6w9FmveVxqBCRRkZX8bxo/SWpKzkF31g3Y
 p9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756807425; x=1757412225;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSSSkLbtwrpSayPhABOlJXP/hr+0H1D9/YeUhYzlcyI=;
 b=rwWtNCRbwdvYrRD/RwYw21RqSBoSpvEEfusk31xLtMa8/2Y89JbVn5DaNEfHNZPG7m
 mVhP3KR94RUTLHlim8karD4gaIfYbaisGDfIIU/AfS+9zKfa0be/c5ZUEl9uEDKbXcu4
 xU5Brx8jtsHnPml4ODT12XIrtR+Ev/s0vhpDyBkBBgZECZuNgC2yKO9BhE4Jgmu9jDjq
 S/ajR+4qDDjA60myh9TyNNNN7bbRdwFqAh90qEa/39Tr/1ehyz8+bWiKZuiaup3jwBkQ
 GR72vVO7tTNHuBjLGZEJ5RGcO3PNfykoUkjwet7DB6NrcJJVJMae4kWSkrjjplrF8FLk
 ZryA==
X-Gm-Message-State: AOJu0YyhvMuB2G5xs6K2ub0ZrME2xSQDvEuqEMPJDMQI+T7nY16OYcfo
 kYnmPDqvBPOHSOhVVWABURERftp1IwCkQq85x576P+EMAhHmublZaCRKl0B1HTxsUwgph36icH6
 L3oeN
X-Gm-Gg: ASbGnctxTKL/Yl0HZBF35foNlwB2DyLQ36whqAElTE7626erDDlMhUB+o9ZjpFgeyz+
 Cc8VF6IBn6MhogpuIx4jXa3f8Vd/oH4J9dtTLM/AI8FxHQwVx4JEWJr3e2gqWYi9tDpN++TjWcJ
 T9M33k19zKUSLQo/ybDCGJHaf7OFscnA4rKij1AtS9EIwxNPUEOAA0zBQDtxyjL7qVjbsnN3HX5
 kjHFpZLGhUE+zZXBLt6T+KbokpgHxyim2D8dkVB+VWfnVTFP3yDCTVUupL4G+uQlx+WRi2rK5+0
 oyyuqGtuxOs325UXg7aAlopMXezdJ8KmxFaOwp8lIaeirH9gzmxZoAsTHLU3U5nnsU0yh96LJUT
 P6oLqMd6Jqi75g0M+4aVo9oeZn5mGvo6mDKMbpN4oq6/GjfMneCr9cbYNbnGS1+RVFXlQwvHFFS
 hk
X-Google-Smtp-Source: AGHT+IF1XFmZsi43r+RbUqLmDISOpnq7n8CiyCI+J8AgonCXZRvRgqPTkv06N6D3CxNkUIKTo6Ojgw==
X-Received: by 2002:a05:600d:1c:b0:45b:8b95:7119 with SMTP id
 5b1f17b1804b1-45b8b957228mr60554285e9.8.1756807425595; 
 Tue, 02 Sep 2025 03:03:45 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9c234b24sm6465315e9.16.2025.09.02.03.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:03:44 -0700 (PDT)
Message-ID: <bd827802-df47-4e78-a946-011f1595a323@linaro.org>
Date: Tue, 2 Sep 2025 12:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/sd/sdcard: Remove support for spec v1.10
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, devel@lists.libvirt.org,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
 <20240627071040.36190-4-philmd@linaro.org>
 <8d9521aa-b7cd-4f93-8d36-bb286f8a6bc6@linaro.org>
 <7c7c8c08-89d1-4864-95ca-dfebb50007fa@linaro.org>
Content-Language: en-US
In-Reply-To: <7c7c8c08-89d1-4864-95ca-dfebb50007fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/9/25 09:41, Philippe Mathieu-Daudé wrote:
> On 1/9/25 09:29, Philippe Mathieu-Daudé wrote:
>> Kind ping :)
>>
>> On 27/6/24 09:10, Philippe Mathieu-Daudé wrote:
>>> Support for spec v1.10 was deprecated in QEMU v9.1.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   docs/about/deprecated.rst       |  6 ------
>>>   docs/about/removed-features.rst |  5 +++++
>>>   include/hw/sd/sd.h              |  1 -
>>>   hw/sd/sd.c                      | 12 ++----------
>>>   4 files changed, 7 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index 02cdef14aa..ff3da68208 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -362,12 +362,6 @@ recommending to switch to their stable 
>>> counterparts:
>>>   - "Zve64f" should be replaced with "zve64f"
>>>   - "Zve64d" should be replaced with "zve64d"
>>> -``-device sd-card,spec_version=1`` (since 9.1)
>>> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> -
>>> -SD physical layer specification v2.00 supersedes the v1.10 one.
>>> -v2.00 is the default since QEMU 3.0.0.
>>> -
>>>   Block device options
>>>   ''''''''''''''''''''
>>> diff --git a/docs/about/removed-features.rst b/docs/about/removed- 
>>> features.rst
>>> index fc7b28e637..dfe04b0555 100644
>>> --- a/docs/about/removed-features.rst
>>> +++ b/docs/about/removed-features.rst
>>> @@ -1056,6 +1056,11 @@ by using ``-machine graphics=off``.
>>>   The 'pvrdma' device and the whole RDMA subsystem have been removed.
>>> +``-device sd-card,spec_version=1`` (since 10.0)
> 
> Updated to "10.2".

As discussed with Pierrick during online review:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

