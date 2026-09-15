Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92DC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HLP-0004Hj-7i; Mon, 14 Sep 2026 20:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLL-0004Gk-DG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLI-00049E-Kg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN06CA689539
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4PsagQ6GSzaq/5tWJYSNHt
 KJwnKSfbyFP4Q3QyAZrmQ=; b=f+MqeMRonMHZqdH3qsAnB/D6Oy3uGhvXOUYbFH
 wYQZq4oeuE13bLKoOMFs0Vy2hmkuR2HqKkJyKTylwEBpCjsNVSTvW+affARUZhha
 tCdocj7J5yIkIuJsvU7VI8lZb1D18hzSZgLVtI0ZRtvjHXoFrgQFeiCYZzY3BMtW
 VZN+Kyjdcd/6Finb3Gr/xpZj85NKORGXMqz7Xbkcp7bu1puvAQlxBYgpk8sc1Rvl
 2jQoCUqZ0+8S/FjgvFqIoHUDop0UbEYuJW8fH7/EPYuaHePt+b9yQcBpyJz8dhHM
 gdYh9Ca+pwVK+Ox9bAnpIVYcQ7t+QbznqKD2dda8RdPKGD4w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergb76e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-868f443cbd0so3235563b3a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433289; x=1790038089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4PsagQ6GSzaq/5tWJYSNHtKJwnKSfbyFP4Q3QyAZrmQ=;
 b=j/Tx5r3Po/ljgX6hzb+BpDoKZ8TYEHEjjSC7cHRnW7EKLl/ASqt4yLWY2dxdlQuQuM
 YnWSr7/xTOxn6K5e44t/YB57VfYsz1rFMB5m+66agaIiIntCkHRWO7WfHYNNlJ5Jlcv2
 E6Tdu35HpEVJitjNFZ3qvMne/RzhyIhm5gsaJLZhypVzbgwd+AlxUkBandIFyYBxTSx8
 kVcI/UxhzWn9/ReY/QFLjzc+cbASaCFhuj1bwSzk2XreuF56DzffxE6VR4V91YW5ySfS
 qbvSconuHP2rs8z3gbI6XNamMfapHte35bmY8fE3w2MEEAm8/7TR334leysbmfLVxv9G
 3OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433289; x=1790038089;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4PsagQ6GSzaq/5tWJYSNHtKJwnKSfbyFP4Q3QyAZrmQ=;
 b=ivrV91WXOJXsjEtyffYfP/qu1jz5I0eKmJa9zyehwViuk2Pygvi/DUfJfVWgjh9CSb
 i1TDvyfZx9oM5qebMpHVH35O0Ve7DeYBbAiDybrZ3iCLt+4hjIRpgXiXzerXmSlO634l
 HCCa0swiuQg4aY54drt0cDQU7LPmAWZAiAFJPtxKE+RxQHaAGB/lxoX9JdNWJI8GV8t6
 KVolxqjDSBKdCTc4XOBAm7hXxVxujx8W5wRSeZbiK08Z85dIQAlsPGD+0QizNiIeW4VA
 t7uxWatKl2QjVo0r8VaUsDKxCRIqcB7YyiHdZGL2NfV3nYanQd1SwJKy5tayyRiqBSLv
 lxHA==
X-Gm-Message-State: AFuF++lpj0m2Nexg1Kg30A5sIDlWVGSB+Nd6wLMpw1X5NdaD1wFYpO/I
 G98Uyfe6+P4rynmHms2GJGL6ftEexnp0vMSTdjY/Yj7lzWPQinbVIEqB4efB6Qumfqjep0FM5L6
 1qSoXBTxXUsRjgCmoBPSxr3M2kfjBm3F+3Z7v32nJtS1rBCDwvma6m8X4M666v0RZpw==
X-Gm-Gg: AYBFou2OsBAEfyimiYMujsXREUF8qJCYvwrT2aqJLx7xuoHbrynoNmtJsq1ldBcwAuo
 5WeYvte1yk+g0vFMQAr4n3EQELb0yn3lLfyBcMOuqtZ7UaDKLi6E9F3amxFS0FsKs/lm7AClyvG
 kzYSI7zcPAF8XaorMOD4AMPyRwQm6O+caMdj8KSqxiQEzQbF6ecQhPxJn8t/c1T4OmfNeRTFfsr
 CKJLth9fpK6VIPrUWwXd5qKUEsxO5BK+Hq088gsxI9GZyYELmAqlRetKppEEsyInA5lhO3oaGr4
 +XNMaronbXB3VbmVODS7OkEp/umcPJdII5Fb3y8YOHrf3ahAqnD633ZL8c+BiT8xr+yVNLitstr
 lhedtETnBilxZTBT7JlfjIGn0g0DryN1StNHFW9wDKdlXrP9vq//FNIkUt5w=
X-Received: by 2002:a05:6a20:43ac:b0:3d1:39e9:b267 with SMTP id
 adf61e73a8af0-3db4037cd96mr11398978637.3.1789433289032; 
 Mon, 14 Sep 2026 17:48:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:43ac:b0:3d1:39e9:b267 with SMTP id
 adf61e73a8af0-3db4037cd96mr11398900637.3.1789433288552; 
 Mon, 14 Sep 2026 17:48:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:08 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/6] roms: fix compilation for {vof, optionrom,
 s390-ccw} blobs
Date: Tue, 15 Sep 2026 00:47:56 +0000
Message-ID: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa895c9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6z3NnJHWl-8rbS-XDkMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: UU6AweJiMuERz7G79ldCIZzdF1KNXMia
X-Proofpoint-ORIG-GUID: UU6AweJiMuERz7G79ldCIZzdF1KNXMia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX44w9GCyi4unX
 qNTlwyYQz++kJ0GfvD32JpLh83GTFTzhP/NU7lt02BjZM+l06YZuqolJbd7VGN7RRZJ5KWnr1TP
 9w68ox83xUsho+m6EPLXF3y2E7fCOUV17J9l0DRN/hBFsACNbh/MnAies+zCqkflRGhAJJlmpgn
 3/gHeLF+PV6BG9khEFgm+ln979o5XsB8xl0CNHF4N7p4yo3ExkZS1NPlDssJCh8uQpAiWhl3pHc
 uibYYEgpTB/FR07py4DWCl+vXq3gGUC1SUN/GdM/wJig9hXmLG/6LcpKcXMCsXz/WPOKmYhxl24
 aS/D3gEELTCH7lRNrAXqAT0yaamqGWvVG+GEqprOW5ZlBal6i82oeXpGXWdRAnD6lWwBkDgKr1V
 eBCKPiOajpYbuqe7Wdxcfefzps7tUCPsjyUnU2l/a4a2ccSSVmuWL4+bZIQdd+F7pl4bfm9eQMp
 2dLmQm0rTTHfmhbR7LA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfXy3eIK4qBXGHa
 WUN5wGYAf1Yqu4XhJKWVuGNOFzbriQvoeMiOuZV2loShYhzWMogGF8NxfUBLmaQM1R1nHSHxC3s
 fG3GUVASEY71BWmFpit1Z7jFC505mxI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Reply-to:  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From:  Pierrick Bouvier via qemu development <qemu-devel@nongnu.org>
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

v2
--

- Add changes for moved files in MAINTAINERS accordingly

Pierrick Bouvier (6):
  roms: move vof from pc-bios
  roms/Makefile: add vofrom
  roms: move optionrom from pc-bios
  roms/Makefile: add optionrom-bin
  roms: move s390-ccw from pc-bios
  roms/Makefile: add s390-ccw-rom

 MAINTAINERS                                 |  4 +-
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
 61 files changed, 136 insertions(+), 147 deletions(-)
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


