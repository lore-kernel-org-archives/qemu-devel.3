Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D10C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti5CM-0000CT-7G; Wed, 12 Feb 2025 00:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <egqac@eldondev.com>)
 id 1ti5CK-0000CL-NU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:22:08 -0500
Received: from npcomp.net ([69.61.8.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <egqac@eldondev.com>)
 id 1ti5CB-0000Oz-V5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:22:08 -0500
Received: by npcomp.net (Postfix, from userid 1000)
 id 89EB0577611; Wed, 12 Feb 2025 04:45:02 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
 s=eldondev; t=1739335502;
 bh=5gjepeYeBtgkaTgcVDwMqVq14MjNklcXADaVgI6i4cY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KTjpiH7t6hg9JFsd2wEZAecj6lL/7hjrTuRH+yc3fIJ70iXjqWlY4ASw6nQ06zQWm
 Ha35sk0mZud/NZtGsrWGlP1AAlMXXjs1vP/DmnccN2hLG1CNh92d5CubFYboKtCaUQ
 3vm6Zw3CKZ+w2f+qz3OVjbYVqbsAizX7+H+usK5A=
Date: Wed, 12 Feb 2025 04:45:02 +0000
From: Eldon Stegall <egqac@eldondev.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] Misc HW patches for 2025-02-10
Message-ID: <Z6wnTouJXLr-bbo5@localhost>
References: <20250210204204.54407-1-philmd@linaro.org>
 <CAJSP0QWH2+sLaNGwwLTQr5Kud6kKLML_Y24M=Kz1GSX9yRxDQw@mail.gmail.com>
 <f28e0b87-9bb2-4bb3-8c10-1f3ff0f784c2@linaro.org>
 <1ddb567a-7261-4831-9f46-7c247969a86d@linaro.org>
 <39314f09-268f-48b8-add5-95366c254f81@linaro.org>
 <6e62808e-0fc2-4de0-a732-621e81f1937e@redhat.com>
 <82b70c1e-fc21-47b1-bfcc-167399af1882@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82b70c1e-fc21-47b1-bfcc-167399af1882@redhat.com>
Received-SPF: pass client-ip=69.61.8.91; envelope-from=egqac@eldondev.com;
 helo=npcomp.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 12, 2025 at 02:39:16AM +0100, Thomas Huth wrote:
> On 12/02/2025 01.41, Thomas Huth wrote:
> > On 11/02/2025 20.03, Philippe Mathieu-Daudé wrote:
> >> On 11/2/25 19:53, Philippe Mathieu-Daudé wrote:
> >>> On 11/2/25 19:48, Philippe Mathieu-Daudé wrote:
> >>>> On 11/2/25 19:26, Stefan Hajnoczi wrote:
> >>>>> On Mon, Feb 10, 2025 at 3:43 PM Philippe Mathieu-Daudé
> >>>>> <philmd@linaro.org> wrote:
> >>>>>>
> >>>>>> The following changes since commit 
> >>>>>> 54e91d1523b412b4cff7cb36c898fa9dc133e886:
> >>>>>>
> >>>>>>    Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/ 
> >>>>>> armbru into staging (2025-02-10 10:47:31 -0500)
> >>>>>>
> >>>>>> are available in the Git repository at:
> >>>>>>
> >>>>>>    https://github.com/philmd/qemu.git tags/hw-misc-20250210
> >>>>>>
> >>>>>> for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:
> >>>>>>
> >>>>>>    hw/net/smc91c111: Ignore attempt to pop from empty RX fifo 
> >>>>>> (2025-02-10 21:30:44 +0100)
> >>>>>>
> >>>>>> ----------------------------------------------------------------
> >>>>>> Misc HW patches
> >>>>>>
> >>>>>> - Use qemu_hexdump_line() in TPM backend (Philippe)
> >>>>>> - Make various Xilinx devices endianness configurable (Philippe)
> >>>>>> - Remove magic number in APIC (Phil)
> >>>>>> - Disable thread-level cache topology (Zhao)
> >>>>>> - Xen QOM style cleanups (Bernhard)
> >>>>>> - Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
> >>>>>> - Invert logic of machine no_sdcard flag (Philippe)
> >>>>>> - Housekeeping in MicroBlaze functional tests (Philippe)
> >>>>>
> >>>>> Please take a look at this CI failure:
> >>>>> https://gitlab.com/qemu-project/qemu/-/jobs/9106591368
> >>>>
> >>>> Hmm I can not reproduce locally this error:
> >>>>
> >>>>    Exception: Asset cache is invalid and downloads disabled
> >>>
> >>> OK, I could reproduce by blowing my cache away.
> >>>
> >>> The problem seems in the "tests/functional: Have microblaze tests
> >>> inherit common parent class" patch, which does:
> >>>
> >>> -class MicroblazeelMachine(QemuSystemTest):
> >>> +class MicroblazeLittleEndianMachine(MicroblazeMachine):
> >>>
> >>> I presume, since MicroblazeLittleEndianMachine is no more a direct
> >>> child of QemuSystemTest, then the ASSET_IMAGE_* aren't automatically
> >>> downloaded.
> >>
> >> Well, apparently related to network failure:
> >>
> >> INFO:qemu-test:Downloading http://www.qemu-advent-calendar.org/2023/ 
> >> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
> >> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
> >> ERROR:qemu-test:Unable to download http://www.qemu-advent- 
> >> calendar.org/2023/ download/day13.tar.gz: HTTP Error 403: Forbidden
> >>
> >> $ curl -v http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
> >>  > GET /2023/download/day13.tar.gz HTTP/1.1
> >> < HTTP/1.1 301 Moved Permanently
> >> < Location: https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz
> >>
> >> Using:
> >>
> >> -- >8 --
> >> diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/ 
> >> functional/test_microblaze_s3adsp1800.py
> >> index 177c8a685bc..949e627c84a 100755
> >> --- a/tests/functional/test_microblaze_s3adsp1800.py
> >> +++ b/tests/functional/test_microblaze_s3adsp1800.py
> >> @@ -24,3 +24,3 @@ class MicroblazeMachine(QemuSystemTest):
> >>       ASSET_IMAGE_LE = Asset(
> >> -        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> >> + ('https://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> >>
> >> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> >> ---
> >>
> >> I still get:
> >>
> >> INFO:qemu-test:Downloading https://www.qemu-advent-calendar.org/2023/ 
> >> download/day13.tar.gz to /Users/philmd/.cache/qemu/download/ 
> >> b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22...
> >>
> >> However:
> >>
> >> $ curl --http1.0 -v https://www.qemu-advent-calendar.org/2023/download/ 
> >> day13.tar.gz
> >>  > GET /2023/download/day13.tar.gz HTTP/1.0
> >> < HTTP/1.0 200 OK
> >> < Content-Length: 4752277
> >> < Content-Type: application/gzip
> >>
> >> So I'm confused...
> > 
> > Looks like this also happens in test runs without your patches:
> > 
> >   https://gitlab.com/qemu-project/qemu/-/jobs/9108828196#L844
> > 
> > The test then silently gets skipped there (since we only fail hard for a 404 
> > error now).
> > 
> > Maybe Eldon could comment why the downloads are blocked for python scripts 
> > but not for curl downloads?
> > 
> > I the worst case, we have to mirror the asset to another place, I guess...
> 
> Ok, I've now also put the image here:
> 
>   https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day05.tar.xz
> 
> (just had to use a different day number there since 13 was an image that I 
> did not want to sacrifice in the best-of roaster).
> 
> So if the qemu-advent-calendar.org server keeps refusing the downloads, you 
> should be able to use the mirrored tarball instead.
> 
>   HTH,
>    Thomas
> 
>

Hello! I recently switched some of the underlying object storage for
sites including the advent calendar, and this was a (very) unintended
consequence. I have now switched to a good old apache upstream for
these, so I would not expect this error to recur. Also, looking to make
another attempt at a calendar for 2025 (end of 2024 was a complicated
time for me). Let me know if you'd like to produce/contribute!

Thanks,
Eldon

