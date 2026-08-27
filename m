Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532E1C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYL-0005Dm-Vb; Thu, 27 Aug 2026 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYE-0005BL-HK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYB-000191-4I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLlWU218241
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=H9ZC+A1WzsF43avK7KUE91
 59B+Vo4VcjNzwETS0M68c=; b=A5+kJ748dXe51UbYbwdsYRY/Ad/rhd2SN8cSTz
 YYUdF97unC7R3jyt8C+0yq+2TGnr22OVwPXfB7k4b85MiW4Kb2uF8aRkEeZ7A5aj
 Y2TV2F0Bp3Qs94NccEr0S9wsYlNbyE67yzWiJMJa8GHC/QCPNez/FMg4Ey2bSrOb
 TBwnievMqSIn9gUDtl/0c/qnuTEhPT+PVfXq4ekBei4/3kqx+CG2EvW7F7fmYbE4
 DAFOS1WtoiHQ6RgTTPmrGJAjUB198UNrvUXUZyiV9763rM4yGT9Cgm6zGmKu1hnx
 RgQQXgzZ+ww/rrxw9u7aBP4o41WMgeQCzmt0ju/Ah+eWxKuw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw239r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936708f129aso42563285a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869580; x=1788474380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H9ZC+A1WzsF43avK7KUE9159B+Vo4VcjNzwETS0M68c=;
 b=Pff4AJroHJuxqTNAXJVSCB/xq+rXH/2erq4RnZYa0+zqZzbOKxrOzNYEx8ypJwEsxK
 9bI6z01L3FN4mppXdnu+YZ7Je046ds9dsZM0uEfg1oq6PmiGJTClrSzAzTyBE3f4GlL+
 +vNIjsVHWBYCFfHJTh59IHyqQ+EZWh6V1Vf5F52lod4ht/WtKjpRmsdrJuxgA/5piXwH
 r+TQZ/KJSCoWUwAYKryd6gqHsO1m+vnhxHvan6lmRAfIIgBZL1DLY+4J5hCEDc+SgLrN
 9PsO4VbK0ce9LjJJPXxhHB0piS+aL4K647A+Z4lmGNcXVhRwaurON942mK5+uiwjJfih
 JmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869580; x=1788474380;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H9ZC+A1WzsF43avK7KUE9159B+Vo4VcjNzwETS0M68c=;
 b=G5aQThptT/g8QJ1s6W57G/IcvLaAfVgBvjd00fa/hYkYZCBDjpVnVAC89c7ThNm3OW
 /bRBFotVbzCTY8SMYQQqGFJbBdmXQnIoiPswq5N48K5vYyY4/HUWvL6x/iCwi6+aX97Y
 oCx+5ZIGJfkr5omQgxMa1t1e6MS9mFGDVQ1e5HtCr67zPWZnrXpwz2jqmVuJBQ2zreRz
 8KYCR3GKJTAsE/SAu48HxojdmzFemo9gIDxj2WLoWCRqS5xFI9zUK+465SePsTsNADEJ
 +xucnVmI2M1x09SVARJpyQLhh76yuo/m2va9CGfpsz6c7B4ncT3D6leuJbYYwrXqUzLP
 bDxA==
X-Gm-Message-State: AFuF++mPw3nqP7MkUo3/4/M3An4/fhtI25x0ltB8zS7++SBm0aNQmOju
 2TX7qaOQzslOFApM+QoMk9XVeomVAXDNFzc6gBbnfvSN8UgTMpFJPmVUbBxZgB8on7an5K2bSUL
 u+ykP7JzG7yLNbDL32r0kATk/i7JqvQBji/HDh5IsxEQTducbzqxSyLy71F+5XSK4Dw==
X-Gm-Gg: AR+sD13A3z0HE6KoDOmr7z858t+C24KosLbDZj27nRKfR8Kkbw3K1yx/Xraa3DXNT0e
 SwcdFIk7C/152F6adHX8wvaRD5wgXMj+P/iA8iIEB6kdIgktGeGonHbZKOaKs6C9nNsbDPlAxqK
 1ZGiJy+BV8t886eo/k4zj7dZi2WF+oRdrhPh9EJ87BJp4TpZOrCrnlYnrMMumyEDGR6XoX6ZAhz
 xL9DpsJFjcSGydDC28u2bPhCeRnLu/h+4JaEWOsijB4o3PTGgIvLZVClZV0S7BeoHyLYJGSNj73
 AorgE3ER9LoJamD8vIrY/xPFbyYtA5jbtUD+EyY5siVVwRWhSM3F6WGD8u6hVdtLgI+lWonCxuC
 g19en7+RXWS4Rfr3dZbcMcy+rsIFxtcE0jJMkgg==
X-Received: by 2002:a05:620a:4056:b0:915:c4de:7ac0 with SMTP id
 af79cd13be357-939139550a7mr258338585a.31.1787869580100; 
 Thu, 27 Aug 2026 15:26:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4056:b0:915:c4de:7ac0 with SMTP id
 af79cd13be357-939139550a7mr258334485a.31.1787869579681; 
 Thu, 27 Aug 2026 15:26:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org (open list:Trivial patches)
Subject: [PATCH v4 00/14] hw/riscv: trivial code dup work (riscv-server-ref
 prep)
Date: Thu, 27 Aug 2026 19:25:53 -0300
Message-ID: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OJkl_aLHeA0TA87-zIPIpMxDNKYmWC_J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX1+eMBCHAu2gs
 jSMMtQxiRdTLtMbrYtgs3JCsEb222Rz3BelFk1pwE9PtuNErVGL0HUcyd0IECn3tYmEOs+ERHvy
 R0ZAsEBIbE3XSO+54sBm1MI2fEfUwbE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX971n6XWhWfaI
 VOq1c+TIG4E8zqCJNA1KVCKxHh4CAGbQsLkHNBSSchSOK0dLriKukeVcfla90/CI24/f4xXURaP
 3KgymfxKmIsTWVUMkI6zeCpO1ZbOtuz+1fAjHqqfaf6JMBNar6btcPXWgKgtXoACYM7UArcosqU
 bC2Q5zlE6aLUmbuX99hkhzZ4JsBuPC0X64noD2mcuCmSIOBbBABssCoBShf972jZPh5gl1PuYA+
 BLSTi7F5+Ol1y2iCN+VCM9SdH2Uh6HHkIFYBC1vBdkiMVNgl9ZnhH5RXadYr+7ilsd4qc0D8dkI
 7gTrhq8mxl/YjjYTpja+ehPjFWR2wDM0zf7WMZN1iNkFi775uxlBzy71BnhYbg4IfIEBUjTC4BB
 uL/uigJpSPlHYuqGv04aKQ+gmeLID/3FTVzFhDnj3w1SMdinXvtGoG3i+HhnY6/uQnXWPW84Cdo
 ECPgif/t8Yk9uuKGTfw==
X-Proofpoint-ORIG-GUID: OJkl_aLHeA0TA87-zIPIpMxDNKYmWC_J
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b98c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GV9jUkj38Kx6g6Zk9FYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

In this version the most notable change is in patch 9, where we left the
tt-atlantis out of the changes being done.  The reason is that the board
will have UART related changes soon, and the UART FDT will be most
likely impacted, thus it's better to wait for the DT to stabilize first.

Other change done is the "local phandle" handling.  For all helpers that
receives a 'next_phandle' pointer we'll check if the pointer is valid
and use its val as next phandle.  Otherwise we'll use
qemu_fdt_alloc_phandle().

Other minor changes were also done following the discussions in v3.

Patches based on alistair/riscv-to-apply.next.

Changes from v3:
- patch 3:
  - renamed 'phandle' to 'next_phandle'.  If non-null the helper will
    use (*next_phandle) as the phandle value for the new subnode.
    Otherwise the helper will retrieve a phandle via qemu_fdt_alloc_phandle().
- patch 4:
  - added a new 'next_phandle' optional pointer.  If non-null the helper
    will use (*next_phandle) as the phandle value for the new subnode.
    Otherwise the helper will retrieve a phandle via qemu_fdt_alloc_phandle();
  - removed the iommu_irq_map array;
  - instead of returning 'void' return the DT iommu phandle.
- patch 6:
  - renamed 'phandle' to 'next_phandle'.  If non-null the helper will
    use (*next_phandle) as the phandle value for the new subnode.
    Otherwise the helper will retrieve a phandle via qemu_fdt_alloc_phandle().
- patch 7:
  - renamed 'phandle' to 'next_phandle'.  If non-null the helper will
    use (*next_phandle) as the phandle value for the new subnode.
    Otherwise the helper will retrieve a phandle via qemu_fdt_alloc_phandle().
- patch 9:
  - removed all tt-atlantis.c changes;
  - renamed irq_mmio_phandle to irq_phandle;
  - removed both bool flags;
  - "/chosen" and "/alias" are now set manually by the board;
  - a new riscv_fdt_get_uart_nodename() helper were added;
  - added an UART_STD_CLOCK_FREQ to hide the magic 3.6864 MHz hardcoded
    clock value.
- patch 10:
  - renamed irq_mmio_phandle to irq_phandle.
- v3 link: https://lore.kernel.org/qemu-devel/20260826214643.122728-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (14):
  hw/riscv/fdt-common: prepend helpers with "riscv_"
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_flash()
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_syscon()
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_riscv_iommu_sys()
  hw/riscv/fdt_common, virt.c: add riscv_create_fdt_pcie()
  hw/riscv/fdt_common, virt.c: add riscv_create_fdt_imsic()
  hw/riscv/fdt_common, virt.c: add riscv_create_fdt_socket_aplic()
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_uart()
  hw/riscv/fdt-common, virt.c: add riscv_create_fdt_rtc()
  hw/riscv/device-common, virt.c: add riscv_create_platform_bus()
  hw/riscv/device-common, virt.c: add flash helpers
  hw/riscv/device-common, virt.c: add riscv_gpex_pcie_init()
  hw/riscv/riscv-iommu-sys.c, virt.c: add riscv_create_iommu_sys()

 hw/riscv/device-common.c         | 168 ++++++
 hw/riscv/fdt-common.c            | 612 +++++++++++++++++++++-
 hw/riscv/meson.build             |   1 +
 hw/riscv/riscv-iommu-sys.c       |  25 +
 hw/riscv/riscv-iommu.h           |   3 +
 hw/riscv/sifive_u.c              |  34 +-
 hw/riscv/spike.c                 |  30 +-
 hw/riscv/tt_atlantis.c           |  22 +-
 hw/riscv/virt.c                  | 861 +++++--------------------------
 include/hw/riscv/device-common.h |  32 ++
 include/hw/riscv/fdt-common.h    | 146 +++++-
 include/hw/riscv/virt.h          |  15 -
 12 files changed, 1111 insertions(+), 838 deletions(-)
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 include/hw/riscv/device-common.h

-- 
2.43.0


