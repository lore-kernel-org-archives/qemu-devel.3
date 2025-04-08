Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44469C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 11:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26hl-0007lT-IL; Tue, 08 Apr 2025 07:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1u26hO-0007gV-Ig
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:00:59 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1u26hL-0002Re-P7
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 07:00:58 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54b166fa41bso1444909e87.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744110052; x=1744714852; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJwZz7yvCJ5j/oDIn4XWU55Ohk40U6xIzbIdb8jE+LY=;
 b=HnucnGm7jSAd+aCakXvCwHNJEtQXBPom7V/w1QcK1/JAR5AGM18HcHYoCEld/sFxuZ
 yevyynzYtRkpb1a77M4Xfj1YhJ0ZCBYBLs2UuSyCf2g/nM80lY1B95t3rKIR9qZs8/ML
 LVPHyk6aNyjPBjdZa0u3kKOCzCY3WPEjx3SlK6udrC1Kcr7FOPbsadtS9D5N0jWwDM1m
 5fg7Z3ubpvWXYq3aiILHCvpGd2r6cXKKH2+tlbxd17jUbz9S+qkLKFlazv3c2jrCpObW
 bIdKa3xzIZjPzl+7NKkwscUFRi6yAZXpwJPz5HricIYLSix6aIY14z2POYd2SkuRaPsS
 3JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744110052; x=1744714852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJwZz7yvCJ5j/oDIn4XWU55Ohk40U6xIzbIdb8jE+LY=;
 b=BIulEGRmvreC1teb4MxDHZo80p53uohMQxAtgR98vfNFrNo+/pVV1L/eKQbU+kVvjS
 gQDXvRgBuKI4KSzlKnN21RVIeo2tEqFVOZ1MnTbMeMAK5V07628QB+YRmxHAs41S8FUM
 xOJw165Llhfa9PFx0PZLnVNXwLvraN1DP3TFtlecblOrawHAQfvE7ZFdHXYv7dfUUdLh
 0q1b0UVTtqy+wob2J3LotSt3h8QrsHyLXvflPQ2a78HeHlMs07AqX8bTrU0bHp8meCVY
 tbk4y4b2VW0p4Hcp8w1OwA29PfOirkvBTEP9BGiO5Wb83MnlJ78NB5btuDxJXkMVvj7F
 rEsw==
X-Gm-Message-State: AOJu0Yynzc17XY1g65nI6FeXb5NbZtz8aJItg+Ld1satxR85vRvK7d/J
 h+9n5r475IMv/7gGQhhdypJ98DEv0a047LAeuxiRp2LBm3Nn8DbVLW98JJd2GIJNcxC+k/CgjX+
 +8WcOI6hHdrprd6hvz1F9rD3xsG3yl5Sb
X-Gm-Gg: ASbGnct5wuv8vvPG+peHup768N0hm4vw9zHyyetwHTxub4Kr/OO2JF5TYH693hLiUTk
 eWwmHiIrVp5wRBph997JO4un1iic2wHrYLh2nBSZsdhn3IQUtdAlpIeUBRGG35qEp7244M9/vZL
 PLhlyRNNYkPC9FTtazYA80nuC1js6V
X-Google-Smtp-Source: AGHT+IGhozt2MzHvDTkedgjgwXXpQ17wfIZ4WQ7XbmyPwB8imQDPaKnT/20ql7jvuD9iZEXmsKHeL7Ntyi34PRzFQh8=
X-Received: by 2002:a05:651c:2210:b0:30b:b8e6:86d7 with SMTP id
 38308e7fff4ca-30f0bf4e0f8mr43766061fa.22.1744110051950; Tue, 08 Apr 2025
 04:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
 <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
 <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
 <CAFvsdYmJFDuQzk6Byu+f4HcTO1EStin3vEMC+twh8P3T2ve6qA@mail.gmail.com>
 <6s2grkptds54jewlroehfvfpk4aci5ks7lkm4h4tfnvayxzi4l@2tilhng3srix>
In-Reply-To: <6s2grkptds54jewlroehfvfpk4aci5ks7lkm4h4tfnvayxzi4l@2tilhng3srix>
From: prashant patil <pmgpatil@gmail.com>
Date: Tue, 8 Apr 2025 16:30:38 +0530
X-Gm-Features: ATxdqUHprKogNBvFgeA0cD3MYHdCJn33F5KREjpSUZIC_-khebSYhvPOQ9CNHrM
Message-ID: <CAFvsdYkhcMgNJfQwdSZ_23qwoqUwbSF8uhBYDQa6d=CiXbcLmw@mail.gmail.com>
Subject: Re: Query on the dirty bitmap
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000188bc30632424441"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=pmgpatil@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000188bc30632424441
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thank you, Eric, for the thorough information=E2=80=94truly appreciate it.

Just to confirm what I understood, when we are reading a bitmap with
'x-dirty-bitmap' (for powered on vm of course), the 'start' is always a
logical offset no matter whether the record has 'offset' value or not. Is
this correct?

Also, I came across a case wherein we get the entire disk as allocated for
a raw format disk which is present on lvm or lvm-thin storage (the disk has
just a few MB data added, and the vm is in running state). Here is an
example of 1Gb data. Is this expected behaviour?
[{ "start": 0, "length": 1073741824, "depth": 0, "present": true, "zero":
false, "data": true, "compressed": false, "offset": 0}]

Regards,
Prashant

On Mon, Apr 7, 2025 at 8:24=E2=80=AFPM Eric Blake <eblake@redhat.com> wrote=
:

> On Mon, Apr 07, 2025 at 02:46:17PM +0530, prashant patil wrote:
> > Thanks Eric.
>
> [top-posting makes conversations harder to follow, so on this list we
> typically reply inline]
>
> > I have a few questions about the bitmap content shown by 'qemu-img map'=
.
> > From below sample bitmap data:
> > 1. Why only some of the extents have start and offset values? And why a=
re
> > they the same values?
> > 2. What does the start value indicate? Is it logical offset or physical
> > offset of data into qcow2?
>
> Normally (when there is no x-dirty-bitmap in play), 'start' denotes
> the logical offset being reported on (you'd expect a map to list every
> logical offset; so the start of entry N+1 should be the sum of start +
> length of entry N), while 'offset' is where that extent begins in the
> underlying file.  For a raw source, offset and start will be
> identical; for other sources, like qcow2, start is obviously logical,
> while offset is physical.  Entries without 'offset' are places where
> the logical contents are compressed, synthesized, or otherwise have no
> 1:1 correspondence to an offset in the physical file.  'present'
> indicates whether the data is synthesized or not; 'offset' is going to
> be absent if 'present' is false; although it can also be absent even
> when 'present' is true such as in the case of compression.
>
> When it comes to exposing a qcow2 file over NBD, you generally want to
> have:
>
> qemu-nbd using '-f qcow2' =3D> raw view =3D> qemu-img using '-f raw'
>
> to expose only the logical contents over the wire.  It is also
> possible to flip the responsibility:
>
> qemu-nbd using '-f raw' =3D> qcow2 view =3D> qemu-img using '-f qcow2'
>
> to expose the bare-metal qcow2 contents over the wire, but that gets
> less testing, in part because if you make the image writable, it tends
> to cause problems if the client writing to the qcow2 layer needs to
> allocate (since NBD does not have a resize command).  Having the
> server open the file as qcow2 and only serving raw contents means the
> server can resize transparently.  What's more, block status commands
> over NBD only work when the server is aware of the qcow2 nature of the
> file it is serving (if you expose qcow2 bits over the wire, the server
> treats the entire file as allocated, and there is is no dirty bitmap
> context for the client to read over NBD).
>
> Therefore, 'start' and 'offset' are going to be identical if you are
> using qemu-img map to read bitmaps from a server, since bitmaps can
> only be read when the wire has the raw view (not the qcow2 view).
>
> But when you add x-dirty-bitmap into the mix, you are asking qemu to
> DISREGARD the normal rules of backing file information and instead
> report on dirty bitmap information as if it were backing file info.
> This means that anywhere the dirty bitmap response differs from a
> normal backing file response, the output of qemu-img is reporting
> garbage data (for example, the 'present' bit is now bogus, which
> explains why the rows where qemu-img claims 'present' is false omit an
> 'offset').  Only 'start', 'length', and 'data' matter when using
> x-dirty-bitmap, with 'data=3Dfalse' meaning the section was reported
> dirty, and 'data=3Dtrue' meaning the section was reported unchanged.
>
> And if that is confusing, well yeah. Which is why I recommend using
> libnbd's nbdinfo --map, where the output is more obvious.
>
> >
> > root@be-proxmox1:/# qemu-img map --output=3Djson --image-opts
> > "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:bitmap1"
> >   [{ "start": 0, "length": 196608, "depth": 0, "present": true, "zero":
> > false, "data": true, "compressed": false, "offset": 0},
>
> The extent starting at logical offset 0 and lasting 196608 bytes is
> unchanged.
>
> > { "start": 196608, "length": 65536, "depth": 0, "present": false, "zero=
":
> > false, "data": false, "compressed": false},
>
> The extent starting at 196608 and lasting 65536 bytes is dirty
> (altered since the point in time when the bitmap was created).
>
> > > > qemu-img
> > > > map with x-dirty-bitmap image-opts.
> > >
> > > Here, this works, but feels like a hack, because it is relying on the
> > > x-dirty-bitmap feature of qemu.  The libnbd project ships with an
> > > application 'nbdinfo --map' that can read the same information as
> > > 'qemu-img map' but with a much nicer layout.  It's not going to
> > > necessarily be faster, but because it is a fully-supported feature of
> > > libnbd rather than a hack in qemu, it may prove more stable in the
> > > long run, and certainly easier to understand.
>
>
> For a worked example:
>
> # Create an image, dirty two different offsets, with a bitmap created in
> between
> $ qemu-img create -f qcow2 foo.qcow2 3M
> Formatting 'foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536 extended_l2=3Dof=
f
> compression_type=3Dzlib size=3D3145728 lazy_refcounts=3Doff refcount_bits=
=3D16
> $ qemu-io -f qcow2 foo.qcow2 -c 'w 1M 512'
> wrote 512/512 bytes at offset 1048576
> 512 bytes, 1 ops; 00.01 sec (42.906 KiB/sec and 85.8112 ops/sec)
> $ qemu-img bitmap -f qcow2 foo.qcow2 --add b1
> $ qemu-io -f qcow2 foo.qcow2 -c 'w 2M 512'
> wrote 512/512 bytes at offset 2097152
> 512 bytes, 1 ops; 00.00 sec (107.735 KiB/sec and 215.4704 ops/sec)
>
> # Now, expose the raw bytes of the image over NBD, and inspect with nbdin=
fo
>
> $ qemu-nbd -f qcow2 foo.qcow2 -A -Bb1 -t
> $ nbdinfo --map=3Dqemu:dirty-bitmap:b1 nbd://localhost
>          0     2097152    0  clean
>    2097152       65536    1  dirty
>    2162688      983040    0  clean
> $ nbdinfo --map nbd://localhost
>          0     1048576    3  hole,zero
>    1048576        4096    0  data
>    1052672       61440    2  zero
>    1114112      983040    3  hole,zero
>    2097152        4096    0  data
>    2101248       61440    2  zero
>    2162688      983040    3  hole,zero
>
> Comparing those to qemu-img map --output=3Djson should be instructive.
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>
>

--000000000000188bc30632424441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

Thank=C2=A0you, Eric, for the thorough information=E2=80=94truly appreciate=
 it.

<div><br></div><div>Just to confirm what I understood, when we are reading =
a bitmap with &#39;x-dirty-bitmap&#39; (for powered on vm of course), the &=
#39;start&#39; is always a logical offset no matter whether the record has =
&#39;offset&#39; value or not. Is this correct?</div><div><br></div><div>Al=
so, I came across a case wherein we get the entire disk as allocated for a =
raw format disk which is present on lvm or lvm-thin storage (the disk has j=
ust a few MB data added, and the vm is in running state). Here is an exampl=
e of 1Gb data. Is this expected behaviour?</div><div>[{ &quot;start&quot;: =
0, &quot;length&quot;: 1073741824, &quot;depth&quot;: 0, &quot;present&quot=
;: true, &quot;zero&quot;: false, &quot;data&quot;: true, &quot;compressed&=
quot;: false, &quot;offset&quot;: 0}]</div><div><br></div><div>Regards,</di=
v><div>Prashant</div></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 7, 2025 at 8:24=E2=
=80=AFPM Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, Apr 07, 2025 at 02:46:17PM +0530, prashant patil wrote:<br>
&gt; Thanks Eric.<br>
<br>
[top-posting makes conversations harder to follow, so on this list we<br>
typically reply inline]<br>
<br>
&gt; I have a few questions about the bitmap content shown by &#39;qemu-img=
 map&#39;.<br>
&gt; From below sample bitmap data:<br>
&gt; 1. Why only some of the extents have start and offset values? And why =
are<br>
&gt; they the same values?<br>
&gt; 2. What does the start value indicate? Is it logical offset or physica=
l<br>
&gt; offset of data into qcow2?<br>
<br>
Normally (when there is no x-dirty-bitmap in play), &#39;start&#39; denotes=
<br>
the logical offset being reported on (you&#39;d expect a map to list every<=
br>
logical offset; so the start of entry N+1 should be the sum of start +<br>
length of entry N), while &#39;offset&#39; is where that extent begins in t=
he<br>
underlying file.=C2=A0 For a raw source, offset and start will be<br>
identical; for other sources, like qcow2, start is obviously logical,<br>
while offset is physical.=C2=A0 Entries without &#39;offset&#39; are places=
 where<br>
the logical contents are compressed, synthesized, or otherwise have no<br>
1:1 correspondence to an offset in the physical file.=C2=A0 &#39;present&#3=
9;<br>
indicates whether the data is synthesized or not; &#39;offset&#39; is going=
 to<br>
be absent if &#39;present&#39; is false; although it can also be absent eve=
n<br>
when &#39;present&#39; is true such as in the case of compression.<br>
<br>
When it comes to exposing a qcow2 file over NBD, you generally want to<br>
have:<br>
<br>
qemu-nbd using &#39;-f qcow2&#39; =3D&gt; raw view =3D&gt; qemu-img using &=
#39;-f raw&#39;<br>
<br>
to expose only the logical contents over the wire.=C2=A0 It is also<br>
possible to flip the responsibility:<br>
<br>
qemu-nbd using &#39;-f raw&#39; =3D&gt; qcow2 view =3D&gt; qemu-img using &=
#39;-f qcow2&#39;<br>
<br>
to expose the bare-metal qcow2 contents over the wire, but that gets<br>
less testing, in part because if you make the image writable, it tends<br>
to cause problems if the client writing to the qcow2 layer needs to<br>
allocate (since NBD does not have a resize command).=C2=A0 Having the<br>
server open the file as qcow2 and only serving raw contents means the<br>
server can resize transparently.=C2=A0 What&#39;s more, block status comman=
ds<br>
over NBD only work when the server is aware of the qcow2 nature of the<br>
file it is serving (if you expose qcow2 bits over the wire, the server<br>
treats the entire file as allocated, and there is is no dirty bitmap<br>
context for the client to read over NBD).<br>
<br>
Therefore, &#39;start&#39; and &#39;offset&#39; are going to be identical i=
f you are<br>
using qemu-img map to read bitmaps from a server, since bitmaps can<br>
only be read when the wire has the raw view (not the qcow2 view).<br>
<br>
But when you add x-dirty-bitmap into the mix, you are asking qemu to<br>
DISREGARD the normal rules of backing file information and instead<br>
report on dirty bitmap information as if it were backing file info.<br>
This means that anywhere the dirty bitmap response differs from a<br>
normal backing file response, the output of qemu-img is reporting<br>
garbage data (for example, the &#39;present&#39; bit is now bogus, which<br=
>
explains why the rows where qemu-img claims &#39;present&#39; is false omit=
 an<br>
&#39;offset&#39;).=C2=A0 Only &#39;start&#39;, &#39;length&#39;, and &#39;d=
ata&#39; matter when using<br>
x-dirty-bitmap, with &#39;data=3Dfalse&#39; meaning the section was reporte=
d<br>
dirty, and &#39;data=3Dtrue&#39; meaning the section was reported unchanged=
.<br>
<br>
And if that is confusing, well yeah. Which is why I recommend using<br>
libnbd&#39;s nbdinfo --map, where the output is more obvious.<br>
<br>
&gt; <br>
&gt; root@be-proxmox1:/# qemu-img map --output=3Djson --image-opts<br>
&gt; &quot;$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:bitmap1&quot;<br>
&gt;=C2=A0 =C2=A0[{ &quot;start&quot;: 0, &quot;length&quot;: 196608, &quot=
;depth&quot;: 0, &quot;present&quot;: true, &quot;zero&quot;:<br>
&gt; false, &quot;data&quot;: true, &quot;compressed&quot;: false, &quot;of=
fset&quot;: 0},<br>
<br>
The extent starting at logical offset 0 and lasting 196608 bytes is<br>
unchanged.<br>
<br>
&gt; { &quot;start&quot;: 196608, &quot;length&quot;: 65536, &quot;depth&qu=
ot;: 0, &quot;present&quot;: false, &quot;zero&quot;:<br>
&gt; false, &quot;data&quot;: false, &quot;compressed&quot;: false},<br>
<br>
The extent starting at 196608 and lasting 65536 bytes is dirty<br>
(altered since the point in time when the bitmap was created).<br>
<br>
&gt; &gt; &gt; qemu-img<br>
&gt; &gt; &gt; map with x-dirty-bitmap image-opts.<br>
&gt; &gt;<br>
&gt; &gt; Here, this works, but feels like a hack, because it is relying on=
 the<br>
&gt; &gt; x-dirty-bitmap feature of qemu.=C2=A0 The libnbd project ships wi=
th an<br>
&gt; &gt; application &#39;nbdinfo --map&#39; that can read the same inform=
ation as<br>
&gt; &gt; &#39;qemu-img map&#39; but with a much nicer layout.=C2=A0 It&#39=
;s not going to<br>
&gt; &gt; necessarily be faster, but because it is a fully-supported featur=
e of<br>
&gt; &gt; libnbd rather than a hack in qemu, it may prove more stable in th=
e<br>
&gt; &gt; long run, and certainly easier to understand.<br>
<br>
<br>
For a worked example:<br>
<br>
# Create an image, dirty two different offsets, with a bitmap created in be=
tween<br>
$ qemu-img create -f qcow2 foo.qcow2 3M<br>
Formatting &#39;foo.qcow2&#39;, fmt=3Dqcow2 cluster_size=3D65536 extended_l=
2=3Doff compression_type=3Dzlib size=3D3145728 lazy_refcounts=3Doff refcoun=
t_bits=3D16<br>
$ qemu-io -f qcow2 foo.qcow2 -c &#39;w 1M 512&#39;<br>
wrote 512/512 bytes at offset 1048576<br>
512 bytes, 1 ops; 00.01 sec (42.906 KiB/sec and 85.8112 ops/sec)<br>
$ qemu-img bitmap -f qcow2 foo.qcow2 --add b1<br>
$ qemu-io -f qcow2 foo.qcow2 -c &#39;w 2M 512&#39;<br>
wrote 512/512 bytes at offset 2097152<br>
512 bytes, 1 ops; 00.00 sec (107.735 KiB/sec and 215.4704 ops/sec)<br>
<br>
# Now, expose the raw bytes of the image over NBD, and inspect with nbdinfo=
<br>
<br>
$ qemu-nbd -f qcow2 foo.qcow2 -A -Bb1 -t<br>
$ nbdinfo --map=3Dqemu:dirty-bitmap:b1 nbd://localhost<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A02097152=C2=A0 =C2=A0=
 0=C2=A0 clean<br>
=C2=A0 =C2=A02097152=C2=A0 =C2=A0 =C2=A0 =C2=A065536=C2=A0 =C2=A0 1=C2=A0 d=
irty<br>
=C2=A0 =C2=A02162688=C2=A0 =C2=A0 =C2=A0 983040=C2=A0 =C2=A0 0=C2=A0 clean<=
br>
$ nbdinfo --map nbd://localhost<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A01048576=C2=A0 =C2=A0=
 3=C2=A0 hole,zero<br>
=C2=A0 =C2=A01048576=C2=A0 =C2=A0 =C2=A0 =C2=A0 4096=C2=A0 =C2=A0 0=C2=A0 d=
ata<br>
=C2=A0 =C2=A01052672=C2=A0 =C2=A0 =C2=A0 =C2=A061440=C2=A0 =C2=A0 2=C2=A0 z=
ero<br>
=C2=A0 =C2=A01114112=C2=A0 =C2=A0 =C2=A0 983040=C2=A0 =C2=A0 3=C2=A0 hole,z=
ero<br>
=C2=A0 =C2=A02097152=C2=A0 =C2=A0 =C2=A0 =C2=A0 4096=C2=A0 =C2=A0 0=C2=A0 d=
ata<br>
=C2=A0 =C2=A02101248=C2=A0 =C2=A0 =C2=A0 =C2=A061440=C2=A0 =C2=A0 2=C2=A0 z=
ero<br>
=C2=A0 =C2=A02162688=C2=A0 =C2=A0 =C2=A0 983040=C2=A0 =C2=A0 3=C2=A0 hole,z=
ero<br>
<br>
Comparing those to qemu-img map --output=3Djson should be instructive.<br>
<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libguestfs.org" rel=3D"norefer=
rer" target=3D"_blank">libguestfs.org</a><br>
<br>
</blockquote></div>

--000000000000188bc30632424441--

