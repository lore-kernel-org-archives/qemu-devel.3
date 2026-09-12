Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B3CC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5IjX-0000CS-PL; Sat, 12 Sep 2026 04:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1x5IjW-0000CF-An
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 04:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1x5IjU-0004Nv-5V
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 04:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789200306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWOpEMtyc7ys5hSccd3XRpJe/0cX57xz8+3xEDnf6QU=;
 b=aI8DRuqIcgIYURbayVPG2wTpS9qPHGzCtY3PULSbkOoYdgYe6Tj9CvpEEwtrV9IZltovMf
 1V0cgqTQRcoYyWH2XvnxM2OmFgNMbf4F7tUSZQhGu01Z9kcDvBjTbLXTuGLXiqDFu3JGuu
 Qn/p6NrS9JkoywNmo73AEWwP7cpKAcw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-KyqsBKgENWK29J0nybrB8A-1; Sat, 12 Sep 2026 04:03:58 -0400
X-MC-Unique: KyqsBKgENWK29J0nybrB8A-1
X-Mimecast-MFC-AGG-ID: KyqsBKgENWK29J0nybrB8A_1789200237
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso11021665e9.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 01:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789200237; cv=none;
 d=google.com; s=arc-20260327;
 b=hHgwVG+U1D+92sAydwRp1mIHbv/9aIEy7x43OH7rGbrSM3283EtCeIpB4VIxKKauPU
 c928VRcZ3d+Xybcv1CGP35gvvU5I01k7807BI6WmOD8/+J0dnrb1mUTMn5zGnhhY383q
 AVW5XKdSpiE1Vihxu8ClbRRZKkeumuu9aBxTy+AOoJ7c0oWCsYanz/ESKg6uGae0Pkss
 Vqsg45MuxsS6hHHQogT7vQpx6tX7w9oQOiZHkFeNT96X6hDQok5nC1qQ/2rzMFn5yvjc
 l3kmPsFJSAnkWgRpihoVOOMtwK23YdjCkqn4yKPTz/iiBtTDBn/uOW5n12elEowp54Yd
 KAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QWOpEMtyc7ys5hSccd3XRpJe/0cX57xz8+3xEDnf6QU=;
 fh=iPwK82NXGEL0a9PC/d/4gZhcKFUIFvm1H78DuVI+9UY=;
 b=Suj50uUOD8Rr0Go9pRpWzwmtQ3tZNRjopMYio7n0or3h9nH7zf9dlBP4cm12srLBe1
 X3zX4PCndfozLCkCjTYciHXTPCtY2xLblVmZS1GUSHj7Vg0dA6/Tz+EtkEcgwXJMqkVC
 NP2LhfGMP6xNOyRLRd/Qijbcrq/eXJ92KbJWDy1IBD4ARQpUgfymYjz/IiQtJKO8qQmE
 8ea9fcSBojlBXhNAIbOt9NBGj7sqPqTL8Rk+zfs5//1TPwN2zURn9maA+Yvhykhb5mA8
 SbgoHgcRBWG5oYCKrPloHatVTAgkBjOUezEqdutjJsUT/lnzgchO7VCTVpEJmwS2R/+K
 xV4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789200237; x=1789805037; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QWOpEMtyc7ys5hSccd3XRpJe/0cX57xz8+3xEDnf6QU=;
 b=qKuWuw/f0zFSv6jw3l/MKpFptfpQW1q1mF43aX/wNdjGLvWmIx9hkza5iNYABhrbVT
 PQ5GjfqPy2hyc0e98gtO/nE6FoyhDIPOHzGWfs4QY/TFu4upurZWM7HgI3gCQAeBoa5M
 lHgiO+nlD6YXjwwTEyYUDKa9p/SykilieZQBaY0SB/7GOCxGx+r/zJWruQIGlhf+o7l7
 tGo1HDau1PvEEfKZVTgpL5c4o2bS9Vot1Psf1EYq9rAIuLBaMz5lP8fAgue8pPcXOM0c
 COxziF7bJJKCamoKmSfs/eqcDwsTsze72FwcYNejz9Gl/sgH6CZDBOkFdQVH+Suy6XIw
 RvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200237; x=1789805037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QWOpEMtyc7ys5hSccd3XRpJe/0cX57xz8+3xEDnf6QU=;
 b=PrqBs5+9pB9fKXQfJapUQgoDT9lIB5hNR01qlGCnmaQcvcX7DfJYKLlOVHZa6+YXcP
 jMToEZyPOn7bm+oeFa2q83F5OyjK9QLU/MJb53F4j5/RtUNSrKHns3+EXVCQGdptnP5c
 VqdTs21Zw5cvLBc5RPSFtKaDaXPT7Janjo1nqupvM1GFXrmVkR5VA/2pnds3Sb6IBHXV
 FEe1oemrdaSPfopmr3HhH/V/BTTyGVyy3VN0ONjWg5wpBHj4pPB6cqOZnhR8Vi9pr8s7
 YSGu8XNk76FGI+SpfqgzNrCKpoGbSZVoGWN8yDMv1u2VvpA6hKQaol3zGD2OlPhedlWq
 pf5g==
X-Gm-Message-State: AFuF++k8TPs3lXhJIciWQncblsLvK4zoYMpe3SDV/Mk/sTh843nIczV5
 vpI1Ns2jLeWcWSNJVIA48Y1dQ6tiaBH5IuEkLDwFQMrQ8kUqx4x4321pmt8G32ttUpfKHSC0taP
 MlwRioCfnLwgxtewYfkBnmph5jY5dbCn1AWOBCyOSx9sSwFi6XF4flNyFNgRQCDeYSk1k+nnj+k
 Z6DDRMIo/rYnod6nnHSCxbQ1HC4lymF4I=
X-Gm-Gg: AYBFou2RKBh0O2KiM43tec9iWCVTd8OKpVZxetgIWTTFcIyDOtQp/In54Z/3IPu5Avt
 Jm/eAVn6tFGt6o52t2/tfYh+Q5vfQvk1yz7ohHr70zawoT/NkS2tWBnjzdA6rfsnAhXi7hJKl5s
 WikAZk9njZ1kuf1fzyhRHSmphvS/fMgq3gtJgQFDMFBHIBnYE5J3gKgwlBLRNDgkkIlNeIn43/j
 2FiG30MuctePCcwvdlQWmdwk98LUC6wMOKMZTJmwwMiBxMo
X-Received: by 2002:a05:600c:4583:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49e619e148fmr89093355e9.31.1789200236901; 
 Sat, 12 Sep 2026 01:03:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4583:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49e619e148fmr89093045e9.31.1789200236523; Sat, 12 Sep 2026
 01:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260912045350.2139416-1-armbru@redhat.com>
In-Reply-To: <20260912045350.2139416-1-armbru@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sat, 12 Sep 2026 13:33:39 +0530
X-Gm-Features: AcwNN1X12aBQ4cQpI72TLCFHEYIwAR1EJXyDdOEhiBxaW3SNBahicGwVreLdMR8
Message-ID: <CAE8KmOzqxBODH9zzehLYuCQFtP8s4UdzLYU+xfW77CY1D=XQ3A@mail.gmail.com>
Subject: Re: [PATCH] qapi/migration: Make migration parameter @local
 consistently unstable
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, peterx@redhat.com, 
 farosas@suse.de, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 12 Sept 2026 at 10:25, Markus Armbruster <armbru@redhat.com> wrote:
> @local is unstable in MigrationParameters, but not in
> MigrationParameter.  Fix the latter.
>
> Fixes: c9affb8e9b (qapi: add local migration parameter)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/migration.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f7628b55e9..9a1cc7c4e5 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -804,8 +804,8 @@
>  #
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
> -#     @x-vcpu-dirty-limit-period are experimental.
> +# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
> +#     and @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -831,7 +831,7 @@
>             'direct-io',
>             { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>             'cpr-exec-command',
> -           'local'] }
> +           { 'name': 'local', 'features': [ 'unstable' ] } ] }

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


