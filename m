Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3DCC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAY-0006s6-6s; Wed, 04 Jun 2025 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAW-0006oY-Kr
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAV-0004if-1I
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xnb6fY77tTZ5nf3Ugq1ke10+nz2hG2kWSwmOHbAyR9g=;
 b=D34bZEdytjANjMVJoqh5WPSx4o0v+UqbHCd3th3KZmriWBcXBE21/TNMPB48RIF/09s2B8
 NsiAFZxkAUUFtZqV0qZIwc/0/p8FVK0g2iL8Mfukhy2hlUFclUcM4iAv+Fl4MY3sHh5N6G
 zW+ci+pZG6UxHG2LBFcx+l/uYzqI53I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-G0JCcm3XN2eV_gCRk55zqg-1; Wed, 04 Jun 2025 09:28:32 -0400
X-MC-Unique: G0JCcm3XN2eV_gCRk55zqg-1
X-Mimecast-MFC-AGG-ID: G0JCcm3XN2eV_gCRk55zqg_1749043711
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so1586456f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043710; x=1749648510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xnb6fY77tTZ5nf3Ugq1ke10+nz2hG2kWSwmOHbAyR9g=;
 b=ZmKQvMGgbOKAMEQQyvXOF+3o54Dkp0vGqYRbUTnlA8DdfZTXopHJIVwOYVI5Bflau8
 BlMtGEsm914ycnAYJ/+9NYEpHnPC1cjrwrZ+FfOty28IKLEnAxJlSJWHpjn6TIdOyzr/
 ylre1ZQSlaJDzoikR2ZAMToPQrVMWIezcu/fpIYh02bd6jcNJCfQlQnt/ymI4bqEDt2w
 pLEWWLAyD60uXUfGmgrVwVrQkPz2kZa6Mr6R3Ey3vbuvBB3LmB8KFMd/NHY52GOhkuNq
 tKBTgYFsOeHaHevon/zc7I/FLpPT+PyYw+5zDjrfggJ9Dj3vfnJZHjuW1pM3IFBmIHwQ
 GU5g==
X-Gm-Message-State: AOJu0YxficVwMKVWZx7jVd7d2O/f45oIr7RUW91puHXWVnxJP0W/+jME
 K3K3d+cVLEsLCFX1Gi4olzvaCExCLb//e1pLKnUBm1fypPMgWfaHaXdIiDH3wpIqr08pWqShzBe
 MFSt3LwzgY+8dTjE1WPdTjh0QxdcYEcsA/y9u5dn63M7e2tGdgh0z9/bltexDXWEq
X-Gm-Gg: ASbGnctnNXI+zUE7AnC+JWCIRNjlzOtY5wGIOWEwQLUG0Ml2YqtB8Lpix1bRR6AOUgs
 ICRwOOtjDfWUhWk67nA7R9vt506I186DLAlwifmoKnLp1gAnVGodq5lTVOYniJWlUn3Gi/NSv49
 tTxAYmsj9cHHJ1MIW4Ammahe8C7fuaciYFdMPQ9XJi2RiuxyZ32QOOMcqC629KZxnrSHWd60oDw
 ieFVB3YlUNN35S6CP/wgL1TN7uEAbRLbwrIWrmuryzizpg2gmJ6XoGaPMeBW3+9zmJNbkGosoej
 QjIhe7/PUY0Em0iF3k8CF4EKdP9nt6uNqDOc6hgg12uALHXC1Jk3wqxmgb7DeIRGg9Tztg==
X-Received: by 2002:a05:6000:2dca:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3a51dc4c4e4mr2176762f8f.57.1749043710594; 
 Wed, 04 Jun 2025 06:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcL5AVmKInEelTtThK+peHT0QG3YlWF7/tZ7/QHBq9wWF+Il6hkzBvPy2zivaRPESuEpd83Q==
X-Received: by 2002:a05:6000:2dca:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3a51dc4c4e4mr2176727f8f.57.1749043710201; 
 Wed, 04 Jun 2025 06:28:30 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5215e4c64sm1586316f8f.3.2025.06.04.06.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:28 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 03/21] fuse: Remove superfluous empty line
Date: Wed,  4 Jun 2025 15:27:55 +0200
Message-ID: <20250604132813.359438-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index b224ce591d..a93316e1f4 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -464,7 +464,6 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
     }
 
     if (add_resize_perm) {
-
         if (!qemu_in_main_thread()) {
             /* Changing permissions like below only works in the main thread */
             return -EPERM;
-- 
2.49.0


