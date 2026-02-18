Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364EAE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdYJ-0006R2-4n; Wed, 18 Feb 2026 04:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsdYA-0005ii-O3
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:50 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsdY6-0002bk-5b
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:08:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E55B680B3E;
 Wed, 18 Feb 2026 12:08:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:18e::1:1d] (unknown
 [2a02:6bf:8080:18e::1:1d])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id d8WeSd3A94Y0-zBrC2Y35; Wed, 18 Feb 2026 12:08:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771405721;
 bh=h4tALshQAb+1ocBp08bQe/VMk2WzGNQe6aBxwP0IqCw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lnFUzw/8HW7b8oMhLAiIM7r1FWeluV21gtbhsJyhZEsPrULBGvwMACn2z0u7YWTB7
 OSlIHdYU9UMFkdRfrt0DIBrkIbWjidHqGYLsT5j9JSf+RU/fh1kR4jKLVemDJLTBxE
 zgR1t6uUMqjPF3No79/zK1VIos3qNU1lVn4FxnHk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <baf33285-850f-4a44-8b02-651df060a451@yandex-team.com>
Date: Wed, 18 Feb 2026 14:08:39 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] audio: do not build audio-related sources with
 --disable-audio
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-8-heifetz@yandex-team.com>
 <146c95fd-00f2-4b51-bda5-249dd768a719@redhat.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <146c95fd-00f2-4b51-bda5-249dd768a719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/17/26 14:49, Paolo Bonzini wrote:
> On 2/17/26 06:27, Sergei Heifetz wrote:
>> When QEMU is configured with `--disable-audio`, do not build any
>> audio-related sources.
>>
>> - audio/meson.build and replay/meson.build:
>>    Exclude audio-related sources when audio is disabled.
>>
>> - audio/audio-stub.c:
>>    Provide a minimal set of straightforward stubs.
>>
>> - replay/replay-audio-stub.c:
>>    Move the existing stubs from replay/stubs-system.c into a separate
>>    file.
>>
>> - qapi/audio.json:
>>    Remove the QMP `query-audiodevs` command.
>>
>> - audio/audio-hmp-cmds-stub.c:
>>    Provide meaningful messages for audio-related HMP commands:
>>    stopcapture, wavcapture, info capture.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   audio/audio-hmp-cmds-stub.c | 28 ++++++++++++++++++++++++++++
>
> Can you remove the commands instead?
>
Yes, sure.
>> +AudioBackend *audio_be_by_name(const char *name, Error **errp)
>> +{
>> +  error_setg(
>> +      errp,
>> +      "trying to find audiodev '%s' by name with audio component 
>> disabled",
>
> This can be simplified to just  'audio disabled' or something like that.
Ok.
>
>> +      name);
>> +  return NULL;
>> +}
>> +
>> +const char *audio_be_get_id(AudioBackend *be) { return ""; }
>
> Can you instead compile out qdev_prop_audiodev?
I think so. I'll try it.
>
>> +bool audio_be_set_dbus_server(AudioBackend *be,
>> +                              GDBusObjectManagerServer *server, bool 
>> p2p,
>> +                              Error **errp)
>> +{
>> +  error_setg(errp, "trying to set dbus server with audio component 
>> disabled");
>
> Since this requires an AudioBackend, which you cannot get with audio 
> disabled, it can be simply abort().
That's reasonable, I'll replace it with abort().
>
>> +if audio_enabled
>> +  system_ss.add(when: 'CONFIG_TCG',
>> +  if_true: files('replay-audio.c'),
>> +  if_false: files('replay-audio-stub.c'))
>> +else
>> +  system_ss.add(files('replay-audio-stub.c'))
>> +endif
>
> I think this can be simply
>
>   system_ss.add(when: ['CONFIG_TCG', 'CONFIG_AUDIO'],
>      if_true: files('replay-audio.c'),
>      if_false: files('replay-audio-stub.c'))
>
> but I may be incorrect.
>
I’ve already tried it, and it doesn’t work for some reason.
> Paolo
>
Thank you for reviewing and for participating in the discussion about 
the series. I probably wouldn’t have been able to summarise the points 
as clearly myself.


