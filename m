Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB89AE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 12:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBE4-0007cc-IW; Thu, 05 Dec 2024 07:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBE0-0007cJ-4M
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:44:56 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJBDy-0004uu-Cc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 07:44:55 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id C70E7180C03
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 13:44:50 +0100 (CET)
Received: (qmail 24588 invoked by uid 990); 5 Dec 2024 12:44:50 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 13:44:50 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 12:44:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <67c879bcd5520d6f7bdf30b5f773436678ca8df7@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=1M8donBU9ahkY6sUyeZu+lPHuEFNgFjlgqLrY7S9tCc=;
 b=atApeZTHWsIjVJju0BZVPZxponqGZZEyNssOdGiD1o9UKxXa7AkTQkg3i71633jmTwsr2lbtwz
 xlyzGYYKyGlkrckrPnX2TxJ7O7QNAIXZlEn7pPhubsSpZYUkMkaKae37JIyaVygN9KT9OGwbfLtI
 QUcQFVroQkig+nKqyJJ1pzxl2zmLrzI9Vp/0VsrRS8CHkD1d5inLFzgImr8rMiGxtiuI0U4m3uL7
 xNVAyjd4gbgHe3qXJVCD9oRgXso8AAwHvSKBB+wr4h+aV7OXmtw0sF2scs2wOBJ/VIunsGafM3c7
 nM/bVJHgtRTG+ZMWA3MGyU6HoH6gxFuuAtNLtdeNHlKfw3hLwKn35DFh2kXJy8ZjqS6HQWbBu1i3
 LlWvzb82sCNNV22wgheRsM6GRcaw6hzgLkhgOlfwuyFlzEUUvlJ5EKtBDk4GmKNvPPsSx6bDyNO2
 FFbY4JZc6jKZLgQUX9e5coVxr5BRuv7+kCaqzg9UaJCoGcRH1sPXv9I+09pdhgYju3gJn8GbDIEL
 D8xdFoPfQ/daPjtrzEw7DLVoomUDqz+e1d5v6LOdYCOYqIc9XQmCJJ1gEYr7lSvn5E/Op66EVFgB
 dR8fin7ldnB72KBIT5XmCPANO0o32/mXayfLrBjxze/G+sR2J3deWTRj44ydmDtziQxlH6Sdb9NE
 Y=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Pierrick,

December 4, 2024 at 11:45 PM, "Pierrick Bouvier" wrote:
> On 12/2/24 11:26, Julian Ganz wrote:
> >  include/qemu/plugin.h | 1 +
> >  include/qemu/qemu-plugin.h | 43 ++++++++++++++++++++++++++++++++++++=
++
> >  2 files changed, 44 insertions(+)
> >  diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> >  index 9726a9ebf3..27a176b631 100644
> >  --- a/include/qemu/plugin.h
> >  +++ b/include/qemu/plugin.h
<snip>
> > +
> >  +/**
> >  + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callba=
ck
> >  + * @vcpu_index: the current vcpu context
> >  + * @type: the type of discontinuity
> >  + * @from_pc: the source of the discontinuity, e.g. the PC before th=
e
> >  + * transition
> >  + * @to_pc: the PC pointing to the next instruction to be executed
> >  + *
> >=20
>=20Missing those parameters when building doc.
> include/qemu/qemu-plugin.h:198: warning: Function parameter or member '=
id' not described in 'qemu_plugin_vcpu_discon_cb_t'
> include/qemu/qemu-plugin.h:289: warning: Function parameter or member '=
type' not described in 'qemu_plugin_register_vcpu_discon_cb'
> 2 warnings as Errors

Yes, I forgot about id. But type is clearly documented. Maybe the tool
is confused about the name and thinks it's a reserved word or something?
In that case I better change that to something else.

And note to self: also test-biuld the docs next time.

Regards,
Julian Ganz

