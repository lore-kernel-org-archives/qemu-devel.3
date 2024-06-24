Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC75C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqzU-0007fW-JH; Mon, 24 Jun 2024 17:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sLqzS-0007el-FN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sLqzQ-0004ni-BK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719263558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ibbd3hVdbE/1r0cwDndo0YXsXE77iv1gB14iaD7leE4=;
 b=MThIWlHD4q2VsM51tPCachMf9QxIcHvvgLEp4XtNjK0uRKg0708XinDF/yU7yKCQMv9zPi
 bFJSAzGN73PwfkJ6IHmVVyz56UnhfSkPOuL8JRWZkZNESZ0891esn4ziqZyAzypnE+VAq+
 861phE8dVvElaFWQxNiGUG/Gu2mcbzE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-sxaru6sZNCmHONihdM3tkw-1; Mon, 24 Jun 2024 17:12:36 -0400
X-MC-Unique: sxaru6sZNCmHONihdM3tkw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-80f4a34f07dso2789652241.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 14:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263555; x=1719868355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ibbd3hVdbE/1r0cwDndo0YXsXE77iv1gB14iaD7leE4=;
 b=KMKqXKJuMNTy7jAe/RjKrrnA3Zmlm0+jqb4ty8vACvBobLDmPxQfgXLozdapzJLYnX
 NOUikRccCIPybJ2o6S3ebJczbMWUJTgiqcNhuJn5OQ32RMQAieJGc809JVxr6uEYdBtK
 NHYpsgI9sz24IWOJgcdf9H9kcuQtQK7EJQoyZAF8WyYLk7sM8yHhzBIXm4A/j9J4hsDs
 BjbnkEHD7FNMfKK6fRp6ak7GJZZZPXK3lTm3e3Tc5I0NJ3XkI/12rwcS31uKws7RedK2
 xlP+MjOjBjTt0hOXz1eZSGX0NH7V8OXiu5FhL7RezR4ZTn/axHXXDqp65xAbBS/DUBJU
 Vsaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQnwqs8Rh5159e2YX2kzhgnD+ARvL53yYQ9WnQMmM9NQzFrjNi5+xu5eAPuJTSDLlG97psknilDXZNmRTzBImyxKARjfE=
X-Gm-Message-State: AOJu0YywuOVoOU4s4a6rjgQC7iQuDofbfuliFigejyaqixz9vlHiAjfr
 bTf3+aNq1szNFuKQdxbnJq1HtVJS4DHU67HZuQ1mZKot/tdsMrVhgU5ohUrVMk9Agfvd5ehoja4
 +o+z1uKa5puO1VCfQMsZdvFgdDeelFuwThbrXMAwD7GROJzwie93JFjhF6Go6PVPwNIWcVMeETU
 TQdmT0eKyWzSxnS2MEk46+dy/NHS8=
X-Received: by 2002:a05:6122:202a:b0:4ef:5e3f:599a with SMTP id
 71dfb90a1353d-4ef6d8baf8emr4431730e0c.14.1719263555391; 
 Mon, 24 Jun 2024 14:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHudo2yhNLWv97A8snyumY09PxXw/nwj3WFxbT8G+pIL60vo0mDD95JgHRp0M9W0YkjBFgvehdQPD9fDI24Grs=
X-Received: by 2002:a05:6122:202a:b0:4ef:5e3f:599a with SMTP id
 71dfb90a1353d-4ef6d8baf8emr4431718e0c.14.1719263555021; Mon, 24 Jun 2024
 14:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com> <ZnmZ-m38IAHg0UdX@redhat.com>
In-Reply-To: <ZnmZ-m38IAHg0UdX@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 25 Jun 2024 00:12:18 +0300
Message-ID: <CAMRbyyv9utXsfXKiPz4fGw+S4JLgsZE2UDxUOxwG1fxZwGMHNQ@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000079064b061ba93d33"
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

--00000000000079064b061ba93d33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:08=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > Tested using:
> >
> > Hi Nir,
> > This looks like a good candidate for the qemu-iotests test suite. Addin=
g
> > it to the automated tests will protect against future regressions.
> >
> > Please add the script and the expected output to
> > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> >
> > See the existing test cases in tests/qemu-iotests/ and
> > tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> > others are Python. I think shell makes sense for this test case. You
> > can copy the test framework boilerplate from an existing test case.
>
> 'du' can't be used like this in qemu-iotests because it makes
> assumptions that depend on the filesystem. A test case replicating what
> Nir did manually would likely fail on XFS with its preallocation.
>

This is why I did not try to add a new qemu-iotest yet.


> Maybe we could operate on a file exposed by the FUSE export that is
> backed by qcow2, and then you can use 'qemu-img map' on that qcow2 image
> to verify the allocation status. Somewhat complicated, but I think it
> could work.
>

Do we have examples of using the FUSE export? It sounds complicated but
being able to test on any file system is awesome. The complexity can be
hidden behind simple test helpers.

Another option is to use a specific file system created for the tests, for
example
on a loop device. We used userstorage[1] in ovirt to test on specific file
systems
with known sector size.

But more important, are you ok with the change?

I'm not sure about not creating sparse images by default - this is not
consistent
with qemu-img convert and qemu-nbd, which do sparsify by default. The old
behavior seems better.

[1] https://github.com/nirs/userstorage

Nir

--00000000000079064b061ba93d33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 24, 2024 at 7:08=E2=80=AFPM K=
evin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:<b=
r>
&gt; On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:<br>
&gt; &gt; Tested using:<br>
&gt; <br>
&gt; Hi Nir,<br>
&gt; This looks like a good candidate for the qemu-iotests test suite. Addi=
ng<br>
&gt; it to the automated tests will protect against future regressions.<br>
&gt; <br>
&gt; Please add the script and the expected output to<br>
&gt; tests/qemu-iotests/test/write-zeroes-unmap and run it using<br>
&gt; `(cd build &amp;&amp; tests/qemu-iotests/check write-zeroes-unmap)`.<b=
r>
&gt; <br>
&gt; See the existing test cases in tests/qemu-iotests/ and<br>
&gt; tests/qemu-iotests/tests/ for examples. Some are shell scripts and<br>
&gt; others are Python. I think shell makes sense for this test case. You<b=
r>
&gt; can copy the test framework boilerplate from an existing test case.<br=
>
<br>
&#39;du&#39; can&#39;t be used like this in qemu-iotests because it makes<b=
r>
assumptions that depend on the filesystem. A test case replicating what<br>
Nir did manually would likely fail on XFS with its preallocation.<br></bloc=
kquote><div><br></div><div>This is why I did not try to add a new qemu-iote=
st yet.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
Maybe we could operate on a file exposed by the FUSE export that is<br>
backed by qcow2, and then you can use &#39;qemu-img map&#39; on that qcow2 =
image<br>
to verify the allocation status. Somewhat complicated, but I think it<br>
could work.<br></blockquote><div><br></div><div>Do we have examples of usin=
g the FUSE export? It sounds complicated but</div><div>being able to test o=
n any file system is awesome. The complexity can be</div><div>hidden behind=
 simple test helpers.</div><div><br></div><div>Another option is to use a s=
pecific file system created for the tests, for example</div><div>on a loop =
device. We used userstorage[1] in ovirt to test on specific file systems</d=
iv><div>with known sector size.</div><div><br></div><div>But more important=
, are you ok with the change?</div><div><br></div><div>I&#39;m not sure abo=
ut not creating sparse images by default - this is not consistent</div><div=
>with qemu-img convert and qemu-nbd, which do sparsify by default. The old<=
/div><div>behavior seems better.</div><div><br></div><div>[1]=C2=A0<a href=
=3D"https://github.com/nirs/userstorage">https://github.com/nirs/userstorag=
e</a></div><div><br></div><div>Nir</div><div>=C2=A0</div></div></div>

--00000000000079064b061ba93d33--


