Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D32CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4mv-0002FC-5B; Fri, 29 May 2026 17:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wT4mr-0002Ey-61
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:30:37 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wT4mp-0001qe-C2
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780090233; x=1780695033; i=deller@gmx.de;
 bh=0MlXRrJpiF/jDlWh6BegdeB9FWf/XC8VJ+mppxkfvN4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eW7e/B8ZTSyX4za69fnWZyce1uMKnrhecIDK4MTZGzoRYUaBDxBWpmWEFP5QFP2X
 EN1HUn73bm/sZBXVu3mGqkvRza9WkhfWScmSn+w65aDoiXyceLX8Sa8Y+/ymjQ9Kt
 7lYPdRUb97HqGmkhKljWFItzjk1jtiK/21Y03YnNVgHAusxLS2Z+JIbIdZ/1lwQ5c
 a8oAcFiDar2AGC8kSYvN/S1EZYif5gmRtDzbBsR6U8mLk1XDJwO+v+EOs3CCEYNvC
 LinkmH236Ykj1G0riAyxdiLBkVJDLkxcbltW/4IqbYqbbiJyeKhwh/qROJ7TwO78/
 crnvCeKdFGdHtBq7tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1xGWCs0xnD-00ulLo; Fri, 29
 May 2026 23:30:33 +0200
Message-ID: <cac9af29-5628-4490-a1f4-d84ed3c190e0@gmx.de>
Date: Fri, 29 May 2026 23:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] - SCSI tape boot
To: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Cc: qemu-devel@nongnu.org
References: <CALk1091JwDs9SGCydB2Q-4BunCbo=VEa429bmRjmQw4SwZrULg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CALk1091JwDs9SGCydB2Q-4BunCbo=VEa429bmRjmQw4SwZrULg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dHS0x2dSaNqfbaEdjm160pqk9wY73bFGnvfWbja1vuuJhav2yo
 tPLvXBhkymgju9CorYprf3aEk0XpV0NVeKhE0pf3SROJ18G6YN7yfmWxb8XACpVwaAEBucG
 Q8aC6+WP+C/FWvfW29bnzP7bTAVnmnHDfpUvTyZirKh+avqYbpEaKE70XvVzdyYvBPZseWH
 kNgOomUHSc3AsQiM4SGLg==
UI-OutboundReport: notjunk:1;M01:P0:wakxwawk8po=;xs5ezSokJZRN3NB4FisYSImMcBA
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Emmanuel,

On 5/29/26 10:35, Emmanuel Ugwu wrote:
> I have implemented the INQUIRY and TEST_UNIT_READY in scsi-tape.c
> and am working on READ, REWIND and other SCSI commands next.

Very good!

> I have 2 questions as I already tried booting the MPE/iX:
>=20
> 1. Is there a need to modify the current implementation of the
> parisc arch to support booting a tape device, cause I am trying to
> boot the file in QEMU but it seems hppa/seabios only supports disk
> and cd-rom boot I think.

Yes, I think up to now it will check for SCSI disc and SCSI CD-ROM only.
SeaBIOS-hppa needs some modifications to detect and use the SCSI tape.
I can start to work on this in 1-2 weeks.

> 2. What is the minimal set of SCSI commands MPE/iX needs before it
> can be booted in QEMU?
The firmware needs support for rewind and read only.
For now it's sufficient if you try that Linux can read from SCSI TAPE.

Helge

