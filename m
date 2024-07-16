Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E2C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfDQ-0004nv-Ou; Tue, 16 Jul 2024 06:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTfDM-0004nA-SO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTfDJ-00060U-VQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721124914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0njENZQPQiFEtWR5OrUYIMAkmtiD62XOlemDsVtllj8=;
 b=gVwms3WKlnUd7+QTss5Qu77gI/pzMgq1Rq79+DH1XeN5VUFJzWsM30pEgx+ZNH/KAPM2fz
 MZrD4cYmDxZy7zWZOW6yLioqGnTGsciCT5m3aIHpqC9bArs6K7ffIo1RASiAsTgHJiHZNi
 ZLBQ4KqkmB+o8RFtIMLyXKFiTo3MFa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-WWTm7rA6OQaQWdgTYWLMYw-1; Tue, 16 Jul 2024 06:15:12 -0400
X-MC-Unique: WWTm7rA6OQaQWdgTYWLMYw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42668699453so50099835e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721124911; x=1721729711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0njENZQPQiFEtWR5OrUYIMAkmtiD62XOlemDsVtllj8=;
 b=kyFtv5pTrNrN9v0SgxOfPaFqOEyMvGnDRhgJ22DuhYhN87Vx2heVrbQZCpExHlMsun
 8VZTKZc4jH1ijji22XumDkI7c9nj6NrliQzeDEo+z0T42YvL5+DHU2neRBJ8YAZJ/XNi
 K2Uy5JbBmxUsxooubgJNI/WkbJcZ3+zMjXWgcXqNZeP0za8ZZt3vnNw34Y8N884WFYuK
 39EPYepuR9HlcoRCm2/OdbT7N5qz1ktyXnyVlnXCXy2EjJvXFup+BV8gmiOQpEzqryOn
 +uYYLLw/HKjrB6BwhZRGGdM0V5r47ln5jub2uAMxalZB/WOzEY37GrkQEB8EjwH3fKmt
 YTNQ==
X-Gm-Message-State: AOJu0YzcAVSGZ4WUAjRegroX0rSIjCBO9gfDpfsubstZFbmw92GfrI9n
 46puDIr42eXuT1jtGraGht1tJwRzaFW76FcTIuv0r6NRfzicUFLcyhUrHkPz43peVmO9NiWEHXZ
 FoWGJh9QMQHuXcT/Gm9XlXbkDPLvB/mntY3O4GZaC2Amc1a488Mii11jWmhpc+SCiIzJ2ITNVXB
 vR6CdmagF1wrMkDtvw4wNikC6Ksco=
X-Received: by 2002:a05:600c:1e14:b0:426:58cb:8ca4 with SMTP id
 5b1f17b1804b1-427ba720da7mr12914115e9.37.1721124911552; 
 Tue, 16 Jul 2024 03:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwqdb3z8jrtZBFAqcPQulCKJJwx/cIyqqBQLzLohF+lsEdAjCytLECZTJwHgTNgAccRXGTN2ZLfHpY4ytrPTU=
X-Received: by 2002:a05:600c:1e14:b0:426:58cb:8ca4 with SMTP id
 5b1f17b1804b1-427ba720da7mr12913925e9.37.1721124911242; Tue, 16 Jul 2024
 03:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
In-Reply-To: <ZpUmrTrEnx0RcO2y@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 16 Jul 2024 15:44:54 +0530
Message-ID: <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Peter,

On Mon, 15 Jul 2024 at 19:10, Peter Xu <peterx@redhat.com> wrote:
> IMHO it's better we debug and fix all the issues before merging this one,
> otherwise we may overlook something.

* Well we don't know where the issue is, not sure where the fix may go
in, ex. if the issue turns out to be how virsh(1) invokes
migrate-postcopy, fix may go in virsh(1). Patches in this series
anyway don't help to fix the migration convergence issue, so they
could be reviewed independently I guess.

> You could pass over the patch to whoever going to debug this, so it will be included in the whole set to be
> posted when the bug is completely fixed.

* Yes, this patch series is linked there.

> The protocol should have no restriction on the thread model of a front-end.
> It only describes the wire protocol.
>
> IIUC the protocol was designed to be serialized by nature (where there's no
> request ID, so we can't match reply to any of the previous response), then
> the front-end can manage the threads well to serialize all the requests,
> like using this rwlock.

* I see, okay. The simple protocol definition seems to indicate that
it is meant for one front-end/back-end pair. If we are dividing the
front-end across multiple threads, maybe we need a document to
describe those threads and how they work, at least for the QEMU
(front-end) side. Because the back-end could be a non-QEMU process, we
can not do much there. (just thinking)

Thank you.
---
  - Prasad


