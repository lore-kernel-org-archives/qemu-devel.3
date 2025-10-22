Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30899CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTv-0002vY-KO; Wed, 22 Oct 2025 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTn-0002tr-VJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTm-0001aT-Dk
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkfFzD5ZM5wWqXJjmTYhmklbUzKo4o7bvR9HregSsu4=;
 b=eF0YlI/vT51f3fLn/lmdC2szlh2epYryZCz1fUMwOLlTX3Pc+OeDdxF7OehxYiQoyWUWWy
 9S6y1RrNm87qG/bb9Rh0Vwrm60Qjk/YSfK/RfzvTKX/NJD+qCmS7S9OendS/a7lTzIIOtt
 Kl6VibXIq0WZ2E963nzAmun8apfgoss=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-YZeCk_AyP5aFkrFqK_0s6Q-1; Wed, 22 Oct 2025 15:26:36 -0400
X-MC-Unique: YZeCk_AyP5aFkrFqK_0s6Q-1
X-Mimecast-MFC-AGG-ID: YZeCk_AyP5aFkrFqK_0s6Q_1761161196
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87dfd03fb72so41274426d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161195; x=1761765995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkfFzD5ZM5wWqXJjmTYhmklbUzKo4o7bvR9HregSsu4=;
 b=HCp7aUIFvavxddmc7BB8lh578G5F+rgDPWEsNJx1LRA2Gg0HTg8qjlZf+0NykU9XXH
 JYloyUDarEksaFEsx81iXgoJqHwv6U4sdY/+V3xUFl9RSPhwFHrwoPktGagQDdjp4dm/
 a1q1wuaVNbpYnFA3lYmo/54yd4/01efLkviSPbmocU7d3Qut4CE9pqn5GYSWwzj89D2w
 bk4V+azAZJ4vjbv8tl76xGzAZKPfiPUNeY951GRKWE18CGZvYd7yuADtGbAYoqe+52V6
 mJpZjjEt+CzpuFjNy6wadjs5xDTa8QipdO9Wf3P5pUS5lNXb82mptqtHPp2yVoyiIjEO
 kHFQ==
X-Gm-Message-State: AOJu0YwHYKBHakvFDScIC0VumluIFvDSmcvnfbUMvG8tJqAKzgf//Ap6
 I1Ts4yMrGi16B8BEQ+wcgSw2r56pOTGA1zNVCVtCNYNIJ3NNhenANZ0JL9YUU1xK8y2NNC11RMZ
 qjW8IPW2BkI7gHuTl3VJHKUQ62eEb/2ZR3J/MMvmHtuX9pEj3kN6lXo0Q2fjsLn8MM/9CKh+h2p
 ObqS2159wTWtxXuUFVPxkQ+yUZ7t4XBDRsLd7itw==
X-Gm-Gg: ASbGncsdxbzl6DPuQxZLo2G6DYOxin9/RpgK6KAYnac+JoCEmeDvP6KaonrdNjnTFjI
 AeuKPV15HhAdTgKRDV+HJuH8HpJbfKdW5dK83rpkuPcPKauM/V456Fm+fdUD3G0uA1kWdhr/Eax
 4R87bf0OKBAQKbEHbpWd3GGlFeswaKq550LpIDM7F/CJaBtxIv/bjSaBslImT74FT9+NoxJROOL
 r2LiJLNDHE0p0aQlWsBMz3Vuw8mWGLLYcLnAFNsY1tXQ8QgVuLys8eovsX7L881FNm9XqXAueIJ
 Jej3NZN+J4PSsZX3gci+DKgIerX4Fj99z2drv/NxYemKgHt/Qn/S8pMHMUKUrrw4
X-Received: by 2002:a05:622a:1116:b0:4e8:9683:3a35 with SMTP id
 d75a77b69052e-4e89d065ea6mr264266471cf.0.1761161195462; 
 Wed, 22 Oct 2025 12:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEnuXwuHSwpW8s4w+ENkN1x9+zbXu+ktZfvdqQj+MZNEmrPbf1Lbi+g5Ma+KrRNR4brXu/fw==
X-Received: by 2002:a05:622a:1116:b0:4e8:9683:3a35 with SMTP id
 d75a77b69052e-4e89d065ea6mr264266101cf.0.1761161195018; 
 Wed, 22 Oct 2025 12:26:35 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 12/13] migration: Allow blocking mode for incoming live
 migration
Date: Wed, 22 Oct 2025 15:26:11 -0400
Message-ID: <20251022192612.2737648-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We used to set nonblocking mode for incoming live migration.  It was
required because while running inside a coroutine we cannot block in a
syscall.  Instead of that, when a syscall needs blocking, we need to
register to the iochannel's GIO events and proactively yield the coroutine
so as to make sure other things can keep running on the QEMU main
thread. When the migration channel has pending data to read, QEMU main
thread will re-enter the blocked incoming migration coroutine.

Now, incoming migration is completely run inside a thread now. We can
safely switch to blocking mode for the main incoming channel.

It's still slightly more efficient to use blocking mode than nonblocking,
because QEMU can avoid creating temporary mainloops and avoid the extra
poll() syscall.  Now it's safe to directly block in the iochannel's
syscall (e.g. io_readv()).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 728d02dbee..abd76801c2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -973,7 +973,9 @@ static void migration_incoming_setup(QEMUFile *f)
 
     assert(!mis->from_src_file);
     mis->from_src_file = f;
-    qemu_file_set_blocking(f, false, &error_abort);
+
+    /* Incoming migration runs in a thread now, nonblocking is not needed */
+    qemu_file_set_blocking(f, true, &error_abort);
 }
 
 void migration_incoming_process(void)
-- 
2.50.1


