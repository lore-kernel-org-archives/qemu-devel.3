Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C77E88D66
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 11:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8zLT-0000Kd-UB; Sat, 04 Apr 2026 07:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8zLS-0000KN-9r
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:39:18 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8zLQ-0001Kc-E6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775302746; x=1775907546; i=deller@gmx.de;
 bh=k+LF7TKrOh25YM8iGsu1zOPaVo0jbBqSYlu/yiytlQY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l9KPMj8DBRTP3Oox693G5+pt6b136n5PF/0mHS5OKGqJnqQDxFuZ4ut5WP2OQFWl
 GmeCru3CaGU/TepXA98xOcusJ1w8PNdhJrwyaFwhljgAvpxaBnZ0TV2rqv4KlzoOl
 srFVqD43XFPAKdtSyBY2awGdqInQPrw1H/2CCnnuYGHf/xvgduWwHrEKhSIVam4G4
 h8608cTb7I4i5zMy/l0ksEc6R9Zrp4EYSJOKTgvDpLQBTB6di9DcfY4bFJRmUYzcq
 eJvUNMDMpw45pPNiRVhWq22HlA9H7BiQZpL3pzDhjmPPweJdgiAw3bdALqGLYROAu
 YcsaiHqy36J4SVcLYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1vjnbz24RR-00n71M; Sat, 04
 Apr 2026 13:39:06 +0200
Message-ID: <00faf635-1991-4de3-92e7-19bdb0e8f0c7@gmx.de>
Date: Sat, 4 Apr 2026 13:39:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v2] Allow building qemu tools on 32-bit hosts
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20260404061215.505913-1-deller@kernel.org>
 <f384b680-050d-40c0-8947-5951fa7946ce@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f384b680-050d-40c0-8947-5951fa7946ce@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:laGoFytWXLwfnU4jD94D7Fczv10+A43l5WX64E60tV3roW3CibI
 yyitp8LZJZzw5AlTI8q7ZhZYIdT3XYf9aAutu+jL+KCahMiUSI5/PYUWvQANPEzOpEom+bH
 +e0K0J6aQ1xH+WQ1B9Irup1ll//hNKlGrmH5oxW24wpMEohB25put+/zVQDpWMRwy1ALoFW
 rsPHkjjkp/Z5PQRg7v4kg==
UI-OutboundReport: notjunk:1;M01:P0:oeKuxPRjX9s=;BuoEukYO4tTI0Y4HQEsY6G4OZXS
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 4/4/26 09:07, Michael Tokarev wrote:
> On 04.04.2026 09:12, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Qemu's tools like qemu-img are often needed on 32-bit platforms,
>> although the actual qemu emulators have been discontinued on 32-bit.
>>
>> To allow building the tools on 32-bit this patch implements three small
>> changes:
>>
>> a) The check in meson.build is changed to still error out if the user
>> tries to build qemu-system or qemu-user on a 32-bit platform, but allow=
s
>> building tools (e.g. by "--enable-tools") alone.
>>
>> b) The compile time check in atomic.h now checks against
>> sizeof(uint64_t) so that 32-bit environments can still build
>> successfully, while 128-bit atomic operations are prevented to sneak in=
.
>>
>> c) Allow linking against libatomic as long as we don't build the
>> qemu-system and qemu-user binaries.
>>
>> Sucessfully tested on the 32-bit big-endian powerpc architecture.
>=20
> On powerpc, util/meson.build tweak is also needed, - did you use it?

Yes, it was needed.
I used all your patches you sent in the series, but replaced
my patch with the new v2 version.

Helge

