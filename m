Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435CEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yl3-0000w4-RC; Thu, 02 May 2024 11:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl0-0000uc-MA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yky-0002Nu-48
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZJdvq9u+pJ5rwgcC5tolr3XsO6TG5/7lA6NafLezNw=;
 b=Wcq4ve/UJVLvoi5S9WOkB9D3uiSO85T/GV/0kgeNRaHo8b/Flxxm/UoN2tMZrXKcfkSEfO
 bSdGf7JJTTrJNTSqcq/yrsFiegowknljk6LJz4usITUHLPmOycEpDbZQ2FaLVdX8RvHqJz
 5SxPcRT8HPGd8hS3nws1JC5qU3aFfes=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-UOI9T2-dMEuukaLLyGHJRw-1; Thu, 02 May 2024 11:53:57 -0400
X-MC-Unique: UOI9T2-dMEuukaLLyGHJRw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5725f45da8eso620488a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665236; x=1715270036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZJdvq9u+pJ5rwgcC5tolr3XsO6TG5/7lA6NafLezNw=;
 b=Vjvpo+7eeiJloy/Of2aiacyhRJ35H0Ie53+HpP9VM15nKChTGChkDJHHt8QayXfZ4K
 0ziHRrtW3p7bGEMXGOaVXCK/9UnwzFB608iqGg8wDp0xcF4KeRDDyiG2rvOUwAONT6aY
 zbao7QVShpVMOyLqa+z6D1wN4X5VdPruJeEhFa2ZBgsY1/5zg42/L+bxVwZUkhVvm0Vg
 S88KoOPdMTpXbELXRylZ/OEuVxtaEyPtVPLyam0E3S19vHI8TaO7GapWXfWnoNARwqNh
 CBB6xs0m47oGx+eZWHRtaoEUqbUnPwz0Z1FQ6/8ntHaBxj6Yx7kYHyRTI+eLPHJxGqOq
 HqEw==
X-Gm-Message-State: AOJu0YzC8Aib9XiKd9Tc/62nX6CgK172nKoO9m9HUqYFvDrLoBp7/AkI
 xyTRddldhvyjdgB/kPyN5zS3mRPShpLcGLAIK9iuUdIFReXnsWl6MklPRv5Y3dVgpeUx+MiLCIc
 5x5cfQnBKoZ+qJiGYKfFkJt3xhwdQnIxhbCHLsGgcKmawz7vbeMJbPjPUXt6n0TuSbQmyyo/j8w
 QbfnRgmVUeILPiX1YI0kywJ/NyR2OoFuwB6DW3
X-Received: by 2002:a50:9f28:0:b0:568:c6a2:f427 with SMTP id
 b37-20020a509f28000000b00568c6a2f427mr1697489edf.27.1714665235876; 
 Thu, 02 May 2024 08:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+vxRpf9L8OFjXnd7+Eax+UJbrfaZfG+jkCTnWqZMKhFx05cg9A/ERjvA1cjscqbve2A8KqA==
X-Received: by 2002:a50:9f28:0:b0:568:c6a2:f427 with SMTP id
 b37-20020a509f28000000b00568c6a2f427mr1697480edf.27.1714665235523; 
 Thu, 02 May 2024 08:53:55 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fk4-20020a056402398400b005701eaa2023sm665014edb.72.2024.05.02.08.53.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] migration: remove PostcopyDiscardState from typedefs.h
Date: Thu,  2 May 2024 17:53:26 +0200
Message-ID: <20240502155331.109297-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

It is defined and referred to exclusively from a .c file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h  | 1 -
 migration/postcopy-ram.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ab24ca2876c..2b1948a19ac 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,7 +96,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct QBool QBool;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index eccff499cb2..34197795482 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -44,7 +44,7 @@
  */
 #define MAX_DISCARDS_PER_COMMAND 12
 
-struct PostcopyDiscardState {
+typedef struct PostcopyDiscardState {
     const char *ramblock_name;
     uint16_t cur_entry;
     /*
@@ -54,7 +54,7 @@ struct PostcopyDiscardState {
     uint64_t length_list[MAX_DISCARDS_PER_COMMAND];
     unsigned int nsentwords;
     unsigned int nsentcmds;
-};
+} PostcopyDiscardState;
 
 static NotifierWithReturnList postcopy_notifier_list;
 
-- 
2.44.0


