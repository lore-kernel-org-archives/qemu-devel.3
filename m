Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B53C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GSM-0006Oz-Ue; Thu, 03 Sep 2026 19:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSL-0006MK-KJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:02:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSJ-000342-Rs
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:02:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683Jgosb2573218
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 23:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6SAf4dHCuT8D66OHUrhik5
 1h6jS4FJ804YHBw3oOzF4=; b=PbslE+aOzUXEtGTuJbv68V2WVbx9DL+U7HKsa5
 NOTHURvdH3j3qRZkgI/WknLOCIplP08MtWts7Dyadf8niy7kKVS7CkotSyR3f6UW
 FBaX8R9qM3LmFm+egtV077BUXuo+Dvp0eyhFxAhbHT0hTCzaHUReFOVnDSvEr88t
 2s9BQV9m3uedqNyvR8bCutwAnknxV9IgwTCVi3NRYvp6otcvhAAemzt6lSqgwdNh
 gFnxlI0GSIN6yQmOmZHWOs8cg6IRcv7yUT7krKDeRaTo0bV6VKssjg2pUTcqz3Ks
 amgzHhGv6z7BZbx7OSCCUNuVnxzGiAc602b+pT/qgpJuBX6A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf9b1ann0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:02:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93917f4ccb4so52328685a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476568; x=1789081368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6SAf4dHCuT8D66OHUrhik51h6jS4FJ804YHBw3oOzF4=;
 b=W04tbA92JJ7K7279Hd5/w7ampFqoB7xN1AmGzqTIXVokdIa6HMI8ilEsvAdiTgZQIi
 aDNf4EDvLGd2nMMJc/BiJW8C9k0K9ktIhOanBwaDrGf9jr17J3zQCkZ6BLW1KzUR5Qp9
 hjG38gAdUuv85SygSPWizbvyEy5gkOskC0VpQ32aPOZcyCb1i4cdzod+0qOV5wfJaT+D
 5IkEVz+rHl+o3pd2Gq3S+mLrJ2U1oCc26tMChNiz+Mg5m8NUPsrFyrg4IaWFhm8QBO0d
 tS9h4IAsXqmmsbx192z6C3f0JMrhuDM3ha0xeXelcCybEvg0Gkxo92dzTm1ue02olas9
 PDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476568; x=1789081368;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6SAf4dHCuT8D66OHUrhik51h6jS4FJ804YHBw3oOzF4=;
 b=cGRfnr2457oVgTrXlynNePZAPfsPc9YkpkQy7OPqWMGyXiUoBVDwCqPEpDlb+K6VV/
 PIzhEuMloTywRds/bJxoQ6BkihIyVEIziYqCfql0ZaOisNb+LT8Fkit8IWBmXjtgwj50
 qHDFCFXHIkdoMubKb+mVBV8ctAA42WOLn4dCGP57tFHxZrTfU818stQq0PvLkCUj3BVp
 o48U7MZN8vOaeGb3wHc1vlCGHL078t8LsNfcJw8lxZMpi394Bg5eItJqsaUlw9uktHp4
 QziYiukdeuyRuJM90KTNesK42gb5AVzn98T8VTeDkQBiGOt2Lb6WV4alhMxX3r6DFh5a
 lvcQ==
X-Gm-Message-State: AFuF++mm6XGKPWYYViQjlhD32IpCpBYIsFMipAKc2LhgdTaTXoDhMiXu
 WV/oVq8QKiSW2Vv68kwkT7zNglMkP0gV9Ngy8AXQI+w81QpgPRbrqwdTrg7oKmdCsImKNjy0Nan
 lFpOl9NxhlENWz/vJtH1HzvzBr8871fAJwq3maF+g/qzBtDMgU6ptN6nyUSE+B4q4aw==
X-Gm-Gg: AYBFou3yc3nGLzI6LueYHyMTeFa8AMiJRDwphe+Ba0Mkq5PLZKCDuKvX4VL9IfijyQ3
 eUYghsBV6uvYZ1NPnE20NNQbiBS1ljRndxn4qsPBJ4H5yaWzg/AXNBA2NwdCUr2MAOUwK/98dem
 UVkUD7Cs9dKOTd6G/GOZRXNUoA7MwM+2LnyuPNz8WeljtFmLCEUfI5fOYqV6hfzzeovYSbnbvpr
 zGD2lkaj7CYqvD48iPybDzNG3f4dJxbtaiykcYTQVDbzsc7PcsIkzy+Fg4AdZlAWP2OagzXnQ1v
 7xsIeheQyK91dGFme8CEO+EmBMz2uW6A7PefOU2PutzN1gC6DSVbS1tN2RGo7f5I/KUcvgw14An
 yVifJ+WpqqjihbX4YTOzVp1dY7vd+oppPzh5f1C7a
X-Received: by 2002:a05:620a:2903:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-939802f7939mr222197685a.5.1788476567692; 
 Thu, 03 Sep 2026 16:02:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2903:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-939802f7939mr222188585a.5.1788476567246; 
 Thu, 03 Sep 2026 16:02:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm18639085e9.6.2026.09.03.16.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 16:02:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 0/4] hw/hotplug: Constify HotplugHandler
Date: Fri,  4 Sep 2026 01:02:41 +0200
Message-ID: <20260903230245.65601-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9He1xWC0JAPfVZAy5eKprJshC3koZTXn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX1SITSqNagvJv
 KC4JbotW077oh4z+wDMScZjT7Anjy8JJHQTBhG8SozCfKMQvDSreQEan4/kl2qRMEMesv2VDYzf
 b57hYMpk9fkDOyp/adkdK9MV5X+FwSc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfXyMBmLbgOrOUZ
 f49E+x8zPQ568ptyqatyhZeafAEX6bE0NDZkpn9dPeaeI85hDLEPhc4QJyFxlP+fDq6Up8iyFP/
 pAELx0ilRyrVw+qGty6iADU5oWwk84mIJ6AnFF9q/guPZQTYRaHN9teDQjpComoJzsgMtWoVRCC
 H11p1bDhfz8MFOq71qiIXux9Z2VJHuc9VDEmaHSz98jH2l0S2PDQAxdkfodmbRo5ZyBi0APyU8i
 ufKhh0MqYw+GENgE91SUR8w/g9rOa5i9eLpITbLtvxomInsaQ34+Pufa2znBCR5r6cfYNydyMiu
 9qj+Ig54DBj2WFruEw6XbuxkMv71iAW1lXg9P4BE4FeoXt/XKrN6JKWEgYsZaCCAuFAtrzJZR21
 OQNqFfM45XawtXysLVWiUdG238y4ptbDCniCvfxmkZhWtG5VSFQuBVPT/bzzZtLAi+D3mqbV0dH
 rD9HckcCP+EI2OfVopg==
X-Authority-Analysis: v=2.4 cv=NNTlPU6g c=1 sm=1 tr=0 ts=6a99fc98 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FHqRjUsf3WdtFUB5aaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 9He1xWC0JAPfVZAy5eKprJshC3koZTXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030202
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

We want to mark QOM interfaces const. HotplugHandler is
the interface with most uses, so start the code churn with
it...

Philippe Mathieu-Daudé (4):
  hw/acpi: Make AcpiGedState const in build_ged_aml()
  hw/hotplug: Mark various HotplugHandlerClass variables as const
  hw/hotplug: Reduce some HotplugHandler variables scope
  hw/hotplug: Constify HotplugHandler

 hw/s390x/ccw-device.h                  |  2 +-
 include/hw/acpi/cpu.h                  |  4 +--
 include/hw/acpi/cpu_hotplug.h          |  2 +-
 include/hw/acpi/generic_event_device.h |  3 +-
 include/hw/acpi/ich9.h                 | 10 +++---
 include/hw/acpi/memory_hotplug.h       |  4 +--
 include/hw/acpi/pcihp.h                |  8 ++---
 include/hw/core/boards.h               |  4 +--
 include/hw/core/hotplug.h              | 13 +++----
 include/hw/core/qdev.h                 | 14 ++++----
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
 hw/acpi/generic_event_device.c         | 13 +++----
 hw/acpi/ich9.c                         | 10 +++---
 hw/acpi/memory_hotplug.c               |  7 ++--
 hw/acpi/nvdimm.c                       |  2 +-
 hw/acpi/pcihp.c                        | 11 +++---
 hw/acpi/piix4.c                        | 12 +++----
 hw/arm/virt.c                          | 23 ++++++------
 hw/char/virtio-serial-bus.c            |  2 +-
 hw/core/hotplug.c                      | 16 ++++-----
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
 hw/pci/shpc.c                          | 11 +++---
 hw/ppc/e500plat.c                      |  4 +--
 hw/ppc/spapr.c                         | 48 +++++++++++++-------------
 hw/ppc/spapr_nvdimm.c                  |  2 +-
 hw/ppc/spapr_pci.c                     | 12 +++----
 hw/remote/machine.c                    |  2 +-
 hw/riscv/virt.c                        |  6 ++--
 hw/s390x/css-bridge.c                  |  2 +-
 hw/s390x/s390-pci-bus.c                | 12 +++----
 hw/s390x/s390-virtio-ccw.c             | 16 ++++-----
 hw/s390x/virtio-ccw-md.c               | 10 +++---
 hw/s390x/virtio-ccw.c                  |  2 +-
 hw/scsi/virtio-scsi.c                  |  6 ++--
 hw/scsi/vmw_pvscsi.c                   |  4 +--
 hw/virtio/virtio-md-pci.c              | 10 +++---
 hw/xen/xen-bus.c                       |  2 +-
 stubs/hotplug-stubs.c                  |  6 ++--
 system/qdev-monitor.c                  |  4 +--
 63 files changed, 269 insertions(+), 262 deletions(-)

-- 
2.53.0


