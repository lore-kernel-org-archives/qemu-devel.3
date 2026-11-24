Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD2606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqXv-0004Em-Ni; Tue, 24 Nov 2026 08:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVqXq-0004D9-Cb; Tue, 24 Nov 2026 08:26:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVqXo-0006kz-EN; Tue, 24 Nov 2026 08:26:50 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EAF8C60C532;
 Tue, 24 Nov 2026 14:26:45 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id owEjAPQw0j8U; Tue, 24 Nov 2026 14:26:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BF07560C54E; Tue, 24 Nov 2026 14:26:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BCEA213C290;
 Tue, 24 Nov 2026 14:26:43 +0100 (CET)
Date: Tue, 24 Nov 2026 14:26:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@pond.sub.org>, 
 Utkarsh Verma <uverma@linux.ibm.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, 
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
In-Reply-To: <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
Message-ID: <03060b9c-aa81-60c3-ae9d-57df8a079644@eik.bme.hu>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
 <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
 <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2128387592-1795526803=:70435"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2128387592-1795526803=:70435
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 24 Nov 2026, Philippe Mathieu-Daudé wrote:
> On 24/11/26 11:19, Peter Maydell wrote:
>> On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>> I'm probably missing the point here, I'd rather look to help maintaining
>>> unmaintained / broken subsystems. Why care about a well working area and
>>> ask the maintainer to step down? Why not ask the same to ARM / RISCV /
>>> X86 maintainers? What is the underlying problem?
>> 
>> The underlying problem is that it gives a misleading view of
>> whether something's actually maintained if you look at
>> MAINTAINERS and there's an "S: Maintained" label but in fact
>> that person hasn't been actively involved with the project
>> for years and is probably not reading their qemu-devel email.
>> If the real situation on the ground is "effectively this is
>> Orphan and patches for it are unlikely to get review" then I
>> think it's better to have MAINTAINERS say so.
>> 
>> This is why at the beginning of the year I did a run through the
>> MAINTAINERS file to look for "stale" entries and query whether
>> the people listed still wished to be listed. (It was about 50:50
>> whether they said "yeah, it would be better to not list me" versus
>> "I do still want to be listed".)
>
> Hmm. Utkarsh should have mentioned that context first, hard to
> otherwise guess.
>
> Are we trying to address a 3rd class of your survey, people who
> didn't even replied?
>
>> I don't view this as "kicking out maintainers" but rather trying
>> to make our maintainer docs match reality: if anybody I contacted
>> in my run through the MAINTAINERS file requested to retain their
>> listing I did so.
>> 
>> We can discuss whether it's better to do this as a coordinated
>> process over the whole file versus single subsystems and who
>> is best placed to be sending out the queries and whether that
>> works better as private email vs cc to qemu-devel, but I think
>> the general principle is right: many people who drift away from
>> the project do not actively send us a MAINTAINERS update and
>> so we do have to do a little active housekeeping on it from
>> time to time.
>
> Since you sent the survey, I'd expect you to send the finalMAINTAINERS 
> update.
>
> Instead of having individual status checks, the process should
> be automated with a script, likely running during the -rc tags.

At every rc would be too frequent. Maybe even at every major version 
change (yearly) would be slightly annoying so I think it's OK to just ask 
from pepole who haven't been active for a while. Maybe if somebody did not 
post to the list or had any patches for more than a year or so you could 
send a query email to ask but as this isn't a too frequent task I'm not 
sure automating it would be that much needed.

I had some patches to prep (40p) last year which are blocked now as they 
depend on other changes I have not finished yet and I had no time for it 
but maybe I'll get back to it one day. But patches to this machine aren't 
frequent enough to need a maintainer urgently so wasn't a problem so far.

Regards,
BALATON Zoltan
--3866299591-2128387592-1795526803=:70435--

