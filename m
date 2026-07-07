Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A0AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAKr-0004P7-BB; Tue, 07 Jul 2026 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKY-00044E-0R
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKV-0006G3-R1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTLoP018214
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=N1WPpvK3UOD0UMjWHSqb8P
 wUqEtpAMLbqzxACyxVxUk=; b=OL7DGuySIdTRaXwQMKKLWH5oFens65Em8z6QWO
 f820QiN93NUEoCtI/k/U/tVdH/mGpZDWVOSL4DmLAriNbSLm2AcFhwIfRAXpCP7J
 XO3GCJOX8i2jAhfBZcVUNTV+NmNKUnAXmECsgdeBtKvB4OInemtJT+qU+wqavaA3
 YFUn0kroPKV4JdPEZNFUcTyf6cvLEr/vU976tdr8Lghi/HiSot77n1MG5GFlfgj3
 H4emE+SqqORJS647JE2jFNEPp91zbOodx4INqSMG+CiIlV9C13C+3jR4+fKKHa1D
 F9UI7huTsm8JV1o3gCUZgsLBsXHu9MXOt+5iqINvpxSIMy4w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2ntq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:15:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f946461so485332085a.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448132; x=1784052932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N1WPpvK3UOD0UMjWHSqb8PwUqEtpAMLbqzxACyxVxUk=;
 b=Smw3+iAPBWNACNxV/TCuhyZHrPoPraOqXCPxSHfGSvS7JLz4MPq+/VR05z1kI0k6ha
 JLE3hRTGJXMMsgSHzxDsbKzLlb/nlhtAJY3tVhBQ9z9/AfTK015r0igneMTd3z3BFB81
 Wu6/NEmPFlOTm4tV8Od2OPVnfzp8dN0OsdqJi7Ct/MF9w9sVwrO21XWmlb7E1LH6auYJ
 BbvXooTzGqMsf8If8J8sFA5fL+ZUULK8m3z0JvxQRrpkB+4g2XpYYsuOOCGf+ofKyl+4
 Y4v2tgr9fxGLy3+rHS+yy2/+5lDiy2XePjFmw4udyTjRlGr43J/XXbluUhxgm4Ox0X2a
 RGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448132; x=1784052932;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N1WPpvK3UOD0UMjWHSqb8PwUqEtpAMLbqzxACyxVxUk=;
 b=DNEsEYMfvNTSRqai3ct5IaT9shQ1crg7v1ONf4uPRY+o7lp1MapycBfiVAdCoA3SyC
 bJnnm3OvLAAbbz0/lLeipk+UaqF7IWDjCq0zE9iEiJEArj7vEhMBAHpx6+iKLYr71p7i
 nRPL/We1ByHxXydwUiWJ0mnnZYO2lBz/MojA1+l5j4as0VwzygulsKoM3ONtmNQFlEob
 v/Iy/BCNoCTywDrLWppo6cqBiRorIhQ3xT/r7D6uB6cVMLIic77YrtsWWSJ/D4fDWVSl
 HM6LcYXroEGC3zzpTs33hdb5lwLQLk4KuHCLEiu2l+Q41eh1zUklayRpUsJMRC0Zx4y4
 BvrQ==
X-Gm-Message-State: AOJu0YzMufR5+sC2rn0ltENYIc1vyijDLZSuMfHb2DrJpHZbHfo6BbFb
 P7U12R2yn7Yv50WkMQTbnrsua7HTnHAHVQUmPepzILWouN65yy8CyW8eXOT/biaLOzSdwN4oS1A
 CXrU6X5jBLc6kNW28LR8ZQ2COC4ySFWEoSOxoZ0QgT8qdwuD5fSOeB/+pGOvPuK6/7w==
X-Gm-Gg: AfdE7cmTpfXszg7EGQpG9Kr9LMKYZzUopRLG4yI0ONm4FLgrgNoKbMYo/+7agxQhGPJ
 P2yO8uhAXuSLHH2CE4xrGTgl04bUUBzjDruXITqv7UkUtIIviBy34lGQehSGWZxBkFcLvZkm2zo
 rj9kel9F5B6dEIIXIXyjW1Mb3ldxr6XUIeSNxqMLc+QHDyRNUoDvOG88979qt3SPH7d98ynAeeM
 +Ci4PWOhqM6/NpTuftv950Vfufa7t23wmT8VZC6aybZFHFVTzodKghxkxyg4u3LWzvKVgtBc/0Y
 Fdpur0JnmRxASy6+uvNNjRisJPkVUNMkPXZufBI4FsFuhHt0gFsKVi9JY9h/DHrEwtm93DtMfxH
 MyjSfuXczUadZ7zFp32YeY5yyeO2sxAY6RZMexvtq/UHXar9cByMgwPdBaOQouRtZhGoY
X-Received: by 2002:ac8:7fd5:0:b0:517:71d2:37d2 with SMTP id
 d75a77b69052e-51c74677074mr72479111cf.0.1783448131760; 
 Tue, 07 Jul 2026 11:15:31 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:517:71d2:37d2 with SMTP id
 d75a77b69052e-51c74677074mr72478661cf.0.1783448131130; 
 Tue, 07 Jul 2026 11:15:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f4ef53sm81709305e9.8.2026.07.07.11.15.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] MIPS & SH4 patches for 2026-07-07
Date: Tue,  7 Jul 2026 20:15:05 +0200
Message-ID: <20260707181529.60191-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AWyTgVC-9ljwS5VlvqeLCeGnxep4zyIA
X-Proofpoint-ORIG-GUID: AWyTgVC-9ljwS5VlvqeLCeGnxep4zyIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX69ATsCpZG9ko
 nBgL/uL+0IK7BGp6hKiMWUU5HF8APVIvPT7mq89lsuAXSMbqLCVRoL7+5Mvq8ioDQH6MYt8dsZg
 w7mZswUR9iWNTb2IOdpBigSznoRJx38nHqs0Ryr3csnCg5QAz8qaVXGBAAV8noZxLwe3FIAUm86
 7iNlvQCIEZbk9VeRZjJPEvXqwdnIeO00bn3nwFzxW6akDBwQyLWe4tTCg1vBr/pQnClFXqKa/zH
 iKuN2C25hp0B4HYgNOCFC5t2qoe17JwQftylIW71GaT2+OfhHcMEWXGnEHUuC6HcsZuXvi2zaoj
 f5E8QEXICxQqOcF6qeRFes0y+uiHpjKCxqs4ZoXrGP9elIi3mS0X4rwsDnYpnaW0v08tun1YuY5
 nQ5xWEtH7l8JjEn0U41DdLlwIKZHOoL7eC26ra9q/yHYN5iDvYsf79xFRbP6Mbgyj/VaZJRSUwd
 u2MWvKvs2iHnirIW62Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXx2x6NDcCpg65
 L/7YfTClHi+V4inooRAXxy3ZAGR4SryTrxqihfPffqUjxTdAzJkkt0+55cFrIPptraSqJpT9m3S
 PIeF2i7UyqUcvQGwt5bFEjtF8wya8YM=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d4245 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=3cHsy0alhm705wfKIboA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:

  Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20260707

for you to fetch changes up to f086625548aa2f839c119243121ef863ecb606a0:

  qemu-options: Do not list -enable-kvm on MIPS binaries (2026-07-07 20:14:51 +0200)

----------------------------------------------------------------
MIPS and SuperH patches queue

- MIPS Octeon COP2 crypto opcodes
- Fix for SH4 FIPR/FTRV vector math opcodes

----------------------------------------------------------------

James Hilliard (21):
  target/mips: add Octeon COP2 crypto state
  target/mips: add Octeon COP2 crypto helper plumbing
  target/mips: add Octeon CRC COP2 helpers
  target/mips: add Octeon GFM COP2 helpers
  target/mips: add Octeon SHA3 COP2 helpers
  target/mips: add Octeon ZUC COP2 helpers
  target/mips: add Octeon SNOW3G COP2 helpers
  target/mips: add Octeon AES COP2 helpers
  target/mips: add Octeon SMS4 COP2 helpers
  target/mips: add Octeon 3DES and KASUMI COP2 helpers
  target/mips: add Octeon Camellia COP2 helpers
  target/mips: add Octeon HSH COP2 helpers
  target/mips: add Octeon CHORD and LLM COP2 helpers
  target/mips: decode Octeon COP2 register selectors
  target/mips: decode Octeon CRC and GFM COP2 selectors
  target/mips: decode Octeon HSH and SHA3 COP2 selectors
  target/mips: decode Octeon ZUC and SNOW3G COP2 selectors
  target/mips: decode Octeon block-cipher COP2 selectors
  target/mips: decode Octeon CHORD and LLM COP2 selectors
  target/mips: add Octeon CvmCount RDHWR support
  tests/tcg/mips: cover Octeon QMAC instructions

Philippe Mathieu-Daudé (1):
  qemu-options: Do not list -enable-kvm on MIPS binaries

Randy Schifflin (1):
  target/sh4: fixup tcg for sh4 fipr/ftrv instructions

 target/mips/cpu.h                             |   31 +
 target/mips/helper.h                          |   61 +
 target/mips/internal.h                        |    3 +
 target/mips/tcg/octeon.decode                 |  213 ++
 target/mips/cpu.c                             |   68 +
 target/mips/system/machine.c                  |   94 +
 target/mips/tcg/octeon_crypto.c               | 2310 +++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  396 +++
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   19 +
 target/sh4/op_helper.c                        |    2 +-
 target/sh4/translate.c                        |   15 +-
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 ++
 qemu-options.hx                               |    2 +-
 target/mips/tcg/meson.build                   |    1 +
 15 files changed, 3437 insertions(+), 13 deletions(-)
 create mode 100644 target/mips/tcg/octeon_crypto.c

-- 
2.53.0


