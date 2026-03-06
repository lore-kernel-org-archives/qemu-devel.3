Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDB8FCC076
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 21:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vycYh-0006PC-Nm; Fri, 06 Mar 2026 16:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vycYg-0006Ou-0k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:18:06 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vycYe-00054h-CH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772831876; x=1773436676; i=deller@gmx.de;
 bh=g93U0z3ekqgCbzrrWKcC8v7n7mFBVJUcqfojQ3fchEA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BHQIU2aoUMEPwkrv5DhIQ3TJf5bzBY7bCFrt3GXZe7P3+0eysBQ48Jj/lstB0oSQ
 fEz7Vam1JRJRBer/5VPZFqKxk6n5T4nDDHqlSz/HudmifEVZQ6DCjj+C4iqPb/msW
 4mQf3+vsy2yKY7XUH9gZzChSJBM9ZOSxavGqWLcpFFRhEWWQITThGdG1ModO8sVd0
 +DDjocEmUDCjv8BQUTDdbCkjIVip1pK092eji+bHyafHqrO69YK4asYX4br2tdebU
 wpOyxoaovAE6Cnaad8lsJ8lsr3g9QR6JruSOLOzt0uXB9KwX2mRryemg/qD0wb/Uz
 5OuAUDQDujh5TeWYfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1vLDDI2IEK-00hInr; Fri, 06
 Mar 2026 22:17:56 +0100
Message-ID: <4175b3ca-b05a-45a0-b8f8-5155136d8981@gmx.de>
Date: Fri, 6 Mar 2026 22:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
 <aas7xpjiDx5Bhrs4@p100> <6b50d2c8-72f9-9082-dc0f-d141c9762fc4@eik.bme.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <6b50d2c8-72f9-9082-dc0f-d141c9762fc4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VLlVjwHKq91BEZ0dKiFozFe9LbGejljFz6VBUfZDdt2itS16h2m
 aEnYpWrYvCYBZyuSQrers6jA/FohACjgCGD/+MbNyyakmVE6VLyf0iNNblIMg+IZdg3bEnc
 +sfg55+EEsrWTGIUmWmckTh0+RmhUoSU2humAhK6yDSfjL5sp66dVkfIWIy52cf//icc109
 Uhc6mAe6E+Jkz4zArPIPQ==
UI-OutboundReport: notjunk:1;M01:P0:tU9SOYTkxqM=;Chiln/BT0WYERFa6MkSj0OtiFvg
 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
 cvjbaISB72SUe4GAcKjFqJINQ2y3E1iqugpgCM
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

On 3/6/26 22:15, BALATON Zoltan wrote:
> On Fri, 6 Mar 2026, Helge Deller wrote:
>> * Peter Maydell <peter.maydell@linaro.org>:
>>> You need to increment the version_id and minimum_version_id
>>> to change the vmstate. Or you could instead replace the line with
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_U=
NUSED(1), /* was "disable" */
>>> (which keeps the migration data structure the same, so no
>>> version bump needed).
>>>
>>> I have no strong preference; I would probably just bump
>>> the version numbers personally.
>>
>> New patch below.
>> Ok?
>>
>> Helge
>>
>>
>> From: Helge Deller <deller@gmx.de>
>> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
>>
>> The "disable" property is not used, so drop it.
>>
>> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Is Noticed-by a valid tag? Usually it's Reported-by or Suggested-by.

True. I'll change it to Suggested-by:

Helge

