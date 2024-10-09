Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45CCF0436
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syTHt-0001TB-ED; Wed, 09 Oct 2024 05:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHl-0001KC-Kg
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syTHe-0008UF-36
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728467224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1CI3G168F3cDdpDRHRzVTftyK0R2VTAU16G+izB978=;
 b=WhFcb477KsG8e4k9LAiUUVu/QhYAE7h2bUKx2dVmq28bgHcoictBlEQgeUmt9KT8NOnTqE
 M9c3Ia8gtqhU3hHEVvEeMlU5ffHdC2j+kPHxqhlp4+qVKO6VEZVp8j/Tf0/wUVCFBLlnk/
 8lQIqZ1fDiNzIc+pugmkUdTe/d9KZIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-K3KqFFXYNQGx2gLgkn-fJA-1; Wed, 09 Oct 2024 05:47:03 -0400
X-MC-Unique: K3KqFFXYNQGx2gLgkn-fJA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8bso42681755e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 02:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467221; x=1729072021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1CI3G168F3cDdpDRHRzVTftyK0R2VTAU16G+izB978=;
 b=Cy4wzEZ5I/ye04yDmlUGpYrgMSVKuJab1m08bDmK8KYexZxh+tYkSkEYDb7KwfE/jD
 Da2+oxDmj6p+eKIUJpqiT0Rs9/GPrRHjDzxHdL2l4SzqfLlIA81DG/l+GSzaf68dOR59
 wlBuALC24pC4x9eoeXb7vD5syZ7kYPEafBIWQDy/Qdpw2UjEb+cneF1CV14AMY9pJr+k
 EJYQnR+IEVBSJKTX5QQSDolNR/1e7noe87hgDAdDwQ7QxtehTuXT+MjTwu/l6fo7apUX
 j2QE0+2EyhKV9ibzF4jQ9DMD1QS8+EowGHKVeC8brRKpXO4Y+AnMWrQTJgjdLlca6EaB
 s0fg==
X-Gm-Message-State: AOJu0Yzr6IPNwN7eZnv80TAHl8oaaU/mJ7jjzclFoURgdQGMvDFBbd8P
 kvlAu3x3TnLONCxICb4UWos4QxsT1H/nu6yriu9oxCIl0+JKhSVngVOZ9YgZ99F5x5bodW9Lc/j
 9ILXNfRxKpu1gtkBoaCjHLsi+2aFoWJMY8/gWjiGbPIZwOc3u7GbeqB3lPaarVIL2JAmz1Lbn3C
 9KEBWi9wVwj6UJ5rU0HoRtAeKSZ/kenwrhQ6uQgGU=
X-Received: by 2002:a05:600c:4ec7:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-430ccf1b2ddmr12148545e9.6.1728467221015; 
 Wed, 09 Oct 2024 02:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFts8NxvM7Mj36SOAQ+JIZEYrfQcvdR1aD60/HBtRXgCzukplxUlmUzquhMfi3ZOBe7gplTMg==
X-Received: by 2002:a05:600c:4ec7:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-430ccf1b2ddmr12148345e9.6.1728467220531; 
 Wed, 09 Oct 2024 02:47:00 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430d748f0a5sm14550845e9.48.2024.10.09.02.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 02:46:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/14] meson: fix machine option for x86_version
Date: Wed,  9 Oct 2024 11:46:11 +0200
Message-ID: <20241009094616.1648511-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009094616.1648511-1-pbonzini@redhat.com>
References: <20241009094616.1648511-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

s/mbmi1/mbmi/

When configuring with -Dx86_version >= 3, meson step works, but
compilation fails because option -mbmi1 is unknown.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/r/20241004223715.1275428-1-pierrick.bouvier@linaro.org
Cc: qemu-stable@nongnu.org
Fixes: ef7d1adfa85 ("meson: allow configuring the x86-64 baseline", 2024-06-28)
Revieved-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b91863736ea..76335bb2a51 100644
--- a/meson.build
+++ b/meson.build
@@ -375,7 +375,7 @@ if host_arch in ['i386', 'x86_64']
     qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
   endif
 
   # add required vector instruction set (each level implies those below)
-- 
2.46.2


