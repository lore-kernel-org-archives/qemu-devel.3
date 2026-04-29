Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED238CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7v-0003Vm-Qk; Wed, 29 Apr 2026 16:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QP-00083v-GF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QM-0007gU-P2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d73422431so11721511f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471076; x=1778075876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCHtycy4An6frL027okw83jsdSBE9b+29TxohlVbQig=;
 b=pu3gZXaRDjkF8MnZTK8zHq0cBdaQbcJ5YsqztboPj0YSY0W7Vp+0Ecz2436OCHfOww
 8GBhTyfXKPsEr0d373lXoTBEPvwWmCavdsRdq7PZxR4PBo0swqj8CholdLN0yp52UzQu
 aAEch4UzCobG1ptNcVKa9eK6m8ZVhwncRlUtRZjG9GzkWqeibaU/xAluQPsyMcyau3T3
 8YzCrSgBN8kBJLD84bankUI2z++FLHr7BBumSJi+EkTKSOmhDNUr8PmuulH1jTclkgiG
 iMPU1TxiGxDXS2NA7G82Yv9GHe7Z0Lvt3+EquL6U5mxnLTfdA27O4An70kqFR3MDnt9p
 xdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471076; x=1778075876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCHtycy4An6frL027okw83jsdSBE9b+29TxohlVbQig=;
 b=fM+LGX8aAxft59OS0XaJ+7KM54nfILe4MtAajziQOto+6+jShuvDH3rks8Uc7mWqpd
 N6YO1di/aU6kyLSeGXyCAAE67nGIbUkLXhIxRGP19e95Lek+jmY9+fzC6EplV5n06nQ3
 X8qNQFxvCzv6YZwXznjCM3P5Rp5Zh1F7qN5BS0SqqlZhj9Ub0WwCDxQV2/+mMs9KZBW0
 ph/S0NB4j/NNXcfMWU0GklR7fNR9yOxuaPIsJME8pThMWWhRv25cnQGDSlF7YkEkGliW
 CmUT/fP8qoXCayJlfCuqsRAiRn/f9fWN6qtKrYBUVsy1vfyAZf9OD1hRg5DvGDeup/gT
 SefA==
X-Gm-Message-State: AOJu0YzvX9nYc+axBEtwsna0lbGOjMhBQots+oL4lPMnnrEvoNAfg1Ji
 STvZnI7SuEqDCAmtld0ZZz3HB4UjXzqN2c+eZvTGfUURXvjtwy2vkRVB
X-Gm-Gg: AeBDietW4TbpFA5+Cna7Oh4RHQIy/nvyHhsls7mRzaSIgYNQChLmZUQlP7oBr5G0wm7
 cjGDBP1S7OCVmM6RMLNJUL8xVNSrtL32DUsS4WnJqRrgxGYdnGUIPn0zBnZ7eZ/CLfrN28PE7Bm
 sr6SnyI2jmuvqrsootLnlf0U4/+CrdK1BfKo+JNHUK6efO/zP8yQlnS7hzPe+PGGvNNwiYeDmrE
 9Rpkg/3kE/+RdL4qpPkCe6EjqTZlMz7KRbD/M0r4zdDvV9MqoOSghN0YyWc21OGEmBqhKNedhvd
 1H/10xWC3VxKCSka87Ecmgv8aPxY7X/Ap1HVs5crfpNfhisrY2PIRBTrQ/SxJh4d041TNxFJyQ8
 qOg1LUiXfnNH0u5DWSsY4ZX6+y1EKq0Dp1ZEnqK8NIZzWiB6kPN0lctnmqqJC9fFAvgBVRfYYpq
 8diYWvTY8I9gVVIEsdQXSJw1xJ1rYAroikZ/eeUTiokvVLyG9tKvXE3T6YTQxr5fCub0X4t3WS
X-Received: by 2002:a05:6000:1843:b0:439:b8b2:fad0 with SMTP id
 ffacd0b85a97d-4478e6b3b9cmr7209099f8f.5.1777471075822; 
 Wed, 29 Apr 2026 06:57:55 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:57:54 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 01/10] docs: Add documentation for cxl-vcs-switch
Date: Wed, 29 Apr 2026 14:48:35 +0100
Message-ID: <20260429135717.3048713-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 docs/system/devices/cxl.rst | 90 ++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..9e8452e576 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -119,11 +119,11 @@ and associated component register access via PCI bars.
 CXL Switch
 ~~~~~~~~~~
 Here we consider a simple CXL switch with only a single
-virtual hierarchy. Whilst more complex devices exist, their
-visibility to a particular host is generally the same as for
-a simple switch design. Hosts often have no awareness
-of complex rerouting and device pooling, they simply see
-devices being hot added or hot removed.
+virtual hierarchy. Whilst more complex devices exist (see VCS
+Switching below), their visibility to a particular host is
+generally the same as for a simple switch design. Hosts often
+have no awareness of complex rerouting and device pooling,
+they simply see devices being hot added or hot removed.
 
 A CXL switch has a similar architecture to those in PCIe,
 with a single upstream port, internal PCI bus and multiple
@@ -467,6 +467,86 @@ Example configuration:
 Guest OS communication with the MCTP CCI can then be established using standard
 MCTP configuration tools.
 
+CXL Multi-VCS Switching
+-----------------------
+
+The cxl-vcs-switch object allows for a Fabric Manager to dynamically reconfigure
+the switching within a multi-upstream port CXL/PCIe topology, This moves beyond
+the static switching configuration described above. The use of vcs=X on an
+endpoint device indicates that it should be hidden from guests at boot. Each
+upstream port with vcs=X set will conceptually become an upstream PPB. Any
+downstream port that is connected to an upstream port with vcs=X set will
+automatically become a vPPB for that VCS. The overall cxl-virtual-switch has a
+single CCI mailbox used for config/status of all ports within the switch.
+Setting local-fm=true indicates that this QEMU instance has the CCI mailbox
+attached. Setting it false will create listeners for commands from a remote
+QEMU process (yet to be implemented).
+
+An example of how the topology is described on the CLI is shown below:
+
+  -object cxl-vcs-switch,id=vcs0,usp-ppbs=2,dsp-ppbs=4,local-fm=true \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
+  -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
+  -device pxb-cxl,bus_nr=22,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
+  -device cxl-upstream,port=0,sn=1234,bus=root_port1,id=us0,addr=0.0,multifunction=on,vcs=vcs0,usppb=0 \
+  -device cxl-upstream,port=0,sn=5678,bus=root_port2,id=us1,addr=0.0,multifunction=on,vcs=vcs0,usppb=1 \
+  -device cxl-switch-mailbox-cci,bus=root_port1,addr=0.3,target=vcs0 \
+  -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=vcs0 \
+  -device cxl-downstream,port=0,bus=us0,id=dsp0,slot=3 \
+  -device cxl-downstream,port=1,bus=us0,id=dsp1,slot=4 \
+  -device cxl-downstream,port=0,bus=us1,id=dsp2,slot=7 \
+  -device cxl-downstream,port=1,bus=us1,id=dsp3,slot=8 \
+  -device cxl-type3,persistent-memdev=cxl-mem1,id=cxl-ep1,lsa=cxl-lsa1,sn=99,vcs=vcs0,dsppb=0 \
+  -device cxl-type3,persistent-memdev=cxl-mem2,id=cxl-ep2,lsa=cxl-lsa2,sn=100,vcs=vcs0,dsppb=1 \
+  -device cxl-type3,persistent-memdev=cxl-mem3,id=cxl-ep3,lsa=cxl-lsa3,sn=101,vcs=vcs0,dsppb=2 \
+  -device cxl-type3,persistent-memdev=cxl-mem4,id=cxl-ep4,lsa=cxl-lsa4,sn=102,vcs=vcs0,dsppb=3 \
+  -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G
+
+Example topology involving VCS switching::
+
+               +--------------------+  +--------------------+
+               |   Host Bridge 0    |  |   Host Bridge 1    |
+               +----------+---------+  +----------+---------+
+    +-------+             |                       |
+    | MCTP  |             |                       |
+    | USB/  |  +----------+---------+  +----------+---------+
+    | I2C   |  |    Root Port 0     |  |    Root Port 1     |
+    +-----+-+  +----------+---------+  +----------+---------+
+          |               |                       |
+          |               |                       |
+   +------|---------------+-----------------------+-----------------------+
+   |    +-+--------+      |  cxl-vcs-switch (vcs0)|                       |
+   | +--| CCI MBOX |---*  |                       |                       |
+   | |  +----------+      |                       |                       |
+   | |  +-----------------+--------+      +-------+------------------+    |
+   | +--+                 |   VCS0 |  *---+       |             VCS1 |    |
+   |    | +---------------+------+ |      | +-----+----------------+ |    |
+   |    | |                      | |      | |                      | |    |
+   |    | |        USP 0         | |      | |        USP 1         | |    |
+   |    | |                      | |      | |                      | |    |
+   |    | +----+------------+----+ |      | +----+------------+----+ |    |
+   |    |      |            |      |      |      |            |      |    |
+   |    | +----+----+  +----+----+ |      | +----+----+  +----+----+ |    |
+   |    | |  DSP 0  |  |  DSP 1  | |      | |  DSP 2  |  |  DSP 3  | |    |
+   |    | |(vPPB 0) |  |(vPPB 1) | |      | |(vPPB 0) |  |(vPPB 1) | |    |
+   |    | |         |  |         | |      | |         |  |         | |    |
+   |    | +---------+  +---------+ |      | +---------+  +----+----+ |    |
+   |    +--------------------------+      +-------------------+------+    |
+   |                                                          |           |
+   |           +----------------------------------------------+           |
+   |           |                                                          |
+   |           |            -                    -            -           |
+   +-----------|------------|--------------------|------------|-----------+
+               |            |                    |            |
+          +---------+  +---------+          +---------+  +---------+
+          |CXL/PCIe |  |CXL/PCIe |          |CXL/PCIe |  |CXL/PCIe |
+          |  EP 0   |  |  EP 1   |          |  EP 2   |  |  EP 3   |
+          | (PPB0)  |  | (PPB1)  |          | (PPB2)  |  | (PPB3)  |
+          +---------+  +---------+          +---------+  +---------+
+                 PPB0 Bound to VCS1, vPPB1. Others unbound...
+
+
 References
 ----------
 
-- 
2.47.3


