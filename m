Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CADC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Mu-0003Ap-EI; Tue, 07 Jul 2026 04:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1Ms-00032O-R9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1Mr-0005W4-By
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:41:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EBQk3139784
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D4XN4hj3rpYtxU9bzK74hbyNPSTsixwm02XY1Ak7xTI=; b=ijfx4ZuZdf7onoyl
 LXk+csOQNCYaeL6NBfou4UmP8dhP1uODOnluQuZi4fZ5ui+nnupi+x+QNol5SWxK
 hsM+tYcXY8GP3GpOr2qroE2UiDgFCrx1kkQWoo84D3TPJgZxNBW5wOkeje/S+cNA
 klR3tCG7I0QP8T9d7Lf6XPE9QAwmwR7hqJqr7n/x1a3AcaTD7VyqUd1FQvU+EZ0n
 nrdwGP8yVnggjU65josBkZDsdvISbBdcWngJPZZUIvt0vr21RfREjo3yRtLft+r+
 qCWilovrS2F2w2qLd3++6j0ZiMK3OwYBbOuiYRqv6a4kpNxPEIJ5Q/TZ7wHb7yIm
 1lK5gg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15928b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:41:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ea75996387so81170586d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413683; x=1784018483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4XN4hj3rpYtxU9bzK74hbyNPSTsixwm02XY1Ak7xTI=;
 b=IWPoAkJliwk9o8JNA2jeT58eFQ7uGWAdkPCjKOGvLBV93hjP/qcwy5Zh8QgdBFQ63t
 a11rfmd0qS45q+FVNRDb5oUHqk3SQx08SsXQQXomt84uRfyQVrr7Sjqkly1lwlAarzwN
 oRznYYsy1a3l5H5AgjRqvfYpXPB73o4FKFzhxYJrB5lCp0EfLSL1LhVsuHwb2+yeLzAt
 SRj0SOywSwj9iUJahx66hXqIAfXuFREf0ZbnSlWLwko31cj2BIWSm1kI5j/00kdo5J9e
 KhyfRglsuQZH77uW0ObGWFNGCEbKicDWt31oFreFYL0O4eHIWvYOGmC+6vrVJYi+joTw
 cWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413683; x=1784018483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4XN4hj3rpYtxU9bzK74hbyNPSTsixwm02XY1Ak7xTI=;
 b=kq/ckeFcFUbRkoOCZI22VWEbUxJjqUt9MkNTmEYCLWh8FUeCvx3LEioLr/NgOrklhY
 upbtMptw4I9nIMMXBdPFC4HLXaEx/xRawnbSFva6o+0f2BEbIv6tJPnzmKPR5w6Ayklk
 oOxRRx/bVSzZKsjTtA/504CRcnPVFqaHiOBVfqZIGiYqQ77VnwxrXLwYl0qXbQJxKosx
 ohmj775YRqjC/L/w7DGstV8RGi3yzKw8FOfvaSJlWJz8J1tNH1dQLFwreD90jpgMkhiT
 p35k/9uvwl81nfXE041VqUCO6AvTQ9Rs6MqUcOGYSTTOQJWX1Xq0BjgkhXM4heSYVmpj
 OMRg==
X-Gm-Message-State: AOJu0YyX6dEdo/Hwss7+HBTniK3RYTYcQtaQnBNnDhBruN4go7qsDaQW
 7zO+LC64kgZfjkqiXd0XEwhZ+Rq9oNTjg7FxxA3GxhlPpoxrqIy20klNOyqNeT1gq0a1xt7toWC
 TJ0Wun4ROuBDRN49zZZPlzPbY7LrJgHz5m6HtW7s/NUn/14Sb0PyjdHwown4hkFLRWg==
X-Gm-Gg: AfdE7ckjqrhn7w5wF/obTheHQFLczPgfjkRlpcabMpRv3hrAQAig4IsNz4hcaPWCiLB
 BqrLzHke/cQMPkkgzqZLUSy9/MgWx1EbgFf1yrALCeRmt7OELV1VJBMn6eW8JF9mOv5Q49hl+bZ
 miqgP+8mOHnaaa7WO6pfAftgCjV7Y9yBU9xM5/c9U9kEc/h0TVtXV49Bcjinob+MPmUcLY2hYIw
 DWVNkgu6NAVDf1+K4+221refju4WLtgCMuXvIzLAZ102hXKgQYvbSLv4/qi4WqBb33E+IrFSv7z
 Nhu02cxCpa0Va6VtGTvX5JAB4fPs9I06jjtAL9IaV5QU+MTvaCtkVXL47GuBD1//RBwnxGNiFMu
 ryRXEhW7ZFb1vozZBIGEALYliVryz6HBWcb23rjYWdC4Qbjz8A8UyyafFOMcq1M8zLLFZ
X-Received: by 2002:ac8:5942:0:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-51c747afd57mr46251261cf.9.1783413683272; 
 Tue, 07 Jul 2026 01:41:23 -0700 (PDT)
X-Received: by 2002:ac8:5942:0:b0:517:87df:d8ec with SMTP id
 d75a77b69052e-51c747afd57mr46251141cf.9.1783413682852; 
 Tue, 07 Jul 2026 01:41:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e01f038fsm29723775e9.2.2026.07.07.01.41.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 01:41:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/3] hw/pci: Consider reserved slots mask when checking PCI
 bus is full
Date: Tue,  7 Jul 2026 10:40:50 +0200
Message-ID: <20260707084050.32137-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707084050.32137-1-philmd@oss.qualcomm.com>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Rgq6i-VvCR8ZA_fStpneam0MBkzRRX2
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4cbbb4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=NUtl-IDQSLxCwqLPUk0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 0Rgq6i-VvCR8ZA_fStpneam0MBkzRRX2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfXyM00C6rwiePt
 5MFy33qLubn8FytF9zKP6J+TsfpzVzkiInhfm07xQMRnTr3HPtA2oOVJTiXwjzjgImBMeQ23Cfn
 irWPflzTEZ0m9wcEe8Qq1iCm8kOyYmQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX4S3jKADRB5hF
 wXAciZ2Le1sPNyQyXLUDrzVgQ7sqx2bapMTocTbWHZDtik5WyZOVegGsz7QuCZKN8Pz3Z+ebD93
 0NJNgqANLkPStZzDqRxp/TotaLLVAQOmuu2+e/u7yjdbx23kJ7vKLC2x8m24MlIbwrpWLdk+yU+
 MfDpaxpbOLorwHNWPm3vli18yz5OzWDr/I13qOxTcie40EjqcuYyV7PAaHVQqcA5B7L/CPuSxIp
 h0XcdPXPijZtzgPTMCMmfHn1fh8tUWMGtdVGLABVMxUxlEY3esa0ExHkqAUJ3vWsg/6+8NA4nU4
 MigIVSKrOiUAx6PWlfKz/c3sJvuOyloaTs4uouMgYvdyCATmncUpg6Mx+o0sx/DV4XUZRSpwxj1
 ZvHYU5z1RQR568OJATHzebPqZ+2Scnb3gr1H9p9LToHy5Uok+gly5zt3MTPGfTVa/ly+bQNZdON
 8TDk+xwfipPbdXQvOUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Do not consider reserved slots as available.

Fixes: 8b8849844fd ("pci: add reserved slot check to do_pci_register_device")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/pci/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b04e94a150b..2e5412137b3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -62,6 +62,7 @@ static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
+static bool pci_bus_is_full(const BusState *qbus);
 
 static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
@@ -293,6 +294,7 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     k->print_dev = pcibus_dev_print;
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
+    k->is_full = pci_bus_is_full;
     k->realize = pci_bus_realize;
     k->unrealize = pci_bus_unrealize;
 
@@ -1329,6 +1331,21 @@ void pci_bus_clear_slot_reserved_mask(PCIBus *bus, uint32_t mask)
     bus->slot_reserved_mask &= ~mask;
 }
 
+static bool pci_bus_is_full(const BusState *qbus)
+{
+    const PCIBus *bus = PCI_BUS(qbus);
+
+    for (int i = 0; i < PCI_DEVFN_MAX; i += PCI_FUNC_MAX) {
+        if (pci_bus_devfn_reserved(bus, i)) {
+            continue;
+        }
+        if (pci_bus_devfn_available(bus, i)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                                          const char *name, int devfn,
-- 
2.53.0


