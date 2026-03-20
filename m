Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C503C1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3asL-000298-7J; Fri, 20 Mar 2026 10:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3asJ-00028Y-Nl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:30:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <califano.tommaso@gmail.com>)
 id 1w3asI-0000LJ-50
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:30:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso556927f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017052; x=1774621852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwkmTF/CS0VyDJVC1u/aIvu2tt3/nzhHfvzUfjsv28s=;
 b=heQtI3+98jCLctz6+igpXhOf+ZMopTQ3HPRXmOkwHVrE3Xxegpm/cjUT2r7JS03+81
 dZMUn/4wjmVNeezLwtgei7u5/+S0vJEE9YxUic+2sUzOF+hWXIgMOrYZxdwShHh95vDw
 TxYXcTXuDOOfEQ2CAgrDfbgsckvDlK/R/3egomCv/YYEXvAIp+CIZvGTBeS6JhZRu3Lz
 X1/8fT2dGR+q+tvVJSQTFhJ8+dZCVWb2HUqW5jcamgsS9BcF3UopyxmiFflU9byrjxVI
 yzhyG3kx0IguJh3uEjfSe8AtYLdmLDfg+BlLkoNhmJyhQ8KtxWBFM9KWYp4xSw4UmhrU
 iGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017052; x=1774621852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rwkmTF/CS0VyDJVC1u/aIvu2tt3/nzhHfvzUfjsv28s=;
 b=aw+w6TB4mUFGj7CmOY9WfBfuzIzGtvJWsephrM8i57jKGZiwXdxeWO+T6w3x3QCK3V
 SUIprzqP4DYqtDM8QIPuXD8URnGXjSxv/XxYiM1TT7/pA1QVFGAdcLJLyQNvMoHSNuqO
 LHB3IbjB3dk/k3LvQC18yRUgUGrfIu5yHdfmXSYoLJEnbHzP4uPm03alV3+06T/RllDL
 YLH+ITx3KQkICqtsey7bnLp29k6HLjkEPt5hBBdcAc8pjmqKaLXoolU8PeMMib9pK8zj
 Dd+mBe+4T9uhq9Nu8iIzhv9xc9GZHSlEAuSFbwMfxnuoQHaaURnkmYMsgaKRHjvMDPDI
 tcdA==
X-Gm-Message-State: AOJu0YxbrdVka0FZ9aYz2kvTMdlZz0C35ir4na13cdE8IB5oJ/3k8BKA
 93nLu8ZmEnHjulleo2BAj2SOltGP4vHBaIVHgv6N8cAtS52mDISO1VtQ
X-Gm-Gg: ATEYQzwyxJZjLmB0wyJ3eXNvU0EeWc6HnpWcMJ8+Ty+cRh2cCG6he0nnY55jKTenvvT
 AMQHHSdMLmh4772Aw2dpPfvAjtxp7+6BRE4R6tUFZJRZrGlH/maWF3ll7qydtA00AaTs3IXTGp9
 1O4loFECv+kjiV2siWM+m/pujkl8M4kvhGAT0UwLkCh/rzeSTo5UWNIo8zMeUjYKGlyKLUOCp+J
 YRWnSQ+SiCkw1lG0t8+DOxJihVOITLDIWO044s3OdLGlreeUnwlqOgWk8VSErpYg4bA1kJM1Fny
 K7nWY5jLpp9j19CXZ0GoN0Je1P5nG9BBIwN+JymT2byEALJWuN9OpqZrk5zzAy680OWnQPb/fcX
 cED5O2uZOhA0qTJ2ZYH1tAE5hrsDo+svBSP2VptcBdRKTl8y6cHOP9k856KRA9Kv0RfXu67vW3s
 m3fyesFOT+b/cIZj933d4L8PpIq8fVDdsiXLafEHVcu5Ku0kDsXHlzKX4V
X-Received: by 2002:a05:6000:2010:b0:43b:4ec7:f924 with SMTP id
 ffacd0b85a97d-43b64264073mr5799774f8f.34.1774017052225; 
 Fri, 20 Mar 2026 07:30:52 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c35sm7227678f8f.22.2026.03.20.07.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 07:30:51 -0700 (PDT)
Message-ID: <71a496c8-9fbc-467e-bd5c-a82142ba558b@gmail.com>
Date: Fri, 20 Mar 2026 15:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i386/sev: Add launch measurement emulation and TIK
 property
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-5-califano.tommaso@gmail.com>
 <87pl50vw14.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <87pl50vw14.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=califano.tommaso@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Il 19/03/26 13:33, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> The next step for completing the SEV launch emulation is to implement the
>> "query-sev-launch-measure" feature, responsible for returning the
>> measurement. In this case the measurement will be computed in QEMU.
>>
>> Implement sev_emulated_launch_get_measure() to emulate the LAUNCH_MEASURE
>> command per AMD SEV API spec section 6.5.1. It generates a random 16-byte
>> mnonce, computes the launch digest as SHA-256 over ld_data, then derives
>> the measurement via HMAC-SHA256
>> (TIK;0x04|| API version || build ID || policy || launch digest || mnonce).
>> The base64-encoded result (32-byte HMAC + 16-byte mnonce) populates
>> "query-sev-launch-measure" data, advancing state to LAUNCH_SECRET for
>> secret injection.
>>
>> The TIK is supplied via 16-byte binary file specified in new
>> SevEmulatedProperty "tik" path; absent this, keys default to zeroed.
>> Example QEMU arguments with the key passed:
>>
>> 	-cpu "EPYC-Milan" \
>> 	-accel tcg \
>> 	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
>> 					tik=/path/to/tik.bin \
>> 	-machine memory-encryption=sev0
>>
>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>> ---
>>  qapi/qom.json     |   3 +-
>>  target/i386/sev.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 35cda819ec..affb5024b5 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1064,11 +1064,12 @@
>>  # This object functionally emulates AMD SEV hardware via TCG, so
>>  # it does not require real hardware to run.
>>  #
>> +# @tik: binary file of the SEV TIK (default: all 0).
> 
> Is this a file name?
> 

Yes, I'll specify it better writing "Path to the binary file..."

> Blank line here, please.
> 

I'll add it.

>>  # Since: 10.1.0
>>  ##
>>  { 'struct': 'SevEmulatedProperties',
>>    'base': 'SevGuestProperties',
>> -  'data': {}}
>> +  'data': {'*tik': 'str'}}
>>  
>>  ##
>>  # @SevSnpGuestProperties:
> 
> [...]
> 

Best regards,
Tommaso Califano

