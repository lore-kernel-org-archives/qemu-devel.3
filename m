Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D3D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7w7X-0000rf-Jj; Mon, 04 Nov 2024 07:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7w7W-0000rK-1d
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:23:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7w7T-00083v-Qh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730723021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+bRSgOp9ibYD55f28Gf+owCeO4wYGmYzCLyOiLBUYM=;
 b=F+miqm09TzvA4B8sog5N9EfYL6ta536xM3oguF0SrQ7SZJz4XrI9SoH98IHNEez7HX1UQp
 s2idlj9G7L/0vhRRK2PAcogf6HPLZUTDCv7YVnt3jaUKwhAcVj6RFA2fNDRBhi/eTc8DZ6
 1qUwedndOU9KwpT8aAF151JJyLzCvvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122--2Ol_TwKOtygj1X58lNz3w-1; Mon, 04 Nov 2024 07:23:40 -0500
X-MC-Unique: -2Ol_TwKOtygj1X58lNz3w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3058885f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723019; x=1731327819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+bRSgOp9ibYD55f28Gf+owCeO4wYGmYzCLyOiLBUYM=;
 b=EynXRq5bPhK9Qrsoc+jLWkU3MG3apyxxTg8cLWabvlbze/R7/Lk2UVE8HqHFJG8evc
 kwNPslonUFSc10o7+b9fFqHAv/3k8Js8xkoPsAxQYFoFxEe4olQyGrhhm1FrAjrSQ2X1
 QRe5oOHS3Fz7bL5AI7KOINSpJubaxPmGtUDOlFobqR1R2VPdzRKbd0V0ixjgu01kRi2a
 nUjGGkm9QNogFRXTPET4j+o7Yfe+eyk3mOFBNvZR2f9gSlDalp+ZJvparvnDkMdcPRKq
 OZM7PDAcboAtkmbqPA1H2CkkZ6dqKS/AQoDHie6XqRomtVe7sMYZfWsPNhdC0vkIoI5w
 AECA==
X-Gm-Message-State: AOJu0YypArHQDzmPaFYjzDMY+U4vBpwFh8eQRyDv/Wt75LRUrCoQJTHv
 XCWzvQaGC7KG3QQSDHc1Z/AqeZQDiKSz2g9b2UKVHyjdlex39vN/O/VUPh2V0uBT9cfP683v9ac
 m7b9sdf0QfclOgSb3ASptoC8d4bZd/MOG8wh8yNhqL23tYRJoWge16SPm/LWiWwdWM8QGjbv97h
 KjpWXwidN7xF/EO9Aa/CWxRbBUNZA=
X-Received: by 2002:a05:600c:4301:b0:431:4e25:fe31 with SMTP id
 5b1f17b1804b1-4328308555cmr96478275e9.12.1730723019124; 
 Mon, 04 Nov 2024 04:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1gDqEIOtaTZYycKpgy6ss5FT9jzZFnmWzeqCNlpKYgnlNfxZMudepsKwcOCgHnkytB6jdmZR0jT18MSvgwGk=
X-Received: by 2002:a05:600c:4301:b0:431:4e25:fe31 with SMTP id
 5b1f17b1804b1-4328308555cmr96478155e9.12.1730723018770; Mon, 04 Nov 2024
 04:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-4-ppandit@redhat.com>
 <ZyTnWYyHlrJUYQRB@x1n>
In-Reply-To: <ZyTnWYyHlrJUYQRB@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Nov 2024 17:53:22 +0530
Message-ID: <CAE8KmOzD3L2kO7AucYcyVEbjh-qc5H_1Xc9A2VPxT9mX_8nMGg@mail.gmail.com>
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

On Fri, 1 Nov 2024 at 20:06, Peter Xu <peterx@redhat.com> wrote:
> > -    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> > +    return s->capabilities[MIGRATION_CAPABILITY_MULTIFD]
> > +            && !migration_in_postcopy();
> >  }
>
> We need to keep this as-is.. I'm afraid.
> You can always do proper check with multifd & !postcopy in your use cases.

* Above change simplifies it a lot. Separate checks as
migrate_multifd() && !migration_in_postcopy() make it more complicated
to follow, because migrate_multifd() is often combined with other
checks like migrate_multifd_flush, or migrate_mapped_ram etc. I was
hoping to avoid adding one more check to those conditionals. Also,
with the above change we don't have to explicitly check where to add
!migration_in_postcopy() check.

* Will try to separate them.

Thank you.
---
  - Prasad


