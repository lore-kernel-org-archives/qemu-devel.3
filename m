Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E4ACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 22:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyHKf-0004b5-7S; Mon, 15 Sep 2025 18:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHKI-0004Sc-TC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:05:40 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uyHIw-0000Yv-8p
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 18:05:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32e1c40ecb0so1624948a91.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757973843; x=1758578643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JVPl3WkHtY26wEQgy01pXNoeJ5YDiVNuCq/nFYkezew=;
 b=bJGpbuLDysF92Y/UHo8F8KNM0Pi0wkVNYEefh5l470oxvPOTv4+bj4j+vL+71F3Up+
 AO6Q9qrtuit/uv1XSvwUxj9MMRexrCcDCR3Mw+pnNkmR35qVfoUUoBxMN4AxC50MpDSl
 jyQ76rkDdaJxSIs22yMXPtxW6E2uvVCbUjuaxMw8YZWkbB3/rFLsKAMJ/Kw95PqL8hdp
 hdmqAUGUj0pg8gDbLs/5qY0x3LXEknHt/tNkUkDO2J66y1sh9kcZsDZJw08exH9enxDv
 /Dyl6gCzcDDhtTHYEqqrkwpOETUVc7OLHHgFBKstVKdPz6yYntV0LGR2ts6yh/wvxeaS
 KYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973843; x=1758578643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVPl3WkHtY26wEQgy01pXNoeJ5YDiVNuCq/nFYkezew=;
 b=BZWbNYGO3rGgRXp3YD6ygYwpGRbvJuSkfhWJsG0n9uK3F+taudBhen8sGpaXpLEHRl
 p7e5h0olk9q2Y+LxABCEv8NxHB1eri9a/D07Fk3TjD4tZPREk/Q7euZwDL+uI9SS8Tsp
 coZEMY/G4PRbwMriAfV/vMjsVXAkIDuS2ci74G9atGvFuaEn5ukugBAUUF4/VjgL8AOG
 kHrq8HgxK6TR2/KgVOFkYvmJ9kfy9rzVHWqfyt3KiJN/Dg07PwfEi1ma4wyxoaOnsNg6
 JysDvbGVFsi0uRtZcFWZ76aWulvf2QpoGvNaomPF/8aKlj19OGbCQbZwavjXgSSusRM3
 cyAw==
X-Gm-Message-State: AOJu0YyiaHoeM+dpteSxOxpGko/Nk+a8uGA+MVgNKCJe81A5WIEJsN2S
 dz8rC3nh4Z5nzkRowTqX3cyrpVAJFHUmw3/DCAP/5qEYE5O7FbUNz73IR85iPQw9SdM=
X-Gm-Gg: ASbGnctNIfb3pJegafSFq20UvG7u5QohMYsgxyl4AVGyAypVHh5noabkTOJ/aja9Pai
 N413boaW2hPyNZ/lpjQLnAvImGVcaOExYZll54gw/XJPKx9xOG1ll+maSSxR0MJ6lzfpXuxE32U
 G4Wpjo1CWo2Cs+OYniw6gePCJefLZHHHZeWRBrcsEKKedwRGzs1zPhpcibEx3al8kxOwKgciwB8
 nu7VvPzhuDcSe5H5uvJnSWbhb/2r3OA+cxl3DwF5Rh5HEblw0EPodTongAD6VsChrzcPwfMyFO8
 vnmqbqwYiSQQ/4J4rE4CwXJJz+DV4bnYnFvpaAUcV3MnBVZ/mkuvmBAnMzEQEFXWSXf65uOMGI4
 gz5VrufrN4BTVPicgFftCj6A0usM+5whdZRT3yNUCaEEJX68YlbGNUwxfs/3+d4AXkh8RBIom8C
 /HTGZc6IFyk1mfRQ==
X-Google-Smtp-Source: AGHT+IF/DQRfGtIQg6W64J4VEEsmo42V7SfGYDGoAvZKia3NGYaZKvds/K4oTaFZik2vVHw+jWuWxw==
X-Received: by 2002:a17:90a:da88:b0:32b:9d3c:13b3 with SMTP id
 98e67ed59e1d1-32de4f87cd3mr14889107a91.18.1757973843009; 
 Mon, 15 Sep 2025 15:04:03 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32e0c2863e6sm8889884a91.28.2025.09.15.15.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 15:04:02 -0700 (PDT)
Message-ID: <44612e6b-c805-4e60-9f2e-1c1863f5b5f6@linaro.org>
Date: Mon, 15 Sep 2025 19:03:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to run
 w/o Avocado (yet another try)
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org
References: <20250915124207.42053-1-thuth@redhat.com>
 <875xdjpubx.fsf@draig.linaro.org>
 <d735ec67-dc45-438c-9151-6ced6ff49b77@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <d735ec67-dc45-438c-9151-6ced6ff49b77@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1031.google.com
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

Hi Thomas,

On 9/15/25 13:18, Thomas Huth wrote:
> On 15/09/2025 18.13, Alex Bennée wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Here's yet another attempt to remove the avocado dependency from the
>>> reverse debugging tests: I basically took Gustavo's patches to rework
>>> tests/functional/reverse_debugging.py, but instead of calling that
>>> through tests/guest-debug/run-test.py and adding the cumbersome code
>>> to support additional test execution logic, I kept our normal way of
>>> running tests via pycotap.
>>
>> Hmm I was getting:
>>
>>    2025-09-15 17:10:50,798 - INFO: GDB CMD: /home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb -q -n -batch -ex 'set pagination off' -ex 'set confirm off' -ex "py sys.argv=['/home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py']" -x /home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py
>>    2025-09-15 17:10:50,803 - DEBUG: Using cached asset /home/alex/.cache/qemu/download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7 for https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz
>>    2025-09-15 17:10:50,891 - INFO: gdb output:
>>     Python Exception <class 'ModuleNotFoundError'>: No module named 'pycotap'
>>    Error occurred in Python: No module named 'pycotap'
> 
> Ah, sorry, I have it installed pycotap system-wide, too, so I did not notice it... I'll fix it in the next version if we decide to proceed with this approach instead of using one of the others.

See my comment in patch 1/2 about adding python_site_packages to
PYTHONPATH to fix it. I think there is no harm to the other tests
by adding it to the test_env, so I don't think it's worth taking
care of it only in reverse_debugging.py.


Cheers,
Gustavo

