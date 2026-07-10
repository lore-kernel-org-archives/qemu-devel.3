Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88642C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAFL-0008EK-QY; Fri, 10 Jul 2026 08:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mp-0000Zr-95
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mn-0001ub-Na
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7dawH140873
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xfihhQahT18
 tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=; b=Ya1RxJbZ8MyyijZ9iQFoLTLvITC
 BHcVOdfXty+zXhYg42kGARuOIIa5MaEPEVg9ywE3RTwwLI8HCOyhTXOVHbuZvErG
 vtKu45aro3pJlCnir2dr/y7tk8MmCaYWCk/SxiOjzxTv4ZEwNN6qEa6wrdbPnIwA
 04hVghp076UiRq6s9DevuAFLjQAiTbYp5tv0CJ3Apm1tIrfwtCirLeSbBxdGVQvr
 ln2w+tyKMy9Tt66OGwYqEyz3GEG5jiH7Im5O47k5XT0s/oF8BtW9Llga895xPOA+
 hTvzIn8HbGAGsksCFpYaXJFU5jNw5BwewAI6HT+WnV8HRiglnwZepwvIppw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpm5m7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-384cb1637c2so157864a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672840; x=1784277640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xfihhQahT18tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=;
 b=h9sIJq+eEYEVl6oUeGWaYasRcTZ/9KcUMCGpb6s9lf/qqqYpNFhMcwO8AwPNYxuMzB
 VY5KwgBCPLelC2FpQwGaiV+Uci7jLdMeajujUqopdmY/QJ4TF4PetIXNkngVuWYOF1kU
 nrsyFjahP5oE2CBRdcsuQ7O1bAs/a1UJCjHeTbE1FpTAByYzZhcVJegts23oY79hDESu
 WOVWpNUn+Es3VYlOcbZUty8OCLiCagkbtcZfC78pT2mK61Tgf1MNtAivNlZ5VreI89ho
 tKnWCDa/FTFQEzZflDXHRZKNFyz5p7ricFU3xCqUBVObyI0653BzG48afJHr5t28NMik
 yfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672840; x=1784277640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xfihhQahT18tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=;
 b=KSGLqzR6xyUK5BYXCNw3PMX9c21KROOnO56wuSIe/71XWhS6pFXjxoxJ4j/d5d+fNa
 b0asGNZRyXGd5td2sM6fVDzW2jZdac/Lp9yNASePpnEVsJgMEI9aOrsWeOhszAbHHbBs
 +gPjjyevTMU9vTMWValHQYSiQ/lC3eoGJyulFEPm5Id6kss2jDpKHDU7kajeQotC7aDJ
 wpINoXb659awXxxvSyd59mCV7SSMrmT8ZXL9CkioclDOoRzegxyDE/j652kws3n7gFeG
 mCex9hWH6UBwH1aW8o+PZZzZc5EKqbEFf027Ed7De0F82kFt/djGGONARDAOnLYD/nEc
 VuUw==
X-Gm-Message-State: AOJu0YxGYKIHrhLmkEeKsnYsJgPWLoc0cXw1uDVsMTZDLTVOoCgQ3t87
 ZAbX7UtTVGIgRuQqv5RUeJebV7bgIY3MSohs3xAV7hPjBO1IEodhVpS+CzQzNtD0+Xda0RMivcb
 g4CqKmatLB6v0rBauQHv6EY/nAhFIKL5VpaffsCm3DgZ5vrmZjD6b0CqgZA==
X-Gm-Gg: AfdE7cnn9CJJjV63QLgXlC6OYRO/bghiz3knzUTENCXuNlgzphg7YYCxuv4wupFDqgp
 88ZM1yCtnR7eef6gsG/5duF0HjgCpQJ5z6qQFZJm8ECQMHoc9bVyBIumwrOIxS9LawIUo+0xqRt
 gmGEC2suJl0aipf9onMl8wX8vsXfHFmnIxeBsnQjHIli3rTjdOCdgrk1joyl6+YGkf95Jimxage
 eaceG+wjfetggoCVHNWmM5Pe0s4fYXZwHjbQr8uZyn7H67u2DVeKHuiY/nwtngV/FKIPmCnHx1a
 RxtIEQCe9kYbI7wckROVxSXttLYUXAKrGX/4wHPj7nVnMp5AItEqXC8qodXBg0gwnjhhA2HemTR
 vctkI4SACeT9lCrVPZJkJGC/7FUr00q3S4lxK3XqOU8/QMrC2Sw/mAjI5JkiSVrEaAaCBKncP8f
 eCbNrg+a+8J16DJTsBNAR/kcr55PNdeRrVq2X0TKs1jQ==
X-Received: by 2002:a17:90b:5287:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38a1f1dbefamr5607850a91.1.1783672839914; 
 Fri, 10 Jul 2026 01:40:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5287:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-38a1f1dbefamr5607827a91.1.1783672839430; 
 Fri, 10 Jul 2026 01:40:39 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:38 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 08/10] docs/system/riscv: document initial virt RPMI support
Date: Fri, 10 Jul 2026 14:09:50 +0530
Message-ID: <10f13dfad6528556a3bb4aa077aca8c38e34bc24.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfX1MYb7w79PGin
 v+aGP1mrw6wlFY70YcSmBg0aUB1q+r13GMq8cURPu0MQzgTuwUtmkg8l/tz++jwgtDxDikq9TiM
 LUZa8j+ZCI/ewv/EZoQ88n0LI5HR653jEcHVwHOT3FZ3lXHIOEb0IBZj+S/F61yi4ECSWOnuND6
 7Gyfb7xtE6nkRI1/QRkZkSHqzkboBIlzEeiwUBHvS/zK7s5iaQSRNL2A/4Iv5qCqiMsNw8n/XJ9
 Y1e9j1qkGvsh/wSi6JI0NDbWHvOP+BsY965zaip3TF2EuVGXocltLljDKS9V7IwgOkM9r9+c6Qe
 QnPkseWgwFKtDDwlrucGisTtZQQ+eZZ5dyM5ID0FAbtmXF9aoqK6K/08TA1apTaGMBuf1Zvy6dX
 2robJQGEUd3xDf9z5mbx7chuGN72djTedK0or3NKE9DR/PxBchJUeuhxSakAaSKMp35b0M69mbt
 sx5MvMlIa2Jpm5izjfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MyBTYWx0ZWRfXwdwKgAZrWTXR
 V71C71xHDKtiSbzpDqJe7X3towp9qB0S5A83e6fWS9H+/RX3lXg+zZUBOjqFdRCqaiTfay1S9z+
 W3aTnXo0k2uj37lKdSXD5OxHn6hXAH0=
X-Proofpoint-GUID: 5KpCUqA1ABYe9kANRSz6eKzkIbXkx3uy
X-Proofpoint-ORIG-GUID: 5KpCUqA1ABYe9kANRSz6eKzkIbXkx3uy
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a50b008 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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
Message-ID: <20260710083950.sqhk5IKbBPAK1XLNnmjrqxi_DBF3SUwh0Hqal_G0RgM@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 docs/system/riscv/virt.rst | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..8e88f780e1 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,56 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- rpmi=[on|off]
+
+  Enables the RISC-V RPMI shared-memory transport. This option defaults to
+  "off", is TCG-only, and is available only when QEMU is built with librpmi
+  support. This support targets the RISC-V Platform Management Interface
+  (RPMI) Specification v1.0 Ratified (`RPMI v1.0 specification`_). The initial
+  ``virt`` implementation exposes RPMI system reset, system suspend, and HSM
+  service groups. System reset can request shutdown or cold reboot through
+  RPMI. HSM uses the ``virt`` hart IDs and supports hart discovery, status,
+  start, stop, and suspend commands. System suspend uses QEMU's suspend and
+  wakeup path. Migration is currently blocked while RPMI transport and service
+  VMState support is being designed.
+
+  The build dependency is provided by `librpmi`_. Install librpmi so that
+  ``pkg-config`` can find ``librpmi.pc``, then configure QEMU with
+  ``--enable-librpmi`` or ``-Dlibrpmi=enabled``.
+
+.. _RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
+.. _librpmi: https://github.com/riscv-software-src/librpmi
+
+RPMI firmware and guest smoke
+-----------------------------
+
+A firmware-level RPMI smoke test can be run with OpenSBI, a Linux kernel, and a
+RISC-V disk image:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+      -machine virt,rpmi=on \
+      -cpu rv64 -smp 4 -m 4G -nographic \
+      -bios /path/to/fw_jump.bin \
+      -kernel /path/to/Image \
+      -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
+      -drive file=/path/to/rootfs.img,format=raw,if=virtio,snapshot=on
+
+The OpenSBI banner should report RPMI-backed HSM and system suspend support.
+After the guest reaches a shell, normal guest reboot/poweroff commands exercise
+the RPMI system reset path.
+
+RPMI device tree policy
+-----------------------
+
+RPMI is currently described through FDT only; no ACPI representation is emitted
+for the RPMI transport or service groups. The ``virt`` machine uses the
+``riscv,rpmi-shmem-mbox`` shared-memory mailbox node plus child service nodes
+with ``riscv,rpmi-*`` compatible strings. These binding names are part of the
+RPMI RFC surface and may be revised if the RISC-V RPMI bindings change during
+review.
+
 Running Linux kernel
 --------------------
 
-- 
2.43.0


