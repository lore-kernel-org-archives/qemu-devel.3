Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B11CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTa-0002WZ-Fs; Mon, 05 Oct 2026 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <384PDagoKCmYWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTX-0002Te-7p
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:19 -0400
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <384PDagoKCmYWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTV-0005PF-As
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:18 -0400
Received: by mail-pg1-x547.google.com with SMTP id
 41be03b00d2f7-cc78c0402e7so872706a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198195; x=1791802995; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BtuYn9nCUgeoZAistXdI0FlIou4/Pe4GgXjsWMAZGrM=;
 b=NIRCmMEYly6Pa3P33Xf7nkvTjzB3i3A74VMpCcYIlzRrzlTfehtqWkvC9S8XBBvhZp
 bhP8OeZJcVlkXIOUQJvRlaUzJkBxAkkJN0ljztC1lF7XYSsVl5r3zbW1C+/XrznR7S8Q
 gny6uyLoHuRUYbqYwWWvOl56+DBea5gADKTBE5WphmWyrfFu2B2T+cN6VKk888SzOolH
 bdGLkREZl7vudGKjeRXkh9yR0gplBitFOuZ0ID9j+zB7osVfjetDsnP3eFVaRrIKlssa
 sOWMNvJKUaAMAe0Va3sgE5KNwsmINE8sdmw2d2fu8WfDqvw+0m0wR3LrbMZuKozkjEWZ
 oyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198195; x=1791802995;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BtuYn9nCUgeoZAistXdI0FlIou4/Pe4GgXjsWMAZGrM=;
 b=wKmYxekkilTavb4pgojoYa8NoBrmZrdwgOHcC6aR+0ucgP7wxgHDluxseHsBLFguu3
 xelb507LyI4RuyZItng3pgCpnvclRb1AOCkyLA8w7AK+TsPBfo+abXdNUkHC5zbl00BE
 iV5cvvAi20bKfo2LGUmEWSr3x5LYgd3ak2CQ//QjZ+cAjiTzQYr/DJnb8DVlmtXibHzp
 eVYsGM03x8Ru7NQ73tiq2Jgv0ZU3TKyuV4bhCp00IFMNDh5IzB5wKt8nyc1KTwxWIDtD
 X+JHM1DIv8kzzuqjaPZ5SKsWo8NVVGq42d/nNde6uc57kXn3FUtdnSJNAWA/XMp/lSSK
 fZRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGoC0sHyQn0QvNEcxG85904Axo5y2Xw7p24RvLlKaJML6kmdDPNe3cAieN72t/dJ0wM1UCKNXGq+XT@nongnu.org
X-Gm-Message-State: AFq9FYIokUUD+K/koD0k/9Km50ecDJhCisqzpMqgu9qAbSJaE6KpuIcv
 /2Okv7zuxaZotuvgwUm9UA+MuE0Yhtb5jMrnQxZ8HxIAMoVUlvHgSAWAOHq+hkhlEPI0KbKvBFc
 RNOSsBUyEO4IVqXYoF3zWcA==
X-Received: from pgba18-n1.prod.google.com
 ([2002:a05:6a02:6452:10b0:ccb:62e:3f27])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c08:b0:3a6:d30f:4658 with SMTP id
 98e67ed59e1d1-3a6d30f6727mr4597618a91.27.1791198195005; 
 Mon, 05 Oct 2026 04:03:15 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:13 +0800
In-Reply-To: <179093130014.85103.5733803911053837491.b4-review@b4>
Mime-Version: 1.0
References: <20260923144911.2877141-1-stanleyjhu@google.com>
 <20260923144911.2877141-4-stanleyjhu@google.com>
 <179093130014.85103.5733803911053837491.b4-review@b4>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110313.3327098-1-stanleyjhu@google.com>
Subject: Re: [PATCH v3 3/3] hw/ufs: Implement Task Management Request (TMR)
 handling
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, fam@euphon.net, 
 kwolf@redhat.com, hreitz@redhat.com, j-young.choi@samsung.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::547;
 envelope-from=384PDagoKCmYWXERPIcNLYKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x547.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, 02 Oct 2026 17:55:00 +0900, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
> tm_resp is a task-management service response for output_param1.  Using it
> here puts reserved values such as 0x08 in the basic-header Response field.

Fixed in v4.

> UTMRCS should only be set when a completed UTMRD has its I bit set.  As
> written, an I=0 polling request can still raise completion status and an IRQ.

Fixed in v4.

