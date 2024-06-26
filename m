Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA01DC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVSr-0000rh-9f; Wed, 26 Jun 2024 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sMVSp-0000qq-Fe
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sMVSn-0007iF-GT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719419139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQgmATcWRLST385uitgeRxWgQj0Eo5fFKFIoP1kZlYM=;
 b=VPui9GHrTf2N+Tiv/z7i3ZJ9Ak/xUZPu5CDTgTY/6z5z75it8UfLHLPISryxFaGeJn6TJd
 NZIrfw2HpBcHKWvdJxeSz9iJhenEtlj/U40SZNBt+Y7odA2vvMyGRZNvTikGj+PsHcvdrm
 Fj0u4qNbIlPEWo7IR6rVMfLicJjjHg8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-5qgRO6doNnO_AbGiqcOHkA-1; Wed, 26 Jun 2024 12:25:38 -0400
X-MC-Unique: 5qgRO6doNnO_AbGiqcOHkA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b50b0270d8so104235476d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719419137; x=1720023937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQgmATcWRLST385uitgeRxWgQj0Eo5fFKFIoP1kZlYM=;
 b=L96q/X4vzrIjGVRmqA9NaEvpZctI4ynYb8vwizO8KQ2fme2w9krYTJZyIB83TWmHCt
 m6RkQwHJEwelayqxRfBLTTTVd2OacKhF82epSS8t9wNAhdWa66hJaRWAd9GkKgZ5zBZu
 y4D3CnuzenyFE5+rYgK+XIcb7zS0/W7UQd2ZiJIwpRUk7QmKMTjHIAKBzkuYtFLCT7we
 HsVGqtF0WbfSVIhvqGXaIRJ9fik7WJLHw/5mJS9wwGDAVEv+Zq3nDhGWCj6ZziJNtLx+
 KIFWruYZ7GoxxKnUiZ/ca75hDFpuZwRlsI69VwVt24pfQgg7B43AGYCwrvkO3LaIW/2a
 e2wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKKtzm3gRUWeVmUa/b9yRXnCQR6NZ/syJtlv37oX2E9jlRC7q+BZGM+sQhhncNI9KMa4Cn4holaXV4/9/3xr0bWrrONjg=
X-Gm-Message-State: AOJu0YxXG7KEzt4rozSXACfmqw8B6j7eJoGzvfLLUR1Og64XiiwTN/pp
 CVmibFKpQBmFN07sXxRUdz0CFJBOlxicWMnNsMBYvrau/T7eLbUOiq6s9ifEQyyk18KZzgrsUFE
 yWpxqDJYLPiAK4npQQ0lTSUt1BVlaUVMYEPk2cekfZBMYNy/lDctFJXpHryrbpmT9PbkJ/SePuC
 7/Z5QW/UVLp7iJ5l+Qp5FCQDVLTS593erSf9c=
X-Received: by 2002:ad4:5d4e:0:b0:6b5:40c:dfcc with SMTP id
 6a1803df08f44-6b53bfdc130mr149032356d6.51.1719419137353; 
 Wed, 26 Jun 2024 09:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3a8U9KD4Nmw6PfFYgbotPlu9YcWhYHcti9fLQPBI7qYWc94d4wTWJ//erCsFDzMfQ5R+gWQsl/1ntKmPn4mc=
X-Received: by 2002:ad4:5d4e:0:b0:6b5:40c:dfcc with SMTP id
 6a1803df08f44-6b53bfdc130mr149032096d6.51.1719419137082; Wed, 26 Jun 2024
 09:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com> <ZnmZ-m38IAHg0UdX@redhat.com>
 <CAMRbyyv9utXsfXKiPz4fGw+S4JLgsZE2UDxUOxwG1fxZwGMHNQ@mail.gmail.com>
 <ZnvUcQiXzQW-Mq1s@redhat.com>
In-Reply-To: <ZnvUcQiXzQW-Mq1s@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 26 Jun 2024 19:25:19 +0300
Message-ID: <CAMRbyys5RLpD+45HXFDoV7KKf8TKwn9i8GDqLC7LtOasUptAuQ@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e2df17061bcd76cb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

--000000000000e2df17061bcd76cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:42=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:

> Am 24.06.2024 um 23:12 hat Nir Soffer geschrieben:
> > On Mon, Jun 24, 2024 at 7:08=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> w=
rote:
> >
> > > Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > > > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > > > Tested using:
> > > >
> > > > Hi Nir,
> > > > This looks like a good candidate for the qemu-iotests test suite.
> Adding
> > > > it to the automated tests will protect against future regressions.
> > > >
> > > > Please add the script and the expected output to
> > > > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > > > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> > > >
> > > > See the existing test cases in tests/qemu-iotests/ and
> > > > tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> > > > others are Python. I think shell makes sense for this test case. Yo=
u
> > > > can copy the test framework boilerplate from an existing test case.
> > >
> > > 'du' can't be used like this in qemu-iotests because it makes
> > > assumptions that depend on the filesystem. A test case replicating wh=
at
> > > Nir did manually would likely fail on XFS with its preallocation.
> >
> > This is why I did not try to add a new qemu-iotest yet.
> >
> > > Maybe we could operate on a file exposed by the FUSE export that is
> > > backed by qcow2, and then you can use 'qemu-img map' on that qcow2
> image
> > > to verify the allocation status. Somewhat complicated, but I think it
> > > could work.
> >
> > Do we have examples of using the FUSE export? It sounds complicated but
> > being able to test on any file system is awesome. The complexity can be
> > hidden behind simple test helpers.
>
> We seem to have a few tests that use it, and then the fuse protocol
> implementation, too. 308 and file-io-error look relevant.
>
> > Another option is to use a specific file system created for the tests,
> > for example on a loop device. We used userstorage[1] in ovirt to test
> > on specific file systems with known sector size.
>
> Creating loop devices requires root privileges. If I understand
> correctly, userstorage solved that by having a setup phase as root
> before running the tests as a normal user? We don't really have that in
> qemu-iotests.
>
> Some tests require passwordless sudo and are skipped otherwise, but this
> means that in practice they are almost always skipped.
>

Yes, this is the assumption the storage is being created before running the
tests,
for example when setting up a development or CI environment, and the tests
can run with unprivileged user.

> But more important, are you ok with the change?
> >
> > I'm not sure about not creating sparse images by default - this is not
> > consistent with qemu-img convert and qemu-nbd, which do sparsify by
> > default. The old behavior seems better.
>
> Well, your patches make it do what we always claimed it would do, so
> that consistency is certainly a good thing. Unmapping on write_zeroes
> and ignoring truncate is a weird combination anyway that doesn't really
> make any sense to me, so I don't think it's worth preserving. The other
> way around could have been more defensible, but that's not how our bug
> works.
>
> Now, if ignoring all discard requests is a good default these days is a
> separate question and I'm not sure really. Maybe discard=3Dunmap should
> be the default (and apply to both discard are write_zeroes, of course).
>

OK, lets limit the scope to fix the code to match the current docs. We can
tweak
the defaults later.

--000000000000e2df17061bcd76cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 26, 2024 at 11:42=E2=80=AFAM =
Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt;=
 wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Am 24.06.2024 um 23:12 hat Nir Soffer geschrieben:<br>
&gt; On Mon, Jun 24, 2024 at 7:08=E2=80=AFPM Kevin Wolf &lt;<a href=3D"mail=
to:kwolf@redhat.com" target=3D"_blank">kwolf@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:<br>
&gt; &gt; &gt; On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:<=
br>
&gt; &gt; &gt; &gt; Tested using:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi Nir,<br>
&gt; &gt; &gt; This looks like a good candidate for the qemu-iotests test s=
uite. Adding<br>
&gt; &gt; &gt; it to the automated tests will protect against future regres=
sions.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please add the script and the expected output to<br>
&gt; &gt; &gt; tests/qemu-iotests/test/write-zeroes-unmap and run it using<=
br>
&gt; &gt; &gt; `(cd build &amp;&amp; tests/qemu-iotests/check write-zeroes-=
unmap)`.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; See the existing test cases in tests/qemu-iotests/ and<br>
&gt; &gt; &gt; tests/qemu-iotests/tests/ for examples. Some are shell scrip=
ts and<br>
&gt; &gt; &gt; others are Python. I think shell makes sense for this test c=
ase. You<br>
&gt; &gt; &gt; can copy the test framework boilerplate from an existing tes=
t case.<br>
&gt; &gt;<br>
&gt; &gt; &#39;du&#39; can&#39;t be used like this in qemu-iotests because =
it makes<br>
&gt; &gt; assumptions that depend on the filesystem. A test case replicatin=
g what<br>
&gt; &gt; Nir did manually would likely fail on XFS with its preallocation.=
<br>
&gt; <br>
&gt; This is why I did not try to add a new qemu-iotest yet.<br>
&gt; <br>
&gt; &gt; Maybe we could operate on a file exposed by the FUSE export that =
is<br>
&gt; &gt; backed by qcow2, and then you can use &#39;qemu-img map&#39; on t=
hat qcow2 image<br>
&gt; &gt; to verify the allocation status. Somewhat complicated, but I thin=
k it<br>
&gt; &gt; could work.<br>
&gt; <br>
&gt; Do we have examples of using the FUSE export? It sounds complicated bu=
t<br>
&gt; being able to test on any file system is awesome. The complexity can b=
e<br>
&gt; hidden behind simple test helpers.<br>
<br>
We seem to have a few tests that use it, and then the fuse protocol<br>
implementation, too. 308 and file-io-error look relevant.<br>
<br>
&gt; Another option is to use a specific file system created for the tests,=
<br>
&gt; for example on a loop device. We used userstorage[1] in ovirt to test<=
br>
&gt; on specific file systems with known sector size.<br>
<br>
Creating loop devices requires root privileges. If I understand<br>
correctly, userstorage solved that by having a setup phase as root<br>
before running the tests as a normal user? We don&#39;t really have that in=
<br>
qemu-iotests.<br>
<br>
Some tests require passwordless sudo and are skipped otherwise, but this<br=
>
means that in practice they are almost always skipped.<br></blockquote><div=
><br></div><div>Yes, this is the assumption the storage is being created be=
fore running the tests,</div><div>for example when setting up a development=
 or CI environment, and the tests</div><div>can run with unprivileged user.=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; But more important, are you ok with the change?<br>
&gt; <br>
&gt; I&#39;m not sure about not creating sparse images by default - this is=
 not<br>
&gt; consistent with qemu-img convert and qemu-nbd, which do sparsify by<br=
>
&gt; default. The old behavior seems better.<br>
<br>
Well, your patches make it do what we always claimed it would do, so<br>
that consistency is certainly a good thing. Unmapping on write_zeroes<br>
and ignoring truncate is a weird combination anyway that doesn&#39;t really=
<br>
make any sense to me, so I don&#39;t think it&#39;s worth preserving. The o=
ther<br>
way around could have been more defensible, but that&#39;s not how our bug<=
br>
works.<br>
<br>
Now, if ignoring all discard requests is a good default these days is a<br>
separate question and I&#39;m not sure really. Maybe discard=3Dunmap should=
<br>
be the default (and apply to both discard are write_zeroes, of course).<br>=
</blockquote><div><br></div><div>OK, lets limit the scope to fix the code t=
o match the current docs. We can tweak</div><div>the defaults later.=C2=A0<=
/div></div></div>

--000000000000e2df17061bcd76cb--


