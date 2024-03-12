Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992EBC54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Wb-0002Wc-Te; Tue, 12 Mar 2024 13:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uk-0006Q8-M4; Tue, 12 Mar 2024 13:00:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Uh-0008Tt-Tp; Tue, 12 Mar 2024 13:00:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6ac00616cso652559b3a.0; 
 Tue, 12 Mar 2024 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262849; x=1710867649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr9X/khHCq5RJj3YA08mgEJxiJTU11rgfAwzxF4mODk=;
 b=RXr2t3Ep3lPUtqd27aDRuMzfnFZ9nWKRs2Srlsullw1xqu2UMAMI8NM1IDbQ5QcAOZ
 2Ic0J7htH948rat5JhOj9SEJ8kJJwKbzx5HjbP7lGTIkJObh3OCG9hD+Sm2MZwuGU+iH
 TDmaaLG4AnCKSvKzAqJecfuLY5i4/+g0XsAV6W+pqIBUyCFg7t6u0S6O69RbFx0napNa
 0qYrPIdZmUAmB0A9BsVuV5f1MjSi+n16u/r+LRKUjQN5OPyZS3h6UniLYGUQGuEWyrFu
 nWV2dt66vOR1yJHQwNDn01etIwperahKruB0bjnXj+vnvgSmVWX5fRa1ZvnOX2jgDgif
 fWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262849; x=1710867649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qr9X/khHCq5RJj3YA08mgEJxiJTU11rgfAwzxF4mODk=;
 b=fDdiH49Qg21cqnFOs3nGBP2J60g89Gn8LfspMW8kPAfj3jQ2RtXePKWfob5Fy3f/W7
 sPJli2H9IjM4bsUw3NJbEYScxiLVQihXy2f+yTVhmpy/oRIGdrmsRBehdTmD5aySCrsD
 Nzzgh/X3jv9OsgsK1I2UaI/oIQqcsLh23YzdFYCMQYHcI8V/0fi7QxYuqn7mO7g6kD6v
 xzKBuDA4QQg9VjOvcIncCwAYBNoOVlvznzvaUtbNili+s/Dm/tFjE2igj81dgWLeunlo
 A8j38tCkB01NgDENlSKedC9uj7yvU/SMh6fh6v64XxIBwCGogrUxywr/dK6t+aOTJsMo
 XyAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9nOEe4TofKvnJATDvfTlCwhZYD1xVIQZDLn51PmWtfNXgzi4A2xMk5BuEEuWDF1D25oN7wa10vaMLA0EyXO2Yg+Ir
X-Gm-Message-State: AOJu0YydW/WyGMC8tkDCXA6EF3HP/gLXUukGEeXWgvO0SydhKB53zvAQ
 fPEKaKgiHB/WqCUQyFT4pk1s9C9hR0XCiIiIetW+DumA6aCZvijjR2JWXzKpgzQ=
X-Google-Smtp-Source: AGHT+IHemoe2+FCjItln5gMGjhCxQ9LURgsjtF/MnwwPbVx8kfykepSpZEoMHtulyqoVhm12Vjy+HQ==
X-Received: by 2002:a05:6a00:8cd:b0:6e2:d162:6315 with SMTP id
 s13-20020a056a0008cd00b006e2d1626315mr5941pfu.29.1710262848147; 
 Tue, 12 Mar 2024 10:00:48 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PULL 29/38] spapr: nested: Document Nested PAPR API
Date: Wed, 13 Mar 2024 02:58:40 +1000
Message-ID: <20240312165851.2240242-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Adding initial documentation about Nested PAPR API to describe the set
of APIs and its usage. Also talks about the Guest State Buffer elements
and it's format which is used between L0/L1 to communicate L2 state.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/nested-papr.txt | 119 +++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 docs/devel/nested-papr.txt

diff --git a/docs/devel/nested-papr.txt b/docs/devel/nested-papr.txt
new file mode 100644
index 0000000000..90943650db
--- /dev/null
+++ b/docs/devel/nested-papr.txt
@@ -0,0 +1,119 @@
+Nested PAPR API (aka KVM on PowerVM)
+====================================
+
+This API aims at providing support to enable nested virtualization with
+KVM on PowerVM. While the existing support for nested KVM on PowerNV was
+introduced with cap-nested-hv option, however, with a slight design change,
+to enable this on papr/pseries, a new cap-nested-papr option is added. eg:
+
+  qemu-system-ppc64 -cpu POWER10 -machine pseries,cap-nested-papr=true ...
+
+Work by:
+    Michael Neuling <mikey@neuling.org>
+    Vaibhav Jain <vaibhav@linux.ibm.com>
+    Jordan Niethe <jniethe5@gmail.com>
+    Harsh Prateek Bora <harshpb@linux.ibm.com>
+    Shivaprasad G Bhat <sbhat@linux.ibm.com>
+    Kautuk Consul <kconsul@linux.vnet.ibm.com>
+
+Below taken from the kernel documentation:
+
+Introduction
+============
+
+This document explains how a guest operating system can act as a
+hypervisor and run nested guests through the use of hypercalls, if the
+hypervisor has implemented them. The terms L0, L1, and L2 are used to
+refer to different software entities. L0 is the hypervisor mode entity
+that would normally be called the "host" or "hypervisor". L1 is a
+guest virtual machine that is directly run under L0 and is initiated
+and controlled by L0. L2 is a guest virtual machine that is initiated
+and controlled by L1 acting as a hypervisor. A significant design change
+wrt existing API is that now the entire L2 state is maintained within L0.
+
+Existing Nested-HV API
+======================
+
+Linux/KVM has had support for Nesting as an L0 or L1 since 2018
+
+The L0 code was added::
+
+   commit 8e3f5fc1045dc49fd175b978c5457f5f51e7a2ce
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:03 2018 +1100
+   KVM: PPC: Book3S HV: Framework and hcall stubs for nested virtualization
+
+The L1 code was added::
+
+   commit 360cae313702cdd0b90f82c261a8302fecef030a
+   Author: Paul Mackerras <paulus@ozlabs.org>
+   Date:   Mon Oct 8 16:31:04 2018 +1100
+   KVM: PPC: Book3S HV: Nested guest entry via hypercall
+
+This API works primarily using a signal hcall h_enter_nested(). This
+call made by the L1 to tell the L0 to start an L2 vCPU with the given
+state. The L0 then starts this L2 and runs until an L2 exit condition
+is reached. Once the L2 exits, the state of the L2 is given back to
+the L1 by the L0. The full L2 vCPU state is always transferred from
+and to L1 when the L2 is run. The L0 doesn't keep any state on the L2
+vCPU (except in the short sequence in the L0 on L1 -> L2 entry and L2
+-> L1 exit).
+
+The only state kept by the L0 is the partition table. The L1 registers
+it's partition table using the h_set_partition_table() hcall. All
+other state held by the L0 about the L2s is cached state (such as
+shadow page tables).
+
+The L1 may run any L2 or vCPU without first informing the L0. It
+simply starts the vCPU using h_enter_nested(). The creation of L2s and
+vCPUs is done implicitly whenever h_enter_nested() is called.
+
+In this document, we call this existing API the v1 API.
+
+New PAPR API
+===============
+
+The new PAPR API changes from the v1 API such that the creating L2 and
+associated vCPUs is explicit. In this document, we call this the v2
+API.
+
+h_enter_nested() is replaced with H_GUEST_VCPU_RUN().  Before this can
+be called the L1 must explicitly create the L2 using h_guest_create()
+and any associated vCPUs() created with h_guest_create_vCPU(). Getting
+and setting vCPU state can also be performed using h_guest_{g|s}et
+hcall.
+
+The basic execution flow is for an L1 to create an L2, run it, and
+delete it is:
+
+- L1 and L0 negotiate capabilities with H_GUEST_{G,S}ET_CAPABILITIES()
+  (normally at L1 boot time).
+
+- L1 requests the L0 to create an L2 with H_GUEST_CREATE() and receives a token
+
+- L1 requests the L0 to create an L2 vCPU with H_GUEST_CREATE_VCPU()
+
+- L1 and L0 communicate the vCPU state using the H_GUEST_{G,S}ET() hcall
+
+- L1 requests the L0 to run the vCPU using H_GUEST_RUN_VCPU() hcall
+
+- L1 deletes L2 with H_GUEST_DELETE()
+
+For more details, please refer:
+
+[1] Linux Kernel documentation (upstream documentation commit):
+
+commit 476652297f94a2e5e5ef29e734b0da37ade94110
+Author: Michael Neuling <mikey@neuling.org>
+Date:   Thu Sep 14 13:06:00 2023 +1000
+
+    docs: powerpc: Document nested KVM on POWER
+
+    Document support for nested KVM on POWER using the existing API as well
+    as the new PAPR API. This includes the new HCALL interface and how it
+    used by KVM.
+
+    Signed-off-by: Michael Neuling <mikey@neuling.org>
+    Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
+    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
+    Link: https://msgid.link/20230914030600.16993-12-jniethe5@gmail.com
-- 
2.42.0


