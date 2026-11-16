Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618A606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NKV1naTE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CzkRZuBv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63L-0002RL-2o; Mon, 16 Nov 2026 18:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63C-0002IS-1S
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT638-0003FI-UZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:23:49 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfX36912931
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xnSmYq0ZGeG2fzffBb2maY
 ESDS67XphFdsVmtwpOn7Y=; b=NKV1naTEK6Z2aajyvrUFQWp1yGm4XZaO+OifkC
 WX4sd+wr09i1g5u7ZYdBKWjyQWqnXo0W8gywUgfCdj7sM67mS8XAPsM+0lULpiPJ
 nzjaGbhUV1uUIyOEdCVUSzRJcm/YYXtTFgd+W1JA8Zboz9q8Ie2wvt0Q/JP3NBWq
 +VKupZFrs7OynbWvoJzisEQh7520VDCxDLOm+3Wvgs4FUgfC7y2c+mzAIaa+VFy6
 vYThcLisUxMF63jnJuSyPx1wf7P9AaqiKWSAuhSy9JBr32oZ6azR/r0klerJtoQF
 4iliBofYqI31FBqI6LPSOwSt351Py48VKjRJWkXDa8RBI1jg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y2519-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:23:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so1739544241.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871418; x=1795476218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xnSmYq0ZGeG2fzffBb2maYESDS67XphFdsVmtwpOn7Y=;
 b=CzkRZuBvI7Ku7BT/8l2HI3RYFTEhAcGeLjGk0UbANbm4F1kURk1hHzMfhWDkao6ALH
 WSpy54PFlCBzi1qZnNX40s05PaKxq3CNe0bN8fHCuIvfo9n3YOZR929dWiL+5UzZ1OEh
 C6f2Ov6B4AFCBZpp3cjDcTBzxj2aMPIjSMOGBZyZnZIogYuG0dTlQP2Rs+WsgjfyfTf9
 u62S8E68phAFtMgdV743eJcRMectI1HAnyGGp3Bpox5kuqBNrxPfxUhV9rJrFwbITIrI
 w+GRL6XPnFdcIEzaZwVURaTqkKydos/zHyt1I9xCYwgeQ9Ldtb7nnRQ4NYAaKkddnsLH
 urXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871418; x=1795476218;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xnSmYq0ZGeG2fzffBb2maYESDS67XphFdsVmtwpOn7Y=;
 b=Od0/8d/M1V5K7WhT+GjnAjCkNOwGgCymEAXUvbQOfamknM2f6zMx5icA1HMzo+BD+5
 l8TISgJv0XJU1zGut8qWKREmLJSflZTAqD+ZjidMO6iL57duln5j/RFn+t+iOD+EBiqF
 UO+vr5ySNzpG2XglZrQA4gVCapWYXqCnagd3L8FSpWpUdcDO3aIGrg4Xrrs03Md6Lxlm
 5WM1U0fyqlS4f1rQL+z+tiNysheUevUkCDmC0Qqir6QSg/Gm0w8O1pO/9ZL/pNWMs70l
 4HdZdwY/KxZG0gbGZuUAIFemN2EWlhfZv3uX2d0c1Ns/DguQWnUQ1FbSMz/JVEpgG0sU
 Qsjg==
X-Gm-Message-State: APuU4Z+EQAoXfuo2E5o7CqIowEEfB5KvK+K0ZmX2aUtfO1rF9eo+kpiy
 cZAYwKIjDQI8HaWupEOLW5BZGMKaeBq5Z0CFBbdFE+1erXY6MnWp/lcAx9ov2PXKWPD4wwBWioE
 k5ThrklwetPS4gxZLUB7d/XUtHd85Khn76VQOwf2CDTMnVNPaQWzd8EhEr2uZZ9FMpA==
X-Gm-Gg: AYBFou2rtG71hzUuwd7FQjMdaq+JwHPU0WZQZr+56YiheajTDl9u2e9qHSjyTWo/Amd
 oQwg9FQKx8wkY/3eLNtmDVafTMGikPvg8dv+nsKSa2CabDKrJ62e1A9WrqFEKsZ5clCUlmMkl4N
 NItTerL2mv8p92XIBdCSvZMGPbU5iAHZbYop3UCAoJR36mzHbZHqimvZd1QvwS5bNp2JobG2ZTK
 jMiLrks+7ZNvoiV2Av3wj0eLdojZBlZGqNSzXU4gQvJv6qPaqjITlBXhSvkMPxOvJCe4b/kOCVS
 mQa8U0dSLxJLGSZaxBJ5pwd62+a+eGqdHiuOP3lOK368PtUhdr46URc0gMHAUkp2nukxs9mnsm2
 K4356S/K5pLLPggBZLD9V05iQRz2CEtJPEuclggqm0UrDIYUmJ/U5P/ws0ubCJeZVs1XxtX0er0
 OgiD0QGTZqZj2OEw==
X-Received: by 2002:a05:6102:6892:b0:7c0:4d52:8cc9 with SMTP id
 ada2fe7eead31-7d64d73ad39mr4936032137.14.1794871418505; 
 Mon, 16 Nov 2026 15:23:38 -0800 (PST)
X-Received: by 2002:a05:6102:6892:b0:7c0:4d52:8cc9 with SMTP id
 ada2fe7eead31-7d64d73ad39mr4936028137.14.1794871417992; 
 Mon, 16 Nov 2026 15:23:37 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56719391sm130777745e9.1.2026.11.16.15.23.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:23:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/22] Misc TCG & HW patches for 2026-11-17
Date: Tue, 17 Nov 2026 00:23:13 +0100
Message-ID: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x1ccAq6Z7N2oWZlThgnXQxCxfYbHqDf_
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb907b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=6bsbhMfY_r_KusYwTTEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: x1ccAq6Z7N2oWZlThgnXQxCxfYbHqDf_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX+uqmuxaXX4wx
 3hRRztHKrODzYl4TBEPhKNL7cp3vFwgzUkYFofi8r42XueF97n9rCV8TaPbKMXXMTRHVuJSNrx3
 FjqgoKejAvEaB47TtSRadY/S7kqY9go=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX3YPi7GVpfC2I
 vTm+UMGT2NuZSOXmPsBI385RvrYOaK8Nj99oLh8yXDk9KD5KQ6XIZkRJW+EESZk0eAkvqtf15ki
 TbnKgi2JOpgPtL60qpDNTxYhUVAZYo/fzCgWMdTtohmFdKMbOmCEKtM0hDWtMz2/44pDLyZdks+
 wy2kMkU6xq5/SDFY5KzcZWNdQhHf7y1d47szSzdltGCK6Kbv7hi7ZplOuJ1aQBj2HQtt9EYRD+W
 bHF7KsWO34iwuBhoVGSACpjLzDBasO2d90eLlXtKLppgamudLVQ1PbsQgP2ggv5H1arCjdeHkyi
 S15VuWOWTM8s8pGMipLZbPHl/ECAmpzJNCZB8ahKvQKYMe76DAsBgr8hAo2CEaNjNYthzFcYA30
 JTHbUgz9KHfmT45MIPvB1fsVhVrOhbV0xZw561ZvbCWChoSpl08ZVrlotO/MMBIUol/ozHM99fA
 jjQIlzFjBOip5276fcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 573577bff0138681ddd4ee2410c51bead7b53e74:

  Merge tag 'pull-target-arm-20261116' of https://gitlab.com/pm215/qemu into staging (2026-11-16 12:09:43 -0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20261117

for you to fetch changes up to 46baf870fa08abd39d4cfe918aa0f81a3281c7ea:

  hw/virtio/virtio-iommu: Fix IOVA address lookup (2026-11-17 00:20:11 +0100)

Ignoring usual spurious checkpatch errors.

----------------------------------------------------------------
Misc fixes for 11.2

- Build system (obsolete Kconfig, QGA, illumos, macOS pvg)
- Fix wrong constant encoding in the vector .vi immediate emitters on RISC-V TCG
- USB device fixes (CCID card, U2F, MTP)
- m25p80, virtio-iommu, Xen backends
----------------------------------------------------------------

Bin Guo (1):
  hw/usb/u2f: validate ring buffer indices on migration load

Brad Smith (1):
  qga: fix uname() return value check in guest-get-osinfo

Chao Liu (1):
  hw/block/m25p80: fix write enable latch after WRSR2

Eric Auger (1):
  hw/virtio/virtio-iommu: Fix IOVA address lookup

John Snow (3):
  build: remove vestigial CONFIG_SGA
  build: update CONFIG_PVPANIC
  hw/i386: move bios functions into x86-bios.c

Mohamed Mediouni (1):
  pvg: disable by default

Peng Fan (1):
  hw/xen: Mark legacy Xen backends as hotpluggable

Peter Maydell (1):
  hw/usb/ccid-card-emulated: Use QemuSemaphore rather than QemuCond

Philippe Mathieu-Daudé (7):
  tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
  tcg/riscv64: Use a uimm5 encoder for vector shift immediates
  tcg/riscv64: Extract elements for vector arithmetic immediates
  tcg/riscv64: Fix constant handling in vector comparisons and selects
  tcg/riscv64: Fix logical vector immediate matching and emission
  tests/tcg/aarch64: Add vector immediate regression tests
  hw/usb/u2f-emulated: Use QemuSemaphore rather than QemuCond

Roman Bogorodskiy (2):
  meson.build: fix getifaddrs() detection on illumos
  qga: fix build on illumos

Tommaso Califano (3):
  hw/usb/dev-mtp: Fix recursive delete of directories
  hw/usb/dev-mtp: Check length of class control request
  hw/usb/dev-mtp: Stop processing SendObjectInfo after an error

 configs/devices/i386-softmmu/default.mak |   6 +-
 meson.build                              |   2 +-
 tcg/riscv64/tcg-target-con-set.h         |   1 +
 tcg/riscv64/tcg-target-con-str.h         |   1 +
 hw/block/m25p80.c                        |   1 +
 hw/i386/x86-bios.c                       | 143 ++++++++++++++
 hw/i386/x86-common.c                     | 125 ------------
 hw/i386/x86.c                            |   1 -
 hw/usb/ccid-card-emulated.c              |  22 +--
 hw/usb/dev-mtp.c                         |  24 ++-
 hw/usb/u2f-emulated.c                    |  19 +-
 hw/usb/u2f.c                             |  31 +++
 hw/virtio/virtio-iommu.c                 |   2 +-
 hw/xen/xen-legacy-backend.c              |   7 +
 qga/commands-posix.c                     |   8 +-
 tests/tcg/aarch64/sve-vec-imm.c          | 233 +++++++++++++++++++++++
 tcg/riscv64/tcg-target.c.inc             | 116 ++++++++---
 hw/i386/meson.build                      |   1 +
 meson_options.txt                        |   2 +-
 tests/qtest/meson.build                  |   2 +-
 tests/tcg/aarch64/meson.build            |   1 +
 21 files changed, 555 insertions(+), 193 deletions(-)
 create mode 100644 hw/i386/x86-bios.c
 create mode 100644 tests/tcg/aarch64/sve-vec-imm.c

-- 
2.55.0


