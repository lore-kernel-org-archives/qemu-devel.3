Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D6C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yl0-0000uO-MG; Thu, 02 May 2024 11:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykp-0000oi-9n
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykn-0002Mh-PQ
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boGg9/rmbZBhJJijlTtUdnXqVutZGINTHhkrDaVixoA=;
 b=YzgPuKvppcfJPo17ytumUasTH3SrAPg3MOnzhon7MoTF7SQVlwdS4wWiDqeirvMQNLx1MV
 7tEb/om1uDPSGXHezU5ugVa0WGThCAQtPQ/1fekRnxzBwCgZAvyavJozJhonSfAtBBIkiA
 uVTKTUlaV3wg7qzQQdiN+jSkjCi30/g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-b5tCyEX3MdCv_hWIlMHKiw-1; Thu, 02 May 2024 11:53:48 -0400
X-MC-Unique: b5tCyEX3MdCv_hWIlMHKiw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-572b3091d68so775988a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665226; x=1715270026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boGg9/rmbZBhJJijlTtUdnXqVutZGINTHhkrDaVixoA=;
 b=AgGlTVnuFi1Zkt5sq98XxCf3SKPA5SfXamtdNz2ZZoN1Hi2taUzoSK1ZGFRLwmm4vi
 0ZT+PAPpkCgzFmKNWIFAMoCmz4wG+YcqDAzBMISHI/+Gh4gAdxl0dkeOz6kkPIETXqdk
 pLc4/QVS32I4nx2hhCWUE+66Pnf2esLqK4xzbzU5a293gY91DXEruw5emepLp1GWXTbx
 2QcdgPAkbroyI2cZ+33r5pjZU/z6c6wyMzZOkAdo4BdAXOxqjIamhkfhtQ1XOBNgjvNW
 Palf4qnSIIblXdfHJ17CcJFK3x6j8BZKZoGcsUL/sbJgTMxfYzN53FxGmvE+amMnwZ7Q
 WrAA==
X-Gm-Message-State: AOJu0YzOnHifOMsMMUCKk5EUHSN7rT2F/OuaPq7nMo1JxzLbEUWp1Udh
 BHSZPxo+/uAQ0U92KngG05AfblpZNZwA+EYP5iPYy8cGV/4wyeBGayM28AqQwT5vLKAj87L4OnB
 /FVDjqTEKYOADr7b9wT7iyOQq75qq5n/5xvtc8eJczyA5mQ+Vfkdzn7hUhuPmaaw35zb72TJzKq
 QXaGmgea6Ec+Zg/4ZqIHQCijAAAr4uBiu/hFlQ
X-Received: by 2002:a50:c355:0:b0:570:1ddc:5e4f with SMTP id
 q21-20020a50c355000000b005701ddc5e4fmr3642857edb.8.1714665226585; 
 Thu, 02 May 2024 08:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5EJ8ohquXin+hLNXdcy+91JPwBmZIwrCI5MF0zIT8C1ZlHHP3vStIpbIaOpZmK5WA8/+rPg==
X-Received: by 2002:a50:c355:0:b0:570:1ddc:5e4f with SMTP id
 q21-20020a50c355000000b005701ddc5e4fmr3642850edb.8.1714665226339; 
 Thu, 02 May 2024 08:53:46 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 el4-20020a056402360400b005725ffd7305sm646743edb.75.2024.05.02.08.53.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/13] qemu-option: remove QemuOpt from typedefs.h
Date: Thu,  2 May 2024 17:53:23 +0200
Message-ID: <20240502155331.109297-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

QemuOpt is basically an internal data structure.  It has no business
being defined except if you need functions from include/qemu/option.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/option.h   | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index b3498287823..01e673ae03f 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -54,6 +54,8 @@ enum QemuOptType {
     QEMU_OPT_SIZE,        /* size, accepts (K)ilo, (M)ega, (G)iga, (T)era postfix */
 };
 
+typedef struct QemuOpt QemuOpt;
+
 typedef struct QemuOptDesc {
     const char *name;
     enum QemuOptType type;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 520f421397b..4519f0cd613 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -108,7 +108,6 @@ typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
-typedef struct QemuOpt QemuOpt;
 typedef struct QemuOpts QemuOpts;
 typedef struct QemuOptsList QemuOptsList;
 typedef struct QEMUSGList QEMUSGList;
-- 
2.44.0


