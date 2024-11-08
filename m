Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D15FD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swj-00043d-1f; Fri, 08 Nov 2024 12:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swi-00043R-4d
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swg-0007eX-Pe
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFEKPmesayCxfe6FTizVM3fXCAtel5A94tDgNJwfRzw=;
 b=N5GPE6V7LYTkRs6yCun1jonWvFlBcaNWays4KERulmLrWIC/wvPpobWfAgRwrAN8vew6fv
 tcpOnc7Si5+nyhFjyjkZk2dW5W7WK2rwDFFw37RLLQhbPwe9112we7t++BpYl1/M5JTQka
 cYZHvDOfcROUegrUyh3TEozg8oir3iA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ryy-rE_KNgq33oivD6XqFA-1; Fri, 08 Nov 2024 12:38:53 -0500
X-MC-Unique: ryy-rE_KNgq33oivD6XqFA-1
X-Mimecast-MFC-AGG-ID: ryy-rE_KNgq33oivD6XqFA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d47127e69so1110401f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087531; x=1731692331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFEKPmesayCxfe6FTizVM3fXCAtel5A94tDgNJwfRzw=;
 b=oQTnxss57NNwEtYh2MgihsIbMjH8/onYf90AJwDaaiwhpY9A3dLUxl9fwSqyBLxcCl
 5Xk63pGYg6g2XKr7TgurpcbTdH/37su0flK9ChHecB2zh6UtOht3KLmNEsvClBSqftl7
 qBnDkaE/RTGVzlu/Jc6G+PJjbApHQkc04HCPK+ztySYNte4BTpcSHDqg6d7hrNOz79GF
 di+C9tfltITR9ZnJP/AEQwoJFaDWaE68wuta5vtk2fKGalTfC5/cll40xDKF7+qlA6xa
 A3Fid7neoGGsoNGah4ex9H2W8CFcdb7at04Ypa6DUrBqrGpaa+fzxDtIuq1Gpp9LulId
 fvYw==
X-Gm-Message-State: AOJu0YwwRoci5DWrfHY8izq5kBIfVAGrrqAcTS1sINWDNzC1ofzW0mXJ
 MfPTof71z8pkBsLk1+MF0PMMVJMyePJ7mm0vw2IsHeH0RMn0C6j0tiJ89lDxMwOkw6fPPTVwdH6
 ENs59vmwLPGvFLiOBXczriFsVs+i1SEv/syXoShXwQ3LJyiR5RCfkLJW1IawUfbw6LQ8DDVB9W6
 byfInvoWL1rRAZRabg9ZiohmtveREJRxPmBrOH+pQ=
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id
 ffacd0b85a97d-381f186fbcbmr3232312f8f.34.1731087530904; 
 Fri, 08 Nov 2024 09:38:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCHSNqig3kWTQkYyUnM2sVRWw8fwNDhjLUvgc75Rhf3wFD1dQR/5Jv5GSvWxVr0NIx9TPurA==
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id
 ffacd0b85a97d-381f186fbcbmr3232281f8f.34.1731087530372; 
 Fri, 08 Nov 2024 09:38:50 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97f544sm5565167f8f.40.2024.11.08.09.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PULL 10/13] i386/hvf: Raise exception on error setting APICBASE
Date: Fri,  8 Nov 2024 18:38:25 +0100
Message-ID: <20241108173828.111454-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

When setting the APICBASE MSR to an illegal value, the APIC
implementation will return an error. This change forwards that report
to the guest as an exception rather than ignoring it when using the hvf
accelerator.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241105155800.5461-5-phil@philjordan.eu
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index be675bcfb71..015f760acb3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -794,9 +794,16 @@ void simulate_wrmsr(CPUX86State *env)
     switch (msr) {
     case MSR_IA32_TSC:
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(cpu->apic_state, data);
+    case MSR_IA32_APICBASE: {
+        int r;
+
+        r = cpu_set_apic_base(cpu->apic_state, data);
+        if (r < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
         break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-- 
2.47.0


