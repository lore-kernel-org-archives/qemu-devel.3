Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E5BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoeC-00043r-Uf; Tue, 13 May 2025 08:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEodp-0003yE-Rt
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEodi-0006PE-JQ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747138899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xL/BoQEOMKsrKAAGIHD3FVU48g5wI98EXn1Zh2p4Lk=;
 b=B8w8O1hytyVrLGdNU2xSyJWFnySqkn9zlb0mZu53OYj64z1ns/FzgWFKY0ANZp87pvXOqW
 ffqRBq3Kry9G2OGFcXjOQ/nuvhKc3SSbNN/oMO55+11IqXldgf+FEz88u2EIN+Ko09t5bH
 WxXg4imEZIG/S+lhZK6Ab7B1JWwQWoA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-hx3ZKAxEMJCbXApThB_4dQ-1; Tue,
 13 May 2025 08:21:35 -0400
X-MC-Unique: hx3ZKAxEMJCbXApThB_4dQ-1
X-Mimecast-MFC-AGG-ID: hx3ZKAxEMJCbXApThB_4dQ_1747138894
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B30091800873; Tue, 13 May 2025 12:21:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7091030002E3; Tue, 13 May 2025 12:21:32 +0000 (UTC)
Date: Tue, 13 May 2025 13:21:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/10] qapi: expand docs for SEV commands
Message-ID: <aCM5SLt6m-bcS15B@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-3-berrange@redhat.com>
 <8734d8emun.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734d8emun.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 13, 2025 at 02:06:40PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This gives some more context about the behaviour of the commands in
> > unsupported guest configuration or platform scenarios.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> > index 5d0ffb0164..ae55e437a5 100644
> > --- a/qapi/misc-target.json
> > +++ b/qapi/misc-target.json
> > @@ -110,7 +110,11 @@
> >  ##
> >  # @query-sev:
> >  #
> > -# Returns information about SEV
> > +# Returns information about SEV/SEV-ES/SEV-SNP.
> > +#
> > +# If unavailable due to an incompatible configuration the
> > +# returned @enabled field will be set to 'false' and the
> > +# state of all other fields is undefined.
> 
> That's awful.  Not this patch's fault.

Yep, IMHO, all the fields except 'enabled' should have been
optional, and omitted when @enabled==false. Probably too
later 


> What's "incompatible configuration"?

Essentially it'll only set values for the extra fields
beyond @enabled when a configuration includes the
following:

  '-object sev-guest,id=sev -machine ...,confidential-guest-support=sev"

(or sev-snp-guest object)

> Actual behavior as far as I can tell:
> 
> * If !CONFIG_SEV: GenericError "SEV is not available in this QEMU".
> 
> * If CONFIG_SEV and !sev_enabled(): SevInfo filled with zero bytes

Having these two scenarios be different feels wrong to me - they
are both "SEV not enabled" scenarios IMHO, and whether or not
SEV is enabled should be irrelevant.

A difference is justified in query-sev-capabilities as that's
a feature probing method, where as this one is a runtime state
query method.

> * If CONFIG_SEV and sev_enabled(): SevInfo filled properly
> 
> sev_enabled() is true when the machine's cgs member is an instance of
> "sev-common".

Yep.

> > @@ -185,8 +198,9 @@
> >  ##
> >  # @query-sev-capabilities:
> >  #
> > -# This command is used to get the SEV capabilities, and is supported
> > -# on AMD X86 platforms only.
> > +# This command is used to get the SEV capabilities, and is only
> > +# supported on AMD X86 platforms with KVM enabled. If SEV is not
> > +# available on the platform an error will be returned.
> 
> What does "not supported" mean here?

Any of at least:

 * Not x86 system target
 * Not KVM accelerator
 * No SEV in host kernel
 * No SEV in host CPUs
 * SEV not enabled in host UEFI
 * /dev/sev device not accessible / not present



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


