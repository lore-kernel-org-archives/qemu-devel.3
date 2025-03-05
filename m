Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE366C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnCd-0005XL-Bm; Wed, 05 Mar 2025 06:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpnCV-0005WL-Qk
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpnCR-0001Sb-EH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741175164;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHi2wvXGbxe/mdEckKmg/kXgkTQnmsGZ2Erxtq9Uz3c=;
 b=A1/E7rFirWiDnNYTd7yOEkJBMS5cylZDocbbs3qeA511Qg5ymYO4ixgxZbDifIIS1fEVXv
 FD2WELNtvZtrRmKVUuzZQQ9QjBWFMNww6GRcNC+l5FlH78Z8F8cVcwX3rRJ5/Ixt0VniCU
 myfUkeSANzroeSd1J7lvW/FlRO6ey30=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-i0FU8fENPtiRNb1YLNJaHA-1; Wed,
 05 Mar 2025 06:45:50 -0500
X-MC-Unique: i0FU8fENPtiRNb1YLNJaHA-1
X-Mimecast-MFC-AGG-ID: i0FU8fENPtiRNb1YLNJaHA_1741175149
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 203C61955D80; Wed,  5 Mar 2025 11:45:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BBDA3000708; Wed,  5 Mar 2025 11:45:42 +0000 (UTC)
Date: Wed, 5 Mar 2025 11:45:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 5/7] tests/functional: skip memaddr tests on 32-bit
 builds
Message-ID: <Z8g5YC6_zkQXBv_z@redhat.com>
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-6-berrange@redhat.com>
 <a6f68dd5-379b-4868-959a-5b4b9a7e97ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6f68dd5-379b-4868-959a-5b4b9a7e97ba@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 05, 2025 at 12:32:31PM +0100, Thomas Huth wrote:
> On 28/02/2025 11.27, Daniel P. Berrangé wrote:
> > If the QEMU binary was built for a 32-bit ELF target we cannot run the
> > memory address space tests as they all require ability to address more
> > RAM that can be represented on 32-bit.
> > 
> > We can't use a decorator to skip the tests as we need setUp() to run to
> > pick the QEMU binary, thus we must call a method at the start of each
> > test to check and skip it. The functional result is effectively the
> > same as using a decorator, just less pretty. This code will go away when
> > 32-bit hosts are full dropped from QEMU.
> > 
> > The code allows any non-ELF target since all macOS versions supported
> > at 64-bit only and we already dropped support for 32-bit Windows.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/test_mem_addr_space.py | 34 +++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> > diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/test_mem_addr_space.py
> > index bb0cf062ca..c8bde77e51 100755
> > --- a/tests/functional/test_mem_addr_space.py
> > +++ b/tests/functional/test_mem_addr_space.py
> > @@ -20,6 +20,25 @@ class MemAddrCheck(QemuSystemTest):
> >       # this reason.
> >       DELAY_Q35_BOOT_SEQUENCE = 1
> > +    # This helper can go away when the 32-bit host deprecation
> > +    # turns into full & final removal of support.
> > +    def ensure_64bit_binary(self):
> > +        with open(self.qemu_bin, "rb") as fh:
> > +            ident = fh.read(4)
> > +
> > +            # "\x7fELF"
> > +            if ident != bytes([0x7f, 0x45, 0x4C, 0x46]):
> > +                # Non-ELF file implies macOS or Windows which
> > +                # we already assume to be 64-bit only
> > +                return
> > +
> > +            # bits == 1 -> 32-bit; bits == 2 -> 64-bit
> > +            bits = int.from_bytes(fh.read(1))
> 
> This unfortunately fails in the Centos CI job (so I guess there's something
> different with Python 3.8):
> 
>  https://gitlab.com/thuth/qemu/-/jobs/9316861212#L131
> 
> Looking at the test log:
> 
> Traceback (most recent call last):
>   File "/builds/thuth/qemu/tests/functional/test_mem_addr_space.py", line
> 335, in test_phybits_ok_tcg_q35_intel_cxl
>     self.ensure_64bit_binary()
>   File "/builds/thuth/qemu/tests/functional/test_mem_addr_space.py", line
> 36, in ensure_64bit_binary
>     bits = int.from_bytes(fh.read(1))
> TypeError: from_bytes() missing required argument 'byteorder' (pos 2)
> 
> Could you please have a look?

It will want

     bits = int.from_bytes(fh.read(1), byteorder='little')

From the docs

  https://docs.python.org/3/library/stdtypes.html#int.from_bytes

'byteorder' gained  default value only in py 3.11, so that explains the
cnetos failure with 3.8

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


