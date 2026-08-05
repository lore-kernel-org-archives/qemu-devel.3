Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08BFC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJK-00007b-NE; Wed, 05 Aug 2026 14:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIs-0008VB-BW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIo-0007dc-5n
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HRu9t3672908
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wuZ5E0ETAoDgelM+YBdVSGUtVXsjyTP1Uhq
 zzw6j8zA=; b=F6cTmfbsAbaJkufaHuobV9STus6r0IhChyVoDCSJmrrjLSNf2ki
 mgh1qI9Knifn2ADZ2FYeA8rjAdgQk7uPr+Jq35PFZzWZT5LQUPUg/UlAP3e3d3rX
 jCB/so0AdQ5MeSywbZi/yfHx55gbJSG9wtYuv7NN1RtJzpyn3K4JkhQXg8Etw6NC
 737lLxf0ZfPBRq/eBVBAe+L2Quoesq+WX3TNl6Z1ZeyeEPi5o+3uiNKXz0Iuy/ro
 7gE04Wn5dr3jDCFh2POJSxbkjJGXluZnhvq1+ylNLuk7XivKopzOxbZ/5LvWmKgO
 DHlD1XPRsdkTFx5iS8jrbx9zFft7dxoJi3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv3w6a2h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93106d8af18so119307885a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954313; x=1786559113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wuZ5E0ETAoDgelM+YBdVSGUtVXsjyTP1Uhqzzw6j8zA=;
 b=aLmRo1Gsp6jVrnlJw0FNJyT4VGnW3XET5Va70vVkERbBfsQ/AFWkIos8agEpkKv60Z
 1iiZtLLG0HqTBPcPgs259csUtkWcN+6YnDfeoYA/oW6R9KegY0BlFY/3xxpBEdh0t9Tt
 5H0cgz6F2wwa8XxrHCOL4YjmzHsmsk05EVndDlndRHU6cbfmgbtUncuzHE2odVQ7B93x
 JRfYP+qcIlGnLvIdRP754Jxz7RPMK41FHPDvkK4umy12oLqwArRTRsVs/UWOApxYRK54
 NGKXjVC7HjfZsbeVr9zZpUtDrmviigpYc7YUy/nSBS0CFogsNowOJEvA0WwWgglIefBR
 zF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954313; x=1786559113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wuZ5E0ETAoDgelM+YBdVSGUtVXsjyTP1Uhqzzw6j8zA=;
 b=mVRPQX3Xsl1bey3ytjEy8tLJUnFhlyeNiYV5Atm7Y+yU9X0NMKiIXJe9rJgu/jgKcE
 FTI03oT7w1uYhwyc/3yK5ZPLz8Cn9fM1YRbGcnlh9Zg6PQZRsqDzDmvz5VDxS+6RQuNT
 8lH56C+0gscX+ohQdFn0WG2J1QD/GJoh4nghb5UCL3RZqllPWtgCQKy98mwfOR7CTKFA
 rAqibF/otaCP5HCFAthByvSgxIIjmAiXgHiFSUqtcaFzKD804zuDaxhhtKvnecwihKgw
 hFCEbCtR26PTfHyQ9TP+a9TZgj57GWu80QiJfCr3rPT9rFvMrQePQQVDuyHwR8oxvnUa
 Cecw==
X-Gm-Message-State: AOJu0YzF3hVjlMOvGoQHNQsOe/jugLKv0y1iiRKWpKPTrHBHWVXBc6B7
 6hqdtTlpbgLaN9esjF9PopItydxSb3nhWsetYBLlqoxKOpBU/ymMeUZh+GHrSoFLlI055aYeo/L
 s6+jNxZPPzTPVY8Xbg184iw7YG1E+7G5CwnO6KICp+JnjHgV2oXBSR6oUrDpG4qpEDA==
X-Gm-Gg: AR+sD11bnAJn3TsLpXgsr5MuodC0HTFedDe25k24pfCa+P3pxZQDvneR1E5HjwEVNWp
 IItg7zICKntxgacQkJKsw3pytp9h6I/rGaW1XjRvubWAGh6NP02y2uMsYT/lEcnz6wyZc/w9x/I
 fiITlDYPHWcZxUoq4IYugFCoF0PhT2eUK7TmB8H4SVxPa3pBfWgHez/dDF4FktPUcUwNCE4OskV
 VjATbVLnKycdnEGGjWjUT0oAPBVeoryGU1AESkZ+JvygdlU21EenUF/z9nPtv4zV2TJoZxZdh3E
 xfM09DTq1D/0qCnXAaFlai7PYD+y8iKYiPVSVD9wvFxLeLoQ3THBU9+XViymzIAixylfm9WjixK
 w3Le5UFAAvAByvThJLtawVsrblVMni1oIRiDFFg==
X-Received: by 2002:a05:620a:c53:b0:930:fad2:fd with SMTP id
 af79cd13be357-93649161658mr693576385a.17.1785954312906; 
 Wed, 05 Aug 2026 11:25:12 -0700 (PDT)
X-Received: by 2002:a05:620a:c53:b0:930:fad2:fd with SMTP id
 af79cd13be357-93649161658mr693569485a.17.1785954312273; 
 Wed, 05 Aug 2026 11:25:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:11 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/5] target/riscv: support Debug 0.13 and 1.0
Date: Wed,  5 Aug 2026 15:25:01 -0300
Message-ID: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wH1ACQEzcCbLYjBN5RZc1oLE_zIG7yWN
X-Proofpoint-ORIG-GUID: wH1ACQEzcCbLYjBN5RZc1oLE_zIG7yWN
X-Authority-Analysis: v=2.4 cv=a48AM0SF c=1 sm=1 tr=0 ts=6a73800a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HwFc7jivAAAA:8 a=SgNnq1RCrPOTJjEUAoEA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX+uxFmb4hcVI7
 fVpQeGMdMChyo6LYGq38xd0BO2D9giX9ozKfhds8TljngUHkgsgPQbds1V75z9b438lUzzyPEyz
 nbKdSwd6WlcsivKD46WfQ0SHZjA5LGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX1fFEz5IkMcHP
 Z4bPBDdjqh/e+mw5g/31llJM16VfPPArkrI2fUWhi0Bnp2FySK7+J0QfAiIpp/q+r/FHf5qa7uS
 GZ2GneSv26k+E84nRo0mgF0ZzzSMIhYNXqMzojH4tUS+U0QQQfEjiZRcoHVyLvMr9Oe+9u8bhjE
 7DNOEF/cU2kemi3kVzxKGKlFxAODWGJMj+wkDIvnP9WnaiZtlYPGrwvOeNhpIblQBDZLMJEYR6m
 1tChcNojgR3JDp3BmbDoZkXGrDuRK1fJ/3rRCuFubZsLmH7Jnxtyau0I4+AecokSxAc8sBOKrHh
 EdUNJsgbxiMw7nG+71oOJG7tDiy70b05XSD8BKB9zKqD4/cPyYqxJhkv/bOQo8nAH4S8cyrEVAI
 VCSg57pezuViAZLnGIEN1o5hofSeXRStTChr9IBYlrujCyMqltsF5sUx1p5Sqy3qIV1Pq6r4XDP
 KapdNoDeaztR6tEMv4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050151
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

This short series adds support for Debug 0.13 and Debug 1.0.  The
motivation is simple: we need Debug 1.0 to complete tue upstreaming of
sdext, which is already fully reviewed and acked for awhile [1], and
then proceed with the upstreaming of the RISC-V Server Ref board
(currently on v8: [2]).

The work is based in section 1.2.1.2 "Incompatible Changes from 0.13 to
1.0" of the ratified 1.0 spec [3].  It ended being simpler than
anticipated because we don't implement most of the registers/bits that
are backwards incompatible.  I added doc changes to explain the
rationale used.

After this series:

- 'ext_sdtrig' refers to Debug 1.0.  The legacy 'debug' flag refers to
  Debug 0.13;
- setting both flags enables Debug 1.0, i.e. 'ext_sdtrig' takes
  precedence.

My hope is that this split will make it easier to to move away from
Debug 0.13 in the future once there's no more demand for it.

Patches based on master.

[1] https://lore.kernel.org/qemu-devel/cover.1775959096.git.chao.liu.zevorn@gmail.com/
[2] https://lore.kernel.org/qemu-devel/20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com/
[3] https://docs.riscv.org/reference/debug/v1.0/_attachments/riscv-debug-specification.pdf

Daniel Henrique Barboza (5):
  target/riscv: split 'debug' and 'sdtrig' flags
  target/riscv/tcg/debug.c: add Debug 1.0 'pending' bit
  target/riscv/tcg/debug: adjust 'timing' bit for Debug 1.0
  target/riscv/tcg/debug: set tinfo version if sdtrig enabled
  docs/specs: add RISC-V CPU Debug support info

 docs/specs/index.rst              |  1 +
 docs/specs/riscv-debug.rst        | 68 +++++++++++++++++++++++++++++++
 target/riscv/cpu.c                | 21 +++++++---
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/machine.c            |  2 +-
 target/riscv/tcg/csr.c            |  2 +-
 target/riscv/tcg/debug.c          | 51 +++++++++++++++++++++--
 target/riscv/tcg/debug.h          |  6 ++-
 target/riscv/tcg/tcg-cpu.c        |  3 +-
 9 files changed, 142 insertions(+), 13 deletions(-)
 create mode 100644 docs/specs/riscv-debug.rst

-- 
2.43.0


