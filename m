Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C5CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 22:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCQQJ-0000Fz-2T; Tue, 06 May 2025 18:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCQQH-0000FR-QF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 18:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uCQQE-0000sg-Lh
 for qemu-devel@nongnu.org; Tue, 06 May 2025 18:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746569150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOATj9lyH6AQruL4xg9k70AFdf72+kN1qINmlp6O3OY=;
 b=UKxqQRIIo2tSspIu/5eddpltef1c6Kk8b2F5i6iUvsOeo8TeB6uCYeYNVO64HwR2D1LhLA
 1mHxWUN/jF+G5yVxrF6yQ8xFOn0Pm6s6tVtDIASmXq5tDu+ie9uQa/GmpjSNyvILgMGOng
 mKXWQIVJiqz1kKKd2R6an5Cj1f0ZXfk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-E-WkT4CyNHaHPi-enw30IQ-1; Tue, 06 May 2025 18:05:48 -0400
X-MC-Unique: E-WkT4CyNHaHPi-enw30IQ-1
X-Mimecast-MFC-AGG-ID: E-WkT4CyNHaHPi-enw30IQ_1746569148
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5d608e703so1169245285a.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 15:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746569148; x=1747173948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOATj9lyH6AQruL4xg9k70AFdf72+kN1qINmlp6O3OY=;
 b=DXVC/Y52bS+xKfyzCGW9p66PG8RvkNTBXqfIry+IlxEBSf4VseheA+gwSgGTSK1ImO
 v0T2yWC3P3SshePP6xMLZIKZ9nyagXK3iGW7f8Vdns4ipGBA9NB5pcbILKqqNiQLikBe
 ZgsItoDU1uRJGMsKopLo1DqcoRzWuqYzFtGBI1EPx64kV0iFT22SXDvjjL0jBMJsEJTO
 olq3tMWDkjCj5LpGrfH669w7uxYDby29bJsyaEIZv8rVqtLnWpaCUicxDXJ74WR2d8A5
 SkePuqOVoUN3B9KKKPJTMgh8uhZLyZclcshf6xaRZK1jf7tLU881Av+ezeQEVEKQ+u4+
 qgUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLFLO6eOpaxnRVbtAYcGz7SQ/hnlu1OROUarQR1g8Ov6EAo0NU+A52n4sG0PQSzYPM0y+M0EVH6gbB@nongnu.org
X-Gm-Message-State: AOJu0Yygsgw26Wn13yLhHi2y+hjdkv9RLLZLMRssqo0MgtpKp13makHL
 X9FmoyAbc7GsrnAqwuHlx8/EQisQQiCn+HkZznS4pborbgujA9tOxBMdKoyPYuNFBJLAStQqbQ/
 tnHq9R/dutGGxOH/iSXCX11tTPX97Cs3i/5n3Q0TKD1eP99nJBYXw
X-Gm-Gg: ASbGncuj3PHcnD+/uX0ZOhj5sK1FyaBXp4BnMuF6zE5fJ/cQcalUpKZDrH4upKKrjdQ
 u6D6J6AnEfhxfJT4hcYUHlB3MEnKoLc9UgFXxCZPnO4Aw2QdkvX/v9j83Xido+Tll6QppL9CSOB
 G4t0kPq4JvefrJmHZiOPzBiku76NqF0GBes6QFvEqDpkg3WKZX+wPsjTPQpzUEyNd1vrLNQmUWU
 jOKX44o0pQjBDXXAkVilrlTj8PUmLKAH7eBeZKnRjf7fJyKxuWxfXQ7Bw4t7f8O8E0DqNTdgbhK
 icM=
X-Received: by 2002:a05:620a:17a6:b0:7c5:4eee:5409 with SMTP id
 af79cd13be357-7caf741cb91mr173478585a.48.1746569148248; 
 Tue, 06 May 2025 15:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTeZlVE2WDYiC1FLHv3HyvA3+xL6FGW07Ikrx+zsMLHtJgCaCHmKqbYvMNKHcYRtQ0j2yAiA==
X-Received: by 2002:a05:620a:17a6:b0:7c5:4eee:5409 with SMTP id
 af79cd13be357-7caf741cb91mr173474585a.48.1746569147810; 
 Tue, 06 May 2025 15:05:47 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7caf75d8b4asm33256485a.96.2025.05.06.15.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 15:05:47 -0700 (PDT)
Date: Tue, 6 May 2025 18:05:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Message-ID: <aBqHt0vhGYFrrTh2@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-5-thuth@redhat.com>
 <d47d36db-f94c-45ee-bdf0-477607703461@linaro.org>
 <aBOE8iwN0oIVfwTi@x1.local>
 <5a0ff4e4-6687-4651-aff2-626615451a5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a0ff4e4-6687-4651-aff2-626615451a5d@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 01, 2025 at 08:58:33AM -0700, Pierrick Bouvier wrote:
> On 5/1/25 7:28 AM, Peter Xu wrote:
> > On Wed, Apr 30, 2025 at 09:10:30AM -0700, Pierrick Bouvier wrote:
> > > On 4/29/25 8:21 AM, Thomas Huth wrote:
> > > > From: Thomas Huth <thuth@redhat.com>
> > > > 
> > > > We've got this nice vmstate-static-checker.py script that can help
> > > > to detect screw-ups in the migration states. Unfortunately, it's
> > > > currently only run manually, so there could be regressions that nobody
> > > > notices immediately. Let's run it from a functional test automatically
> > > > so that we got at least a basic coverage in each CI run.
> > > > 
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >    MAINTAINERS                      |  1 +
> > > >    tests/functional/meson.build     | 13 +++++++-
> > > >    tests/functional/test_vmstate.py | 56 ++++++++++++++++++++++++++++++++
> > > >    3 files changed, 69 insertions(+), 1 deletion(-)
> > > >    create mode 100755 tests/functional/test_vmstate.py
> > > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 65fb61844b3..6a8d81458ad 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -3525,6 +3525,7 @@ F: migration/
> > > >    F: scripts/vmstate-static-checker.py
> > > >    F: tests/data/vmstate-static-checker/
> > > >    F: tests/functional/test_migration.py
> > > > +F: tests/functional/test_vmstate.py
> > > >    F: tests/qtest/migration/
> > > >    F: tests/qtest/migration-*
> > > >    F: docs/devel/migration/
> > > > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > > > index b317ad42c5a..9f339e626f6 100644
> > > > --- a/tests/functional/meson.build
> > > > +++ b/tests/functional/meson.build
> > > > @@ -76,6 +76,7 @@ tests_generic_bsduser = [
> > > >    tests_aarch64_system_quick = [
> > > >      'migration',
> > > > +  'vmstate',
> > > >    ]
> > > >    tests_aarch64_system_thorough = [
> > > > @@ -164,6 +165,10 @@ tests_loongarch64_system_thorough = [
> > > >      'loongarch64_virt',
> > > >    ]
> > > > +tests_m68k_system_quick = [
> > > > +  'vmstate',
> > > > +]
> > > > +
> > > >    tests_m68k_system_thorough = [
> > > >      'm68k_mcf5208evb',
> > > >      'm68k_nextcube',
> > > > @@ -230,6 +235,7 @@ tests_ppc_system_thorough = [
> > > >    tests_ppc64_system_quick = [
> > > >      'migration',
> > > > +  'vmstate',
> > > >    ]
> > > >    tests_ppc64_system_thorough = [
> > > > @@ -265,6 +271,10 @@ tests_rx_system_thorough = [
> > > >      'rx_gdbsim',
> > > >    ]
> > > > +tests_s390x_system_quick = [
> > > > +  'vmstate',
> > > > +]
> > > > +
> > > >    tests_s390x_system_thorough = [
> > > >      's390x_ccw_virtio',
> > > >      's390x_replay',
> > > > @@ -305,8 +315,9 @@ tests_x86_64_system_quick = [
> > > >      'migration',
> > > >      'pc_cpu_hotplug_props',
> > > >      'virtio_version',
> > > > -  'x86_cpu_model_versions',
> > > > +  'vmstate',
> > > >      'vnc',
> > > > +  'x86_cpu_model_versions',
> > > >    ]
> > > >    tests_x86_64_system_thorough = [
> > > > diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
> > > > new file mode 100755
> > > > index 00000000000..3ba56d580db
> > > > --- /dev/null
> > > > +++ b/tests/functional/test_vmstate.py
> > > > @@ -0,0 +1,56 @@
> > > > +#!/usr/bin/env python3
> > > > +#
> > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > > +#
> > > > +# This test runs the vmstate-static-checker script with the current QEMU
> > > > +
> > > > +import subprocess
> > > > +
> > > > +from qemu_test import QemuSystemTest
> > > > +
> > > > +
> > > > +class VmStateTest(QemuSystemTest):
> > > > +
> > > > +    def test_vmstate(self):
> > > > +        target_machine = {
> > > > +            'aarch64': 'virt-7.2',
> > > > +            'm68k': 'virt-7.2',
> > > > +            'ppc64': 'pseries-7.2',
> > > > +            's390x': 's390-ccw-virtio-7.2',
> > > > +            'x86_64': 'pc-q35-7.2',
> > > > +        }
> > > > +        self.set_machine(target_machine[self.arch])
> > > > +
> > > > +        # Run QEMU to get the current vmstate json file:
> > > > +        dst_json = self.scratch_file('dest.json')
> > > > +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
> > > > +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> > > > +                             '-M', target_machine[self.arch],
> > > > +                             '-dump-vmstate', dst_json],
> > > > +                            stdout=subprocess.PIPE,
> > > > +                            stderr=subprocess.STDOUT,
> > > > +                            text=True)
> > > > +        if cp.returncode != 0:
> > > > +            self.fail('Running QEMU failed:\n' + cp.stdout)
> > > > +        if cp.stdout:
> > > > +            self.log.info('QEMU output: ' + cp.stdout)
> > > > +
> > > > +        # Check whether the old vmstate json file is still compatible:
> > > > +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> > > > +                                  self.arch,
> > > > +                                  target_machine[self.arch] + '.json')
> > > > +        vmstate_checker = self.data_file('..', '..', 'scripts',
> > > > +                                         'vmstate-static-checker.py')
> > > > +        self.log.info('Comparing vmstate with ' + src_json)
> > > > +        cp = subprocess.run([vmstate_checker, '-s', src_json, '-d', dst_json],
> > > > +                            stdout=subprocess.PIPE,
> > > > +                            stderr=subprocess.STDOUT,
> > > > +                            text=True)
> > > > +        if cp.returncode != 0:
> > > > +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
> > > > +        if cp.stdout:
> > > > +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
> > > > +
> > > > +
> > > > +if __name__ == '__main__':
> > > > +    QemuSystemTest.main()
> > > 
> > > Thanks for this series Thomas, it's very useful.
> > > Could we extend this automatically to test migration on all combinations:
> > > {qemu-system-*} x {machine}?
> > > We could generate a single list of references, containing hashes of all
> > > outputs, and a simple and clean command to regenerate all those, and
> > > associated jsons, so we don't pollute qemu code with tons of json.
> > 
> > I think a major challenge would be false positives, and how to filter
> > them.. when we put anything into CI.
> > 
> 
> A fail would be expected everytime something changes:
> - it can be a default field that has a new value (particularly sensitive for
> cpus)
> - it can be a new cpu field that is added
> - it can be a board definition change
> - it can be a hardware related change
> 
> In all cases, even though it does not break migration, it's interesting to
> know such a change happen.
> As well, if it's simple to update and get differences of the various dumps
> per {binary, board}, then it's trivial to identify and comment the "false
> positive". The more often it runs (ideally, per PR, or per series), the
> easier it is to identify what changed.
> 
> > Side note: yesterday I just wrote a script to do exactly this, by auto
> > build binaries and check all relevant archs over all machine types
> > supported.  It looks like this:
> > 
> > https://gitlab.com/peterx/qemu/-/commit/c4abfa39f8943cd62f0d982ecb36537df398ae70
> > 
> > The plan is I can run this at the end of each release, though.. not yet for
> > CI.  I also don't have plan to upstream this script, maybe I'll keep it
> > myself as of now unless someone thinks we should have it.
> > 
> 
> Glad to hear we have a script, but sad to hear "will run manually once every
> 6 months".
> 
> > PS: I just ran it over v9.2..v10.0 over the default 4 archs
> > (x86,arm,ppc,s390) and a huge list was generated..  I believe most of them
> > are false positives, I'll delay walking the list for some time..  I
> > attached the result at the end in case anyone is interested.
> > 

I probably forgot to do that.  Here's the condensed list, and this time I
went throught it, even though I found zero real bug.. so all false
positives, AFAICT..

Found forward migration incompatibility issues:

  Section "acpi-ged", Description "acpi-ghes": expected field "ghes_addr_le", got "hw_error_le"; skipping rest
  Section "sysbus-ahci" does not exist in dest
  Section "imx.enet" Section "imx.enet" Description "imx.fec": minimum version error: 2 < 3
  Section "imx.enet", Description "imx.fec": expected field "phy_status", while dest has no further fields
  Section "npcm7xx-clk" Section "npcm7xx-clk" Description "npcm7xx-clk": minimum version error: 1 < 3
  Section "npcm7xx-clk": Description "npcm7xx-clk" missing, got "npcm-clk" instead; skipping
  Section "npcm7xx-gcr" Section "npcm7xx-gcr" Description "npcm7xx-gcr": minimum version error: 0 < 2
  Section "npcm7xx-gcr": Description "npcm7xx-gcr" missing, got "npcm-gcr" instead; skipping
  Section "lan9118" Section "lan9118" Description "lan9118": minimum version error: 2 < 3
  Section "lan9118", Description "lan9118": expected field "phy_status", got "eeprom_writable"; skipping rest
  Section "imx.fec" Section "imx.fec" Description "imx.fec": minimum version error: 2 < 3
  Section "imx.fec", Description "imx.fec": expected field "phy_status", while dest has no further fields

Found backward migration incompatibility issues:

  Section "uefi-vars-sysbus" does not exist in dest
  Section "acpi-ged", Description "acpi-ghes": expected field "hw_error_le", got "ghes_addr_le"; skipping rest
  Section "uefi-vars-x64" does not exist in dest
  Section "vmclock" does not exist in dest
  Section "virtio-mem" does not exist in dest
  Section "npcm8xx-gcr" does not exist in dest
  Section "imx.enet" version error: 3 > 2
  Section "imx.enet" Description "imx.fec": version error: 3 > 2
  Section "rs5c372" does not exist in dest
  Section "imx8mp.analog" does not exist in dest
  Section "npcm7xx-clk" version error: 3 > 1
  Section "npcm7xx-clk" Description "npcm-clk": version error: 3 > 1
  Section "npcm7xx-clk": Description "npcm-clk" missing, got "npcm7xx-clk" instead; skipping
  Section "imx8mp.ccm" does not exist in dest
  Section "npcm7xx-gcr" version error: 2 > 0
  Section "npcm7xx-gcr" Description "npcm-gcr": version error: 2 > 0
  Section "npcm7xx-gcr": Description "npcm-gcr" missing, got "npcm7xx-gcr" instead; skipping
  Section "fsl-imx8m-pcie-phy" does not exist in dest
  Section "imx8mp.gpt" does not exist in dest
  Section "lan9118" version error: 3 > 2
  Section "lan9118" Description "lan9118": version error: 3 > 2
  Section "lan9118", Description "lan9118": expected field "eeprom_writable", got "phy_status"; skipping rest
  Section "imx.fec" version error: 3 > 2
  Section "imx.fec" Description "imx.fec": version error: 3 > 2
  Section "lan9118-phy" does not exist in dest
  Section "aspeed.hace-ast2700" does not exist in dest
  Section "npcm-clk" does not exist in dest
  Section "aspeed.sdhci-ast2400" does not exist in dest
  Section "npcm-gcr" does not exist in dest
  Section "aspeed.sdhci-ast2500" does not exist in dest
  Section "npcm-pcs" does not exist in dest
  Section "aspeed.sdhci-ast2600" does not exist in dest
  Section "aspeed.timer-ast2700" does not exist in dest
  Section "npcm8xx-clk" does not exist in dest
  Section "aspeed.sdhci-ast2700" does not exist in dest

> 
> Would that be possible to post this on an online forge like GitLab, and
> commit the previous and new versions of dumps (the data, not the list of
> failures), so we can see all the differences in a nice way?

It should be easy to do, but now I'm thinking how much it would help
developers.

As discussed above, I finally went through the list for the previous
release cycle, and I see no real positive reports.

It could be that the script used to be able to capture more real issues,
but as more developers / maintainers got reports, then such issues are less
likely to happen.  Do any of us used that to find any real bug recently?

I also start to doubt whether we should keep growing the renaming list.
First of all, such list isn't that helpful if we don't run that on old
enough binaries - the rename will not cause false positive anymore as long
as we compare newer binaries from the commit it got changed.  So if we run
it per-release the rename will only bother us once per release..

> 
> > > 
> > > This way, we can automatically detect that we never regress, not only from
> > > release to release, but commit to commit.
> > > 
> > > In case we need to update reference, people can point what's the actual
> > > difference in the commit message.
> > > 
> > > As well, since I took a look into that before, this check is not enough
> > > regarding migration. Beyonds the VMDstate, we should check as well that the
> > > default values of every field are not changed. For instance, we recently
> > > changed the default pauth property of arm cpus, and without a careful
> > > backcompat, it would have break migration. It's a bit more tricky, since
> > > there is nothing available now to dump this (I hacked that using a custom
> > > trace). And definitely not something in the scope of your series, just worth
> > > mentioning.
> > > 
> > > I hope we can one day get rid of all "Is this change safe regarding
> > > migration?" comments because we know we can trust our CI instead.
> > 
> > IMHO it's extremely hard (if not impossible) to guarantee that, because
> > some migration bug may only trigger in special paths that not always
> > happen, e.g. it can even involve guest driver behavior.
> > 
> 
> It would not cover 100%, but if we already make sure that a VM stopped at
> end of qemu_init() has a predictable dump, it's already a huge win over
> having nothing.
> We can use the same argument that current QEMU CI does not cover 100% of the
> code (*much* less than that from what I tried), but it's still better than
> no test.

So now I start to question whether we need to work more on the whole
vmstate static checker..  I think I'll still try to keep running it once
per release for some while, but if I can't catch any real bug maybe we're
good from this regard, and people just started being very cautious on
e.g. randomly adding or removing vmsd fields.

Let me know if anyone thinks it differently..

Thanks,

-- 
Peter Xu


