Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1F0C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8GU-0000TF-4p; Fri, 25 Sep 2026 11:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA8GR-0000PB-ST
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xA8GP-0006A3-Vn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790351705;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkKTE6l/0Jm27ZP/leE8JHnkYiBVjiFuUGyl3XtkZ1k=;
 b=X6yyU3zuzVlJ3DHdLDkRKTgL7RgqSKNlzX2YnIJTSujYyy3xlewJxQJZQv1HA9OpSQIAvD
 KpP5EK5/LLznXhbhJTS7XQc4SSeMuOfNBuAAJvQX+RfUjU8X3PsvZ3EGQJGgCdQ1nFww/Y
 42UBehdL6lz8Mvda9s1ne2zlxP++Zr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-KfoYIwksPcqk9_2ZG1ZJgg-1; Fri,
 25 Sep 2026 11:55:01 -0400
X-MC-Unique: KfoYIwksPcqk9_2ZG1ZJgg-1
X-Mimecast-MFC-AGG-ID: KfoYIwksPcqk9_2ZG1ZJgg_1790351700
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2DC41800611; Fri, 25 Sep 2026 15:54:59 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C1F9427; Fri, 25 Sep 2026 15:54:57 +0000 (UTC)
Date: Fri, 25 Sep 2026 16:54:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/4] tests/tcg: add alternative cross-compilers for fedora
Message-ID: <araZTzyeRXP2AL80@redhat.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
 <arZBqmDtOX8YoJaA@redhat.com>
 <fa2f6396-c658-4ca9-a985-04d9f2cffda2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa2f6396-c658-4ca9-a985-04d9f2cffda2@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 25, 2026 at 08:20:44AM -0700, Pierrick Bouvier wrote:
> On 9/25/2026 2:40 AM, Daniel P. Berrangé wrote:
> > On Thu, Sep 24, 2026 at 09:39:41PM +0000, Pierrick Bouvier wrote:
> >> This allows to pick host compiler automatically on fedora, as those
> >> binaries are installed with 'gcc' package.
> >>
> >> This covers all host arch supported to this day:
> >> https://fedoraproject.org/wiki/Architectures
> >> - x86_64
> >> - aarch64
> >> - ppc64le
> >> - riscv64
> >> - s390x
> >> Note: QEMU and Fedora don't support 32-bit hosts anymore.
> > 
> > Regardless of what installation arches Fedora targets, it
> > ships cross compilers for pretty much everything. In F44
> > I see the following GCC available:
> > 
> > gcc-aarch64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-alpha-linux-gnu.x86_64           16.2.1-1.fc44 updates
> > gcc-arc-linux-gnu.x86_64             16.2.1-1.fc44 updates
> > gcc-arm-linux-gnu.x86_64             16.2.1-1.fc44 updates
> > gcc-avr32-linux-gnu.x86_64           16.2.1-1.fc44 updates
> > gcc-bfin-linux-gnu.x86_64            16.2.1-1.fc44 updates
> > gcc-c6x-linux-gnu.x86_64             16.2.1-1.fc44 updates
> > gcc-frv-linux-gnu.x86_64             16.2.1-1.fc44 updates
> > gcc-h8300-linux-gnu.x86_64           16.2.1-1.fc44 updates
> > gcc-hppa-linux-gnu.x86_64            16.2.1-1.fc44 updates
> > gcc-hppa64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> > gcc-ia64-linux-gnu.x86_64            16.2.1-1.fc44 updates
> > gcc-loongarch64-linux-gnu.x86_64     16.2.1-1.fc44 updates
> > gcc-m68k-linux-gnu.x86_64            16.2.1-1.fc44 updates
> > gcc-microblaze-linux-gnu.x86_64      16.2.1-1.fc44 updates
> > gcc-mips64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> > gcc-mn10300-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-openrisc-linux-gnu.x86_64        16.2.1-1.fc44 updates
> > gcc-powerpc64-linux-gnu.x86_64       16.2.1-1.fc44 updates
> > gcc-powerpc64le-linux-gnu.x86_64     16.2.1-1.fc44 updates
> > gcc-ppc64-linux-gnu.x86_64           16.2.1-1.fc44 updates
> > gcc-ppc64le-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-riscv32-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-riscv64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-s390x-linux-gnu.x86_64           16.2.1-1.fc44 updates
> > gcc-sparc64-linux-gnu.x86_64         16.2.1-1.fc44 updates
> > gcc-x86_64-linux-gnu.x86_64          16.2.1-1.fc44 updates
> > gcc-xtensa-linux-gnu.x86_64          16.2.1-1.fc44 updates
> > 
> >
> 
> We want to detect host compiler here (redhat-* variants), as mentioned
> in commit description. It addresses original request from Paolo. Cross
> compilers above are already detected with current cc field.

Oh, I see what you mean. Itis dealing with the naming difference
between  'redhat-linux-gnu' and just 'linux-gnu' in the compilers
for the native vs cross arch RPMs.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


