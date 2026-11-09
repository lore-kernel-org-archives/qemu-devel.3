Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3F606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YOvyvhVp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXu7-0005LZ-Bl; Mon, 09 Nov 2026 17:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXth-0005Cv-R7
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:29 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtg-0003sf-59
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:29 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8b67f25e6e1so629263b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263487; x=1794868287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e6cGpCW9ua2cMf+lJeF3kZN84gK1Yf677YZr+Kh5B/8=;
 b=YOvyvhVpfB0px+PFTCg+4p1qowAW+bWIPIXwt219g+sarG7KxtFFvaRNJo0CgWoOnE
 jRAmxnnK5LEv5NejL/9KnDPSqEz2vgqe7kHRhhbS6hDHR7tsCl4LAOxD2WacXwFDYtge
 P78AnyVEMQOlaUpp2+M5xDnddg9cV3c4IGU02r1nP9kQILrxbMY10XIt8Y981oobdn1o
 +DBa1Q1W9ehqNWXtvS5amEqiMjhF5VkF3SrF2hduL/9g49Xu1cs+e/i5bXRnGMmb8+oe
 Hsc9VPjMiICW+Kk8oF3idUaQ6X5SuvN7hYD4VAIsQQVRJJsTpTEeJoq9vhGIbV+1KdFo
 /gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263487; x=1794868287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e6cGpCW9ua2cMf+lJeF3kZN84gK1Yf677YZr+Kh5B/8=;
 b=0Zqely+NAle6V7OnAsIJAnCzAKqox62qAMYCsyD8I/eJpxFOf0ATM3/RSf6+A5VY+F
 i70EtSv9nov0g8lRN1ziwHu1jriXz7PNc6Zf1Jj87x/YB6Kd5wOLLvzBzWBYn6i9hFZu
 D6B8z59RtFf5Jqe6kXqX/qIuwFqu5136xQ5IX3TlyHE/6SqCYMy4r9Up8zxXNZrp4Qu5
 6gErmMdE+9iiSGI3RreS8xBcl8aNUXoDq3cUB5PoL44Ot99uxZGaAN6S8Jtn0tAQhknu
 i7LaAt9fIaIKql65fGOhzYQRYbF8GaCq91rKjymKgCBuKG7hZYB69G2Qfo+KHmOqEycS
 KzAQ==
X-Gm-Message-State: APuU4Z8wc4tIhqQAIRM4AOPSUBAySEDJUaXVjeUEiXm9FRNM8Mt+gHLw
 Qak0VpYNb/nTI987aCkYWBFe5fVh5ofIu7npuKb4X49Erqf1n9lCdRO6iKmdF3qob3w=
X-Gm-Gg: AYBFou0K5FNkL69jrBZywYQsyEqPdKMlwRJFCpXrOhcaE3ZTFvwyzSvq7x+ZieaGix9
 9rRmP9cpOvkCB/liFmarW8OiDVYOaXdqYjcp2kNFEc8ZYOwKnDSmPQTyONAhfjbf6dwBXfjz/OS
 Z+kFasiDKETyMDJwajhiVJLm6nmexa2pPrmSAK8x9hLr+5EIM65qf0R3G4rt9gbf8qLcDtx7ZPz
 oqx3z1mZl9CZsLu+xgJChnvG/zKamNAqKklJVOItHx4jIs5yjO9AMYvrLMbv9a4M2lDFXRGFq6Q
 F+bxOeVwWoa3P7LRSHZQ1U1KDMTruCyZqBGvvAFTVaIt4ydMG0vuUDwZ0xCeSVC9wuPaPbk7od3
 QU8fqiVhUWJ79JqjfdM3wF+GJn6L4RKatYoJ/wEjACZsf4Gb+UPEokkzzdfG7LCnzPA6y4NZHbA
 cllSbHnXRKMDmRMKp1O/UJXZ3oTWTbthYFe+IOUotGZl2VlNxNc6J1OUTWxJGSOm7maAW03qcxx
 NqA0EqP5H1NBubQ1bKQ4xIpqUFDLVzSxHGSxPd9h6cNtz95xmfE/o3TsINcfzXpmrWxrVK6Z66T
 u13uwGFJZfTYrlI3x3+L5OiFXW2jJGMtys8ZmdoNEnW1zYtieYoHEiYNK0DooHbf/zopzRnTjDM
 =
X-Received: by 2002:a05:6a00:a226:b0:89c:d875:603c with SMTP id
 d2e1a72fcca58-8ba882e23b8mr929126b3a.53.1794263486735; 
 Mon, 09 Nov 2026 14:31:26 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:25 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 06/23] target/arm/kvm: Create scratch Realm VM when
 requested
Date: Mon,  9 Nov 2026 16:30:53 -0600
Message-ID: <20261109223110.1619504-7-mathieu.poirier@linaro.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 30
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 941951a9bc05..63a3e78efd53 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -110,6 +110,8 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init, Error **errp)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
@@ -122,7 +124,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
         max_vm_pa_size = 0;
     }
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         error_setg_errno(errp, errno, "Failed to create the scratch VM");
-- 
2.53.0


