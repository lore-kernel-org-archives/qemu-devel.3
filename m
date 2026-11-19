Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC808606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2lC-0004nt-Gp; Thu, 19 Nov 2026 09:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU2l2-0004WH-7S
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:05:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xU2l0-0000iH-Ae
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:04:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB1C860EAFC;
 Thu, 19 Nov 2026 15:04:53 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id UTHWf70H1dMn; Thu, 19 Nov 2026 15:04:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B82C460EAF8; Thu, 19 Nov 2026 15:04:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B22A313C28F;
 Thu, 19 Nov 2026 15:04:51 +0100 (CET)
Date: Thu, 19 Nov 2026 15:04:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <e9d89a36-a536-4853-ba62-28f80ae56f5e@oss.qualcomm.com>
Message-ID: <297a4b91-24fc-33b6-0e3a-199dc177ab50@eik.bme.hu>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com> <avy4mkin-orpwskO@redhat.com>
 <avzDYfG-cPiWaCZ6@redhat.com>
 <740c20c7-f8c2-bcb5-4669-d996a8a90cda@eik.bme.hu>
 <e9d89a36-a536-4853-ba62-28f80ae56f5e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-184487031-1795097091=:14212"
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

--3866299591-184487031-1795097091=:14212
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Nov 2026, Philippe Mathieu-Daudé wrote:
> On 17/11/26 22:42, BALATON Zoltan wrote:
>
>> The problem is not people using AI but people using AI who otherwise have 
>> no idea what they are doing and send the slop unreviewed and untested (or 
>> submit tickets that way)
>
> I'd rather blame AI-induced automation bias which also happens to
> "people who have idea of what they are doing".

That's a second level of problem we need to deal with once we manage to 
exclude the non-sensical slop or people who submit tested AI patches but 
then don't reply to review because they don't understand what the patch 
does or review asks. Then it may become a problem that it's easy with AI 
to make large changes touching a lot of areas which is much harder to 
review. But if these are submitted by people who know what they are doing 
we can at least expect them to read and follow the policy and review, test 
and understand the changes before submitting so it will not be stuff that 
nobody understands or can correct according to review. This still means 
more work for reviewers but at least they don't have to fight the slop 
first to find the valuable changes which should be done by the submitter 
in the first place. If such large changes that become possible with AI 
used by people who know what they are doing helps improving the project 
it's probably worth the increased review work. So I still think we should 
try to filter submissions that are sent by people who don't know what the 
patch does and cannot answer review because then review work is wasted 
effort.

Regards,
BALATON Zoltan
--3866299591-184487031-1795097091=:14212--

