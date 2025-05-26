Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA8C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYAu-0000vP-Sx; Mon, 26 May 2025 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJYAq-0000vC-Ji
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJYAo-0003Xz-Sz
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748267244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZ4JvpKZxj5hngF9eLOt1AsdcpmcLWKX/H+SWKzjBAc=;
 b=a0mAahZmEN8QnOLZlBaTHW1RXgdTh0gw5zDBtXef7WjDorawAxn4bmG9HoshkuvuBB3kjj
 JtrUqP/GiiHZRPRBTjkfCgTjcPonW7r8F9cq0ndk5dRx7IV97q/varFYHkCHPMaltKOQhs
 w+OUglt7XV/fCrL8iFJs5jUIf19ALhM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-fls_v04UOFyLxRW8a5Y1yw-1; Mon, 26 May 2025 09:47:23 -0400
X-MC-Unique: fls_v04UOFyLxRW8a5Y1yw-1
X-Mimecast-MFC-AGG-ID: fls_v04UOFyLxRW8a5Y1yw_1748267242
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6faa53cbc74so25573426d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748267242; x=1748872042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZ4JvpKZxj5hngF9eLOt1AsdcpmcLWKX/H+SWKzjBAc=;
 b=FJ+kgWMf0CiXZTMMMaIIlLYxtDJpStQwDNKtJHPXiVi9+3ExQO1b/kNR+F9rsZweZ2
 VVTLx33Uo194udKEU0r1HEnn5ZlI4ge5qL7sSQvWib5wXGEVhLiaq4xA6XAct76Hgsae
 883QvPfsnian/pYX366KFPnt3fCKH70DqydxOkB+v3pBG8ouJk7/pNCvy+OmX2tr/2Un
 B3gWcpJJVwb5Z6zidLIZ21GyVvHm+RIOewpxexapK91AxZrxCD/07OmtXcND83vTQG3V
 r+5LlEGmaNSQWI8vs6LvWFUuezKtEZqnUvsGtDTvWUpVeGfipNEbWrYaW8ykvr+etWHE
 Qiqg==
X-Gm-Message-State: AOJu0YymRkHb70RGTcjhlMCAYGQn+r1ZGPpWVasXkxUM4SmPR4vYcZxA
 ArieR0Bqet98C011kXU2WXWCa65yIjawuRiTzaifD+uVZQ2yjjgNc1pHjWh+lKPEUGv3qbrgDsD
 xDJn7ClC6H9YCfBKRJDw44a9dh+WV7s8Or8bDs38+z0IlVx1ZGNXFNiLq
X-Gm-Gg: ASbGncsy9fLbJBE0sJsBqJ8eCxxMCjW84Cr19mRmnhdBJZVZ5fzxsIlguxe0n6f7w7M
 GLzDCE53a0FXKNt2O4FkSBBwHPGcL16cu4ervbKVTgaiBsMuhA2wq9VIcI4Fy/YHH2bkX144A2K
 pkG2GAJi7ILCoWUm3grP4YH6Xlj0+jMbhjLOZf8cobDdtwHYBpb7RPjr/uk7rDU0T2sTn6g6VoQ
 Eaz7ZcQqoujNOK64zHuomcKAO7ToT576lEbgqUFSG/I1dlvz8JvuCLFu2I8z2QOmA63pSlvmtFo
 IZs=
X-Received: by 2002:a05:6214:c6f:b0:6f4:cbcf:5cea with SMTP id
 6a1803df08f44-6fa9d2bde67mr131035216d6.44.1748267242393; 
 Mon, 26 May 2025 06:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5/2Ug5ZRgmZFyPFHqQ4PQd2FH+zbjEl85BeUY9y36iTv6Wtq9kcdtQ59+Dl33WMBBhHkfg==
X-Received: by 2002:a05:6214:c6f:b0:6f4:cbcf:5cea with SMTP id
 6a1803df08f44-6fa9d2bde67mr131034916d6.44.1748267241994; 
 Mon, 26 May 2025 06:47:21 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6faa56dabe0sm20788116d6.103.2025.05.26.06.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 06:47:21 -0700 (PDT)
Date: Mon, 26 May 2025 09:47:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 4/4] tests/functional/test_vmstate: Test whether the
 checker script works as expected
Message-ID: <aDRw5jst47MwwOi1@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-5-thuth@redhat.com>
 <aC83QUmY6B255lTb@x1.local>
 <1fa7b5a7-585b-415d-900b-092f9ec13c52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fa7b5a7-585b-415d-900b-092f9ec13c52@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

On Thu, May 22, 2025 at 08:12:49PM +0200, Thomas Huth wrote:
> On 22/05/2025 16.40, Peter Xu wrote:
> > On Thu, May 22, 2025 at 03:37:56PM +0200, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > We've got two vmstate dump files in the repository which are meant
> > > for verifying whether the vmstate-static-checker.py works as expected.
> > > Since running this manually is a cumbersome job, let's add an automated
> > > test for this instead that runs the script with the two dump files
> > > and checks for the expected output.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/functional/test_vmstate.py | 37 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
> > > index cc988987481..19a62e8a17e 100755
> > > --- a/tests/functional/test_vmstate.py
> > > +++ b/tests/functional/test_vmstate.py
> > > @@ -9,6 +9,22 @@
> > >   from qemu_test import QemuSystemTest
> > > +expected_output='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
> > > +Section "fw_cfg" does not exist in dest
> > > +Section "fusbh200-ehci-usb" version error: 2 > 1
> > > +Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
> > > +Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
> > > +Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
> > > +Section "cfi.pflash01": Entry "Description" missing
> > > +Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
> > > +Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
> > > +Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
> > > +Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
> > > +Section "sun-fdtwo" Description "fdc": version error: 2 > 1
> > > +Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
> > > +Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
> > > +'''
> > > +
> > >   class VmStateTest(QemuSystemTest):
> > >       def run_vmstate_checker(self, src_json, dst_json):
> > > @@ -19,6 +35,27 @@ def run_vmstate_checker(self, src_json, dst_json):
> > >                                 stderr=subprocess.STDOUT,
> > >                                 text=True)
> > > +    def test_checker(self):
> > > +        """
> > > +        Test whether the checker script correctly detects the changes
> > > +        between dump1.json and dump2.json.
> > > +        """
> > > +        if self.arch != 'x86_64':
> > > +            self.skipTest('for x86 only')
> > > +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> > > +                                  'dump1.json')
> > > +        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
> > > +                                  'dump2.json')
> > > +        self.log.info(f'Comparing {src_json} with {dst_json}')
> > > +        cp = self.run_vmstate_checker(src_json, dst_json)
> > > +        if cp.returncode != 13:
> > > +            self.fail('Unexpected return code of vmstate-static-checker: ' +
> > > +                      cp.returncode)
> > > +        if cp.stdout != expected_output:
> > > +            self.log.info('vmstate-static-checker output:\n' + cp.stdout)
> > > +            self.log.info('expected output:\n' + expected_output)
> > > +            self.fail('Unexpected vmstate-static-checker output!')
> > > +
> > 
> > Would this run for every make check and every CI run?
> 
> Yes.
> 
> > Since the script almost never change, I wonder whether this test should be
> > triggered only if manually.
> 
> We could disable it by default with a @skip... decorator, but I think it's
> not really worth the effort: The runtime of test_checker() is about 100 ms,
> that's really nothing compared to the hunders of seconds that some other
> tests take.

Right, not a concern of time used but only CPU burns.

Meanwhile, this is not part of the QEMU function that the repo delivers,
but the infra to test QEMU, hence here we're always running this check
script for everyone testing yet another almost not-changing (and may not be
helpful, not anymore?) script to test QEMU..

I think we should save the cycles, but no strong opinions.

Thanks,

-- 
Peter Xu


