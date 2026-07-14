Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25012C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiur-0001XR-NM; Tue, 14 Jul 2026 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiuk-0001X1-6B
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiuh-00050m-LS
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIw8MH1136452
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6jvJ2jQtDw58F2tcQ2rADAmzFepgy9g+HQwh2b/wLw=; b=BBTZLfCcafzIuXR8
 HEWWTa9m4TBrupuyuwIpWDDekRH8XsC6eL+BtEMOqZ1oSViZED54HtQMrwhICFa6
 Hy+/7jhQmMGbErKJmJ9wbIIyC+CpTlcJ0nKYCy1M+uJjIK6sqio9ygtSn0CHgYyk
 R2Yrq2CNTt5TGWwB4zaMN2eY0BLB1wGfOiKYfbWDpBdjWc+HZM2m9Pj6RBP9kRhw
 AZths37xPEkznE0OLx3NLCLG/3dQA0hEalLX5fNPW8h1JDQjOTY6XWZgQPS4xPxq
 ErUJO6ldm1Aqw43VFTMRhwFyvzrhKtTZeoKT8L/8ITixSExc6IxwNz1x8l/I3PXH
 0FFu7w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mgfrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ea75996387so116102886d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057728; x=1784662528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l6jvJ2jQtDw58F2tcQ2rADAmzFepgy9g+HQwh2b/wLw=;
 b=CXPYhOVmQI5E/y3lYLhPYQKuAHXUKgFw5yczbLkMHzRT4LHMX0TzHlWew92lJjuvOy
 HcKf/6sw6iAiWU7boKLG4nrTYI9ak2mXsz4XEz306GGt75zF5X8c4yccg6e/2U/m1eXk
 P/1w7vNE4oEmuOOUtoF0MXpBXXxNGT+NmnarbETX2dUgurmJFGIFFo5Y+LOZaZEN9YdM
 rr5KPpfeKtQdAKi29dYefOXV/Z1UBvfkHclGvsf1hS+36DF1RksPtinkmKmRZz06QHZD
 NYviv77byVEmSIXaytOgw5gqL1f+3psn3c4dR919DkfsC0mZJOH/pOwhu5JsZ8TvtXUI
 l6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057728; x=1784662528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6jvJ2jQtDw58F2tcQ2rADAmzFepgy9g+HQwh2b/wLw=;
 b=WnP5zEeRmGlY/U8/YnZrhuDx8r7TiiWFyLfCVulCQwAuzUP3p9PFtFzNUoD3UUdpxm
 pHTNJNfgNvzlIQKfikAVY48sIJPD6Wt+W28ajYWAwN/nc4Z04Ms/9aiJ7YmQCnPupcFg
 UIKIjoMvgTxM7tz+80OoF1OwHH7fnNgBbYAeEs80V8ZnnTEzqQKJvwRX6qnbGgtCl0QP
 Y0rH3btMZwcjf5KbCpcMx57H3PVmm6bNCsPdy3Yen3W1sGkX3c9OA682rav+zs8cX1sm
 lhEZn7ZnMnE7zV8Fxl3D1bxsAR3QSALgmPtklFYdk7A1f5qMrzaOaXUyfsEJAkI1N5v5
 WzXQ==
X-Gm-Message-State: AOJu0Yx8dOtv5UaWArFmpNmahOk4gdqM7gSeRCqRqLoHiDQHYDdpo9Y4
 b+4Pw2ZSpWxWqUMa30iGjVvGony3tcOtU6bHyPcHDJMLC4q2rMnwrii7f9lp4kgakKRkOX8EF9/
 hCAUOpd2K5J2cbpscGa2AlS9g22lwZ8V3pXo1hWZmFalB3baFNNmFBhv2EUx/IYkurQ==
X-Gm-Gg: AfdE7clu8bYOwByutnRYAynmKSOKtcDS0u0TOSXBXmrDyJl7Bcg1blPT0HECzlT+hcY
 A+fIIRRMlde6GupHUsoKOQY+pz7YsCTMKzfCJi+otjbate8qRGEFKiOrGzB/nEeJOQAqVRghGsa
 Xg389I7Z8W2z6nwIvWJdPd+ZSygQqYir9rGhH6U2RhqUsd/XaEWmxRlIRp3wzaw8jtX7/fhIwec
 1i06vttW6paj0DZP6FaffDfglrmGXJ/HNiLbhSXWFr11dJlwPLZOCUABgMFFNulctB06wKmvDwX
 TF8WM4PyIcvynACkAmHg7fPjdqqyNFcPqWOYq2Qo3pzr08Tnqp5cjG4zpK6Jdv4X1onHcPAxBSa
 SmXsuS8emsPLyHFqd8fJKVa5UF4YsnMypOsAfM87LU+VQdxBwpxpPt4zsSdv71ZofNBI5
X-Received: by 2002:ac8:5889:0:b0:519:f02b:45cb with SMTP id
 d75a77b69052e-51e4eff6d4amr483481cf.26.1784057728370; 
 Tue, 14 Jul 2026 12:35:28 -0700 (PDT)
X-Received: by 2002:ac8:5889:0:b0:519:f02b:45cb with SMTP id
 d75a77b69052e-51e4eff6d4amr483211cf.26.1784057727819; 
 Tue, 14 Jul 2026 12:35:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f9402sm99863185e9.13.2026.07.14.12.35.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
Date: Tue, 14 Jul 2026 21:35:05 +0200
Message-ID: <20260714193517.60708-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX6crcJZqJZsLZ
 w+/X6cGUoBkr2oPHl2kSjI20zZcaedABu9WLn0FII+iKr2xSIPqioSS5/y2tH+/euespxDnByPj
 JQP4jGk3Czn1ZAtbkABo1dqNs8j5Tl34nwP6xeqg9sxHnrS641/jdQhBMIerVbptSfir93Nh/SY
 VsSNgn/Io5Ru+lYjdDkSBd3GGqVtGqzxGf1Yh8+iKW7e1L2dhrwT1WiXcuv9WBl+nwSpx7XV2oa
 M+OlLnP77Y3LsbsPDQg4/JcBWxwq37h1kJj4VInFQeJ9UYDZwMepot+tTaDe4fwWZbydze4okVB
 ncwuQG420Fcq9+jzZcvpyGZmGIPxcg3OdF3GdqsyKGafhLNYXuPCcV42s+uOSgNwl5e+a1DMDku
 wK6B+XyCO8cqEdiW9hzEEkV1WzuephzWi4Ej4feW4STdsljwDOVbZdx+/svfaSFPA1ulQfbgMQN
 vQTbmgLcnFrzjzf5WCg==
X-Proofpoint-ORIG-GUID: sBWckII6mFn7SwP1JSL22moD2Ke7huJF
X-Proofpoint-GUID: sBWckII6mFn7SwP1JSL22moD2Ke7huJF
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a568f81 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=07aRgWtaSAiwv9DsM3QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX9am6hmmnjf+l
 Y9ZcfZNd5T8y2d9AtrJjyaOiFvvLf0nY/Y96kDT1VgmoS/wo1L/NL2fWwd849FaIJg3WMapCYx3
 9U96GOnxEH7NRkwYUwH+PXHYXv/sS0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140202
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

From: Thomas Huth <thuth@redhat.com>

When trying to plug a PCI device to a Sparc64 machine, you currently
have to specify the right bus ("bus=pciB"), otherwise you get this error:

 $ qemu-system-sparc64 -device virtio-scsi-pci
 qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
 available for virtio-scsi-pci, all in use or reserved

This is quite annoying for the unexperienced users, and it also breaks
e.g. the iotests ("make check-block") when running with qemu-system-sparc64.

Mark the non-usable PCI busses as full now, so that QEMU can automatically
plug new PCI devices to the right "pciB" bus.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260309181452.83702-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sparc64/sun4u.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d69ed9a81ac..a348096aee6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -719,6 +719,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
 
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
+    /*
+     * Mark internal PCI busses as full so that the plugging of additional
+     * PCI devices happens on the right bus that still has free slots:
+     */
+    qbus_mark_full(&pci_bus->qbus);
+    qbus_mark_full(&pci_busA->qbus);
 }
 
 enum {
-- 
2.53.0


