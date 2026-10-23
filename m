Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5A606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qAexws5g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBQh-0003sM-Vd; Fri, 23 Oct 2026 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xKBQh-0003sD-7d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:19:15 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xKBQf-0006PN-Hh
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:19:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so776256a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792747151; cv=none;
 d=google.com; s=arc-20260327;
 b=LDxPEgtmKSosH5V/TMl0HnvQWlJzpA8DzMt7YaHWaAzO0T65oypLx6Z22R7VT6/S+Q
 AH6WrweZJ+pWdpoHb5UPCNVeszol3OFPb/gjCWPhvoqCaaVfXgXxef5ZckTshzSuQ0WL
 9YK0NTR3xjR4z77frly+dxKbyDIcHObDL7VESAq8vOBYbnEXFcC9wGeC1VfoI033lX6J
 FImwZzJ8Gr3t06iFA600hYI5jSNAe3QW2X2ThEC1E2TcW2K1FZcPkhE0nHsUJ1BNEVaQ
 fA09E/086XLaFvZtbQEeTy7UstLw38X0voKw3yyJ49jFxTkYCw1h/yndIkzAypkxyo0v
 QHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MRFAYl28aa8iE83sBcbvN5OUUvJnWP6Rm/oS0Uq3CXQ=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=cWAcahKUFpLSSvC/YeH5VugJjXhSD+CZSBFqYZC2l5K+2I7E0i2LblsBStlYadDo0V
 gercP0GuzN8Z2WwNMkSMtX8HbykJmPXKsH2mD1BVTtlCjpYkUyxkqRw+SUM/7jEfWjAg
 mgMVfRYhm95HGnDKdGx/QP+ntLeGLiKynf0fzWnbVQN4yg7gXei0wNWzbKsPMkg5h9PW
 5FReNuwBuHtevnK52HG7KNaEvgw8xmwTH7h2bHY3wefE9Tu5UyWLIkVtYhHrcdTtXwVY
 yxVssM27DShVRsEtDREslTrLdEnouvWztOPHXowxcVd8dUuwGQoAZWcj9RoGXTwza5sa
 XcGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792747151; x=1793351951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MRFAYl28aa8iE83sBcbvN5OUUvJnWP6Rm/oS0Uq3CXQ=;
 b=qAexws5gR2MNAitm+4vF1k9Atv1Fs0jYkWrckrbWfM5FIRzMRM7ADBcz3SACS1TY60
 aWB/bS9tkULmpi8U/6q1FiHeoM8P6j3a0WKFtI8O4qNuS5dSwZPLmYD2jXxXFxL+BU1I
 C9WxxZOiZ6lNSkfQxRuyt4cql6l6oRXSOLbLo+Z43tZ0M7c3/mjOXO9bk5AS81MJEMPg
 n3x22FueuWaJgYz9HF6qPN/MXHtcwfgz3WhgpnTs+YEYSKt2w+0KTHpXqRa6IeZOwGaU
 UXYn39j02p6ubnJSaHCAeeNzzKakDXbwGAnZjtS5A21Z0KKOAaNeGE6rtSget7w2mPQI
 E0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792747151; x=1793351951;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MRFAYl28aa8iE83sBcbvN5OUUvJnWP6Rm/oS0Uq3CXQ=;
 b=gIxo3cCo5NWgIdXe8mrlkcP1iHqgof9wV3kK5PILdTu99HFcISI49rxeoIoDDKK7Yu
 T4+baYOCPyWZrc6d1t6BdacMCAjFi9xxboLCQgCWql+fXPfXFfEM0LbP66QOMYL9UTl0
 2JP4GZxrA9toYk4eKHptST+LX8zHCIIqaA9xsEqaECnCRCOdcjFGrFd3VWX8GGFyI9FT
 nSrR5/EMtyqvZD1b2YhBSYW8NmoNEJ2AFFO0UWia5eN2tZbvL+mHJGmUstJcikU9357W
 z+kexOm+Ztpis8YRJCjxASZkctqA6vbbYIDSsa4rj2u+SxDnmh1axPLNTgQJmUBTy/mT
 OZ5w==
X-Gm-Message-State: AFq9FYJnY1L/CCjL9GIloGIPGLJieEYlrbG9qMDTSVFHh1ppR457iaw0
 PvMtuzv6tk7VSM5bFG1nJF3Xoz2KmX5xRizpt7BuLYfsKb9ANX1Hc51JGl+B5PrNOMuG4hN19oQ
 kYpebXxrOlywJB6daEDsUrz3Dhd+1zHY=
X-Gm-Gg: AYBFou0gyenQMy/a3k65Z6qarZ7Dg++pbrt/a20gvx2NuX/7rtNXya2cy4AXEN4OD7+
 gImxMAzpmgepQG0neZRcahripsof9E+MiWrzH9XtL2Zb62W91ne7R3eNhqaDhMa/+i2e31OlXcF
 v+zNq1T5N36z4wikx5qX77vk8GTr7hnxe584PH5ozjZpzhl869kjs1+Gc5+ekqRipyHjgcEaijv
 X8zYn/sfouPFBrgEz+t8G8y4nKADNaIR24mNWV5Hkwynttekay+Qk3QajDdg/e7VN0qQgYz6l6f
 r5z5ecz0Msiniqfj+6SbkpfIeB2h+mROiRr/IuF1CqxQWkMs+zjdzXNtu73AAiuoMvH7LcIKzfP
 DCZNnGbQBQLF9AH5vsJg5DYn41lN1ea8Qx4I1euqnC+V4j24EYnNI4/9mOE0=
X-Received: by 2002:a05:6402:c110:b0:6b4:2185:7147 with SMTP id
 4fb4d7f45d1cf-6b432bce2a6mr1759210a12.15.1792747151240; Fri, 23 Oct 2026
 02:19:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260929084416.1600199-1-zhangckid@gmail.com>
 <20260929084416.1600199-6-zhangckid@gmail.com>
 <20261022202336.GH20810@shajnocz.csb>
In-Reply-To: <20261022202336.GH20810@shajnocz.csb>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 23 Oct 2026 17:18:33 +0800
X-Gm-Features: AclHuK8U6M4PQUlZ_r4etz76nqV6v0VPZLNSL2QXR0i9qbD81NpULTD3COxAYU0
Message-ID: <CAK3tnv+vouzXe95XJPBjHOODu4o3MYaV4jc7o3pHBG-LmD2oqQ@mail.gmail.com>
Subject: Re: [PATCH V18 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 4:23=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Sep 29, 2026 at 04:44:08PM +0800, Zhang Chen wrote:
> > @@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
> >      return true;
> >  }
> >
> > -void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
> > +void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
> > +                                 const char *holder)
> >  {
> >      IOThreadVirtQueueMappingList *node;
> >
> >      for (node =3D list; node; node =3D node->next) {
> >          IOThread *iothread =3D iothread_by_id(node->value->iothread);
> > -        object_unref(OBJECT(iothread));
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D (char *)holder,
> > +        };
> > +
> > +        iothread_unref_and_put_aio_context(iothread, &io_holder);
>
> If the `object_del iothread0` monitor command was used to delete the
> IOThread, then the object still exists but iothread_by_id() cannot look
> it up because object_unparent() has already removed it from the object
> hierarchy. That means iothread can be NULL here.
>
> Please implement bc->prepare_delete() in iothread.c to return an error
> when iothread->holders is non-NULL. This prevents `object_del` from
> unparenting the IOThread object while there are still users.
>

Thanks for catching this. I'll add bc->prepare_delete() to reject
deletion while holders remain, preventing object_del from unparenting
an IOThread that is still in use.

Thanks
Chen

