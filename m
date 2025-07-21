Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9CEC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkud-0005nK-R3; Mon, 21 Jul 2025 03:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udkua-0005jV-Ny
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1udkuV-0000zk-Jx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753082764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ymR3HI0xLDMETPlRkIzw2a81Fv2XuICvGq0q2UwV2fc=;
 b=QJaRRtFuA9JJjqcbWxNdYNdeLSuzW8mNJnkOK63xzn+cugNmTL+YYrQIlGBrXFTilgG9ww
 8vOXj5qQGoWDZa3l61BWv2VI3F63HhDrQsrFUYXtrAWsFYoTRx2uq7q6VT0weAg4pzPFYo
 yJyIGGnfJb3ka1UXxOCWgMGC2pELUVU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-21uzpm85NCykbPeH8oWtsw-1; Mon, 21 Jul 2025 03:26:02 -0400
X-MC-Unique: 21uzpm85NCykbPeH8oWtsw-1
X-Mimecast-MFC-AGG-ID: 21uzpm85NCykbPeH8oWtsw_1753082762
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2356498f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753082761; x=1753687561;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymR3HI0xLDMETPlRkIzw2a81Fv2XuICvGq0q2UwV2fc=;
 b=N70ADmKKqeBAi7iouo/Pa5lxd9BSh9qeb8HjcHtbUci/LyoO99d4Tctje9//dBqYki
 AJ3Vinn1aLv8YJw60gmcmQNcHeNHm0Hwrd9UpCbSZBfBSZSbGT+p2BPRLubKbpQs5Cj+
 aYJnj7iyb3nfQdub3e3iBxhGF7UcQal8z1ohRz8D4GhNhzo3JduH/UL1Yo4jwEWvrHBC
 MICr7rN4yEoSWD5C18nwyUGBc6Gxm3YwNmGjT0IDrsUF7ANxbnMJRDa9eeB2ampvWDvC
 9zuktex3mzsEszcW5VV7rYneXrIpMSdodWOZws8koHA87fN9jLJGkazSebhjDMDkjg9A
 NixQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh6aFe/lcSIek/jFdb9gYYwbcA4zaCP5RXQ/zCYfRYMpl+rLhTkkZS3vG2OQS9ThNiFB7E0F4lvWc5@nongnu.org
X-Gm-Message-State: AOJu0Yxf6znpakdYGsffxxMj4LUwuM2UdaM0h/82HbD5NrSIXObtocIC
 HrHjHq2tIKjexiMegWXQVIcMCG3ru0KMt6/uCjIVGJD/tQWOE/fw2xiGjiwllM0bbFqYfnElRMk
 iKSDbU5RV79BRzAIs5ZyyFpeg74guzwPpHENXS8Y4sb2ohn3dcnhXc3q1
X-Gm-Gg: ASbGncuwr32srv4fjvx/SzhqY/xLyXUc3Y0hMNLq3CBCWx8Dq8/+idxMYqKNiPBy2/G
 9MuBBC1Dz16Agea5f68M6qAxECZj3x88aBK3UpWnRtqgeB7a+35skXpN/8m9REDbK5v2GPD2Iqy
 XoGxJ/DGPfrn6BKOznnYCvWwCkPVON5gSs9i3vQ6iVKACUlb1C/AUPX7rynd3ds7wChorjnssOh
 bQQejBGF+00cDr0tzGgdYVJ/POH17SzvIpMVHI8FH+dEfN8GItQksD3NW5l0Hvw3Emdeo9gtQyl
 V668cs9yP8+74dhtsdopAxgACxLCA/V82ytyyKLnCaNzf4OWgeMQJYrctqqAHUfy+nUr+n7i+qG
 Xc4c=
X-Received: by 2002:a5d:5c02:0:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b61b0f2f8dmr8987503f8f.20.1753082761512; 
 Mon, 21 Jul 2025 00:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF68xDr+KTllPgZyOEcaifBf/XoQesI2crIWu+royBXFSphw0oICtkd6u18r8DDkMHWGMYC7w==
X-Received: by 2002:a5d:5c02:0:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b61b0f2f8dmr8987481f8f.20.1753082761029; 
 Mon, 21 Jul 2025 00:26:01 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-097.pools.arcor-ip.net.
 [47.64.114.97]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bac1sm9580926f8f.25.2025.07.21.00.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 00:26:00 -0700 (PDT)
Message-ID: <1fc2e473-5dbb-4943-bf9a-d364987a545b@redhat.com>
Date: Mon, 21 Jul 2025 09:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <7924aab8-2d89-4b69-be5d-40ffb0c839a5@redhat.com>
 <875xfrxfwf.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <875xfrxfwf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/07/2025 12.36, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 17/07/2025 10.42, Alex Bennée wrote:
>>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>>
>>>> Add argument parsing to functional tests to improve developer experience
>>>> when running individual tests. All logs are printed to stdout
>>>> interspersed with TAP output.
>>>>
>>>>     ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>>>>     usage: test_aarch64_virt [-h] [-d]
>>> Am I holding it wrong?
>>>     ➜  ./pyvenv/bin/python
>>> ../../tests/functional/test_aarch64_virt.py --help
>>>     Traceback (most recent call last):
>>>       File "/home/alex/lsrc/qemu.git/builds/all/../../tests/functional/test_aarch64_virt.py", line 16, in <module>
>>>         from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__init__.py", line 14, in <module>
>>>         from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 26, in <module>
>>>         from qemu.machine import QEMUMachine
>>>     ModuleNotFoundError: No module named 'qemu'
>>> I thought the point of the venv is we had all the modules we need
>>> automatically available to the PYTHONPATH?
>>
>> The "qemu" module is special since we ship it in our repository. See
>> the "PYTHONPATH" description in docs/devel/testing/functional.rst.
> 
> Is there anyway to setup the venv so it automatically does that?

I guess so. I just noticed that we already do it when running "make 
check-venv" ... so I assume this could also be done right from the start 
instead?

Paolo, do you remember whether there was a special reason for not doing it?

  Thomas


