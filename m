Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A42D0E6EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qE0-0004wR-4J; Mon, 21 Oct 2024 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2qDy-0004tX-Hc
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2qDv-0005t6-U8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729508717;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szRBa3mnIXG/3g1R0dwM0gbyZfqi8EDpaIqi4UD/rrQ=;
 b=eX6pl1VXWIVi/3YRHCr3AtepnxzMM+TGufnLyyqDOZOsZJyVmhlUAXZHSzbvrJby2z+0gd
 rlFidcNZJJV3Qt8eB92pzYL3nnrwCLuCTasMMY6A24mjJbgQTxLksg4qNBKeD/3UmJBdc5
 3vclcu3kB3DtDNy/rdxd/rwVB/w1rGU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-TpofasZkPyShbYCAqnJBHQ-1; Mon,
 21 Oct 2024 07:05:13 -0400
X-MC-Unique: TpofasZkPyShbYCAqnJBHQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07EB31955F41; Mon, 21 Oct 2024 11:05:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7181955F42; Mon, 21 Oct 2024 11:05:08 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:05:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/vm: update openbsd image to 7.6
Message-ID: <ZxY1YPQMYVRMY3i3@redhat.com>
References: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
 <ZxYee2xa-VJjOQSV@redhat.com>
 <c086dbe4-bcd9-4a90-99ef-8c2cda37471d@comstyle.com>
 <c6f9071b-4473-4d12-9f89-283289eab5a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6f9071b-4473-4d12-9f89-283289eab5a0@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 21, 2024 at 12:49:27PM +0200, Thomas Huth wrote:
> On 21/10/2024 11.58, Brad Smith wrote:
> > On 2024-10-21 5:27 a.m., Daniel P. Berrangé wrote:
> > > On Sun, Oct 13, 2024 at 02:19:41AM -0400, Brad Smith wrote:
> > > > tests/vm: update openbsd image to 7.6
> > > > 
> > > > Remove tomli as Python has been updated to 3.11.
> > > > 
> > > > Signed-off-by: Brad Smith <brad@comstyle.com>
> > > > ---
> > > >   tests/vm/openbsd | 6 +++---
> > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> > > > index 49cab08782..dfd11c93f0 100755
> > > > --- a/tests/vm/openbsd
> > > > +++ b/tests/vm/openbsd
> > > > @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
> > > >       name = "openbsd"
> > > >       arch = "x86_64"
> > > > -    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
> > > > -    csum =
> > > > "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
> > > > +    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
> > > > +    csum =
> > > > "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
> > > >       size = "20G"
> > > >       pkgs = [
> > > >           # tools
> > > > @@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
> > > >           "pkgconf",
> > > >           "bzip2", "xz",
> > > >           "ninja",
> > > > -        "py3-tomli",
> > > >           # gnu tools
> > > >           "bash",
> > > > @@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
> > > >           self.print_step("Installation started now, this will
> > > > take a while")
> > > >           self.console_wait_send("Location of sets",        "done\n")
> > > > +        self.console_wait_send("Time appears wrong.  Set to", "\n")
> > > Have you any idea why this line has suddenly become neccessary ?
> > Thomas provided that piece.
> > > Without your patch, I'm seeing OpenBSD VM installs fail with the existing
> > > 'install75.iso' image, with the error matching this line
> > > 
> > >    con recv: Time appears wrong.  Set to 'Mon Oct 21 04:07:03 UTC
> > > 2024'? [yes]
> > > 
> > > The OpenBSD installer can't have changed behind our back, because we've
> > > recorded the original ISO image checksum.
> > > 
> > > So I'm wondering what other thing has changed to suddenly make this
> > > "Time appears wrong" message appear ?  Have we accidentally broken
> > > something in QEMU ?
> > > 
> > > With regards,
> > > Daniel
> > 
> > 
> > This is not new in the installer as far as I can see. But I have never
> > seen this until now.
> > 
> > https://github.com/openbsd/src/blob/
> > ad7ea506c1758b3b614d7becde019d9bf8d29459/distrib/miniroot/install.sub#L3315
> > 
> >      # If we got a timestamp from the cgi server, and that time diffs by more
> >      # than 120 seconds, ask if the user wants to adjust the time.
> >      if _time=$(http_time) && _now=$(date +%s) &&
> >          (( _now - _time > 120 || _time - _now > 120 )); then
> >          ln -sf /mnt/usr/share/zoneinfo/$TZ /etc/localtime
> >          if ask_yn "Time appears wrong.  Set to '$(date -r
> > "$(http_time)")'?" yes; then
> >              date $(date -r "$(http_time)" "+%Y%m%d%H%M.%S") >/dev/null
> >              # N.B. This will screw up SECONDS.
> >          fi
> >          rm -f /etc/localtime
> >      fi
> 
> I just tried some older versions of QEMU (where it used to work fine), but
> the error is still there. Is maybe the time of the server wrong?

Yeah, I think this is it - the openbsd server is reporting the wrnog time


$ wget -O cgiinfo.txt https://ftplist1.openbsd.org/cgi-bin/ftplist.cgi?dbversion=1
$ date -d"@$(grep TIME cgiinfo.txt| awk -F= {'print $2}')"
Mon 21 Oct 07:10:08 BST 2024
$ date
Mon 21 Oct 12:03:48 BST 2024


IOW, adding this line to our installer recipe looks wrong. We need to file
a bug somewhere to get the ftplist1.openbsd.org server time fixed.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


