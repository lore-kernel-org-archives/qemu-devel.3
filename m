Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E313CC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4Rg-000175-2s; Wed, 14 Oct 2026 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xH4Rc-00016V-1T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:15:20 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xH4Ra-0006wA-3x
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792005304; x=1792610104; i=deller@gmx.de;
 bh=x90LwhFGZJpsBFC8Y4rkSrYMzfarAvG6ji0YafW6zAU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Z1CNK9/WQowXUFTq2HwpBs681W/gvj2JjVgAJjPM+21yDrQ+NmA/LqGiVjCBk5ba
 Fu4zhBPSRfqZWC4EGn35/6hiTjifXL+SXvuTGOTRY04cPO+h+9GOj9P6lJrGKZmz1
 WiflC02Oldfct7D/g6em9c3GPQY9UAU5mcPLBx17yyg8qh/V04+gNmaifY7dS/CTz
 qIt4ccSmTaL/n2T1yVhpL7UtGttXXWTHltjtRJqXH6acC57f2wn6FLc3M1Opb2B9c
 6kg1qDyzF49flUvJXWtbR9mPHqtKJdr8Q25mRMAffREMcVQHxE1m0mn5GT9UIcxlP
 gET8fTqXk3YOFC7zPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1wrNif1q85-00aHp8; Wed, 14
 Oct 2026 21:15:04 +0200
Message-ID: <43894188-e54d-4f20-8b3b-de868715131e@gmx.de>
Date: Wed, 14 Oct 2026 21:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: don't print core dump message by default
To: Richard Henderson <richard.henderson@linaro.org>,
 Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <mvmzews2zze.fsf@suse.de>
 <22222b65-2093-4501-baf4-e5644c8e4018@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <22222b65-2093-4501-baf4-e5644c8e4018@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BbbwYZWEy28p+OD8u2/sf/K2QmPnCeK7j5tU38Mg6SVPlnQEHHu
 Oi12X+1vYsxOdmdU+2RYcBj4cVR+wbJwjEXA9XbgJgK2M6oa0QGjZAx/q/qRCJkCDERkLAO
 M8pBPF6ULRVu5FjJYZw3+l1vDxQuDTIXj0Lg50oWDzOqdbj25QfMnrH7QcimBW2Gn3MUobo
 VOPrEC11tMFgPr3WSA77g==
UI-OutboundReport: notjunk:1;M01:P0:2lzta1O90YU=;X6ZcLTVtTk/9BBXpfHkXcUUzWO9
 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
 ORpxqUbuuu43MTrAYSvKV2f6T2EWDjw2SkuUdI=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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

On 10/10/26 11:24, Richard Henderson wrote:
> On 10/5/26 12:39, Andreas Schwab wrote:
>> When the target binary is killed by a signal with core dump print a
>> message to the guest_errors log instead of stderr.=C2=A0 This avoids br=
eaking
>> various testsuites due to the extra output produced by the emulation.
>>
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>> =C2=A0 linux-user/signal.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
queued up in linux-user-next.

Thanks!
Helge

