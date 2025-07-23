Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F580C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 12:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueYvo-0007bb-9O; Wed, 23 Jul 2025 08:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYtV-0005pp-0K
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1ueYtR-0008RL-GN
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 08:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753274898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1i5IYAi4xXFAbKLvrwQqGMewRtXbUCz3RUpoxhp2io=;
 b=Aw3r+MSDgSf9KNaE60eMb+tW1of17C27W0gDyX2VGwAtIUMtjdB4qBcOnJmlfO96tCJhz+
 UWBrJBsl8e98W4NAlwtjnOG9F5yBYzeioZ6I7YjX8bVi9qJ36mqrLBpHCj2eRZvhV8aCaX
 K9NQS99M3k8A9K9QEewPqLTlEBjCAus=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-entDNuirOTyvAxm-1Wd99Q-1; Wed, 23 Jul 2025 08:48:16 -0400
X-MC-Unique: entDNuirOTyvAxm-1Wd99Q-1
X-Mimecast-MFC-AGG-ID: entDNuirOTyvAxm-1Wd99Q_1753274896
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311a6b43ed7so5152011a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 05:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274895; x=1753879695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1i5IYAi4xXFAbKLvrwQqGMewRtXbUCz3RUpoxhp2io=;
 b=EHYsx5G1eBYPtJvSnLu59WWEcUvZH9XBhhdBshM1l8Z6tYu3/JQQU+7XYzkOuqjjs7
 BHk04N+33hvCitERbnU12hd537fiJHHsvKpGGD5iXSTORbaJ7xxcHShkUUlgslleUwY1
 XCd2iLMVMvsoQNFoxj60DtSPxRaQnXb2/6369zGetx2OD7n5XHzEhAmXXNuwJ6DEKuI4
 xWgvw/dLFbvwX3YwVf5xyosIttAGzklG8l4igMZW2ETBG/89L+FL2FsBS8vIpG2FPGMh
 Vc0qrdxutVm9iztabZAILnDoOdS1cy9nm8FoCcGyhTOniWLHwd1rYnygVkzj4WhX2cAS
 ix4Q==
X-Gm-Message-State: AOJu0YzMH74/bZQt5g6uwh6kpZbSORPFh90XsKWBqDe7LeafAD0qK+V4
 iNsYBjsAu/MPgio+4+batjHNLeABZpDiSYSJMqC9OrdmkTdiAgKBukQ1veHXKu8hntxgaXkAJ44
 nL+wsxpEUAfSK+sFRhMyCH1LF3l9TYXwMqXEv+saNMeV4Q7/Il2ual2NWIVTtq+wRiHaRvukfuA
 K0Q3PD6NPJBERFQoXn3/afquBwBUC6Y1X3ztps6rI=
X-Gm-Gg: ASbGnctLjsg+My676Rs7FnqYm+/AUcfb6+IQQNJ2MzjEvc1gbTMS8cwP/M1aRIRw2ew
 aewbc8+amvq70wx7Iw86nHloaKPeeM5KAsq0yqqtuqxHeYgBy6CXQUHBP2jmmBmpwgFbjoxurGg
 4ZOHQBZrmb/dMqaoFTxHot
X-Received: by 2002:a17:90b:384c:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-31e50818ad9mr4793523a91.18.1753274895134; 
 Wed, 23 Jul 2025 05:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvM8rJiO9PBoQqGRrtF3HnuoYwwaI4iuvx0sosSBPx82ARpVrRfpvdNB3XJ27oBQAEYfBgPDbR5IBcA9+aUKU=
X-Received: by 2002:a17:90b:384c:b0:311:af8c:51cd with SMTP id
 98e67ed59e1d1-31e50818ad9mr4793490a91.18.1753274894724; Wed, 23 Jul 2025
 05:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250723121920.1184928-1-aesteve@redhat.com>
 <98df482d-c75a-46e7-8c39-5aa26eaf1700@redhat.com>
In-Reply-To: <98df482d-c75a-46e7-8c39-5aa26eaf1700@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 23 Jul 2025 14:48:02 +0200
X-Gm-Features: Ac12FXxtGLKIZrNbPLAJ8nUn1kllGmOuajs_IKzpQD6Fz6qf0BYT5xUsLtYxQQ8
Message-ID: <CADSE00KkhKKQBSk_iLo4xCkPRcWQqUUumD_xsNDOk_YoSDoNeQ@mail.gmail.com>
Subject: Re: [RFC] memory.c: improve refcounting for RAM vs MMIO regions
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 23, 2025 at 2:43=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 23.07.25 14:19, Albert Esteve wrote:
> > In the last version of the SHMEM MAP/UNMAP [1] there was a
> > comment [2] from Stefan about the lifecycle of the memory
> > regions.
> >
> > After some discussion, David Hildenbrand proposed
> > to detect RAM regions and handle refcounting differently
> > to clear the initial concern. This RFC patch is
> > meant for gathering feedback from others
> > (i.e., Paolo Bonzini and Peter Xu).
> >
> > [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D4601=
21
> > [2] https://patchwork.ozlabs.org/comment/3528600/
> >
> > ---
> >
> > This patch enhances memory_region_ref() and memory_region_unref()
> > to handle RAM and MMIO memory regions differently, improving
> > reference counting semantics.
> >
> > RAM regions now reference/unreference the memory region object
> > itself, while MMIO continue to reference/unreference the owner
> > device as before.
> >
> > An additional qtest has been added to stress the memory
> > lifecycle. All tests pass as these changes keep backward
> > compatibility (prior behaviour is kept for MMIO regions).
> >
> > Signed-off-by: David Hildenbrand <david@redhat.com >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   system/memory.c            | 22 +++++++++++++----
> >   tests/qtest/ivshmem-test.c | 50 +++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 67 insertions(+), 5 deletions(-)
>
> Did we discuss extending the doc as well, to clarify which scenario is
> now supported?

Not that I remember? But it is a good idea. I will update the docs for
the next version of this patch.

>
> --
> Cheers,
>
> David / dhildenb
>


