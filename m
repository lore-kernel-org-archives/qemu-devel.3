Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50690EFD202
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9kz-0003Vx-Mo; Wed, 25 Feb 2026 02:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9ku-0003RH-W1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:56:25 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9ks-0008VU-3u
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:56:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CB53480761;
 Wed, 25 Feb 2026 10:56:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55b::1:1] (unknown [2a02:6bf:8080:55b::1:1])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Fub4uw7AAuQ0-2My1A7l8; Wed, 25 Feb 2026 10:56:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772006177;
 bh=50NRkfHRXxvmBsebiEQ+ENx5otxq+4DVc9pVflStrpA=;
 h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
 b=toNq2RXJoQ6xUM9VMkTGz8vV94jAmw439oWu5bIOrriD8Bvc5CfcttKYs4fBTYBEg
 3A8/FAcYUBo/o1BLRv8F2zhmeEmLTZcDzgx2lEz765bsJXo54lgbhspLaLLjeHNgYS
 n/LOwYHeXHDJtVivU5wtxuT7e2PhDoRNGrkynnj4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <fcfce063-7f77-4a36-83bd-f706183200fc@yandex-team.com>
Date: Wed, 25 Feb 2026 12:56:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergei Heifetz <heifetz@yandex-team.com>
Subject: Re: [PATCH v2 09/10] audio: do not build audio-related sources with
 --disable-audio
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-10-heifetz@yandex-team.com>
 <87o6le602l.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <87o6le602l.fsf@pond.sub.org>
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

Hi, Markus.

On 2/24/26 13:02, Markus Armbruster wrote:
> Sergei Heifetz<heifetz@yandex-team.com> writes:
>
>> When QEMU is configured with `--disable-audio`, do not build any
>> audio-related sources.
[...]
> You compile out just the command, and keep all the audio types.
>
> According to the cover letter: "In [certain] environments it is
> generally beneficial to avoid building unused code, for both security
> and maintenance reasons."  True.  But if we still need the audio types,
> could there be more code we'd rather not build?
>
> To find out, I emptied out qapi/audio.json completely, then fixed what
> broke without regard for neatness.  Diff appended.
>
> I'm not demanding anything here.  I merely want to show where audio
> stuff is still used, so we can make an informed decision on where
> exactly to make the cut.

Indeed, it was a question of where to draw the line, and my main goal 
was to remove the audio/* files. However, I think it’s great that we can 
remove qapi/audio.json entirely. Thank you very much for the suggestion 
— I’ll try to incorporate it in the next version of the series.

[...]

