Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D659EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gSv-00025u-Ok; Tue, 29 Apr 2025 04:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9gSt-00025d-Tw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9gSq-0006zE-Kq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745915835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OeW7VyJRkKYnKn6i4VF0cFJ3WFYd7NfLb4AkqclYkDQ=;
 b=GiRPVPw53HxBdmRk5yBg86/sT4Cthlrzdvphu2klU7BX/WBPsCuh43DQEQZ0F8aw1RtSW6
 yetiuhuV1wrzuuI1XgZ6W4ReknYGzoGfDAOXdCL1WPCyKprTSIPC1ZVfk4ZXmUIqTz6uf3
 LTSg4wYzvU0OAgXy5C6kckeQK1Di+1U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-2PhVA7vENgWlvi4oQgdhvA-1; Tue,
 29 Apr 2025 04:37:11 -0400
X-MC-Unique: 2PhVA7vENgWlvi4oQgdhvA-1
X-Mimecast-MFC-AGG-ID: 2PhVA7vENgWlvi4oQgdhvA_1745915830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC56A19560B0; Tue, 29 Apr 2025 08:37:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 627E5180047F; Tue, 29 Apr 2025 08:37:05 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:37:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org, Victor Toso <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aBCPrqggooxF6Z1w@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734drpg4j.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 09:43:24AM +0200, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
> > After looking at the introspection code, I don't see any major blocker.
> > We need to keep some of existing "if", as they are based on config-host, 
> > and should apply.
> > We can introduce a new "available_if" (or any other name), which 
> > generates a runtime check when building the schema, or when serializing 
> > a struct.
> >
> > This way, by modifying the .json with:
> > - if: 'TARGET_I386'
> > + available_if: 'target_i386()'
> >
> > This way, we keep the possibility to have ifdef, and we can expose at 
> > runtime based on available_if. So we can keep the exact same schema we 
> > have today per target.
> 
> The name is ugly.  Naming is hard.  No need to worry about it right now.
> 
> Semantics of having both 'if' and 'available_if'?  To work out an
> answer, let's consider how to convert conditionals:
> 
> * 'if': STRING
> 
>   If STRING is a target-specific macro, replace by 'available_if': PRED,
>   where PRED is the equivalent run-time predicate.
> 
>   Else, no change.
> 
> * 'if': { 'all': [COND, ...] }
> 
>   If COND contains only target-specific macros, replace by
>   'available_if': { 'all': [PRED, ...] }, where the PRED are the
>   equivalent run-time predicates.
> 
>   If COND contains no target-specific macros, no change.
> 
>   What if it contains both?
> 
>   - If each COND contains either only target-specific macros, or no
>     target-specific macros, we could split the target-specific ones off
>     into an additional 'available_if'.  This requires defining the
>     semantics of having both 'if' and 'available_if' as "both conditions
>     must be satisfied".
> 
>   - What if this isn't the case?
> 
> * 'if' { 'any': [COND, ...] }
> 
>   Similar, but to be able to split the COND we need "either condition
>   must be satisfied."
> 
> Even if we can make this work somehow, it would likely be a royal mess
> to explain in qapi-code-gen.rst.
> 
> We currently don't have "mixed" conditionals.  So we could sidestep the
> problem: you can have either 'if' or 'available_if', but not both.
> Feels like a cop out to me.
> 
> What if we move the "is dynamic" bit from the root of the conditional to
> its leaves?  So far, the leaves are macro names.  What if we
> additionally permit a function name?
> 
> Function name, not C expression, to not complicate generating code in
> languages other than C too much.
> 
> Ignore the question of syntax for now, i.e. how to decide whether a leaf
> is a macro or a function name.

I wonder if any of this is worth the pain in practice.....


Looking at the QAPI schema, we apply TARGET_xxxx conditions either to
commands, or to structs/enums that are used in args/return of commands.
We don't conditionalize individual fields, etc.

I tried to query our schema with 'jq' (incidentally rather tedious
because of our JSON-but-not-JSON language[1]). If I select only
commands we get:

query-cpu-definitions          => currently many arches
query-cpu-model-expansion      => currently many arches
query-cpu-model-baseline       => currently s390x only
query-cpu-model-comparison     => currently s390x only
query-s390x-cpu-polarization   => inherently s390x only
query-gic-capabilities         => inherently arm only
query-sev                      => inherently x86 only
query-sev-attestation-report   => inherently x86 only
query-sev-capabilities         => inherently x86 only
query-sev-launch-measure       => inherently x86 only
query-sgx                      => inherently x86 only
query-sgx-capabilities         => inherently x86 only
rtc-reset-reinjection          => inherently x86 only
set-cpu-topology               => inherently s390x only
sev-inject-launch-secret       => inherently x86 only
xen-event-inject               => currently x86 only
xen-event-list                 => currently x86 only

The two Xen commands are currently limited to x86, but if we ever extended
Xen to arm, possibly they would make sense. IOW, conceptually a target
conditional might be useful in future.

The CPU model commands are the ones where having the target conditions
visible in schema appears to add value, in that they'll allow a mgmt
app to detect when we extend any of them to cover new architectures.


Libvirt (and other mgmt apps) want to query the schema to see if commands
exist in the QEMU they're using, before trying to invoke them. To some
degree this is just a "nice to have" that improves error reporting/detection.


For the commands that are inherently arch specific, the mgmt app should
conceptually already know what architectures these commands apply to.
These target conditionals provide little (no) value when probing commands
in the schema.

IOW, if we (for example) have a single binary for x86 and s390, it should
be harmless if we report that 'query-sev' exists regardless of arch, as
the mgmt app should none the less already know to only use it with x86.

I don't know if libvirt correctly filters based on architecture in the
case of SEV/SGX/GIC/RTC when probing & using these features, but if it
does not, then I'd consider that a pre-existing bug that should be fixed.

Libvirt doesn't use the Xen commands.

For query-cpu-model-comparison/baseline, libvirt already filters its
usage of these based on s390 arch, so even if x86 reported them I
believe it won't break libvirt today. If these commands are extended
to other archs in future, libvirt might want a way to detect this.
On the flipside it might not be the end of the world if we just expose
them on all arches and simply have them return an error at runtime
where non-applicable. 


IOW, while the target conditions could theoretically provide value at
some point in future, it does not look like they do anything /today/
for libvirt.

Given that I wonder if we shouldn't just ignore the problem, and
blindly remove all TARGET_nnn conditions from QAPI schema today. Let
our future selves worry about it should this prove insufficient later.


With regards,
Daniel

[1] To use QAPI JSON with 'jq' you must convert ' to " and
    strip comments. eg
    
      cat *.json | sed -e "s/'/\"/g" -e 's/#.*//' | jq ...expression...
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


