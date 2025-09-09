Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAF3CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 10:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvvjG-0004jg-I1; Tue, 09 Sep 2025 06:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvvjE-0004jQ-79
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvvjA-0000X2-UD
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757414247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8tMonEwMMztYrVlk6yr7bssrKM4mcBJMyJMorHpkNjs=;
 b=XOtIutE3PfvJus0YTdJxRrxdJb8/DYx53kPReomvaF+hq+cD4/Z/ksa0/y+qkGBHYnZHDs
 6G9qCmVGOUJw288hqx+TQ+u6vvPheeWV7asxOd2VLQK7Kc6cBF3dMbHgbPfLkZ0nBqGmlS
 touVBoEJLrlYQnkuUFvin8/qgMm0+1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-xA-IfwxzOI6dNqwgm6xDSQ-1; Tue, 09 Sep 2025 06:37:26 -0400
X-MC-Unique: xA-IfwxzOI6dNqwgm6xDSQ-1
X-Mimecast-MFC-AGG-ID: xA-IfwxzOI6dNqwgm6xDSQ_1757414245
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b96c2f4ccso32365965e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 03:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757414245; x=1758019045;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tMonEwMMztYrVlk6yr7bssrKM4mcBJMyJMorHpkNjs=;
 b=Ti+OPd56ZxJ8+pKVYSP1Fbgy1TxcQ1spXkiqkXvC7tcSNZ98I98VVqBlMpG6UhE9+Y
 yHSKYcNsFQEUs0m9THkn5/0BjK0oXuhQvbT/4cYYUo/B2N4LOiY2Iu69tTBBPj5HBoZd
 SZ4LOxVL64g/KN84m6n8n/PINFcj2xUVz23IOwL9onwinVYHz6htORRUeLnAB6IfrvcJ
 jx8zSWN3VvEMaqe4wEp6vF274jzqFKO17R5z4jwVAPphAPV8f+9UPyqHtOgQFC2fJqv/
 xcipiKrlGeE2+Aom7AMpLyllkYQz6QIF0p/wp+UAB7vjpjRlwzsaoTNCOBS0AjWKHbnh
 +b/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU83BkpHtbSfIPcja8z6xIJ3jYXcTNyhyldP1ijJGj5ErgwO/bbEQf4kD7kAaXKHA6JuPtiI/SeJW3h@nongnu.org
X-Gm-Message-State: AOJu0Ywicb5YE9I38j4B45Fe5j4K140o4ksL6z8M950RRSF6Mp58Fwt9
 s9OkzcYUH9++vVPPMr2ubS+JEY/TNjWE1V/j2Xn3EGDqHcU6g2MzuutD5YgYy0vU0KzRitVF/xN
 4i1yp5RC76EyN33XFzSfmBRoh0iGzjyKV12pUDX80Rfk3t9dRQtd2nQbh
X-Gm-Gg: ASbGnctp8F38yjYA+UUuvpLVcN9pZjT6LHfvc6YZJ0VlCpB0lSk0B0SJ1i+rl6vfUc5
 r9biJxoq82yv7VezUYmYCWQSu0fCyLZsgjBfIENRZpGsLRzWn9Q85YTz6WMYkV3lSEQgsA2iH3x
 nn0EV0G195gCYK2QuaYNrkRYduoFpbBHkfJt6tib+X65OsYgG1BSvjCQdEOXcTGgtyjvOsVjJdw
 xMjKbxj2DSxwHPU4GT3d80D3SH0oYNoFNVs2Ev5CbPT+ooWkI2E/ZZdtbAwcozhoTSyIZCi+EmQ
 zfLviyvt0Cxuoje5C2cnvtK5/PSybcsS8PjSUWogBxdzql0hSiYqObpI6yTUBkl3J5egBKKP+FM
 PPdo3XQ==
X-Received: by 2002:a5d:5f48:0:b0:3de:78c8:1223 with SMTP id
 ffacd0b85a97d-3e6440ef6cemr9297371f8f.31.1757414245074; 
 Tue, 09 Sep 2025 03:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5+3/qfuph8oCcvoMRXFKN2G9jJeTgIB5VjROYmvjn+vdWpHmpLm4QXq0cpdI6ghDvBCgJMA==
X-Received: by 2002:a5d:5f48:0:b0:3de:78c8:1223 with SMTP id
 ffacd0b85a97d-3e6440ef6cemr9297351f8f.31.1757414244628; 
 Tue, 09 Sep 2025 03:37:24 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223ea3csm2105260f8f.49.2025.09.09.03.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 03:37:24 -0700 (PDT)
Message-ID: <147a8aaf-5895-435d-8394-ef6a5e03b638@redhat.com>
Date: Tue, 9 Sep 2025 12:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
 <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
 <CAFn=p-aZA0_DhBEFohK6TS=xev459S2YGPm9N3X5w+QDi0noEA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-aZA0_DhBEFohK6TS=xev459S2YGPm9N3X5w+QDi0noEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/08/2025 23.46, John Snow wrote:
> On Thu, Jul 24, 2025 at 3:47 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 21/07/2025 22.38, John Snow wrote:
>>> On Thu, Jul 17, 2025 at 4:44 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>> ...
>>>> Am I holding it wrong?
>>>>
>>>>     ➜  ./pyvenv/bin/python ../../tests/functional/test_aarch64_virt.py --help
>>>>     Traceback (most recent call last):
>>>>       File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test_aarch64_virt.py", line 16, in <module>
>>>>         from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
>>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py", line 14, in <module>
>>>>         from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 26, in <module>
>>>>         from qemu.machine import QEMUMachine
>>>>     ModuleNotFoundError: No module named 'qemu'
>>>>
>>>> I thought the point of the venv is we had all the modules we need
>>>> automatically available to the PYTHONPATH?
>>>
>>> As Thomas points out, "qemu" is special since it's already in the
>>> tree. There has been some dragging-of-feet by yours-truly because
>>> installing the "qemu" module by default when running configure
>>> introduces a considerable startup lag time, and the module is not
>>> actually needed for the simple configuration and building of QEMU -
>>> only testing.
>>>
>>> It's something I want to fix, but must admit to being a bit stumped as
>>> to how I will bridge that gap long term. Currently, all of the modules
>>> we need are in the tree with no dependencies, so it can be fixed with
>>> a simple PYTHONPATH hack. However, if I actually remove the QMP
>>> library from the tree like I have wanted to, then we need pip to do a
>>> real install and process dependencies, and this creates some
>>> complications and extra startup lag.
>>
>> Wouldn't it be possible to add the module as a wheel in python/wheels/ ?
>> That's maybe the easiest solution, isn't it?
> 
> The qemu.qmp wheel, yes, because it's purepython. The part I am
> worried about is that by removing qemu.qmp from the tree, you cannot
> just use the PYTHONPATH hack anymore to use the remaining in-tree
> goodies, namely the machine module used extensively throughout
> testing, because they will now rely on an external dependency.

Would it maybe be possible to add the machine part to the qemu.qmp module, 
too? (Gerd also ask me at KVM forum about this, so there is certainly 
interest for extending the qemu.qmp module with the machine part)

> I'm sure it's solvable, I just tried once a while back and hit a wall,
> got distracted, and haven't revisited it yet... Maybe a good
> rubber-ducking session would help.

For the (removed) avocado tests, they had a dependency on the "check-venv" 
target in QEMU, so its python dependencies were only added when you ran 
"make check-avocado". We could maybe do the same for "check-functional", too?

  Thomas


