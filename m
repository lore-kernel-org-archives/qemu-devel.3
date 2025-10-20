Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED92ACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqGr-00032i-8m; Mon, 20 Oct 2025 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vAqGo-00032Q-Jj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vAqGl-00041X-RJ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760968188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ej8351/0UvMa/41ngEr3sh4LZ9iC70aq0b1MPPoDwSo=;
 b=TcdkSZtFgjIDCdWIAw3IgB69fyXph5DW+pqPgR8lSPxvSIC45iNBDqVpvo5UACtk4z3zDt
 ZARC4mmWErs/OxxU0rNopsOOm6oit9tofQsSx+FxiNFGLDUsFo/on8PgK9eh+G0yZgfOsM
 IYWbe/l+TMlM7d/YZ91V82ZtvRo57bE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-1193aKMjMAeeJjhkmusCvw-1; Mon, 20 Oct 2025 09:49:45 -0400
X-MC-Unique: 1193aKMjMAeeJjhkmusCvw-1
X-Mimecast-MFC-AGG-ID: 1193aKMjMAeeJjhkmusCvw_1760968184
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b56ae0c8226so2905500a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968184; x=1761572984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej8351/0UvMa/41ngEr3sh4LZ9iC70aq0b1MPPoDwSo=;
 b=AuacYviZxrHe9TdFQhMr4/EPijG8MbiOv42jiJq1gHDwfI8Y42F6moDqKMeuwqrTpx
 tUBYMOO6sCFWsFJCZUsJ6w/8UkDQ3r7sCey0B6B0G6x/54DM/Vj9oY9BeQlzEGUNuCm6
 reI3Qqv6iuQ4muyutJVu8GKD9kd1gzVODg4O1NyI74ISwN8tF5a2dpuGmDPPwfVIxWzG
 XmXAdUhTOwCVorPb0XRT7PBiEGNwAfYKohCZJwYcLSRXmyeZSSHai8TF0xrbkHubj+pv
 JyKHRFySshY12U5GxTFXj9iGV5mbg0e09ALmhygUZCF+nPIfLmU97O+bSbho1Hvcv176
 9m4Q==
X-Gm-Message-State: AOJu0Yy+50/Zvu4MUr0xk+gJQHw1qjLTnxkYKObxO7KXVnO2wiJpY4Zc
 oVuQhQFSqSHo3JOTB6k9x0Er5Sv2bVHJLSjG3kfwOETTkZONiVnPvdzhcct86efXu3yUIZOJie4
 MH2K89DoLIyx+yJ8nIdqfhaYYUfnEC5xsKn/IVVSiYEyHHCamAzhnolEhpKjdmGKk1XJiieQEaI
 2+MB5GuZFe/hMtWsUYagJKxsze1ZyApYE=
X-Gm-Gg: ASbGncuRZWl5OmIVqI5LzF+Oiv78AlM0zlssG6J3oRFnYFwzMB9CBiqwFBdSaOA2slC
 SqQK5LIRcSUQlI0CP3LHGAcUNxep13zJ1BDefhXbI+Ymf9Gc2j0KDzL5SYvTtd3Tt7DhZLOgjKW
 Dht1UuzKjXGTQ8XY8oXUY/KQanTKxAWBDVtmlR8IboWSB6JUcD1xk=
X-Received: by 2002:a17:903:3bce:b0:27e:ec72:f67 with SMTP id
 d9443c01a7336-290c9c89dd4mr148886085ad.6.1760968184181; 
 Mon, 20 Oct 2025 06:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvKTg2YlkFHJmdM+9+OVL9F38ORTWDZyybsCrkTvqUCamklZVk0sGW4sQO836taHG/lQNXAV2omfzoEUxTc3Y=
X-Received: by 2002:a17:903:3bce:b0:27e:ec72:f67 with SMTP id
 d9443c01a7336-290c9c89dd4mr148885725ad.6.1760968183750; Mon, 20 Oct 2025
 06:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016143827.1850397-4-aesteve@redhat.com>
 <20251020132700.GB115852@fedora>
In-Reply-To: <20251020132700.GB115852@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Oct 2025 15:49:31 +0200
X-Gm-Features: AS18NWCtHbIDfSM3NXFRL4oBoCwqGdhf4jcRBcpYrP9ESG2OkFSdAJ7q_myfnJo
Message-ID: <CADSE00KCyFrc_f06B-OJ4zUG+nr8FhVkO_5WsJ2N39REWUMKKg@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com, dbassey@redhat.com, 
 stevensd@chromium.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com, manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 20, 2025 at 3:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Oct 16, 2025 at 04:38:23PM +0200, Albert Esteve wrote:
> > Add SHMEM_MAP/_UNMAP request to the vhost-user
> > spec documentation.
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 58 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 436a94c0ee..8143d56419 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -350,6 +350,27 @@ Device state transfer parameters
> >    In the future, additional phases might be added e.g. to allow
> >    iterative migration while the device is running.
> >
> > +MMAP request
> > +^^^^^^^^^^^^
> > +
> > ++-------+---------+-----------+------------+-----+-------+
> > +| shmid | padding | fd_offset | shm_offset | len | flags |
> > ++-------+---------+-----------+------------+-----+-------+
> > +
> > +:shmid: a 8-bit shared memory region identifier
> > +
> > +:fd_offset: a 64-bit offset of this area from the start
> > +            of the supplied file descriptor
> > +
> > +:shm_offset: a 64-bit offset from the start of the
> > +             pointed shared memory region
> > +
> > +:len: a 64-bit size of the memory to map
> > +
> > +:flags: a 64-bit value:
> > +  - 0: Pages are mapped read-only
> > +  - 1: Pages are mapped read-write
> > +
> >  C structure
> >  -----------
> >
> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with =
the following struct:
> >            VhostUserInflight inflight;
> >            VhostUserShared object;
> >            VhostUserTransferDeviceState transfer_state;
> > +          VhostUserMMap mmap;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1057,6 +1079,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> >
> >  Front-end message types
> >  -----------------------
> > @@ -1865,6 +1888,41 @@ is sent by the front-end.
> >    when the operation is successful, or non-zero otherwise. Note that i=
f the
> >    operation fails, no fd is sent to the backend.
> >
> > +``VHOST_USER_BACKEND_SHMEM_MAP``
> > +  :id: 9
> > +  :equivalent ioctl: N/A
> > +  :request payload: fd and ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds to
> > +  advertise a new mapping to be made in a given VIRTIO Shared Memory R=
egion.
> > +  Upon receiving the message, the front-end will mmap the given fd int=
o the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``.
> > +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> > +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> > +  must respond with zero when operation is successfully completed,
> > +  or non-zero otherwise.
> > +
> > +  Mapping over an already existing map is not allowed and requests sha=
ll fail.
> > +  Therefore, the memory range in the request must correspond with a va=
lid,
> > +  free region of the VIRTIO Shared Memory Region. Also, note that mapp=
ings
> > +  consume resources and that the request can fail when there are no re=
sources
> > +  available.
>
> If you respin this series or send follow-up patches, please extend this
> to mention that mappings are automatically unmapped by the frontend
> across device reset. This behavior is already implemented in the patch
> series but needs to be part of the spec so that spec implementors are
> aware of it.

Sounds good!

>
> > +
> > +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> > +  :id: 10
> > +  :equivalent ioctl: N/A
> > +  :request payload: ``struct VhostUserMMap``
> > +  :reply payload: N/A
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the backen=
ds so
> > +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) =
in the
> > +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that =
the
> > +  given range shall correspond to the entirety of a valid mapped regio=
n.
> > +  A reply is generated indicating whether unmapping succeeded.
> > +
> >  .. _reply_ack:
> >
> >  VHOST_USER_PROTOCOL_F_REPLY_ACK
> > --
> > 2.49.0
> >


