Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BDDF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbqr-00089L-W6; Mon, 09 Mar 2026 10:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1vzYc0-0004VW-Mr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:17:24 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1vzYbx-0005NA-Su
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:17:24 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12776bebe9fso4801267c88.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 04:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773055039; cv=none;
 d=google.com; s=arc-20240605;
 b=coBFZDyRzyzE08SBwVJumT5dclqQWJl9mMDdYVnZCk0F5bWsOkZJFj/iGg2dg4iSOo
 +C29eVi1/j/5htxNTH4uZRB4bLtwTQgNNr1CPUEkNQ0vmPnEdnV0vKB19jak+fgCIiul
 At0SW8GJb1dkU5KSxWuMyj3+bPLMa/55ob9GzKYsZWKS+qEOXuA650gpE+KRY0o+mMrt
 N28Yi7db7SF1yaV4ddAhi9M2AAUN4HOCd0V6qxcn7RAECA8zv9FnxkJReonx9q5Kj3Bk
 a2atHZCk4syvCMgWcLNF+AppxOyj0XmiqDfHkI5hG7ozMkBsmFNqlh2nXiwkviCkdR/6
 3rZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=FVprUn3vn/ezg8TuPdgWAd8xfLWyCfNfkmEGDexijK4=;
 fh=wfPDixGcq6EavxVQy45gtd6cwcmhIZ25p7AB5TYjT54=;
 b=kvACjRbgLuIWSukDt/JRGqmCJf3XeI7YffW5BUUvNU4nz01k8vCiO6mK/tmAXzTYjR
 ZbRHtk2apEjkai347RPMu30s3xPDOvkXoA03TU9qrJJC5653pr0eFAw776MacOLlM4C3
 7g+mhnjkeT4QHkBm/iQSGqL3ObxmShhix8H8LgHr6Q6iJOnUUiBG/dAdvXeoeKhXPZhj
 QNGYixgUb3GqO/uTQDl9jdgzvviH6n+2BrGRP2lMrgLdz3Fo/ew+U0BFvdBvwdCyDVlL
 swDc8VxrABjV/fVULiZI/PuJts/cIgttkwMXRiO2fuUPa5vjydwLT9njm/90ZXnWjs/p
 JFXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773055039; x=1773659839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FVprUn3vn/ezg8TuPdgWAd8xfLWyCfNfkmEGDexijK4=;
 b=SsYFJxk9SAlcX63jsjQzEuF1Q5zS2o5ZxeJOHN7kTR45Wd5nHiNqhKwy9GfmhwFtb1
 h1ghyppxV3Xo1MhxB95TsMjNZkB07clMcdmzrWkkXFCAUirbAcQhIXb3h2yjFSTHFIUG
 fXuhywPIxFMxfsBkujia8pVSpQbOm5uTPcZdpjm5EDBkmop2h4v8k6HOV72bE4CaGjNK
 GXMuNrlpPqnOGWIaNxKqr9d7oDELqNQpkKqyd6G7NLO7HMv6bjLYM1ZCtUZW8kTJUuZf
 fMwtnjZArOIwc3UfHfC+O5LricwuDynfU3bW3iWpUKmSdnMCRXdx4bnPJeKocjYjKjpK
 dpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773055039; x=1773659839;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVprUn3vn/ezg8TuPdgWAd8xfLWyCfNfkmEGDexijK4=;
 b=kXJuTFEkZUPtI/ZQ1hpiXja0fX5ESkFPvYnlu/YUcswuoboSyP0kEdrIEQE1sGogRb
 Hx0YwfJyFALslKW3qiUWi2Ema63kYm4cEP+vls7ZP3GOmJVBiyETekdgwXSOCRjGoaf2
 o/pYqMRnZSkP/gfYLCvSxOYx/pDhzBwb0iBY0jUgXKTS6AKmaR2qL70YJ+CYTH6fauEG
 6zTRA05R4M0svqK2g64Ug2sanZ4OXYRJje+CZ2qflDceC/l7mAkDAq1vJss7tbx7Jpcs
 GNTNA8MhEeihRjLA5jBwCdV7Q5IrhkPlGNvWsyRgIkZFkAZyfmwMcTB6o/sUM8h0hChF
 yfbw==
X-Gm-Message-State: AOJu0YwSuoGxqLqzzm8E+SM455a/Eod5AUafmbRGfzok/xZZD/Bb65ya
 Po9AaASNV2BKaim3iTFR+zms0NcCeTEhI6r9mMl9EpRhnGQ6UM/ePsqX43s3zaEsGKJCviyGeZp
 /qySqF61WBdWf//fJf5Ix3i9NGGnPx7+rytIUX2dtlPs7Zg==
X-Gm-Gg: ATEYQzzVznXIFoiwVWSKs/XO8ow+NktSKAj4jYPVzvaoP7LKHpNdA8cvyjdikm1Wjvg
 W1ojDzXEC3LKeQeH63S3gU3sbEC5Q9r8O1N0tcvGklVfJI6x7Z+wTZR55ZdCBxxWX+duIn6WX0+
 0yhS1SUXLCp7WF0JNq8DoMbv70KJQj5pxLGsMeA809qZR6qAD4vGLTHd3wjVtP4DfwxRkYrfVhh
 LmMw/wtudTsWY6Aaa5s9CSKxmy6hvWzYj1ejgwdssGm0lVuZ3ODJxLSGsGPwoZEFEJB+QX0r3H4
 Afqxj/o=
X-Received: by 2002:a05:7022:906:b0:127:5cfd:785 with SMTP id
 a92af1059eb24-128c2d8f553mr4510182c88.4.1773055038788; Mon, 09 Mar 2026
 04:17:18 -0700 (PDT)
MIME-Version: 1.0
From: Han Zhang <ihanzhzh@gmail.com>
Date: Mon, 9 Mar 2026 19:17:07 +0800
X-Gm-Features: AaiRm5197f_OJ243JTdRYIcu5q25PiBvOvagCM8q1k8iUj5E2ZpSwkd3aoA-TVE
Message-ID: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
Subject: [GSoC 2026] vhost-user memory isolation proposal feedback request
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, tfanelli@redhat.com, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=ihanzhzh@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 10:44:53 -0400
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

Hello,

My name is Han. I previously implemented a virtio-based communication
mechanism between confidential virtual machines, and based on that
experience I would like to apply for the QEMU GSoC 2026 project
"vhost-user memory isolation". Before finalizing my proposal, I would
like to check whether my understanding of the project direction is
correct.

My current understanding is:
without changing the existing vhost-user protocol, add a
memory-isolation mode for vhost-user devices so the backend no longer
directly accesses guest RAM. Instead, QEMU intercepts virtqueue
requests, copies data between guest RAM and isolated buffers, and
forwards notifications. The backend only sees QEMU-managed shadow
virtqueues and descriptors pointing to isolated buffers.

After reading the relevant code paths around vhost-user-blk and SVQ,
my current understanding of the required work is roughly:
1. Extend the generic SVQ path for the vhost-user case, including
adding a used_handler so completion handling can perform copy-back and
cleanup before returning requests to the guest virtqueue.
2. Move the SVQ vring memory to memfd-backed shared regions and
register them with the backend through add-mem-reg/rem-mem-reg, so the
userspace backend can access the shadow vring.
3. Allocate bounce or isolated buffers at the SVQ callback point, copy
data from the guest virtqueue into those buffers, forward rewritten
descriptors to the backend, and copy data back on completion.

I am mainly trying to validate whether this is the right architectural
direction, especially the split between generic reusable vhost-user
SVQ code and device-specific handling such as the vhost-user-blk
bounce-buffer path.

I would appreciate feedback on the following:
1. Is this interpretation of the core goal correct, especially "QEMU
performs data copy, backend only sees isolated memory + SVQ"?
2. For isolated buffers, is qemu_memfd_alloc + add-mem-reg the
preferred direction, or is there a better approach?
3. For code organization, what split is preferred between generic
vhost-user code and device-specific code (for example vhost-user-blk)?

This is my first time participating in an open source project, so I
would greatly appreciate any correction or guidance.

Thank you very much for your time.

Best regards,
Han

