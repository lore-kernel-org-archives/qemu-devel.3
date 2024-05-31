Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83152C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwJM-0006cl-Ao; Fri, 31 May 2024 03:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwJK-0006cc-Qd
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwJJ-0007KR-4t
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717139059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QawWJRYcXrYBVo/lMRELy2do7rjudde1sSrXARepgNc=;
 b=LQySupbVD4o5qfnosu2c92VmL/5sMlk2Eln3BEMJPocbJou1kN9doGj4HBacWRgUetG1UG
 pj4dMobc1h/oQsXeDnGXMjp+UPiid+GP/JHqp/1IEuMiCw7L6xvnQZihY6pkTTQlloTdB9
 kUwyTlhYtQHtbsdUsIxMN01jMlYy4LM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-STXy3rjoOqW7SJTuNGBf2g-1; Fri, 31 May 2024 03:04:17 -0400
X-MC-Unique: STXy3rjoOqW7SJTuNGBf2g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dca12cca8so744808f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717139056; x=1717743856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QawWJRYcXrYBVo/lMRELy2do7rjudde1sSrXARepgNc=;
 b=QbrxwUpvNitKKLVGF3fyPaN4AvThja0v6/1GE1YP/ryybkcWR4PYV0Vp06JP9CmZh4
 PGiEguI8Kx92Vsv4jRfIyx3Z+GLPWFt77EsVIJkfZZ1IFcn8lzmETY6VNreqQzPjFA0y
 hdVTrlcG3RfuRaq+EzJKUb6vtQOBt8Q04iEwPCn+J782K4HMlAMC5u9oWAJOdU2vUypX
 vwgD55RWbtIRxmexZi3K/6ijqh+y56MO/l/gyfmwDw9bLFxzHCwuOoCFfZDLcKi0cwuz
 OvK6k2dBU2ZvW3ZUl+3JJNhDaO5v8hDtEWwKiXPm5IJjU1l8bpBYP665mUJlQuQgQTJ4
 TTtg==
X-Gm-Message-State: AOJu0YxO+djahOqja7IdbinfVgO8xiDH6ws1gWOAvG+tuiyKCZ19/GFO
 lb/RPGAPKN7IJ9UIR6f8+c3Ipz4dhdGjZRFY6icFADVIOEsLt/gDygFYr+Mv590dZrbJuUtvLT1
 cXSvAsZ7N2hi3+QIWXcSOaNpEAAWmdt1iGgPsjupsehBSvljSEcPIHnFxWRFK510JI87CU2BILz
 Aa7NvMPgYOI77CJmNYW/DZ0EXZrlc=
X-Received: by 2002:adf:a112:0:b0:351:b130:45c2 with SMTP id
 ffacd0b85a97d-35e0e5a80dcmr757877f8f.14.1717139056402; 
 Fri, 31 May 2024 00:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkVnR1f+D4hDdSNpf95bQIMp2ESrifI4KfgNGHPPGBuYBJ4IDG6gpIPsYzbTdexHLtktAwiskta3BGA1qrwE0=
X-Received: by 2002:adf:a112:0:b0:351:b130:45c2 with SMTP id
 ffacd0b85a97d-35e0e5a80dcmr757858f8f.14.1717139056039; Fri, 31 May 2024
 00:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-2-npiggin@gmail.com>
In-Reply-To: <20240530095408.31608-2-npiggin@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 31 May 2024 12:33:59 +0530
Message-ID: <CAE8KmOwoWXTcJzq5+U1z0=fRxsNDB_3kgRyjHOZ3JaA8EN1+_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tests/qtest/migration-test: Use regular file file
 for shared-memory tests
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 30 May 2024 at 15:25, Nicholas Piggin <npiggin@gmail.com> wrote:
> There is no need to use /dev/shm for file-backed memory devices, and
> on Gitlab CI the tmpfs mount is too small to be usable for migration
> tests. Switch to using a regular file in /tmp/ which will usually have
> more space available.
...
> -    if (args->use_shmem) {
> -        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> -        shmem_opts = g_strdup_printf(
> +    if (args->use_memfile) {
> +        memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
> +        memfile_opts = g_strdup_printf(
...
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
...
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs, FILE_TEST_FILENAME);

* Maybe the 'tmpfs' variable needs to be renamed to indicate that it
uses '/tmp/' or '/var/tmp' directory to create temporary files. And it
is not in memory tmpfs(5) used for shared memory '/dev/shm'. Commit
message above says 'tmpfs mount is too small' and above calls continue
to use 'tmpfs' variable to create temporary files. It's a little
confusing.

Otherwise patch looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


