Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B0C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpdu-0003Jm-Se; Mon, 20 Jul 2026 11:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlpds-0003JU-RT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlpdr-00080v-1B
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784560249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=amzcMtzh3+ZGkw+lfy7KfFIaeFkaGRBfV4OT58EsFrA=;
 b=YIajyj5qrHLupYVyORsDHf72iaeOmfJYAwwUGc+0eeH5j7wT6+qamgKAzaM06MgDhyH8Gh
 a0f9U9fW8ZGom0BCk7sHAXs85yyBAbnHEsmJLaHpVaE+gu7ubcSkPQ4RaxMi0vStUXCSoK
 muVOmGvs2fyjmnaKrztH8J1T4ysbWWQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-5_Ds4tGQMXyqV4MS7EY9kQ-1; Mon,
 20 Jul 2026 11:10:46 -0400
X-MC-Unique: 5_Ds4tGQMXyqV4MS7EY9kQ-1
X-Mimecast-MFC-AGG-ID: 5_Ds4tGQMXyqV4MS7EY9kQ_1784560245
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5F81955F2C; Mon, 20 Jul 2026 15:10:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00DBB1800612; Mon, 20 Jul 2026 15:10:40 +0000 (UTC)
Date: Mon, 20 Jul 2026 16:10:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <al46bcG96ARl5Rf6@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyqv3u32.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 16, 2026 at 11:08:49AM -0300, Fabiano Rosas wrote:
> Assumptions:
> 
> A) The migration stream is assumed to be secured by TLS on a per-host
> basis.
> 
> B) For migration streams stored to file, including snapshots, it is
> assumed that the storage file is authentic, i.e. the files are owned by
> the party performing the live migration and have not been tampered with.
> 
> C) The network ports used for migration are expected to be available
> only during migration. No long-standing listening destination QEMU
> process.
> 
> D) The network used for migration is expected to be adequately isolated.
> 
> E) The migration source QEMU process is assumed to be secure. Compromise
> of the source QEMU process is nonetheless possible but exploiting the
> migration process is expected to grant no further privileges.


In the security.rst doc, we have an "Architecture" heading where
we outline design principals  for security. The "Assumptions" feels
like it has overlap with that section.

> For security consideration, the following are considered:
> 
> OUT OF SCOPE:
> 
> 1) Abort of destination QEMU process while migration is still in course.
> Rationale: the source virtual machine is not affected.
> 
> 2) Migration failure.
> Rationale: eventual failed migrations are part of normal operation.
> 
> 3) Memory over-allocation issues in the destination QEMU process.
> Rationale: the destination host's operating system is expected to
> constrain resource usage. Process termination due to OOM falls under
> point 1 above.

The "Security boundary scope" section has primarily been listing
things that are definitely "out of scope".

Anything not out of scope then gets triage to decide whether it
is in scope or not....

> IN SCOPE:
> 
> 1) Privilege escalation from the guest operating system into the
> destination QEMU process or host.
> 
> 2) Tampering or exfiltration of migration stream data by a third party
> at a lower privilege level than either QEMU processes involved in the
> migration.
> 
> 3) Termination of the source QEMU process by source virtual machine
> guest userspace, including by forcing host OS resource constraints to
> be reached.
> 
> 4) Other tampering or exfiltration of data from the source QEMU process
> if reached from migration code or migration stream manipulation.
> 
> 5) Causing source QEMU process to enter a state from which migration is
> not possible permanently.

...so I'm not sure we especially need an "in scope" section.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


