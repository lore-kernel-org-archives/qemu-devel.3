Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AAFD1AD36
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LrJ-0003nI-Af; Thu, 17 Oct 2024 04:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1LrH-0003mt-LS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t1LrG-0002us-17
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729153664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6LhPeKaSydXnCd1LDRaIcSA5XyIsiNU3SR2GAfR44I=;
 b=GhoXBo/u0mDYU2cH+AdagH/sEEUsymcsZ5xqYb29g6BsrNxl9CptFFeeAyMrRWjMsCmw0E
 Ao5KyRZ9ICuHQXXvKwazH1HBosvXsLJOcaw+ke+kK68NkIZn/wP5uQ+CR0UckWM7hVJoiv
 ATiWFqUnbiYAqewv3NCrEt8BfWhLRUE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-DfeVNb-NOoK1Rlr0w1s2rQ-1; Thu, 17 Oct 2024 04:27:43 -0400
X-MC-Unique: DfeVNb-NOoK1Rlr0w1s2rQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e2c3338a9dso819381a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 01:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729153662; x=1729758462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6LhPeKaSydXnCd1LDRaIcSA5XyIsiNU3SR2GAfR44I=;
 b=Ihs/nM7DptFh1d9YxRkyVtZk1YMHuDlEf0noRrl2uDPR3/QBHqtFbQH51/1PP1P303
 9ddSbW1yEa+JfVOjRODaHM38RKVqgOl7aUs8ri8LJqZeMSH0tqBqUEfJYjknhUEMD2OG
 5WwEYrBSKcwoGPzxEzQMW/c1uJK5cALmwDQDEtWMTKvlzEiXhadGXRRxtB347HsTsqzS
 BboC2bEIdNV9PqZ3Atai9gwdY3YH2hMflllozG+ZJ2nVx9OFyI0dRQtTJDjBazvLSbte
 5iPjFEEgw1OfT+Kx2AvK97xgfGJncJ9xidB9hnNv9SJpZzosPhcK4nWwsb0oXB/d6qfK
 sJ9w==
X-Gm-Message-State: AOJu0Yz4G26b6Qxd4Cxb535Oarb7jjAgL1+XEjJ0Dmagtf8MG/nXSksN
 wLX85eBK5e1SS40P5pLrCf/gGIeIEBwNhGymZluVXUGLXesaNnAC3eZa28qMxYSe2utUbgJiXO3
 Y5BiSvQUoQ/AZFs6gFc4hrzMGg14BhCettW7tzHcevw+0EzJ54kYeny/lAgc0+V29+gjwkrEPK7
 TQpeeeLkAMWeLNEwaRS5nJDCB06vo=
X-Received: by 2002:a17:90b:384c:b0:2e0:a77e:82ff with SMTP id
 98e67ed59e1d1-2e3b09fac5emr6173959a91.33.1729153662023; 
 Thu, 17 Oct 2024 01:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqwoskkOqUZW1833mXq31oPi9XDze0vDS7PBA8ygEsc1cTQe3ZeR0yH4DskSn3oW9Pzxfk9o9Xsae+sTHkQz8=
X-Received: by 2002:a17:90b:384c:b0:2e0:a77e:82ff with SMTP id
 98e67ed59e1d1-2e3b09fac5emr6173941a91.33.1729153661597; Thu, 17 Oct 2024
 01:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241016090606.2358056-1-aesteve@redhat.com>
 <vmtm4zz6pkfcxr64wixa2wdjb7ujn2vaiapmziaqciiytcwe5v@7fh6zlfyf67l>
In-Reply-To: <vmtm4zz6pkfcxr64wixa2wdjb7ujn2vaiapmziaqciiytcwe5v@7fh6zlfyf67l>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 17 Oct 2024 10:27:30 +0200
Message-ID: <CADSE00+UFCHOLQHndGThOmXt3eXo4RsJZKC+FyXOuaiPwJbBmQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Albert Esteve

Senior Software Engineer

Red Hat

aesteve@redhat.com



On Thu, Oct 17, 2024 at 9:38=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> >VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> >VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> >in the spec that they return 0 for successful
> >operations, non-zero otherwise. However,
> >implementation relies on the return types
> >of the virtio-dmabuf library, with opposite
> >semantics (true if everything is correct,
> >false otherwise). Therefore, current implementaion
>
> s/implementaion/implementation
>
> I hadn't seen it ;-P found with:
> ./scripts/checkpatch.pl --strict --branch master..HEAD --codespell

Never used the checkpatch script for spelling. Thanks!

>
> >violates the specification.
> >
> >Revert the logic so that the implementation
> >of the vhost-user handling methods matches
> >the specification.
> >
> >Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
>
> This is in from 9.0 ...
>
> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
>
> ... and this from 8.2, so should we consider stable branches?

You mean in addition to the commits already reflected here?

>
> I think it depends if the backends are checking that return value.

The return value is optional (requires VHOST_USER_NEED_REPLY),
and I am not aware of any backend using this feature so far,
in general. So iiuc, that'd mean no need to include stable, right?

Best,
Albert.

>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
>
> Thanks for the fix!
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 00561daa06..90917352a4 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct=
 vhost_dev *dev,
> >     QemuUUID uuid;
> >
> >     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >-    return virtio_add_vhost_device(&uuid, dev);
> >+    return !virtio_add_vhost_device(&uuid, dev);
> > }
> >
> > static int
> >@@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(s=
truct vhost_dev *dev,
> >         struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> >         if (dev !=3D owner) {
> >             /* Not allowed to remove non-owned entries */
> >-            return 0;
> >+            return -EPERM;
> >         }
> >         break;
> >     }
> >     default:
> >         /* Not allowed to remove non-owned entries */
> >-        return 0;
> >+        return -EPERM;
> >     }
> >
> >-    return virtio_remove_resource(&uuid);
> >+    return !virtio_remove_resource(&uuid);
> > }
> >
> > static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> >--
> >2.46.1
> >
>


