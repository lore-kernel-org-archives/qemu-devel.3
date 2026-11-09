Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cJ92RHnc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuK-0005aD-Bp; Mon, 09 Nov 2026 17:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu9-0005Ns-3c
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:57 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu6-0003z0-C6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:56 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b904d10882so606514b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263513; x=1794868313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+u6Yq2Kmh1DA6S9pJr7fqXJM24Inl6fgSOuDXL+1Qo=;
 b=cJ92RHncxdjAajMsxLiGX2SaMV7uNKgjTODrW2X4dXHE5JA+EthpyKxKzuSsOxKTad
 jkRqa+xVSaVO4CyzoWueX3wqYzAXiohZM43tmGtKI1pIHQZE9B04Vpy+RYFydvBXK8Du
 3gLkoZI1rDuWneiG3MiDN+ctBU03RniicQXGDxYq4AQyKJy23h5c/QeVSHptYrnJnKgD
 Z35onTSQJP7SBBWZ/2LPYoPNDfVyNU33PpuhjHWqL4usFNKvs617T5wCf8E1b0B3GUtj
 mtUSH8gSrgoASy/JTQRtv04bJn2ywcxu9/3SN6MqZhVt8Lh4MN150SwDMiqsssWl0FwY
 lnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263513; x=1794868313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+u6Yq2Kmh1DA6S9pJr7fqXJM24Inl6fgSOuDXL+1Qo=;
 b=t+S1SgEk3ddo0Knmw4mbS4s5M0uLAak92vF4titeTXi0i1b9Um4q7EP0pKQPRMg51h
 nVgj60+mLYEr2mcvQYMmEXJ0FsqGy72mEvC2fV8cte9lmaq+rq591O2AIxNszgdK73YZ
 cxRGDShIPi5rMGxzelNapPu3vlcF2ERAFEFjZ7SWbciOwVbD6jsLWBEVs7CJ/skDVq8j
 x/Vd1m0Dcv8oLNiD5mf6GBkYWBmR33Xtri8gxbaK6Qb0h9DAW34Mj5w8T7x7TF1GG9JW
 ZkWXz28Qo0etHIY4vBGvMnq+0fqMQTo57sz/C5ASH2cZpK5O/c4+EisiG79yOnOzaM63
 7QVw==
X-Gm-Message-State: APuU4Z9XIA5qbxlYoDr8/g/6MXpcI4nEtFIS1GTw9ag40tnx4kwQHeCK
 LFIVD8LDV/l0oitLA9lIyAQNBu7OpoA+JpFFhVjyxDUZlFWV/dGoT+wr8Gt3vHB/P76yb9G3ruq
 eq8tM
X-Gm-Gg: AYBFou1xf8tzeIlo3kCkzzaONYkAhSI3WRXMXQG2xzfXYbBkBH+nnguq4g3bGctSkac
 cVQ/osAr94jXx0OekaCxEsexNFqeXWd6ltWask00cQ3qCDDgLJfhlbjl7cClIR+wiOGQR7pzUCm
 JRuoQTADk2IU+XDHZv1IiPSs4ZmA16kGHCC78xLR/a0kBlEZuuVn5ifiuJxSrv3Pppehf25S/O5
 p91BzQ75AKDISLhLWSh0vPMXI4l0+6sJftLROhSPu/TLtZdVQXwNQ++1NusMjaTjvieo0ue16XO
 MgqGfyrlJ0F0Oa4fwuT/rKcg9OjQLO6CDp321VW1+/2n9jAKMZMmrkjLfcLTqWlNq1y8/cdT+NZ
 Jnpgjab0mf9xMzsbo9blfCFLVEX9tVFJhldz/WQ+e7n/7a2/rnh0CBm/yIUANNVnsfrjZ7aRa5h
 rYBfAW2ae1qRol2KktuspbcPI6iUjQ0tpCbay4lbB479I0wc8ZDWSqoEV3TkkRW2lGgYg/5FKek
 VjRCZ4zifB9ZWSZers/qmcA1i1MlLGkC8/bRyW0P7NHkG/QWisYTvO0oysQ5uHScnthuCXxpfOz
 IrHpE5s1awdxxsqf3kGITMH9yMEvlZRenWvphzmRyYcy5DrAuSdBx6//ze08rgKps3xoYQfiCsE
 =
X-Received: by 2002:a05:6a20:549d:b0:3eb:afe0:20a6 with SMTP id
 adf61e73a8af0-3f18e4cd7c9mr635019637.21.1794263512913; 
 Mon, 09 Nov 2026 14:31:52 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:52 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 23/23] hw/arm/boot: Skip bootloader for confidential guests
Date: Mon,  9 Nov 2026 16:31:10 -0600
Message-ID: <20261109223110.1619504-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

An independent verifier needs to reconstruct the content of guest memory
in order to attest that it is running trusted code. To avoid having to
reconstruct the bootloader generated by QEMU, skip this step and jump
directly to the kernel, with the DTB address in x0 as specified by the
Linux boot protocol [1].

[1] https://docs.kernel.org/arch/arm64/booting.html

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b3d3558bcbc..da4f399a3026 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -731,7 +731,13 @@ static void do_cpu_reset(void *opaque)
             if (cpu == info->primary_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
-                cpu_set_pc(cs, info->loader_start);
+                if (info->confidential)  {
+                    assert(is_a64(env));
+                    env->xregs[0] = info->dtb_start;
+                    cpu_set_pc(cs, info->entry);
+                } else {
+                    cpu_set_pc(cs, info->loader_start);
+                }
 
                 if (!have_dtb(info)) {
                     set_kernel_args(info, as);
@@ -821,7 +827,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 }
 
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
-                                   hwaddr *entry, AddressSpace *as)
+                                   hwaddr *entry, AddressSpace *as,
+                                   bool confidential)
 {
     const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
@@ -873,7 +880,8 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
              * bootloader, we can just load it starting at 2MB+offset rather
              * than 0MB + offset.
              */
-            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE &&
+                !confidential) {
                 kernel_load_offset += 2 * MiB;
             }
         }
@@ -957,7 +965,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
-                                         info->loader_start, &entry, as);
+                                         info->loader_start, &entry, as,
+                                         info->confidential);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1098,8 +1107,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        arm_write_bootloader("bootloader", as, info->loader_start,
-                             primary_loader, fixupcontext);
+        /* Immediately jump to the kernel when guest is a Realm */
+        if (!info->confidential) {
+            arm_write_bootloader("bootloader", as, info->loader_start,
+                                 primary_loader, fixupcontext);
+        }
 
         if (info->write_board_setup) {
             info->write_board_setup(cpu, info);
-- 
2.53.0


