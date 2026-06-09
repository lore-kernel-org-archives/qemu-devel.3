Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE886CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzKF-00081T-2A; Tue, 09 Jun 2026 12:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wWzKD-000815-NW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:29:13 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wWzKA-00084A-Px
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781022548; x=1781627348; i=deller@gmx.de;
 bh=CmGxzLSkZIqqdhA8t/RHpBoPmawrMJgoxbDM3gc2BW0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gxtyvScm9XRrwXnkCBEAkVc3ZlAsFEPeMgXhm6NKlVPr8UzrRQRV2v8R4mHBtYVI
 B208eQsdkm2MqeoqHcmXVy0QvxwZEVbs5z8xMn+xEhkm58UR+yfhncb6xkjO2nQm/
 DuTXy3Y8MTFF9SQ0Kqsh2mJL0mHwje46CNbIKvjyo/OQs1paPlp2CQLKfNrT64LLr
 mOlhQDFxk/AzkZW4rMJjW6Da8MzTh1t7uwj8/WT1tB9bEP00RZYTdBBB4TMFZ7OQJ
 eY1l9XzifdkSfYP9MyA0ALkHPmVpS0EUK9kGVKcnqSIRV8z6xPGGrPLj2uySWn4ah
 lcojnzWI+wSYS/4I9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1xGWjx3LVd-00sjvB; Tue, 09
 Jun 2026 18:29:08 +0200
Message-ID: <44ccf6b8-1dea-4094-bb38-09719fcdcd1f@gmx.de>
Date: Tue, 9 Jun 2026 18:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Linux user patches
To: Stefan Hajnoczi <stefanha@gmail.com>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Laurent Vivier <laurent@vivier.eu>
References: <20260608194256.13794-1-deller@kernel.org>
 <CAJSP0QWtOGdNx-hQnmcDhagKdB7iEwoQyc9b1_YxP9RbQHYfJQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QWtOGdNx-hQnmcDhagKdB7iEwoQyc9b1_YxP9RbQHYfJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mxqvoKxV4U3XUKbVQJywybgH5iDt8EYz7LeXW9GO/Mu/53H8+g3
 gyvCw0g9Ye0ulaVZzLIt/gtTJ0dwIBOBx1j3nRwBc6TeONnzq/YRNR9mWHpPf84L10SUk4h
 CiGcd+vpsaJP/NyvBYlym5kvCdZ7YUE9GsViTu7U+Be8WmwBykrMVY3kOjj2QVj58R+X+A8
 max920I5a5eN6E2FV5s8A==
UI-OutboundReport: notjunk:1;M01:P0:LZvJ02lqRlY=;T9JSPMUoMIACm3gxD6dEiJ0wqkf
 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
 mwnjpD4LkoEPo2BlBc687LYEvRI=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/9/26 17:16, Stefan Hajnoczi wrote:
> On Mon, Jun 8, 2026 at 3:43=E2=80=AFPM Helge Deller <deller@kernel.org> =
wrote:
>>
>> From: Helge Deller <deller@gmx.de>
>>
>> The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce=
0bdc:
>>
>>    lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-reques=
t
>>
>> for you to fetch changes up to fd8da2844c4354ecf54bd73a2fa7babe669b7a12=
:
>>
>>    target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn (20=
26-06-07 17:56:24 +0200)
>>
>> ----------------------------------------------------------------
>> linux-user patches for alpha, sparc and sh4
>>
>> Various linux-user related patches from Matt Turner with coredump suppo=
rt for
>> alpha and sparc, as well as some fixes for the signal handler in sparc.
>>
>> The patches from Xinhui Yang add the missing fsmount series syscalls su=
pport
>> for systemd.
>>
>> ----------------------------------------------------------------
>>
>> Matt Turner (6):
>>    linux-user/alpha: add coredump support
>>    linux-user/sparc: add coredump support
>>    linux-user/sparc: restore L/I registers from RSA in
>>      sparc64_set_context
>>    linux-user/sparc: call block_signals() before set_sigmask() in
>>      setcontext
>>    linux-user/sparc: flush register windows before core dump
>>    target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn
>>
>> Xinhui Yang (2):
>>    linux-user: implement fsmount(2) series of syscalls
>>    linux-user/strace: add fsmount series of syscalls
>=20
> Hi Xinhui Yang,
> Please take a look at the CI failures below. It will probably be
> necessary to detect the availability of the fs syscalls at build time
> and avoid them when the host lacks support.
>=20
> Please send a fixed patch series to the list so Helge can pick it up
> again in a future pull request. Thanks!
I'll fix and resend.

Helge

