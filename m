Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B055FC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 11:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq9n0-00022s-G8; Thu, 06 Mar 2025 06:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq9mz-00022j-99
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tq9mv-0000aq-TZ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 06:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741261994;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yei7ybyqzBFo5udSBL62hX06mvgEi9MLZ/jpWKvEBIo=;
 b=KdPvhNVjTPF/hj5LDG7miw2VbZXPnnFjlUYS0oeoP6157sqldOSPVKzjt6+Zc2Yd6kOVAt
 MUiKB2WyeOIDmjysGvfrdf9O3eC06n1dDR4j3Kqt+uJK2szimbEf9U9n3gokv/HZ4Sm6HM
 gJgosdp/m4S2hWjg6zZChaplSCl6lDw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-yhseRxsRPIuZGW6C19mnKA-1; Thu,
 06 Mar 2025 06:52:59 -0500
X-MC-Unique: yhseRxsRPIuZGW6C19mnKA-1
X-Mimecast-MFC-AGG-ID: yhseRxsRPIuZGW6C19mnKA_1741261978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7210E18333C8; Thu,  6 Mar 2025 11:52:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D0E1828A81; Thu,  6 Mar 2025 11:52:42 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:52:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
Message-ID: <Z8mMhjwiYCY7Pq4H@redhat.com>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
 <35177cd6-0741-4c28-a5d5-3529208a31dc@linaro.org>
 <dd0336c2-c2ed-477c-8f40-eaee2f110238@redhat.com>
 <21a34cac-855b-4628-a154-e708ea85df59@linaro.org>
 <CABgObfaKQLizim36Lzqzn+brc5d7m10eKbZV59ZK9+03Kt7eTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaKQLizim36Lzqzn+brc5d7m10eKbZV59ZK9+03Kt7eTg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Mar 06, 2025 at 12:34:13PM +0100, Paolo Bonzini wrote:
> Il gio 6 mar 2025, 10:27 Philippe Mathieu-Daudé <philmd@linaro.org> ha
> scritto:
> 
> > This API is to allow refactoring code for heterogeneous emulation,
> > without changing user-facing behavior of current qemu-system binaries,
> > which I now consider as 'legacy'.
> >
> > Once all current restrictions removed, the new qemu-system-heterogeneous
> > binary is expected to run any combination of targets.
> >
> > qemu-system-$target will be a call to qemu-system-heterogeneous with
> > a restricted subset, possibly in the form of:
> >
> >   $ qemu-system-heterogeneous --target aarch64-softmmu
> >
> 
> Or just qemu-system I guess.
> 
>     ^ equivalent of today's qemu-system-aarch64
> >
> > If you don't like 'qemu_legacy_binary_' prefix, I can use
> > 'qemu_single_binary_' instead.
> >
> 
> Still there is a problem with renaming binaries (both the "qemu-kvm" case
> and the good/bad case that Richard pointed out).

We could special case the '-kvm' suffix, because by its nature it
implies the current binary build target.

> 
> I think you should try creating two versions of system/arch_init.c, so that
> it has a separate implementation for heterogeneous vs. single-target
> binaries. Then you can keep separate linking steps for single-target
> binaries and you naturally get the right target info from either the
> target-specific arch_init-single.c, or the --target option for
> arch_init-multi.c.
> 
> (Is --target even necessary? As long as you have a way disambiguate
> same-named machines like -M virt, and have no default machine in the
> multi-target binary, you shouldn't need it).

If we did 'query-machines' on qemu-system-heterogeneous, it would
return all machines from all targets. To disambiguate naming there
are various options

  * The query-machines command would have to gain a new 'target'
    field and we would have to document that uniqness is across
    the tuple (name, target), not merely name. That's a semantic
    change.

    We would still need a way to express the 'target' when asking
    to instantiate a machine

  * The query-machines command would have to gain a new 'target'
    paramter so callers can restrict the data they receive back

    We would still need a way to express the 'target' when asking
    to instantiate a machine

  * Rename all machine types so they are '<target>-<machine>'
    The query-machines command doesn't change. Apps would have
    to "parse" the machine name to see what 'target' each is
    associated with, or we include an explicit 'target' field
    in the returned data. Instianting a machine would not need
    changing

  * Require --target CLI arg, meaning query-machines remains
    unchanged, as does instantiating machines

Any other options ?

The last is the simplest option if we just make --target be defaulted
based on the binary name.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


