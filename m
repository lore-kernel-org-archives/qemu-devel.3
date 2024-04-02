Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD75CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre0z-0006cS-BD; Tue, 02 Apr 2024 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00061K-9S
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0X-0006P9-7a
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7agLjjzk8v9ujmcbZ2gvOtjaRd7wQXKN8qM36ZwHWGA=;
 b=CeAFLKEuj1qrXxOjo3i2nJL8C0No9SzgBPlbHCcNtcSRynTZmmYjaFb2aaathCp0sFTond
 FMrURY/3rgQn0jlIKAkjrKe6nHx/sVWU2IkIcB7KHxYeYMzDiMKFj2A71M3fn8oo5AzM+P
 DAU9ews18VpLrHg8e0YUCm/ovInqVY8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-e9DuDHaNN4GxNhgs8vQnlA-1; Tue, 02 Apr 2024 09:16:54 -0400
X-MC-Unique: e9DuDHaNN4GxNhgs8vQnlA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d82715d3e2so8712101fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063812; x=1712668612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7agLjjzk8v9ujmcbZ2gvOtjaRd7wQXKN8qM36ZwHWGA=;
 b=iHtatK3gTR2jzUdtEIU9hnqXICN/+PwfKcAzvDpRDeuZboez715d8jOm7jRENZuZO2
 DD64+6wKUvYhAXX+BcRSqbQFnY0pX2ZHYcjgc2I3jiMK6KCRd9hbc2lCf23M0jzo4CzO
 lSHgBVOmcDYw/c09u6VD/H1d6DVHapArd9wyBEPbCgEM2nwr/I2gtQC94xmwroRLPuWZ
 J1ZDgV8sybh1SDXj9D6mlQPVfYZfcoxvJSA/K5IAEU28ADxrp+bymlfQKx2XYuIyqbvx
 ENTnPPGWXPydCzeScc02thnBgPmb9A4dlQGYnQT7XVsLePyTpZEquSc8VyPuqkR/13Op
 SsVw==
X-Gm-Message-State: AOJu0Yx6hpiU221v8UV9v+kqPXpE9mtPe4OnVsGkmnRYwfHkpdyqJqVL
 VEFMhm+EUmR6pqrJ06P85OfziwaTJCaTzts+P9D6rw/dE+PuJva8ew44RmxVFmm3YHc/dEaUdzz
 j7004iZZg8lMHR/iC9gc58N+azVLBmOGqKQTaMqcsg6be3NdumQ+Z0LQ5igbUqF0YCkkAiHt4aq
 hEzh1siOZC/JGomtJo96E5YFjjxhB529CyP6JP
X-Received: by 2002:a05:651c:c:b0:2d8:11cd:4223 with SMTP id
 n12-20020a05651c000c00b002d811cd4223mr4204165lja.2.1712063812378; 
 Tue, 02 Apr 2024 06:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExS4tS9bUBWtvHGlmOqrVuhQxXtjQEnKAHiHtNSa3HcTAm/F4oM/9zKxcBCMqzZu53u9qbZA==
X-Received: by 2002:a05:651c:c:b0:2d8:11cd:4223 with SMTP id
 n12-20020a05651c000c00b002d811cd4223mr4204141lja.2.1712063811926; 
 Tue, 02 Apr 2024 06:16:51 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c154e00b00414674a1a40sm17893359wmg.45.2024.04.02.06.16.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:16:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] lsi, vga fixes for 2024-04-02
Date: Tue,  2 Apr 2024 15:16:42 +0200
Message-ID: <20240402131649.23225-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit b9dbf6f9bf533564f6a4277d03906fcd32bb0245:

  Merge tag 'pull-tcg-20240329' of https://gitlab.com/rth7680/qemu into staging (2024-03-30 14:54:57 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to eac4af186f6db46fc90ec571a855bd6fa4cb7841:

  pc_q35: remove unnecessary m->alias assignment (2024-04-02 15:14:02 +0200)

----------------------------------------------------------------
* lsi53c895a: fix assertion failure with invalid Block Move
* vga: fix assertion failure with 4- and 16-color modes
* remove unnecessary assignment

----------------------------------------------------------------
Paolo Bonzini (7):
      vga: merge conditionals on shift control register
      vga: move computation of dirty memory region later
      vga: adjust dirty memory region if pel panning is active
      vga: do not treat horiz pel panning value of 8 as "enabled"
      lsi53c895a: avoid out of bounds access to s->msg[]
      lsi53c895a: detect invalid Block Move instruction
      pc_q35: remove unnecessary m->alias assignment

 hw/display/vga.c     | 146 +++++++++++++++++++++++++--------------------------
 hw/i386/pc_q35.c     |   1 -
 hw/scsi/lsi53c895a.c |  28 +++++++---
 3 files changed, 94 insertions(+), 81 deletions(-)
-- 
2.44.0


