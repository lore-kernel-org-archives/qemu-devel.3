Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB03FC72C3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 11:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4GZN-00052u-Vp; Sun, 22 Mar 2026 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4GZE-0004yQ-U5; Sun, 22 Mar 2026 07:02:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4GZC-0006Ix-Bc; Sun, 22 Mar 2026 07:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3AAE05969E4;
 Sun, 22 Mar 2026 12:01:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id L9H83MVdUk8v; Sun, 22 Mar 2026 12:01:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2AA2B5968DD; Sun, 22 Mar 2026 12:01:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2871B5968DC;
 Sun, 22 Mar 2026 12:01:50 +0100 (CET)
Date: Sun, 22 Mar 2026 12:01:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Stefan Weil <sw@weilnetz.de>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH for-11.0] Fix several typos in documentation (found by
 codespell)
In-Reply-To: <b8f6ec6d-60ba-4620-93ee-f4053d368c85@tls.msk.ru>
Message-ID: <d97253a2-a59b-c046-69f3-74f383c996cb@eik.bme.hu>
References: <20260319183453.100545-1-sw@weilnetz.de>
 <b8f6ec6d-60ba-4620-93ee-f4053d368c85@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sun, 22 Mar 2026, Michael Tokarev wrote:
> On 19.03.2026 21:34, Stefan Weil via wrote:
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> 
>> These typos are part of the generated documentation.
>> Therefore they should be fixed in the new release.
>> 
>> More typos can be found in the remaining code, mostly in comments.
>> 
>> Regards,
>> Stefan
>> 
>> ---
>
> Missing s-o-b?
>
> I can fold changes suggested by Peter to this patch, but without S-o-b
> it's not good.

Isn't there an S-o-b right in the first line of quoted text above?

Regards,
BALATON Zoltan

