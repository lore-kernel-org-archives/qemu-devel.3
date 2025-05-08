Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C657C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2iX-0004G3-An; Thu, 08 May 2025 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD2iV-0004Eb-Cd
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD2iM-0006hN-AD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746716347;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkckZQ7A47rF7nDMT1xmaMeDJjIA+q/cWHG+zJuPU+o=;
 b=Z2U7gQ2KOqXvlKovGj2vJn67w/uoLM/cF98ECah4as2lsM+u5aFmS/Fsq1TtCiT19kqAwa
 x7DdzyY+d4dInighV7117Sph8xCVJCsvDRjyIrrRSugK5KFSaQoWynpnx2ki7WDHPyD5SG
 mRxhY8SYTDXN/QEvdpR04/teT2fOSGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-qJRToraoOmOq_akblziQ4w-1; Thu,
 08 May 2025 10:59:04 -0400
X-MC-Unique: qJRToraoOmOq_akblziQ4w-1
X-Mimecast-MFC-AGG-ID: qJRToraoOmOq_akblziQ4w_1746716343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2180019560AF; Thu,  8 May 2025 14:59:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F2418004A7; Thu,  8 May 2025 14:59:00 +0000 (UTC)
Date: Thu, 8 May 2025 15:58:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
Message-ID: <aBzGsKcvIeGUlIaw@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <a0b57e48-e826-4376-aa69-8db92c939064@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b57e48-e826-4376-aa69-8db92c939064@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 08, 2025 at 04:56:03PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/5/25 15:58, Daniel P. Berrangé wrote:
> > Pierrick has proposed a series that introduces a concept of runtime
> > conditionals to the QAPI schema, in order to adapt the TARGET_*
> > conditionals currently used at build time:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html
> > 
> > For the sake of comparison & evaluation, this series illustrates the
> > alternative approach that we've discussed of entirely removing any
> > concept of TARGET_* conditionals.
> > 
> > With this the QAPI schema varies solely based on CONFIG_* conditionals,
> > and is thus invariant across different target emulators.
> > 
> > In this PoC I've taken the minimal effort approach to the problem.
> > 
> > The QAPI schema has removed the TARGET_* conditionals and in order to
> > make all the emulators then compile, the stubs/ directory is populated
> > with a bunch of files to provide dummy impls of the target specific QMP
> > commands.
> > 
> > This is sufficient to make the current QEMU binaries build successfully.
> > 
> > To make the "single binary" concept work, however, would require
> > additional followup work to eliminate the stubs.
> > 
> > Instead of having stubs we would need to de-couple the QMP command
> > impl from the machine internals. This would likely require greater
> > use of interfaces and/or virtual method dispatchers on the machine
> > class. This would enable the 'qmp_XXXXX' command impls to exist
> > once. Then they call out to virtual methods on the machine to provide
> > the real impl, and/or generate an error if the virtual method is not
> > implemented for the machine.
> 
> Note,  I don't see commands "per machine", but per device (including
> CPU). When not specified, we iterate over device implementations / CPUs.

Yep, that makes sense. If its not abstracted via machines, we'll need
to abstract it in some other place in our object model. The right answer
probably varies depending on each feature/command we're considering


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


