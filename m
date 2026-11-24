Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3C606A327
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aVcd8bQk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmNd-0004N0-7G; Tue, 24 Nov 2026 04:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVmNc-0004MB-5E
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:00:00 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVmNa-0000YX-Jk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:59:59 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67da3d03263so4351336d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 00:59:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795510797; cv=none;
 d=google.com; s=arc-20260327;
 b=Lli2x4vqjA3BjgQSNINeI3NQsySu58K/HabYtC2Yg76EVWmgd3IQ4WFe30MR45bqEh
 yLr11HRSVOaBQx283pyVM1lS5bM6spHHB3WSBE5RhwqdbePHK7CesdDG9mQtbRgLZxHJ
 8tFmDE+5CB2nDv9nhkV9RK5Qj56ny4JYsoHeJoVBJdPfaQLCTzi8G5Uec4d4f7XPXf80
 67mFNDln8KVlcTbiocNJ7pqRINEZ2+JgI/7gaaOzG3pLv+RtMNyq4clrYM12bjkyn4D3
 akLV/hDeoFqFwnp2tCch6sLKK0azDk39RxusyJPJKNLmxpfnfe0AESJQ0V5V9XeUZf2G
 vx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qSg0HhDbaADXq1/THgPRmJZtqcH4gtlKISvJ5s0Tayw=;
 fh=C7z2/kkXemN5L3NkUsQfLYBNsTWpTIABpQ1Rg2QSxLg=;
 b=Ns3C7pnfYM3xGGG6C3MZGTS3odifzpwvSgZIUAeZJ5olH1tjT49exg+BrgOMQwfUm9
 7l50/ZMB2tR4Dxp22MlOTQyMcCWVQH5GMsPHDbqPBRO6xIaYMkyOajV682eGZ05LEIgT
 X3Hi396SQRtv1TEYecmlQXm3LKvn7am4DoGni4R8kpmQYUJ5uko94JxAJV//8sFwq+jw
 JjOtOsQn8t8qmePtNJA4CEJcU0G6izZzB9aqaq302kMfeIzQ7jr+qhdn1vzz/kf44jvq
 zNFCvULRTbMmzayRiPmJT2yKoCBVNHsbY7jLe7EBShOM6NrZi5EckKt2VV+QMQa+LO6e
 JYsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795510797; x=1796115597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qSg0HhDbaADXq1/THgPRmJZtqcH4gtlKISvJ5s0Tayw=;
 b=aVcd8bQkaAYBf1ne0ruxtFgIGz6JCEtE1cEtOavRI70+BulEt1aHXZHnaVot+ru1tG
 uRZvQfYHQCfgv/tNsYbJWYw5yPgX3gatSGYoJiBV6cKnkx3u8HPTSFNZpGCxDLbI8lS/
 /KLMBdextVX6SIOa/rvEBSSFeODc6EPvXppK96oDFWYYf+/WwrLxYgkCSiMQdYCv3KHm
 TWtbK4LBne6nsPmGj96ErfBVUdYsVbJugR3zvJPV4gl5ParQy0qlrGS9/WhpDzXlFNg9
 qOZM8KZjqmU01GJ9j7DGHi+RH1WA0vvkAgoOUZVo22TA0inSggkikSfdKotfpqM+nGse
 TcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510797; x=1796115597;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qSg0HhDbaADXq1/THgPRmJZtqcH4gtlKISvJ5s0Tayw=;
 b=nJ9EMui41Q1gxEhZYTWeDMW/Y/fCQxnymptuNQORb8qjtYzYqrL9Ckzm9CHG+YPlGo
 x4hDtILYyWd4kaoetZj6sjHkSJrlpHnXT/Yn2oI/WhDNiRKkulcgRJogm5j8UxKQKArg
 LOMxj2GOTBwcx0Ui6pXwWV9RMdLbSbCIhdF+BafiRSWMy2qEpgLLXgsZdfXNaaIBNNgX
 K++Nj4lvwCHH89e6+MBN3MvuOM7RNPrxhWGCtUrQnQ+739yzC1j0gjhvt5CDZLcfMK8h
 Ofqs7F4O18MIyTarFYlNUuZ6IFk9JJMF/ESQ5Qq+DqDc3QhvdFQyDh5cs3nxIVHkL9BW
 vk9g==
X-Forwarded-Encrypted: i=1;
 AL+hErFGPghVFkYvlvWgiDWe9z2DRf6hGkBhiURr5Dt14ik6hsZJHVOT02iuvnWNFkKNpsKr2rE9lQeTg++f@nongnu.org
X-Gm-Message-State: APuU4Z9OvHWZ6x36V5OLPd1cQlC5NtoJWMetxr52GVWfLbGG+VISVU+L
 vYyF4GBXyYliOgbu54+MfAu8pwoBA6F2SUGvgdBNOmDGsnmgqIMW7t9WbmUkqL2zk+SZsVblzlT
 Xu7Kz8JvpUdbWWl0USp2Q2mWYbIuEfS1MlPgBhkqYeA==
X-Gm-Gg: AZFdTZe4UC5+iET/kUowjbyDGXecZkxNIBNhvnqcluQL/QQr2JCAyoYR3+M1lsXiCWh
 BcHsyQlFCTKq3s1xLeSlbOQnsx526CwFM76JDJ3XAPGuk0gf21igkjotku1/5b7UM0+k+8cGqEn
 4InSBvkJGebQZRBZqTV3qkbdoKpM8lcdRkiOwf1I+nvjiuiQXT50/VD84732xYaY+WyEgZoKoz5
 04WKEJO5qFJkiZxlFcsGmlbc+XE+srvjk8daXrVBw+9Cuq2B/0K8JyxYHuNV9wuwX8ve5Lq8UT4
 er6yjSe9PWyVsr1ULenX2OcB45Zw2OAqmpdMgHBvZEv5uub97FwGbYZkqezfzdBClfn7yjorRx9
 EWrzCQ+9ahKwUSQ+T6Ft+0H+tA25H2qYO0VakAjJ2KD0EI3QEj+sUNzU4UBKR3JKUvZmHaMKyhS
 GYGV4zW1Ch1w01CBU75GSh
X-Received: by 2002:a05:690e:138c:b0:67d:a750:ef7b with SMTP id
 956f58d0204a3-67df449a453mr4501641d50.132.1795510796985; Tue, 24 Nov 2026
 00:59:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
 <ar_FXE5rzVqKcTc4@redhat.com> <87ik21vy11.fsf@pond.sub.org>
 <CABgObfagz=EvmYtNFBo2xyDdXNkFPK8k0-YGDs7aVS6xRKEJTw@mail.gmail.com>
 <awQisiKRYpQSTmVy@redhat.com> <87a4mzwuqp.fsf@pond.sub.org>
 <CABgObfaELn80BU_b9CjaTqiHx_tCj+8hSh+59FpUk33+osBvDQ@mail.gmail.com>
 <87y0ajuw9j.fsf@draig.linaro.org>
 <CABgObfbb-+zmxeV5rjLM=7cXAZUqpGr84kBPTfnysiLc+crL-w@mail.gmail.com>
In-Reply-To: <CABgObfbb-+zmxeV5rjLM=7cXAZUqpGr84kBPTfnysiLc+crL-w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 08:59:44 +0000
X-Gm-Features: Aa3M54qALhW5HoVecuWaZaMiGaJgz-8ahCt8IqDSMBqth2fsLsAlfsRZfLQvkts
Message-ID: <CAFEAcA9uvfiwB5TFEbq9ROMumpB+dsta8RNYbqCnkMrDUmj7Tg@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 21:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il lun 23 nov 2026, 21:29 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha sc=
ritto:
>>
>> > On the other hand: people are already reviewing *clearly* LLM-produced
>> > patch series (example
>> > https://lore.kernel.org/qemu-devel/CABgObfbKKSoO1NsyygXUT4O1b+aPZ0SRNU=
GU55pcQphR5s81aQ@mail.gmail.com/T/).
>>
>> clearly? My reading is the cover letter is thorough but its not giving
>> off LLM vibes to me. I've only eyeballed the patches themselves but they
>> seem thought out and split into nicely re-viewable chunks. If it is AI
>> it certainly seems to be in the hands of someone who knows what they are
>> doing.
>
>
> Sure, no doubt Denis knows what he's doing. But the commit messages are c=
ertainly AI (I have just checked the cover letter and three patches with pa=
ngram, including one that didn't give me immediate pause), and there are ce=
rtain aspects of overengineering that give me serious doubts about the code=
.
>
> In that respect a clear policy would remove all of the pressure to wait a=
nd possibly ask later for forgiveness, and would let us provide clear agent=
 instructions without being hypocritical.

Though this new policy even with patch 4 still says that cover
letters and commit messages should be written by humans, so
that series would not be in policy under the proposed new rules
either.

-- PMM

