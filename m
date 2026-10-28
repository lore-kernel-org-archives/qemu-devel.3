Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFD+/94m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLztC-0006Jw-D9; Wed, 28 Oct 2026 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLztA-0006JS-5h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLzt6-0006MA-LK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793179443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoIFGQD2Pgx7JcL8KWegNPNG/UhOHlZ0YXVSguyqQ/E=;
 b=jFD+/94miFAifBHJDQJxIiwfVzGoW3N5iNEk7pPHlAds1wRwLLu9IoI6jyvAmVr900NROe
 CMMm2b4VqP2XuH3lawScloeEVX2/+/i7kgAe41c4P5RME7UyEC/lv/C/Bod0HPGEnXhUem
 xN+SqkNzZjHpU5RSR2mhe1wlCdQ0j7A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-QvALJoHrMWuq_4gia0fz1w-1; Wed,
 28 Oct 2026 05:24:00 -0400
X-MC-Unique: QvALJoHrMWuq_4gia0fz1w-1
X-Mimecast-MFC-AGG-ID: QvALJoHrMWuq_4gia0fz1w_1793179439
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D2BA1954190; Wed, 28 Oct 2026 09:23:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C9161955F10; Wed, 28 Oct 2026 09:23:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 486D721E6A04; Wed, 28 Oct 2026 10:23:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Eric Blake
 <eblake@redhat.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [PULL 02/14] qapi: add 'insecure-types' option for -compat
 argument
In-Reply-To: <auC5d5KoWqEMEomR@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 27 Oct 2026 14:47:19 +0000")
References: <20260917160525.1275388-1-berrange@redhat.com>
 <20260917160525.1275388-3-berrange@redhat.com>
 <877bj3a33b.fsf@pond.sub.org> <auC5d5KoWqEMEomR@redhat.com>
Date: Wed, 28 Oct 2026 10:23:56 +0100
Message-ID: <87tsm62n6b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 27, 2026 at 10:46:00AM +0100, Markus Armbruster wrote:
>> This has long been merged.  I couldn't review it at the time, and
>> merging it without my review was clearly appropriate.
>>=20
>> I have questions / doubts about the external interface I'd like to
>> discuss now.
>
> ... just in time for freeze if we need any urgent changes
> before this gets into a release.

Basically last minute :)

>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This introduces a new 'insecure-types' option for the 'compat'
>> > argument that accepts three values
>> >
>> >  * accept: Allow any usage
>> >  * reject: Reject with an error reported
>> >  * warn: Allow any usage, with a warning reported
>> >
>> > For historical compatibility it defaults to 'accept'.
>> >
>> > The 'reject' and 'warn' values will take effect for any type
>> > that has been explicitly marked insecure, or is lacking an
>> > explicit declaration of its security status.
>> >
>> > This new command line option is currently a no-op, but will
>> > become functional as following patches enable the checks.
>> >
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> snip
>
>> > diff --git a/qapi/compat.json b/qapi/compat.json
>> > index 90b8d51cf27..b54f8eb3713 100644
>> > --- a/qapi/compat.json
>> > +++ b/qapi/compat.json
>> > @@ -37,6 +37,23 @@
>> >  { 'enum': 'CompatPolicyOutput',
>> >    'data': [ 'accept', 'hide' ] }
>> >=20=20
>> > +##
>> > +# @CompatPolicySecurity:
>> > +#
>> > +# Policy for handling any devices or backends which do not provide a
>> > +# security boundary to protect against untrusted environments
>> > +#
>> > +# @accept: Allow any usage
>> > +#
>> > +# @reject: Reject with an error reported
>> > +#
>> > +# @warn: Allow any usage, with a warning reported
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'enum': 'CompatPolicySecurity',
>> > +  'data': [ 'accept', 'reject', 'warn' ] }
>> > +
>> >  ##
>> >  # @CompatPolicy:
>> >  #
>> > @@ -62,10 +79,14 @@
>>    # Policy for handling deprecated management interfaces.
>>    #
>>    # This is intended for testing users of the management interfaces.
>>    #
>>    # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
>>    # with feature 'deprecated' or 'unstable'.  We may want to extend it
>>    # to cover semantic aspects and CLI.
>>    #
>>    # Limitation: deprecated-output policy @hide is not implemented for
>>    # enumeration values.  They behave the same as with policy @accept.
>>    #
>>    # @deprecated-input: how to handle deprecated input (default 'accept')
>>    #
>>    # @deprecated-output: how to handle deprecated output (default
>>    #     'accept')
>>    #
>>    # @unstable-input: how to handle unstable input (default 'accept')
>>    #     (since 6.2)
>>    #
>> >  # @unstable-output: how to handle unstable output (default 'accept')
>> >  #     (since 6.2)
>> >  #
>> > +# @insecure-types: how to handle types that are not declared secure
>> > +#     (default 'accept') (since 11.2)
>>=20
>> Minor issue: "types" is ambiguous without context.  We call lots of
>> things "types" in our external interfaces.  It's actually QOM types
>> here.  Let's say so.  I can take care of it.
>>=20
>> Similar confusion exists elsewhere[*], but let's not digress.
>
> It is currently  QOM types. It might even stay exclusively QOM types,
> but not guaranteed.
>
> The initial focus is mostly on guest visible pieces (-device, -machine)
> with '-object' as an easy extra win that's more backend oriented.
>
> In theory it might be extended to other backend types, which are probably
> modelled in QAPI, but are not neccessarily implemented with QOM. So I
> somewhat intentionally left it fuzzy what 'types' we refer to.

If we named it @insecure-fuzz, users would get about the same
information ("it's about *something*") with less risk of confusion ("it
must be about device types, right?").

I'm not actually proposing to name it this way, I'm merely arguing that
the current name is problematic.

>> >  # Since: 6.0
>> >  ##
>> >  { 'struct': 'CompatPolicy',
>> >    'data': { '*deprecated-input': 'CompatPolicyInput',
>> >              '*deprecated-output': 'CompatPolicyOutput',
>> >              '*unstable-input': 'CompatPolicyInput',
>> > -            '*unstable-output': 'CompatPolicyOutput' } }
>> > +            '*unstable-output': 'CompatPolicyOutput',
>> > +            '*insecure-types': 'CompatPolicySecurity' } }
>>=20
>> The existing members are all named "wide", and the documentation narrows
>> them.  For instance, the name @deprecated-input could cover *any* input,
>> but its documentation narrows it to "only syntactic aspects of QMP".  I
>> did it this way to let us extend coverage without having to change the
>> external interface.
>>=20
>> New member @insecure-types is named "narrow".  Why different?  Why not
>> @insecure-input?
>
> In those existing examples, we're directly refering to data streams,
> whether they're command line / QMP parameters or QMP response, so
> input/output are reasonable terms.

To avoid misunderstandings: @deprecated-input is strictly QMP (all four
policies predating yours are strictly QMP in fact).  For instance,
chardev kind "memory" is deprecated.  Creating one with QMP is caught by
policy:

    $ qemu-system-x86_64 -S -nodefaults -display none -compat deprecated-in=
put=3Dreject -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "p=
ackage": "v11.1.0-2787-g288458be66-dirty"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute":"chardev-add", "arguments": {"id":"chr0", "backend": {"type"=
: "memory", "data": {}}}}
    {"error": {"class": "GenericError", "desc": "Deprecated value memory di=
sabled by policy"}}
    {"execute": "quit"}
    {"timestamp": {"seconds": 1793173931, "microseconds": 999776}, "event":=
 "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
    {"return": {}}

Creating one with CLI is not:

    $ qemu-system-x86_64 -S -nodefaults -display none -compat deprecated-in=
put=3Dreject -chardev memory,id=3Dchr0 -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "p=
ackage": "v11.1.0-2787-g288458be66-dirty"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute": "query-chardev"}
    {"return": [{"frontend-open": false, "filename": "memory", "label": "ch=
r0"}, {"frontend-open": true, "filename": "stdio", "label": "compat_monitor=
0"}]}
    {"execute": "quit"}
    {"timestamp": {"seconds": 1793174007, "microseconds": 270419}, "event":=
 "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
    {"return": {}}

Works as intended, and matches documentation.  Yes, applying the policy
more widely would be more useful, and applying it everywhere would
likely be most useful, but this better than nothing, and it's what I
could actually implement.  New CompatPolicy members, such as yours, need
not have this limitation.  The may have others.

> In the security status, we specifically focused on types, regardless
> of whether they're requested explicitly via -device (& friends) or
> arrive implicitly via built-in command line defaults and/or hardcoded
> type relationships (ie built devices in a machine type).  I don't
> find 'input' to be a desired term in that respect.
>
> What is being determined is whether the VM as a whole can be classed
> as secure or not.

1. You picked a different limitation for @insecure-types: it covers only
QOM types.  Again, a different limitation is *fine*.  "Only QOM types"
is obviously more useful than "only QOM types and only QMP" would be.

2. I do think the policy is about input.  What else could be accepted
(@accept), accepted with a warning (@warn), or rejected (@reject)?  The
connection from QOM object creation to input can be less obvious than it
is for @deprecated-input and @unstable-input.  But it surely exists,
don't you think?  Consider how a QOM object of type T could be created:

* The user asked for it with -device T,..., -object T,..., or similar.
  Obvious.

* The user asked for it with -machine M, -cpu C, or similar.  Same,
  except we use machine names / CPU names, ... instead of QOM type
  names, mostly for historical reasons, which makes it slightly less
  obvious.

* The user asked for another type that contains T as a component.  This
  can be unobvious, e.g. when a machine contains some obscure onboard
  device the user doesn't know or care about.  It's still the user's
  input that triggers its creation.

* We create T by default, i.e. we can't pin it on any particular piece
  of user input.  It's still triggered by user input, though.

  Example: the user elects not to pass -machine, and the default machine
  contains an insecure onboard device.  The user still asked for that
  machine, if only by not asking for another one.

  Hypothetical example: qemu-system-insecure provides just one machine
  type, which contains an insecure onboard device.  The user still asked
  for that machine, if only by running qemu-system-insecure.

* Did I miss ways to create T?

>> The existing @FOO-input support CompatPolicyInput: "accept", "reject",
>> "crash".  New insecure-types supports CompatPolicySecurity: "accept",
>> "reject", "warn".  Why different?
>
> With deprecations, there is often (but not always) a warning message
> printed unconditioally.

Yes, we do this manually when we remember to.

We do *not* do this automatically for QAPI schema feature @deprecated.
There is no warning then for QMP input.  CLI and HMP wrapping around QMP
warn only if someone added code for it manually.  Rare to never, I'd
guess.  So, @deprecated-input policy @accept does what it says on the
tin: accept silently.  Possibly with rare exceptions.

>                         eg even if you have 'accept' as policy, you
> are liable to see a deprecation warning message on stderr.

Uh, what's the difference between policy @accept and policy @warn then?

>                                                            This is
> good because even if you want to carry on using it for now, and
> never give a -compat flag, actioning the deprecation warning is
> still essential.
>
> With security checks, it is valid to launch QEMU in an insecure
> configuration and use it that way forever, with no action required
> to change anything. As such we must never report any warnings by
> default for insecure types, any warning messages must be strictly
> opt-in.  So "accept" is the default behaviour which is totally
> silent, "warn" lets you know something is bad but does not
> enforce it, and "reject' lets you know something is bad and
> refuses to let it be used. So overall, I think "warn" is justified
> for security checks, while not required for deprecations.

If I understand you correctly, you're arguing for "accept insecure
silently" by default, and for "accept deprecated with a warning" by
default.  Correct?

I feel the sane way to do this would be a choice of accept/warn/reject
in both cases, but with different default, @warn for deprecated, @accept
for insecure.

>> My rationale for "crash" is in commit dbb675c19aa (qapi: New -compat
>> deprecated-input=3Dcrash):
>>=20
>>     Bugs in integration tests may mask the error from policy "reject".
>>     Provide a larger hammer: crash outright.  Masking that seems unlikel=
y.
>>=20
>> If "crash" can be useful for testing a management application's non-use
>> of deprecated and unstable interfaces, surely it's just as useful for
>> insecure ones.
>
> I'm happy to add 'crash' as an extra option.

One-liner, almost :)

>> Likewise, "warn".  I didn't provide "warn" at the time, because QMP
>> lacks support for warnings.

I just remembered another reason.  We generally want to emit a
deprecation warning at most once, to not annoy users.
warn_report_once() makes that easy.  Doesn't work when all the QAPI
deprecation warnings are detected by a single piece of code.  Using
warn_report_once() there would go silent after the first QAPI
deprecation warning, which is not what we'd want.

>>                              Do management applications find warnings on
>> stderr in response to QMP commands useful?
>
> Many deprecations none the less report warnings on stderr - we just
> haven't automated that process from QAPI schema.
>
> I've seen plenty of scenarios where people have paid attention to
> the deprecation warnings in libvirt logs capturing QEMU's stderr.
> It is likely the main way that non-developers find out about the
> deprecations, as few people proactively read the QEMU docs to
> see deprecations, and similarly few use a -compat arg.

I am open to adding policy @warn to deprecated-input and unstable-input,
with deprecated-input's default changing to @warn.

However, I'd much prefer to warn at most once per deprecated thing.  I
can't say offhand how that could be done, though.

> For the security compat arg, my expectation was that distros which
> wish to restrict what their ship & support (ie RHEL) could use
> the -compat insecure-types arg to validate their configs, and
> could even set libvirt in their distro to pass 'warn' (or even
> 'reject') as a safety net against mistakes.
>
> I think it would also be interesting for virt-install (and similar
> tools) to request secure types only by default, at least if KVM
> is used.
>
>> > diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
>> > index 3d849fe0347..38b1cec7a41 100644
>> > --- a/qapi/qapi-util.c
>> > +++ b/qapi/qapi-util.c
>> > @@ -14,6 +14,7 @@
>> >  #include "qapi/compat-policy.h"
>> >  #include "qapi/error.h"
>> >  #include "qemu/ctype.h"
>> > +#include "qemu/error-report.h"
>> >  #include "qapi/qmp/qerror.h"
>> >=20=20
>> >  CompatPolicy compat_policy;
>> > @@ -58,6 +59,35 @@ bool compat_policy_input_ok(uint64_t features,
>> >      return true;
>> >  }
>> >=20=20
>> > +bool compat_policy_check_security(const CompatPolicy *policy,
>> > +                                  const char *typename,
>> > +                                  bool is_secure,
>> > +                                  Error **errp)
>>=20
>> More minor issues.
>>=20
>> The policy functions are named compat_policy_FOO_ok().  Why different?
>
> I wasn't paying close enough attention to the naming convention.

Happens :)  Easy enough to tidy up.

>> Their arguments are "relevant facts" (@features), @policy, "stuff for
>> error message" (@error_class, @kind, @name), @errp.  This one has the
>> same things in different order.  Why?
>
> Same lack of close attention as above.
>
> Though I would say I think the 'const CompatPolicy *policy' arg should
> be the first one in all the existing methods, as it is typical convention
> for the first arg type to be associated with the method name.

Fair point.

>> > +{
>> > +    if (is_secure) {
>> > +        return true;
>> > +    }
>> > +
>> > +    switch (policy->insecure_types) {
>> > +    case COMPAT_POLICY_SECURITY_ACCEPT:
>> > +        return true;
>> > +
>> > +    case COMPAT_POLICY_SECURITY_REJECT:
>> > +        error_setg(errp, "Type '%s' does not provide a security bound=
ary "
>> > +                   "to protect against untrusted data or actions", ty=
pename);
>> > +        return false;
>> > +
>> > +    case COMPAT_POLICY_SECURITY_WARN:
>> > +        warn_report("Type '%s' does not provide a security boundary "
>> > +                    "to protect against untrusted data or actions", t=
ypename);
>> > +        return true;
>> > +
>> > +    default:
>> > +        g_assert_not_reached();
>> > +    }
>> > +}
>> > +
>> > +
>> >  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>> >  {
>> >      assert(val >=3D 0 && val < lookup->size);
>>=20
>>=20
>> [*] So I digress in a footnote.  Sue me ;)
>>=20
>> While examining the QAPI schema, I found near object-add:
>>=20
>>     ##
>>     # @qom-list-properties:
>>     #     List properties associated with a QOM object.
>>     #
>>     # @typename: the type name of an object
>>     [...]
>>     ##
>>     # @object-add:
>>     #     Create a QOM object.
>>     #
>>     # Errors:
>>     #     - If @qom-type is not a valid class name
>>     [...]
>>     ##
>>     # @ObjectOptions:
>>     #     Describes the options of a user creatable QOM object.
>>     #
>>     # @qom-type: the class name for the object to be created
>>=20
>> We use "QOM type" and "QOM class".  This is pretty bad; we should pick
>> one and stick with it.
>
> Probably "type" since there is no concept of a "class" in QAPI,
> it is just a schema for describing types and their relationships.
>
> The 'class' is an internal QOM implementation detail of the
> public QAPI 'type'.

Yes.  And I don't like it much there.

>> And near device_add:
>>=20
>>     ##
>>     # @device-list-properties:
>>     #     List properties associated with a device.
>>     #
>>     # @typename: the type name of a device
>>     [...]
>>     ##
>>     # @device_add:
>>     #     Add a device.
>>     #
>>     # @driver: the name of the new device's driver
>>=20
>> We use "driver" and "device type".  Similarly bad.
>
> Kind of wish we just used a plain 'type' in both -object and -device,
> but changing that is not worth the disruption. At least the docs
> could refer to 'QOM type' generally.

Makes sense.

Thank you!


