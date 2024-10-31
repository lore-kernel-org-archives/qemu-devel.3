Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADABD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLb-0007La-3H; Thu, 31 Oct 2024 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLZ-0007K5-At
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLX-0007Db-O4
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCIBueuJ/pcmxe+TRoueGGm2RCVvnQkhXWm8H+WbDa8=;
 b=MwXr++QQNcV6/gYSlnN38+DYgAOvOjWZRa6kEC9AE7NS8/MSPIMU2Krp0LLia6qM0woAgn
 uMKC3563CmfnfR0L38OolZhIABxk7aFIsi8kWdui9KYVrYScSABHVEKgEQHXvzEdOYBzvv
 /Td3y27cZVS9H4mFbTWD3ag9haQFzPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-mTeZk3mNORWzfuGOewHZ7w-1; Thu, 31 Oct 2024 13:52:33 -0400
X-MC-Unique: mTeZk3mNORWzfuGOewHZ7w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso7613715e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397152; x=1731001952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCIBueuJ/pcmxe+TRoueGGm2RCVvnQkhXWm8H+WbDa8=;
 b=RKw3/s5Jx3yGEtwXi5gkdqSzQSn9XTCqFVXngnHWjgSDDj/BiF1npTg/QrEuAYzFo4
 lKEhvQAgx55iWIn7sUDQs0gNc1Dz4NS1QynaLN2XTntpE0+U0VpgUl96ijjLE2mVxMpg
 9CeEY9bNKxwi8/1fz4ajK0tz3axPTu5j8SfykAOtMnQYUglE7+jo/rzQ+vpENXZeAawH
 RiBxo/qYrKIWVMo+VSu28YOf0siq+Tb5z/Z7A6SNJDKybVNZ2VvBVsEuPUz+pbDiPAeP
 v5J5yLgGwfbmAW+9pOd0zGlSXtRm/gY7DZkbnHTorgKdERWZn+WYqtNIutd/Idey4xdk
 HRvQ==
X-Gm-Message-State: AOJu0YwEji7CAl85+U+y1sqAHsgCEcQ7kpakopswQiDzRxkOaWSmi/Bg
 3Wi9WcoZFx9KCP0+TAkqKtwRIBkw9xg9EnZm2v/xONFDIDPvZQ/qw07p9frJSNwSgCTJ797BNJI
 nlGP2EnZxb+3LwzYafQcomHXhevvhYnyVFz2KSQYHwByaMOlXvbm+h8mXNQ6KlDg05OrziMWC+H
 5rwt7GFjKLqiENd74WozltUoSaRhwKSxzVZM6gzkQ=
X-Received: by 2002:a05:600c:45ce:b0:431:4f29:9542 with SMTP id
 5b1f17b1804b1-4328323f81amr5370675e9.6.1730397151959; 
 Thu, 31 Oct 2024 10:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEnxZ+A635LUGRJH808Ax7yFl+rECJ5qqTCSGSNsB+Y+PdstK+1lFMSbiWfc8RGjsIDBJXHw==
X-Received: by 2002:a05:600c:45ce:b0:431:4f29:9542 with SMTP id
 5b1f17b1804b1-4328323f81amr5370565e9.6.1730397151488; 
 Thu, 31 Oct 2024 10:52:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm64423495e9.21.2024.10.31.10.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/49] MAINTAINERS: Add myself as a reviewer of x86 general
 architecture support
Date: Thu, 31 Oct 2024 18:51:32 +0100
Message-ID: <20241031175214.214455-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
index f48d9142b8a..58c71f753ac 100644
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


