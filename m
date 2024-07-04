Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDE7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEq-00076P-5i; Thu, 04 Jul 2024 05:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEj-0006oT-0O
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEh-00088O-2Y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3cYvj5uU+nN/F2qMr7WF3fjwOiYUBjz++YEMm43ueI=;
 b=FaCCpdx/gYE8Xdn6zoOKWzSGz4qGjWlIKS6+UJx8sBQJiLocbrGwg+9rJfyzHck9FU+6VH
 1Y4aXXjH5cMQ/d20JA+a5DmsaVl6kyp5N4ksvS0UJqd6yEWLupSdnFGzXQG6wDQkLzho2J
 F197iH82dw5QAg4rWUa6G67D/wNwGdI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-3abIG9b9Mg-LwzYgKsfyqA-1; Thu, 04 Jul 2024 05:58:39 -0400
X-MC-Unique: 3abIG9b9Mg-LwzYgKsfyqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990a5796so327964f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087118; x=1720691918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3cYvj5uU+nN/F2qMr7WF3fjwOiYUBjz++YEMm43ueI=;
 b=p0C64IWpfslj1R3Nd2JQmR1GBKJ/sXbYarf84HI/HK+JfflxtWLUNr9rN7XCO4gce4
 yxS7WdaAMOwt0D+kZVWJmJJPkOOsEsGsl7c3iwKYEqdsCn4B1p8uLcoCM/5DdRzSVSKI
 Fv9lYq5czZv+Ul/xUhKcDl1k+fYrAnOihx0/+2A9fBZNU7/vSv4GvgGvvcwiH9zTHMft
 f+IybFqUyfim7iCF4rkzDsUlZinpyqAk9v/CH38cUyvZE4B27EV343CW5rase7ux0RRA
 WpJ4fBbgSrxSB5NNjFkJAlMs3Em0ZjPIJ8XoQlkNuBh3SkIP9FTIZQdzFA/J6BSsmOvy
 2muQ==
X-Gm-Message-State: AOJu0Ywkngbx3+DUoFyaSz6b7zes/WfUTEzxynoUXBuBm5bH2Yxn0L3q
 fRf8oUr1KcgJeplzTDL2lAnGvClRxUh/WuQVQEiynJwQSkG20MQeFrMiYDuiA4wdoZ7WaUXhKJ3
 4MWcbHG57SXxX0H22rqiYbyu7dLhjQzHdPb/l+6gni5ZqwqXbBgi1DateeHyzV/a9mrMT8LoViG
 WWxDlhalS68T045JzFUnYe6YXA7KjsNXMfjP9Z
X-Received: by 2002:adf:ed49:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-3679dd547e9mr1072970f8f.37.1720087118522; 
 Thu, 04 Jul 2024 02:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLcRS0a81rrU++UgUxCznRNHJ0gaYkNI/TL3izcN7UbeUahDDOXDs3q8Qw6UShiNbW4Mit6g==
X-Received: by 2002:adf:ed49:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-3679dd547e9mr1072958f8f.37.1720087118185; 
 Thu, 04 Jul 2024 02:58:38 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678f41116bsm5012238f8f.116.2024.07.04.02.58.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] target/i386: add avx-vnni-int16 feature
Date: Thu,  4 Jul 2024 11:58:03 +0200
Message-ID: <20240704095806.1780273-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

AVX-VNNI-INT16 (CPUID[EAX=7,ECX=1).EDX[10]) is supported by Clearwater
Forest processor, add it to QEMU as it does not need any specific
enablement.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c40551d9bfb..c05765eeafc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1131,7 +1131,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, NULL, NULL,
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
-            "amx-complex", NULL, NULL, NULL,
+            "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.45.2


