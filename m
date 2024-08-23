Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC9AC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPal-0002Pd-TL; Fri, 23 Aug 2024 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shPak-0002MG-5d
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:24:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shPah-00063G-Go
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:24:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso13118065e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724401453; x=1725006253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOoceEIcYGKPldCMuMwpOHROEYBnvJrMPykhiJEBUGQ=;
 b=nTIWkhIorqI3Anm4IfV204ueaus2KlNfMX5e6J5Yp1T+Vo+RaVlOTILnV56SsaAsHH
 A0ylaNLXm0lViyUN+orZBacXhJlGfWiY/6uslHKJzWCtLuHvexewGYvicCCYu453m4bx
 wJ1ljUI0Irn+WDUQ7YNRZ3xwI/nXRHlDfxJzyJDfMTehpvEC3yDVMze3Y/8VVbaIL5yo
 ve8NdOI96NX+VSNqD8aIylCYx1s3xPLJ8YOKMMVpQ0+c0XMyuB2o9TVw56E9ikE8ESAx
 5XpRlC1uUqGxWYl1Oh/W5tX+OWlktlKBiKF4pQMLPVquV1dpb88/GvfkdFMwkgz6IAJj
 O8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724401453; x=1725006253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOoceEIcYGKPldCMuMwpOHROEYBnvJrMPykhiJEBUGQ=;
 b=v4YMw7rGKO2NLJHmZLs1IaTx6WmBlcpmlEy9cgwiPuzrLCWDQ+LTvGRDBdTmDSKH4n
 +qhdIxHyVfYBocccHqIzoJm8hHmLsZd3Ws9pGAFRMKA05W10p6tpZsXFzw2Cc3SIhYiS
 aSk1BjmPlkJ3Iod7So6vkQfqN14c2Y1+Zcjmvq2H/ZgOvHe7OM1RygG0jVz4ojIPGBZf
 HdkSCcP5egrKfSiqb4cSCqlhYO5LfJpPpsvRTKtiXJ2nwIdAf4AhnzLTepAVHYMfFN3g
 VLR0LbBr7QxnqcvrCz68AZfQ+UQYMt+bTaRXDViEMbCpCuYwFWke1OW22waZnxWXL/2L
 pIQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+7EB1h6Ds7nnPTT87KURYfRVRAJjVeEBFOXEFR7FLuRHZezERAf3HeTcPCisCgWDByBKHGm0bzrP@nongnu.org
X-Gm-Message-State: AOJu0YwcyNgTlGMZisdjF1tiq5TxDjfn3dn5VZuDpNbg++ZCdX24XNGo
 5ftz7O5xnBGTiOsjYcAgYZOmdHb4heE9slDK0VVQUxqLhin/aZF0hRA6zi9I5o0XcD+BFkDAu56
 t
X-Google-Smtp-Source: AGHT+IFKS1fEEsG4cbsF5JWpptmRmTe+F4voxq26sVkgZvOsdph+eOhKGIWgircWtl1tdkdUL5iALg==
X-Received: by 2002:a05:600c:1552:b0:426:5416:67de with SMTP id
 5b1f17b1804b1-42acc8ff52bmr9280085e9.30.1724401452650; 
 Fri, 23 Aug 2024 01:24:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed8b83dsm87623545e9.6.2024.08.23.01.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 01:24:12 -0700 (PDT)
Message-ID: <df7826f8-df08-46d0-b5bc-86b640b71c6f@linaro.org>
Date: Fri, 23 Aug 2024 10:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Convert Aarch64 Virt machine avocado
 tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240822120750.89065-1-philmd@linaro.org>
 <23566834-d8e5-4a54-8f3e-cc68e6b7d951@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <23566834-d8e5-4a54-8f3e-cc68e6b7d951@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/24 14:41, Thomas Huth wrote:
> On 22/08/2024 14.07, Philippe Mathieu-Daudé wrote:
>> Straight forward conversion. Update the SHA1 hash to
>> SHA256 since SHA1 should not be used anymore nowadays.
>> Use has_cmd() and run_cmd() methods from qemu_test.
>>
>>    $ make check-functional-aarch64 V=1
>>    ...
>>    ▶ 1/4 
>> test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv2                 OK
>>    ▶ 1/4 
>> test_aarch64_virt.Aarch64VirtMachine.test_aarch64_virt_gicv3                 OK
>>    ▶ 1/4 
>> test_aarch64_virt.Aarch64VirtMachine.test_alpine_virt_tcg_gic_max            OK
>>    1/4 qemu:func-thorough+func-aarch64-thorough+thorough / 
>> func-aarch64-aarch64_virt  OK   30.44s  3 subtests passed
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20240822114146.86838-1-philmd@linaro.org>
>> ---
> ...
>> @@ -100,12 +98,11 @@ def common_aarch64_virt(self, machine):
>>           image_path = os.path.join(self.workdir, 'scratch.qcow2')
>>           qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
>>           if not os.path.exists(qemu_img):
>> -            qemu_img = find_command('qemu-img', False)
>> +            qemu_img = has_cmd('qemu-img')
> 
> As far as I can see, has_cmd() returns either True or False ...

Oops.

> 
>>           if qemu_img is False:
>>               self.cancel('Could not find "qemu-img", which is 
>> required to '
>>                           'create the temporary qcow2 image')
>> -        cmd = '%s create -f qcow2 %s 8M' % (qemu_img, image_path)
>> -        process.run(cmd)
>> +        run_cmd([qemu_img, 'create', '-f', 'qcow2', image_path, '8M'])
> 
> ... so this seems wrong to me?
> 
> tests/avocado/avocado_qemu/__init__.py used to have a get_qemu_img() 
> function, maybe you could port that one over?

Good idea.


