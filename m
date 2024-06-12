Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4141AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHOx6-0000uX-Ug; Wed, 12 Jun 2024 10:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHOx4-0000oY-JS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:27:50 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1sHOx2-0000RE-8w
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:27:50 -0400
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 8D9C54073CEB;
 Wed, 12 Jun 2024 14:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8D9C54073CEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1718202464;
 bh=szqoqOVA/fGsYuoahLeAXh3ebM+0iS2cfKVMzur9gXA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=tuX1WV997bGIj6pqkRdYaj+Ay/YhlW2WgMY2rmbq0l9+zUdPUrvUObAsbqs/K/iPw
 ADhu1nJgKpnzeSQV3YLbfnerzl3EfB7QfTl1mTGxHRk5OdcVIEKGDCkHqZey9vKkxg
 kCkEy1PSbSGmhCaaS6GuFBieHhqG9oRCWuhsFjnk=
Date: Wed, 12 Jun 2024 17:27:44 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
In-Reply-To: <CABgObfbPu10_jEuT2sEHJmF91Vov9M7bTmLR9dQXRR5gicNF5Q@mail.gmail.com>
Message-ID: <86bc893e-12cf-3dd2-32e6-66ebd9887e77@ispras.ru>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
 <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
 <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
 <e292326a-0f71-3d4d-4ec1-562efe94271b@ispras.ru>
 <CABgObfZEmA6DrN-8f_nTg8DHfN+m7DO+DbabW1AtdtMtHjbgyQ@mail.gmail.com>
 <b5fac5cc-40af-2437-44c4-4e0d5747691d@ispras.ru>
 <CABgObfbPu10_jEuT2sEHJmF91Vov9M7bTmLR9dQXRR5gicNF5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-380214561-1718202464=:10393"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--8323328-380214561-1718202464=:10393
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Wed, 12 Jun 2024, Paolo Bonzini wrote:

> On Wed, Jun 12, 2024 at 3:34 PM Alexander Monakov <amonakov@ispras.ru> wrote:
> > On Wed, 12 Jun 2024, Paolo Bonzini wrote:
> > > > I found out from the mailing list. My Core2-based desktop would be affected.
> > >
> > > Do you run QEMU on it? With KVM or TCG?
> >
> > Excuse me? Are you going to ask for SSH access to ensure my computer really
> > exists and is in working order?
> 
> Come on. The thing is, I'm not debating the existence of computers
> that don't have x86_64-v2, but I *am* debating the usefulness of
> making QEMU run on them and any extra information can be interesting.

I think it will be useful to me, with KVM and TCG both.

> > Can you tell me why you never commented on buffer_is_zero improvements, where
> > v1 was sent in October?  Just trying to understand how you care for 2% of L1D
> > use but could be ok with those kinds of speedups be dropped on the floor.
> 
> I'm not sure if there is any overlap in the scenarios where
> buffer_is_zero performance matters, and x86 emulation. People can care
> about thing A but not thing B. If there's anything that you think I
> can help reviewing, feel free to let me know offlist.

In that case I would've appreciated an early indication you're not interested,
making Cc'ing you on followups unnecessary.

Alexander
--8323328-380214561-1718202464=:10393--

