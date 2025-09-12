Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1904BCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux1ns-0004Hh-Jp; Fri, 12 Sep 2025 07:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1ux1ng-0004Fm-GO; Fri, 12 Sep 2025 07:18:46 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1ux1nZ-0005Vf-RD; Fri, 12 Sep 2025 07:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=rzNHFGeMQmaxDNPPNTH28xsP0DNpp+preXxsdixIsU0=; b=OU3LgTq2IcCOlZSC
 G9OikVuAUPZIV+gmSWEotX3bIFxjcA/0VTLjNjDlZLJf++WFsulTX7pO2iX+hItDfNf1zdycEb57w
 i2SNvAQ10Pafq82e6UGWLM3ANq92vWoCQX5X2eAq4HXfjzzCfwWaFW6baABgl5u0QcklXNgajC/kv
 zDgqqY2HqODDzhmGeUJSmxVFkhcii5ZBKPX5ydnGBAJ9JFlDae0kbHwrmvhxLNtnx0SpR40De3QES
 sZa154nQhlJlIVpQqEDkIxaFyMXZQ8n0zp2K7h609ahvxc0hFlWlLz4zitUdy3ohN87pJ3WcaPZAj
 qvlcvmmXkvn0i4DpIw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1ux1nS-00Ad58-2J;
 Fri, 12 Sep 2025 11:18:30 +0000
Date: Fri, 12 Sep 2025 11:18:30 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 17/20] util: add support for formatting a workload
 name in messages
Message-ID: <aMQBhuF9u1sDbZfx@gallifrey>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-18-berrange@redhat.com>
 <aMMwuEqguq62FZhU@gallifrey> <aMPa-yjEzsdsqjZO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMPa-yjEzsdsqjZO@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 11:17:48 up 137 days, 19:31,  1 user,  load average: 0.05, 0.07, 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Sep 11, 2025 at 08:27:36PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > The error_report function can include the guest name in any
> > > messages it prints. The qemu_log function has no equivalent
> > > behaviour.
> > > 
> > > This introduces support for a "workload name" in the new
> > > messages API, which in the case of system emulators will
> > > be the guest name. The possibility of defining a workload
> > > name for other binaries is left as an exercise for the
> > > future.
> > > 
> > > This change has no impact on the output of the error_report
> > > function, but will change the qemu_log function. This can
> > > be easily seen with the 'log' trace backend, and how it is
> > > now more closely matching error_report output.
> > > 
> > > Before:
> > > 
> > >   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> > >   qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
> > >   qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
> > >   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > > 
> > > After:
> > > 
> > >   # qemu-system-x86_64 -msg guest-name=on -name blah -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> > >   blah qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55b3af3fd870 dir=fish
> > >   blah qcrypto_tls_creds_get_path TLS creds path creds=0x55b3af3fd870 filename=ca-cert.pem path=<none>
> > >   blah qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Are you going to want to escape that? I see later you're adding []'s around it,
> > which makes it feel like you want to end up with it parsable, but if some nasty
> > person does:
> > 
> > -name ']})🐧({['
> > 
> > then things get confusing; I guess you're hoping that whoever calls qemu will
> > be careful not to allow that.
> 
> I was considering the log output to be human targetted, rather
> than something to be parsed. IOW, if users want to confuse
> themselves with wierd names, that's their own (unwise) decision.
> 
> If we added ecaping of the name, it'd probably even more difficult
> to read for a human, even if we make it a bit easier for humans ?
> 
> TL;DR: do we care about parseability here, or just humans reading ?

If it's just humans that's fine; if anywhere were documenting the output
format then it should probably have a warning.

Dave

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

