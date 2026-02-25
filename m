Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD4F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9N3-0003Jr-Lo; Wed, 25 Feb 2026 02:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9Mr-0003JO-Md
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:31:34 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9Mq-0004bh-8O
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:31:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A29F980BEC;
 Wed, 25 Feb 2026 10:31:30 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55b::1:1] (unknown [2a02:6bf:8080:55b::1:1])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SVbQqX7A6uQ0-F5q7wDl9; Wed, 25 Feb 2026 10:31:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772004690;
 bh=afDYuBSzDLXR/dQsRNw6qEJlW9wcjwk9xAVc9IiZIsE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xdVECnPD0VMMl+lU91N7Bgp7S7ZK9QSc6i4rW/ZLVUN5JCGRtk9A8hQWFeMd3adaJ
 VlgIMItQUAby7pvJjnn7DPY5JdAtSHHbzWFQQf3P04qSmHNauNZ1EfZVKYdgbj2dup
 +ZiNTOFnfsJhAZW+3/aarwiJzANGjkj2+4YxNx4g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <5290a215-653f-424d-bbce-b0acfa5adb55@yandex-team.com>
Date: Wed, 25 Feb 2026 12:31:28 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] tests/qtest: remove -audio none when configured
 with --disable-audio
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
 <20260223202512.1308205-4-heifetz@yandex-team.com>
 <CAJ+F1CKvBQ4DGAXW16KU9gP5Vo4Y2DJGOqaEE6L_D6Hd8wDFzA@mail.gmail.com>
Content-Language: en-US
From: Sergei Heifetz <heifetz@yandex-team.com>
In-Reply-To: <CAJ+F1CKvBQ4DGAXW16KU9gP5Vo4Y2DJGOqaEE6L_D6Hd8wDFzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
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

On 2/24/26 16:05, Marc-André Lureau wrote:
> Hi
>
> On Mon, Feb 23, 2026 at 9:27 PM Sergei Heifetz <heifetz@yandex-team.com> wrote:
>> It does not matter much whether `-audio none` is passed. In the future,
>> support for `-audio none` with `--disable-audio` will be dropped, so we
>> should remove it beforehand.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tbh, I feel like we could still allow "-audio none" for compatibility
> reasons, even if compiled without CONFIG_AUDIO. But "-audio none" does
> not mean "no audio"! it's actually the "none" backend, so better to
> remove "-audio" altogether indeed. It may be worth explaining that in
> the commit message.
>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>
Yes, that was my reasoning as well. I’ll explain it in the commit message.
>
>> ---
>>   tests/qtest/libqtest.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 794d870085..adb968f40e 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -464,7 +464,9 @@ gchar *qtest_qemu_args(const char *extra_args)
>>                         "-chardev socket,path=%s,id=char0 "
>>                         "-mon chardev=char0,mode=control "
>>                         "-display none "
>> +#ifdef CONFIG_AUDIO
>>                         "-audio none "
>> +#endif
>>                         "%s"
>>                         "%s"
>>                         " -accel qtest",
>> --
>> 2.34.1
>>
>>
>
> --
> Marc-André Lureau

