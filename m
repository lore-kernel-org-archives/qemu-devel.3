Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D8BD59F52
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDHk-0006c4-C2; Fri, 12 Dec 2025 19:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-q88aQoKCp0J7O9JLO9LPDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--marcmorcos.bounces.google.com>)
 id 1vUDHi-0006an-L3
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:54 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-q88aQoKCp0J7O9JLO9LPDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--marcmorcos.bounces.google.com>)
 id 1vUDHh-00078L-8V
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:54 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-29f29ae883bso12372565ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584891; x=1766189691; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8tL7/RGN/sKACTO1/U808dKR26ztwxbHlqQIK/m5vG0=;
 b=mPIZH28N+EuYnjV1gqdf4b3ctnYa2OAOdaUDuRtb9/cK+ZxQ3gdHRGLrdDW8Zrw/Pt
 qoJBEptckWIrdE7/qJCZeDSrQe/XEwfVf1NKqRPhyZ6LY1IhIez+KtwpgLsQwCyLcW1b
 cf53jFU8l0UZqI7zQQaBwlwuM4hHsvg2lD3vUg8dqPefZVPE4qC8CZDIlvuvOnogoXTK
 dByOQd76dWV74vbEEEP5tGCHAdSMUjtWdlMjKmrG9QOOxRVhe36wkwJhA13e82YscTeq
 Z3KAO0DO975te74t3D687svbEdeNq4HfiCZ87nZ0YryC0in/enRU6lzdja668ivEGl97
 XOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584891; x=1766189691;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tL7/RGN/sKACTO1/U808dKR26ztwxbHlqQIK/m5vG0=;
 b=Iyemzh1auA+IWGeC7hmALE5YmvKuoTvUrPDi3HiEX2bYupSYMyj4PySdnvVwN+MsQ3
 O/26ZFQNjKP3832zJ/OZrdV4nXoQLGFrmeebg1tSbiy3bx3arCN13kNxGHc+LfyUusRE
 2UZEAv0uU7JlB7xvsVeNiY4iUAUdQ1lEjlrHuvMsWfFDIMS2QgJnjAwucVZz8ms0S9uz
 Olpr/ddNZAqsfcFgo0hVHZxfjevnrKehixgYnb8WWAFN2Eh8NVH0vFnsFcFGtV6jIK52
 r87XdITVdsTRyf8O5GQnF1XcJnnhfflQNOFTV5tiStcJd+Z+9MovhSDrQVFMERwEsCB+
 pH0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJpSPl194jlw9rL4uOjfJlFM4AP0BcTHeubGsZznqgvjKFGD2Hx4ta05nVulieGmZnsE8qDFWxK2wr@nongnu.org
X-Gm-Message-State: AOJu0YyAebcl4fOZeOapO04JjIY7Zj5bcSStMc1PR+iqH2SU5W8iG32k
 5LYOvs7z5NB8YmYF1exL2Vkp2A8X0QQp0GD9K1J4+xBOz97oDkR9CnZ9zKV448v8Q0N2XDgHcDP
 5f1IoU6QmE9MdsMIFT57iMg==
X-Google-Smtp-Source: AGHT+IEk/EneiJL291SDXmhW6/pWcFWHFjoD4OjmgLdPzMcPD1d1qlCRdYtHtLu1AW5T+C/bWNgCkI8hcBP/vuAg
X-Received: from dlkk18.prod.google.com ([2002:a05:7022:6092:b0:11e:60ad:95af])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:982:b0:11b:ade6:45bd with SMTP id
 a92af1059eb24-11f35475c65mr2888073c88.8.1765584890841; 
 Fri, 12 Dec 2025 16:14:50 -0800 (PST)
Date: Sat, 13 Dec 2025 00:14:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001443.2041258-1-marcmorcos@google.com>
Subject: [PATCH 0/4] Clean up TSAN warnings
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3-q88aQoKCp0J7O9JLO9LPDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--marcmorcos.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

When running several tests with tsan, thread races were detected when reading certain variables. This should allieviate the problem.
Additionally, the apicbase member of APICCommonState has been updated to 64 bit to reflect its 36 bit contents.

Marc Morcos (4):
  apic: Resize APICBASE
  thread-pool: Fix thread race
  qmp: Fix thread race
  apic: Make apicbase accesses atomic to fix data race

 hw/i386/kvm/apic.c              | 12 ++++++++----
 hw/intc/apic_common.c           | 24 ++++++++++++++----------
 include/hw/i386/apic_internal.h |  2 +-
 monitor/monitor.c               | 11 ++++++++++-
 monitor/qmp.c                   |  6 ++++--
 util/thread-pool.c              | 30 ++++++++++++++++--------------
 6 files changed, 53 insertions(+), 32 deletions(-)

-- 
2.52.0.239.gd5f0c6e74e-goog


