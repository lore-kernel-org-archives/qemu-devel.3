Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F161C531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOD3-0002a5-3X; Mon, 27 Jul 2026 12:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woOCw-0002Vx-Va
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:29:39 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woOCs-0001sj-6f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785169770; x=1785774570; i=deller@gmx.de;
 bh=jRqoudd6ZIrMh8QjVM7cZKQZ5m/iwVNpUmDtCT1+fAY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gBjFu09n3eW+lWiQsWNz1VJNns+MbgJM/Wp5J3izeUGGbK1DI9vI93ff2SBCBZHK
 WdgWfS251Cl9KV2Z4aYaJyla7R07aflqz8h9IlGhCyAb2NEElWGotKApxoi7sYExQ
 X3GIPOyN//g6zEImlcBXtDwC97Sv9zdcPPnCCWXb/o3L/cTa30VCqbqs9oEnfYjhG
 tDvt5/mgFriiNc/S1hPIOG1QDx1PgAnvxUGvkyiz7wCATGQPNMlgdW5/RrZ9jWGVp
 d5Sa3pIUjZqJMnqdxhiwFtaOIbpH5cLFL0+dO58BGTUR0HmW6u7Ic5T6cPH+98N3N
 0+7kRN+Rp3HIQHql8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1wjUNs2ykk-0016Nv; Mon, 27
 Jul 2026 18:29:30 +0200
Message-ID: <9b29b936-a71f-4ae2-b0e6-634f48bea31f@gmx.de>
Date: Mon, 27 Jul 2026 18:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
 <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
 <3677fd2b-64fc-45fe-8bb7-04f84773c77e@oss.qualcomm.com>
 <87bjbspipl.fsf@suse.de>
 <CAFEAcA-VTV=r4cCKgfXD-4L3HixAVOMX3BUerRWbN=6fg_L3MQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA-VTV=r4cCKgfXD-4L3HixAVOMX3BUerRWbN=6fg_L3MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cCM66RG0rFk/DNSS8UHGvsTPXzFi/tipS0rmZxKMkwnciMyx2a
 ELnhYxmv6rlUS7d4RIh0bqswMFhC+j/2z/5Jry60P73fOJNTJEnd3rsDZiaPHbTLqfZeXIH
 0qQ9hP2Qk+XPEH298qTCZS8Xd4L9h41XP5zyI5qfejvgT++2D+/5Q4PUcMyfK1/5aW/Rt7l
 UTin+2wiZ0HYv5wF8SC+w==
UI-OutboundReport: notjunk:1;M01:P0:BPpxsZNjydc=;1QaayJ/Up4ES6LgcrYHCSH/L7qy
 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
 HMguqPJwE=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/27/26 17:23, Peter Maydell wrote:
> On Mon, 27 Jul 2026 at 16:16, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>>> I'm not saying this patch is a bad idea, I'll likely use it too;
>>> I want to clarify what are the valid use cases the community sees
>>> here. Building pointless things clearly has a negative impact on
>>> resources and our time, but not testing changes also has.
>>
>> Perhaps we could add something to checkpatch that emits an error if
>> config-status has --disable-tests.
>=20
> I think that's probably overkill. People who don't run tests
> are much more likely to be doing it by simply not running
> "make check" and "make check-functional" than by using this new
> --disable-tests configure option :-)
>=20
> I think if --disable-tests isn't the default then that's enough
> to mean that it only gets used for the situations where it matters
> to cut down that build time (like the bisection-test cases etc).
+1 from me:
Add "--disable-tests", but don't make it default.

Those tests just stole lots of my time while running git-bisect.....

Helge

