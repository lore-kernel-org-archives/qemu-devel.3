Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyAAH-0004Df-17; Mon, 15 Sep 2025 10:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyAAE-0004Cp-4m
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:42 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1uyA9y-0000Jp-AW
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 10:26:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D301440694;
 Mon, 15 Sep 2025 14:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A03C4CEF1;
 Mon, 15 Sep 2025 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757946368;
 bh=C2jK1UFUtb8LaJFNih+XJciK25lF0de4y5xAZpbInJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZyC3l+XOuZTNl7SgDwLRuzYJ+jj1PM30v55sUhInAzQllch8vOIGpgNXIjw1eoxgP
 y3U8A8nWTGBIP28CsserT4T6kq3ezLerT0SxpjaiZA7YlYFmY2i25m57QvbpiZskIN
 q8hB52T9bqTYq+rbFjqiebgJ9IIeBp/VBXFOPiVhd79P1ZUPgNoxyGtKqloFPcywqq
 0Zlk20/J8BnhQifvv6HQWVpzCAct21i31mwDPR70pfzpZTlLDx5fN+lHYJbZtldt6p
 C6oUiMtWh1LFu4Ge6vyx+tOEXoA6EAQ7kPAlRuhoYaPhc6d8u0HKbzxMegk/sWgM60
 /swHXglUau/2g==
Date: Mon, 15 Sep 2025 19:55:02 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm@vger.kernel.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [RFC PATCH 3/7] target/i386: SEV: Add support for enabling
 debug-swap SEV feature
Message-ID: <m5fnfafkzxqamg4iyc6xjun7jlxulcuufgugtrweap6myvmgov@5cmxu5n3pl2p>
References: <cover.1757589490.git.naveen@kernel.org>
 <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
 <87jz239at0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz239at0.fsf@pond.sub.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Markus,

On Fri, Sep 12, 2025 at 01:20:43PM +0200, Markus Armbruster wrote:
> "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> 
> > Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
> > SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
> > objects. Though the boolean property is available for plain SEV guests,
> > check_sev_features() will reject setting this for plain SEV guests.
> 
> Let's see whether I understand...
> 
> It's a property of sev-guest and sev-snp-guest objects.  These are the
> "SEV guest objects".
> 
> I guess a sev-snp-guest object implies it's a SEV-SNP guest, and setting
> @debug-swap on such an object just works.
> 
> With a sev-guest object, it's either a "plain SEV guest" or a "SEV-ES"
> guest.
> 
> If it's the latter, setting @debug-swap just works.
> 
> If it's the former, and you set @debug-swap to true, then KVM
> accelerator initialization will fail later on.  This might trigger
> fallback to TCG.
> 
> Am I confused?

You're spot on, except that in the last case above (plain old SEV 
guest), qemu throws an error:
	qemu-system-x86_64: check_sev_features: SEV features require either SEV-ES or SEV-SNP to be enabled

> 
> > Add helpers for setting and querying the VMSA SEV features so that they
> > can be re-used for subsequent VMSA SEV features, and convert the
> > existing SVM_SEV_FEAT_SNP_ACTIVE definition to use the BIT() macro for
> > consistency with the new feature flag.
> >
> > Sample command-line:
> >   -machine q35,confidential-guest-support=sev0 \
> >   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on
> >
> > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 830cb2ffe781..71cd8ad588b5 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1010,13 +1010,17 @@
> >  #     designated guest firmware page for measured boot with -kernel
> >  #     (default: false) (since 6.2)
> >  #
> > +# @debug-swap: enable virtualization of debug registers (default: false)
> > +#              (since 10.2)
> 
> Please indent like this:
> 
>    # @debug-swap: enable virtualization of debug registers
>    #     (default: false) (since 10.2)

Sure.

Thanks for the review,
- Naveen


