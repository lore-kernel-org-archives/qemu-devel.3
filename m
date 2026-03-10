Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB74EB1078
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyyy-0000Xe-DU; Tue, 10 Mar 2026 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyyw-0000XK-OC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:26:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzyyu-00046N-Ut
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:26:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso25660875e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773156407; x=1773761207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gMvEb/7HJmai+atFAOI9cWahvkksIXvdfhkp5lXJilw=;
 b=vRmxpque4RzCLwAMgElLvXtjDZE4WjiQ7yBkBfxoUN2z5s8hr4S2IppvWuKQAm53R4
 3fd1nz9n/Md0AqtVLwGXVXvU2d55ST0YY3eCIi1ZR655KBVvPn3BQok7U/8oC3mN8O33
 gZnX/lkp78TdNZNaLLB+urBtOsOjxCAa1XPDFmigA2+X9t1lYET+ELaDcJznt7EF2BO4
 cXmQJPIoJMQ1ZLFCDA9S5X1+G98ld/Rt6NO7xsRdmkZqZaR2LRY9GKZoROIsxmOZl7Ee
 fzrqLZoyit+tLPSmSGw2wefusMvtt3J30+1fcu62L61bOWxiyMeZnY4AlELVQgb92yKX
 99VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156407; x=1773761207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gMvEb/7HJmai+atFAOI9cWahvkksIXvdfhkp5lXJilw=;
 b=hEixIFobrfSqAmcoxBQeYcFYj2xPhWd2DK6+mHLOrYO/x2cJROS5XImFyIp7veV3E2
 Sgtlnn2MALepNEDSHKW6lcScbxsksLYdlO0QIhdXQ/jsk9gkds/ji3hN0xUbR6m1jVld
 fCRO2aQMhqDdzGqNaSRJMQ5USe1iBln3MlrEN0bcMeTlT+hRWAhlaHmjvZyR5adJgC2M
 idNzGaGiliFUeZe4MaKPNGlBynewemLUzeDVij7xtkbqPnLKlfkIoN4NJvYI7Hijv506
 9HmiN8HJXbTUMTp4F74geoYm5lNJFlMLDC0Yyf0ifawcPIuNARsjCCm5SKUzDp7pYZ/0
 KVcQ==
X-Gm-Message-State: AOJu0YyNG3RfGZelUYp++VdgW5QDcSpSmdS3KCsd7oqZxdpqwQllmwCg
 O8rwIr5XIiw5Csu538TD8ZVXyGKwe/h/a60KjT//eco8tpCYcFbJe9xaCC0h+HDYM/4=
X-Gm-Gg: ATEYQzzSbgKmpFx9o6n4vHBteUCSN7NwkjenXPzpEGOTrnJkIYKSetf+FXBO310QXq9
 ThtO8ydpjbYpI/d1l54kBONCLutTVS1+xDTf4NpYuidZZNzneR7zwAzCom/W8witV2T2sHe0CsM
 4Mv0S/LJz1yPTPYJ7jYqOIkYl5fskWgxA+nAKd07L5GuB0J83IZ7EhByQH/s+Y2P7/IIFdy8qm2
 yrno6XoEIrhXvDhNUO1n+uT8YKmKDGuoTFwhSPqlNgGHkKgrftJm+sMTJXc5gFQwY086lSv9qCK
 EVl3g8mNhGzzwx5JQ5v4XvM2N5s4F5ek78RT00M5MhA1z9tB3h3bWAKxUuEsYCe8DTeJJ+LZE81
 p255CAYE8ULMGQFrGyLbdAlbUOTK/mC/MXvT5+xLx9YJoLcrhFwLtEV6L1wXcTko3Cegl0ovQuC
 1TE0+U5LrSJo2OIjoJ8InjYjvNLkrK95swEdg/LheQxxXETaURmI8HMPBhrESdG8SMSg==
X-Received: by 2002:a05:600c:1d04:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-485419a286cmr65170175e9.4.1773156406685; 
 Tue, 10 Mar 2026 08:26:46 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237e8095sm223612175e9.2.2026.03.10.08.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 08:26:45 -0700 (PDT)
Message-ID: <9ca4f877-c66b-456d-b9be-fced0241ff73@linaro.org>
Date: Tue, 10 Mar 2026 16:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-5-philmd@linaro.org>
 <aaRD95XwtmZEZv8B@ZEVORN-PC.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aaRD95XwtmZEZv8B@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 1/3/26 15:05, Chao Liu wrote:
> Hi Philippe,
> 
> On Fri, Feb 27, 2026 at 11:43:14AM +0100, Philippe Mathieu-Daudé wrote:
>> gdb_static_features[] only contains strings, nothing target-specific.
>> Instead of generating one file per target, generate a single file
>> with a single gdb_static_features[] array.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build                               | 14 --------------
>>   stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
>>   gdbstub/meson.build                       | 21 +++++++++++++++++++++
>>   stubs/meson.build                         |  2 --
>>   4 files changed, 21 insertions(+), 16 deletions(-)
>>   rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
>>
>> diff --git a/meson.build b/meson.build
>> index 56a746fed00..875a0bb1999 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4221,7 +4221,6 @@ if have_rust
>>   endif
>>   
>>   
>> -feature_to_c = find_program('scripts/feature_to_c.py')
>>   rust_root_crate = find_program('scripts/rust/rust_root_crate.sh')
>>   
>>   if host_os == 'darwin'
>> @@ -4301,19 +4300,6 @@ foreach target : target_dirs
>>       endif
>>     endif
>>   
>> -  if 'TARGET_XML_FILES' in config_target
>> -    gdbstub_xml_files = []
>> -    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
>> -      gdbstub_xml_files += 'gdbstub/gdb-xml/' + gdbstub_xml
>> -    endforeach
>> -    gdbstub_xml = custom_target(target + '-gdbstub-xml.c',
>> -                                output: target + '-gdbstub-xml.c',
>> -                                input: files(gdbstub_xml_files),
>> -                                command: [feature_to_c, '@INPUT@'],
>> -                                capture: true)
>> -    arch_srcs += gdbstub_xml
>> -  endif
>> -
>>     if target in config_target_info
>>       arch_srcs += config_target_info[target]
>>     else
>> diff --git a/stubs/gdbstub.c b/gdbstub/gdb-xml-stub.c
>> similarity index 100%
>> rename from stubs/gdbstub.c
>> rename to gdbstub/gdb-xml-stub.c
>> diff --git a/gdbstub/meson.build b/gdbstub/meson.build
>> index 15c666f5752..a25a5ae9fbf 100644
>> --- a/gdbstub/meson.build
>> +++ b/gdbstub/meson.build
>> @@ -4,6 +4,27 @@
>>   # types such as hwaddr.
>>   #
>>   
>> +gdbstub_xml_files = []
>> +foreach target : target_dirs
>> +  config_target = config_target_mak[target]
>> +  if 'TARGET_XML_FILES' in config_target
>> +    foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
>> +      gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
> Many XML files are shared across multiple targets. For example,
> arm-core.xml appears in 5 targets (arm-softmmu, arm-linux-user,
> arm-bsd-user, armeb-linux-user, arm-softmmu), riscv-64bit-fpu.xml
> in 5 targets, etc.
> 
> Since there is no deduplication here, feature_to_c.py will receive
> duplicate input files and generate duplicate GDBFeature entries in
> gdb_static_features[]. While gdb_find_static_feature() does a
> first-match linear scan so it won't break, it unnecessarily bloats
> the binary.
> 
> Consider adding a dedup check:
> 
> ```
>      if not gdbstub_xml_files.contains('gdb-xml/' + gdbstub_xml)
>        gdbstub_xml_files += 'gdb-xml/' + gdbstub_xml
>      endif
> ```

Great suggestion, thanks!

> 
> I tested this by actually running feature_to_c.py with the collected
> XML files:
> 
> ==Without deduplication:==
> - Total references: 171
> - Unique files: 60
> - Duplicates: 111 (64.91%)
> - Generated file: 669 KB, 17,777 lines
> - Example: arm-core.xml appears 5 times at lines 1527, 2705, 3276, 3847, 4418
>    (each occurrence is 2400 bytes of identical code)
> 
> ==With deduplication:==
> - Generated file: 244 KB, 6,243 lines
> - Space saved: 425 KB (63.57% reduction)
> - No duplicate entries
> 
> ---
> 
> Everything else looks good to me.
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Thanks,
> Chao
>> +    endforeach
>> +  endif
>> +endforeach
>> +if gdbstub_xml_files.length() > 0
>> +  feature_to_c = find_program('../scripts/feature_to_c.py')
>> +  gdbstub_xml = custom_target('gdbstub-xml.c',
>> +                              output: 'gdbstub-xml.c',
>> +                              input: files(gdbstub_xml_files),
>> +                              command: [feature_to_c, '@INPUT@'],
>> +                              capture: true)
>> +else
>> +  gdbstub_xml = files('gdb-xml-stub.c')
>> +endif
>> +common_ss.add(gdbstub_xml)
>> +
>>   # We build two versions of gdbstub, one for each mode
>>   user_ss.add(files(
>>     'gdbstub.c',
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 8a07059500d..1e0f6f47377 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -89,8 +89,6 @@ if have_system
>>   endif
>>   
>>   if have_system or have_user
>> -  stub_ss.add(files('gdbstub.c'))
>> -
>>     # Also included in have_system for --disable-tcg builds
>>     stub_ss.add(files('replay.c'))
>>   
>> -- 
>> 2.52.0
>>
>>


