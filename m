Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17592CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXE9n-00008U-2I; Wed, 10 Jun 2026 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXE9h-000075-7X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:19:21 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wXE9f-0001kR-4F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:19:20 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E1EF433CF;
 Wed, 10 Jun 2026 08:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B21F00893;
 Wed, 10 Jun 2026 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781079550;
 bh=OULYz7kvtwcbi+bYznmSOCkch57XhD0I1I9d0hEInvA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R06RuhDsygpO9HK1DQx0WxtZlilzpjvKCwwMg5xAWbz5fUKr50Aa2TNrSthYx376J
 9E60c9XI78jKooSCcM0awCiDDSOxKWsrkE344bAhKnMPgWSgaU/JgK5tD51YmGvSGK
 8hBOXJYO2oxFXeIxQSrqG7GWd2o0ByHuyO51VxGwXD3YXzb6zqXhTxBMudMuUgSZ37
 O8zYiZq9bMPEw3OlwVp4zcDhrw3GnWuXEEh2LLerPgOATTeaqmu+idbQXuZq7mJMuc
 vaGrEmKtOoPtECWkNboqpgMONHbddRAnHSai5CzUKiqUAm0nYjI2oBWOh1T0AtPt5k
 c8B7EblFfirJg==
Date: Wed, 10 Jun 2026 13:43:52 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, Kim Phillips <kim.phillips@amd.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 2/9] target/i386: SEV: Ensure SEV features are only
 set through qemu cli or IGVM
Message-ID: <aikYQ3HW52rWMAAC@blrnaveerao1>
References: <cover.1779281646.git.naveen@kernel.org>
 <6939de99f13d7170af68b74e711eb9f03f32f682.1779281646.git.naveen@kernel.org>
 <aifZY1h55L4jxGeO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aifZY1h55L4jxGeO@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Tue, Jun 09, 2026 at 10:14:11AM +0100, Daniel P. Berrangé wrote:
> On Wed, May 20, 2026 at 06:57:55PM +0530, Naveen N Rao (AMD) wrote:
> > In preparation for qemu being able to set SEV features through the cli,
> > add a check to ensure that SEV features are not also set if using IGVM
> > files.
> > 
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > ---
> >  target/i386/sev.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 22c350fe14b7..641a295c42b7 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -1908,6 +1908,16 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >           * as SEV_STATE_UNINIT.
> >           */
> >          if (x86machine->igvm) {
> > +            /*
> > +             * Test only the user-set SEV features by masking out
> > +             * SVM_SEV_FEAT_SNP_ACTIVE which is set by default.
> > +             */
> > +            if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
> > +                error_setg(errp,
> > +                           "%s: SEV features can't be specified when using IGVM files",
> > +                           __func__);
> 
> IMHO, including __func__ in error messages is redundant / undesirable.
> The error msg  alone should be sufficient to diagnose problems.

Understood. Markus had a similar concern, though this is just following 
the pattern in other messages in this function.

In fact, I checked and there are 40-odd uses of __func__ in 
target/i386/sev.c, so this looks to be a common pattern used for SEV.  I 
can submit a separate cleanup patch (independent of this series) if you 
think we should make this change throughout.

> Perhaps we should include the actual feature values though
> 
>                            "SEV features 0x%x can't be specified when using IGVM files",
>                            sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE);
> 
> this case, however, you should report which features are not permitted

Sure, I can incorporate your suggested change above unless you wanted 
the individual SEV features to be called out/named?

I will wait for further feedback on this series before making that 
change.


Thanks,
Naveen


