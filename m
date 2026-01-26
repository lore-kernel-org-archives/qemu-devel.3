Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F185D13C34
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOc2-000389-Vp; Mon, 26 Jan 2026 10:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1vkNiU-0002gQ-S8
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:37:22 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1vkNiT-0005eB-FA
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 09:37:22 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C5C743BDD;
 Mon, 26 Jan 2026 14:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0506EC116C6;
 Mon, 26 Jan 2026 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769438238;
 bh=tzJ0soplydFym6XlPZKnariJVCtKf+HTw+CnOyHS+UA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ngC+ChN0yRJuTZgIvxBSv/H1HH0zPl+0X/4eExBSuWcEGtN08BkkJbNsr7Zra9Li3
 5WoQli5W4m6MzFmbbdRirt7tdeviw9YzFjdB7cmF2RS89bmdv+WjuI9f9vnT/yxhKW
 a0S8BrXe5h2I4eZnvl5kgs3gfj6T3ERJWgLbE4q4mF5Prqjk/jEUc/n5lRaEx0vM7T
 SK26OvopCq6G28Vhe0Ok9NxurklXniIl2cTrTXMI0yTeKhHLLwPBe6x/n76bBEWJ7k
 tohZb1Et9C3+OPGCO8Q/iCBIoK359FyLyDowH4dU8hdeTLxwmhb0nggCZ+1UNSiMLn
 WlasxSv+rac+g==
Date: Mon, 26 Jan 2026 09:37:15 -0500
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
Message-ID: <20260126-wonderful-notorious-coati-e91a5e@lemur>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
 <87343wmhki.fsf@draig.linaro.org>
 <CANCZdfpFZ6uwSURZOJgRFRXh=+xngi2CUVj-PMpg860O4x_Avw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfpFZ6uwSURZOJgRFRXh=+xngi2CUVj-PMpg860O4x_Avw@mail.gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=konstantin@linuxfoundation.org; helo=sea.source.kernel.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Jan 2026 10:34:38 -0500
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

On Fri, Jan 23, 2026 at 03:09:24PM -0700, Warner Losh wrote:
> > I'd be interested in knowing where the pain points are for you because
> > modern tools like b4 make some of the grind (collecting tags and
> > applying patches from ML) a lot easier.
> 
> I've tried setting up b4 before. I'll have to try again.

I'll be happy to hear of any parts of the configuration process that weren't
obvious.

> > Usually the most difficult thing is getting email setup so you can
> > git-send-email or git-publish.
> >
> 
> The most difficult part for me is 'where the heck did google hide the
> password
> junk today' so I can turn on a password, do the submission, then kill the
> password.
> I really wish I could do OTP sometimes.

You can use the web submission endpoint with b4 submit.

-K

