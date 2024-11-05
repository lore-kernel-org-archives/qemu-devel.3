Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FB6D12674
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8GDa-0005JW-9b; Tue, 05 Nov 2024 04:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8GDY-0005JJ-NV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:51:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8GDX-00072h-26
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730800277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4j+gfizJjFo7h8dw5lIT/tbppopu2Z2VbLhi5swEhws=;
 b=fGNUYVwiTK99fjNoNRh1CQlDn3aa5cvOx8bMUiRfIDU/A7uCEtlXU5SgK02W1n+6uNccwu
 a9mmi8qrX5aMGNhlv6Jl/C70O/vRYmaVAPC+99ej+iy/64bkpHOWWGvnIP91dE18EEq2j3
 tkmDW7NWq3VxhY2SSvf61PDLSrgox4s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-NoM3_DJ3MP-b2NwWJt_VZA-1; Tue, 05 Nov 2024 04:51:15 -0500
X-MC-Unique: NoM3_DJ3MP-b2NwWJt_VZA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso37105645e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730800274; x=1731405074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4j+gfizJjFo7h8dw5lIT/tbppopu2Z2VbLhi5swEhws=;
 b=BG3/2Xc4oZVxZs3Nrh+wujNNErL7xJkV9AkvhSj7+AmF23Kaev5fKLxUrhI8SihMpq
 tml7//Sunks7FQ6cBSDJ4ghcYUFfRTcPsr8sBjZgBuN3PstZh4ooZIKbpp4cJWKLK3C7
 lf/RRbgYlop8bJ+RAdSatLfUQqXrj4CtfT/35y/TiacQOXjtwqG/P5Z3rEJggeo2SFem
 fjgDyJcLKznslbFrXwERPmHPzY6FMT+AJmoX5r0binb9bdQAr4iHcZGt+y84MrINvGED
 ChK91sMBTd4sQukWxhSr3Rpg5TMdI2pApMl8pmKobAIRV4WO/TGsFMb+VrLusGjl2Dyp
 tAng==
X-Gm-Message-State: AOJu0Yw6jDLlZc+Y2Z/hKxet2m8JD90BBlI3dNjG5TAl4R7sVSkhZYqJ
 /WX3AT6PlrWnUxUeIX2v8Iilhou8J0qy1GjJhQ88IK6gvVnFmwBZAYu/OpIPKujwNivGfr+6BTg
 SBpru0tCR5j2MTiodotCJqk3Xf7VGSG80dBBFZvzlAhs3c0TWb3pQb9arsyfyiv3/UI0kNEIVus
 omo6n129hRyFq6deCnHqtx8OlpGys=
X-Received: by 2002:a05:600c:4511:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4327b6f953dmr162014335e9.8.1730800273898; 
 Tue, 05 Nov 2024 01:51:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDHka4/05/zFkRe3vLPFOGvTuXVUOxDeO0HtsVPmn1sZfwp01MkK/lnysgx8yDmdAJGNBAbiV9kLz2zJfj4lI=
X-Received: by 2002:a05:600c:4511:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4327b6f953dmr162014185e9.8.1730800273614; Tue, 05 Nov 2024
 01:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-4-ppandit@redhat.com>
 <ZyTnWYyHlrJUYQRB@x1n>
 <CAE8KmOzD3L2kO7AucYcyVEbjh-qc5H_1Xc9A2VPxT9mX_8nMGg@mail.gmail.com>
 <Zyj76Olcwtfs4ndt@x1n>
In-Reply-To: <Zyj76Olcwtfs4ndt@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Nov 2024 15:20:57 +0530
Message-ID: <CAE8KmOxiPRWGHyGBgjjg1==BuPQBRm9vbttDPoAAFsmZGhUobw@mail.gmail.com>
Subject: Re: [PATCH 3/5] migration: remove multifd check with postcopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 4 Nov 2024 at 22:23, Peter Xu <peterx@redhat.com> wrote:
> We definitely need a helper like this to simply detect what the user chose
> on the feature.
>
> You can still introduce a new helper, e.g. migrate_multifd_precopy(), if
> that simplifies the code.

Okay. Thank you.
---
  - Prasad


