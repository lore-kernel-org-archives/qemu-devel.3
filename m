Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A262C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6o6-0004Tm-K6; Tue, 25 Mar 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o1-0004S3-Ta
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o0-0007Lh-6n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUQnGlHs5herHOASbjnzqcyWsb2S34k63P/LGi0N478=;
 b=EeECdsVlHa4CpxOiUAf6XuUf40Yzywm8tDe871EDYzEgVXSJa9sV130X8bGiYQZK0I2p4c
 4befOKTPKcOyyehZ+V3QeivoZYZ1MEq+caW2U8QU9VQNvCjHPW5YPaXZcHdnKBQyEbv9Th
 dYQD748lSns589tENwioF0wBv8IPKgc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Ph5CsxDDPcqeFndm62fv3Q-1; Tue, 25 Mar 2025 12:07:05 -0400
X-MC-Unique: Ph5CsxDDPcqeFndm62fv3Q-1
X-Mimecast-MFC-AGG-ID: Ph5CsxDDPcqeFndm62fv3Q_1742918824
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so2992582f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918824; x=1743523624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUQnGlHs5herHOASbjnzqcyWsb2S34k63P/LGi0N478=;
 b=vYRqxB6Sr+o05clvhJ3KpOrOF+6c1PhbdkHOjUifYoWcXqsFHEWoXrN/LSGsa2lOzY
 zPaUKe3GEIPjAueQl27Hh+KvIgfr/3AUh1X+lT5HOuRLmJmqat6SQ/i7x2jODh1aRJFT
 drpT4IaBToMYrRgP1BVaqXbOUGg8btDjM0as5NYNBpW7sIYTLPh/Y4g8WQkrpp8TYgaD
 /2gUX4M5KY53Vc86uTecap+To9tIPqIu+Ej46/XNCuiGqYaukHd+Nq4ojxGQ3sv1SE3N
 pzVBnmuofg7EaxVIK4OMgHYUOv2K0NvzcpsQNKJvSXssefyNrINqUcvxZHtq9Kj4DPOf
 yrZQ==
X-Gm-Message-State: AOJu0YxnREdJwx70qBKxht01AwDu9swM39y4VaHUOk/Ap/QZT9SpJzwE
 50Z1qeDcnzVzlMCh7ROHNvkmtuQ3VjvDsjgrATtQv/aXOvZqffHkDDGKA7v0+FJQG6ZtnockyLk
 bvaAkAscKpdu5AqHi2HJEW89niL18U3Y7qMprYrH/atJxLmAQI8aN
X-Gm-Gg: ASbGncuFILnU3/NekEokGUJZkSK4pEYg+Hj7dpx38soqv81k+Ha8hFKseTxM4++yhGl
 U722e62qqYtDN4pmS/D/YVtSEHBjLdrGnlSSNcEpRCvI84k6NtaN8V13Ue6VDjTVIPHP7XI3Gbg
 GWYVeuEmG9exBysKxQZZP5eK0TW8RFkBgNka1qsM+lLYM/CnCC9JO4PaobB5BP7lmd3og6PPVOU
 NAWDtFDCUEwsyESjRLFvE7BJO405aqV5cvbAEkGecaZ2LSQJ3Juvir3CrW3m88X8MnhlGN1sUau
 O0Di9k3F24xwLDcsK7KhoMvGak5f8Kq2BgI6plVKVlEg7xNlJ0o9RkkahdMGdx1GoqDibnT2Ow=
 =
X-Received: by 2002:a5d:64e7:0:b0:391:13ef:1af8 with SMTP id
 ffacd0b85a97d-3997f9423admr15435986f8f.54.1742918824222; 
 Tue, 25 Mar 2025 09:07:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaf0YLrRC/R+zcROFM6QCU8cTlxCMK+lfkNomyXJgbPKFJFbTxGOheDY38iULhnmPgOAhJog==
X-Received: by 2002:a5d:64e7:0:b0:391:13ef:1af8 with SMTP id
 ffacd0b85a97d-3997f9423admr15435945f8f.54.1742918823796; 
 Tue, 25 Mar 2025 09:07:03 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d6eaa2fe6sm18189345e9.1.2025.03.25.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:02 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 04/15] fuse: Explicitly set inode ID to 1
Date: Tue, 25 Mar 2025 17:06:44 +0100
Message-ID: <20250325160655.119407-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Setting .st_ino to the FUSE inode ID is kind of arbitrary.  While in
practice it is going to be fixed (to FUSE_ROOT_ID, which is 1) because
we only have the root inode, that is not obvious in fuse_getattr().

Just explicitly set it to 1 (i.e. no functional change).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 17ad1d7b90..10606454c3 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -432,7 +432,7 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
     }
 
     statbuf = (struct stat) {
-        .st_ino     = inode,
+        .st_ino     = 1,
         .st_mode    = exp->st_mode,
         .st_nlink   = 1,
         .st_uid     = exp->st_uid,
-- 
2.48.1


