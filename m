Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A3ECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2yk-0002eC-Nx; Thu, 05 Feb 2026 12:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vo2yi-0002b2-SZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:17:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vo2yY-00070q-4V
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:17:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so1061388b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770311824; x=1770916624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HMJBLIZZVySrzBjx6zWXdGIJwCn406NAcMdgicy7liM=;
 b=oM2rN4qBQ8izJTw7/e1JQLmib9cmySKOq4aU9Vcb78vj5sfYQtmZjbFAcQAqqa3S4l
 xsSgCzxJRqaKuVH8xWegz/uuQ73zNhw1PSbxCMbmCeQNqLSCNsSKn3uC92WZNA6jbMZf
 eENdfowV1TAk8hT2j+wd6+K4mZSK0rMsFLGV6ythNjMmuYVosK21hHllYvicbMNQWe/T
 H9n+ILYB11PJwSrMqpAcf/KsnfLayMYY7zJDibBsZzDtmAUlnc27H+SEm6RcJZSWoHkj
 2HC9vaisJsYRUslovzjiL/auYjfE2GUThoyVF5XFuI0K7yFaqqnDCHpPAxW1Z5fuz9J+
 pL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770311824; x=1770916624;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMJBLIZZVySrzBjx6zWXdGIJwCn406NAcMdgicy7liM=;
 b=hXJWRRPrwEM9lD4fduGh4XytYl6FkDtKyoBDQJfCRAs9uVEgLU9tzq+gdls5f1bhwh
 yndirx2Zq3U3X8biJ843YSdHr0JZKulGJRSQ+DahSNFAoIHyd4TMkuroZ2gOdKgarcXs
 byRd8o8jh85RPRP0LQGn0rTmyIOdgRGeL80FrMAuzKbl4+3Lup5mwaFRpTnXUCmDSZ53
 ZzN9Z/6rn5g05okdFIJk3I4Pr7I3YE/PGwQpVGesEgimPnd1BkHBL021rwj4c6sIkJod
 y1dXDgWB6EGMfIiys2G/pf7PQUgMEFHeM+o7vNG7W5zyGwsn7H/x/e8GSzGKJuHQCcsC
 X2iQ==
X-Gm-Message-State: AOJu0Yy3j3cqsHKF/LNekUPVqK+Kq0Woa8quzENxM+kcsieSloqQellH
 2u7OQ/0xc+Wf4HMj6Gw/BO1y8eeGwM/0P6hR1JJzAzxfpwaAI1X5s9A7z9sUh7Idiho=
X-Gm-Gg: AZuq6aLVkqMeoEtiqArOD0+xLinw3u9MuAWBpXUGoc3Q9wAJc6ZOGYGJBEwvJXGtW+q
 p8YLTOKVVOr4hH/QakVDl3hrI6BeoCo37jvt3gAKBsiJa9e5gjESgkAVhdWs+AQtxT3zsm2n2nr
 KktSTSR+T12A6hbNhiVl8oQV8EbqEJQ8wpvs7xZXTLfeOzzT+14yD6ounpDe1hrBjjTfxhKruCX
 URL5p+AZJKRNwSJSEdA4QhsUQzzR3wNZRWBTwsk7EklwwXL3V8A7KbHG+SJ9fOc5kwrKSY2y9FP
 orIpc91eR9LVjclRyQ4CLo6SRsKsSRIC0MK8pG1+9JlgEI36f4Cd5E9RCqkfgYaUELAGuVkGF9g
 U2K02/cV+PGUBrAWb5vGMXI05Fj8BLc76a2MXXb6v1cYH4BizO76LPmxwKKdnHjXcswMTQ/5Fe6
 U3h3hpLOcxQM38lkbMTlTrOD1YzELYE0tCvNXC7b7/X6Q6s7+zHvu6CGtR
X-Received: by 2002:a05:6a00:a904:b0:81e:b2ba:5b36 with SMTP id
 d2e1a72fcca58-8241c695b0emr7941670b3a.63.1770311823986; 
 Thu, 05 Feb 2026 09:17:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d45b3f8sm7607294b3a.47.2026.02.05.09.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 09:17:03 -0800 (PST)
Message-ID: <59bea9ee-d874-446e-9ec3-b14449d856e4@linaro.org>
Date: Thu, 5 Feb 2026 09:17:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] single-binary: hw/virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-ppc@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <571ef1d1-88f1-4f4c-9800-00f114a85e02@linaro.org>
 <20260205014101-mutt-send-email-mst@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260205014101-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/4/26 10:43 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 09:27:10PM -0800, Pierrick Bouvier wrote:
>> On 2/3/26 12:56 PM, Pierrick Bouvier wrote:
>>> This series eliminates target specifics in hw/virtio and replace them with
>>> runtime functions where needed.
>>>
>>> Performance has been measured with this automated fio benchmark, with
>>> original instructions from Stefan [1].
>>>
>>> $ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_64_io_benchmark
>>> $ cd qemu-linux-stack
>>> $ ./build.sh
>>> $ ./run.sh /path/to/qemu-system-x86_64
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/
>>>
>>> Results are on 20 runs and expressed in kIOPS:
>>> reference: mean=239.2 std_dev=3.48
>>> with_series: mean=238.5 std_dev=3.46
>>>
>>> Performance is on par, and within standard deviation.
>>>
>>
>> Does it look better to you Michael?
>>
>> Regards,
>> Pierrick
> 
> 
> better for sure. is there a reason you dropped stefanha
> from CC? he suggested these tests...
> 

I didn't to that intentionally, it seems like he was not added by 
default from the file set when I posted v4.

Stefan, please see cover letter above and let us know if that sounds 
acceptable to you.

Regards,
Pierrick

