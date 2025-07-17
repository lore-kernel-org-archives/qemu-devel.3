Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E148C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCv-0004lF-Ci; Thu, 17 Jul 2025 14:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSS-0004dq-7q
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSP-0004LA-5P
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2WlmBVN2Qucvf1vEE6nWUJB/kVdkIb8dEtL75AIz63Q=;
 b=GjKvVlIQmb7Gq7h9wZdysYQSvDug6GzFudjrs+nSmDSb89Z0bSMNfS5ipami1DstyUCtjx
 yqusZsAfiQolaLTDzMKRSWFNAGvSMyDvhzFBvDvCM2BrHSRRRBj7DDbjVuB+RPP6w5I2he
 7pUXFUdzpld4SqxK6fQfDwbtDB6IVgg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-HCWi4nO-N6qm72AlbbfqGg-1; Thu, 17 Jul 2025 11:23:32 -0400
X-MC-Unique: HCWi4nO-N6qm72AlbbfqGg-1
X-Mimecast-MFC-AGG-ID: HCWi4nO-N6qm72AlbbfqGg_1752765811
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4560f28b2b1so3939395e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765811; x=1753370611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WlmBVN2Qucvf1vEE6nWUJB/kVdkIb8dEtL75AIz63Q=;
 b=U/WrC2sOPINLBsJNs+7mVULyf8f8N+VlEOG929CWOJvX3s39sR38YWkGDzgmp7Q74Z
 MX9s9n4UPG0FCmnePwfO6mmYKkDBQ0Pl64IusiNcC2rz8cYPe6gaWuLhFkuOxDSzZiRB
 AoLDWrtYlVejxJ9EfWtA1bCqJwrfjAoFee544p/YXBpe3nAqvM6gFmbTY0k4Jm7kM0WU
 tks340DyRzphHw98+M1BtA6HSuYVmTHmYMU4TL72+DI7QzEQO8HLk+GA53ULxAMEyY9v
 qaXtFgFBGdyR5lNtDlsqGCM9hXgoOhmUSs9Taa2lnUxqIwjLM9F0IgRvCjInt1zd8Lcp
 pyog==
X-Gm-Message-State: AOJu0YzeipijDy/Om8YYhuQwwfh6oG9ovEOPS5Mcq40J73oxboMMI2XX
 GyaASs5NR++SgphQshfrbpuRx/6AtOiVTM3Zjy7VOh97XJvQVrGGqMrase402B4ILyXDm6MSOiQ
 zYe0LuvfKeMspUcTWRv3Y/jHW2ZAL5zlQMy3pgkqDs42Rh/SETWadO4anBA3Yj+4yfVD5HfxZ83
 fdFffFtE/WI1uoLpPH4xvbVPOZaE2H2qARLxSckB5z
X-Gm-Gg: ASbGnctA23qZx7DVE9HOiAfQLu1LqyhH09TLjpessg5LJauWyOF5+vCTeqi5yHhgqJa
 9wkgDwq6mIsspS/1ilD4NK/ZZz4IWS/mQYvZMMjVk6F1iw62hdoOYOs8sj6R3uNNlL5+dFDguT4
 4TTLat+R0K0HK0HIjKH7c+jejJtnjtHyZKoNI7jjYoB/pgMVXTACrQLInOJ7tS2jLtyAjLgqLi1
 fLAxEaB6ernHX3FutE+ffNn42sph8l4tZyyroLKkVXXkRsXgsL0Xu28aTDAweP0IyNAsWieXb27
 mPe1MQVxjuxRh1o+h/5F8OdaPiFce0uBgTmBQEyiIvs=
X-Received: by 2002:a05:600c:8b85:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-456355c60d3mr30190975e9.20.1752765810925; 
 Thu, 17 Jul 2025 08:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF67RAZBw5pAQGPD0Rra2YQASNKHOLGkzgIaXyjKt0rQcg3SLQOiJfNtU+Yo6hAi05d7dFIMg==
X-Received: by 2002:a05:600c:8b85:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-456355c60d3mr30190615e9.20.1752765810367; 
 Thu, 17 Jul 2025 08:23:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d872sm21195130f8f.60.2025.07.17.08.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 5/6] i386/cpu: Cleanup host_cpu_max_instance_init()
Date: Thu, 17 Jul 2025 17:23:15 +0200
Message-ID: <20250717152316.353049-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

The implementation of host_cpu_max_instance_init() was merged into
host_cpu_instance_init() by commit 29f1ba338baf ("target/i386: merge
host_cpu_instance_init() and host_cpu_max_instance_init()"), while the
declaration of it remains in host-cpu.h.

Clean it up.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250716063117.602050-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 10df4b3a3a7..ee653242254 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -12,7 +12,6 @@
 
 uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
-void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
 void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
-- 
2.50.1


