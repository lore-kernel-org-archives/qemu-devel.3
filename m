Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49745C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 17:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taeqE-0006kv-LS; Wed, 22 Jan 2025 12:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taeqC-0006kg-CC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:48:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taeqA-0001ms-73
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 12:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737568111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iRtLiIc7bLfHYJDA11nu7kSwdSV9ePmhSdTJCmL4OuU=;
 b=DqGoSXfx5tym59Q1pvXr4Bie6KTskrmUFWNIOOGFpXAC3H7QH12Qbx9F6BxW7lyt/PiSy3
 R7WyUvM8rGqAGgQby2DEisOxdL5SsMDFhtnEun7W9uVUxPUJMb9shquxaSop5dtQpFRyGZ
 i2eiOyTnjCJHj4+3Syy1HnQU85MY9FA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Fi_edix0M5WwbtdIx78nag-1; Wed, 22 Jan 2025 12:48:29 -0500
X-MC-Unique: Fi_edix0M5WwbtdIx78nag-1
X-Mimecast-MFC-AGG-ID: Fi_edix0M5WwbtdIx78nag
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d899291908so2260676d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 09:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737568109; x=1738172909;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRtLiIc7bLfHYJDA11nu7kSwdSV9ePmhSdTJCmL4OuU=;
 b=JRY0+3lw2dI6Uya1Wx6JrWOx+WpXR9cRwa2dkAxLillurHvG9YAEKrLuuVJGf8dXvs
 Hp0GgMGWEep6MkQseWg2MvWh9v+fv/mykL9jRkbNueDUI+YmN9p91PJdcJbn/z8vaVPC
 Upmx/2UPOHe9a+I+VRrTA7nd0ox3IdjhRCMzBZ/i8i0CiCtChAGoJx+ymz1xG1p4g41E
 RUaZzWWLg6ZDhoGGyNi3nRu3aBdsIC1YOAUKILTZx9D76KN2GdyB5/a5rec/8H9vnOqX
 f5QGtSWqKOiaMFgFuhuzJnSllX2+N4cyQoarMpZKbzqlK/LXUMa3Ee60/+egihcIeOvf
 xGig==
X-Gm-Message-State: AOJu0YxirxTPkJn5tC0sGg5CAKfvzZ0ApGwqzdaWsHD31hNuVGF3oDkZ
 XPUYKnqvn/rWCPz4XxJsTw+BJAKUmGWjYMnFd+E5Y3ad8Kl0+e642QFcZxmyCDuS89MuK+ZIFvK
 0dTVSnUxuplW8kOUxRcEwDD+VED3EPI91ZQCkjXeZtPqRjH5Y3Yqk
X-Gm-Gg: ASbGnctHOYPiscZhq1YXDa5cyF+TT56FQNvOR/QLQdAeYbHhh/lzrWs0TXdxpTCckFj
 ZxBFZqg6Qer/vACuWrZ5tuawXujgTMwjDY77Nz6RRACA+mf+VambLGlFp3HRWADhbHaSgNPPEvO
 8RVdTwf6/d88w8MXca8bMBCnDWSTgpgGDVu40cs3YLG3E4U2d59Lqw214z/+KW9XaBTIyz57DNw
 AHqG2fFltw+QgZsuDLbO0GJ2R/Ed062YARgskvezjbZ4WeNvzOA1CzkJXmM7SK8p0Zxn9FRkgzU
 wFP9sD2qMQ3vyu94s4F01gPkBg==
X-Received: by 2002:a05:6214:5292:b0:6d8:9960:b063 with SMTP id
 6a1803df08f44-6e1b21793acmr375271286d6.14.1737568109422; 
 Wed, 22 Jan 2025 09:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy5D9voaiY+o1BbQ+UAcFo7tR0ofOx4ONXFSzJp63w8UC25hdZt2t6u4kosFTrzwmIVmWSfg==
X-Received: by 2002:a05:6214:5292:b0:6d8:9960:b063 with SMTP id
 6a1803df08f44-6e1b21793acmr375270996d6.14.1737568109130; 
 Wed, 22 Jan 2025 09:48:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf2dd7sm62908726d6.3.2025.01.22.09.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 09:48:28 -0800 (PST)
Message-ID: <158bcde5-0be1-486b-b066-e7b25c4747f1@redhat.com>
Date: Wed, 22 Jan 2025 18:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix the aarch64_tcg_plugins test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250122091517.1429734-1-thuth@redhat.com>
 <87ed0un47k.fsf@draig.linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87ed0un47k.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/01/2025 18.33, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Unfortunately, this test had not been added to meson.build, so we did
>> not notice a regression: Looking for 'Kernel panic - not syncing: VFS:'
>> as the indication for the final boot state of the kernel was a bad
>> idea since 'Kernel panic - not syncing' is the default failure
>> message of the LinuxKernelTest class, and since we're now reading
>> the console input byte by byte instead of linewise (see commit
>> cdad03b74f75), the failure now triggers before we fully read the
>> success string. Let's fix this by simply looking for the previous
>> line in the console output instead.
>>
>> Also, replace the call to cancel() - this was only available in the
>> Avocado framework. In the functional framework, we must use skipTest()
>> instead.
>>
>> Fixes: 3abc545e66 ("tests/functional: Convert the tcg_plugins test")
>> Fixes: cdad03b74f ("tests/functional: rewrite console handling to be bytewise")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                 | 1 +
>>   tests/functional/test_aarch64_tcg_plugins.py | 6 +++---
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 5457331643..e0a276f349 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -72,6 +72,7 @@ tests_aarch64_system_thorough = [
>>     'aarch64_sbsaref',
>>     'aarch64_sbsaref_alpine',
>>     'aarch64_sbsaref_freebsd',
>> +  'aarch64_tcg_plugins',
> 
> The test only takes a few seconds to run so maybe it can go in the basic tests?

Unfortunately no, the quick category is reserved for the tests that don't 
need to download any assets, and this one here is downloading some stuff.

>>     'aarch64_tuxrun',
>>     'aarch64_virt',
>>     'aarch64_xlnx_versal',
>> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
>> index 01660eb090..357eb48477 100755
>> --- a/tests/functional/test_aarch64_tcg_plugins.py
>> +++ b/tests/functional/test_aarch64_tcg_plugins.py
>> @@ -46,7 +46,7 @@ def run_vm(self, kernel_path, kernel_command_line,
>>           except:
>>               # TODO: probably fails because plugins not enabled but we
>>               # can't currently probe for the feature.
>> -            self.cancel("TCG Plugins not enabled?")
>> +            self.skipTest("TCG Plugins not enabled?")
> 
> We can be more explicit now, something like:
> 
>          try:
>              vm.launch()
>          except VMLaunchFailure as excp:
>              if "plugin interface not enabled in this build" in excp.output:
>                  self.skipTest("TCG plugins not enabled")
>              else:
>                  self.log.info(f"unhandled launch failure: {excp.output}")
>                  raise excp

Ok, good idea, I can respin a v2 with that included.

  Thomas


