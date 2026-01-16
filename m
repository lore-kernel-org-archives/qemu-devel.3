Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3251ED4660C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggzu-0006mI-M4; Fri, 16 Jan 2026 05:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vggzs-0006l3-L3
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:24:04 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vggzq-0004zG-FV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:24:04 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso245002766b.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768559041; x=1769163841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4pKB6eLX3QoEf/QjWoMPWyx9QFs7qbqCKSaPJtxCOI=;
 b=GKCsMXQJPsXtGtGewITSIec8VsXfeM4yhIfGFI6+qD9Dh/kYNAo99h+0X+zHhm1Nnm
 tvG035WZsIKzgaLAiixcMh49n6C4AlkylOOlrxCJNazk0be3GPAD8rKkAEoaH77x4COv
 Cf0ZMMSwWaL9K/X7R6oYmPFLsOfMttVcMQpfbHq7bV0HJDKTu6Vmy4PQ/wREdB1YFQpe
 6EnnxJAh+RQnpct1a0dQ/lI46T4Q/mhsYqkgbw+PXIQ6H1e1S52XSbSNkj9BZFekMSSi
 WurD25qjrp7VAzBWVAC8v2nX7LEm2pKcxscOACRCbI5XKMWeoFINSl8w6i7RNAUyq9ZM
 y/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768559041; x=1769163841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G4pKB6eLX3QoEf/QjWoMPWyx9QFs7qbqCKSaPJtxCOI=;
 b=WssMuhRAi5WVFePegaHviTkILbVSXL8c0QHrIIdz5VXKnopP7EXNa033dcJQwjoPRv
 gIvAFV/cpvh7T6hn4IiLPR5VZVwEj2o5ZYxB+Vh1WDrvv9mAk1qru7unzJ9QyyLrpqQL
 jlI5JDR3BhH9JUHobu1W60uVrT6yw1IKM2XQ6dDHFUCIV0k+Qo6gyLIswgSdYrc0/F/x
 OX4dSPGC3JRKtrYOm6nfwlYsqGJJXEd62qbkyx/FqKmLu1sznul6rOe54HOHa0HLjB+w
 rPEe5HH/l8rYdVXAqrb+napPdRrjeZmGAwl9ZBPYzo74vb56bzlCvMJJrA8TuapROoxo
 lbGg==
X-Gm-Message-State: AOJu0YwSNs1qOZGQYw2WzfR9YCdKDEDm9lNZatixh4Sg/ojxxoml+h4c
 FC933bOvvEgfSfhHjDC6p2JWJY0DJmxqL898plPkzz7ntvyU6t6FnAZYp0cb2ejsABlHhXNAOoM
 35ET2TJJzG9C33PWVY5XoZ2dqbKXIvv0y2n1S461SUg==
X-Gm-Gg: AY/fxX6re35I9JWs/La5nInfRKbybgSI5riFcsuaLX8Vd7GjHtnHjNRDJtBpvq8uDp/
 cp3pt7FzZGIySd+qIgNYzefKxwhb+a8vVJXsT5ZWNaEUfYYmn3Sa+b0CMo50l0Ez7GJmjJjzPmG
 +Kn//x7oJXsxdgVJpAOOVa8p89nOGK0e7oxdm25shbZKZqpiYHeYgqlXhbH97mehyYomTEsljPp
 uDilJSpzgchH6i9fNHJbr752rfZ0K3jRYCHOrjA8zbZcSioeG5Dpu3NH1e0rmHpMGG8nYtwVfN6
 BfUDR7ez1upn/j/Msyqq9uoEI7Bt5DK0FtUP
X-Received: by 2002:a17:907:3e83:b0:b87:7e8:e268 with SMTP id
 a640c23a62f3a-b879300cc4bmr231753266b.37.1768559040650; Fri, 16 Jan 2026
 02:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-6-aesteve@redhat.com>
 <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
In-Reply-To: <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 16 Jan 2026 12:23:34 +0200
X-Gm-Features: AZwV_QhdMzg8wkKBxFpf-iVjU-7zkWBt6L4y4jh2gQk-HPBUFp1OEdt31pPch-M
Message-ID: <CAAjaMXZPGzx7FrEbjYiZcHf+e+bz4Um3E-HgkQxb==JZaMYsAA@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, slp@redhat.com, stefanha@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 16, 2026 at 12:20=E2=80=AFPM Albert Esteve <aesteve@redhat.com>=
 wrote:
>
> On Tue, Nov 11, 2025 at 10:11=E2=80=AFAM Albert Esteve <aesteve@redhat.co=
m> wrote:
> >
> > Add GET_SHMEM_CONFIG vhost-user frontend
> > message to the spec documentation.
> >
> > Reviewed-by: Alyssa Ross <hi@alyssa.is>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 6c1d66d7d3..6a1ecd7f48 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -371,6 +371,20 @@ MMAP request
> >    - 0: Pages are mapped read-only
> >    - 1: Pages are mapped read-write
> >
> > +VIRTIO Shared Memory Region configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+---------+------------+----+--------------+
> > +| num regions | padding | mem size 0 | .. | mem size 255 |
> > ++-------------+---------+------------+----+--------------+
> > +
> > +:num regions: a 32-bit number of regions
> > +
> > +:padding: 32-bit
> > +
> > +:mem size: contains ``num regions`` 64-bit fields representing the siz=
e of each
> > +           VIRTIO Shared Memory Region
> > +
>
> When implementing this for rust-vmm, the mem size came up a bit
> confusing. In the last patch (7/7) of this series, the implementation
> uses `num regions` as a count for the number of valid regions (thus
> accounting for gaps in the shmem region mapping). Thus, `mem size` has
> this confusing statement saying that it containers `num regions`
> fields. It should say it contains 256 fields (it is only sent once
> during initialization, so no need to save bytes here), with only `num
> regions` that are valid (i.e., greater than 0).

That was my understanding also. I agree a clarification would not do any ha=
rm :)

> Maybe it could even
> discard the `num regions` field, and send only the full array.
> Thoughts?
>



> As much as I wanted this series merged, this deserves a clarification.
> So I can either send a new version of the series or split the last
> three patches into a different series. Hopefully it only requires one
> more version though.
>
>
> >  C structure
> >  -----------
> >
> > @@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> >            VhostUserMMap mmap;
> > +          VhostUserShMemConfig shmem;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1761,6 +1776,30 @@ Front-end message types
> >    Using this function requires prior negotiation of the
> >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> >
> > +``VHOST_USER_GET_SHMEM_CONFIG``
> > +  :id: 44
> > +  :equivalent ioctl: N/A
> > +  :request payload: N/A
> > +  :reply payload: ``struct VhostUserShMemConfig``
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the front-=
end
> > +  to gather the VIRTIO Shared Memory Region configuration. The back-en=
d will
> > +  respond with the number of VIRTIO Shared Memory Regions it requires,=
 and
> > +  each shared memory region size in an array. The shared memory IDs ar=
e
> > +  represented by the array index. The information returned shall compl=
y
> > +  with the following rules:
> > +
> > +  * The shared information will remain valid and unchanged for the ent=
ire
> > +    lifetime of the connection.
> > +
> > +  * The Shared Memory Region size must be a multiple of the page size
> > +    supported by mmap(2).
> > +
> > +  * The size may be 0 if the region is unused. This can happen when th=
e
> > +    device does not support an optional feature but does support a fea=
ture
> > +    that uses a higher shmid.
> > +
> >  Back-end message types
> >  ----------------------
> >
> > --
> > 2.49.0
> >
>

