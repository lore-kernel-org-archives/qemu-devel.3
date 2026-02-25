Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB74F357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9US-0006TU-0d; Wed, 25 Feb 2026 02:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9UQ-0006TI-Ih
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:39:22 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9UO-0005dy-Co
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:39:22 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ED609808A9;
 Wed, 25 Feb 2026 10:39:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55b::1:1] (unknown [2a02:6bf:8080:55b::1:1])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EdbTAM7An8c0-KUqmQBPA; Wed, 25 Feb 2026 10:39:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772005156;
 bh=QaQh5iMiXmJog/kDCntmOvBOndb0Vif1vRPL+kUgHHY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=23MrIacxydA0peDdM+utYv6r5cNLe2wXqI9Mtamse+0tRN05S1tRfQvO/Q+knddrB
 t2aWbBS17F/05/oEjNT/wOR6LZJSO1i+BPoyQ7L0NNzj3y5KMqM929u3po9j/zus0g
 tGkpdS0ppAQW+fTrg76fQapU0+wijjs+jBawJ7T8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <fdf9519d-9382-442e-8ae9-260fdd1d4c69@yandex-team.com>
Date: Wed, 25 Feb 2026 12:39:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] system/vl: remove audio and audiodev options
 when audio is disabled
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
 <20260223202512.1308205-7-heifetz@yandex-team.com>
 <CAJ+F1CKEjT741GHZP5HJSKYSW93K7iROmAiVS-oPJmL+J3Bujw@mail.gmail.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <CAJ+F1CKEjT741GHZP5HJSKYSW93K7iROmAiVS-oPJmL+J3Bujw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>> Remove the audio and audiodev runtime options when QEMU is configured
>> with `--disable-audio`.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> This change should also modify qemu-options.hx
Oh, yes, of course. I somehow forgot about this.

Thank you for all the feedback.
>
>> ---
>>   system/vl.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 3e341142a0..1034a4688f 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2248,7 +2248,9 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>   static bool is_qemuopts_group(const char *group)
>>   {
>>       if (g_str_equal(group, "object") ||
>> +#ifdef CONFIG_AUDIO
>>           g_str_equal(group, "audiodev") ||
>> +#endif
>>           g_str_equal(group, "machine") ||
>>           g_str_equal(group, "smp-opts") ||
>>           g_str_equal(group, "boot-opts")) {
>> @@ -2265,6 +2267,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
>>           object_option_add_visitor(v);
>>           visit_free(v);
>>
>> +#ifdef CONFIG_AUDIO
>>       } else if (g_str_equal(group, "audiodev")) {
>>           Audiodev *dev = NULL;
>>           Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(dict));
>> @@ -2272,6 +2275,7 @@ static void qemu_record_config_group(const char *group, QDict *dict,
>>               audio_add_audiodev(dev);
>>           }
>>           visit_free(v);
>> +#endif
>>
>>       } else if (g_str_equal(group, "machine")) {
>>           /*
>> @@ -3057,6 +3061,7 @@ void qemu_init(int argc, char **argv)
>>                   }
>>                   break;
>>   #endif
>> +#ifdef CONFIG_AUDIO
>>               case QEMU_OPTION_audiodev:
>>                   default_audio = 0;
>>                   audio_parse_option(optarg);
>> @@ -3097,6 +3102,7 @@ void qemu_init(int argc, char **argv)
>>                   }
>>                   break;
>>               }
>> +#endif
>>               case QEMU_OPTION_h:
>>                   help(0);
>>                   break;
>> --
>> 2.34.1
>>
>>
>
> --
> Marc-André Lureau

