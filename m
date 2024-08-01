Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8B4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQ7u-0005Qt-Ii; Thu, 01 Aug 2024 03:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sZQ7s-0005QC-C0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:21:28 -0400
Received: from out-182.mta0.migadu.com ([91.218.175.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1sZQ7q-0005jl-Dv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:21:28 -0400
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1722496872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeS4B7JM62gRwn0FdQMtCOMSoDOgmNkYg2CkomEetiY=;
 b=OQFj8cRKVDpD+zP9mmXf+IMFHP9DQXcuAPBajma72xclyZj6clI3hLERtOdURZ27plnpa/
 7jzYofX3rRXSEw6652cimcmIWC2Riu/JkGVAtU7csIqLhUfg6CQcpJYqCgP8I85IV2RYyX
 5pXxbXx/s2Q1Fa27mulx3GPY0d7LyEc=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: QEMU unexpectedly closed the monitor
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <ZqoTG0eYwNLAJu3D@redhat.com>
Date: Thu, 1 Aug 2024 16:20:54 +0900
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2AEE094A-639C-4FC6-A1C6-F4639E075672@linux.dev>
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
 <87le1jc8qi.fsf@draig.linaro.org>
 <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev>
 <87h6c5dh31.fsf@draig.linaro.org>
 <CAFEAcA_y1y+5aqDXDUmAzRJo2Kf9o+JwbH-6MB62UEZD=LQZ-w@mail.gmail.com>
 <ZqoTG0eYwNLAJu3D@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.182;
 envelope-from=itaru.kitayama@linux.dev; helo=out-182.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On Jul 31, 2024, at 19:34, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Jul 31, 2024 at 11:29:01AM +0100, Peter Maydell wrote:
>> On Wed, 31 Jul 2024 at 10:52, Alex Benn=C3=A9e =
<alex.bennee@linaro.org> wrote:
>>> You then need to manually strip out all the various chardevs for =
libvirt
>>> control sockets and you can an equivalent command line you can run =
from
>>> the console. One thing that did jump out as a bit weird to me was:
>>>=20
>>> -rtc base=3Dutc -no-shutdown -no-acpi -boot strict=3Don \
>>> -kernel /home/realm/Image-v6.10 \
>>> -initrd /home/realm/rootfs.cpio \
>>> -append 'earlycon console=3DttyAMA0 rdinit=3D/sbin/init rw =
root=3D/dev/vda acpi=3Don'
>>=20
>> Also worth checking here I guess is whether virt-install
>> is running QEMU as a user which doesn't have access to
>> the /home/realm/Image-v6.10 etc files -- are they world
>> readable?
>=20
> Most likely it is the directory permissions which are the problem =
since
> $HOME is typically set to deny access from other users, which would =
include
> the user QEMU runs as.

Hi Daniel, Peter,

That was it, I was (unintentinally) adding additional ACL control on my =
home directory ie /home/realm; I removed it and doing chmod o+rw =
/home/realm helped it. Kernel Image and initrd files were world =
readable.
Also, placing them under /var/lib/libvirt/boot worked as well.

Alex,
Thanks for showing me the steps to reconstruct the set of QEMU options =
used by libvirt.

Thanks,
Itaru.

>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



