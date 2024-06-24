Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA2C3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLk5x-0004RG-Q9; Mon, 24 Jun 2024 09:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLk5s-0004Pi-8L
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLk5o-0005PX-UK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719237047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEJivHUtcd1tcJNTagUcbvajMTg41JxsFpN+umGYzGU=;
 b=E2iFlQlrg7BMDOGzXGR+WZ1kV9wpYdbm4nRJIH/s1HYGo/Ncx7BuS3OMf6f6Ck9heH1OKw
 +U3aYLkOiSvxoJn2faVlOCof82iu0q+a1xs0GQJazXY+ADdkn8QoDp/64us6JTP4l4UofP
 O3liMvb+iz831CEbr9FC4rHYKFeJqrs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-OMiCtoDzMGe7Km9n2r5dLw-1; Mon,
 24 Jun 2024 09:50:43 -0400
X-MC-Unique: OMiCtoDzMGe7Km9n2r5dLw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 578031956080; Mon, 24 Jun 2024 13:50:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8DF63000219; Mon, 24 Jun 2024 13:50:34 +0000 (UTC)
Date: Mon, 24 Jun 2024 14:50:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 00/15] Introduce support for IGVM files
Message-ID: <Znl5p1vQYjSQi7Qk@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 03:29:03PM +0100, Roy Hopkins wrote:
> Based-on: 02d9c38236
> 
> Here is v3 of the set of patches to add support for IGVM files to QEMU.
> 
> Firstly, apologies for the long gap between v2 and v3. This was due to a number
> of factors, but particularly holding back until SEV-SNP support landed in QEMU
> as well as for some changes to be merged in the upstream IGVM specification and
> library. The delay meant that I could include the SEV-SNP IGVM changes that I
> had been separately maintaining for COCONUT-SVSM into this series, giving full
> support for the full range of SEV technologies.
> 
> Thank-you to everyone who reviewed the previous set of patches [1]. I
> have hopefully addressed all of the comments in those reviews. Some of these
> changes required a reasonable amount of rework. Along with the inclusion of
> support for SEV-SNP, this has resulted in a fairly large set of differences from
> v2. This v3 patch series is also available on github: [2]

snip

FYI, I hit some compile problems reporting array bounds issues,
with this posting. I'm using Fedora 40, which has gcc 14 in
case that matters.


In file included from /var/home/berrange/src/virt/qemu/include/sysemu/kvm.h:214,
                 from ../target/i386/sev.c:29:
In function ‘cpu_x86_load_seg_cache’,
    inlined from ‘sev_apply_cpu_context’ at ../target/i386/sev.c:454:13:
../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bounds of ‘SegmentCache[6]’ [-Werror=array-bounds=]
 2236 |     sc = &env->segs[seg_reg];
      |           ~~~~~~~~~^~~~~~~~~
../target/i386/cpu.h: In function ‘sev_apply_cpu_context’:
../target/i386/cpu.h:1682:18: note: while referencing ‘segs’
 1682 |     SegmentCache segs[6]; /* selector values */
      |                  ^~~~
In function ‘cpu_x86_load_seg_cache’,
    inlined from ‘sev_apply_cpu_context’ at ../target/i386/sev.c:454:13:
../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bounds of ‘SegmentCache[6]’ [-Werror=array-bounds=]
 2236 |     sc = &env->segs[seg_reg];
      |           ~~~~~~~~~^~~~~~~~~
../target/i386/cpu.h: In function ‘sev_apply_cpu_context’:
../target/i386/cpu.h:1682:18: note: while referencing ‘segs’
 1682 |     SegmentCache segs[6]; /* selector values */
      |                  ^~~~
In function ‘cpu_x86_load_seg_cache’,
    inlined from ‘sev_apply_cpu_context’ at ../target/i386/sev.c:454:13:
../target/i386/cpu.h:2236:20: error: array subscript 6 is above array bounds of ‘SegmentCache[6]’ [-Werror=array-bounds=]
 2236 |     sc = &env->segs[seg_reg];
      |           ~~~~~~~~~^~~~~~~~~
../target/i386/cpu.h: In function ‘sev_apply_cpu_context’:
../target/i386/cpu.h:1682:18: note: while referencing ‘segs’
 1682 |     SegmentCache segs[6]; /* selector values */
      |                  ^~~~
...cut many more similar warnings...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


