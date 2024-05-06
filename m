Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA660C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSX-0005qJ-2M; Mon, 06 May 2024 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRo-0004wY-PC
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tR5-0002aD-Cp
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xBPt5Wem4MwOzjHbh3JuP/s1c0HFZtDIzVQz3NedIhI=;
 b=bx8SAc6F+Zyo0eBrkGmt7c712i+9KSu8IUW4hCvoHMHb9OQ80dC74cnPwvy3Es2RdvTX4n
 lYYaR0siaDUxsYObP+EthI39R5oqbvRdV5VRnUiFWUvJ4IwrcdOdtU5QnsfeRZYJtDyPqe
 v8dE9t8vw0H0BoDZy18/5PkuOA7mdqo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-fsjn5i53O2-NGRLWSdqEcw-1; Mon, 06 May 2024 04:10:56 -0400
X-MC-Unique: fsjn5i53O2-NGRLWSdqEcw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a1fe7396so116797966b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983054; x=1715587854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBPt5Wem4MwOzjHbh3JuP/s1c0HFZtDIzVQz3NedIhI=;
 b=olCB8Rzhiv7M/GtSKk6TinAv/AYakev89vGnI7ufs5KQuFDUV9Nrkl0cdiAXfJ9xRq
 CxEoBcxmz7vkKQyY9I21GBr1d3KuICMiwhCTE70DgwDBCnxYAkxjNGAWsiQC5Qj++Evf
 aIUCd8pxt3z125UEvawM3zUXBZUgljDyPkeVtE8dOzUWkahJLxzIzzx7TEsqYGKm0Mdq
 ttNw/YGumRcO/vCiy+u/BqrTC8BUqaot1KhDD/rLKOJyblFl4Tf5TvYp+RkrBG4/0d3E
 uq7YaeqoAIOFYfYGtT4u8LUu64GDuMyCowX31OWSgzO8/v29YxLkQn36az6/ygS7zhrx
 1/Rw==
X-Gm-Message-State: AOJu0Yw0q0Ze8w0Cx+A4GS45ynwYHJSOyNKmP5uyTpdZTWNgT4Sh1eMX
 x7yV1Jrovtz9CB4yrUVMuoQkowV2Q/bo0Q6Ma9K7+amP4e5MmdHTmAN5z63Wylj2eUqAMHjIMzt
 R912mFd4AwdtzEvwxnREucLsFofGU7v1N50qB3qkboR1txjCqF0gkinkIfIj0NWhLu95xzGOzQu
 Wi4SGMwTZB+3l4KMCAua37ZaYyHiCKAaHN8yYk
X-Received: by 2002:a17:906:2ac5:b0:a55:6b76:eedc with SMTP id
 m5-20020a1709062ac500b00a556b76eedcmr5281517eje.14.1714983053828; 
 Mon, 06 May 2024 01:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKom9/vY1pzPb9pxvJNkw6J1K4MAD3xjK1umJ3Mh612T47qQnSA/ffpIg7i31bg/QXjum48Q==
X-Received: by 2002:a17:906:2ac5:b0:a55:6b76:eedc with SMTP id
 m5-20020a1709062ac500b00a556b76eedcmr5281505eje.14.1714983053387; 
 Mon, 06 May 2024 01:10:53 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a17090648c500b00a59a85053c3sm2799088ejt.16.2024.05.06.01.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 18/25] target/i386: merge and enlarge a few ranges for call
 to disas_insn_new
Date: Mon,  6 May 2024 10:09:50 +0200
Message-ID: <20240506080957.10005-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Since new opcodes are not going to be added in translate.c, round the
case labels that call to disas_insn_new(), including whole sets of
eight opcodes when possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 79b6e2760fe..b94d9504090 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6868,9 +6868,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
-    case 0x138 ... 0x13a:
-    case 0x150 ... 0x179:
-    case 0x17c ... 0x17f:
+    case 0x138 ... 0x13f:
+    case 0x150 ... 0x17f:
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-- 
2.45.0


