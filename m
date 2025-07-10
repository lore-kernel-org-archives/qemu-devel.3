Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A208AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZta0-0002VQ-NV; Thu, 10 Jul 2025 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZtU3-0004At-8r
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:46:52 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZtTz-0000qB-Eg
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:46:51 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-714067ecea3so9618347b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752162406; x=1752767206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VGJsdpbw/lAyP0+Xom2j/vYXlcVr5QJOnKdJJIKoVb0=;
 b=wT2h57oDOiQC1PY1HxR3lYBzx3NmuR3vwY6L/zLhhY9N1i3P3caccE/Ww5k6mcmkD3
 3rpCi27azU/s3E4QHBP/+HDiMELzVM5jmdapsjd4fEzgb/rxRptyZKCKngoppxyZGEw5
 Me4V4tLSYi3xjmntAT0S5i7htpeUKBZ873zNMQJBukPrMzeZeG7P4FHsKcKP9Mn9f2iT
 XzyopW1RYhLNucWJEhHqMNfZs3sRkGpquUk2B9NLtTqKdywVO6XbdQiNxsAQKhD7uLqG
 mj2LI8UpEET8hBmtWYxOUCLn23F5EwWjrRypy+oVa7TcrjoDDYmK+y0mEf5u5apfmHbF
 jl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752162406; x=1752767206;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VGJsdpbw/lAyP0+Xom2j/vYXlcVr5QJOnKdJJIKoVb0=;
 b=PZIb2nz+pBFgf3jxLdBi6wbUg1ALPPC/pinq2xPe3/Nl6dtpqQ0cWCd91Syi4bF3EV
 IAqFhuhl0jUgzi+zEP/nCU1dLW30ZVCI5xRK+uRcMa7UnABvV1nvHrsfMzwyz1XeTxpw
 iG1LAJ30DIsznpS0LVfAJc+j1R7NUO8xH2tikrQIVKiK3gffKSdNqBZR0m5J4xVeQzC2
 50FO2k+3temHMf3hSAfNi7j8qfBWUAqR5AWcdD0c2pmSZK5RdYEgphhowysfvjgU5Ax3
 jk5WeyzvzEyoPMRrp2DUiRxh4+nUZeiFo5MXyKcm9CDolXxfctxYHI/pGrrXOsFTFVM3
 R+2Q==
X-Gm-Message-State: AOJu0YwgypRlgcETqXMrLtFMzNnFKCy6G89BBw+DA5oavF+VgUU/T5tx
 hcTCk5FjR7MvvMZalGDQkq6dSKRbeekt2hXfOnlAQmW6T0SDYj8XJxGUTszBa3LC+RQycWEUciT
 5S3X4918b0UD3tSILW8imCb2ks7ujKbnV+rkegP3TnWRPtDfJ9in5
X-Gm-Gg: ASbGncvIiPQlBuQbAudB5aQYNuZud9dG9sfnqXPYCjT23nNTV0X2gRE4WEqfoH8hfoh
 0r/zjHVwkPnOrCzFKXMlBhzblX25zOgjn85jtoSEewPLykAGzl2UAZviJQlnWvozLCzY5jRTd76
 gBwJWKHN9Mlrz3JnQQL2E04Kzy+8btaCuzpFw4VlfZA81DYlZsIkj+eFA=
X-Google-Smtp-Source: AGHT+IGmXRyeXwyZ4Ov8rSjHxRLvbwL3Cww4hTqxBd9rAzBn9ATDpsZPTVIEWRYRkPFEq+DbFk1J3Sg7P9da4+/QHOQ=
X-Received: by 2002:a05:690c:600c:b0:70e:142d:9c4e with SMTP id
 00721157ae682-717c47e9d8bmr47570687b3.26.1752162405764; Thu, 10 Jul 2025
 08:46:45 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 16:46:34 +0100
X-Gm-Features: Ac12FXwG7PcbJMP2zbf7o4qjPbOT4-k2Yk9MbLgDEelAy5YUfhLZVZ23WakvRUo
Message-ID: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
Subject: vhost-vdpa potential fd leak (coverity issue)
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi; Coverity complains about a potential filedescriptor leak in
net/vhost-vdpa.c:net_init_vhost_vdpa(). This is CID 1490785.

Specifically, in this function we do:
    queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
                                                 &has_cvq, errp);
    if (queue_pairs < 0) {
        [exit with failure]
    }
    ...
    ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
    for (i = 0; i < queue_pairs; i++) {
       ...
       ncs[i] = net_vhost_vdpa_init(..., vdpa_device_fd, ...)
       ...
    }
    if (has_cvq) {
       ...
       nc = net_host_vdpa_init(..., vdpa_device_fd, ...)
       ...
    }

So if queue_pairs is zero we will malloc(0) which seems dubious;
and if queue_pairs is zero and has_cvq is false then the init
function will exit success without ever calling net_vhost_vdpa_init()
and it will leak the vdpa_device_fd.

My guess is that queue_pairs == 0 should be an error, or possibly
that (queue_pairs == 0 && !has_cvq) should be an error.

Could somebody who knows more about this code tell me which, and
perhaps produce a patch to make it handle that case?

Q: should this file be listed in the "vhost" subcategory of MAINTAINERS?
At the moment it only gets caught by "Network device backends".

thanks
-- PMM

