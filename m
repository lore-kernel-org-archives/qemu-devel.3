Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B41C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti8lv-0006uA-QD; Wed, 12 Feb 2025 04:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti8lp-0006tO-6L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti8lm-0004Os-VW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739351457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8kzvKxXmxH01ehNvbo9hkZfr1tPmy2EDgc2AfLcabA=;
 b=LXV/nwOKOPmH3W1EFvfO/CM/Ry61H0vJULmr2KHKvyfPJXwDTWnwwcfbZliK8HtCUL2kRB
 CHK9B2WesmhJfqifJci7WIw9uW2qgnoIU6F+8nJ1bo2f7qnS8VXWmuA9XSzRrX+WOffqob
 m24ZgH5TN6nWivtS68zj+IOqutNezwg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-FHcAsNeUNGqIOlwfNkyGpw-1; Wed,
 12 Feb 2025 04:10:52 -0500
X-MC-Unique: FHcAsNeUNGqIOlwfNkyGpw-1
X-Mimecast-MFC-AGG-ID: FHcAsNeUNGqIOlwfNkyGpw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371DA1956096; Wed, 12 Feb 2025 09:10:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CF0E1800570; Wed, 12 Feb 2025 09:10:48 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:10:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
Message-ID: <Z6xlUMopyRVfYjAh@redhat.com>
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 11, 2025 at 07:53:32PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
> > On 11/2/25 19:26, Stefan Hajnoczi wrote:
> > > On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
> > > <philmd@linaro.org> wrote:
> > > > 
> > > > The following changes since commit
> > > > 54e91d1523b412b4cff7cb36c898fa9dc133e886:
> > > > 
> > > >    Merge tag 'pull-qapi-2025-02-10-v2' of
> > > > https://repo.or.cz/qemu/ armbru into staging (2025-02-10
> > > > 10:47:31 -0500)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >    https://github.com/philmd/qemu.git tags/hw-misc-20250210
> > > > 
> > > > for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
> > > > 
> > > >    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
> > > > (2025-02-10 21:30:44 +0100)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Misc HW patches
> > > > 
> > > > - Use qemu_hexdump_line() in TPM backend (Philippe)
> > > > - Make various Xilinx devices endianness configurable (Philippe)
> > > > - Remove magic number in APIC (Phil)
> > > > - Disable thread-level cache topology (Zhao)
> > > > - Xen QOM style cleanups (Bernhard)
> > > > - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
> > > > - Invert logic of machine no_sdcard flag (Philippe)
> > > > - Housekeeping in MicroBlaze functional tests (Philippe)
> > > 
> > > Please take a look at this CI failure:
> > > https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
> > 
> > Hmm I can not reproduce locally this error:
> > 
> >    Exception: Asset cache is invalid and downloads disabled
> 
> OK, I could reproduce by blowing my cache away.
> 
> The problem seems in the "tests/functional: Have microblaze tests
> inherit common parent class" patch, which does:
> 
> -class MicroblazeelMachine(QemuSystemTest):
> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
> 
> I presume, since MicroblazeLittleEndianMachine is no more a direct
> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
> downloaded.

Yes, my code assumes all assets are on the leaf test classes. I'll
look at a fix since it is easy enough to check parent classes too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


