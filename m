Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9A8C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPU-0005ZP-Ef; Fri, 28 Jun 2024 13:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPG-0005Xx-R4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPF-00029R-DY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INLXKQAnxyLlbt49tJcziQ4qLBnfUf83esez+1sBRI0=;
 b=L7n14Oq3gXom2EdgM4JHElORPY8gYv7PRuMZbbcV8bnpJ87o6zWw0mCDoRLlRPWVv8B65H
 qJT/09/WpSHCWhdxG07CgGn9mUtB+i/5PQYhwwB0xhNKNzD1DalvFfD6hT8wAfM0vGrp75
 JXCer4q+wwvSOP14ZOs9kNrjtQSyW/8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-v9FYkyJPMmGOAjA7UA7GRg-1; Fri, 28 Jun 2024 13:29:02 -0400
X-MC-Unique: v9FYkyJPMmGOAjA7UA7GRg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so702072a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595740; x=1720200540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INLXKQAnxyLlbt49tJcziQ4qLBnfUf83esez+1sBRI0=;
 b=f4DzxdS1gLXSgAseQq1ZtNqpgiyDEx/pXk7In8/W0JORFDz5gpt1MmQpV5wAFthJEH
 WtLdffB9eenc1qYVvjXvu1rllTZcbfB59NTxLFfdJWk6cj/TogP8T6KvDediVMUvOgVZ
 0ZCaLXAllUZgfa3UhMIceCcnOprWBue+fqRsfeF9Bzqbt1/U7e3Oea6zSSy4VMsUVstx
 KYx2F4b78/wDL6JZUnSGApbxoLS3dbRWJ+A4buzNhT0a2wrv573yr+HLAzATqgt/5FQp
 DbI7y884GF8Y+3W1jiW9GazGReiz5OyuTy2MZ42MYyFfx6y8LZH97no/ekiXFUXv1xk7
 z9gQ==
X-Gm-Message-State: AOJu0YzQ3cfSR9zL31cKFvHWRl4xXUw9qt0v7x4OvdzBGSws0nx2pjX9
 poyCEwrqElCh4pqnoAoNXw1Dg48xvqMm5RYWInUxLggNgBj2xpWhGHyqQlOJWp6HGDXQJsL53Lb
 8rjlrt/IvzJoiYySUH6HemR4Ct/6flPIJCB55KFriWTgRPmbr0S7oqfYEiy4NFLhexIj7iTNW30
 yjWMKqXpfBbq6Iqx9fayt9kq2QFXmzw0aw47tD
X-Received: by 2002:a05:6402:2106:b0:586:1d26:1b4c with SMTP id
 4fb4d7f45d1cf-5861d26215fmr2373241a12.37.1719595740386; 
 Fri, 28 Jun 2024 10:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/5gebsMgK2FjR8MWaXrRdFQ5/t7sozq2ESEK2FoeFROhhvggmbuJbBMICn+ca6F8vNCPeDQ==
X-Received: by 2002:a05:6402:2106:b0:586:1d26:1b4c with SMTP id
 4fb4d7f45d1cf-5861d26215fmr2373226a12.37.1719595739986; 
 Fri, 28 Jun 2024 10:28:59 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835dfsm1273877a12.20.2024.06.28.10.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:28:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/23] configure: detect --cpu=mipsisa64r6
Date: Fri, 28 Jun 2024 19:28:33 +0200
Message-ID: <20240628172855.1147598-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

Treat it as a MIPS64 machine.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 5ad1674ca5f..8b6a2f16ceb 100755
--- a/configure
+++ b/configure
@@ -450,7 +450,7 @@ case "$cpu" in
     linux_arch=loongarch
     ;;
 
-  mips64*)
+  mips64*|mipsisa64*)
     cpu=mips64
     host_arch=mips
     linux_arch=mips
-- 
2.45.2


