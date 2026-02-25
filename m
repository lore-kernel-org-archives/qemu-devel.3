Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1231AF357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9R3-0004tN-VK; Wed, 25 Feb 2026 02:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9R2-0004tD-Lo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:35:52 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9R0-0005C3-GG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:35:52 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 088D180671;
 Wed, 25 Feb 2026 10:35:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55b::1:1] (unknown [2a02:6bf:8080:55b::1:1])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id iZbf3M7Au4Y0-BVashg4A; Wed, 25 Feb 2026 10:35:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772004946;
 bh=9TYDpoesOEc62xZZuvi6taN7y5FA0s9muCfBixPpLeM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QfWgodSvAzA4Z7w+rIEdFoyaSMoXAPRD9mP4XcO+lLgyC2Kh6Vvr9nsRkqiaANPsc
 oEF02KkjHOB5NOEIIwBMiPy9oMW2xu/UcTotKjCnq1IUmsNDJyN22RTtNPqwIpG2HR
 p2vJM/41RTXbxM2fMHkpbcqa8LRW1d39HX/qbo/8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <f2908136-eaea-4760-8711-93cd93e90c81@yandex-team.com>
Date: Wed, 25 Feb 2026 12:35:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] ui/dbus: run without Audio interface when audio
 is disabled
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-8-heifetz@yandex-team.com>
 <CAJ+F1C+Zb-KRBf+bFv2FbVx6Q5P4rKumTZRJ68VC65ZVVWKKNQ@mail.gmail.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <CAJ+F1C+Zb-KRBf+bFv2FbVx6Q5P4rKumTZRJ68VC65ZVVWKKNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2/24/26 16:06, Marc-André Lureau wrote:
> Hi
>
> On Mon, Feb 23, 2026 at 9:26 PM Sergei Heifetz <heifetz@yandex-team.com> wrote:
>> D-Bus display can be used even when QEMU is configured with
>> `--disable-audio`. In that case, audio interface will not be available
>> on `/org/qemu/Display1/Audio`.
>>
> I think it should also disable "audiodev" (from QAPI DisplayDBus etc).
> Or at the minimum, it should return an error if the option is given
> and qemu is compiled with !CONFIG_AUDIO.
OK, I’ll remove `audiodev`, then.
>
>> (The current handling of the situation when audio is enabled but
>> no D-Bus-compatible audio backend is available is different and
>> hasn’t been changed.)
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   ui/dbus.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/ui/dbus.c b/ui/dbus.c
>> index 905ee6fea7..60c8e0b473 100644
>> --- a/ui/dbus.c
>> +++ b/ui/dbus.c
>> @@ -219,6 +219,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>>           return;
>>       }
>>
>> +#ifdef CONFIG_AUDIO
>>       {
>>           AudioBackend *audio_be = audio_get_default_audio_be(NULL);
>>           if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
>> @@ -234,6 +235,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>>               return;
>>           }
>>       }
>> +#endif
>>
>>       consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
>>       for (idx = 0;; idx++) {
>> --
>> 2.34.1
>>
>>
>
> --
> Marc-André Lureau

