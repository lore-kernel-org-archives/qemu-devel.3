Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EACC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWiJ-0004os-G0; Thu, 01 Aug 2024 10:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiH-0004fI-8d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZWiE-0002e7-TV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:23:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso44145315e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722522205; x=1723127005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I/6CNtfkx/vK3/2m6asJcZw+ghBegtW4R7IRgfjVD4E=;
 b=Ekt+TZyKTOh3e8Uk9xh9H2AcTuFpJ/5cKnknWiK2iJb3sNz2A0l2pWvR89kOX6rSNs
 ssgJlAA0IWJ6iMAjHmfzjiTJsQOMkO0UOk7P/KhLQXZhGfQLnDnMPr/hMG2LDmQDttGH
 Gc4UXkdIcMh7/c3wAo+MUI+rMhLtj1piidd3vmECDfY50csWe6ek5mDcHYGgmfNWgB7z
 n5dI8E4i0I5it71Fyb0VhpAFtF7M1F6/Jz+lG4Q4JBKqxSZkPMp0g5Ke2Be9nWkbYUGX
 FRArZDF5yjOetvGb8JzylITzHSCJRBLJ5a+BJW/sneUtFJvCEbafRHaXE+z497eH+ZW8
 404w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522205; x=1723127005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/6CNtfkx/vK3/2m6asJcZw+ghBegtW4R7IRgfjVD4E=;
 b=LYRoIgxzk6Q4quLVGyz1QFme9GPK+iIJ+cWVNOkxJr9Y1oDfTnvp5EB2TW7idpe4Ct
 PUkYVja77B18/+U8u8tNTIZpMkziGbOM14uShmyFKFMBOdt2BfKE7Gz5gwbUj4vS70MG
 a12cKj+j/ybh+3L5PuwhvPJXgxJQYLSpNgiz1aNZPHc+yqzNzRZxwgd61YMD27JU4Bxs
 xMm0PEUr662MYw+mW7LhNIHkphcrEszeYzCgmwmfq+CWcWvqsHIxecaw6Im3ib8Dx0Ah
 6XPKwcnqyVLkCG07cYlUer5zY97nd/0gGKt8y6tFBZGoF4ZdL1VtFRGcfvFcChVJHfjT
 D8yA==
X-Gm-Message-State: AOJu0YxhwXiiZrGRkfXHE1RTdJjjEdL0u1+hi5Nz/dhNqbsEyMZtpsnR
 bMP7VxIp0AnypfRCQaFEFh3MIeq20C/nXHYPOLQl1OllmSYppqHVkXTAweCRfwgQWoU/o+JKN5Q
 R
X-Google-Smtp-Source: AGHT+IGxHDXVNERd/qiwsLBtD0aEPlVLnxfuSvl3OsVlnfkTXpLlg+KhXmsyIRK1t35Wf6k4jtrHSw==
X-Received: by 2002:a05:600c:524f:b0:428:17b6:bcf1 with SMTP id
 5b1f17b1804b1-428e6b0a2bcmr300065e9.22.1722522205173; 
 Thu, 01 Aug 2024 07:23:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e08012d7sm29657435e9.22.2024.08.01.07.23.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:23:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
 logic
Date: Thu,  1 Aug 2024 15:23:20 +0100
Message-Id: <20240801142322.3948866-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801142322.3948866-1-peter.maydell@linaro.org>
References: <20240801142322.3948866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Salil Mehta <salil.mehta@huawei.com>

Loop should exit prematurely on successfully finding out the parked vCPU (struct
KVMParkedVcpu) in the 'struct KVMState' maintained 'kvm_parked_vcpus' list of
parked vCPUs.

Fixes: Coverity CID 1558552
Fixes: 08c3286822 ("accel/kvm: Extract common KVM vCPU {creation,parking} code")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20240725145132.99355-1-salil.mehta@huawei.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <CAFEAcA-3_d1c7XSXWkFubD-LsW5c5i95e6xxV09r2C9yGtzcdA@mail.gmail.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e1d13863063..75d11a07b2b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -362,6 +362,7 @@ int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id)
             QLIST_REMOVE(cpu, node);
             kvm_fd = cpu->kvm_fd;
             g_free(cpu);
+            break;
         }
     }
 
-- 
2.34.1


