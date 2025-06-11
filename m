Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B21FC71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 22:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPU9N-0001Of-56; Wed, 11 Jun 2025 18:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPU9I-0001O9-Qr
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 18:42:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPU9G-000654-PU
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 18:42:24 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 115C255BC03;
 Thu, 12 Jun 2025 00:42:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Aweud1lt4TtU; Thu, 12 Jun 2025 00:42:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0BAA455BC02; Thu, 12 Jun 2025 00:42:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 06288745683;
 Thu, 12 Jun 2025 00:42:17 +0200 (CEST)
Date: Thu, 12 Jun 2025 00:42:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Stefan Hajnoczi <stefanha@gmail.com>
cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Mads Ynddal <mads@ynddal.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 oltolm <oleg.tolmatcev@gmail.com>
Subject: Re: [PULL 1/1] meson: fix Windows build
In-Reply-To: <CAJSP0QVWQLK+5Z4DiNVDaz2-YtUUDYRj+roq9rwRS8ZVWYMKBg@mail.gmail.com>
Message-ID: <b8e7bb06-b10d-e0a0-68f1-4bc74debe9a5@eik.bme.hu>
References: <20250611182902.201331-1-stefanha@redhat.com>
 <20250611182902.201331-2-stefanha@redhat.com>
 <alpine.LMD.2.03.2506112113260.22610@eik.bme.hu>
 <CAJSP0QVWQLK+5Z4DiNVDaz2-YtUUDYRj+roq9rwRS8ZVWYMKBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-797795893-1749681737=:95578"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-797795893-1749681737=:95578
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Jun 2025, Stefan Hajnoczi wrote:
> On Wed, Jun 11, 2025 at 3:25 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Wed, 11 Jun 2025, Stefan Hajnoczi wrote:
>>> From: oltolm <oleg.tolmatcev@gmail.com>
>>>
>>> Sorry, I forgot to cc the maintainers.
>>
>> Do we want comments like this end up in git log? This could have been
>> fixed before a pull. Also the other pull request about uninitialised stack
>> variables had hw/audio/gus twice which was pointed out by a comment before
>> the pull that one of those should be different but the pull request still
>> had this error. Did you miss these or aren't these important enough to fix
>> before getting in git log forever or there is just no easy way to fix up
>> commit messages in pull requests?
>
> If another reviewer asks for the author to resend then I'll hold off
> on merging, but I didn't see the comment about hw/audio/gus. Sorry!
>
> I did see this "Sorry, I forgot to cc the maintainers" comment.
> Although I'm not consistent, nowadays I generally do not fix these
> issues when merging, provided it's a small issue that can be ignored
> or understood from the context.
>
> I don't really mind either way, so if there is a consensus that all
> maintainers should be strict about this, I'm happy to join.

I wouldn't ask maintainers to fixup commits regularly, especially changing 
the patch itself would need resend from the author but for small typos in 
commit message only it might be OK to fix them up on commit if noticed 
before a pull. Just because if these aren't fixed they will be in git log 
forever.

Regards,
BALATON Zoltan
--3866299591-797795893-1749681737=:95578--

