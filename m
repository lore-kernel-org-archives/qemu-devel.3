Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F9BC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqQN-00065J-Br; Fri, 02 Aug 2024 07:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqQL-0005yD-3B
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:26:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sZqQJ-0008Bg-7t
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:26:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc65329979so69222005ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722597973; x=1723202773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/C+cJKFO0bt1DxPTWKksyVN3fKJ+x+Sxy6ZVWA4ZsyI=;
 b=h4KvvSZCC8G782Rj2+41WAkh0ER+zmJy/f055moU+lFw3NfGydbeerlMneVboaatL4
 bHygt2Sx4+kqz0e9erDiOBmiVk3W98rT9buEOKvEmSp36ylabPdQDuhlw0FETqMut76s
 unG8OFj9arxejNyZWo228vKyXgwej/YstY/U6cqMjXDPQnrWWHTskMIWnrw9c9amvURF
 057W0ZI3Gsz55i9Hrr9SFDcljnDb6laoG+ftKhOIN9YNoIQ8efIprezgtsxgFqeWuSNE
 ZxTSUlMsRHDcBDK8iuwzF71gly31k8lH1isuA+tmGRrHBjBTeSuXsQrfkELKjgb4ZM4v
 yRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597973; x=1723202773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/C+cJKFO0bt1DxPTWKksyVN3fKJ+x+Sxy6ZVWA4ZsyI=;
 b=r537Kg8AspyzTIPy6aSedjjPSYC3nd7WAm3ALN58aqNt52SjGjCk0NhN1U1TEDK5hA
 XYo1mP0a4v7GQxNPyTbFJB+dzFDNiNvkDrB/4M9ezo/InP+5beoSnxis1ChN7lz1158D
 9yidTIkpydX55XTdOEIiPY3EyQPKJUf4tLBhi+C1HptIHRjAVo8GbegvIA7BvmUWebUJ
 XZGAF5jsh6lVFklS9c/guT48sDIrOnc0W243b+ZA8P6q2YnqBxmxSl18Er+i8uBtnmVG
 2l2xNWP6h9TJytdZlDRugjBkqImkjtjorBTlMhVhcan1nC/c53GEb1Pw63860nOHMjTc
 SWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYBe709gkTUyPObY1Wp24yBJHw0vHfDfaImowOAdkSqI9Co1YOsNKiQ43lneKZieE+bfNKSUiIcvvKD1u37saH+LeeuEE=
X-Gm-Message-State: AOJu0Ywp3qeBPNMhyfwt5g+C8G3dIkDAsP1LKMyhCtNZLVmnyFsgryoN
 iTP8rnxmWkHKYuW6tjmjzYtW/k3gOwA4lfwdkEhoPKektvL9O4ue
X-Google-Smtp-Source: AGHT+IED+BHIb8D+EACtwViwnaxvlnYmXd2IlxbRar5PRp2oo/VLqoHD4Rcq6XITdNOhlb2GRGU3dg==
X-Received: by 2002:a17:902:f685:b0:1fc:719c:5f0 with SMTP id
 d9443c01a7336-1ff573e75a3mr44704375ad.49.1722597973274; 
 Fri, 02 Aug 2024 04:26:13 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.85.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905ee07sm14910415ad.153.2024.08.02.04.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:26:12 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v2 1/3] vhost: Introduce packed vq and add buffer elements
Date: Fri, 02 Aug 2024 16:56:03 +0530
Message-ID: <12491035.O9o76ZdvQC@valdaarhun>
In-Reply-To: <CAJaqyWd4Ts-JMofDeZ4Uv8Azdi3s_NaYmATd7ezJxwMG+HiPUw@mail.gmail.com>
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <2957475.e9J7NaK4W3@valdaarhun>
 <CAJaqyWd4Ts-JMofDeZ4Uv8Azdi3s_NaYmATd7ezJxwMG+HiPUw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Monday, July 29, 2024 1:51:27=E2=80=AFPM GMT+5:30 Eugenio Perez Martin w=
rote:
> On Sun, Jul 28, 2024 at 7:37=E2=80=AFPM Sahil <icegambit91@gmail.com> wro=
te:
> > [...]
> > > > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > > > +                                const struct iovec *out_sg, size_t=
 out_num,
> > > > +                                const struct iovec *in_sg, size_t =
in_num,
> > > > +                                unsigned *head)
> > > > +{
> > > > +    bool ok;
> > > > +    uint16_t head_flags =3D 0;
> > > > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> > > > +
> > > > +    *head =3D svq->vring_packed.next_avail_idx;
> > > > +
> > > > +    /* We need some descriptors here */
> > > > +    if (unlikely(!out_num && !in_num)) {
> > > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > > +                      "Guest provided element with no descriptors"=
);
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    uint16_t id, curr, i;
> > > > +    unsigned n;
> > > > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.de=
sc;
> > > > +
> > > > +    i =3D *head;
> > > > +    id =3D svq->free_head;
> > > > +    curr =3D id;
> > > > +
> > > > +    size_t num =3D out_num + in_num;
> > > > +
> > > > +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
> > > > +    if (unlikely(!ok)) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_=
num);
> > > > +    if (unlikely(!ok)) {
> > > > +        return false;
> > > > +    }
> > > > +
> > >=20
> > > (sorry I missed this from the RFC v1) I think all of the above should
> > > be in the caller, isn't it? It is duplicated with split.
> >=20
> > I don't think this will be straightforward. While they perform the same
> > logical step in both cases, their implementation is a little different.
> > For example, the "sgs" pointer is created a little differently in both
> > cases.
>=20
> Do you mean because MAX() vs in_num+out_num? It is ok to convert both
> to the latter.
>=20
> > The parameters to
> > "vhost_svq_translate_addr" is also a little different. I think if they =
are
> > moved to the caller, they will be in both "svq->is_packed" branches (in
> > "vhost_svq_add").
> I don't see any difference apart from calling it with in and out sgs
> separately or calling it for all of the array, am I missing something?
>=20

I tried refactoring this and have sent a new patch series. Please let me
know if I have missed something.

Thanks,
Sahil



