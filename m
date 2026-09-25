Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA13DC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4vE-0004yn-EC; Fri, 25 Sep 2026 08:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xA4vC-0004yJ-FY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:20:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xA4vA-00065E-C5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 08:20:58 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47A335832AF;
 Fri, 25 Sep 2026 14:20:51 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id pJPo3jbN9qRm; Fri, 25 Sep 2026 14:20:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3CF0B583223; Fri, 25 Sep 2026 14:20:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B6D45831F0;
 Fri, 25 Sep 2026 14:20:49 +0200 (CEST)
Date: Fri, 25 Sep 2026 14:20:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Kevin Wolf <kwolf@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <arZZhpR5_nPybOUo@redhat.com>
Message-ID: <e030a85d-a5d5-8fc6-5d1a-41167f7a95bf@eik.bme.hu>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com> <arEvLLYK9A5MKNdE@redhat.com>
 <arP7TDfz7lz699KJ@redhat.com> <87ik3vyp3i.fsf@draig.linaro.org>
 <arT_kefzEhqg8-FB@redhat.com> <arUJxE0F7Q3Cw5sk@redhat.com>
 <arZHWKAgr-GYvoeX@redhat.com> <arZZhpR5_nPybOUo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Not directly related to this patch but as an input to this discussion I'd 
like to bring to your attention how some people use AI now. With LLMs 
being able to do more, some users who have no idea about coding or QEMU 
internals but want to use QEMU for things that we could not deliver, now 
just maintain a fork and let the AI add features and fix bugs they find 
without ever contacting us or reporting these back. They now talk to the 
AI instead of us because they get faster results and achieve what they 
couldn't if they just waited for us to fix these issues or add the needed 
features. I've briefly looked at one such repo and the patches the AI 
makes are mostly nonsense but they also contain some actual fixes which at 
the end is good enough for these users as long as the result does what 
they want. But this could not be upstreamed by them anyway so they also 
don't intend to do that. This is not ideal and a strict no-AI policy leads 
to this practice becoming more common (although a less strict policy will 
also not stop this if the AI is faster to deliver what they need). 
Therefore I think we should allow some AI assisted contributions but we 
have to put a limit on the minimum quality and requiring that people who 
do such contributions have some idea of what they are doing and don't just 
flood the project with nonsense patches tries to do that. The proposal to 
require the human to review and describe the patches, sign the DCO (as a 
proof they did review the patch and know what's in it) and participate in 
review seems to be a good middle ground to protect the maintainers from 
slop but also not lock out people who can't do everything by themselves 
but could still make useful contribution with AI help.

Alternatively if we worry more about copyright the AI contributions could 
be restricted to bug fixes that are not rewriting large parts of the code 
and often are just a few lines that would not be copyrightable anyway. 
That still locks out new features added with AI help but at least we get 
notified about bugs they already fixed with AI even if at the end we 
decide to fix the bug in a different way. Maybe people would not even 
submit such patches if they can't just tell the AI to do it and they have 
to do it by hand but we can't lift that limitation without getting too 
much slop at this point.

All the above may resolve in a few years when these tools won't be freely 
available any more but some people are already paying for this so maybe it 
will stay that way and the "official" QEMU will just become one fork 
between the many AI managed ones.

Regards,
BALATON Zoltan

