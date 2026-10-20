Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAC60A2613
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=CzmTPRpI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ9LK-0004UR-5a; Tue, 20 Oct 2026 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xJ9LG-0004UJ-KL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:53:22 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xJ9LD-00076H-7U
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=CcrmvAJwpxECJBpeEWtnso+piTsBWCgpVdV02di476I=; b=CzmTPRpIG0nZl+xB
 Q9mEqpBRDPa/Kil+VWJE+ZZ8J7vdjJBx5AiJW1aIJToQqqBI82UFyIE0ELbHsMFklSJgNsisagZNq
 IL46Rr+mkwE37zzGdeaVXYlrPYuTq47dV9x+jHILKNZ5fza6PJUfgdjdli4GWyuf279n+5HjkIIfb
 2JnaPq3y++atlbjvH8uM0NS3PNSyrof9eEsG7E+2PkeR16sVj2fBAdMHlYQVpxcifaHFULngaVQpL
 o7EEm25EhZcVEJKFCCZZQMsZCZswsk/vl79jsE0XeE8rs1cSf2+kHw5sy0BxH/Ab7EVBebNfJwK09
 77RT+pnJxyDWogL33Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xJ9L4-000000015VP-0kZW;
 Tue, 20 Oct 2026 12:53:10 +0000
Date: Tue, 20 Oct 2026 12:53:10 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] system: Remove deprecated '-name foo, debug-threads=...'
 option
Message-ID: <atdkNjYyvigwU14g@gallifrey>
References: <20261018232917.7716-1-philmd@oss.qualcomm.com>
 <atcpgXk-rQ5m1PDK@jtomko.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atcpgXk-rQ5m1PDK@jtomko.csb>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.113+deb13-amd64 (x86_64)
X-Uptime: 12:52:40 up 3 days, 22:13, 2 users, load average: 0.14, 0.08, 0.03
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Ján Tomko (jtomko@redhat.com) wrote:
> On a Monday in 2026, Philippe Mathieu-Daudé via qemu development wrote:
> > 'debug-threads' option for -name was deprecated in v11.0
> > (commit 1b65aeed2a0 "system: unconditionally enable thread
> > naming") thus can now be removed.
> > 
> 
> libvirt patch sent:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/E5HZUYURWU3JCQSXQJEM3HLW52KUQPKB/
> 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > ---
> > docs/about/deprecated.rst             |  7 -------
> > docs/about/removed-features.rst       |  9 +++++++--
> > system/vl.c                           | 11 -----------
> > tests/qtest/migration/framework.c     |  4 ++--
> > tests/qtest/migration/precopy-tests.c |  2 +-
> > qemu-options.hx                       |  7 +++----
> > 6 files changed, 13 insertions(+), 27 deletions(-)
> > 
> 
> Reviewed-by: Ján Tomko <jtomko@redhat.com>

Nice to get rid of it.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> 
> Jano
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

