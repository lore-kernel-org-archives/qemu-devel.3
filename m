Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8240C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneko-0007Nn-RS; Thu, 27 Feb 2025 09:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekl-0007Jo-3R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekd-0003ms-D9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnzc4UUkvTQN2ZMghuf8CBTQIaTWTUioqbHttISTjcc=;
 b=fPXa/11tCb6aB9/UNQRqyg2P+557rsAIseHGf54R5cfnNcRHJhFyWOuMhCd4F/0zg4NmvV
 X/K4WevtuEl1Ww/mTmPlJ1PXvX7BZp2bGIP/AGmo9kOn3hYCN7MAocfqrRXxTIVjjuzkWd
 a3TdgRd9Bc7bPLfIT/jUWMwwW1L+53U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-tJlK4aAJOdOQF12i_rt2Wg-1; Thu, 27 Feb 2025 09:20:31 -0500
X-MC-Unique: tJlK4aAJOdOQF12i_rt2Wg-1
X-Mimecast-MFC-AGG-ID: tJlK4aAJOdOQF12i_rt2Wg_1740666031
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abec83a498cso114845166b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666030; x=1741270830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnzc4UUkvTQN2ZMghuf8CBTQIaTWTUioqbHttISTjcc=;
 b=ZwYpFQJseMJ93Yl5HFsy3CE1v9rDx/9gG61Epvpgx3dDbysB0fscdjrqjJyqBmWRx5
 0I5YSvG6rcMdfAXzeEvucBJImgdxIw+vZVUAAEQIoeT3NSGorXoOlgHqS/ePms9KKU7S
 Ik/jgFXyIMR4R6l9wtUTgJPXAliS4t/OBED0F1daOIkN+Cw4Jo3Ne70mQrIl6hAKKx5o
 PJSfjCAGqO4hDe8/hU9Wx37r/tgheqlJd4b4FmIbvzLxGTls4Xm/Ts+EiNeGjfirPsYy
 8X/3Rvlj9xh0x11EElwiv8z43IO8VDiV2ubbbG/MU4QAW/xfn4FGeMA/7wcvEhkZcwyB
 bCbA==
X-Gm-Message-State: AOJu0YztdznSbvOp7IVFNpIVeVoPIOq+07KgxwCGauaGw/PbEXeVm5Sz
 PwV1J7JitV4FJeg5Q0V6a49W0Isij1Qhf+r0kOrhAss709l2hiOyCvnfIft6wzcd9J88a0R4mzk
 a86VWXFmkWRDYh+aLdTdSiFWkJphf4myzrw/3q1n9mfTt11Imz9xxlnSO1f3q1la8676NzdPdgz
 8IxFiVajD7/PCWLRh+tfx79HxZlS3QjDt20Ne/JfI=
X-Gm-Gg: ASbGncsaEqDs2DpgAildqROZxNyaJIINKZacckZiS0MvNHawAHn9W/OjOcMh4VET+1/
 vMc/Hn+8SARCHbzu1rjExMPMJ5QjJ+FO8emYxfSq89gm3kCBUikYUZyylT8bSta1dWoGPCbkwur
 Tq+cvrdaTDlmOA1XQAPDDiZCKlfFWedxq/e0pbmP9mhSutI+RcLYfQqnFSK9nzON+sAs09u9iFf
 JIE09tO9005nDaJWG6UnWG7wVd0ie93gPHyLPrgtukhYhS94scvhbfVILDOawiaBFfeVrzbe1rA
 knCTEVkZgMkIyfda2GXh
X-Received: by 2002:a17:906:7952:b0:abb:cdca:1c08 with SMTP id
 a640c23a62f3a-abeeee04193mr935706366b.16.1740666029692; 
 Thu, 27 Feb 2025 06:20:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZjEsyzbquHuhVPmRpyq7dOcfP6JQO5bBZtpIISEktuKe/oYs6IPGguM3FOyZrgD5r+CSkkQ==
X-Received: by 2002:a17:906:7952:b0:abb:cdca:1c08 with SMTP id
 a640c23a62f3a-abeeee04193mr935703566b.16.1740666029223; 
 Thu, 27 Feb 2025 06:20:29 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b98e1sm129714966b.9.2025.02.27.06.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 16/34] target/i386/hvf: use x86_segment in x86_decode.c
Date: Thu, 27 Feb 2025 15:19:34 +0100
Message-ID: <20250227141952.811410-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Wei Liu <liuwe@linux.microsoft.com>

Make the code to rely on the segment definition for checking cs.db.
This allows removing HVF specific VMX related definition from the
decoder.

Introduce a function for retrieving the CS descriptor.

No functional change intended.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1740126987-8483-4-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_decode.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index a4a28f113fd..d6d5894e54b 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -1893,6 +1893,16 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
+static struct x86_segment_descriptor get_cs_descriptor(CPUState *s)
+{
+    struct vmx_segment vmx_cs;
+    x86_segment_descriptor cs;
+    vmx_read_segment_descriptor(s, &vmx_cs, R_CS);
+    vmx_segment_to_x86_descriptor(s, &vmx_cs, &cs);
+
+    return cs;
+}
+
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->addressing_size = -1;
@@ -1904,10 +1914,9 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        struct vmx_segment cs;
-        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
+        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
         /* check db */
-        if ((cs.ar >> 14) & 1) {
+        if (cs.db) {
             if (decode->addr_size_override) {
                 decode->addressing_size = 2;
             } else {
@@ -1941,10 +1950,9 @@ void set_operand_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        struct vmx_segment cs;
-        vmx_read_segment_descriptor(env_cpu(env), &cs, R_CS);
+        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
         /* check db */
-        if ((cs.ar >> 14) & 1) {
+        if (cs.db) {
             if (decode->op_size_override) {
                 decode->operand_size = 2;
             } else{
-- 
2.48.1


