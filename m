Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924DFC4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiv1-0001Yh-16; Tue, 14 Jul 2026 15:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiuz-0001YH-0h
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiuw-00055N-Kx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwE1b1267117
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2gT/f+7rNUOz44SiKCldN288jWx7NqogwOp56DfNUVg=; b=HigVHhp6z3lA3EKS
 5WJQ8Oqm1VFf2lFfcw15Bz9Huz+X8479Z24ZoXqJJilooR/y/u4j24GpECJLo+Nq
 ItOg65ab/VkfG/RdrvhX2sBTmRS/Is5vjkq9+rB/JhmAIdKYoti2AlLCfGezbxSy
 Ad5jFkCrYtiwu3p834oQXY/1upK8G43Gs2V9wRxQFuXgvOlOE2AgSoqmi+DRuCWI
 cGMqkaMwm6qre2cW3GOPApW9q/Mt9e3UbPaHETAByz6tG8CS2h2zYgCE/hu/Moa7
 6uuaajZq6QsY/IZps8OdKNgvfMhYT5v0wlAnASsrXaD/Bgdnn9w5BdabLY2Gg8/F
 8YC5NA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnp0hkfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so17600381cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057744; x=1784662544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2gT/f+7rNUOz44SiKCldN288jWx7NqogwOp56DfNUVg=;
 b=aEOne7rV1gHTPX6fNcshqZApGSEWRA2hWq134TxVfsa/WuZawWQ7bXoxyy6z3i2P9P
 6k+ffjlyW/ZtPvasL01ry9l18qthLqZENN3wDHcRtQcMIpVGGGpzwZKrqESh0MnQB9rB
 eTF0orjO2jijdrX0O6Wwu7leSO9zRtCxEg3GxjlI4RM6k9O60Ru3fIXAeQGFvdABqQia
 aZp4pBf56LosQ/nE50kCIPlrGISE4mL1cf2t5/8f5L6jBBvN9YNnop0S6E0T2Uefxs0f
 e3WrsdW2Zdigleu3I8a/0XzdmcPAUi1owGiH7tpzq0tHyy8kjbTIHpk8pG9q4pWMZq7a
 019A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057744; x=1784662544;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2gT/f+7rNUOz44SiKCldN288jWx7NqogwOp56DfNUVg=;
 b=diENIx0S4LWOj0ZglkzbVP8zXyJi8RjyXU166KltKNyrMd4KKIxMkY/uQotOvJ9Fc8
 c/lFKymrzjv/dZGrCObm+hbd11mHSPsxbtIzG3RZLZhFCGM5reak6psvJMO3lFaDTXJD
 DPVJn4gqRy/jTubsCdYeQeN+qj1LXComslyNfaBB8i1zelkwXscZiMwfpir69UKquSk/
 jx89+CMF+f5QtCSm0xmZ3qvmUK7Tvw8jX+KB3bimQ/aLpWX1t1lekCC7RhgXhukZBbN/
 kZlmKpwxoC9+exQNyfoZU1RlisAXI92H57CJajQeWgz7D34YrxV9Q9K8o0sfAIqnUEQK
 D86Q==
X-Gm-Message-State: AOJu0YytUxHZG8vzeU2+y3HDKIgFnXtyF3GkDuqzgZEJ7/AnO3V7b2po
 rqNuKx440cZIilWoyEHXlMqtLJu5H0fDVWmX9N/FgbJUDet/6fUz+8LGwTSJ00VxC8uslCXTpJa
 0CQSd7xOJdVIfSE7vJrkMCVamFCCeWN7QSbeKh1yICLmZwhcIMQu6lx7dxIgDGFtjcg==
X-Gm-Gg: AfdE7cnJjEHod+PGDghPgJTM1NifzdBuY/knKiQ77o/+gD8voIetSwnFCfZ7cw3Q1SW
 9t5zylXZuYi0YV3QpbxBxnlqtHxOQzM9YrF93rph4xe2ih/MZiEbvnfO5yef8Oc8k7S36b2aok7
 5TzYUFHSNUgkfwJtegKN7p3ZmyrrotUxdtHd3qiZD/RPwS+XKoEfEfiEdolYa0omCPR67FHWNDl
 my0q7clmcLf8vmKyIhu/tAB83tqmVGaXFUfLLoguKE7+y9Cj8ZD5WqQRvNj5LEUdU9Gh8EBI417
 9Rq3qURb2GFFTtxAdTBtf1cPb5gJIAPqWuJgn/vZH5+fwFNYMUDLw5uIhyUKyp8mlRqgybEP0+m
 P6bdSMP5ex+Ll6ZQsETREmpDJgbP3VZ49LOz7cFG/9T4YwHgOMcRgr5PQzgNa2pbq+JNn
X-Received: by 2002:ac8:57ca:0:b0:51c:b8fa:395b with SMTP id
 d75a77b69052e-51cbf27f76dmr145284731cf.66.1784057743781; 
 Tue, 14 Jul 2026 12:35:43 -0700 (PDT)
X-Received: by 2002:ac8:57ca:0:b0:51c:b8fa:395b with SMTP id
 d75a77b69052e-51cbf27f76dmr145284491cf.66.1784057743027; 
 Tue, 14 Jul 2026 12:35:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49506a1fbcesm97349685e9.0.2026.07.14.12.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] docs/devel: Document SSI dummy-cycle ownership
Date: Tue, 14 Jul 2026 21:35:07 +0200
Message-ID: <20260714193517.60708-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXyKXzq+2+dmpR
 n73ToMFY7qt93nu16VTdsA8ZtbgPS4LYDstku+bT93rFI4WwpWCged/YyV6POXhZaE22Y88PFBu
 Bsgm2powHcXxuQFud2+ZvEKEHL5j+h4=
X-Proofpoint-GUID: 5VZNzIkxX59a2ig3C1XcKMDQS_qrdO7d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXx0yCBoLioH1c
 SlR68FubKI0eZbtiL2/UDtk4eafq5Mry5UHfVPK6B+WgcfNTO2RFXw1SZYFydzLEoEifeL7R+sN
 eyCoqNjWWXCEvMq3uBZyocNEkTReUUtTOzXdJ1Jr4LR/MI7K60fPp3kTbjlxVNvtqovlWfGyIpD
 luhGYCTcDT/WWqcXV15Z4gG7MEzpWFYsOlHbfXvSqMUKeqc9ktf5oBgF9wn4UrA14cKY1uBlbsj
 JZWV/kon69dfM64Hvk0Ul7KyDT5WbxOuQpXFyssR68IQih/HW4w0SPJhf5RPPSwcZ7jfzRIHhhf
 5m1w2GOBWSGswwHnSWRt4YVDz9WTFkNPhackls0GCSoWK/L05pEvhUFOF9MqTwm9W1BchwqBw3R
 /J6kuiAycA54iED3QaNe3zpbLPJWmlrrNQdy6E8A6Eqhwogplc9jrOD1TRAAuL3mxXQdAbClAMW
 OPfkyMMv+LcMb/5LrSA==
X-Authority-Analysis: v=2.4 cv=FtM1OWrq c=1 sm=1 tr=0 ts=6a568f91 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=SQy2IqWyL_sr42ozp8oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: 5VZNzIkxX59a2ig3C1XcKMDQS_qrdO7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Bin Meng <bin.meng@processmission.com>

Document the boundary between SPI/SSI controller models and SPI flash
models when representing fast-read dummy cycles. It explains that
flash models own command semantics, while controllers own
hardware-generated dummy transfers and cycle-to-byte conversion.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260707083431.219671-11-bin.meng@processmission.com>
[PMD: Update MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 docs/devel/ssi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ecb8cfdc41e..f06a2788065 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2350,6 +2350,7 @@ T: git https://github.com/bonzini/qemu.git scsi-next
 SSI
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
+F: docs/devel/ssi.rst
 F: hw/ssi/*
 F: hw/block/m25p80*
 F: include/hw/ssi/ssi.h
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index b89bab9b306..a8f5e310df3 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
    reset
    s390-cpu-topology
    s390-dasd-ipl
+   ssi
    tracing
    uefi-vars
    vfio-iommufd
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
new file mode 100644
index 00000000000..864b5d93204
--- /dev/null
+++ b/docs/devel/ssi.rst
@@ -0,0 +1,132 @@
+================================
+SSI devices and SPI flash models
+================================
+
+QEMU's Synchronous Serial Interface (SSI) bus models the full-duplex transfer
+of words between a controller and one selected peripheral. Most SPI flash
+models, including ``m25p80``, are attached to controllers through this bus.
+
+This page documents the expected boundary between a controller model and a
+flash model for SPI fast-read dummy cycles. The boundary is important because
+many real controllers expose dummy-cycle configuration in registers, while the
+flash model observes only the byte stream delivered through ``ssi_transfer()``.
+
+SSI transfer granularity
+------------------------
+
+``ssi_transfer()`` transfers one SSI word. Flash models that implement common
+SPI NOR command streams usually consume one 8-bit word at a time:
+
+* command opcode;
+* address bytes;
+* optional mode or continuous-read bytes;
+* dummy bytes;
+* data bytes.
+
+The SSI core does not model individual clock edges or the number of active SPI
+data lines. If a real transaction has a dummy phase expressed in clock cycles,
+the device model that generates transfers on the SSI bus must represent that
+phase as a number of dummy byte transfers.
+
+Flash model responsibilities
+----------------------------
+
+A SPI flash model owns the command semantics for the flash device:
+
+* which opcodes are recognized;
+* how many address bytes are required;
+* whether a command has mode bytes;
+* how many dummy bytes must be consumed before data can be returned;
+* manufacturer-specific differences in fast-read command behavior.
+
+For the ``m25p80`` model, ``needed_bytes`` is a byte count. It must not store
+raw dummy cycles. When a flash datasheet describes the dummy phase in cycles,
+the flash model converts the cycles to bytes using the bus width used for the
+dummy phase::
+
+    dummy_bytes = DIV_ROUND_UP(dummy_cycles * dummy_bus_width, 8)
+
+For SPI NOR fast-read commands modeled by ``m25p80``, the dummy phase follows
+the address phase width. For example, output-only dual and quad read commands
+such as DOR and QOR use one line for command, address, and dummy phases, then
+use two or four lines only for the data phase. Dual I/O and Quad I/O commands
+such as DIOR and QIOR use the wider bus for both address and dummy phases.
+
+If the exact dummy phase cannot be represented as a whole number of SSI byte
+transfers, the model should round up and log the limitation instead of silently
+treating cycles as bytes.
+
+Controller model responsibilities
+---------------------------------
+
+A controller model owns the behavior of the controller hardware:
+
+* how guest-visible registers select command, address width, bus width, and
+  dummy-cycle count;
+* whether the guest supplies dummy bytes in a transmit FIFO;
+* whether the controller itself generates the dummy phase for a memory-mapped,
+  direct-read, or other automatic transfer mode;
+* how chip-select state changes around controller-generated transfers.
+
+When guest software writes dummy bytes into a transmit FIFO or manual transfer
+path, the controller should pass those bytes to ``ssi_transfer()`` like any
+other guest-provided byte. It should not add more dummy transfers on behalf of
+the flash.
+
+When hardware registers instruct the controller to generate a dummy phase, the
+controller must emit dummy byte transfers before data transfers reach the flash
+model. The controller should convert the configured cycle count using the bus
+width that the controller uses during the dummy phase. For example:
+
+* 8 dummy cycles on a single data line become 1 dummy byte;
+* 8 dummy cycles on two data lines become 2 dummy bytes;
+* 8 dummy cycles on four data lines become 4 dummy bytes.
+
+The controller should not duplicate flash-specific opcode tables merely to
+guess which commands need dummy cycles. In automatic modes the controller
+already has enough hardware configuration to know whether it must generate a
+dummy phase. In manual modes the guest-provided byte stream is authoritative.
+
+Avoiding double counting
+------------------------
+
+Exactly one side should generate each dummy byte transfer seen by the flash:
+
+* If the guest sends dummy bytes through the controller, the controller forwards
+  them and the flash consumes them.
+* If the guest programs a controller dummy-cycle register, the controller
+  converts those cycles to dummy byte transfers and the flash consumes them.
+* The flash may know that a command requires dummy bytes, but it does not create
+  transfers on the SSI bus.
+
+Do not implement controller-side snooping that watches manual-mode opcode
+streams and injects extra dummy transfers based on flash opcodes. That mixes
+flash command semantics into the controller and is fragile when flash models
+gain correct dummy-byte accounting.
+
+Examples in the tree
+--------------------
+
+The following models illustrate the boundary:
+
+* ``hw/block/m25p80.c`` keeps fast-read dummy requirements as byte counts in
+  ``needed_bytes``. Manufacturer-specific helpers convert datasheet dummy
+  cycles to the byte stream expected by the model.
+* ``hw/ssi/aspeed_smc.c`` generates dummy byte transfers for direct fast-read
+  mode from controller registers, but manual user-mode writes are forwarded as
+  guest-provided bytes.
+* ``hw/ssi/npcm7xx_fiu.c`` converts the direct-read dummy configuration to the
+  number of dummy byte transfers sent before reading data.
+
+Review checklist
+----------------
+
+When adding or changing a SPI flash controller or flash model, check:
+
+* Are dummy counts stored in byte units when they drive flash state machines?
+* If a hardware register stores cycles, is the conversion to bytes based on the
+  bus width of the dummy phase?
+* Are manual guest-provided dummy bytes forwarded without extra injection?
+* Are automatic controller-generated dummy phases modeled by the controller?
+* Is flash-specific opcode knowledge kept in the flash model rather than copied
+  into controller snooping paths?
-- 
2.53.0


