Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5F1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKSr-0003pY-CG; Tue, 21 Oct 2025 18:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSo-0003p1-SE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSm-0001KA-1F
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761084253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z7BDB6b3AQq0dRCf7+/g6dGq/WGqxKH3wxeSDq0vKPs=;
 b=eHNhKJJ6S+E+LXsGTQR4YzXG8OsjsY09cFv0VoWC1+GYPqz7VBzSuG5dghvDy8zdFuJOuq
 I2kKYcnrvIGfAiKL5KoUdqE4mXwiLT51SV3qbrCNPLFRGCFZUMjmx8M5GyQqcSnv8MNSlb
 g18ZMqqlTtGUcGZdtNdMk62rXTiei00=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-wOEkK9VmPqKF-KAucB8EpQ-1; Tue, 21 Oct 2025 18:04:12 -0400
X-MC-Unique: wOEkK9VmPqKF-KAucB8EpQ-1
X-Mimecast-MFC-AGG-ID: wOEkK9VmPqKF-KAucB8EpQ_1761084251
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e89265668fso11027911cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084251; x=1761689051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z7BDB6b3AQq0dRCf7+/g6dGq/WGqxKH3wxeSDq0vKPs=;
 b=dlIrmepcilYFkzxedywn9MBNuu97M7iODZKMbiQYp93OSwZn13SiCDsfFc1AEEO/dC
 jjauoojFwprOhnOTAuJaYSnvdZRf9msmSE6t2Hj4eJvojJFRN6XhNrDODPil8oQyMh04
 XLrrPUYHkQqZ9CNl8y8fq79HnassHmtc58rRw+Sw/y4TGQjlejfEFLLq9QsmctLB/5SZ
 oxhvoYFiEiZI+RFcX2dukmsEAkNHETaQS5PbOxFOFHOOrD8C1k3ujuVUOcHuiKxMYk4P
 P3r+LIXoEWhEmupoqrbKsTFqdSvhus2BM8FJE4cd0oeiBTFpj16wJw8BhkWnV4ts0MWw
 RlGw==
X-Gm-Message-State: AOJu0Yyg+fvV96FHPvqHVnUYNGurEJZqjg2KxAujKUvcDfoS4oDIdyy9
 F+0WlHYchyexwHanSxkc6KnoO0hrPV1kyMmRTPPRjIZNwghTbttWLsmz96yyzadn4Lu7E+xa1um
 EoQGS+MLC6LYZ+csy/D0TjouMbYDy5lpekixTGx1D1DUmGH2QZ94F1pJbKs9uADs6BLCH4M7h4w
 m1UADJI83WIn8DBE5K12Qoa5umClIE1vggwYxcjw==
X-Gm-Gg: ASbGncvflc39dDB3V8fzt519SkllhAwPbjSJ3pzLVIDzR+fdGsmrFMQRztExdRP68+R
 xU0t9sbqmTSpp4MjHHAGUKgM7s+GBJNXyYmQGLGr+HAv92HGdEvYPJdkk/jaV+qSq8QCxcLcQGX
 8hZfjuddacOkgYGtDmKXygVevSrHMWdP1Nf/m25Wis00NO2FFzVPNa/YSGQPNPR4DZplMBDmjq0
 4ySD21HQYV/W49MSMcoRh9CmnyE5BlpGjCf0sQboU3wyPJ419bbjDmm0O50rvZsPIFmG6nak07l
 3G/KaqKw7XkflO5Z+15tI4qKfns0rNk2fzynocxuM2ecJygC1YIC7ej86Zig0aKY
X-Received: by 2002:a05:622a:1820:b0:4e8:9459:4f61 with SMTP id
 d75a77b69052e-4e89d355d9fmr225123161cf.53.1761084251033; 
 Tue, 21 Oct 2025 15:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqVNAZGbDwZNwkDmtw1y2HA0xr93fN1pHxoJNzXBVh5ke21VvWPm4N008I214Ky9EA6wUpFQ==
X-Received: by 2002:a05:622a:1820:b0:4e8:9459:4f61 with SMTP id
 d75a77b69052e-4e89d355d9fmr225122891cf.53.1761084250551; 
 Tue, 21 Oct 2025 15:04:10 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098edasm849197285a.19.2025.10.21.15.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 15:04:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 0/4] migration: A few fixes on coverity reports
Date: Tue, 21 Oct 2025 18:04:03 -0400
Message-ID: <20251021220407.2662288-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

v2:
- Added tags for Fabiano
- Patch 1: dump the %d too along with %s [Fabiano]
- Patch 2: make the error returned to the caller, with some refactoring
- Added new patch 4 to fix a crash on cpr-exec when args==NULL

A small series that fixes three coverity reported issues.  Please review,
thanks.

Peter Xu (4):
  migration: Fix error leak in postcopy_ram_listen_thread()
  migration/cpr: Fix coverity report in cpr_exec_persist_state()
  migration/cpr: Fix UAF in cpr_exec_cb() when execvp() fails
  migration/cpr: Avoid crashing QEMU when cpr-exec runs with no args

 include/migration/cpr.h |  4 ++--
 migration/cpr-exec.c    | 14 ++++++++++----
 migration/cpr.c         | 15 +++++++++------
 migration/migration.c   |  8 +++++++-
 migration/savevm.c      |  7 ++++---
 5 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.50.1


