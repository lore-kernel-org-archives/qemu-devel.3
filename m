Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1B5C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qe-0007pf-3e; Wed, 15 Jan 2025 13:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pj-0006hL-UN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ph-0006fC-9q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1lIcA2T55auu2mZERZOQ89Kmxf8Hn1zqHyiZZgMmBI=;
 b=LKtyD7TWv9wJkc5BPAaSAWaKepDl+MS0OA2YXrIrbNZIcgyQa/i3tOOnzLFWphFecCTCZs
 5caVqpwWYau6SZkorkUxRcLSP20VwZxxYj8YbtHxul/DoqzYykHBp0GiOzxmgPxsZYX3fo
 OHYwXZwtGv+cFKJNYlQ0flFbsJyUkTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rExWmRq_M_WhgwjNOZJwEw-1; Wed, 15 Jan 2025 13:09:35 -0500
X-MC-Unique: rExWmRq_M_WhgwjNOZJwEw-1
X-Mimecast-MFC-AGG-ID: rExWmRq_M_WhgwjNOZJwEw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso37154075e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964574; x=1737569374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1lIcA2T55auu2mZERZOQ89Kmxf8Hn1zqHyiZZgMmBI=;
 b=U+38NOZtcs6O01GLlvkpnzF0es0DEJjEdOISFNYueXU6f/c/Dm58frINm7eMIESojq
 l+1qpFWbx7SxnlTNmwH/+09s5AZJct+cp1StEvLIjgdPRcS0G2pUNUCgkYqXOunwLT/q
 4ibweQH3UiYok1Wygy5/ztWpS1/hGI7AHziIVx2AVTuijog8BE2DmGZPFPbqMRZClunz
 kS+S/n6wV0Y23zhDLuBYpwcpm/0Fj6RJmuRCluLL2t9IpfNguuHHib70IydjBI//wdxg
 R0CrxMe1VfobcAbJnbEmueaFwAECt/CiH/1fAzdHxpmHzYdoTw1SuQQP4vj/WjG135nP
 x+LA==
X-Gm-Message-State: AOJu0YydzfKESP5//gbfa8CWpkJrOkY/BgzvNrizrX8ybYHDIp4Mt112
 Tokyen2JesJPYhgt0c5j49bBbeFHSOpfJxh0qSQeXC/+UX3pBJXoWEe82QPJDnjy7fRgB/SHUWY
 3PMBg6K1BNzahquL7FA2bxSNNqZMDeamdrKuJrN3JmmgtYuZ6RM+dTxVeCdbuCgxNE+wlkazOwp
 DPD+zjYGjTBHZ4L3JtrkwOvcemdz5bDA==
X-Gm-Gg: ASbGncsZKJBNWsR9uheksV92vmQb9kE6Vm7CkubxJNIOh1jYKcjlDLfgBJrO0H5qjcn
 yQlq14lCbMHW84iepYZlDlheug0I7fa9rvAdOxk2Eaa7Ds8+AsQUPF9GYE6rTJ2ZH7RL6cfxEOe
 eEKroDsg4PSbWGUSmCsbH7WI3XV03d270PMjEwqpL7jEiAcKv8Pd6/uek9V7BNPgHx8ccUaT1N3
 WtPuZ4X6q/FJJp2lAKcEEJGpR5eFmVYrXR5P3mi+pufLOEVRLSh
X-Received: by 2002:a5d:6d83:0:b0:385:e429:e59e with SMTP id
 ffacd0b85a97d-38a87357af8mr25925070f8f.52.1736964573817; 
 Wed, 15 Jan 2025 10:09:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgTqRDKXt/QMfii/3EI3UdjaEy/Zk8X/TP5tKC61xzB+//RIgBreRPAf3yaLlZ3bU7JFHPvQ==
X-Received: by 2002:a5d:6d83:0:b0:385:e429:e59e with SMTP id
 ffacd0b85a97d-38a87357af8mr25925045f8f.52.1736964573444; 
 Wed, 15 Jan 2025 10:09:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499932sm31341385e9.7.2025.01.15.10.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:32 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 20/48] tests/acpi: q35: allow DMAR acpi table changes
Message-ID: <9609d7101867819086516c7df845337dcee1cf08.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-16-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..46f80be9ca 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/DMAR.dmar",
-- 
MST


