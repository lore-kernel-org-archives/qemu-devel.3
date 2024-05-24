Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915FBC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWvG-0000Eq-6j; Fri, 24 May 2024 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWvE-00009S-Ji
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWvD-00079j-5h
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716564809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o5pj81AZEUwQ0Lg5tkoxH8oknLAgvUBA1zppo7S2F2M=;
 b=W+TLaXGviRB2uG5eS3dGqs7qEsMSGFBFBXxSOXztqN+6fPlmvP6f5FVHNkkrCfU3YGWr9A
 o1XCww8txX/RCAKSl9o0/YQWh/Hj8O2azfjMpMfZkP9cPi7n13bk5snEs2dE5E4JD84avD
 yGPw4OjzglC84jsluJHYPNg2Kb3vUTs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-nME60Af3MdaKl9nmVPktow-1; Fri, 24 May 2024 11:33:28 -0400
X-MC-Unique: nME60Af3MdaKl9nmVPktow-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a62684ef298so50264166b.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716564805; x=1717169605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5pj81AZEUwQ0Lg5tkoxH8oknLAgvUBA1zppo7S2F2M=;
 b=oM9C0AH5GYN+7De0sxR6Uwc725l9ckKK8qdtLri5baHHinQLPDF8nbID52dCyqd0f4
 py4zSuF2jUQY7ni94jhkUcdbgO8vmhnowl73ioOb+nTeLCqSrAt5BRqw7cqnWbXGZNQY
 6XXLa3+t9eD33htCtbO3kENk1rLovEwWDffVnzksh6rvR2SYvVi8fKyNGYQeDtQVYqtd
 YStwWbyrQ7L+ZbeZ0GAMKXhWz/LvKtBB+zE/X3asZER/ZQEfEl727jwGmy3xtfLVekJQ
 ZfR1OHLpynFsqa0BirYVedkOOGJamE5bC7mCvfG4b4tjXrsq3tNotFTQlhwn+zRCSsR5
 QqzQ==
X-Gm-Message-State: AOJu0Yzw5kwjfaUs/oKUTigFCmliZVONQp+cWcn9zTBcXySq7NA8/WEf
 GG5LVngB0UhyD4Qas9i4ZeBV5fkZtr8C/qVmYOwc9wK7oj7tixn6mIKUXxDSu/8OOuJ90uIy83b
 6IxmW1ktHqJRwJsE5JEojG40ZsJVh/+lzE62RNynQmIp80rrvD7uRNqAyi90mWO2HfqnqfLf7Ac
 OeNFtr6nGUXBwItH7yZfzuTDZA+GaZF9Sc4CzW
X-Received: by 2002:a17:906:3896:b0:a61:bd80:7ba6 with SMTP id
 a640c23a62f3a-a62641a56c3mr155067366b.3.1716564805360; 
 Fri, 24 May 2024 08:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6H/p7jvqjkGSfKMsd+RlDWQxDLGe5ueShc9ZfBnlbxeHs72Qp3/zBN5Kq6KcetypTNbMhw==
X-Received: by 2002:a17:906:3896:b0:a61:bd80:7ba6 with SMTP id
 a640c23a62f3a-a62641a56c3mr155066066b.3.1716564804814; 
 Fri, 24 May 2024 08:33:24 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817b15sm147568066b.40.2024.05.24.08.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:33:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: disable jmp_opt if EFLAGS.RF is 1
Date: Fri, 24 May 2024 17:33:22 +0200
Message-ID: <20240524153323.1267511-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If EFLAGS.RF is 1, special processing in gen_eob_worker() is needed and
therefore goto_tb cannot be used.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76be7425800..ebcff8766cf 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4660,7 +4660,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
-                    (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
+                    (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
     /*
      * If jmp_opt, we want to handle each string instruction individually.
      * For icount also disable repz optimization so that each iteration
-- 
2.45.1


