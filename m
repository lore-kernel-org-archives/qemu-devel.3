Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B7EC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLxF-0001zu-Lb; Fri, 09 Aug 2024 05:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLxC-0001yR-Ms
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:30:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLxA-0000KC-9g
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:30:34 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428fb103724so16470185e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723195830; x=1723800630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTXFjiUw5Bp4dZ4P9iTQAoR26OCDVV5O5ZIqNR6ttXo=;
 b=ZbQGGBxsUqL+9GnZOTpMFnEkaVJqBeaZMeg7efBH0ZqyLyz0Bw7ZP1lDx2uPKevjQm
 QwR/XmKfdrJ5lvJe1TK4x3odTpxauiKi+g9tERE5+puuX0PtKza5y7jd0W2rJ7wDEuZC
 QqU5W46AteZE+KajUvOhdjWKvZ50UC0VMyAQsy+Wpi3YSfev9SgHaBQN6jgkpyvPnE8r
 wqgX/XZSnbch1c6SUKkMP2Ns+/4VYZ0skwY7Z7vxCI5Kq/SYI8M+RAUzr29kkiRrEuTs
 6nHTEmu1ucLplKCwC3OK8ivgI1oCVqOM6lhJCh5gq3e33OXLbRlqdQZ77GPgvGC+EGzn
 k8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723195830; x=1723800630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTXFjiUw5Bp4dZ4P9iTQAoR26OCDVV5O5ZIqNR6ttXo=;
 b=TXl8cvhFx8dtIXSoqDy+duFA1C2zK+MoRlC1M99S5vBcRwyK/5cjmBzf5zVPKR95aL
 rTrAc0h0TF7iC4QeaukZwB0JIoim2q57a4DTeRm6uagjmXFke0oFpOI/uOrEl7VAmNSJ
 yp6F/vIIce+tgEGOp8G5gmKiR+8ttTeq/zyxgZkIb4vYs+WLJV8rKCTarBPNNHu7fblC
 2rFuGDk5bUzB2y9hqGQGRkuGWLkfq4YpwrZeCOKVh978NroSXd5smaxPyIBfvLSudFCL
 ppyGd4PT6a8mKzHNOQrqo4fSv6KQzBi0iE3uqD8TfLEv4oYYu1CHRFpc3IsHh82i9pXN
 8wIA==
X-Gm-Message-State: AOJu0YxXABwnmxVy3zouSz/xSkNaA2P0u4jy4mF1v7QZZBTV/km30HpC
 t/YR1lXkbKYsQ7iPuTLHLUlStmt4TN8SVIBCsiN1qoXX17iVSIiXX6FFkdUftss=
X-Google-Smtp-Source: AGHT+IE2kOvm5jYMZiltc3fT9+yWha2f7l9SEStT1cOlFQ7BoScLKVHUtFWIY6lmySr2vwOgFlSQxw==
X-Received: by 2002:a5d:6691:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-36d6829eadbmr913471f8f.4.1723195830340; 
 Fri, 09 Aug 2024 02:30:30 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d271576c1sm4682692f8f.21.2024.08.09.02.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 02:30:29 -0700 (PDT)
Message-ID: <9080f7e5-a40d-4cbd-a734-74578dd27894@linaro.org>
Date: Fri, 9 Aug 2024 11:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Octavian Purdila <tavip@google.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com,
 peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 alistair@alistair23.me, berrange@redhat.com, crosa@redhat.com,
 bleal@redhat.com
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/8/24 00:30, Octavian Purdila wrote:
> On Thu, Aug 8, 2024 at 2:56 PM John Snow <jsnow@redhat.com> wrote:


>>> diff --git a/configure b/configure
>>> index 5ad1674ca5..811bfa5d54 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -956,7 +956,7 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
>>>   # Finish preparing the virtual environment using vendored .whl files
>>>
>>>   $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>>> -     ${source_path}/pythondeps.toml meson || exit 1
>>> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
>>
> 
> Hi John,
> 
> Thanks for reviewing!
> 
>>
>> I haven't read the rest of this series; I'm chiming in solely from the build/python maintainer angle. Do we *always* need pysvd, no matter how QEMU was configured? Adding it to the meson line here is a very big hammer.
>>
> 
> I think the minimum we can do is to install it only if CONFIG_ARM is
> enabled. That might change in the future if the models we create with
> pysvd are enabled for other architectures.

Similarly on how we manage libfdt, you can have meson defines
SVDGEN as:

   config_host_data.set('CONFIG_SVDGEN', svd_gen_header.found())

Then declare SVDGEN in Kconfig.host, and finally use in the Kconfigs:

   config FLEXCOMM_UART
       bool
       depends on SVDGEN

   config RT500
       bool
       depends on ARM
       select FLEXCOMM_UART

See for FDT examples:

$ git grep 'depends on.*FDT'
hw/core/Kconfig:10:    depends on FDT
hw/i386/Kconfig:118:    depends on I386 && FDT
hw/loongarch/Kconfig:4:    depends on LOONGARCH64 && FDT
hw/mips/Kconfig:84:    depends on MIPS64 && !TARGET_BIG_ENDIAN && FDT
hw/ppc/Kconfig:4:    depends on PPC64 && FDT
hw/ppc/Kconfig:29:    depends on PPC64 && FDT
hw/ppc/Kconfig:58:    depends on PPC && FDT
hw/ppc/Kconfig:77:    depends on PPC && FDT
hw/ppc/Kconfig:174:    depends on PPC && FDT
hw/ppc/Kconfig:180:    depends on PPC && FDT
hw/ppc/Kconfig:186:    depends on PPC && FDT
hw/rx/Kconfig:11:    depends on RX && FDT
hw/xtensa/Kconfig:17:    depends on XTENSA && FDT

>> If not, consider looking at how sphinx (the "docs" group) is only conditionally installed into the configure venv and mimic that using the appropriate configure flags that necessitate the availability of pyvsd for the QEMU build.
> 
> Thanks for the pointer, I'll take a look.
> 
>>
>> We also need to provide a way for pysvd to be available offline; some packages are available via distro libs and if this package is available for every distro we officially support, that's sufficient (but requires updates to our various docker and VM test configuration files to add the new dependency). Otherwise, like we do for meson, we need to vendor the wheel in the tree so offline tarball builds will continue to work.
>>
>> It looks like pysvd is a pure python package with no dependencies, so it should be OK to vendor it in qemu.git/python/wheels/ - look at qemu.git/python/scripts/vendor.py and consider updating and running this script.
> 
> Thanks, I'll look at it and add it in v2.
> 
>>
>> (The real blocker here is that RPM builds are performed offline and dependencies that cannot be satisfied via rpm can't be added through pip. We need any one of these to be true: (A) pyvsd is available (of a sufficient version) in all distro repositories we target; (B) This build feature is conditional and nobody minds if it never gets enabled for RPM builds; (C) The package can be vendored.)
>>
>> ~~js
>>
>> That said, you might be the first person I've seen outside of Paolo and I to brave mucking around with the python build venv. You deserve a bravery sticker :)
>>
>>>
>>>   # At this point, we expect Meson to be installed and available.
>>>   # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
>>> diff --git a/meson.build b/meson.build
>>> index ec59effca2..dee587483b 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -3235,6 +3235,10 @@ tracetool_depends = files(
>>>     'scripts/tracetool/vcpu.py'
>>>   )
>>>
>>> +svd_gen_header = [
>>> +  python, files('scripts/svd-gen-header.py')
>>> +]
>>> +
>>>   qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
>>>                       meson.current_source_dir(),
>>>                       get_option('pkgversion'), meson.project_version()]
>>> diff --git a/python/setup.cfg b/python/setup.cfg
>>> index 48668609d3..bc830c541a 100644
>>> --- a/python/setup.cfg
>>> +++ b/python/setup.cfg
>>> @@ -45,6 +45,7 @@ devel =
>>>       urwid >= 2.1.2
>>>       urwid-readline >= 0.13
>>>       Pygments >= 2.9.0
>>> +    pysvd >= 0.2.3
>>>


