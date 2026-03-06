Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C57FCC076
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 21:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vycWe-0005Sk-Jm; Fri, 06 Mar 2026 16:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vycWd-0005Mu-22
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:15:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vycWb-0004wW-0n
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:15:58 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 920455969F6;
 Fri, 06 Mar 2026 22:15:51 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BRtIDsE0v7Df; Fri,  6 Mar 2026 22:15:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 594685969E4; Fri, 06 Mar 2026 22:15:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 574615966F5;
 Fri, 06 Mar 2026 22:15:49 +0100 (CET)
Date: Fri, 6 Mar 2026 22:15:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@kernel.org>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
In-Reply-To: <aas7xpjiDx5Bhrs4@p100>
Message-ID: <6b50d2c8-72f9-9082-dc0f-d141c9762fc4@eik.bme.hu>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
 <aas7xpjiDx5Bhrs4@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9,
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

On Fri, 6 Mar 2026, Helge Deller wrote:
> * Peter Maydell <peter.maydell@linaro.org>:
>> You need to increment the version_id and minimum_version_id
>> to change the vmstate. Or you could instead replace the line with
>>            VMSTATE_UNUSED(1), /* was "disable" */
>> (which keeps the migration data structure the same, so no
>> version bump needed).
>>
>> I have no strong preference; I would probably just bump
>> the version numbers personally.
>
> New patch below.
> Ok?
>
> Helge
>
>
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
>
> The "disable" property is not used, so drop it.
>
> Noticed-by: Peter Maydell <peter.maydell@linaro.org>

Is Noticed-by a valid tag? Usually it's Reported-by or Suggested-by.

Regards,
BALATON Zoltan

