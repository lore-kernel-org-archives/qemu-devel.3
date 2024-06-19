Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE0CC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzNM-0004VR-3m; Wed, 19 Jun 2024 13:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzNI-0004UE-K3
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1sJzNG-0006wQ-EE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718819133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djkRnvj1Z2ls6SnAhMa8vY7deyPaLvZN2MH7J+tZ/Bs=;
 b=Bu+nY0ZRih5ccdPoYkujIYRnprwAtVkZN3COut4/78fRBFcGh9X9km7A+sNFXM9/J4RNTc
 anhM7dig4l8ygp8mALTm1fqo42ZDyGorlm/c5POLNvvwoaOhOjIzKxKlqBQBNy2SFrYung
 lVWPDsr1SyVIHu1JB5TV1FPJcsWVrSU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-WQ-03nowOZu8AlJtnF1aBQ-1; Wed, 19 Jun 2024 13:45:31 -0400
X-MC-Unique: WQ-03nowOZu8AlJtnF1aBQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-63bf23f8fbcso3459497b3.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 10:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718819130; x=1719423930;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djkRnvj1Z2ls6SnAhMa8vY7deyPaLvZN2MH7J+tZ/Bs=;
 b=oOA7PVp0fdmcwOyTHrBg48NftcYSYHfO5MemSSzRxLDt0yRUtBoAAjvQrlb6rJtXcF
 XJicA3KXcv0RJmZ+BMEQvGunzVqLhxhbpF0jdwhrXxud/Z9md+EIjv/eR6Jw6qVDzlaC
 T3rppCTSat6jamWORjPip6erSckesZ+zftWySOYiZfhq/s+nF9+QTG5LvvpUltnKkXJ9
 nWAQp8qR9BUoEJiyg8HzDe6GRGbqv3Csk7vSUxq4cI3KQkf2deHV0MhCXnNQGlvo6ObC
 57TI+vM/SIbYyWwdu0PQZ0Z40Cedi/maUu7ZO3WOD8ncMndgbCpwqQjdhqMrZQzETOLD
 a0YQ==
X-Gm-Message-State: AOJu0YyBzfbuF07O2vXTQisX79wWxbTkoUQdnfY+BxvTIOTEoFaVzW0Q
 tB9EGRQfX0GGqEXs25YVKVXmySap6YJ56A8KNXjp8S6pjIZEBqO1R1DwocFsD43OigdyT2d1t5O
 /Jq1oABv14PAvc+KrS1aMp9cIIxDSVHinmFZceeGEzv5gUXZPj/hA/+4CugFoewNOGUicf9IgFz
 h9MfjmbPXOHjHXv4U4xd0NFh/prCDBluxZ20g=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr34682597b3.16.1718819130397; 
 Wed, 19 Jun 2024 10:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzUBx0nmwyx3mwY6DQYGxB+7zjxl0sFu7jLOrjhGDgkd/m0FQW0kkZ+GgNSZtAB3HZBY//nr3bYyqVcmBRCkM=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr34682437b3.16.1718819130142; Wed, 19 Jun 2024
 10:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240619174022.1298578-1-nsoffer@redhat.com>
In-Reply-To: <20240619174022.1298578-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 19 Jun 2024 20:45:13 +0300
Message-ID: <CAMRbyyuS=+jLQ4pjULxmvrusxs_Z1LRk1YhnjHiBZc41qOncZg@mail.gmail.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af8d70061b41c381"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000af8d70061b41c381
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:40=E2=80=AFPM Nir Soffer <nsoffer@redhat.com> wro=
te:

> - Need to run all block tests
>

Stale note, make check pass

--000000000000af8d70061b41c381
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 19, 2024 at 8:40=E2=80=AFPM N=
ir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com">nsoffer@redhat.com</a>&=
gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
- Need to run all block tests<br></blockquote><div><br></div><div>Stale not=
e, make check pass</div></div></div>

--000000000000af8d70061b41c381--


