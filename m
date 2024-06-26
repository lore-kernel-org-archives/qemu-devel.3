Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDAC3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVUh-0002Mk-PB; Wed, 26 Jun 2024 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sMVUe-0002Lp-Rd
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sMVUd-0007yz-0b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719419254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dkc32KD6jHiG2WGVGYTRiTN9Bb2ES53OK7rvF1bVN10=;
 b=fi8qiX9xjuCKiCu1gIjKe763M6UVS8UkICHcAo0srdM8u9kMw+2olEEzRpGdlbGl2eaJC3
 rs6raAt3qaNcakApqBnRROt0ZQ1lNJg/CWe/Oq75EkiaEaLiu5fHCnENI/1ZEpmAjjX/e3
 MJQ1Cy0BRKS6uL/PUPRHo6H24kVe3iw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-VFUs1X04OF6JzRk0PSNK-Q-1; Wed, 26 Jun 2024 12:27:32 -0400
X-MC-Unique: VFUs1X04OF6JzRk0PSNK-Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b50f078c46so107811576d6.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719419252; x=1720024052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dkc32KD6jHiG2WGVGYTRiTN9Bb2ES53OK7rvF1bVN10=;
 b=P9bzGd0h2Cdr0dDoMa1SxgZOnRedcyKuoNT9O8j0FpnJd3qpYSUy7CSgY258mQ4bo1
 zMH0AxO0mNisxNSDGwKwoo70I3vUkmA1xUXTlUtQkjSj+EGzgmLVaV1ivtAuuQFDvFk1
 s37MniI8W4UpiC2LH1i2wGQgN910ObomY1/J9YGEl5h4CH7AdRKaLaEWBCxeDWnwvU44
 VkO5h9ldXKxFWXH5l0irlbJ00wXmgIvTPpnkNmbbeUZJzYlcq7TftEXHYuMvXLpqw4c8
 R2R/rytbca/noatnEJVtE/XweKGpWVKxFzK7YnQtuMts1gBwhURlV/RM7j2hpjD5yZG1
 VnAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+5pi/5hqIwEuORwb6GDJM6onZB0cwXccF2/ToCWPlcgbIwzZeZyIYajjMqhavcUTS1UiISPo+2K4vz7NrU9Giw2d9rjs=
X-Gm-Message-State: AOJu0Yw+w3J+GRvhNAr70IcUC0lySfpWqXsav/nViXndLBYVYTQ0+lKJ
 yabIHR+gbT+WBBLU1iHPzC+5JV9V8W8Ri/n6uJ5BFk16T1X5YcpPqsVNQgcrRmTLhN73jE6UN3N
 darSPlVwqazRD9coIi7eUwaq0XkuuHKvjLhngL+RHkViw10OHSmNp9+hoe2Igao2SXj2LlGq3BV
 Z/IrLMAlvErVoOIoF4WWIgQvvtI2Q=
X-Received: by 2002:ad4:5fcf:0:b0:6b5:46ad:b92c with SMTP id
 6a1803df08f44-6b546adbb20mr135309036d6.1.1719419252235; 
 Wed, 26 Jun 2024 09:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTQUvmd1TnXKoURK2aUWdnY0dtqN1gOBMq4c4gRoP4QmMjD9+jgJN4a03whPtSTgKAeI6jgoIX1Wub/FzryJU=
X-Received: by 2002:ad4:5fcf:0:b0:6b5:46ad:b92c with SMTP id
 6a1803df08f44-6b546adbb20mr135308816d6.1.1719419251941; Wed, 26 Jun 2024
 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com> <ZnmZ-m38IAHg0UdX@redhat.com>
 <Znvcq1H7sGtwxIAd@redhat.com>
In-Reply-To: <Znvcq1H7sGtwxIAd@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 26 Jun 2024 19:27:15 +0300
Message-ID: <CAMRbyyugz47v7k=tw7=ed45m8m_m70pL56PHpc+Qj-WHRUTC6g@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bb7ba0061bcd7d55"
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

--000000000000bb7ba0061bcd7d55
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:17=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Jun 24, 2024 at 06:08:26PM +0200, Kevin Wolf wrote:
> > Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > > Tested using:
> > >
> > > Hi Nir,
> > > This looks like a good candidate for the qemu-iotests test suite.
> Adding
> > > it to the automated tests will protect against future regressions.
> > >
> > > Please add the script and the expected output to
> > > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> > >
> > > See the existing test cases in tests/qemu-iotests/ and
> > > tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> > > others are Python. I think shell makes sense for this test case. You
> > > can copy the test framework boilerplate from an existing test case.
> >
> > 'du' can't be used like this in qemu-iotests because it makes
> > assumptions that depend on the filesystem. A test case replicating what
> > Nir did manually would likely fail on XFS with its preallocation.
> >
> > Maybe we could operate on a file exposed by the FUSE export that is
> > backed by qcow2, and then you can use 'qemu-img map' on that qcow2 imag=
e
> > to verify the allocation status. Somewhat complicated, but I think it
> > could work.
>
> A simpler option would be to use 'du' but with a fuzzy range test,
> rather than an exact equality test.
>
> For the tests which write 1 MB, check the 'du' usage is "at least 1MB",
> for the tests which expect to unmap blocks, check that the 'du' usage
> is "less than 256kb". This should be within bounds of xfs speculative
> allocation.
>

This should work, I'll start with this approach.

--000000000000bb7ba0061bcd7d55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 26, 2024 at 12:17=E2=80=AFPM =
Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange=
@redhat.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Mon, Jun 24, 2024 at 06:08:26PM +0=
200, Kevin Wolf wrote:<br>
&gt; Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:<br>
&gt; &gt; On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:<br>
&gt; &gt; &gt; Tested using:<br>
&gt; &gt; <br>
&gt; &gt; Hi Nir,<br>
&gt; &gt; This looks like a good candidate for the qemu-iotests test suite.=
 Adding<br>
&gt; &gt; it to the automated tests will protect against future regressions=
.<br>
&gt; &gt; <br>
&gt; &gt; Please add the script and the expected output to<br>
&gt; &gt; tests/qemu-iotests/test/write-zeroes-unmap and run it using<br>
&gt; &gt; `(cd build &amp;&amp; tests/qemu-iotests/check write-zeroes-unmap=
)`.<br>
&gt; &gt; <br>
&gt; &gt; See the existing test cases in tests/qemu-iotests/ and<br>
&gt; &gt; tests/qemu-iotests/tests/ for examples. Some are shell scripts an=
d<br>
&gt; &gt; others are Python. I think shell makes sense for this test case. =
You<br>
&gt; &gt; can copy the test framework boilerplate from an existing test cas=
e.<br>
&gt; <br>
&gt; &#39;du&#39; can&#39;t be used like this in qemu-iotests because it ma=
kes<br>
&gt; assumptions that depend on the filesystem. A test case replicating wha=
t<br>
&gt; Nir did manually would likely fail on XFS with its preallocation.<br>
&gt; <br>
&gt; Maybe we could operate on a file exposed by the FUSE export that is<br=
>
&gt; backed by qcow2, and then you can use &#39;qemu-img map&#39; on that q=
cow2 image<br>
&gt; to verify the allocation status. Somewhat complicated, but I think it<=
br>
&gt; could work.<br>
<br>
A simpler option would be to use &#39;du&#39; but with a fuzzy range test,<=
br>
rather than an exact equality test.<br>
<br>
For the tests which write 1 MB, check the &#39;du&#39; usage is &quot;at le=
ast 1MB&quot;,<br>
for the tests which expect to unmap blocks, check that the &#39;du&#39; usa=
ge<br>
is &quot;less than 256kb&quot;. This should be within bounds of xfs specula=
tive<br>
allocation.<br></blockquote><div><br></div><div>This should work, I&#39;ll =
start with this approach.=C2=A0<br></div></div></div>

--000000000000bb7ba0061bcd7d55--


