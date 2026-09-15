Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDAAC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H19-00061v-Nd; Mon, 14 Sep 2026 20:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H15-00060g-5D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H13-0000xL-4z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxtra2336077
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7OTPk8d7M16USf0rJUkd+c
 bRAApOKxjP+/YyBOODUoE=; b=RMjjQoFkjLkozP1m5NBupb07sHSv5LS+a6z2Dg
 U0qpn2et9+xJhB5RtDDl2MvJFZJBz/PZFC3BBs6UUR0rTVTvmWf4oJtucZOscKuE
 N+Y/bbGSnCTWNBLRUoHpmIRgjLKfCb44i5+QXyxqDTubiPAV8VZS6NLLmFk8/OGY
 jOXhUkMWj7H/RMfDKuVw931STARlLwIN55WSTRgxFVDvVJo3axRK1UZ9SaVHjtIX
 o7wKfO4XTGQPNx042WFY+29EzEJ/z3LhfvLJveQJvQSw8tFFo2Bz4/oXHkNYTi4i
 4rioEE+ppkGwL0t615IprAMxly7JSU6j4DoqpviKUFgqqaCg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5ukmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so2556389a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432034; x=1790036834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7OTPk8d7M16USf0rJUkd+cbRAApOKxjP+/YyBOODUoE=;
 b=YcxoUdqEgz/WFvwKQlccLylGFD1nrWuyq8TQ/nns/pMaiZ1yIhYN8zCKKSWEZ4MkRQ
 MrexlE4DvoiZBI+W1sHLOoiRanPGtWwMeBDlTPaci857CoSE6HhFBIl5k+R8hG6+y66w
 SPi3WpzW5TOX81YqgMlWGghwabx4t3md3OucLNhpFwQohec1ygY5Lg2FDpqwIwNVm/xh
 mzQlgdJZIaH9AwWE1YkAVgkb6T/0BkAHGn4mkxKtqTuoBQDtRus6kcki18BFaIgukv4s
 zAgxralynCTl/coivcFnReRmgNZ5jONI21KF1ki/bZogEailGXEP1oxK2OEjzvy66Sg+
 1y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432034; x=1790036834;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7OTPk8d7M16USf0rJUkd+cbRAApOKxjP+/YyBOODUoE=;
 b=EHdWzEj1XcxcfUiQttx9+5e611BmEed7RM7kOx8UOEbtprT4bg2dZU3nV+pHDsBzR1
 VauIsBc6laXTEWrl359zzeBvrzyT9tbV/CtMCmt20MWZbB2KF6D5WJo+3Okmf4TIcPeO
 bOqT/w4vgzZ0jF8wK+zkAuGVkfiX1ZwKC4DLaispDNKlRfMq0uVYQbBW/FZmLCMMGfL+
 pIFQLEL/9aVszljvO410nTPzHl59hldhVauvGrFdsVMPM0mHqcIPo6ILs+2ImYO12gx8
 oRGu3S49dMNS6l0gVaejr1+l53IjJ4bop4FlPARf0MqaqPh23h84QIBNr8YBamVjRixu
 k13A==
X-Gm-Message-State: AFuF++mohywOxEdTsOt2/QnTx4bGqpqA/6C44ogwkgW7MRCRcA9XIf+g
 +fxuxNolYZmtiDFgQH/dchW4lMOxiNh5ectTf6WJ3PYGhKXE4JxMfRet119tIrDUwA9FHdCamO6
 eTm4BVlvndZicAuSJjAlz9cjDqV2B0OvlY0xuvbW5rAy4BTcJUgvflOx2m2Xerw+M1Q==
X-Gm-Gg: AYBFou26FnOwYfhQ54AIFeSxQD9l0/LHqqmd6s3eJNO9HYRqmYaCqAsF8p7hLMGtD/q
 NfsjZPSfX4tX+JeqTd3HIFO9UBHySawHvsI7obQ4rSntwOVEo15Rota83vf3NDxFAhkWeXh7s0a
 HrOQW/QUvE5Al+K7aL1an4e3iQuoHMdYeo3ld0YHufjsL21eyK73PU5oq+Ta1vtlD4IxDs4JQjj
 GOppIX1qeWdLTUPSTnL+o2hyy460ftnqSnbK+FVPGAjMYh3L+ivxeN7lE8WwZzUXZUaL8tI/oXt
 eIfEnRATdac9URR+rcpKWzitXGNGtwnjq0+Qbu9wstUjY0CD9BkEANvOYO5UcWGPja3RwCzLjzR
 rSETwmoJ70rsllCunTxcv6S8ihzjBacq8ErGDglqRwjdFyhHdBxCjDoTT38w=
X-Received: by 2002:a05:6a20:1609:b0:3d3:afd9:6040 with SMTP id
 adf61e73a8af0-3db40746ea8mr11098883637.27.1789432034401; 
 Mon, 14 Sep 2026 17:27:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:1609:b0:3d3:afd9:6040 with SMTP id
 adf61e73a8af0-3db40746ea8mr11098818637.27.1789432033936; 
 Mon, 14 Sep 2026 17:27:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/6] roms: fix compilation for {vof,optionrom,s390-ccw} blobs
Date: Tue, 15 Sep 2026 00:27:00 +0000
Message-ID: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX8A/7ywSF5LF8
 LUfahK0E6mP64D2Do8OliMiYtoBKrOvzuM/T7lQ0T/B+VMi83seLduEXvqiojRiuISMVK3KLtSz
 xTGv/vaqVW8C7bBFAic78UKkxmoyy/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX4qRV+PTjKUme
 1eu5ZVSFWSKe3V/wCvN5mEoW1jkMemgl0t2+jwpLhSf2hin+gwTi9KUBJJDMPGWc3I+cAdcuUyD
 SAZ7C6vAPoxOkECNrUnUZAMvsLAWOTbMi/5Rc8/W7ZMoQy89RG4+mI4AxXUXMRgAjInCKesfF3U
 z4CQP9fpGTzCWB7j5+nYhcGKRRV6mtZ/pMhl2QTB3cZgoONQGSCltM++bGhYHAzdbKjExh0UeZ0
 iJGcRvn1S9eGVJqxP5Johbt3SkT0+zCU3VslS7a/eob5njEe7qq0KLQKva5ePtM3pjccw/IdYXc
 tNkUI1+e6y3Y7QqoS/KD3ZQANtQiXrVHI4lqPZ397rWNkjuKadICKDuOWbkwhhBbAiG0spOU9ib
 m/hk8W0B+1QxvVX+1TpOCnnG2BA9zTpxg34OwZlDW9KTz80NJ1bddWEdf5kEjWphuJRhP84dOpM
 EVgqKzzFdJu1nfWpLIQ==
X-Proofpoint-GUID: KwvSQHrD1VtJ5ipra0Oymy4AeFfnXV29
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa890e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6z3NnJHWl-8rbS-XDkMA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: KwvSQHrD1VtJ5ipra0Oymy4AeFfnXV29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150004
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Recent switch to tcg-tests removed a part of configure that was generating
config .mak files, that were reused in other places of the tree:
- linux-user vdso
- pc-bios

Taking a look closer, our roms sources are supposed to be in roms folder, and
there is a standalone Makefile to build associated blobs.
This series moves the remaining sources from pc-bios to roms, and adapt their
Makefile to work without depending of config.mak.
vdso build will be fixed in another series.

Pierrick Bouvier (6):
  roms: move vof from pc-bios
  roms/Makefile: add vofrom
  roms: move optionrom from pc-bios
  roms/Makefile: add optionrom-bin
  roms: move s390-ccw from pc-bios
  roms/Makefile: add s390-ccw-rom

 pc-bios/optionrom/Makefile                  | 69 ---------------------
 pc-bios/vof/Makefile                        | 31 ---------
 roms/Makefile                               | 22 +++++++
 roms/optionrom/Makefile                     | 56 +++++++++++++++++
 {pc-bios => roms}/optionrom/flat.lds        |  0
 {pc-bios => roms}/optionrom/kvmvapic.S      |  0
 {pc-bios => roms}/optionrom/linuxboot_dma.c |  0
 {pc-bios => roms}/optionrom/multiboot_dma.S |  0
 {pc-bios => roms}/optionrom/optionrom.h     |  0
 {pc-bios => roms}/optionrom/optrom.h        |  0
 {pc-bios => roms}/optionrom/optrom_fw_cfg.h |  0
 {pc-bios => roms}/optionrom/pvh.S           |  0
 {pc-bios => roms}/optionrom/pvh_main.c      |  0
 {pc-bios => roms}/s390-ccw/Makefile         | 67 ++++++++------------
 {pc-bios => roms}/s390-ccw/bootmap.c        |  0
 {pc-bios => roms}/s390-ccw/bootmap.h        |  0
 {pc-bios => roms}/s390-ccw/bswap.h          |  0
 {pc-bios => roms}/s390-ccw/cio.c            |  0
 {pc-bios => roms}/s390-ccw/cio.h            |  0
 {pc-bios => roms}/s390-ccw/clp.c            |  0
 {pc-bios => roms}/s390-ccw/clp.h            |  0
 {pc-bios => roms}/s390-ccw/dasd-ipl.c       |  0
 {pc-bios => roms}/s390-ccw/dasd-ipl.h       |  0
 {pc-bios => roms}/s390-ccw/helper.h         |  0
 {pc-bios => roms}/s390-ccw/iplb.h           |  0
 {pc-bios => roms}/s390-ccw/jump2ipl.c       |  0
 {pc-bios => roms}/s390-ccw/main.c           |  0
 {pc-bios => roms}/s390-ccw/menu.c           |  0
 {pc-bios => roms}/s390-ccw/netmain.c        |  0
 {pc-bios => roms}/s390-ccw/pci.c            |  0
 {pc-bios => roms}/s390-ccw/pci.h            |  0
 {pc-bios => roms}/s390-ccw/s390-arch.h      |  0
 {pc-bios => roms}/s390-ccw/s390-ccw.h       |  0
 {pc-bios => roms}/s390-ccw/s390-time.h      |  0
 {pc-bios => roms}/s390-ccw/sclp.c           |  0
 {pc-bios => roms}/s390-ccw/sclp.h           |  0
 {pc-bios => roms}/s390-ccw/scsi.h           |  0
 {pc-bios => roms}/s390-ccw/secure-ipl.c     |  0
 {pc-bios => roms}/s390-ccw/secure-ipl.h     |  0
 {pc-bios => roms}/s390-ccw/start.S          |  0
 {pc-bios => roms}/s390-ccw/virtio-blkdev.c  |  0
 {pc-bios => roms}/s390-ccw/virtio-ccw.c     |  0
 {pc-bios => roms}/s390-ccw/virtio-ccw.h     |  0
 {pc-bios => roms}/s390-ccw/virtio-net.c     |  0
 {pc-bios => roms}/s390-ccw/virtio-pci.c     |  0
 {pc-bios => roms}/s390-ccw/virtio-pci.h     |  0
 {pc-bios => roms}/s390-ccw/virtio-scsi.c    |  0
 {pc-bios => roms}/s390-ccw/virtio-scsi.h    |  0
 {pc-bios => roms}/s390-ccw/virtio.c         |  0
 {pc-bios => roms}/s390-ccw/virtio.h         |  0
 roms/vof/Makefile                           | 26 ++++++++
 {pc-bios => roms}/vof/bootmem.c             |  0
 {pc-bios => roms}/vof/ci.c                  |  0
 {pc-bios => roms}/vof/entry.S               |  0
 {pc-bios => roms}/vof/libc.c                |  0
 {pc-bios => roms}/vof/main.c                |  0
 {pc-bios => roms}/vof/vof.h                 |  0
 {pc-bios => roms}/vof/vof.lds               |  0
 tests/tcg/s390x/console.c                   |  4 +-
 tests/tcg/s390x/head64.S                    |  4 +-
 60 files changed, 134 insertions(+), 145 deletions(-)
 delete mode 100644 pc-bios/optionrom/Makefile
 delete mode 100644 pc-bios/vof/Makefile
 create mode 100644 roms/optionrom/Makefile
 rename {pc-bios => roms}/optionrom/flat.lds (100%)
 rename {pc-bios => roms}/optionrom/kvmvapic.S (100%)
 rename {pc-bios => roms}/optionrom/linuxboot_dma.c (100%)
 rename {pc-bios => roms}/optionrom/multiboot_dma.S (100%)
 rename {pc-bios => roms}/optionrom/optionrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom.h (100%)
 rename {pc-bios => roms}/optionrom/optrom_fw_cfg.h (100%)
 rename {pc-bios => roms}/optionrom/pvh.S (100%)
 rename {pc-bios => roms}/optionrom/pvh_main.c (100%)
 rename {pc-bios => roms}/s390-ccw/Makefile (59%)
 rename {pc-bios => roms}/s390-ccw/bootmap.c (100%)
 rename {pc-bios => roms}/s390-ccw/bootmap.h (100%)
 rename {pc-bios => roms}/s390-ccw/bswap.h (100%)
 rename {pc-bios => roms}/s390-ccw/cio.c (100%)
 rename {pc-bios => roms}/s390-ccw/cio.h (100%)
 rename {pc-bios => roms}/s390-ccw/clp.c (100%)
 rename {pc-bios => roms}/s390-ccw/clp.h (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/dasd-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/helper.h (100%)
 rename {pc-bios => roms}/s390-ccw/iplb.h (100%)
 rename {pc-bios => roms}/s390-ccw/jump2ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/main.c (100%)
 rename {pc-bios => roms}/s390-ccw/menu.c (100%)
 rename {pc-bios => roms}/s390-ccw/netmain.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-arch.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/s390-time.h (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.c (100%)
 rename {pc-bios => roms}/s390-ccw/sclp.h (100%)
 rename {pc-bios => roms}/s390-ccw/scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.c (100%)
 rename {pc-bios => roms}/s390-ccw/secure-ipl.h (100%)
 rename {pc-bios => roms}/s390-ccw/start.S (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-blkdev.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-ccw.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-net.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-pci.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio-scsi.h (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.c (100%)
 rename {pc-bios => roms}/s390-ccw/virtio.h (100%)
 create mode 100644 roms/vof/Makefile
 rename {pc-bios => roms}/vof/bootmem.c (100%)
 rename {pc-bios => roms}/vof/ci.c (100%)
 rename {pc-bios => roms}/vof/entry.S (100%)
 rename {pc-bios => roms}/vof/libc.c (100%)
 rename {pc-bios => roms}/vof/main.c (100%)
 rename {pc-bios => roms}/vof/vof.h (100%)
 rename {pc-bios => roms}/vof/vof.lds (100%)

-- 
2.43.0


