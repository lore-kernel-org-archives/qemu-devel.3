Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460E606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwoY-0004ha-V4; Tue, 24 Nov 2026 15:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVwoW-0004cy-E9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:08:28 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xVwoU-00004q-CA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:08:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4E1E060CCE7;
 Tue, 24 Nov 2026 21:08:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HAT3y9udfLJq; Tue, 24 Nov 2026 21:08:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1DE5560C705; Tue, 24 Nov 2026 21:08:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C23713C290;
 Tue, 24 Nov 2026 21:08:22 +0100 (CET)
Date: Tue, 24 Nov 2026 21:08:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, peter.maydell@linaro.org, 
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 alex.bennee@linaro.org
Subject: Re: [PATCH v6 0/3] docs/devel, AGENTS.md: a completely new policy
 on AI-generated contributions
In-Reply-To: <20261124164217.1768040-1-pbonzini@redhat.com>
Message-ID: <d12847a0-4cbe-7d97-ffa8-653025b53d99@eik.bme.hu>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026, Paolo Bonzini wrote:
> As agreed in the community call, I'm posting a cleaned up version of
> v5 patches 1-3, not including the permission for pre-arranged large
> contributions.  However, the full text of AGENTS.md is included, as
> that can be a useful way to steer agents in our preferred direction,
> even for contributions not allowed by the policy.
>
> To be clear, I don't think this is a particularly useful intermediate
> step.  It all but encourages the same "don't ask, don't tell" behavior
> that we had until now, perhaps even more since it does not mention
> copyright anymore and therefore does not explain _why_ large contributions
> are disallowed.  Also like the current prohibition, we won't get any

In that case should we leave in the copyright problem which is still 
a valid concern to explain why we only allow small patches for now?

Regards,
BALATON Zoltan

> information other than gut feelings about when this happens.
>
> To avoid that, I would like to have already an informal process for
> evaluating AI-based contributions openly and on a case by case basis,
> to understand what their prevalence could be and the impact on maintainer
> review workloads.  (Personally, I'm more worried by a large amount of
> small contributions and no path towards getting help in consolidating
> them, than by a few large ones; but that may admittedly vary by subsystem).
>
> Nevertheless, I plan to send this as a pull request next week, and keep
> the rest for discussion in future months.
>
> All changes from v5 are to the commit messages, other than removing
> this sentence.
>
>  No such agent currently exists; in the future, such official
>  agents will be listed in the documentation.
>
> Paolo
>
> v5->v6: drop references to pre-arrangement in patch 1 commit message
>        drop examples of agent behavior that were done on previous versions
>        drop patch 4
>
> Paolo Bonzini (3):
>  docs/devel: relax policy on AI-generated contributions
>  AGENTS.md: let agents know what the participation rules are
>  AGENTS.md: make the human part of the design process
>
> docs/devel/code-provenance.rst |  71 ++----------
> docs/devel/index-process.rst   |   1 +
> docs/devel/llm-usage.rst       | 191 +++++++++++++++++++++++++++++++++
> AGENTS.md                      | 133 ++++++++++++++++++++---
> scripts/checkpatch.pl          |   5 +-
> 5 files changed, 321 insertions(+), 80 deletions(-)
> create mode 100644 docs/devel/llm-usage.rst
>
>

