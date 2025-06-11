Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB90C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPElM-0005iF-Ec; Wed, 11 Jun 2025 02:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPEky-0005a7-Fa
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uPEkw-0007s3-KZ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749622571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDJEwk/kVYrzRvv1cD8oGHc2ljTA0M3cMi5yRig7Xbs=;
 b=R+PvnHWNCMPNre1CD6/e0UZ9iiAomS5zjWu3tlgZZ6MqtSKC1LMBI2uGtzTRySJU3Ma0yx
 XrtN8w6SotD0JYK2a3tF/YAlT593xysHOekhMaGBAN/hWrblJzu5tf/iAsuTvPocZxBM9h
 YTj49sV7K6AvMB+jpl92sd3cIZPRLQg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-C5Zpj_3mO3aJB8e2ENl9Ig-1; Wed, 11 Jun 2025 02:16:09 -0400
X-MC-Unique: C5Zpj_3mO3aJB8e2ENl9Ig-1
X-Mimecast-MFC-AGG-ID: C5Zpj_3mO3aJB8e2ENl9Ig_1749622567
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-32a74099591so33016231fa.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 23:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749622567; x=1750227367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDJEwk/kVYrzRvv1cD8oGHc2ljTA0M3cMi5yRig7Xbs=;
 b=GLrrcDcNRy1lsTn/Zyik+yZNs9jG4cmm6kyNTb3MfPP/MU9YuBFogiKmYvHa/7BwK/
 beJNw/Q0J7xlirfY15Kq5oVllQ/5Wal41Y6kR3BaOuDqz+e6lVO6RMrL1SaMMjFcLs41
 hvpA9VcSng7+qmdoBMiDsGoIClz9QBhQ/9KHLC//SXO4mfSt6L07df1Qw4HMI1tENyif
 GJz1TlnT//50ijffmVBkhV4hkuTTddopegqEg+oaPHZ1Q8TrlbzbGptARpKz53s3uAIe
 qr4jzj/I4hDqMyeatQvoAXsNLmB2UbU4Fe6voomCBXVATaffyDkGpSjzOnrYf+YbAc2C
 LX7g==
X-Gm-Message-State: AOJu0Yz+tMqlN74EKllQu3hh2TlbjxR1vDqf8DF5B+cFzfnoRZylOHk6
 Zau6yZ8clioty9jIVpKXn54skPAz1YSDtKedAi4oAV4FDwHeXMOWG6swC9HsJ+At1/bV6xmDPut
 pT9hsC95SpFQF/86zsCzVXya9BZ8vk03XHNL27VLy5TotYyZanRO94wMv0XcTLpXYvqFA9FzyFk
 lkQaGxM1W6W9vVxUi5nrCDCZXvQsLUhP0=
X-Gm-Gg: ASbGncspqwmuBs5VpUgOLEimru8KT9D5bqCpKO1UpYROpfLrhMoZ5edA7OilQ83cyU9
 Udko9p34j6CG6/lq6ItkwM/M4seuehbct/XrcUivV8TwcQJ9fHm1Jzvxy9LaQiAxqI0NxQHhtSO
 NIxl8=
X-Received: by 2002:a2e:a585:0:b0:32a:6ccf:a45c with SMTP id
 38308e7fff4ca-32b21d71ca4mr4873161fa.39.1749622566812; 
 Tue, 10 Jun 2025 23:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETCpW14bWGaExhRoPXqPahyhYQAVVScPySReswuw6kMiKsnBE4x61QmW8N54QelqjKgaSTV0cmn92GruaXbTM=
X-Received: by 2002:a2e:a585:0:b0:32a:6ccf:a45c with SMTP id
 38308e7fff4ca-32b21d71ca4mr4873091fa.39.1749622566395; Tue, 10 Jun 2025
 23:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250609161855.6603-1-peterx@redhat.com>
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Wed, 11 Jun 2025 08:15:55 +0200
X-Gm-Features: AX0GCFs5TLV24Knt4eptwFDKKb7LyBi5qPA9KV-9nj8BF4IOlJuVE5mj8O87cpU
Message-ID: <CAMXpfWtGPUDGtn40tkZYNMhntp48BbMRHnZqQkrBKokyMyEXyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] migration: Some enhancements and cleanups for
 10.1
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series has been successfully tested. The information displayed
from the HMP info migrate command is more user-friendly, with the
possibility of displaying the globals with info migrate -a.
(qemu) info migrate -a
Status: active
Sockets: [
tcp::::8888
]
Globals:
  store-global-state: on
  only-migratable: off
  send-configuration: on
  send-section-footer: on
  send-switchover-start: on
  clear-bitmap-shift: 18

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Mon, Jun 9, 2025 at 6:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> v2:
> - Collected R-bs
> - Avoid using "\b" in HMP dumps [Markus, Dave]
>
> The series is based on a small patch from Yanfei Xu here:
>
> Based-on: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
> https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.co=
m
>
> This is a series that collected many of either enhancements or cleanups I
> got for QEMU 10.1, which almost came from when working on the last patch.
>
> The last patch, which is a oneliner, can further reduce 10% postcopy page
> fault latency with preempt mode enabled.
>
>       Before: 268.00us (+-1.87%)
>       After:  232.67us (+-2.01%)
>
> The patch layout is as following:
>
> Patch 1:         A follow up of HMP change for "info migrate", per
>                  suggestion from Dave
> Patch 2:         Yet another HMP fix for blocktime displays
> Patch 3-10:      Cleanups everywhere, especially please take a look at
>                  patch 10 which changes the core switchover decision logi=
c
> Patch 11:        The one-liner optimization
>
> Comments welcomed, thanks.
>
> Peter Xu (11):
>   migration/hmp: Reorg "info migrate" once more
>   migration/hmp: Fix postcopy-blocktime per-vCPU results
>   migration/docs: Move docs for postcopy blocktime feature
>   migration/bg-snapshot: Do not check for SKIP in iterator
>   migration: Drop save_live_complete_postcopy hook
>   migration: Rename save_live_complete_precopy to save_complete
>   migration: qemu_savevm_complete*() helpers
>   migration/ram: One less indent for ram_find_and_save_block()
>   migration/ram: Add tracepoints for ram_save_complete()
>   migration: Rewrite the migration complete detect logic
>   migration/postcopy: Avoid clearing dirty bitmap for postcopy too
>
>  docs/devel/migration/postcopy.rst | 36 +++++++-------
>  include/migration/register.h      | 26 ++++------
>  hw/ppc/spapr.c                    |  2 +-
>  hw/s390x/s390-stattrib.c          |  2 +-
>  hw/vfio/migration.c               |  2 +-
>  migration/block-dirty-bitmap.c    |  3 +-
>  migration/migration-hmp-cmds.c    | 81 ++++++++++++++++--------------
>  migration/migration.c             | 61 ++++++++++++++++-------
>  migration/ram.c                   | 32 +++++++-----
>  migration/savevm.c                | 83 +++++++++++++++++--------------
>  migration/trace-events            |  1 +
>  11 files changed, 184 insertions(+), 145 deletions(-)
>
> --
> 2.49.0
>
>


