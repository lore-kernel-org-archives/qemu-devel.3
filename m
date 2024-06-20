Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609E4C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHRj-0001jD-GG; Thu, 20 Jun 2024 09:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRi-0001fc-3D
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKHRg-0006Xt-Lq
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718888599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6tnGmP8UAqa4G+onMQE8JTTdn8pIGx/VV2/Iv84CZc=;
 b=LYW7HDCMEwWVEVxADfBbITx5yvthyZK1ucg2ndKM9ZwWZhbywQ4sChHFG5g0upw9ExEX+n
 cIl88fasVtQHb6UHV9Asqzw9IUaRHg7GGo9ZK4otlBTcuR+/mGJdMXyG3ft/dCtws6Nxb9
 cbGBELKtctIUdOpkVK0Q4RJJ7Imxadc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-afH1yldQO9WsZEOkO10R0Q-1; Thu, 20 Jun 2024 09:03:17 -0400
X-MC-Unique: afH1yldQO9WsZEOkO10R0Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ca8a3448eso649078e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888595; x=1719493395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6tnGmP8UAqa4G+onMQE8JTTdn8pIGx/VV2/Iv84CZc=;
 b=BE4JyUpRwvOLCZTs23vqFJe6RT7g1s0Q1Vw25yJOCTL39jOFNG/9u47S1wAVFeET8f
 tELBphppr1qCTiRxUcEZxRXjVCTk9PjEa0GXx+BIiYIdQf+fJaYf5e8XnlDOk3aKEiHn
 tcuHQOB098jNwJWi+VTHvGByTXY4L4SjStaJblSrN51+I5hSaEjlT0qmQGU2xFVacea1
 w9rIm35El7WcfajRjWKgkUhaePuo1exna/aryxigVD+Me8b91YUxiiV7CoWPNof0vs+B
 3gIu3hJIrPPUTCGT2fBxDQGfdcnvVkymkLfJMNPASljO5LkR4OJtviOz1XFnOF3diHzS
 T7wA==
X-Gm-Message-State: AOJu0Yya8WrxgSDq6zl+6heq8Nzl7t0Ee52/mNKxXb4dHtHdYjTTG7VJ
 KYHziWGOi4gFB1yLIqH2dNiz+UT71yIZSCEeVsmARYcvMQ3Mmk5LomBYXsJKUq+hxDFoSe31Vuv
 U9GRt4ar/84riFJ2+rzVO2bPVePecs1vp5s9FT+xpsjPXYQ9NHMJfh7cCM7eghZZLhbomREofg5
 pB4ACuLIK1LyLH02iDplmcIcaTnFJh6il37g4W
X-Received: by 2002:a05:6512:2252:b0:52c:8289:e891 with SMTP id
 2adb3069b0e04-52ccaa2a86emr4908286e87.6.1718888595035; 
 Thu, 20 Jun 2024 06:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6w9f30q/hsffICkeJ4Q2+BFb7ayRlH0zqxsnrJL2YMk9kd59EDpZqD/RJXcC8nzuwt9gEtg==
X-Received: by 2002:a05:6512:2252:b0:52c:8289:e891 with SMTP id
 2adb3069b0e04-52ccaa2a86emr4908271e87.6.1718888594749; 
 Thu, 20 Jun 2024 06:03:14 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f939296d8sm248435866b.35.2024.06.20.06.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:03:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru
Subject: [PATCH 6/6] meson: require compiler support for chosen x86-64
 instructions
Date: Thu, 20 Jun 2024 15:02:54 +0200
Message-ID: <20240620130254.415699-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620130254.415699-1-pbonzini@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 54e6b09f4fb..c5360fbd299 100644
--- a/meson.build
+++ b/meson.build
@@ -2863,6 +2863,7 @@ have_cpuid_h = cc.links('''
 config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
 
 config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
+  .enable_auto_if(get_option('x86_version') >= '3') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
   .require(cc.links('''
     #include <cpuid.h>
@@ -2875,6 +2876,7 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
   '''), error_message: 'AVX2 not available').allowed())
 
 config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
+  .enable_auto_if(get_option('x86_version') >= '4') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
   .require(cc.links('''
     #include <cpuid.h>
-- 
2.45.2


