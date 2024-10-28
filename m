Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2772D33991
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qli-0001g1-HC; Mon, 28 Oct 2024 10:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlU-0000iC-Nl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlT-00041V-97
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANrTQw6sylLk0MOtalh3eFn5kIjq1iikw1mOMtK6UAY=;
 b=iS0ubircX4y0UWJXDD3CxNfy/hzwXkLY/k2PqD04Ke6Hdygaq1lSmtv3KdJ9qIg3L6j4SF
 QnL5gek/+A5f8O8+dcQbQILIvakWRaL5w46+/FlskUtTUegd6u1B+aP83CA9CVJimrM/+5
 jHno5bhT47yuX/8rY2aJ4gy8SyUBXKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-jaNMWRIYPBmHbOsBTQlaqw-1; Mon, 28 Oct 2024 10:30:37 -0400
X-MC-Unique: jaNMWRIYPBmHbOsBTQlaqw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso2171946f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125835; x=1730730635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANrTQw6sylLk0MOtalh3eFn5kIjq1iikw1mOMtK6UAY=;
 b=pTze3OMoVzXmWqa8JDJ7eQnFSlQi/H5S0Pl5qUtMcqUFdKlXkD10G8bM2XrReN3m8i
 f7WT00Sf1GYtSSy2pVLe89a0WnEjWAMxqmjFiYkTUPvJl4JS1Ym1UkTjYRiXwV7HbAd8
 EGjJYXc3U4aCgHDsE9AEEJKwig5e6DcKh3SJP2HIcZgpxmACeb25kG5LQfZSVgqgrMLV
 f6KC3khOKfB2uTY9EnGoNuCCf2RHO7rNcmyDrnYZvkbAJbQW89LdOFevsaQCaert6fHm
 qEMFszvVrDxMWFYFrHOyhRaQp6DyJUW8t3U89Bx7vxT8XmHHIhoWLdUtIPwY1vOOLUrJ
 jpNg==
X-Gm-Message-State: AOJu0YxX3RKVCQSV7ujBa3AOLnCPQZ0/JIXF5DESAh4LcJqqGosaaKlF
 Gj8rbxTLTetWotpkbaWTbjCNWnOTBBHGzylPNYsgMoVbojF8tjPADYnB7drgCSFSMrRTteFUB3i
 bweko+9fkzPAKiRZMzrkJ0SPOyzg6fR2VA+XGfGzLCyqWdY3Ix7vBBz9wOt1EC1ZL/kRX8Vw3Uz
 VZNGpdNmraWLdGsk2Xwf6dFj2HTHadZORIVPgRsqM=
X-Received: by 2002:adf:ce0d:0:b0:37d:5046:565 with SMTP id
 ffacd0b85a97d-3806120085fmr6710308f8f.40.1730125835096; 
 Mon, 28 Oct 2024 07:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZEbzKaqxkHSPWqbBy/nv/SzGNxiAlvAwg+MTqSgxU7md2VRQkxlk9g0APXSIVS9wVskFRxQ==
X-Received: by 2002:adf:ce0d:0:b0:37d:5046:565 with SMTP id
 ffacd0b85a97d-3806120085fmr6710262f8f.40.1730125834339; 
 Mon, 28 Oct 2024 07:30:34 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b91ff2sm9629177f8f.96.2024.10.28.07.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/24] MAINTAINERS: Add myself as a reviewer of x86 general
 architecture support
Date: Mon, 28 Oct 2024 15:29:31 +0100
Message-ID: <20241028142932.363687-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

X86 architecture has always been a focus of my work. I would like to
help to review more related patches.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241022023628.1743686-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3bfa132fd6..db2880253d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -132,6 +132,7 @@ F: configs/targets/mips*
 
 X86 general architecture support
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: configs/devices/i386-softmmu/default.mak
 F: configs/targets/i386-softmmu.mak
-- 
2.47.0


