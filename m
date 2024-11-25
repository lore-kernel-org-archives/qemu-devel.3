Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE31ED59D72
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgY3-0005DD-BX; Mon, 25 Nov 2024 16:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgXy-0005CT-N7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tFgXx-0001Ee-14
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732569783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SNTKMA9xsbPVcH1VQL6J+ge2XbGSj41RWwtVsTB/BA=;
 b=RB7JJeIw/QXYEY6GPi83Y679McAyOoaVDsZatNlnQf/6jHY/ce2BnRuzsJIIqy3N+fngfn
 WaNLt6PGzoZqvJdCgrto4zbeArFP/NVp4ATHlShUwuDxRKxYHhKilmDvOoFIaK8XN9m++a
 pIJgY0yMtnm0tDcSBwzSckeD5mfi3cM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-7JQL1lhWMv2-vOOfduoeZg-1; Mon, 25 Nov 2024 16:23:00 -0500
X-MC-Unique: 7JQL1lhWMv2-vOOfduoeZg-1
X-Mimecast-MFC-AGG-ID: 7JQL1lhWMv2-vOOfduoeZg
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a743d76ed9so53044935ab.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 13:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732569779; x=1733174579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SNTKMA9xsbPVcH1VQL6J+ge2XbGSj41RWwtVsTB/BA=;
 b=u/J/Zb9zbmzZcs+qON4vZt21gpEb8LD3E3VadPz8+U/ssxj4EGpU7xdf04gt2BMVBz
 aAMJRUGPqp00/wsVP5+/FNCSpblssTm7+DPBpH/zTyMzT9RxFXduPa5G9CZB17WVrhnG
 PME5LvHcVsSQz7YyvfHD0OtHQkwKIXY5WYTjGRJjrV18aDMCa+njbzbynkAyrRwISHqu
 MPAumAcTsUdFH3H+Al7wy5HE/0lQTL+CgklhMlDhTBO5Mx9qRaUz7iVM92XZ1Pp9a/do
 wMRuFjIfU50pmXJcJcKpHr62NYAfXqm444CrETnulrJ8GzorvOlAv6gSrI+XtoE0VGMf
 yuzg==
X-Gm-Message-State: AOJu0YxEu0iNxnVdQg+1dpd2TIRDY6GVP4RY7rzbMvqI2hem7QCLYM4W
 5BYKg0aeWWBLDYp6RFRQZdV7NjOA3T0JvzKPcm8YZmIsyx24IT7uW48q//farqybH5Q1cwC3jR1
 I1mO9EE+zGomhvhv0quJHcQ11a4sTpUBdvBrhMpVk++BmYk0hSPbMRprCUaM2tho2swTVvx9QMl
 vVy0LNBxZrmjFv9orPlXA+MCKUQ8wp8utvCw==
X-Gm-Gg: ASbGncvflBX7DFTmYjkGa6tJ89jkh5djBj6fYE5ZtRUEJuoJS9/ff+qVeJLdtqwTJdZ
 RVI+sG0od2a/Zk7uKmVXa95YDbb1jr6NBDmaHWkfKLBy8rNkEC/0r/Kp934uY5AC2fCD6Rr3UVQ
 wLmiqYdomesy5DGgSPGjRZkBb+mOufOjhHx0pFX8QOD5yYRhH/4A3ojIWZO43FtO+AtB52sVEKr
 ppTLCJ5ACiQ3p+HRckk2r0zrVZrbbZxZ7sV+28KC8hy9C8N/ZNj0IP29ML0X7XtqwlzgZGjBC4U
 8TXLutxw6nW+c4X+1NquLF5HqQ==
X-Received: by 2002:a05:6e02:3386:b0:3a7:933e:ed95 with SMTP id
 e9e14a558f8ab-3a7bbd57994mr12711745ab.2.1732569779224; 
 Mon, 25 Nov 2024 13:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCUbxmtQm+dNgle0/7EgNyOCwexXHtVoe/+Wnz7JGBijXU1OxsLknH8t04cA/aFx3Og04qJA==
X-Received: by 2002:a05:6e02:3386:b0:3a7:933e:ed95 with SMTP id
 e9e14a558f8ab-3a7bbd57994mr12711505ab.2.1732569778873; 
 Mon, 25 Nov 2024 13:22:58 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79acb7b6fsm18989815ab.67.2024.11.25.13.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:22:58 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com
Subject: [PULL 0/2] Migration 20241125 patches
Date: Mon, 25 Nov 2024 16:22:54 -0500
Message-ID: <20241125212256.62608-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The following changes since commit 791e3837c1105aec4e328674aad32e34056957e2:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-25 10:44:11 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241125-pull-request

for you to fetch changes up to 59c390d95b4984c87db0deda2b8dad0c9595156e:

  migration: Fix extra cleanup at postcopy listen (2024-11-25 16:21:55 -0500)

----------------------------------------------------------------
Migration pull for 9.2-rc2

- Fabiano's patch to remove double vmstate cleanup in postcopy
- Peter's patch to whitelist pipes in fd migration URIs

----------------------------------------------------------------

Fabiano Rosas (1):
  migration: Fix extra cleanup at postcopy listen

Peter Xu (1):
  migration: Allow pipes to keep working for fd migrations

 migration/fd.c     | 27 +++++++++++++++++++++++++--
 migration/savevm.c |  1 -
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.47.0


