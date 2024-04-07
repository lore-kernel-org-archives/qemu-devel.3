Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCECD1292
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 18:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtXUp-0000Ot-EN; Sun, 07 Apr 2024 14:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUn-0000Ob-Ri
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtXUm-0003C5-6E
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 14:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712515438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=26pTu8EVj1KEbXWxmdKjhECkDGwyK4deuCMQ23PJ+9s=;
 b=E7j99PdW+N0m/310CJplG1wDKPf8I9iE7Hfz9HaT3T6WakgmdaYWD2pIbfUlHCajaMw/mO
 pq2mPSTMDbnW4wk8VLmjkPpgtNrdbGo0rKI3hWH8v0deOdmMbDtOer1x9vb39uOQ3wjb3q
 FwKYydfSk9qlY6dHuRagOvicksp/DN4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xkBV-j5pPc2_DLdFN5nsDg-1; Sun, 07 Apr 2024 14:43:57 -0400
X-MC-Unique: xkBV-j5pPc2_DLdFN5nsDg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-618047c2daeso983797b3.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 11:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712515437; x=1713120237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26pTu8EVj1KEbXWxmdKjhECkDGwyK4deuCMQ23PJ+9s=;
 b=alVIpxhri6C609gIrN9EiuM2t7BFFWyBerqSC3zYygYukGlUYVPRHspFoVQsUVHluz
 Gyos2lGuvNKPdrNP579J5KZW9hcyXnm767DXuRCvOUoSdKev4PrYBrEpcQVozo/dM73n
 qJT8I2vbRo0UAdyYgFYta0HfBqX72S1dDj3RFSJ519DBOOWVF3Q04gm/s34E0l90vlUI
 dE877/o66w2yWtI9r7ujO2Nw+VKEZ+jG6rslMRHbBV3NKEdmjOzUjQfwP9714E4qv4Up
 RscILuQUHG4tsmrkKpxDn54Fwa1h1FB2YjfUKdqhtafn2OiZIBklToHyj1DMc9ZMXxo9
 8pAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUWsAQKqMznpXiIBrrnj2WuDpo9VrVIaGiJ2WoInyTeMKRs95a4QH1ZQZ7G82dh1uj1UEo0HfZew/1mymFuFBiT6hoxlQ=
X-Gm-Message-State: AOJu0YxWSVZQoqmZBnH3eSC6rZwyTGom8jwb9hxWHygjt2i4e7c8F0Ji
 ZdYDOiQI3ZPVS8128EmBMpAHNjyrbUAAAhc6/v3gCr0bRoXg5kYoqMdsU4f+FZ7A+IP/UDecKsy
 V/fE9D7YlHewUYOmVuVE69kPFlk2AtZGuJTME4aJpBbA/fImU9W9G
X-Received: by 2002:a25:2904:0:b0:dc7:4aa8:865a with SMTP id
 p4-20020a252904000000b00dc74aa8865amr4205204ybp.3.1712515436995; 
 Sun, 07 Apr 2024 11:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6UyuGbYGBTc3Gl0OBEey8qXcrH2N1mu4b7kj8/5P+2e94CsJk8ml8yrkNHLG9lrNhjQ8ShA==
X-Received: by 2002:a25:2904:0:b0:dc7:4aa8:865a with SMTP id
 p4-20020a252904000000b00dc74aa8865amr4205187ybp.3.1712515436045; 
 Sun, 07 Apr 2024 11:43:56 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
 by smtp.gmail.com with ESMTPSA id
 cw12-20020ad44dcc000000b0069905863252sm2416842qvb.84.2024.04.07.11.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 11:43:55 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, Lei Wang <lei4.wang@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 0/2] Migration 20240407 patches
Date: Sun,  7 Apr 2024 14:43:52 -0400
Message-ID: <20240407184354.1839435-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:

  Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240407-pull-request

for you to fetch changes up to 8e0b21e375f0f6e6dbaeaecc1d52e2220f163e40:

  MAINTAINERS: Adjust migration documentation files (2024-04-07 14:40:55 -0400)

----------------------------------------------------------------
Migration pull for 9.0-rc3

- Wei/Lei's fix on a rare postcopy race that can hang the channel (since 8.0)
- Avihai's fix on maintainers file, points to the right doc links

----------------------------------------------------------------

Avihai Horon (1):
  MAINTAINERS: Adjust migration documentation files

Wei Wang (1):
  migration/postcopy: ensure preempt channel is ready before loading
    states

 MAINTAINERS        |  6 ++++--
 migration/savevm.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.44.0


