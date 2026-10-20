Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A64606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gQNXc43X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7ML-0008Ew-4C; Tue, 20 Oct 2026 06:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7K9-0004gv-3V
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:44:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jk-0004US-8j
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:44:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2157157f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493018; x=1793097818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FGqirORdiYAHpa8WKE6kkRgcY8UYqpJTtFDjbgGTNq4=;
 b=gQNXc43Xd1+ACu6H7IdDP7o3weBOa8ijZDg2K0BK3aZeuVZ5GH2iStovwFmNldp3LM
 xtFceYeo6X+15ZaMtXMafXdd5sk8miAF6jR+ufjJo7fl/Fh0VlzUGdafx+0Ggxx3eR5G
 2rXBU8qPVk5pff7vBBY2vz8B4NifgsEIiYc+bjcHxdJ2zAXnp/3n9we5pIpWCQgka2+Q
 7W8EkTuI08kyV2TpanoDo3FTTNv35bXNf841xo/RrCtCc6sbTVta7SzYWtAfoQxFM3xK
 Cp+DH4EA8jUku0DWyVfB2TdgiZf//MA0SbCdwPLVkFVzmnciB8tq+naxFf3jF0j21N00
 hJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493018; x=1793097818;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGqirORdiYAHpa8WKE6kkRgcY8UYqpJTtFDjbgGTNq4=;
 b=ENtdLA4pdnA8dRYuk9ZWaQBIHEw45FPPTTAXf5c7Tss1ru3vdHYXrnKwLBr7Jaf3/4
 GckO9m5Q/B4gLDQGzj0T7N4aqmiBOtiS3Wjj4NoK59v1n5GIl99jPRoP1bDcUcIup37J
 8y50SOQQZPks7Fdxr0yNemUliPsuyTvX92BEfvymCNnk7COhA8tP1S8WRV6BmUs6qTOq
 HN8MsP8eQcqb6i8+MEFC5XEMk8KDDO/Iqiquj2D3b1WaxEHe54QzAwgp5vuMJoekXCWC
 jLAFJSF61JYCLt3tJjGGBslCg4XQuli3xjqFiR1ME+3K0ShE0bXKlEZJDNIRWSGGtA45
 Cv7A==
X-Gm-Message-State: AFq9FYKdIs/+bl7ftaCkdHUUOzfb5+Qw2Lt7rI0I+V6wTZ69oJ4cd0bH
 SpEBNLPWIaJTLy/YgfyFOQQMx05IllWkZtfXr0FG4mmhqGU/kITxcwvcfC2lDIPOi2A=
X-Gm-Gg: AYBFou37lQxhW9ACGx9WiMrWp4nWW/SyXRMKqrMTBZ3jPpk1mnaMR+U9d8pZLijyMmX
 KkYIacp6u34ZdtP23iRW17zxa54GUtAgdz6NNZxjY2baJmWnAr63qbqZYuCwYqI+Cd2oS9iPk5p
 5GHQCg6WD65TEUby1dfpX1OnSxDQLPELsSotQQ9qC/7pjnJoXE/7Ue6Xn+bmVchz7iNVyXcTlDp
 LXYJ/zJp9hKyBv8csrl1QP2SZ5ileFNSPAD+RCSmZj6DFiKDZJ0kIdXKPL+ZK9huXJaCTn8beRp
 WxTzGaFAv58Avc8wZAdlmd7iUywap/TzANZ5M+2WHPJnJA9gSW4+SuygemTcNs2/rcZ2j09HsS2
 ojyIV3sBDFBpAzUekHKPaVqXFGix4aihWxrXUpcQhSWZhXiHGbJVKPMd1QWkMwdQA1L5a25buwk
 OyNw+mXb/DnPkrKqbsNi3OzDH1UzxnBoxxVJifwdIHjveK4VFl8M7Txh/o5XNa6MIhE1J2Eg==
X-Received: by 2002:a05:6000:186e:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e07f9d49fmr23637520f8f.28.1792493018396; 
 Tue, 20 Oct 2026 03:43:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d83a338sm5303864f8f.59.2026.10.20.03.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B49C25FF9E;
 Tue, 20 Oct 2026 11:43:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Cornelia Huck <cohuck@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 23/23] accel/kvm: remove redundant ops checks for
 kvm_get_cpu_ops
Date: Tue, 20 Oct 2026 11:43:17 +0100
Message-ID: <20261020104320.3686723-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We assert that we should always be able to retrieve KVMCPUOps on an
initialised system so remove the redundant checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/kvm/kvm-all.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 041113ed9b5..8b719d6eb44 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -455,11 +455,7 @@ static void kvm_create_vcpu_internal(CPUState *cpu, KVMState *s, int kvm_fd)
 unsigned long kvm_vcpu_id(CPUState *cpu)
 {
     const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
-
-    if (ops && ops->vcpu_id) {
-        return ops->vcpu_id(cpu);
-    }
-    return cpu->cpu_index;
+    return ops->vcpu_id ? ops->vcpu_id(cpu) : cpu->cpu_index;
 }
 
 static int kvm_rebind_vcpus(Error **errp)
@@ -3190,7 +3186,7 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
         bool stop = true;
 
         fprintf(stderr, "emulation failure\n");
-        if (ops && ops->stop_on_emulation_error) {
+        if (ops->stop_on_emulation_error) {
             stop = ops->stop_on_emulation_error(cpu);
         }
         if (!stop) {
@@ -4004,7 +4000,7 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
     QTAILQ_FOREACH_SAFE(bp, &s->kvm_sw_breakpoints, entry, next) {
         int ret = -ENOENT;
 
-        if (ops && ops->remove_sw_breakpoint) {
+        if (ops->remove_sw_breakpoint) {
             ret = ops->remove_sw_breakpoint(cpu, bp);
         }
         if (ret != 0) {
@@ -4021,7 +4017,7 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
         QTAILQ_REMOVE(&s->kvm_sw_breakpoints, bp, entry);
         g_free(bp);
     }
-    if (ops && ops->remove_all_hw_breakpoints) {
+    if (ops->remove_all_hw_breakpoints) {
         ops->remove_all_hw_breakpoints(cpu);
     }
 
@@ -4116,7 +4112,7 @@ int kvm_on_sigbus(int code, void *addr)
     assert(code != BUS_MCEERR_AR);
     assert(first_cpu);
     ops = kvm_get_cpu_ops(first_cpu);
-    if (ops && ops->on_sigbus_vcpu) {
+    if (ops->on_sigbus_vcpu) {
         ops->on_sigbus_vcpu(first_cpu, code, addr);
         return 0;
     }
-- 
2.47.3


