Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NqUDhWNl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiSh-0005UQ-46; Tue, 27 Oct 2026 10:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLiSa-0005TX-5N
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLiSX-0007C7-Ar
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793112446;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8GrDsLRiJPaIhSzzKanfkCUP6BbyMIBjC3PCmBPbxw=;
 b=NqUDhWNlthgvEWpnNYjOYBroyfcUnmp5a3H9CsEDqaunNlQ+LqDdT3jhGaEykoxwfTU1Ze
 +Z0rVB5wiOvbwDYanhOasA9aGba2Tb65F6WtMlMujnyxf4DQiBRc+40lnBCuld7FTQhwnJ
 YHfa8HwyNQGcam/NyAIXn1zp7vzppzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-vZyPcORyMOO2KKXRrE1zlQ-1; Tue,
 27 Oct 2026 10:47:25 -0400
X-MC-Unique: vZyPcORyMOO2KKXRrE1zlQ-1
X-Mimecast-MFC-AGG-ID: vZyPcORyMOO2KKXRrE1zlQ_1793112444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB2F1802577; Tue, 27 Oct 2026 14:47:24 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C1D195608A; Tue, 27 Oct 2026 14:47:22 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:47:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PULL 02/14] qapi: add 'insecure-types' option for -compat
 argument
Message-ID: <auC5d5KoWqEMEomR@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
 <20260917160525.1275388-3-berrange@redhat.com>
 <877bj3a33b.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877bj3a33b.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:46:00AM +0100, Markus Armbruster wrote:
> This has long been merged.  I couldn't review it at the time, and
> merging it without my review was clearly appropriate.
> 
> I have questions / doubts about the external interface I'd like to
> discuss now.

... just in time for freeze if we need any urgent changes
before this gets into a release.

> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This introduces a new 'insecure-types' option for the 'compat'
> > argument that accepts three values
> >
> >  * accept: Allow any usage
> >  * reject: Reject with an error reported
> >  * warn: Allow any usage, with a warning reported
> >
> > For historical compatibility it defaults to 'accept'.
> >
> > The 'reject' and 'warn' values will take effect for any type
> > that has been explicitly marked insecure, or is lacking an
> > explicit declaration of its security status.
> >
> > This new command line option is currently a no-op, but will
> > become functional as following patches enable the checks.
> >
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

snip

> > diff --git a/qapi/compat.json b/qapi/compat.json
> > index 90b8d51cf27..b54f8eb3713 100644
> > --- a/qapi/compat.json
> > +++ b/qapi/compat.json
> > @@ -37,6 +37,23 @@
> >  { 'enum': 'CompatPolicyOutput',
> >    'data': [ 'accept', 'hide' ] }
> >  
> > +##
> > +# @CompatPolicySecurity:
> > +#
> > +# Policy for handling any devices or backends which do not provide a
> > +# security boundary to protect against untrusted environments
> > +#
> > +# @accept: Allow any usage
> > +#
> > +# @reject: Reject with an error reported
> > +#
> > +# @warn: Allow any usage, with a warning reported
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'enum': 'CompatPolicySecurity',
> > +  'data': [ 'accept', 'reject', 'warn' ] }
> > +
> >  ##
> >  # @CompatPolicy:
> >  #
> > @@ -62,10 +79,14 @@
>    # Policy for handling deprecated management interfaces.
>    #
>    # This is intended for testing users of the management interfaces.
>    #
>    # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
>    # with feature 'deprecated' or 'unstable'.  We may want to extend it
>    # to cover semantic aspects and CLI.
>    #
>    # Limitation: deprecated-output policy @hide is not implemented for
>    # enumeration values.  They behave the same as with policy @accept.
>    #
>    # @deprecated-input: how to handle deprecated input (default 'accept')
>    #
>    # @deprecated-output: how to handle deprecated output (default
>    #     'accept')
>    #
>    # @unstable-input: how to handle unstable input (default 'accept')
>    #     (since 6.2)
>    #
> >  # @unstable-output: how to handle unstable output (default 'accept')
> >  #     (since 6.2)
> >  #
> > +# @insecure-types: how to handle types that are not declared secure
> > +#     (default 'accept') (since 11.2)
> 
> Minor issue: "types" is ambiguous without context.  We call lots of
> things "types" in our external interfaces.  It's actually QOM types
> here.  Let's say so.  I can take care of it.
> 
> Similar confusion exists elsewhere[*], but let's not digress.

It is currently  QOM types. It might even stay exclusively QOM types,
but not guaranteed.

The initial focus is mostly on guest visible pieces (-device, -machine)
with '-object' as an easy extra win that's more backend oriented.

In theory it might be extended to other backend types, which are probably
modelled in QAPI, but are not neccessarily implemented with QOM. So I
somewhat intentionally left it fuzzy what 'types' we refer to.

> >  # Since: 6.0
> >  ##
> >  { 'struct': 'CompatPolicy',
> >    'data': { '*deprecated-input': 'CompatPolicyInput',
> >              '*deprecated-output': 'CompatPolicyOutput',
> >              '*unstable-input': 'CompatPolicyInput',
> > -            '*unstable-output': 'CompatPolicyOutput' } }
> > +            '*unstable-output': 'CompatPolicyOutput',
> > +            '*insecure-types': 'CompatPolicySecurity' } }
> 
> The existing members are all named "wide", and the documentation narrows
> them.  For instance, the name @deprecated-input could cover *any* input,
> but its documentation narrows it to "only syntactic aspects of QMP".  I
> did it this way to let us extend coverage without having to change the
> external interface.
> 
> New member @insecure-types is named "narrow".  Why different?  Why not
> @insecure-input?

In those existing examples, we're directly refering to data streams,
whether they're command line / QMP parameters or QMP response, so
input/output are reasonable terms.

In the security status, we specifically focused on types, regardless
of whether they're requested explicitly via -device (& friends) or
arrive implicitly via built-in command line defaults and/or hardcoded
type relationships (ie built devices in a machine type).  I don't
find 'input' to be a desired term in that respect.

What is being determined is whether the VM as a whole can be classed
as secure or not.

> The existing @FOO-input support CompatPolicyInput: "accept", "reject",
> "crash".  New insecure-types supports CompatPolicySecurity: "accept",
> "reject", "warn".  Why different?

With deprecations, there is often (but not always) a warning message
printed unconditioally. eg even if you have 'accept' as policy, you
are liable to see a deprecation warning message on stderr. This is
good because even if you want to carry on using it for now, and
never give a -compat flag, actioning the deprecation warning is
still essential.


With security checks, it is valid to launch QEMU in an insecure
configuration and use it that way forever, with no action required
to change anything. As such we must never report any warnings by
default for insecure types, any warning messages must be strictly
opt-in.  So "accept" is the default behaviour which is totally
silent, "warn" lets you know something is bad but does not
enforce it, and "reject' lets you know something is bad and
refuses to let it be used. So overall, I think "warn" is justified
for security checks, while not required for deprecations.

> My rationale for "crash" is in commit dbb675c19aa (qapi: New -compat
> deprecated-input=crash):
> 
>     Bugs in integration tests may mask the error from policy "reject".
>     Provide a larger hammer: crash outright.  Masking that seems unlikely.
> 
> If "crash" can be useful for testing a management application's non-use
> of deprecated and unstable interfaces, surely it's just as useful for
> insecure ones.

I'm happy to add 'crash' as an extra option.

> Likewise, "warn".  I didn't provide "warn" at the time, because QMP
> lacks support for warnings.  Do management applications find warnings on
> stderr in response to QMP commands useful?

Many deprecations none the less report warnings on stderr - we just
haven't automated that process from QAPI schema.

I've seen plenty of scenarios where people have paid attention to
the deprecation warnings in libvirt logs capturing QEMU's stderr.
It is likely the main way that non-developers find out about the
deprecations, as few people proactively read the QEMU docs to
see deprecations, and similarly few use a -compat arg.


For the security compat arg, my expectation was that distros which
wish to restrict what their ship & support (ie RHEL) could use
the -compat insecure-types arg to validate their configs, and
could even set libvirt in their distro to pass 'warn' (or even
'reject') as a safety net against mistakes.

I think it would also be interesting for virt-install (and similar
tools) to request secure types only by default, at least if KVM
is used.

> -util.c b/qapi/qapi-util.c
> > index 3d849fe0347..38b1cec7a41 100644
> > --- a/qapi/qapi-util.c
> > +++ b/qapi/qapi-util.c
> > @@ -14,6 +14,7 @@
> >  #include "qapi/compat-policy.h"
> >  #include "qapi/error.h"
> >  #include "qemu/ctype.h"
> > +#include "qemu/error-report.h"
> >  #include "qapi/qmp/qerror.h"
> >  
> >  CompatPolicy compat_policy;
> > @@ -58,6 +59,35 @@ bool compat_policy_input_ok(uint64_t features,
> >      return true;
> >  }
> >  
> > +bool compat_policy_check_security(const CompatPolicy *policy,
> > +                                  const char *typename,
> > +                                  bool is_secure,
> > +                                  Error **errp)
> 
> More minor issues.
> 
> The policy functions are named compat_policy_FOO_ok().  Why different?

I wasn't paying close enough attention to the naming convention.

> Their arguments are "relevant facts" (@features), @policy, "stuff for
> error message" (@error_class, @kind, @name), @errp.  This one has the
> same things in different order.  Why?

Same lack of close attention as above.

Though I would say I think the 'const CompatPolicy *policy' arg should
be the first one in all the existing methods, as it is typical convention
for the first arg type to be associated with the method name.

> 
> > +{
> > +    if (is_secure) {
> > +        return true;
> > +    }
> > +
> > +    switch (policy->insecure_types) {
> > +    case COMPAT_POLICY_SECURITY_ACCEPT:
> > +        return true;
> > +
> > +    case COMPAT_POLICY_SECURITY_REJECT:
> > +        error_setg(errp, "Type '%s' does not provide a security boundary "
> > +                   "to protect against untrusted data or actions", typename);
> > +        return false;
> > +
> > +    case COMPAT_POLICY_SECURITY_WARN:
> > +        warn_report("Type '%s' does not provide a security boundary "
> > +                    "to protect against untrusted data or actions", typename);
> > +        return true;
> > +
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +}
> > +
> > +
> >  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
> >  {
> >      assert(val >= 0 && val < lookup->size);
> 
> 
> [*] So I digress in a footnote.  Sue me ;)
> 
> While examining the QAPI schema, I found near object-add:
> 
>     ##
>     # @qom-list-properties:
>     #     List properties associated with a QOM object.
>     #
>     # @typename: the type name of an object
>     [...]
>     ##
>     # @object-add:
>     #     Create a QOM object.
>     #
>     # Errors:
>     #     - If @qom-type is not a valid class name
>     [...]
>     ##
>     # @ObjectOptions:
>     #     Describes the options of a user creatable QOM object.
>     #
>     # @qom-type: the class name for the object to be created
> 
> We use "QOM type" and "QOM class".  This is pretty bad; we should pick
> one and stick with it.

Probably "type" since there is no concept of a "class" in QAPI,
it is just a schema for describing types and their relationships.

The 'class' is an internal QOM implementation detail of the
public QAPI 'type'.

> And near device_add:
> 
>     ##
>     # @device-list-properties:
>     #     List properties associated with a device.
>     #
>     # @typename: the type name of a device
>     [...]
>     ##
>     # @device_add:
>     #     Add a device.
>     #
>     # @driver: the name of the new device's driver
> 
> We use "driver" and "device type".  Similarly bad.

Kind of wish we just used a plain 'type' in both -object and -device,
but changing that is not worth the disruption. At least the docs
could refer to 'QOM type' generally.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


