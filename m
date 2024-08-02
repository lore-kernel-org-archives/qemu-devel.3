Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA7C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29k-0001yZ-2r; Fri, 02 Aug 2024 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29Z-0001TH-C9
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:46 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29X-0004As-Kg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:44 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81fb80d3887so213703239f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643062; x=1723247862;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YbJS1lujiJw+GBrT/gz6au1tdNTic+L9ACEewZENu4=;
 b=d9YXHKVkSCtdHQkUyV2Hr9rL3OtKk1HuDE8d+vRiRlSI7iN9Z7A3vUPcZRt6iOGMzF
 VGCNxpgTR3wTPJVQ3z89CZ0Ue4q5e7s1ww0ZVoG7Wp+qR/4A8C53gl5esuDO2sCxxb3s
 fYc8NbdS5yoNncYwcKVod+RIqUil2R0J9clO5/ZfPn+3bQ0g9H8QqSi5k+fhtlunMSib
 1m1TbTWVTJejwdj3Hw7NU++FbhRELMJo+HfD5NNFu6AkBPH+Nz22lUviiXw3q6SSOHwr
 RSkyVpLpFlRTpMpUsJeIsKcF/oGT9diMfzZ1tw0eYFVO84sCcF13AOfEd/7zBdQbe5rH
 EEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643062; x=1723247862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+YbJS1lujiJw+GBrT/gz6au1tdNTic+L9ACEewZENu4=;
 b=l8rjwFSEM+GoLFG/+Ak7RT7FFuBGV6UM7w+VHETbsYcxQbHxYqdQ3wfazpydVDfDgO
 uzzpzrq7bcBoC6++jKX70dtwA5V34g1AQKG/EI51S77epmDESXXmDY0MBZ8U401cciOJ
 7F7XQBaV15/8Br/t/V9yqIZGkpLtZZOUiVzdkgV01pQ0cYNAJG3gqqua/Mx7wpGeKvJ1
 t6E8YJg9bzvEWV06n2w96PRZ1AGdoFvwDDhvOgiIFRRMeMWSthW6hZhI/2UPEMjTmXpG
 8BbAPPs8vWinf0yCc99m3hBPxML+clxxmCYJ7UVjE0adNDxz22LQ879DjRN1Mfh21DvV
 936g==
X-Gm-Message-State: AOJu0YymtCl5QWxvvFF7BpZIlxY3tiSsUNIA50FCJPtLwV+QmELgwuWK
 7O/j2kR8Ph9VTnihep2Zy0lHPupCBBL7WOTtyd1gYP8dSGavWoqRDwmDpVf+WIIrsS9lfe9ku5j
 Zsps=
X-Google-Smtp-Source: AGHT+IHkmOSmtZ3pI8aGjUdQpwWcYxsDJX+nfQRwPEykWpmePdwc9GGimkCC7JuU1e4iMrHmpvP+Tw==
X-Received: by 2002:a05:6602:2b8c:b0:7f9:6afc:182 with SMTP id
 ca18e2360f4ac-81fd437a289mr747985339f.9.1722643062138; 
 Fri, 02 Aug 2024 16:57:42 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 03/17] bsd-user: Make cpu_model and cpu_type file scope
Date: Fri,  2 Aug 2024 17:56:03 -0600
Message-ID: <20240802235617.7971-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

linux-user already does this since 2278b93941d4. That same commit just
added them with main() scope to bsd-user. We need the cpu_type, like
linux-user does, to create new CPUs outside of main to support
threading. Move both cpu_model and cpu_type to mirror linux-user/main.c.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4d29e13a8f5..1533fd51168 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -62,6 +62,8 @@ intptr_t qemu_host_page_mask;
 static bool opt_one_insn_per_tb;
 uintptr_t guest_base;
 bool have_guest_base;
+static const char *cpu_model;
+static const char *cpu_type;
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
@@ -251,8 +253,6 @@ adjust_ssize(void)
 int main(int argc, char **argv)
 {
     const char *filename;
-    const char *cpu_model;
-    const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     const char *seed_optarg = NULL;
-- 
2.45.1


