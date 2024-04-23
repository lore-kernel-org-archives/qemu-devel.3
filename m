Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHfr-0001Mc-IY; Tue, 23 Apr 2024 11:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rzHfa-0001AD-V0
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rzHfW-000708-Ck
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713884568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peBAFTsHFmx2t6BfkBfJiJav/IFFwVk2FE9pFB1gXEg=;
 b=fBEmcvkxDCijd8RjaVM7bGlkPRlqjYPZMGmA1TUcT+UBPQgwqb/Zh3oGa+N6WHz3cMHHgY
 SjqWWSksDE5qyowknhxlKCsTB08i0dLaO6YruNzH7i8JgdznphKhAHxmriSe5GgTzCMvfu
 fSMpe8wq0YFAtA+BaNg4QzM6L8QuVR4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-CzASXUkoNXeH6X0nGLB1fQ-1; Tue, 23 Apr 2024 11:02:44 -0400
X-MC-Unique: CzASXUkoNXeH6X0nGLB1fQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 177551011324;
 Tue, 23 Apr 2024 15:02:44 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7A782166B31;
 Tue, 23 Apr 2024 15:02:43 +0000 (UTC)
Date: Tue, 23 Apr 2024 16:02:43 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Cc: deller@gmx.de, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: hppa-firmware.img missing build-id
Message-ID: <20240423150243.GB7636@redhat.com>
References: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 23, 2024 at 10:11:50AM -0400, Cole Robinson wrote:
> Hi,
> 
> hppa-firmware.img and hppa-firmware64.img in qemu.git are missing ELF
> build-id annotations. rpm builds on Fedora will error if an ELF binary
> doesn't have build-id:
> 
> RPM build errors:
>     Missing build-id in
> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware.img
>     Missing build-id in
> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hppa-firmware64.img
>     Generating build-id links failed
> 
> I didn't hit this with qemu 8.2.* builds FWIW

Discussed in chat, and I think the consensus is to rebuild these
downstream, since we have the cross-compilers available.  It requires
adding -Wl,--build-id=sha1 at link time.

FWIW this worked for me on Fedora:

# dnf install /usr/bin/hppa-linux-gnu-gcc
$ pushd roms/seabios-hppa
$ make parisc
$ popd

That didn't actually add the .note.gnu.build-id section though, you
have to add this patch:

diff --git a/Makefile.parisc b/Makefile.parisc
index 36edc0c2..3e0c1812 100644
--- a/Makefile.parisc
+++ b/Makefile.parisc
@@ -168,7 +168,7 @@ $(OUT)hppa-firmware$(BIT_SUFFIX).img: $(OUT)autoconf.h $(OUT)head.o $(OUT)ccode3
        @echo "  Linking $@"
        $(Q)$(CPP) $(CPPFLAGS) -Isrc -D__ASSEMBLY__ -DBITS=$(BITS) src/parisc/pafirmware.lds.S -o $(OUT)pafirmware.lds
        $(Q)$(CC) $(CFLAGS32FLAT) -c src/version.c -o $(OUT)version.o
-       $(Q)$(LD) -N -T $(OUT)pafirmware.lds $(OUT)head.o $(OUT)version.o -X -o $@ -e startup --as-needed $(OUT)ccode32flat.o $(LIBGCC)
+       $(Q)$(LD) --build-id=sha1 -N -T $(OUT)pafirmware.lds $(OUT)head.o $(OUT)version.o -X -o $@ -e startup --as-needed $(OUT)ccode32flat.o $(LIBGCC)
 
 ################ Kconfig rules
 
... and then:

$ objdump -sj .note.gnu.build-id ./out/hppa-firmware.img 

./out/hppa-firmware.img:     file format elf32-big

Contents of section .note.gnu.build-id:
 f0000000 00000004 00000014 00000003 474e5500  ............GNU.
 f0000010 daabe2dc 4e95a4c2 bad0cc57 e7f63152  ....N......W..1R
 f0000020 46274585                             F'E.         

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


