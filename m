Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC91C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GSw-0006Yb-Ag; Thu, 03 Sep 2026 19:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSv-0006YJ-6V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSq-00036f-AF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683JhDG2245598
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 23:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nochKuzgVDPhq+MX0FmnI7ta8qahtAkAJ1SRf5bMYcw=; b=ap0pfn1rUw/2kISf
 71pF6qHoCCJFvLZQVnYVXmFld2dCLYdHu5r+EGeTHjakxVd26mOiN3jTooEkQlpR
 6KMwxTRgOdt5jQo9OJQ1Xmjkh+VU1HHrfg9adU1J944OrXVTUJEJt0akA9aZcco6
 rUsOQGJYvZQ4OZPEexSPnxBoxlav0PxNxyeZAXyB3HP8FbvTIqqPlYPO1kKmQXjP
 nVGHmLA3rtbfCUTctKRaN5LC/hTJOVSEfjN2tupmL6wIdgA9uZhP9NME9ki/szLe
 cDO2VYsESjwqoMeLsLElV4Nx1ebnMy/MujgiQqo0EIar8250x/LeSyMLqRgsj5ok
 A9cqhA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d13nsw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:03:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939281526e1so33648185a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476602; x=1789081402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nochKuzgVDPhq+MX0FmnI7ta8qahtAkAJ1SRf5bMYcw=;
 b=BT0wjD8fB9uMe+0OPvVjQ/9cdOnhSMXxgheWPRS0BldBMRpWGcKQjbfl2IWoFYqLx/
 7/GfsQsv8gZTb2fnS4AQO7u67RpLkiFs8EASdywyShSuYSNCNGmOZV66zeivvmyor/5H
 /LIEvlgoqlO42jfV6HXyaEfI61iF5oDyQJ9uoFEdVp3oSOa/w/yoKSEWbZiM2SGVZWC3
 EyqLaVNvFD2XEnJKLFPuR4QNfp1zi4s87RPn2C1x4jhCYmVRc0aId7/cr7t2UndfCX9A
 W0zsRWy6OF6qfQ4aw7i5aIbsez56keTzC/xFOeM4px4/0JFwe+ZlY+AvKUpJfvGiddh4
 UJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476602; x=1789081402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nochKuzgVDPhq+MX0FmnI7ta8qahtAkAJ1SRf5bMYcw=;
 b=lndYQROoZwpJ9D5TQmwZxplImxfJctSIfkUKwzWROHVe6dhqEqBmHLXtsUNUFJ51/1
 XGog3XNXVZEOBbwZx42acHHCXPgNdkzG4ucMboWQ8hh0rnOWS6wnTVK7hizZgMzcO6Vc
 V+6vu2T9nN3cEbdOvMCu3lnP7pFffX+muqE2cl4JB6vW7xeldO7zbYdbRRCL4uJmt1CO
 K91QDb252erwdyOaiQAUXxbaV75MplUfieR0iSfkNzUwyw7ZxDoshFt1Gbat5FDjZdoS
 /ka+/nwHdA3B1lzw3hhG/02SRsdJUv9ZsAQ4noy0Aq0lPziagSMdsVpNxqyyea+qQ096
 4lAw==
X-Gm-Message-State: AFuF++kgxiPwPzeexyx/WxmAh9rLYnE4O2yhQLd/4CpqgSwgdB62W7/N
 P69Dki4dYE4xdC/qyO+D1pEwzvcL/mMX1yJDlEcptWz8qXIAE6Yca6rWXvhaYnaBQ/uH5R2a4ur
 vaaji+QTLgnlYUdgsUohfGgWLYHz3NjhsivZTAcgX/oWIxgFRO633cBtngjC71Q0VAA==
X-Gm-Gg: AYBFou1yPPxfPOHY1AvI77lnzJfos7JrKN/QmfY/Hbv1kE8n77hgvznhMXe4M1BOWXJ
 nNMtj6MqXkSjE03Ygtv+PjZqwnvjoycj9oW4YNYHJ92ZgqCYR/NGU62zWx+1f/to1l9OEuDmbty
 7XURp9/zV9qVJEZWdUozePXs1gXimQfnVBqy5SBo5Ky7N/Y7lYW3zP7izUvj2c1fdhVpIxpFm1B
 I7++KO0EjHXdI2dhrGL6z2IZMvuB3BkhLREU/C9aFC+dUTHD/ms0c2mq3+40uEgzRBgmu36jkmY
 gXG1Cnrq89MLV+kvQuar9CFFp6UPmWxQ69DuF+e9Kxp5I06zCCZhK49Ftl44gI3KNurBjnJL3+b
 B101Pk/+178brR+Igy+Jd6K5s7dYpoEQJED3GWWwT
X-Received: by 2002:a05:620a:9d1:b0:939:5efe:d980 with SMTP id
 af79cd13be357-939804105c6mr169337885a.21.1788476600482; 
 Thu, 03 Sep 2026 16:03:20 -0700 (PDT)
X-Received: by 2002:a05:620a:9d1:b0:939:5efe:d980 with SMTP id
 af79cd13be357-939804105c6mr169317385a.21.1788476598931; 
 Thu, 03 Sep 2026 16:03:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883acd33sm1693676f8f.18.2026.09.03.16.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 16:03:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 4/4] hw/hotplug: Constify HotplugHandler
Date: Fri,  4 Sep 2026 01:02:45 +0200
Message-ID: <20260903230245.65601-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903230245.65601-1-philmd@oss.qualcomm.com>
References: <20260903230245.65601-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX8ilKMkR2xBGL
 66IYd/3I8p/nJe8PPi6W9uZ5ANOSQVfF3849BjnhImy6LadaSs9IOISEP7abkmSRNy/ZK2ITz9Q
 SiKQS/8dURXV6hYKxgsCXr7s2NcIji6/s8L5VfyW/mtaOGtxxt4bO9uvx9UvSvO5NvhILmx8+Y8
 ou96ry9WXfDJDZj9jDllHfqD1o9zCk2BGctq7UThKC04HCIcz+ib6XcgCEAORRbtjul8KxWzE3P
 7f8M9CeftiUFCOXJERK6vLBZ2C0O89TG6GjRSufVl8lfIYeEphQrFVGJ/RBQqYdsB5UbPqZ5UKF
 LFJFpDA1s7fXwCYA+jRWZnpHBiw6vb3SkXHLV5hkhogty68MhJ1P7iA6EK50OvT4Z+m/895D+w2
 vQUIVH3t/dJX4O0D0xXI2A/Sg5/FqsAgHJgkNfkdzDFLhGZNGY3Zrru6w9nHjW6DA0iTOb3riod
 9v73GywMYJaTuCp7hSA==
X-Proofpoint-ORIG-GUID: cTFAimuGcoLIWkNTcUrlip8HUUWhwCeH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX/DmDAOmeWt3M
 EXFfneokMy59sPSzqh0GjBHnUN06AdO9qTSmO6RwvLm4T0ebkyrvbe26QCdt2pnTB3oZWkhsqLh
 ms5iXkt+e3LloGrl5t3VOfVIHcDjKO0=
X-Proofpoint-GUID: cTFAimuGcoLIWkNTcUrlip8HUUWhwCeH
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a99fcba cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=TOdx9HqFMmWna6nZQ0cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030202
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

HotplugHandler value returned from qdev_get_hotplug_handler()
points to the handler of and object implementing the
TYPE_HOTPLUG_HANDLER interface. That handler mostly points to
read-only section which shouldn't not be updated. Better
protect it with the const qualifier.

Mechanical change using 'sed' then manually adapted coding style.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/s390x/ccw-device.h                  |  2 +-
 include/hw/acpi/cpu.h                  |  4 +--
 include/hw/acpi/cpu_hotplug.h          |  2 +-
 include/hw/acpi/generic_event_device.h |  3 +-
 include/hw/acpi/ich9.h                 | 10 +++---
 include/hw/acpi/memory_hotplug.h       |  4 +--
 include/hw/acpi/pcihp.h                |  8 ++---
 include/hw/core/boards.h               |  4 +--
 include/hw/core/hotplug.h              | 13 +++----
 include/hw/core/qdev.h                 | 12 +++----
 include/hw/i386/microvm.h              |  4 +--
 include/hw/i386/x86.h                  | 10 +++---
 include/hw/mem/nvdimm.h                |  2 +-
 include/hw/pci/pci_bridge.h            |  6 ++--
 include/hw/pci/pcie.h                  |  8 ++---
 include/hw/pci/shpc.h                  |  6 ++--
 include/hw/ppc/spapr_nvdimm.h          |  2 +-
 hw/acpi/acpi-cpu-hotplug-stub.c        |  4 +--
 hw/acpi/acpi-mem-hotplug-stub.c        |  4 +--
 hw/acpi/acpi-nvdimm-stub.c             |  2 +-
 hw/acpi/acpi-pci-hotplug-stub.c        |  8 ++---
 hw/acpi/cpu.c                          |  6 ++--
 hw/acpi/generic_event_device.c         | 11 +++---
 hw/acpi/ich9.c                         | 10 +++---
 hw/acpi/memory_hotplug.c               |  6 ++--
 hw/acpi/nvdimm.c                       |  2 +-
 hw/acpi/pcihp.c                        | 10 +++---
 hw/acpi/piix4.c                        | 12 +++----
 hw/arm/virt.c                          | 23 ++++++------
 hw/char/virtio-serial-bus.c            |  2 +-
 hw/core/hotplug.c                      |  8 ++---
 hw/core/qdev-hotplug.c                 | 10 +++---
 hw/core/qdev.c                         |  2 +-
 hw/i386/microvm.c                      | 12 +++----
 hw/i386/pc.c                           | 28 +++++++--------
 hw/i386/x86-common.c                   |  8 ++---
 hw/intc/loongarch_dintc.c              |  8 ++---
 hw/intc/loongarch_extioi_common.c      |  4 +--
 hw/intc/loongarch_ipi.c                |  4 +--
 hw/loongarch/virt.c                    | 44 +++++++++++------------
 hw/net/virtio-net.c                    |  4 +--
 hw/nvme/ctrl.c                         |  8 ++---
 hw/pci-bridge/pci_bridge_dev.c         |  6 ++--
 hw/pci/pcie.c                          | 10 +++---
 hw/pci/pcie_port.c                     |  2 +-
 hw/pci/shpc.c                          | 10 +++---
 hw/ppc/e500plat.c                      |  4 +--
 hw/ppc/spapr.c                         | 48 +++++++++++++-------------
 hw/ppc/spapr_nvdimm.c                  |  2 +-
 hw/ppc/spapr_pci.c                     | 12 +++----
 hw/remote/machine.c                    |  2 +-
 hw/riscv/virt.c                        |  6 ++--
 hw/s390x/css-bridge.c                  |  2 +-
 hw/s390x/s390-pci-bus.c                | 12 +++----
 hw/s390x/s390-virtio-ccw.c             | 16 ++++-----
 hw/s390x/virtio-ccw-md.c               |  8 ++---
 hw/s390x/virtio-ccw.c                  |  2 +-
 hw/scsi/virtio-scsi.c                  |  6 ++--
 hw/scsi/vmw_pvscsi.c                   |  4 +--
 hw/virtio/virtio-md-pci.c              |  8 ++---
 hw/xen/xen-bus.c                       |  2 +-
 stubs/hotplug-stubs.c                  |  6 ++--
 system/qdev-monitor.c                  |  2 +-
 63 files changed, 257 insertions(+), 253 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 15f64cfb636..c303f1de42c 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -37,7 +37,7 @@ extern const VMStateDescription vmstate_ccw_dev;
 
 struct CCWDeviceClass {
     DeviceClass parent_class;
-    void (*unplug)(HotplugHandler *, DeviceState *, Error **);
+    void (*unplug)(const HotplugHandler *, DeviceState *, Error **);
     bool (*realize)(CcwDevice *, Error **);
     void (*refill_ids)(CcwDevice *);
 };
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 04c821d2b90..3664ac7a52f 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -39,10 +39,10 @@ typedef struct CPUHotplugState {
     AcpiCpuStatus *devs;
 } CPUHotplugState;
 
-void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_plug_cb(const HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp);
 
-void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp);
 
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 5b670b04eb6..bac40ccfa0e 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -25,7 +25,7 @@ typedef struct AcpiCpuHotplug {
     uint8_t sts[ACPI_GPE_PROC_LEN];
 } AcpiCpuHotplug;
 
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void legacy_acpi_cpu_plug_cb(const HotplugHandler *hotplug_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp);
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index 7cbfb5fe7d7..42a8033a23e 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -136,7 +136,8 @@ typedef struct AcpiGedClass {
     ResettablePhases parent_phases;
 } AcpiGedClass;
 
-void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
+void build_ged_aml(Aml *table, const char *name,
+                   const HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
 void acpi_dsdt_add_power_button(Aml *scope);
 
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 6d145447518..6956b2b9c9a 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -85,15 +85,15 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
 void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset);
 
-void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_pre_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
-void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
-void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void ich9_pm_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp);
-void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp);
-bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus);
+bool ich9_pm_is_hotpluggable_bus(const HotplugHandler *hotplug_dev, BusState *bus);
 
 void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
 #endif /* HW_ACPI_ICH9_H */
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index eb7f460afec..6e4f82bcf93 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -36,9 +36,9 @@ typedef struct MemHotplugState {
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
                               MemHotplugState *state, hwaddr io_base);
 
-void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
+void acpi_memory_plug_cb(const HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp);
-void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_memory_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp);
 void acpi_memory_unplug_cb(MemHotplugState *mem_st,
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index efce5fd2e10..21c0b72355d 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -66,13 +66,13 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *,
                      MemoryRegion *io, uint16_t io_base);
 
 bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
-void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
-void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_plug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp);
-void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_unplug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp);
-void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp);
 
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index a436d48c8e5..dba465efc2c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -322,8 +322,8 @@ struct MachineClass {
     SMPCompatProps smp_props;
     const char *default_ram_id;
 
-    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
-                                           DeviceState *dev);
+    const HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
+                                                 DeviceState *dev);
     bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
                             Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
diff --git a/include/hw/core/hotplug.h b/include/hw/core/hotplug.h
index a9840ed4854..0c69be60ee0 100644
--- a/include/hw/core/hotplug.h
+++ b/include/hw/core/hotplug.h
@@ -30,7 +30,7 @@ typedef struct HotplugHandler HotplugHandler;
  * @plugged_dev: a device that has been (un)plugged
  * @errp: returns an error if this function fails
  */
-typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
+typedef void (*hotplug_fn)(const HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp);
 
 /**
@@ -59,7 +59,8 @@ struct HotplugHandlerClass {
     hotplug_fn plug;
     hotplug_fn unplug_request;
     hotplug_fn unplug;
-    bool (*is_hotpluggable_bus)(HotplugHandler *plug_handler, BusState *bus);
+    bool (*is_hotpluggable_bus)(const HotplugHandler *plug_handler,
+                                BusState *bus);
 };
 
 /**
@@ -67,7 +68,7 @@ struct HotplugHandlerClass {
  *
  * Call #HotplugHandlerClass.plug callback of @plug_handler.
  */
-void hotplug_handler_plug(HotplugHandler *plug_handler,
+void hotplug_handler_plug(const HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp);
 
@@ -76,7 +77,7 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
  *
  * Call #HotplugHandlerClass.pre_plug callback of @plug_handler.
  */
-void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
+void hotplug_handler_pre_plug(const HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp);
 
@@ -85,7 +86,7 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
  *
  * Calls #HotplugHandlerClass.unplug_request callback of @plug_handler.
  */
-void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
+void hotplug_handler_unplug_request(const HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp);
 /**
@@ -93,7 +94,7 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
  *
  * Calls #HotplugHandlerClass.unplug callback of @plug_handler.
  */
-void hotplug_handler_unplug(HotplugHandler *plug_handler,
+void hotplug_handler_unplug(const HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp);
 #endif
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e4cb027ab3a..1f6bf3fc1ab 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -386,7 +386,7 @@ struct BusState {
     /* public: */
     DeviceState *parent;
     char *name;
-    HotplugHandler *hotplug_handler;
+    const HotplugHandler *hotplug_handler;
     int max_index;
     bool realized;
     bool full;
@@ -514,8 +514,8 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
-HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
-HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
+const HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
+const HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp);
 bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
 
@@ -529,10 +529,10 @@ bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
  * Return: pointer to object that implements TYPE_HOTPLUG_HANDLER interface
  * or NULL if there aren't any.
  */
-HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
+const HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
 int qdev_sync_config(DeviceState *dev, Error **errp);
-void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
+void qdev_simple_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
 bool qdev_machine_modified(void);
@@ -1065,7 +1065,7 @@ void qbus_set_bus_hotplug_handler(BusState *bus);
 
 static inline bool qbus_is_hotpluggable(BusState *bus)
 {
-    HotplugHandler *plug_handler = bus->hotplug_handler;
+    const HotplugHandler *plug_handler = bus->hotplug_handler;
     bool ret = !!plug_handler;
 
     if (plug_handler) {
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 184b7a8c094..5d5eacd1c6d 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -76,8 +76,8 @@
 
 struct MicrovmMachineClass {
     X86MachineClass parent;
-    HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
-                                           DeviceState *dev);
+    const HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
+                                                  DeviceState *dev);
     void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
                            int acpi_data_size);
 };
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 71fe6b5e122..abb073ca47d 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -46,7 +46,7 @@ struct X86MachineState {
     qemu_irq *gsi;
     DeviceState *ioapic2;
     GMappedFile *initrd_mapped_file;
-    HotplugHandler *acpi_dev;
+    const HotplugHandler *acpi_dev;
 
     /*
      * Map the whole BIOS just underneath the 4 GiB address boundary. Only used
@@ -112,13 +112,13 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
 void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
-void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
+void x86_cpu_pre_plug(const HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
-void x86_cpu_plug(HotplugHandler *hotplug_dev,
+void x86_cpu_plug(const HotplugHandler *hotplug_dev,
                   DeviceState *dev, Error **errp);
-void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void x86_cpu_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp);
-void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
+void x86_cpu_unplug_cb(const HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
 void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index d3b763453a5..169a943e3ce 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -157,5 +157,5 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        uint32_t ram_slots, const char *oem_id,
                        const char *oem_table_id);
 void nvdimm_plug(NVDIMMState *state);
-void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
+void nvdimm_acpi_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev);
 #endif
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index b61360b9007..f114f0a6517 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -141,11 +141,11 @@ void pci_bridge_reset(DeviceState *qdev);
 void pci_bridge_initfn(PCIDevice *pci_dev, const char *typename);
 void pci_bridge_exitfn(PCIDevice *pci_dev);
 
-void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pci_bridge_dev_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
-void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pci_bridge_dev_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp);
-void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
+void pci_bridge_dev_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp);
 
 /*
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 71ba94874b4..ec25e7a7de9 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -146,13 +146,13 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                PCIExpLinkSpeed speed, bool flitmode);
 
-void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_pre_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
-void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
-void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp);
-void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
+void pcie_cap_slot_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
 
 void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index fce5bdd3bc7..67becb5c568 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -45,11 +45,11 @@ void shpc_free(PCIDevice *dev);
 void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
 
 
-void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void shpc_device_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                          Error **errp);
-void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void shpc_device_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp);
-void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void shpc_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
 
 extern const VMStateInfo shpc_vmstate_info;
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index e9436cb6ef6..386da920422 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -18,7 +18,7 @@ typedef struct SpaprMachineState SpaprMachineState;
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt);
-bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+bool spapr_nvdimm_validate(const HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot);
 void spapr_nvdimm_finish_flushes(void);
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 72c5f05f5c4..2e05d7100b6 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -14,7 +14,7 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
 }
 
-void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_plug_cb(const HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
 {
 }
@@ -24,7 +24,7 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
 {
 }
 
-void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/acpi-mem-hotplug-stub.c b/hw/acpi/acpi-mem-hotplug-stub.c
index 7ad0fdcdf26..c218813fd18 100644
--- a/hw/acpi/acpi-mem-hotplug-stub.c
+++ b/hw/acpi/acpi-mem-hotplug-stub.c
@@ -13,7 +13,7 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list)
 {
 }
 
-void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
+void acpi_memory_plug_cb(const HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
 }
@@ -23,7 +23,7 @@ void acpi_memory_unplug_cb(MemHotplugState *mem_st,
 {
 }
 
-void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_memory_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/acpi-nvdimm-stub.c b/hw/acpi/acpi-nvdimm-stub.c
index 22ba17f5118..0120bacaace 100644
--- a/hw/acpi/acpi-nvdimm-stub.c
+++ b/hw/acpi/acpi-nvdimm-stub.c
@@ -2,6 +2,6 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/core/hotplug.h"
 
-void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
+void nvdimm_acpi_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
 }
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index d58ea726a82..20625c7ed7d 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -9,22 +9,22 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
 {
 }
 
-void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_plug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp)
 {
 }
 
-void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
 }
 
-void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_unplug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
 }
 
-void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp)
 {
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index d63ca83c1bc..ef97ed779a5 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -132,7 +132,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             trace_cpuhp_acpi_clear_remove_evt(cpu_st->selector);
         } else if (data & 8) {
             DeviceState *dev = NULL;
-            HotplugHandler *hotplug_ctrl = NULL;
+            const HotplugHandler *hotplug_ctrl;
 
             if (!cdev->cpu || cdev->cpu == first_cpu) {
                 trace_cpuhp_acpi_ejecting_invalid_cpu(cpu_st->selector);
@@ -247,7 +247,7 @@ static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
     return NULL;
 }
 
-void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_plug_cb(const HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
 {
     AcpiCpuStatus *cdev;
@@ -264,7 +264,7 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 5225e325132..65a5d1612fa 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -45,7 +45,8 @@ static const uint32_t ged_supported_events[] = {
  * affected by the interrupt. This way, we can support up to 32 events
  * with a unique interrupt.
  */
-void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
+void build_ged_aml(Aml *table, const char *name,
+                   const HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base)
 {
     const AcpiGedState *s = ACPI_GED(hotplug_dev);
@@ -250,7 +251,7 @@ static const MemoryRegionOps ged_regs_ops = {
     },
 };
 
-static void acpi_ged_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+static void acpi_ged_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
@@ -258,7 +259,7 @@ static void acpi_ged_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
+static void acpi_ged_device_plug_cb(const HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
     AcpiGedState *s = ACPI_GED(hotplug_dev);
@@ -279,7 +280,7 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
+static void acpi_ged_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
     AcpiGedState *s = ACPI_GED(hotplug_dev);
@@ -298,7 +299,7 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
+static void acpi_ged_unplug_cb(const HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp)
 {
     AcpiGedState *s = ACPI_GED(hotplug_dev);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 8082eae4282..6d421b990ce 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -410,7 +410,7 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
 
 #undef PM_REG_FIELD
 
-void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_pre_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
@@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
@@ -455,7 +455,7 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void ich9_pm_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
@@ -489,7 +489,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void ich9_pm_device_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
@@ -507,7 +507,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus)
+bool ich9_pm_is_hotpluggable_bus(const HotplugHandler *hotplug_dev, BusState *bus)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
     return acpi_pcihp_is_hotpluggable_bus(&lpc->pm.acpi_pci_hotplug, bus);
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index f482c835a1c..b5b6d6ada63 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -166,7 +166,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             mdev->is_removing = false;
             trace_mhp_acpi_clear_remove_evt(mem_st->selector);
         } else if (data & 8) {
-            HotplugHandler *hotplug_ctrl;
+            const HotplugHandler *hotplug_ctrl;
 
             if (!mdev->is_enabled) {
                 trace_mhp_acpi_ejecting_invalid_slot(mem_st->selector);
@@ -254,7 +254,7 @@ acpi_memory_slot_status(MemHotplugState *mem_st,
     return &mem_st->devs[slot];
 }
 
-void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
+void acpi_memory_plug_cb(const HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
     MemStatus *mdev;
@@ -277,7 +277,7 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
     }
 }
 
-void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_memory_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp)
 {
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 703e854951e..5a7ff1ede8f 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -887,7 +887,7 @@ static const MemoryRegionOps nvdimm_dsm_ops = {
     },
 };
 
-void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
+void nvdimm_acpi_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     if (dev->hotplugged) {
         acpi_send_event(DEVICE(hotplug_dev), ACPI_NVDIMM_HOTPLUG_STATUS);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 336ebe1a13e..b69379a18be 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -209,7 +209,7 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
                      */
                     qdev->pending_deleted_event = false;
                 } else {
-                    HotplugHandler *hotplug_ctrl;
+                    const HotplugHandler *hotplug_ctrl;
 
                     hotplug_ctrl = qdev_get_hotplug_handler(qdev);
                     hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
@@ -261,7 +261,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
     acpi_pcihp_update(s);
 }
 
-void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
@@ -275,7 +275,7 @@ void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_plug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
@@ -317,7 +317,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
-void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_unplug_cb(const HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
@@ -328,7 +328,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     qdev_unrealize(dev);
 }
 
-void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_pcihp_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp)
 {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 52bd61667f9..a7d5356340b 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -303,8 +303,8 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
     acpi_pm1_evt_power_down(&s->ar);
 }
 
-static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
-                                    DeviceState *dev, Error **errp)
+static void piix4_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
 
@@ -323,7 +323,7 @@ static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
+static void piix4_device_plug_cb(const HotplugHandler *hotplug_dev,
                                  DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
@@ -344,7 +344,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+static void piix4_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                            DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
@@ -364,7 +364,7 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
+static void piix4_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
@@ -383,7 +383,7 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static bool piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
+static bool piix4_is_hotpluggable_bus(const HotplugHandler *hotplug_dev,
                                       BusState *bus)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11f..3eecf094bcc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3753,7 +3753,7 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void virt_memory_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3779,7 +3779,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
-static void virt_memory_plug(HotplugHandler *hotplug_dev,
+static void virt_memory_plug(const HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3798,7 +3798,7 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+static void virt_machine_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3896,7 +3896,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+static void virt_machine_device_plug_cb(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3957,7 +3957,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
+static void virt_dimm_unplug_request(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3977,7 +3977,7 @@ static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
                                    errp);
 }
 
-static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
+static void virt_dimm_unplug(const HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
@@ -3995,8 +3995,9 @@ out:
     error_propagate(errp, local_err);
 }
 
-static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
-                                          DeviceState *dev, Error **errp)
+static void
+virt_machine_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_dimm_unplug_request(hotplug_dev, dev, errp);
@@ -4009,7 +4010,7 @@ static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+static void virt_machine_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -4022,8 +4023,8 @@ static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
-                                                        DeviceState *dev)
+static const HotplugHandler *
+virt_machine_get_hotplug_handler(MachineState *machine, DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 83a033ce855..109769227b2 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -975,7 +975,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
     port->elem = NULL;
 }
 
-static void virtser_port_device_plug(HotplugHandler *hotplug_dev,
+static void virtser_port_device_plug(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 00e80a67c80..3aca0688406 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -13,7 +13,7 @@
 #include "hw/core/hotplug.h"
 #include "qemu/module.h"
 
-void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
+void hotplug_handler_pre_plug(const HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
 {
@@ -24,7 +24,7 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
     }
 }
 
-void hotplug_handler_plug(HotplugHandler *plug_handler,
+void hotplug_handler_plug(const HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp)
 {
@@ -35,7 +35,7 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
     }
 }
 
-void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
+void hotplug_handler_unplug_request(const HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
 {
@@ -46,7 +46,7 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
     }
 }
 
-void hotplug_handler_unplug(HotplugHandler *plug_handler,
+void hotplug_handler_unplug(const HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp)
 {
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index 1d547e0dbdf..d7fa8a5ed27 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -14,7 +14,7 @@
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 
-HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
+const HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
     MachineState *machine;
     MachineClass *mc;
@@ -90,7 +90,7 @@ bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
            qdev_hotplug_unplug_allowed_common(dev, dev->parent_bus, errp);
 }
 
-HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
+const HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
         return dev->parent_bus->hotplug_handler;
@@ -98,9 +98,9 @@ HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
-HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
+const HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
+    const HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
 
     if (hotplug_ctrl == NULL && dev->parent_bus) {
         hotplug_ctrl = qdev_get_bus_hotplug_handler(dev);
@@ -109,7 +109,7 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 }
 
 /* can be used as ->unplug() callback for the simple cases */
-void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
+void qdev_simple_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
     qdev_unrealize(dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0b0f2f47fa7..c6540bec56a 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -501,7 +501,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
-    HotplugHandler *hotplug_ctrl;
+    const HotplugHandler *hotplug_ctrl;
     BusState *bus;
     NamedClockList *ncl;
     Error *local_err = NULL;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e7adab7d2ef..a49de337497 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -416,7 +416,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     g_free(cmdline);
 }
 
-static void microvm_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+static void microvm_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
     X86CPU *cpu = X86_CPU(dev);
@@ -425,26 +425,26 @@ static void microvm_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     x86_cpu_pre_plug(hotplug_dev, dev, errp);
 }
 
-static void microvm_device_plug_cb(HotplugHandler *hotplug_dev,
+static void microvm_device_plug_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     x86_cpu_plug(hotplug_dev, dev, errp);
 }
 
-static void microvm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+static void microvm_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                              DeviceState *dev, Error **errp)
 {
     error_setg(errp, "unplug not supported by microvm");
 }
 
-static void microvm_device_unplug_cb(HotplugHandler *hotplug_dev,
+static void microvm_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     error_setg(errp, "unplug not supported by microvm");
 }
 
-static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
-                                                   DeviceState *dev)
+static const HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
+                                                         DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e9e4fc262b8..9006e7c29e1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1181,7 +1181,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     g_free(i8259);
 }
 
-static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void pc_memory_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     const X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
@@ -1214,7 +1214,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
-static void pc_memory_plug(HotplugHandler *hotplug_dev,
+static void pc_memory_plug(const HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -1231,7 +1231,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     hotplug_handler_plug(x86ms->acpi_dev, dev, &error_abort);
 }
 
-static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
+static void pc_memory_unplug_request(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
@@ -1256,7 +1256,7 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                    errp);
 }
 
-static void pc_memory_unplug(HotplugHandler *hotplug_dev,
+static void pc_memory_unplug(const HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
@@ -1274,7 +1274,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
+static void pc_hv_balloon_pre_plug(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     /* The vmbus handler has no hotplug handler; we should never end up here. */
@@ -1282,13 +1282,13 @@ static void pc_hv_balloon_pre_plug(HotplugHandler *hotplug_dev,
     memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), errp);
 }
 
-static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
+static void pc_hv_balloon_plug(const HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp)
 {
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
 }
 
-static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
+static void pc_sp_mem_pre_plug(const HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(hotplug_dev);
@@ -1304,7 +1304,7 @@ static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
     memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
 }
 
-static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
+static void pc_sp_mem_plug(const HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
     SpMemDevice *spm = SP_MEM(dev);
@@ -1318,7 +1318,7 @@ static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
     e820_add_entry(addr, size, E820_SOFT_RESERVED);
 }
 
-static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+static void pc_machine_device_pre_plug_cb(const HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -1356,7 +1356,7 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+static void pc_machine_device_plug_cb(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -1372,7 +1372,7 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+static void pc_machine_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -1388,7 +1388,7 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+static void pc_machine_device_unplug_cb(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -1403,8 +1403,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
-                                             DeviceState *dev)
+static const HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
+                                                    DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM) ||
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 8f9419e7d36..ae583527606 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -158,7 +158,7 @@ static CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
     return found_cpu;
 }
 
-void x86_cpu_plug(HotplugHandler *hotplug_dev,
+void x86_cpu_plug(const HotplugHandler *hotplug_dev,
                   DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
@@ -199,7 +199,7 @@ out:
     error_propagate(errp, local_err);
 }
 
-void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void x86_cpu_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                DeviceState *dev, Error **errp)
 {
     int idx = -1;
@@ -222,7 +222,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    errp);
 }
 
-void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
+void x86_cpu_unplug_cb(const HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp)
 {
     CPUArchId *found_cpu;
@@ -248,7 +248,7 @@ void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
+void x86_cpu_pre_plug(const HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp)
 {
     int idx;
diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 94d418261c1..c27ab4d3935 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -159,8 +159,8 @@ static DINTCCore *loongarch_dintc_get_cpu(LoongArchDINTCState *s,
     return NULL;
 }
 
-static void loongarch_dintc_cpu_plug(HotplugHandler *hotplug_dev,
-                                   DeviceState *dev, Error **errp)
+static void loongarch_dintc_cpu_plug(const HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
 {
     LoongArchDINTCState *s = LOONGARCH_DINTC(hotplug_dev);
     Object *obj = OBJECT(dev);
@@ -185,8 +185,8 @@ static void loongarch_dintc_cpu_plug(HotplugHandler *hotplug_dev,
     return;
 }
 
-static void loongarch_dintc_cpu_unplug(HotplugHandler *hotplug_dev,
-                                     DeviceState *dev, Error **errp)
+static void loongarch_dintc_cpu_unplug(const HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
 {
     LoongArchDINTCState *s = LOONGARCH_DINTC(hotplug_dev);
     Object *obj = OBJECT(dev);
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index 5cb0d396c65..22cbb7a0977 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -28,7 +28,7 @@ static ExtIOICore *loongarch_extioi_get_cpu(LoongArchExtIOICommonState *s,
     return NULL;
 }
 
-static void loongarch_extioi_cpu_plug(HotplugHandler *hotplug_dev,
+static void loongarch_extioi_cpu_plug(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(hotplug_dev);
@@ -60,7 +60,7 @@ static void loongarch_extioi_cpu_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void loongarch_extioi_cpu_unplug(HotplugHandler *hotplug_dev,
+static void loongarch_extioi_cpu_unplug(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(hotplug_dev);
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 5d8b8c96df7..227b72ef7c9 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -128,7 +128,7 @@ static void loongarch_ipi_reset_hold(Object *obj, ResetType type)
     }
 }
 
-static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
+static void loongarch_ipi_cpu_plug(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(hotplug_dev);
@@ -154,7 +154,7 @@ static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
     qdev_connect_gpio_out(DEVICE(lics), index, qdev_get_gpio_in(dev, IRQ_IPI));
 }
 
-static void loongarch_ipi_cpu_unplug(HotplugHandler *hotplug_dev,
+static void loongarch_ipi_cpu_unplug(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(hotplug_dev);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9cc79929a8a..9c5371af9de 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1167,7 +1167,7 @@ static CPUArchId *virt_find_empty_cpu_slot(MachineState *ms)
     return NULL;
 }
 
-static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
+static void virt_cpu_pre_plug(const HotplugHandler *hotplug_dev,
                               DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
@@ -1229,7 +1229,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
-static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
+static void virt_cpu_unplug_request(const HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
@@ -1246,7 +1246,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
 }
 
-static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
+static void virt_cpu_unplug(const HotplugHandler *hotplug_dev,
                             DeviceState *dev, Error **errp)
 {
     CPUArchId *cpu_slot;
@@ -1268,7 +1268,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     cpu_slot->cpu = NULL;
 }
 
-static void virt_cpu_plug(HotplugHandler *hotplug_dev,
+static void virt_cpu_plug(const HotplugHandler *hotplug_dev,
                           DeviceState *dev, Error **errp)
 {
     CPUArchId *cpu_slot;
@@ -1304,14 +1304,14 @@ static bool memhp_type_supported(DeviceState *dev)
            !object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 }
 
-static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                                 Error **errp)
+static void virt_mem_pre_plug(const HotplugHandler *hotplug_dev,
+                              DeviceState *dev, Error **errp)
 {
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), errp);
 }
 
-static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
-                                            DeviceState *dev, Error **errp)
+static void virt_device_pre_plug(const HotplugHandler *hotplug_dev,
+                                 DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
@@ -1320,8 +1320,8 @@ static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
-                                     DeviceState *dev, Error **errp)
+static void virt_mem_unplug_request(const HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
@@ -1330,8 +1330,8 @@ static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                    errp);
 }
 
-static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
-                                          DeviceState *dev, Error **errp)
+static void virt_device_unplug_request(const HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
@@ -1340,8 +1340,8 @@ static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_mem_unplug(HotplugHandler *hotplug_dev,
-                             DeviceState *dev, Error **errp)
+static void virt_mem_unplug(const HotplugHandler *hotplug_dev,
+                            DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
@@ -1350,8 +1350,8 @@ static void virt_mem_unplug(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-static void virt_device_unplug(HotplugHandler *hotplug_dev,
-                                          DeviceState *dev, Error **errp)
+static void virt_device_unplug(const HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
@@ -1360,8 +1360,8 @@ static void virt_device_unplug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void virt_mem_plug(HotplugHandler *hotplug_dev,
-                             DeviceState *dev, Error **errp)
+static void virt_mem_plug(const HotplugHandler *hotplug_dev,
+                          DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
@@ -1370,8 +1370,8 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
-static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
-                                        DeviceState *dev, Error **errp)
+static void virt_device_plug_cb(const HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
     MachineClass *mc = MACHINE_GET_CLASS(lvms);
@@ -1389,8 +1389,8 @@ static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
-                                                DeviceState *dev)
+static const HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
+                                                      DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d2..b9a3cddc533 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3749,7 +3749,7 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
 
 static bool failover_unplug_primary(VirtIONet *n, DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl;
+    const HotplugHandler *hotplug_ctrl;
     PCIDevice *pci_dev;
     Error *err = NULL;
 
@@ -3772,7 +3772,7 @@ static bool failover_replug_primary(VirtIONet *n, DeviceState *dev,
                                     Error **errp)
 {
     Error *err = NULL;
-    HotplugHandler *hotplug_ctrl;
+    const HotplugHandler *hotplug_ctrl;
     PCIDevice *pdev = PCI_DEVICE(dev);
     BusState *primary_bus;
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e741..4708909e0f0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -10595,8 +10595,8 @@ static const TypeInfo nvme_info = {
     },
 };
 
-static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                              Error **errp)
+static void nvme_ns_hot_plug(const HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
     NvmeSubsystem *subsys = ns->subsys;
@@ -10627,8 +10627,8 @@ static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                               Error **errp)
+static void nvme_ns_hot_unplug(const HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
     NvmeSubsystem *subsys = ns->subsys;
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 0c1383562d9..bc53bcb69d8 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -205,7 +205,7 @@ static const VMStateDescription pci_bridge_dev_vmstate = {
     }
 };
 
-void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pci_bridge_dev_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
@@ -218,7 +218,7 @@ void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_device_plug_cb(hotplug_dev, dev, errp);
 }
 
-void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pci_bridge_dev_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
@@ -227,7 +227,7 @@ void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_device_unplug_cb(hotplug_dev, dev, errp);
 }
 
-void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
+void pci_bridge_dev_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4622c75e48c..42bcb9206d5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -508,7 +508,7 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
     }
 }
 
-void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_pre_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
@@ -525,7 +525,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
 }
 
-void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_plug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp)
 {
     PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
@@ -571,7 +571,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void pcie_cap_slot_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp)
 {
     qdev_unrealize(dev);
@@ -579,7 +579,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 
 static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
+    const HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
 
     if (dev->partially_hotplugged) {
         dev->qdev.pending_deleted_event = false;
@@ -608,7 +608,7 @@ static void pcie_cap_slot_do_unplug(PCIDevice *dev)
                                PCI_EXP_SLTSTA_PDC);
 }
 
-void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
+void pcie_cap_slot_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index dbb6032160e..57fcc9079a6 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -188,7 +188,7 @@ int pcie_count_ds_ports(PCIBus *bus)
     return dsp_count;
 }
 
-static bool pcie_slot_is_hotpluggable_bus(HotplugHandler *plug_handler,
+static bool pcie_slot_is_hotpluggable_bus(const HotplugHandler *plug_handler,
                                           BusState *bus)
 {
     PCIESlot *s = PCIE_SLOT(bus->parent);
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 1198e1ab8c0..3f24ca84f55 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -278,7 +278,7 @@ static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
          ++devfn) {
         PCIDevice *affected_dev = shpc->sec_bus->devices[devfn];
         if (affected_dev) {
-            HotplugHandler *hotplug_ctrl;
+            const HotplugHandler *hotplug_ctrl;
 
             hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(affected_dev));
             hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
@@ -561,8 +561,8 @@ static bool shpc_device_get_slot(PCIDevice *affected_dev, int *slot,
     return true;
 }
 
-void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
-                            Error **errp)
+void shpc_device_plug_cb(const HotplugHandler *hotplug_dev,
+                         DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
     SHPCDevice *shpc = pci_hotplug_dev->shpc;
@@ -601,13 +601,13 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     shpc_interrupt_update(pci_hotplug_dev);
 }
 
-void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
+void shpc_device_unplug_cb(const HotplugHandler *hotplug_dev, DeviceState *dev,
                            Error **errp)
 {
     qdev_unrealize(dev);
 }
 
-void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+void shpc_device_unplug_request_cb(const HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 85cec810d9a..4bc1426dc82 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -42,7 +42,7 @@ static void e500plat_init(MachineState *machine)
     ppce500_init(machine);
 }
 
-static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+static void e500plat_machine_device_plug_cb(const HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
     PPCE500MachineState *pms = PPCE500_MACHINE(hotplug_dev);
@@ -53,7 +53,7 @@ static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static
+static const
 HotplugHandler *e500plat_machine_get_hotpug_handler(MachineState *machine,
                                                     DeviceState *dev)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 20e024907b1..6d994644865 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3616,7 +3616,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     }
 }
 
-static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_memory_plug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
@@ -3642,7 +3642,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
     }
 }
 
-static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void spapr_memory_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
@@ -3807,7 +3807,7 @@ void spapr_memory_unplug_rollback(SpaprMachineState *spapr, DeviceState *dev)
 /* Callback to be called during DRC release. */
 void spapr_lmb_release(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    const HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_ctrl);
     SpaprDimmState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
@@ -3832,7 +3832,7 @@ void spapr_lmb_release(DeviceState *dev)
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_memory_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     SpaprDimmState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
@@ -3845,7 +3845,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
 
-static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
+static void spapr_memory_unplug_request(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
@@ -3899,14 +3899,14 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
 /* Callback to be called during DRC release. */
 void spapr_core_release(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    const HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
 
     /* Call the unplug handler chain. This can never fail. */
     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_core_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     MachineState *ms = MACHINE(hotplug_dev);
     CPUCore *cc = CPU_CORE(dev);
@@ -3918,7 +3918,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
 }
 
 static
-void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
+void spapr_core_unplug_request(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
@@ -3988,7 +3988,7 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     return 0;
 }
 
-static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_core_plug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(spapr);
@@ -4043,7 +4043,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
 }
 
-static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void spapr_core_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
@@ -4169,7 +4169,7 @@ static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
     return true;
 }
 
-static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static bool spapr_phb_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
@@ -4198,7 +4198,7 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                windows_supported, sphb->dma_liobn, errp);
 }
 
-static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_phb_plug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
     SpaprDrc *drc;
@@ -4220,18 +4220,18 @@ static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
 void spapr_phb_release(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    const HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
 
     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
     object_unparent(OBJECT(dev));
 }
 
-static void spapr_phb_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_phb_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     qdev_unrealize(dev);
 }
 
-static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
+static void spapr_phb_unplug_request(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
@@ -4251,7 +4251,7 @@ static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
 }
 
 static
-bool spapr_tpm_proxy_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+bool spapr_tpm_proxy_pre_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
@@ -4264,7 +4264,7 @@ bool spapr_tpm_proxy_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return true;
 }
 
-static void spapr_tpm_proxy_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_tpm_proxy_plug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(dev);
@@ -4275,7 +4275,7 @@ static void spapr_tpm_proxy_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
     spapr->tpm_proxy = tpm_proxy;
 }
 
-static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+static void spapr_tpm_proxy_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
 
@@ -4284,7 +4284,7 @@ static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceState *dev
     spapr->tpm_proxy = NULL;
 }
 
-static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
+static void spapr_machine_device_plug(const HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -4298,7 +4298,7 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
+static void spapr_machine_device_unplug(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -4324,7 +4324,7 @@ bool spapr_memory_hot_unplug_supported(SpaprMachineState *spapr)
         spapr_ovec_empty(spapr->ov5_cas);
 }
 
-static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
+static void spapr_machine_device_unplug_request(const HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
     SpaprMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
@@ -4349,7 +4349,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
-static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+static void spapr_machine_device_pre_plug(const HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
@@ -4363,8 +4363,8 @@ static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
-                                                 DeviceState *dev)
+static const HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
+                                                       DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 66474283915..542ed79497a 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -64,7 +64,7 @@ struct SPAPRNVDIMMClass {
     void (*unrealize)(NVDIMMDevice *dimm, Error **errp);
 };
 
-bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
+bool spapr_nvdimm_validate(const HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp)
 {
     const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c1d4b7806e4..f7fc544d35c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1445,7 +1445,7 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
 /* Callback to be called during DRC release. */
 void spapr_phb_remove_pci_device_cb(DeviceState *dev)
 {
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    const HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
 
     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
     object_unparent(OBJECT(dev));
@@ -1454,7 +1454,7 @@ void spapr_phb_remove_pci_device_cb(DeviceState *dev)
 int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
-    HotplugHandler *plug_handler = qdev_get_hotplug_handler(drc->dev);
+    const HotplugHandler *plug_handler = qdev_get_hotplug_handler(drc->dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(plug_handler);
     PCIDevice *pdev = PCI_DEVICE(drc->dev);
 
@@ -1521,7 +1521,7 @@ static bool bridge_has_valid_chassis_nr(Object *bridge, Error **errp)
     return true;
 }
 
-static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
+static void spapr_pci_pre_plug(const HotplugHandler *plug_handler,
                                DeviceState *plugged_dev, Error **errp)
 {
     SpaprPhbState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
@@ -1556,7 +1556,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
     }
 }
 
-static void spapr_pci_plug(HotplugHandler *plug_handler,
+static void spapr_pci_plug(const HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
     SpaprPhbState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
@@ -1614,7 +1614,7 @@ static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
     remove_drcs(phb, bus);
 }
 
-static void spapr_pci_unplug(HotplugHandler *plug_handler,
+static void spapr_pci_unplug(const HotplugHandler *plug_handler,
                              DeviceState *plugged_dev, Error **errp)
 {
     SpaprPhbState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
@@ -1639,7 +1639,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_handler,
     qdev_unrealize(plugged_dev);
 }
 
-static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
+static void spapr_pci_unplug_request(const HotplugHandler *plug_handler,
                                      DeviceState *plugged_dev, Error **errp)
 {
     SpaprPhbState *phb = SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index ced782f6a9c..f79f5a05657 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -111,7 +111,7 @@ static void remote_machine_instance_init(Object *obj)
     s->auto_shutdown = true;
 }
 
-static void remote_machine_dev_unplug_cb(HotplugHandler *hotplug_dev,
+static void remote_machine_dev_unplug_cb(const HotplugHandler *hotplug_dev,
                                          DeviceState *dev, Error **errp)
 {
     qdev_unrealize(dev);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dd396410178..f1538d63f86 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1693,8 +1693,8 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->acpi, errp);
 }
 
-static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
-                                                        DeviceState *dev)
+static const HotplugHandler *
+virt_machine_get_hotplug_handler(MachineState *machine, DeviceState *dev)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
@@ -1709,7 +1709,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
+static void virt_machine_device_plug_cb(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(hotplug_dev);
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 440fefb7d0f..e7cd9ac7b60 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -26,7 +26,7 @@
  * (including sending a channel report to the guest) and remove the
  * device from the virtual css bus.
  */
-static void ccw_device_unplug(HotplugHandler *hotplug_dev,
+static void ccw_device_unplug(const HotplugHandler *hotplug_dev,
                               DeviceState *dev, Error **errp)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eff980fdfe9..2eb4e8cec42 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -158,7 +158,7 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
 
 static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 {
-    HotplugHandler *hotplug_ctrl;
+    const HotplugHandler *hotplug_ctrl;
 
     if (pbdev->pft == ZPCI_PFT_ISM) {
         notifier_remove(&pbdev->shutdown_notifier);
@@ -1005,8 +1005,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
     return true;
 }
 
-static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                                   Error **errp)
+static void s390_pcihost_pre_plug(const HotplugHandler *hotplug_dev,
+                                  DeviceState *dev, Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
 
@@ -1079,7 +1079,7 @@ static int s390_pci_interp_plug(S390pciState *s, S390PCIBusDevice *pbdev)
     return 0;
 }
 
-static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
@@ -1216,7 +1216,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
@@ -1255,7 +1255,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
+static void s390_pcihost_unplug_request(const HotplugHandler *hotplug_dev,
                                         DeviceState *dev,
                                         Error **errp)
 {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 17266779a6c..7fb78d8fa1a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -343,8 +343,8 @@ static void ccw_init(MachineState *machine)
 
 }
 
-static void s390_cpu_plug(HotplugHandler *hotplug_dev,
-                        DeviceState *dev, Error **errp)
+static void s390_cpu_plug(const HotplugHandler *hotplug_dev,
+                          DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
     MachineState *ms = MACHINE(hotplug_dev);
@@ -608,7 +608,7 @@ out_lock:
     bql_lock();
 }
 
-static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+static void s390_machine_device_pre_plug(const HotplugHandler *hotplug_dev,
                                          DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
@@ -618,7 +618,7 @@ static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
+static void s390_machine_device_plug(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(hotplug_dev);
@@ -648,7 +648,7 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
+static void s390_machine_device_unplug_request(const HotplugHandler *hotplug_dev,
                                                DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
@@ -662,7 +662,7 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
-static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
+static void s390_machine_device_unplug(const HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
@@ -715,8 +715,8 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
-                                                DeviceState *dev)
+static const HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
+                                                      DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
index 0b18b49bc48..70dbea819ad 100644
--- a/hw/s390x/virtio-ccw-md.c
+++ b/hw/s390x/virtio-ccw-md.c
@@ -19,7 +19,7 @@
 void virtio_ccw_md_pre_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
@@ -48,7 +48,7 @@ void virtio_ccw_md_pre_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
 void virtio_ccw_md_plug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
@@ -72,7 +72,7 @@ void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
 {
     VirtIOMDCcwClass *vmdc = VIRTIO_MD_CCW_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
@@ -112,7 +112,7 @@ void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
 void virtio_ccw_md_unplug(VirtIOMDCcw *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d82874ed27e..30fb2c0681f 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1235,7 +1235,7 @@ static void virtio_ccw_busdev_unrealize(DeviceState *dev)
     virtio_ccw_device_unrealize(_dev);
 }
 
-static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
+static void virtio_ccw_busdev_unplug(const HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = to_virtio_ccw_dev_fast(dev);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a8..de6fc0d8316 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1140,14 +1140,14 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
     }
 }
 
-static void virtio_scsi_pre_hotplug(HotplugHandler *hotplug_dev,
+static void virtio_scsi_pre_hotplug(const HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
     SCSIDevice *sd = SCSI_DEVICE(dev);
     sd->hba_supports_iothread = true;
 }
 
-static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void virtio_scsi_hotplug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
@@ -1179,7 +1179,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
-static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+static void virtio_scsi_hotunplug(const HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 05f93171cd7..77c9b843b43 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -612,7 +612,7 @@ pvscsi_send_msg(PVSCSIState *s, SCSIDevice *dev, uint32_t msg_type)
 }
 
 static void
-pvscsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev, Error **errp)
+pvscsi_hotplug(const HotplugHandler *hotplug_dev, DeviceState *dev, Error **errp)
 {
     PVSCSIState *s = PVSCSI(hotplug_dev);
 
@@ -620,7 +620,7 @@ pvscsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev, Error **errp)
 }
 
 static void
-pvscsi_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *dev, Error **errp)
+pvscsi_hot_unplug(const HotplugHandler *hotplug_dev, DeviceState *dev, Error **errp)
 {
     PVSCSIState *s = PVSCSI(hotplug_dev);
 
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index aa5b11c0f60..97ea0ec7b31 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -19,7 +19,7 @@
 void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
@@ -47,7 +47,7 @@ void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 void virtio_md_pci_plug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
@@ -71,7 +71,7 @@ void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
 {
     VirtIOMDPCIClass *vmdc = VIRTIO_MD_PCI_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
@@ -110,7 +110,7 @@ void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
 void virtio_md_pci_unplug(VirtIOMDPCI *vmd, MachineState *ms, Error **errp)
 {
     DeviceState *dev = DEVICE(vmd);
-    HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
+    const HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
     MemoryDeviceState *md = MEMORY_DEVICE(vmd);
     Error *local_err = NULL;
 
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 1762816bf46..8def3bb68bc 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -374,7 +374,7 @@ fail:
     g_free(key);
 }
 
-static void xen_bus_unplug_request(HotplugHandler *hotplug,
+static void xen_bus_unplug_request(const HotplugHandler *hotplug,
                                    DeviceState *dev,
                                    Error **errp)
 {
diff --git a/stubs/hotplug-stubs.c b/stubs/hotplug-stubs.c
index 0f592ee1391..32b4af79974 100644
--- a/stubs/hotplug-stubs.c
+++ b/stubs/hotplug-stubs.c
@@ -14,19 +14,19 @@
 #include "qemu/osdep.h"
 #include "hw/core/qdev.h"
 
-HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
+const HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
     return NULL;
 }
 
-void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
+void hotplug_handler_pre_plug(const HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
 {
     g_assert_not_reached();
 }
 
-void hotplug_handler_plug(HotplugHandler *plug_handler,
+void hotplug_handler_plug(const HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp)
 {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 0c5502d45b6..a62ad23ecf0 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -917,7 +917,7 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
-    HotplugHandler *hotplug_ctrl;
+    const HotplugHandler *hotplug_ctrl;
     const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
-- 
2.53.0


