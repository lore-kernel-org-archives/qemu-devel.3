Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B187C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcTu-00051p-1C; Tue, 02 Apr 2024 07:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrcTr-00051U-Vy
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rrcTp-0001rY-5T
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdyL4Zo0mveb6MocZPEFcF58z4tmDaEDbphaAow61Ug=;
 b=FTBVimgNHtFKirMVxbL1H7Mwd+J0uzdFV8x9dNeEy+3JMmczcdqC31TTBPQD2AFEPLhoqR
 /vcj5arEonXj30kckcwZiuNtkenAP+mnYw8876Ye9Yk+5sVK+jJXVdkpAvUQREcZgmt1Mh
 2ESXZIyBrcp4Np7Qml9B42hVg5abA1Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-5kAlzM-9MuumF-Q_gnBjKQ-1; Tue, 02 Apr 2024 07:39:01 -0400
X-MC-Unique: 5kAlzM-9MuumF-Q_gnBjKQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dc6b26845cdso7432102276.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057941; x=1712662741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdyL4Zo0mveb6MocZPEFcF58z4tmDaEDbphaAow61Ug=;
 b=J4JgtJdyJQvXjsoN8fCwXbEiT9JOz+LWLttoaSyhL+rApTF7+H2tTliMnlB4Ss9EHm
 V2NqvZ+NG1M06lvVBlCfr3LzQQlZBnG1Wu9F9pZq3kE0ECADIZk9QvncghURHpLoSoW3
 Cr5BvDXLSUToRp42E2zoP8v67yBsf8UoYUBVe2Mz5ktphdmQhiTT4spt4qui4lVIDLzr
 BFgR+ZyO4jike6e1MpcFUFeWJz41WlHW6at40FbLBSmArAkftnb1qLh5brz7/Q9sgTAy
 ETGpkQKS/ALjgvw+J4NvV543Y73JAIa5fxoLfQ831rChwmVbyRYCCSJnoo4Gzxz3Bcum
 gosg==
X-Gm-Message-State: AOJu0YzLVEOGnAHRh3vLkG1yxGB6UyzJH5why50jCsJAsE7iTNAdocfw
 ovym44k+FYAj4GVzJe1nqQUU/6ZhzD5ctskOX//CyGTDuGkokqflSxh9i9uNJQ9VqtKX30yw5wO
 193sIg+UUWv0wbDvu+nekAS6S7+4GRyQ4BTXVjyRM/feNcy1PyrZ48woEYbllgVOGrn+bXCBwOy
 2f61aVAJEUqDuL2URQ9RZu4DfIlX4=
X-Received: by 2002:a25:c789:0:b0:dcf:4793:9a25 with SMTP id
 w131-20020a25c789000000b00dcf47939a25mr11181449ybe.44.1712057941401; 
 Tue, 02 Apr 2024 04:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMXxVniompKqDWr0EO+1OsuP3fNAQh/QXkZxD9425iC44/k/yTfsGAiLJY40zUmauHIozrkVFTS7IOwOuw91I=
X-Received: by 2002:a25:c789:0:b0:dcf:4793:9a25 with SMTP id
 w131-20020a25c789000000b00dcf47939a25mr11181436ybe.44.1712057941149; Tue, 02
 Apr 2024 04:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun> <8390729.NyiUUSuA9g@valdaarhun>
 <10693205.CDJkKcVGEf@arch> <10440822.nUPlyArG6x@valdaarhun>
In-Reply-To: <10440822.nUPlyArG6x@valdaarhun>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 2 Apr 2024 13:38:24 +0200
Message-ID: <CAJaqyWfeUHTEj6F-uBzA57gPLZhD70w1+FY2sDCTFBHEDkzzPA@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>, daleyoung4242@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 2, 2024 at 6:58=E2=80=AFAM Sahil <icegambit91@gmail.com> wrote:
>
> Hi,
>
> On Monday, April 1, 2024 11:53:11 PM IST daleyoung4242@gmail.com wrote:
> > Hi,
> >
> > On Monday, March 25, 2024 21:20:32 CST Sahil wrote:
> > > Q1.
> > > Section 2.7.4 of the virtio spec [3] states that in an available
> > > descriptor, the "Element Length" stores the length of the buffer elem=
ent.
> > > In the next few lines, it also states that the "Element Length" is
> > > reserved for used descriptors and is ignored by drivers. This sounds =
a
> > > little contradictory given that drivers write available desciptors in=
 the
> > > descriptor ring.
> > When VIRTQ_DESC_F_WRITE is set, the device will use "Element Length" to
> > specify the length it writes. When VIRTQ_DESC_F_WRITE is not set, which
> > means the buffer is read-only for the device, "Element Length" will not=
 be
> > changed by the device, so drivers just ignore it.
>
>
> Thank you for the clarification. I think I misunderstood what I had read
> in the virtio spec. What I have understood now is that "Element Length"
> has different meanings for available and used descriptors.
>
> Correct me if I am wrong - for available descriptors, it represents the
> length of the buffer. For used descriptors, it represents the length of
> the buffer that is written to by the device if it's write-only, otherwise=
 it
> has no meaning and hence can be ignored by drivers.
>

Both answers are correct.

> > > Q2.
> > > In the Red Hat article, just below the first listing ("Memory layout =
of a
> > > packed virtqueue descriptor"), there's the following line referring t=
o the
> > > buffer id in
> > >
> > > "virtq_desc":
> > > > This time, the id field is not an index for the device to look for =
the
> > > > buffer: it is an opaque value for it, only has meaning for the driv=
er.
> > >
> > > But the device returns the buffer id when it writes the used descript=
or to
> > > the descriptor ring. The "only has meaning for the driver" part has g=
ot me
> > > a little confused. Which buffer id is this that the device returns? I=
s it
> > > related to the buffer id in the available descriptor?
> >
> > In my understanding, buffer id is the element that avail descriptor mar=
ks to
> > identify when adding descriptors to table. Device will returns the buff=
er
> > id in the processed descriptor or the last descriptor in a chain, and w=
rite
> > it to the descriptor that used idx refers to (first one in the chain). =
Then
> > used idx increments.
> >
> > The Packed Virtqueue blog [1] is helpful, but some details in the examp=
les
> > are making me confused.
> >
> > Q1.
> > In the last step of the two-entries descriptor table example, it says b=
oth
> > buffers #0 and #1 are available for the device. I understand descriptor=
[0]
> > is available and descriptor[1] is not, but there is no ID #0 now. So do=
es
> > the device got buffer #0 by notification beforehand? If so, does it mea=
n
> > buffer #0 will be lost when notifications are disabled?
> >
>

I guess you mean the table labeled "Figure: Full two-entries descriptor tab=
le".

Take into account that the descriptor table is not the state of all
the descriptors. That information must be maintained by the device and
the driver internally.

The descriptor table is used as a circular buffer, where one part is
writable by the driver and the other part is writable by the device.
For the device to override the descriptor table entry where descriptor
id 0 used to be does not mean that the descriptor id 0 is used. It
just means that the device communicates to the driver that descriptor
1 is used, and both sides need to keep the descriptor state
coherently.

> I too have a similar question and understanding the relation between buff=
er
> ids in the used and available descriptors might give more insight into th=
is. For
> available descriptors, the buffer id is used to associate descriptors wit=
h a
> particular buffer. I am still not very sure about ids in used descriptors=
.
>
> Regarding Q1, both buffers #0 and #1 are available. In the mentioned figu=
re,
> both descriptor[0] and descriptor[1] are available. This figure follows t=
he figure
> with the caption "Using first buffer out of order". So in the first figur=
e the device
> reads buffer #1 and writes the used descriptor but it still has buffer #0=
 to read.
> That still belongs to the device while buffer #1 can now be handled by th=
e driver
> once again. So in the next figure, the driver makes buffer #1 available a=
gain. The
> device can still read buffer #0 from the previous batch of available desc=
riptors.
>
> Based on what I have understood, the driver can't touch the descriptor
> corresponding to buffer #0 until the device acknowledges it. I did find t=
he
> figure a little confusing as well. I think once the meaning of buffer id =
is clear
> from the driver's and device's perspective, it'll be easier to understand=
 the
> figure.
>

I think you got it right. Please let me know if you have further questions.

> I am also not very sure about what happens when notifications are disable=
d.
> I'll have to read up on that again. But I believe the driver still won't =
be able to
> touch #0 until the device uses it.
>

If one side disables notification it needs to check the indexes or the
flags by its own means: Timers, read the memory in a busy loop, etc.

Sorry for the late reply!

Thanks!

> I think going through the source should better explain these concepts.
>
> Thanks,
> Sahil
>
>
>


