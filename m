Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0B2C531DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 16:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seH79-0004QU-PM; Wed, 14 Aug 2024 12:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seH78-0004Pw-11
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 12:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seH76-0002Ln-Fx
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 12:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723653882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erdV0C39tgYWZRKxE1+NQz9R3647EY6jag+HGv6dCRo=;
 b=VXrjS3pxsAbfxpPHBsF7BTs9yDOdTvqfs0a647pByizJWpL41WZUMGB+CLg3VPQPhpWql+
 +C6pyjX40xtB3vCBEEzss4Fzc8M39ArIdR4eCY8kCXejvnxWiVUbBb5qy1LKZDXNJrNvyH
 ABgmXFIVifinujNYzdMzpRm8RYiAkHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-oesTO6jtND6jqgMaLYi6CQ-1; Wed, 14 Aug 2024 12:44:41 -0400
X-MC-Unique: oesTO6jtND6jqgMaLYi6CQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428fc34f41bso51850925e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 09:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723653879; x=1724258679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erdV0C39tgYWZRKxE1+NQz9R3647EY6jag+HGv6dCRo=;
 b=LZ0XpY5UzNNvOdF7Y+/7PiJ+f6q/Oss36BRtStstFapZjJuhD+mAhQmMNf/zq1rhfz
 qLqq7kuclUtcpGXZ405rcgLrFaAUn6htbbpGD9yErGelVYJt8ALBH8yoSVHnaWpdjAA/
 ZhtFNadWEunSm1QiAgFaCSfo6HHerwS/fx2PT3iKmuu/ypPB5SXNUeuFbiaBqu9qtD9M
 kNibCHka2JeHNnEKZ2GSBT6Elof+xY4Jko1PeKkRnkyVadAxgpCfk9DwZqFVWa2QeWnD
 Gx2wTBGB1EvY0vDv/KJU0v3P2sX/+qKmDgil0MZejnS5z46NutISFVgBXUijijcU6MhZ
 Wmow==
X-Gm-Message-State: AOJu0YxIaCqrRsgOmeGIBTYevN+AxDNwzXL4Srhs8pWrksXMCpkuh2RY
 oM9Qwzdxtem8Qo07hKgdf3GlIqRUN7qtNJ/Y613CDZISEUj6fE0XTvbkQWJA0IamNAaTlavOehO
 j0ifDhUs8NQJCVuSZVg110adLnBi86sWW/LgCSjjcj/QLYTnFKaXhqf7QUq+8ULBq79FUAdiYCU
 sVzWQ7DcPBl8x6wPA1zM+sJJgYUo4rKLxRoKoj
X-Received: by 2002:a05:600c:470a:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-429dd26c28bmr25953535e9.31.1723653879259; 
 Wed, 14 Aug 2024 09:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLK25T3TX32NzfACVHi4J3OUHHKlIW6rN0P5THW5SH5iECctRz2B/V+p2SM+0SXdAmD7JXnw==
X-Received: by 2002:a05:600c:470a:b0:426:6c70:dd9c with SMTP id
 5b1f17b1804b1-429dd26c28bmr25953315e9.31.1723653878702; 
 Wed, 14 Aug 2024 09:44:38 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37184283603sm450136f8f.73.2024.08.14.09.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 09:44:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anthony Harivel <aharivel@redhat.com>
Subject: [PULL 1/1] target/i386: Fix arguments for vmsr_read_thread_stat()
Date: Wed, 14 Aug 2024 18:44:32 +0200
Message-ID: <20240814164432.271179-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814164432.271179-1-pbonzini@redhat.com>
References: <20240814164432.271179-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anthony Harivel <aharivel@redhat.com>

Snapshot of the stat utime and stime for each thread, taken before and
after the pause, must be stored in separate locations

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
Link: https://lore.kernel.org/r/20240807124320.1741124-2-aharivel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31f149c9902..2fa88ef1e37 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2712,8 +2712,8 @@ static void *kvm_msr_energy_thread(void *data)
             thd_stat[i].thread_id = thread_ids[i];
             vmsr_read_thread_stat(vmsr->pid,
                                   thd_stat[i].thread_id,
-                                  thd_stat[i].utime,
-                                  thd_stat[i].stime,
+                                  &thd_stat[i].utime[0],
+                                  &thd_stat[i].stime[0],
                                   &thd_stat[i].cpu_id);
             thd_stat[i].pkg_id =
                 vmsr_get_physical_package_id(thd_stat[i].cpu_id);
@@ -2777,8 +2777,8 @@ static void *kvm_msr_energy_thread(void *data)
         for (int i = 0; i < num_threads; i++) {
             vmsr_read_thread_stat(vmsr->pid,
                                   thd_stat[i].thread_id,
-                                  thd_stat[i].utime,
-                                  thd_stat[i].stime,
+                                  &thd_stat[i].utime[1],
+                                  &thd_stat[i].stime[1],
                                   &thd_stat[i].cpu_id);
 
             if (vmsr->pid < 0) {
-- 
2.46.0


