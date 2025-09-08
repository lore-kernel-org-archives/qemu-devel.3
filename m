Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080EFCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsq-00025q-AO; Mon, 08 Sep 2025 06:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsk-00022v-17
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsa-00011y-OH
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nuKa0pQnnRbuWROMsoY7tGerozDA9x5CjuoP23Xwkg=;
 b=H8a7y+8RO8TEwiiBBuHJz/HjeblQ4BhDGP2pcRRQfFafb5zVYbj/JDCsDsiDubjsXJTAt3
 6dUIBiPzSVhjGMUugqwz7elvgGIltUEOeV5bfd5s7UoRJ3LdWXCnqryZfLwNPw764AMX5J
 sCLN+OhjgpF86Fxc8zh4zxymdwl89iE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-pkc1EtrlPQK0liLb-UdwkQ-1; Mon, 08 Sep 2025 06:13:33 -0400
X-MC-Unique: pkc1EtrlPQK0liLb-UdwkQ-1
X-Mimecast-MFC-AGG-ID: pkc1EtrlPQK0liLb-UdwkQ_1757326413
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2ba0so2034822f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326412; x=1757931212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nuKa0pQnnRbuWROMsoY7tGerozDA9x5CjuoP23Xwkg=;
 b=ijmDNY+7n/95AlqtHnUZ9QyyD+8bOf04cIB7zjIGKSWftXecbjzzmQRfIaG7j5xkoL
 IVQTWt27kMdcnKAlK3Kx2+Ys+61OO858q5Om8ua+4NIOv9NGj0fPLJjCt4LdUsphnBah
 Z/xxEwO08eMD92NUs2zXz/rshDMDxdK2XpJ9Wl/fvszTkq2UBdjZ4TtfSpV+Edr9ua/g
 ONqv5rZMdPwH3WPNimbKz/tk9sk6JAzfipDRWwIPb7cCEdN8+rwM4N3T/B+7ulEKE875
 t7tbwgKKdYdtnJR5xjaDniyiHhjzkzFs8vmfdhhfTpMS7rDknlD8NxFOWEzEOFaZcEPN
 0BEQ==
X-Gm-Message-State: AOJu0YyY/QMxerg8USgyjQ/S65KKc/ZFKoAGZHI3+n5NDqen/YPtGXyq
 JdPzzwqB4fNYNXkjqYUd+REmLSkecQbmK9RRazMQYTTa3bnWCQxvV4NHSBVwE4ZnHDhWh+deXMN
 WMnVT+HdmDrTT4oWCdILK2DnRbLA2H0SWa5a/cCpNRMW+8/WmIFmwYE67ZC0Sofm/7eYOAwgOAM
 3lqYtLjo1rVVYtPj1WCucaeYQt4GyXUsOtabll1XcO
X-Gm-Gg: ASbGnctCSbGdoC28Dw8n9wkAl52L8seLB3Rm4N7K2drrC54IwStE8qHiaUtlXNm8rqd
 dYIwI0DbfZxAr/bPQyQ6+xev7gZmsWzAAsLZyxiTQw4MededRMzURSRenod+yG5fEiOaapCOr14
 ZLS7ZtIxr8jgK/0ks4FK2E3POcxmHssoxr1iXGiJdYndQqeKMKSeqjZks9f3CeGFqQJYeHKH2iB
 HlfL82KTBcNcOwSj8pVkQ185x5EuQv8dHZ4R9SHflFuxeaE2iCZDwuviwDyVZT5h4X+xYhLePOA
 TUtWUVgOfzJ69EQrsyOtHmHEtG2dMNC5prohhx251woU5U/dqBggZ5KfQYl8ku3Onr4o65/uoUC
 /5yGH8lnbNf4kdCFpvKYxQGV7eDQ0eIXiUo60ZfaNZlY=
X-Received: by 2002:a05:6000:2285:b0:3e7:4334:2afe with SMTP id
 ffacd0b85a97d-3e743342e6cmr4399706f8f.5.1757326411858; 
 Mon, 08 Sep 2025 03:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm9IeoOJnq1GxSimtNLaafTKR2wFYYFuU5wLNExCZ92RuAwuojRAUeUShXld3eyRPwc7mQ8g==
X-Received: by 2002:a05:6000:2285:b0:3e7:4334:2afe with SMTP id
 ffacd0b85a97d-3e743342e6cmr4399672f8f.5.1757326411372; 
 Mon, 08 Sep 2025 03:13:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e748171834sm3967668f8f.5.2025.09.08.03.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 19/19] tcg/user: do not set exit_request gratuitously
Date: Mon,  8 Sep 2025 12:12:41 +0200
Message-ID: <20250908101241.2110068-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Whenever user-mode emulation needs to go all the way out of the cpu
exec loop, it uses cpu_exit(), which already sets cpu->exit_request.

Therefore, there is no need for tcg_kick_vcpu_thread() to set
cpu->exit_request again outside system emulation.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ad94f96b252..7c20d9db122 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -751,6 +751,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -758,6 +759,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, true);
+#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.51.0


