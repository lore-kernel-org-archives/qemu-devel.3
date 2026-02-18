Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77E9E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 07:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsc6w-000498-6j; Wed, 18 Feb 2026 02:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsc6s-00048r-6V
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:36:34 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsc6q-000765-8E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 02:36:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 229C7C07AD;
 Wed, 18 Feb 2026 10:36:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:18e::1:1d] (unknown
 [2a02:6bf:8080:18e::1:1d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OaUF9e3Ae4Y0-RSHMIR7P; Wed, 18 Feb 2026 10:36:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771400186;
 bh=TgwamYqIm3jEoCxoyaKmzgorvgu1lRVDGcrYhg5LTlk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=arX8DqJkISGcRlhb0N5VH7/P6kEQjVOP1ZM1WIi7Xj3En5aMKa1naVkAhxUbxV138
 KcdKhARo/0RreYzHsrCtffDomWIqd+MGdnrpb/XGjtPc7kFOxTcwruFo7uAy2MEUez
 tNs8KhJfsLr+IfSv7mhvnzWx/wg7r2iAsPeqTydU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <45f8333e-bee9-4227-9cfa-9fde1d24c834@yandex-team.com>
Date: Wed, 18 Feb 2026 12:36:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-5-heifetz@yandex-team.com>
 <03582d00-0aa7-4a59-b654-3bd6bc92cdb6@redhat.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <03582d00-0aa7-4a59-b654-3bd6bc92cdb6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2/17/26 14:14, Thomas Huth wrote:
> On 17/02/2026 06.27, Sergei Heifetz wrote:
>> PCSPK (PC Speaker) is an embedded audio device. We don't want it to 
>> use audio
>> when QEMU is configured with `--disable-audio`. This is achieved with 
>> minimal,
>> non-invasive changes to the code.
>>
>> In essence, the changes ensure that PCSPK does not use the corresponding
>> audio backend, while functioning the same way in non-audio aspects.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   hw/audio/pcspk.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
>> index 916c56fa4c..03fe816024 100644
>> --- a/hw/audio/pcspk.c
>> +++ b/hw/audio/pcspk.c
>> @@ -36,10 +36,12 @@
>>   #include "qom/object.h"
>>   #include "trace.h"
>>   +#ifdef CONFIG_AUDIO
>>   #define PCSPK_BUF_LEN 1792
>>   #define PCSPK_SAMPLE_RATE 32000
>>   #define PCSPK_MAX_FREQ (PCSPK_SAMPLE_RATE >> 1)
>>   #define PCSPK_MIN_COUNT DIV_ROUND_UP(PIT_FREQ, PCSPK_MAX_FREQ)
>> +#endif
>>     OBJECT_DECLARE_SIMPLE_TYPE(PCSpkState, PC_SPEAKER)
>>   @@ -48,18 +50,25 @@ struct PCSpkState {
>>         MemoryRegion ioport;
>>       uint32_t iobase;
>> +#ifdef CONFIG_AUDIO
>>       uint8_t sample_buf[PCSPK_BUF_LEN];
>> +#endif
>>       AudioBackend *audio_be;
>> +#ifdef CONFIG_AUDIO
>>       SWVoiceOut *voice;
>> +#endif
>>       PITCommonState *pit;
>> +#ifdef CONFIG_AUDIO
>>       unsigned int pit_count;
>>       unsigned int samples;
>>       unsigned int play_pos;
>> +#endif
>
> Could you maybe group the fields that should get disabled together in 
> one #ifdef here? ... AFAIK the order of the fields should not matter, 
> so it should be ok to move them together.
>
>  Thomas
>
Yes, I agree — I don’t see any reason why the order would matter here. I 
just wanted to be extra careful. I’ll change it.

Thanks for reviewing.


