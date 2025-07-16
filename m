Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D1C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 02:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubrmQ-0005Qe-7i; Tue, 15 Jul 2025 22:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubrmO-0005Ov-BD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 22:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubrmM-0004ip-Hg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 22:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752632512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7WEqIe46EWlYaFnJXnhCuBl7R1UntjQ3+F1j9U/cSM=;
 b=BVrq0ixDxl9NIri7AGIcHGfjwcvyFuJextGhBgpsmwTP2oU6Ij3obzERBEVOD48/PT+7mM
 BpWMI3eKeTXQVSINMspTSJwkF5om2RsKrAjkmtHY7ft6Pu3BOEVFtzkehSou2ft9rsvvo/
 RnthV+Cp5hHIMLuT456zhrb64ke0lOA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-14GVjsvQPUSttjE7cJKnRQ-1; Tue, 15 Jul 2025 22:21:50 -0400
X-MC-Unique: 14GVjsvQPUSttjE7cJKnRQ-1
X-Mimecast-MFC-AGG-ID: 14GVjsvQPUSttjE7cJKnRQ_1752632509
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235196dfc50so4463975ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752632509; x=1753237309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7WEqIe46EWlYaFnJXnhCuBl7R1UntjQ3+F1j9U/cSM=;
 b=JQ/izuxyBO7gpbmzLQyJ37qBLWYJaQFtluXujU3R0DZiOFVGXvEtHX9tNoJJto3pEf
 vUYd7c0w6t8PiBb1wIHcyqU+gtHGBhBEGtw1JlvUvRndHJ/oAzTnj6V7qh2o89GbB4V6
 20Oq9gGoBd72v6Ysygps+AFzq+8/8/MDMpLF8MAMsSQj+19ij/7HfYN0zekZrhWvqhkn
 C+X3gCnSYDi7o1uZgcgPcEnxCZj+EGc1yLARwNZ5k8TcLQwHJxxtabSaawA7T4o6F2x4
 G/Ya2/bRMCOjnJ6h9GapiWoUdd5CgBd4a42XBtK/0+jNp7bwgMy9isWMw91fKjuSNg6J
 c/4Q==
X-Gm-Message-State: AOJu0Yw2uVqNeX4ZqXcqrEOHO27nwaf2mTKNxgqvozL+Atc6dyqWMvTt
 U/Bv2vVgL8iVKvKxTbRcHUa4QgAeTJxpxiobeFTRgjhTfqRPGkZxBK76S81rozZd0g7J1ROISOR
 ntCf65O5hCddSwSNXY3WpDsPk28qz3kTgiBN6OmHrrQa1cY9oav/sSyR70MjaifGJiRyXk2TtoC
 /mojvkKSjS9n3gOQQH+F+AbncZFMndyYg=
X-Gm-Gg: ASbGnctVRypQ52Pl235vWJoxBbPICpN1WQMDEnjwIp71XQzSaffnnb0OyQ6t/iK4s6T
 xP2Mg5VooKvGIjZl1JEirtPkX+KDLiJgWLUK1sSLJEa2wsAdVLwqgt8VLYue1zRB9JP/10M6tWK
 f014+vaHFWo8kwcBOricI=
X-Received: by 2002:a17:902:cec6:b0:23d:dd5b:886a with SMTP id
 d9443c01a7336-23e1a37723fmr80471135ad.0.1752632509049; 
 Tue, 15 Jul 2025 19:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqw5jMJBVssN4cDPi7MlS6WAQDq41PvIbOuT5AsMrrsN9bF5r2wVidKlq+cP25RFetwsZKUqSVtnoTTjYvVoA=
X-Received: by 2002:a17:902:cec6:b0:23d:dd5b:886a with SMTP id
 d9443c01a7336-23e1a37723fmr80470875ad.0.1752632508590; Tue, 15 Jul 2025
 19:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250714053423.10415-1-jasowang@redhat.com>
 <20250715195028.GA242340@fedora>
In-Reply-To: <20250715195028.GA242340@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Jul 2025 10:21:37 +0800
X-Gm-Features: Ac12FXzbVklErxwEwdzGIUu-N9f26R-HaKgGnJjoT4Su6Igzjux7S_2amtQNTWE
Message-ID: <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
Subject: Re: [PULL 00/13] Net patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Stefan:

On Wed, Jul 16, 2025 at 3:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for a=
ny user-visible changes.

I sent a V2 of the PULL:

https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg03794.html

That includes some enhancement of AF_XDP. Considering you've merged
V1, I wonder how to proceed.

Are you ok to include those three patches in the next pull before hard free=
ze?

Thanks


