Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F23CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 18:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzzN-0007XB-4Y; Sun, 31 Mar 2024 14:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzJ-0007W6-E4
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzH-0007Lm-RK
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711909978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f92/+N7+04yRcvyYKwlCJ4LGX5yCmgUgyE5M0om2fis=;
 b=T9UT2q1VBzImavU2JveyAgRFS1UvhtZ9F7eS8ClCF7wDeuVDp5EyIk5RvlycA70UIAXRBa
 aiYQ6EzB+EmQ54tmALjRmanqRONTkEy+qqwgXEo3wFwU+jAX234YwjWJa8Keojf1SZ8o2H
 OUhuRa7uq4d3bFqylDuWbJxZhuiZzoM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-PZInxWa8OcO3yx1ZxsbMsA-1; Sun, 31 Mar 2024 14:32:54 -0400
X-MC-Unique: PZInxWa8OcO3yx1ZxsbMsA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7830635331bso87246985a.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 11:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711909974; x=1712514774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f92/+N7+04yRcvyYKwlCJ4LGX5yCmgUgyE5M0om2fis=;
 b=JTObKzceOKvDVTkVc62TdctRq/zL3CVuz8OnMVfNUUFHGfRYAwnwtodcDS/Y+6MzDk
 I2Q6LkGknGg7/lsZ2kkXRZMEYP/vIjWoY/C1ZHeJ+tcNbkt9sRbCNR4zG+IMEEOVoTNX
 FBpL6S0Zn6nNkaq6PKTSsQcm0fHDYFFQ2j7bGvqScAZ8xmGDY8rJW9Y+hozdBNlzp03b
 KyT/OFeJEm71BigRh8r1cOJXbWZPjCkflNp9m3cjfbeebeJCOMtCt2HyvUkmK4Y3qpfN
 j9yKhGqcV4kxobxDd93KW2P++11MBxSgpNaxAaVyitI/UzjWK0cF9iZEZT01BTwf2Sm8
 P8pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGpCWfZBsTT54Cx/DKUX4kcee8H9ji9hChtYKe1HJ41bAootpmWYt0kbuNk8aV/r9L80jVyn7ZhNpwmETRniHxS1FP5Lg=
X-Gm-Message-State: AOJu0YzOptRPh7LSsgYL9eYzasplCrAy4mK3KUNFot6qNZCeosE7cHBq
 gcAdc6GmzfD0Q7BIrwd+O7IWgAzeCqRUkSrHYp21m9D9ESj36boS/1ZvdQZkteqZcgHJWgP6jQ4
 Zk5pyzOdjWrQraoNoocVwsadCD6j2H6C78d2snAEdumwdTv9K+vtk
X-Received: by 2002:a05:6214:a4c:b0:699:285:3ee4 with SMTP id
 ee12-20020a0562140a4c00b0069902853ee4mr2266538qvb.5.1711909974252; 
 Sun, 31 Mar 2024 11:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhQVYRnIfCK4PJyGnVdk0nQ5poCw2LO7vCXIm3tPh1X5pC+HdKbTos1lHad/Zp3041U+zMTA==
X-Received: by 2002:a05:6214:a4c:b0:699:285:3ee4 with SMTP id
 ee12-20020a0562140a4c00b0069902853ee4mr2266511qvb.5.1711909973573; 
 Sun, 31 Mar 2024 11:32:53 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u10-20020ad45aaa000000b00696a47179a1sm3748823qvg.14.2024.03.31.11.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 11:32:53 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 0/2] Migration 20240331 patches
Date: Sun, 31 Mar 2024 14:32:49 -0400
Message-ID: <20240331183251.1045817-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit b9dbf6f9bf533564f6a4277d03906fcd32bb0245:

  Merge tag 'pull-tcg-20240329' of https://gitlab.com/rth7680/qemu into staging (2024-03-30 14:54:57 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20240331-pull-request

for you to fetch changes up to d0ad271a7613459bd0a3397c8071a4ad06f3f7eb:

  migration/postcopy: Ensure postcopy_start() sets errp if it fails (2024-03-31 14:30:03 -0400)

----------------------------------------------------------------
Migration pull for 9.0-rc2

- Avihai's two fixes on error paths

----------------------------------------------------------------

Avihai Horon (2):
  migration: Set migration error in migration_completion()
  migration/postcopy: Ensure postcopy_start() sets errp if it fails

 migration/migration.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.44.0


