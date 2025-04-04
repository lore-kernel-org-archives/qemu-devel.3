Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5124C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0dhu-00067S-20; Fri, 04 Apr 2025 05:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0dhs-00066y-G6
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0dhq-00041q-WE
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743760282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xV9hHN/es+KaB/F65Rpqefn2zs1rfJzqe3qGPx9o1wE=;
 b=FQAvwCN3NTxJ3diTL8U8TtVMMyMqDuYSrXCXs8rYJPo3UnWqhUhrnfLzdBolgvYlPYFPyC
 /1i6k3hJiUZ9bib/PhFC7T4eFgXPJ6v90KXgTnH1MaDjruTVE35vT1iI7dfNsamSCQLn70
 uZgks2B2PU8lTC1E6zCDh+1r715BRrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-KnmdAP6GMrysE8cW7IIUXw-1; Fri, 04 Apr 2025 05:51:16 -0400
X-MC-Unique: KnmdAP6GMrysE8cW7IIUXw-1
X-Mimecast-MFC-AGG-ID: KnmdAP6GMrysE8cW7IIUXw_1743760275
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so14991065e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743760275; x=1744365075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xV9hHN/es+KaB/F65Rpqefn2zs1rfJzqe3qGPx9o1wE=;
 b=FLXbIiEGrr1X4GdvvywTO5SjBWWzMvLXsEWYR5Jkbva9C9OZh2gcPZmhEUykfwWqYA
 hjkcabtuch9wqVBzfM30uQpSz0M0xllnWhR/VCoz2FSg/hcjHgQmT+vHedoZiJc9MPSq
 v8nN1hNhEH/21WV9b9EeR7Xfx6DrGBMC9184R10u9rqVP4EwAeP5pOKDEVsCHgfb0f19
 YwaU3tXPIfdqUKKbL/k/gkd61kqekkh7RyLuBSzZDJ84/uMynm6WQ5vDFXTPYnv3EApS
 oztrmlgqRzDiT//XxOAXK+REvpfX1woxSPjO1e8hfReTreyG9Ak3qI1080Bf5CNRiNwQ
 q/gw==
X-Gm-Message-State: AOJu0YwkuCVc2d6q2x6MaRz4OAZ1F53qV57Zx88IgR3MSKpbDqxG2EdC
 yQTef337IDclo+bHhF5XPlaML6crJLC1TIYwmv2aPksIamZrZCBpi5ijHlpZDKRud9L38e3F91m
 Ya/XL11OxMOfrmK0h/4T5sqRSXu3LMhXqIMdq7vAsr3B1uEpnrMB8RLPArs/PAtKkoyQ7pDkTsc
 lVtIn1dcSuWiAjnc36L+3kyv/weZI=
X-Gm-Gg: ASbGnctMgIlDy1q78HpeuQXZWJ1Wfp5Fd+b6bq8qbJVRZGw9P337d4uDGvOrm6ylKJX
 KbIlCiwufXTsmGGK7ICddx9UmSOjzZcvo2dRtyxOGa72DKZu6KhCZPdWyaOiMO66+4Q0qfAdSNE
 U=
X-Received: by 2002:a05:600c:4fd3:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43ed0bf6a48mr20814745e9.10.1743760274794; 
 Fri, 04 Apr 2025 02:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW0wwnTzpeaT/N+bAms1iJt5QkfkU2nWa3CfeedgWFs41jgr9lPCzwnfP+xYhdi0jIH+SDk5oZ195XT6r7+AE=
X-Received: by 2002:a05:600c:4fd3:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43ed0bf6a48mr20814565e9.10.1743760274531; Fri, 04 Apr 2025
 02:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-8-ppandit@redhat.com>
 <87semtkz32.fsf@suse.de>
 <CAE8KmOwiFtQHpUWJE9aYcH2e8__nBjD8rp5vnWCd66wjy7e90Q@mail.gmail.com>
 <8734epl7gm.fsf@suse.de>
In-Reply-To: <8734epl7gm.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 4 Apr 2025 15:20:57 +0530
X-Gm-Features: ATxdqUGR6hkqa8k0Hhmn_GU1J0ps8pO6AyyC9Q_RueHriaQl53b-H9gg-vhUtlM
Message-ID: <CAE8KmOxQk=id-e79oBW4WdUs_xeFs16FhNe1wSa7-=z02emoPQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] migration/ram: Implement save_postcopy_prepare()
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 3 Apr 2025 at 18:37, Fabiano Rosas <farosas@suse.de> wrote:
> The code assumes some understanding of the multifd sync in general. It
> doesn't help that we don't have a high level documentation for that
> (yet). If you think the comments at the MultiFDSyncReq are not enough,
> feel free to propose a separate patch adding documentation to
> multifd_ram_flush_and_sync().

Okay, will check. Thank you.
---
  - Prasad


