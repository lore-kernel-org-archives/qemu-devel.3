Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57B6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 05:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHuP-0001qI-0O; Fri, 09 Aug 2024 01:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHuO-0001oE-Aa
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1scHuN-0002kC-0Y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 01:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723180281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=58ShCAkzJcml0FgLuMrrLrERMQozVUybMjRiQDJjA7o=;
 b=RWDXR6XSKBkLtA0CbXnThY3vuQm9J6INEeTJv0tIgfPOTYOINEGMhQml8p9uhPVmwUB8aC
 Y+34YYW45d1zL+apIZ04iNDzFP/4AFLHLRBkdGl+E08NWJpHaiknIVFyWn3NJAvdmq2qwT
 5cKI7alT2F4ABt17lw9czRubOGYrlPI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-k_wPhvjyOGS_WFk__Tyuow-1; Fri, 09 Aug 2024 01:11:20 -0400
X-MC-Unique: k_wPhvjyOGS_WFk__Tyuow-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-703666ad688so1853096a34.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 22:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723180279; x=1723785079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58ShCAkzJcml0FgLuMrrLrERMQozVUybMjRiQDJjA7o=;
 b=krw6NhCKV/3Qb5tUV+109zEPV0G3DrzkHYmwMH81+i/SEv9XSGfW5o84m7df+UnXbH
 aN30GAjv2HBjy6vac8PHF3J3UWJABgkheCHaB55T3vqeEDheWre1E8Lp8SJiVXalcMDS
 A/faVgZDe8s0Qy+tsSguropvgAMFJ8KJ0Jis/yysL6IlbDUwySnQCzblZ6Z2M0zopPYP
 Ix692EbwBQm4/2OwncBrKsY+WhLyEagqS5hDZMKwEDA30ypgIw1/2nmhXlKdyoi/XBwg
 Xy0h4j0Jyt4mB8T8ClGWdVd/FfU4BUtHWLld8JYRelA3AsrC5OkjgYR8yIaaWERJ0f9Q
 IEOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Uz8/D6iRg2dhd3XkV9Mj2ONW9agBF2qvLZ+d1nrRW5r43w13L4B3GpQvWZd8rq8Tli5wXYYk06BDXC3VEi3i6/X34tc=
X-Gm-Message-State: AOJu0YxDEkI4Vho/6fVofdmVEYuCX6EvaGpIc5VRPGjzBzytrdTCZ4YL
 amk+5JPuFD/RO1wVsYO7n/rl3gam9iVqbQlfMHS7NnCBTc7EJ00YgBAie7gGG75EfXBAyKiz0Kt
 fZyp9DpW1q0/bqY3iGt8YlDxJGqEy1RAUkxbOKNDxEGAJ6qu2zS3+
X-Received: by 2002:a05:6870:218b:b0:259:8420:8e3b with SMTP id
 586e51a60fabf-26c62ce7605mr485545fac.21.1723180279337; 
 Thu, 08 Aug 2024 22:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9wJwPJ18iuXVXiRxPpCF6mEQKkjilyoLGwm1T+o/eo09QZnOhH9lIsNrzz+sIn/CLlHKX5g==
X-Received: by 2002:a05:6870:218b:b0:259:8420:8e3b with SMTP id
 586e51a60fabf-26c62ce7605mr485529fac.21.1723180278997; 
 Thu, 08 Aug 2024 22:11:18 -0700 (PDT)
Received: from localhost.localdomain ([115.96.114.241])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-710cb2e52bfsm1961777b3a.145.2024.08.08.22.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 22:11:18 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, zhao1.liu@intel.com, pbonzini@redhat.com
Subject: [PATCH 0/2] Some refactoring
Date: Fri,  9 Aug 2024 10:40:52 +0530
Message-ID: <20240809051054.1745641-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

replace fprintf() with error_report() in kvm_init()
refactor code in kvm_init() to move core vm creation operation to its
own function.

CC: qemu-trivial@nongnu.org
CC: qemu-devel@nongnu.org
CC: zhao1.liu@intel.com
CC: pbonzini@redhat.com


Ani Sinha (2):
  kvm: replace fprintf with error_report() in kvm_init() for error
    conditions
  kvm: refactor core virtual machine creation into its own function

 accel/kvm/kvm-all.c | 106 +++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

-- 
2.45.2


