Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4921BCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHam-0005dX-0l; Thu, 15 Oct 2026 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xHHaj-0005d3-45; Thu, 15 Oct 2026 05:17:38 -0400
Received: from smtp1-g21.free.fr ([2a01:e0c:1:1599::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xHHag-0004PU-NR; Thu, 15 Oct 2026 05:17:36 -0400
Received: from [192.168.25.24] (unknown [89.93.216.19])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A378CB00539;
 Thu, 15 Oct 2026 11:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1792055848;
 bh=eV4+FPmBOubhr902KB/kB510r+b3+TorkLQ7jM23K5Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j+Mq23Cp77XgMK/zxPjhYKO7rMALd254M3c9gMiNBlLTzLy4i+0zWVm4JDbFHDi++
 47T3sHWpmPlWQnD2M8Fw+kc9trwENlhZLJ8HI4dr58Bg9HGQigwbBJ2nGWpyxo7Fo6
 SLSQqRB8BdeSeTwlUSvlPA9KufYQ13t4c1wYMhWHOaHGE9y/VJD7nlUUjMJhZ4ogOT
 863OVv50OHtkrITEpDP2Fi3OQoI8lgQkGbYbSC5K47cMMR5JMojBX5fTmjQhh8lYbi
 KTWA3UDPhyt1o4Shg1zgQFnEWLsbz1xxg+D51O2Ky2ZG1gwSsUtSyKG/fMKzN0udEg
 JZ5exBAdNlW0A==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: Miles Glenn <milesg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 37/50] tests/qtest: ina230: cover operating modes and
 triggered conversions
Date: Thu, 15 Oct 2026 11:17:04 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <3AAC1CB5-CB9E-4153-A4D4-184DFC78DDC6@free.fr>
In-Reply-To: <0a89d4d7abf1054008ccc90e73089c7f528bf750.camel@linux.ibm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-37-4c3dff084ec9@free.fr>
 <0a89d4d7abf1054008ccc90e73089c7f528bf750.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_CB57454B-74F4-4AFB-A62C-4B80DB466E48_="
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
Received-SPF: pass client-ip=2a01:e0c:1:1599::10;
 envelope-from=emmanuel.blot@free.fr; helo=smtp1-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


--=_MailMate_CB57454B-74F4-4AFB-A62C-4B80DB466E48_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: 8bit



On 14 Oct 2026, at 22:01, Miles Glenn wrote:

> On Mon, 2026-10-12 at 16:32 +0200, Emmanuel Blot via qemu development
> wrote:
>> Add coverage for the MODE field: power-down retains the last results,
>> the shunt/bus channel-enable bits gate which registers track new inputs,
>> triggered modes convert once per Config write, and bus-only mode still
>> derives power from the retained current.
>>
>> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
>> +    i2c_set16(dev, REG_CONFIG, 0x07);
>> +    qmp_ina230_set("shunt-voltage", 20000000); /* A */
>
> Is the /* A */ comment intentional?
>
> Thanks,
>
> Glenn
>

No, good catch, it’s a left-over comment.
Sorry about that, I’ll send a V3.

Thanks,
Emmanuel.

--=_MailMate_CB57454B-74F4-4AFB-A62C-4B80DB466E48_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8"=
>
</head>
<body><div s><div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">On 14 Oct 2026, at 22:01, Miles Glenn wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">On Mon, 2026-10-12 at 16:32 +0200, Emmanuel Blot via qemu=
 development<br>
wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; border-left-color: #999999; color: #999999;">
<p dir=3D"auto">Add coverage for the MODE field: power-down retains the l=
ast results,<br>
the shunt/bus channel-enable bits gate which registers track new inputs,<=
br>
triggered modes convert once per Config write, and bus-only mode still<br=
>
derives power from the retained current.</p>
<p dir=3D"auto">Signed-off-by: Emmanuel Blot <a href=3D"mailto:emmanuel.b=
lot@free.fr" style=3D"color: #999999;">emmanuel.blot@free.fr</a></p>
<ul>
<li>i2c_set16(dev, REG_CONFIG, 0x07);</li>
<li>qmp_ina230_set(&quot;shunt-voltage&quot;, 20000000); /* A */</li>
</ul>
</blockquote>
<p dir=3D"auto">Is the /* A */ comment intentional?</p>
<p dir=3D"auto">Thanks,</p>
<p dir=3D"auto">Glenn</p>
</blockquote>
<p dir=3D"auto">No, good catch, it=E2=80=99s a left-over comment.<br>
Sorry about that, I=E2=80=99ll send a V3.</p>
<p dir=3D"auto">Thanks,<br>
Emmanuel.</p>

</div>
</div>
</body>

</html>

--=_MailMate_CB57454B-74F4-4AFB-A62C-4B80DB466E48_=--

