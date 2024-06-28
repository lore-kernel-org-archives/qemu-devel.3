Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAFFC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 19:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNHdK-0004IP-LU; Fri, 28 Jun 2024 15:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNHdJ-0004ID-6u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 15:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sNHdF-0003WR-Nb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 15:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719604299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhOXtyBapcKoykj+c/GOMs1pemye28o0tRpJwjRm7nA=;
 b=P7gMSxwb0YzK2x8J79DsUYXjnBfOYgWV7GBngPRgzNPhXbPgUKITnUzmXRFxp37ZGFEppl
 CXArsZ2iWdquS6z5tx1a+JUeTPl438qeopCJDR5yE1t/YADF865N+iaehOsa2HaZX9hEmt
 vltlrBh4BaXA9IJB8SfhQbZESELG900=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-XIOdXFJCOW-cyiX378i9YA-1; Fri, 28 Jun 2024 15:51:36 -0400
X-MC-Unique: XIOdXFJCOW-cyiX378i9YA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b51db044edso14024926d6.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 12:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604296; x=1720209096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhOXtyBapcKoykj+c/GOMs1pemye28o0tRpJwjRm7nA=;
 b=bPkFXYEnSwIu/Sz09bzHEwIMdGXMOSofYdCz0ssP0rS+QULvSkDlKM5I5rfm9vPAFO
 +Wm4FsIt9zef/m5SdPfjQSihufiUQjCK9yHHnYvoHdCDom/gVgVpq2+ritTRLv+v6JfO
 GbJiQ4xRI6useOdeR00XhuQqa+9E9HmO8fExWpkhLAH8Be6Cxu5/jRI+INX8l0byMqxS
 5P1T1hPKCWCYXlj5nyRenoGi4GgIdTPFEmQ0GNKMnAwQWRBC9Ql53OicZ0lkyITvefDm
 IvKDHTbXgxFCpbegvhWoCfbSHN3dW+IQ5EMGLcEgqMlmCgNuUJXjrtV4KoWsBXqCNPJO
 n+vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9LxZPZgdE+Glp8tzI8bx1J4bvjAas32dalwq23Lu8PSR5D67GRwduapyIXCs0OX0fMK41fagTvb48IO0yfCVgcrW/m24=
X-Gm-Message-State: AOJu0Ywrt8EWPDJuF4nFytCgvdL0lbpKzrVvs62WwF65BzlWcRmi+Ovj
 fDMDK7CxRGI3nhKEvuSJglGUmuso8c8cvvO7j6nOlezER/qM1s3cBa01WrnD1Db9JQiEvkzXs9Y
 Z8gd+SinkZIC6hnn+p+hLr4UP8IOIyyuQPv0JqLwqSTs0sPLB6KW3boRLJgj5vx5/f2oF2ArDz7
 t+7YxQajJHjx9IqJwoboy3MWjeyIA=
X-Received: by 2002:ad4:404a:0:b0:6b5:4a87:4034 with SMTP id
 6a1803df08f44-6b54a874160mr161106966d6.49.1719604295788; 
 Fri, 28 Jun 2024 12:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEafRD5nLPP5WfBwAIHHScfsHhE+vT0MGzOIvwKkIqFWApMMHiqme6g85atYpPVkiv+PXLkfD8/K3uePndRb2c=
X-Received: by 2002:ad4:404a:0:b0:6b5:4a87:4034 with SMTP id
 6a1803df08f44-6b54a874160mr161106876d6.49.1719604295494; Fri, 28 Jun 2024
 12:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com> <ZnmZ-m38IAHg0UdX@redhat.com>
 <Znvcq1H7sGtwxIAd@redhat.com>
 <CAMRbyyugz47v7k=tw7=ed45m8m_m70pL56PHpc+Qj-WHRUTC6g@mail.gmail.com>
 <Zn1QMzWnaZYYYEml@redhat.com>
In-Reply-To: <Zn1QMzWnaZYYYEml@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 28 Jun 2024 22:51:19 +0300
Message-ID: <CAMRbyyu6ojApLOvH1LrLUdaiETGCbxoKadAtw=2oAWy4=O0nFw@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000030098f061bf89303"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000030098f061bf89303
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:42=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 26.06.2024 um 18:27 hat Nir Soffer geschrieben:
> > On Wed, Jun 26, 2024 at 12:17=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
> >
> > wrote:
> >
> > > On Mon, Jun 24, 2024 at 06:08:26PM +0200, Kevin Wolf wrote:
> > > > Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > > > > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > > > > Tested using:
> > > > >
> > > > > Hi Nir,
> > > > > This looks like a good candidate for the qemu-iotests test suite.
> > > Adding
> > > > > it to the automated tests will protect against future regressions=
.
> > > > >
> > > > > Please add the script and the expected output to
> > > > > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > > > > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> > > > >
> > > > > See the existing test cases in tests/qemu-iotests/ and
> > > > > tests/qemu-iotests/tests/ for examples. Some are shell scripts an=
d
> > > > > others are Python. I think shell makes sense for this test case.
> You
> > > > > can copy the test framework boilerplate from an existing test cas=
e.
> > > >
> > > > 'du' can't be used like this in qemu-iotests because it makes
> > > > assumptions that depend on the filesystem. A test case replicating
> what
> > > > Nir did manually would likely fail on XFS with its preallocation.
> > > >
> > > > Maybe we could operate on a file exposed by the FUSE export that is
> > > > backed by qcow2, and then you can use 'qemu-img map' on that qcow2
> image
> > > > to verify the allocation status. Somewhat complicated, but I think =
it
> > > > could work.
> > >
> > > A simpler option would be to use 'du' but with a fuzzy range test,
> > > rather than an exact equality test.
> > >
> > > For the tests which write 1 MB, check the 'du' usage is "at least 1MB=
",
> > > for the tests which expect to unmap blocks, check that the 'du' usage
> > > is "less than 256kb". This should be within bounds of xfs speculative
> > > allocation.
> >
> > This should work, I'll start with this approach.
>
> If we're okay with accepting tests that depend on filesystem behaviour,
> then 'qemu-img map -f raw --output=3Djson' should be the less risky
> approach than checking 'du'.
>

Unfortunately it does not work since qemu-img map and qemu-nbd reports the
allocated
area as zero area with no data.

I tried this:

$ cat test-print-allocation.sh
#!/bin/sh

qemu=3D${1:?Usage: $0 qemu-executable}
img=3D/tmp/qemu-test-unmap.img

echo
echo "discard=3Dunmap - write zeroes"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -z 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null

echo "du:"
du -sh $img
echo "qemu-img map:"
qemu-img map -f raw --output json $img
echo "nbdinfo --map:"
nbdinfo --map -- [ qemu-nbd -r -f raw $img ]

echo
echo "discard=3Dunmap - write zeroes unmap"
fallocate -l 1m $img
echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' | $qemu -monitor stdio \
    -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap >/dev/null

echo "du:"
du -sh $img
echo "qemu-img map:"
qemu-img map -f raw --output json $img
echo "nbdinfo --map:"
nbdinfo --map -- [ qemu-nbd -r -f raw $img ]

rm $img


$ ./test-print-allocation.sh ./qemu-system-x86_64

discard=3Dunmap - write zeroes
du:
1.0M /tmp/qemu-test-unmap.img
qemu-img map:
[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero":
true, "data": false, "offset": 0}]
nbdinfo --map:
         0     1048576    3  hole,zero

discard=3Dunmap - write zeroes unmap
du:
0 /tmp/qemu-test-unmap.img
qemu-img map:
[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero":
true, "data": false, "offset": 0}]
nbdinfo --map:
         0     1048576    3  hole,zero

--00000000000030098f061bf89303
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 27, 2024 at 2:42=E2=80=AFPM K=
evin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Am 26.06.2024 um 18:27 hat Nir Soffer geschrieben:<br>
&gt; On Wed, Jun 26, 2024 at 12:17=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com=
</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Jun 24, 2024 at 06:08:26PM +0200, Kevin Wolf wrote:<br>
&gt; &gt; &gt; Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:<br>
&gt; &gt; &gt; &gt; On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wr=
ote:<br>
&gt; &gt; &gt; &gt; &gt; Tested using:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hi Nir,<br>
&gt; &gt; &gt; &gt; This looks like a good candidate for the qemu-iotests t=
est suite.<br>
&gt; &gt; Adding<br>
&gt; &gt; &gt; &gt; it to the automated tests will protect against future r=
egressions.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Please add the script and the expected output to<br>
&gt; &gt; &gt; &gt; tests/qemu-iotests/test/write-zeroes-unmap and run it u=
sing<br>
&gt; &gt; &gt; &gt; `(cd build &amp;&amp; tests/qemu-iotests/check write-ze=
roes-unmap)`.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; See the existing test cases in tests/qemu-iotests/ and<=
br>
&gt; &gt; &gt; &gt; tests/qemu-iotests/tests/ for examples. Some are shell =
scripts and<br>
&gt; &gt; &gt; &gt; others are Python. I think shell makes sense for this t=
est case. You<br>
&gt; &gt; &gt; &gt; can copy the test framework boilerplate from an existin=
g test case.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &#39;du&#39; can&#39;t be used like this in qemu-iotests bec=
ause it makes<br>
&gt; &gt; &gt; assumptions that depend on the filesystem. A test case repli=
cating what<br>
&gt; &gt; &gt; Nir did manually would likely fail on XFS with its prealloca=
tion.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Maybe we could operate on a file exposed by the FUSE export =
that is<br>
&gt; &gt; &gt; backed by qcow2, and then you can use &#39;qemu-img map&#39;=
 on that qcow2 image<br>
&gt; &gt; &gt; to verify the allocation status. Somewhat complicated, but I=
 think it<br>
&gt; &gt; &gt; could work.<br>
&gt; &gt;<br>
&gt; &gt; A simpler option would be to use &#39;du&#39; but with a fuzzy ra=
nge test,<br>
&gt; &gt; rather than an exact equality test.<br>
&gt; &gt;<br>
&gt; &gt; For the tests which write 1 MB, check the &#39;du&#39; usage is &=
quot;at least 1MB&quot;,<br>
&gt; &gt; for the tests which expect to unmap blocks, check that the &#39;d=
u&#39; usage<br>
&gt; &gt; is &quot;less than 256kb&quot;. This should be within bounds of x=
fs speculative<br>
&gt; &gt; allocation.<br>
&gt; <br>
&gt; This should work, I&#39;ll start with this approach.<br>
<br>
If we&#39;re okay with accepting tests that depend on filesystem behaviour,=
<br>
then &#39;qemu-img map -f raw --output=3Djson&#39; should be the less risky=
<br>
approach than checking &#39;du&#39;.<br></blockquote><div><br></div><div>Un=
fortunately it does not work since qemu-img map and qemu-nbd reports the al=
located</div><div>area as zero area with no data.=C2=A0</div><div><br></div=
><div>I tried this:</div><div><br></div><div>$ cat test-print-allocation.sh=
 <br>#!/bin/sh<br><br>qemu=3D${1:?Usage: $0 qemu-executable}<br>img=3D/tmp/=
qemu-test-unmap.img<br><br>echo<br>echo &quot;discard=3Dunmap - write zeroe=
s&quot;<br>fallocate -l 1m $img<br>echo -e &#39;qemu-io none0 &quot;write -=
z 0 1m&quot;\nquit&#39; | $qemu -monitor stdio \<br>=C2=A0 =C2=A0 -drive if=
=3Dnone,file=3D$img,format=3Draw,discard=3Dunmap &gt;/dev/null<br><br>echo =
&quot;du:&quot;<br>du -sh $img<br>echo &quot;qemu-img map:&quot;<br>qemu-im=
g map -f raw --output json $img<br>echo &quot;nbdinfo --map:&quot;<br>nbdin=
fo --map -- [ qemu-nbd -r -f raw $img ]<br><br>echo<br>echo &quot;discard=
=3Dunmap - write zeroes unmap&quot;<br>fallocate -l 1m $img<br>echo -e &#39=
;qemu-io none0 &quot;write -zu 0 1m&quot;\nquit&#39; | $qemu -monitor stdio=
 \<br>=C2=A0 =C2=A0 -drive if=3Dnone,file=3D$img,format=3Draw,discard=3Dunm=
ap &gt;/dev/null<br><br>echo &quot;du:&quot;<br>du -sh $img<br>echo &quot;q=
emu-img map:&quot;<br>qemu-img map -f raw --output json $img<br>echo &quot;=
nbdinfo --map:&quot;<br>nbdinfo --map -- [ qemu-nbd -r -f raw $img ]<br><br=
>rm $img<br></div></div><div class=3D"gmail_quote"><br></div><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">$ ./test-print-allocation=
.sh ./qemu-system-x86_64<br><br>discard=3Dunmap - write zeroes<br>du:<br>1.=
0M	/tmp/qemu-test-unmap.img<br>qemu-img map:<br>[{ &quot;start&quot;: 0, &q=
uot;length&quot;: 1048576, &quot;depth&quot;: 0, &quot;present&quot;: true,=
 &quot;zero&quot;: true, &quot;data&quot;: false, &quot;offset&quot;: 0}]<b=
r>nbdinfo --map:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 10485=
76 =C2=A0 =C2=A03 =C2=A0hole,zero<br><br>discard=3Dunmap - write zeroes unm=
ap<br>du:<br>0	/tmp/qemu-test-unmap.img<br>qemu-img map:<br>[{ &quot;start&=
quot;: 0, &quot;length&quot;: 1048576, &quot;depth&quot;: 0, &quot;present&=
quot;: true, &quot;zero&quot;: true, &quot;data&quot;: false, &quot;offset&=
quot;: 0}]<br>nbdinfo --map:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =
=C2=A0 1048576 =C2=A0 =C2=A03 =C2=A0hole,zero<br></div></div>

--00000000000030098f061bf89303--


