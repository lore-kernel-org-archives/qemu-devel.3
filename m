Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C31DD7833F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPkG-0000VH-Um; Tue, 03 Dec 2024 05:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPkE-0000Uu-Dy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIPkB-0007J2-DT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733220177;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKf6r369rHnf2u9jCTDPcLjD9loWMUYulW2zrdihdWE=;
 b=ekCFZunaRN/fe+Hbt8JzN7otFsx52PDiZyGezWvdB5J48a1wsLRWYWOxmXx5M93ltWYZcX
 oBDVyd+e7XT9D5IBwdI65FrscD73I2VxyGlIqY0PXBGdNmpXia+9y/5mlBCQGv/JgKk07k
 JmL2qvJZgn2FvHIMPTqufJm14Q+GO8w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-nfPLfC9lNJGtfIgrukY9iQ-1; Tue,
 03 Dec 2024 05:02:54 -0500
X-MC-Unique: nfPLfC9lNJGtfIgrukY9iQ-1
X-Mimecast-MFC-AGG-ID: nfPLfC9lNJGtfIgrukY9iQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C19D1954193; Tue,  3 Dec 2024 10:02:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D3481956052; Tue,  3 Dec 2024 10:02:50 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:02:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH-for-9.2? v2 1/2] tests/functional/test_version: Use QTest
 accelerator
Message-ID: <Z07XRkf2cs-IOyq_@redhat.com>
References: <20241203091036.59898-1-philmd@linaro.org>
 <20241203091036.59898-2-philmd@linaro.org>
 <Z07M4jpxZo9Ns0Rj@redhat.com>
 <884bb70b-bb7a-4676-ab74-fd19a2758955@linaro.org>
 <9124df54-a9a7-401b-8b0e-b81ac4dab365@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9124df54-a9a7-401b-8b0e-b81ac4dab365@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 03, 2024 at 10:38:26AM +0100, Philippe Mathieu-Daudé wrote:
> On 3/12/24 10:26, Philippe Mathieu-Daudé wrote:
> > On 3/12/24 10:18, Daniel P. Berrangé wrote:
> > > On Tue, Dec 03, 2024 at 10:10:35AM +0100, Philippe Mathieu-Daudé wrote:
> > > > When testing with a HVF-only binary, we get:
> > > > 
> > > >     3/12 qemu:func-quick+func-aarch64 / func-aarch64-
> > > > version                                      ERROR           
> > > > 0.29s   exit status 1
> > > >    stderr:
> > > >    Traceback (most recent call last):
> > > >      File "tests/functional/test_version.py", line 22, in
> > > > test_qmp_human_info_version
> > > >        self.vm.launch()
> > > >      File "machine/machine.py", line 461, in launch
> > > >        raise VMLaunchFailure(
> > > >    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to
> > > > establish session: EOFError
> > > >        Exit code: 1
> > > >        Command: build/qemu-system-aarch64 -display none -vga
> > > > none - chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control
> > > > -machine none -nodefaults
> > > >        Output: qemu-system-aarch64: No accelerator selected and
> > > > no default accelerator available
> > > > 
> > > > Explicit the QTest accelerator to be able to run the HMP command.
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >   tests/functional/test_version.py | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/tests/functional/test_version.py
> > > > b/tests/functional/ test_version.py
> > > > index 3ab3b67f7e3..d3da796991f 100755
> > > > --- a/tests/functional/test_version.py
> > > > +++ b/tests/functional/test_version.py
> > > > @@ -18,6 +18,7 @@ class Version(QemuSystemTest):
> > > >       def test_qmp_human_info_version(self):
> > > >           self.set_machine('none')
> > > > +        self.vm.add_args('-accel', 'qtest')
> > > 
> > > IMHO this is wrong. The functional tests are there to test the
> > > real functional behaviour under an actual accelerator not qtest.
> > 
> > It works using '-accel hvf'. The issue is:
> > 
> >    "No accelerator selected and no default accelerator available"
> > 
> > So we should select HVF over QTest by default? I tend to not
> > enforce any default because we always get troubles with them,
> > what is today's default is unlikely tomorrow's one.
> 
> So by using:
> 
> -- >8 --
> diff --git a/system/vl.c b/system/vl.c
> index 54998fdbc7e..2f855d83fbb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2362,6 +2362,7 @@ static void configure_accelerators(const char
> *progname)
>              /* Select the default accelerator */
>              bool have_tcg = accel_find("tcg");
>              bool have_kvm = accel_find("kvm");
> +            bool have_hvf = accel_find("hvf");
> 
>              if (have_tcg && have_kvm) {
>                  if (g_str_has_suffix(progname, "kvm")) {
> @@ -2374,6 +2375,8 @@ static void configure_accelerators(const char
> *progname)
>                  accelerators = "kvm";
>              } else if (have_tcg) {
>                  accelerators = "tcg";
> +            } else if (have_hvf) {
> +                accelerators = "hvf";
>              } else {
>                  error_report("No accelerator selected and"
>                               " no default accelerator available");
> 
> ---
> 
> All test suites pass on my HVF-only build directory. If this is
> OK with you then this is also OK for me.

If all the functional tests pass with HVF that is a good stamp of approval
for the quality & usefulness of HVF, and should justify enabling it by
default IMHO.

I might even suggest that we should flip to rank HVF above TCG, on the
principal that HW accelerator is preferrable when available.

I don't think we slip this into 9.2 at this stage in -rcNN, but perhaps
do this early in 10.0 and propose for stable (TCG preferred over HVF),
then flip the TCG & HVF ordering to prefer HVF for remainder of 10.x
and the future

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


