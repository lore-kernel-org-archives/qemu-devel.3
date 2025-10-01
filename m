Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2245ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wH6-0005Mr-7V; Wed, 01 Oct 2025 08:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3wGv-0005Kb-Uq
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3wGm-0006Gl-Qv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759322953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xBvUacTQKPCTsZyq4AnsGAkR0CCCM4sjuH7l9mVztAg=;
 b=dWs0QBcqLq96NwcpLTh3aExkHQAM1a0eSGuC7j/dzTm7P4g4QhTZCUg3dm9BNhfRsI/teS
 VRELF16RdwGvsHxOpt7CCd2/w66XJq/mapo4xk65i87bTPV0Gv1WZNLYNWJJ3n/bciqceS
 o4RHOHbK6TReAogXc+QA0By6VfXyfjQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-j-hjSi1TOf6_7l-lDj36vA-1; Wed, 01 Oct 2025 08:49:11 -0400
X-MC-Unique: j-hjSi1TOf6_7l-lDj36vA-1
X-Mimecast-MFC-AGG-ID: j-hjSi1TOf6_7l-lDj36vA_1759322951
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634cdb5d528so986139a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 05:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759322950; x=1759927750;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBvUacTQKPCTsZyq4AnsGAkR0CCCM4sjuH7l9mVztAg=;
 b=be6qtdmCnDHScZ29QdZ2G/glaH/DMQmbYZ3HXmxg+4l8KteJseFPga4BEamxKRbiXN
 B2zG197BWS8MJXCtYs+yQ0WHoi8Itb/E786dqYsYyfkLfiJeadUhxJm9sbikeSXMBH0q
 yLzk2za1e2kVWkzLvRbmgaYSfJuLCZ6jUd6rbXEX/sPXZtE2CjvSRpQ+NPa90XxEUAoM
 UmMfbK5PSDYNOYsh/bdkLfxuVcN1XpldUxaG+enC59I5Mu5HaV6xwfCwsJK7HKkwXIya
 HrWU12T7pTeEXTfs48cE7swcadsgeyDPIZF2IUdCr9cwyUuR0hiaUVCWrXLhd7ir5x8b
 1NSw==
X-Gm-Message-State: AOJu0YyIrhQlCXJeNDpfT0rkjLn1ijmPq2u4CXH3QrxYTYoQKwNnV2Ja
 Uzc9a6elhJKFCrJupky5Y85w1l1zKQEMMaG+Kp7LfdvGq8KirX46t4jkp8Z/SCO2ldqd1xGEIr9
 I0wBGrxXpeJjXvjg1+zL6J3otSfARRZ0ylc0IotJfCizCL6GhOcr6+uby
X-Gm-Gg: ASbGnctKN1OlRvpeSaYXDDkX1Pl6MM+a6n4rnV9VdHLi6A2TDvNBABWTxaMbFEAzMf+
 ZV8Qij9PR4rgRiOlS8r3uPXObl/l7I4jnV0TpUUfjO0K2enSTm2emFyygJ5TpCVmpYqCOTxwuOX
 BFXT8bgVemWQs93zH37MKQ/y3i3TGNZAUHHCwwrL9vvyfPg9TKOBbcylWA64x6KKtN8y89UyM4P
 0VnIpgZ0XHU2H8KuOmKdYGljgQRlZduBLxaeTtjRWhGDywkrtoaTKYWYY8a5+u8iliaa7Y2cQmM
 iQoy5s+/tAHPMaXSZBm01+ZeBp96SP9wd+l+WJ31c4TAcVF1H/Av4Vo3B2Z38lgGPREZTjPX6/9
 WHU4hOGBxSI8QOrhsLrKiUEQC2fJ3mw2lYLfl5IRtDJQ62RKIimo=
X-Received: by 2002:aa7:cc02:0:b0:62f:2b4a:fb34 with SMTP id
 4fb4d7f45d1cf-6365af8a867mr6317184a12.14.1759322950585; 
 Wed, 01 Oct 2025 05:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVRldyCr0N7VtAp86I3ZNzvAWhA9Jan81fcvxKPU/lIQpuAtAblzrEVAvUjWAvSphcObNx3w==
X-Received: by 2002:aa7:cc02:0:b0:62f:2b4a:fb34 with SMTP id
 4fb4d7f45d1cf-6365af8a867mr6317166a12.14.1759322950146; 
 Wed, 01 Oct 2025 05:49:10 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-634bc5e724fsm9703417a12.12.2025.10.01.05.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 05:49:09 -0700 (PDT)
Message-ID: <be2e1f53-f5a4-40d1-817b-cfe9a2e6b0f8@redhat.com>
Date: Wed, 1 Oct 2025 14:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/27] target/i386/mshv: Add x86 decoder/emu
 implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
 <aN0JmdP6tEwzpsDB@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aN0JmdP6tEwzpsDB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/1/25 12:59, Daniel P. Berrangé wrote:
> On Tue, Sep 16, 2025 at 06:48:23PM +0200, Magnus Kulke wrote:
>> The MSHV accelerator requires a x86 decoder/emulator in userland to
>> emulate MMIO instructions. This change contains the implementations for
>> the generalized i386 instruction decoder/emulator.
>>
>> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> ---
>>   include/system/mshv.h           |  25 +++
>>   target/i386/cpu.h               |   2 +-
>>   target/i386/emulate/meson.build |   7 +-
>>   target/i386/meson.build         |   2 +
>>   target/i386/mshv/meson.build    |   7 +
>>   target/i386/mshv/x86.c          | 297 ++++++++++++++++++++++++++++++++
>>   6 files changed, 337 insertions(+), 3 deletions(-)
>>   create mode 100644 include/system/mshv.h
>>   create mode 100644 target/i386/mshv/meson.build
>>   create mode 100644 target/i386/mshv/x86.c
>>
> 
>> diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
>> new file mode 100644
>> index 0000000000..8ddaa7c11d
>> --- /dev/null
>> +++ b/target/i386/mshv/meson.build
>> @@ -0,0 +1,7 @@
>> +i386_mshv_ss = ss.source_set()
>> +
>> +i386_mshv_ss.add(files(
>> +  'x86.c',
>> +))
>> +
>> +i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
> 
> FYI, we expect the SPDX-License-Identifier to be present on
> all new files[1] added to git, even if they're relatively simple
> in some cases like this meson.build.
> 
> If you run the series though checkpatch.pl it should tell
> you which files you've missed.

I'll handle this when applying.

Paolo


