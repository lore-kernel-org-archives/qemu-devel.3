Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C981CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpXX-0004xN-Gk; Tue, 26 Aug 2025 05:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpXU-0004wU-Tg
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpXP-0003Di-Ov
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756198814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IvEuZ0zL/NzHxYBbMC/XRTd+plJimY/Tu2+hzhM/Hb8=;
 b=VuM3z0pBCYSOpjQ9fHBj2Gz59h2FMREK3Zs3KGBG35pdyaopXww2F559InSiSNZGLRFTeo
 sVk7i0W8S2TsKlC4LPVRls+HrUXuOw/dERG31ZZ2bm1mseOGazkA3uWUf9nJTw+7UCmfpY
 egh1b4sAdCC7jBGhPiEIBRTuiw6C7jw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UyxwRQ0pNQuFjEiNzvy9og-1; Tue, 26 Aug 2025 05:00:12 -0400
X-MC-Unique: UyxwRQ0pNQuFjEiNzvy9og-1
X-Mimecast-MFC-AGG-ID: UyxwRQ0pNQuFjEiNzvy9og_1756198812
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-71fece075d7so45363537b3.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 02:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756198812; x=1756803612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvEuZ0zL/NzHxYBbMC/XRTd+plJimY/Tu2+hzhM/Hb8=;
 b=Et/2J/NJaKqvoX+5UkCij9+wbd1FDSCMn/MfkXWx978pRv+OFqNhoIxhgMxDwRoYJx
 /bAa7kbsLWFpNgZmkZRYdS4cIvbnLZGBjGWCr+UbVxru4xVzxIG6p33T052OsTKnpW+M
 4etkoWVD7eec4prFO42vv0lD/fHJ0QvssIBsq0InMV93LfMmxy6KFyRaE7tNBV51ZeNV
 9xjtlQS4hXECc215UfsnONoYyEoySnCJAHWrQuNleM4BjYHAEBsJVUFusghmPjHak4pk
 IYKscsokO9OSSPI4tSWzju2GPHN7C135c1oM4LldBiNS9tn4GnI/xqPZr0aKxyLzNj5W
 1e+w==
X-Gm-Message-State: AOJu0Ywa+cMp9C26KxRovsqcP7Y1IOibkLZ+UO+sASIoNmkP8VvqEAhZ
 B8pi6IY+9D+X6+4SjEOlp9hSXK8R0nujmDye4+IjjEVilClaw5iyDq+qqaMfQxW8OHRFUSa938H
 0PG3HocrKPdZp9/WcN3DBSX2Whr3sTW+kbnCSDA1p4rwfPeuVFd+FUZFd4KriaA7eqI40N4kxd3
 JgwTYOo0AVcqeocydoi6Q7/VyXXks+HG0=
X-Gm-Gg: ASbGncun++m7MOqO/737GomvtO5eNbOGsFIJEHFBg+kOTX6v7W5gihT3ZJyRHraPAso
 y6SJj5cZrlsa8bet9QlGFE0V4nnF6lw24CzbxP2sPC8ZV2K6nyfh4iXTcJpvuT0y6HjpOOAWPPy
 lBz3aUCp0n+mi1LG4LrK7ptmPHcGDlBF9xCmVvnO4i5aVu13u4gQ==
X-Received: by 2002:a05:690c:4d84:b0:71f:b944:101c with SMTP id
 00721157ae682-71fdc57fe50mr147235147b3.46.1756198811601; 
 Tue, 26 Aug 2025 02:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3W1+RmIzatRqNQPdvQVGa3iizPs21wW9uI/sZbKnDP1sYW1s66lyCRsT4nLd2YePrZIBhc8VPBAPf9LUFVUo=
X-Received: by 2002:a05:690c:4d84:b0:71f:b944:101c with SMTP id
 00721157ae682-71fdc57fe50mr147234837b3.46.1756198811065; Tue, 26 Aug 2025
 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250825140549.146617-1-kkostiuk@redhat.com>
In-Reply-To: <20250825140549.146617-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 26 Aug 2025 12:00:00 +0300
X-Gm-Features: Ac12FXw0UeGpUSqDXXYJKDvfiPh6IkTZ98GwCAGy4thI8Gl-Qb7LVDfSNY2QJ0g
Message-ID: <CAGoVJZxg_DF-YkJOa+u9NB1n5AbFmdRVrXPURpmvqir1V4nRvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] qga: Fix --retry-path behaviour
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Jan Tomko <jtomko@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 25, 2025 at 5:05=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
>
>
> Kostiantyn Kostiuk (2):
>   qga: Fix channel initialization check in run_agent_once
>   qga: ignore channel_init() fail if 'retry_path' is set
>
>  qga/main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.50.1
>
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


