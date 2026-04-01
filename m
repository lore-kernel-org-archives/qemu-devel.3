Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2729210FCADC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82i8-0006Sf-KM; Wed, 01 Apr 2026 17:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w82i6-0006SH-L7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:02:46 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w82i3-0008DH-HN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:02:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 906098084A;
 Thu, 02 Apr 2026 00:02:36 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:42a::1:b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Y2jre50LIa60-SiQ08sZY; Thu, 02 Apr 2026 00:02:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775077356;
 bh=a0qXD0BRkmULIXgGZZm60R+bqcDE+kdNGO5S3+ojn6A=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=al0AtOQ8Jukv4Z1uyX3q5Clqaxc+k93k+NKSVWBfGuiqzhOaIGdsNVFOUgYLA5tm4
 oKzuDIM2dikU6cF532jYlxyeSJoV8E17e2HCf9jidXn1z1BfMYhDk2yHqYkaZCUbvB
 xfDA9ik3DdiBHMm5RgV9nUG5WpYzxrV/jZ101c2Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 02:02:34 +0500
Message-Id: <DHI4EN57FYTJ.3M2PPEKA08JIA@yandex-team.com>
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Eric Blake" <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Markus Armbruster"
 <armbru@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Laurent
 Vivier" <lvivier@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>
Subject: Re: [PATCH v3 08/11] tests/audio: do not compile if audio is disabled
X-Mailer: aerc 0.20.1-262-gc2819a603771-dirty
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-9-heifetz@yandex-team.com>
 <37430b6a-6e11-4154-b784-61d3cbca5875@linaro.org>
In-Reply-To: <37430b6a-6e11-4154-b784-61d3cbca5875@linaro.org>
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

On Wed Apr 1, 2026 at 3:10 PM +05, Philippe Mathieu-Daud=C3=A9 wrote:
> On 15/3/26 21:16, Sergei Heifetz wrote:
>> If QEMU is configured with --disable-audio, do not compile the audio
>> tests.
>>=20
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   tests/audio/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tests/audio/meson.build b/tests/audio/meson.build
>> index 84754bde221..97c1d623bbd 100644
>> --- a/tests/audio/meson.build
>> +++ b/tests/audio/meson.build
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>  =20
>> -if not have_system
>> +if not have_audio
>>     subdir_done()
>>   endif
>>  =20
>
> Squash with the meson change in patch #1?

Yes, sure.


