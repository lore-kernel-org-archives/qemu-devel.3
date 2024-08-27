Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59307C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sixqE-0004IT-00; Tue, 27 Aug 2024 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixqB-0004Gp-Nh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixq9-0000VU-Sb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724771436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FidGmXnxpG6f8PpoDrv303//AyAsBhaUgdFoIqfgnDc=;
 b=gMH/zO1hWRof/MTi2PiTAW6QR5mZ24YsXKaiW135GT+K0O0fNtKNoAair8sPgeuRIrFhJ7
 ak4Nn9m+ezr+7SGWEKjXHh33xBU+NkRNX/X1NHjEDOiVTpemXvh0yLPs6/FR8SWu2lz1K1
 kAdCAGBLaXz228peY4XBHoQuMdThCno=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-XTGDI-MLMJ22Vo-Q8dHvgA-1; Tue, 27 Aug 2024 11:10:34 -0400
X-MC-Unique: XTGDI-MLMJ22Vo-Q8dHvgA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7125fb17a83so3732686b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724771433; x=1725376233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FidGmXnxpG6f8PpoDrv303//AyAsBhaUgdFoIqfgnDc=;
 b=CJEMXVP+f/gOR8nfrlUcEFwUW1Qd7+v6FDTkL+DczwWPqxKL7/L1LpopxSnOVvoSNF
 2UUzJxkYhoxwwr9OdqFq8opAZnJP/N4/+TrHlDaZWcJTdybvurB8btnDr0yA4UTeC2M6
 UIXEUjzJGvlE6CvKZvX79Xib+GbG+j/BYI9rr3adPAzEyQ2Rd9psWVwDP7wzPWNaL/qF
 WRjMDRaN0pdUnsSLV4son1PCRt5ejyfIzBRIAk3NXQ56K++toBtFDFty9Jm3Oe7bpcr3
 BRrn9y7pkxJKADXFbIJUNEsLPOBqP8PkAEOwnWLACeCM0a4NrbJ31Ko0+NaiP7hu03HP
 VPjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSGAOEpLV2THm/2uc39te1sVW/zqx187QGrmHnrfsf6R9DSlJ036pvrO0v4ll1vEYhKo847n3JMqOE@nongnu.org
X-Gm-Message-State: AOJu0YwpO/VA1rmf3DSlMLOG1K9LhD5GlbdHAnBygYPj7bwWeVbHu8iQ
 vxMrVrZ0KuCvPsN1hRmxgwenpwdL6kWkVS5slwVLzXdgbXPEcKOWtYuWVfLOvPfYNgxeVYudcml
 Y62gvnPUlQWJEGv0PMdNHI/ZXW0ip+1xfNQfd/Ot1d4Qrq2xCOJek
X-Received: by 2002:a05:6a00:3c8b:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-71445e73722mr15425767b3a.27.1724771433085; 
 Tue, 27 Aug 2024 08:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlpqBQKIWl8ufEwOHqy+tmzdMjRRi8eswppCnEysYfgdJcZX+AGTQ60Jv9FaPnnjB7kPt5Ig==
X-Received: by 2002:a05:6a00:3c8b:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-71445e73722mr15425722b3a.27.1724771432540; 
 Tue, 27 Aug 2024 08:10:32 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.188])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7143430636esm8679062b3a.165.2024.08.27.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:10:32 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, zhao1.liu@intel.com, pbonzini@redhat.com,
 armbru@redhat.com
Subject: [PATCH 0/2] Some refactoring
Date: Tue, 27 Aug 2024 20:40:20 +0530
Message-ID: <20240827151022.37992-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

replace fprintf() with error_report() in kvm_init()
refactor code in kvm_init() to move core vm creation operation to its
own function.

CC: qemu-trivial@nongnu.org
CC: qemu-devel@nongnu.org
CC: zhao1.liu@intel.com
CC: pbonzini@redhat.com
CC: armbru@redhat.com

Ani Sinha (2):
  kvm: replace fprintf with error_report/printf() in kvm_init()
  kvm: refactor core virtual machine creation into its own function

 accel/kvm/kvm-all.c | 106 +++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

-- 
2.42.0


