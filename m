Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B60E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJLu-00039g-Oo; Thu, 05 Dec 2024 16:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJLq-00035B-QS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:25:35 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tJJLp-0005RU-BK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:25:34 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 460A717F8B6
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 22:25:31 +0100 (CET)
Received: (qmail 6620 invoked by uid 990); 5 Dec 2024 21:25:31 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 05 Dec 2024 22:25:31 +0100
MIME-Version: 1.0
Date: Thu, 05 Dec 2024 21:25:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <43c67eb2b1fefe818b24a5a8ea575a4c8afa4f3d@nut.email>
TLS-Required: No
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related to
 certain discontinuities
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
In-Reply-To: <c8b34d17-a619-456b-8f6c-ffe0cee027e3@linaro.org>
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
 <67c879bcd5520d6f7bdf30b5f773436678ca8df7@nut.email>
 <c8b34d17-a619-456b-8f6c-ffe0cee027e3@linaro.org>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-3) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:subject:date;
 bh=YCklGVnjz5uuxnRORFh8hRasWKdZ2tPiHAad6Fj5hgU=;
 b=QvUe3qZhNnLVMcPwlWgeyh9bKeLtHVWWQ7dN1BxquLUndcUghw5GQjeeUGqrYXX6aPGHlwev6T
 zTTgCVauxTsClynsNTrlPMQ8lTkXoh7otUNgokEhuzicjSuFIKwHonBVRORGcDfJasbcxLZL4O37
 IYajLf5wVbWeCFA6TSpWYCEh8Gtr1p1LTlUf4LclQ9gvHZibIiWLZZ8Bwpd4IaPyXTBFBGNdENYG
 wGh3veabd67C3PNLk7zwDoPtWWyWwPWWhEybAQeOUZbguO3gNUMpZDWa074E68l5V4LxKotRSIDa
 WFdF4TyJA3217JaK01m7Hquc17VUALnAdHSXVKyVcWvQe64M9tsu2xW9av3cMds6l7zS2gTOV8Ed
 iJgRCMeugEVd7CsEgxfSrsSy5RmgT+WKl0oRKfveOuFFEpQy5O7K3eKJgl2OHNz8szgXSIzl4mgi
 rT/F5Nyy0QjsGzJdVNQdZyH1Fz8UUDHnZvIjzMLtYvglZO7cFn/uBv8ZzRhQ+7Wnqy3CbHpPhgBg
 E2uZpxpK8/ASw9iMqJ1/9D15rB6SLtmsK5wRhcHg9XJUvTfAtwnwymqyxrfOE/ox4MsbEnlMpmpu
 7VUm0iECFhMkvZA8Dol0paAKqTsgUH9RCCUcYzeiI/TsHSIraXtr9VeiF5A5t7bIYbJz4Sq+bxQX
 8=
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

December 5, 2024 at 6:35 PM, "Pierrick Bouvier" wrote:
> On 12/5/24 04:44, Julian Ganz wrote:
>=20
>=20>=20
>=20> Hi Pierrick,
> >  December 4, 2024 at 11:45 PM, "Pierrick Bouvier" wrote:
> >=20
>=20> >=20
>=20> > On 12/2/24 11:26, Julian Ganz wrote:
> > >=20
>=20>  include/qemu/plugin.h | 1 +
> >  include/qemu/qemu-plugin.h | 43 ++++++++++++++++++++++++++++++++++++=
++
> >  2 files changed, 44 insertions(+)
> >  diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> >  index 9726a9ebf3..27a176b631 100644
> >  --- a/include/qemu/plugin.h
> >  +++ b/include/qemu/plugin.h
> >  <snip>
> >  +
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
>=20> >=20
>=20> > Missing those parameters when building doc.
> > >  include/qemu/qemu-plugin.h:198: warning: Function parameter or mem=
ber 'id' not described in 'qemu_plugin_vcpu_discon_cb_t'
> > >  include/qemu/qemu-plugin.h:289: warning: Function parameter or mem=
ber 'type' not described in 'qemu_plugin_register_vcpu_discon_cb'
> > >  2 warnings as Errors
> > >=20
>=20>  Yes, I forgot about id. But type is clearly documented. Maybe the =
tool
> >  is confused about the name and thinks it's a reserved word or someth=
ing?
> >  In that case I better change that to something else.
> >=20
>=20The type (qemu_plugin_discon_type) is documented, but the parameter "=
type" is not. Even if the name is correctly chosen, you still need to mak=
e it appear in the doc.

Yes. I didn't realize that the two warnings were for different entities
because I somehow failed to parse the entire line.

Regards,
Julian Ganz

