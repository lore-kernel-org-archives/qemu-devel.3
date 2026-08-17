Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F22C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzoS-0001tK-1j; Mon, 17 Aug 2026 12:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wvzoH-0001q0-4u
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:03:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wvzoF-0006uj-5j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:03:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFYpSC2666316
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 16:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=iUpfIZkbkjQh1GSKm3Neq9+gpYS9Taf5qFg
 uVKBvvF8=; b=fqFBN15jzkvtGQH5/4FhHu/UJMJYtin5bZxFRt2ktkj4yhylY6K
 530QdN85uZWQUSC23nQSSHkT3V+H4YQh/UeVhgV7dt5GY1Z+vw0p2CUAjRKXn8uo
 Nc4cr9WRIQK91P/9WWrS1zd/zl2BjuwmvLy/RXhfU0J7ntN9NBiaYh636BwXk5xX
 z4gayHwkGEzdWceKZgIScPwjY4YGIWjO+J9oN7CWaFV3edGaRLZA2u5NN8K0z+89
 nf09hz0r9lbPIj7qU5KosOr6rK8qa1eTy25BUcVjpu6gFHNeAwtbk35g5HfmHYNo
 71TXMH6Aafa3BMmQ3w/qorkrdBy+ZjT276A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vghtgrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 16:03:31 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso34389b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786982611; x=1787587411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUpfIZkbkjQh1GSKm3Neq9+gpYS9Taf5qFguVKBvvF8=;
 b=hDauSGU+ywfX2zJXugjRJmf55S9nA5kmtda5Wa6r9+L5q1i6ib1MwTbH2E1N2g2fGv
 EIxQhKRiH+7Y7T662aZlK0k3UoOLX/DP1OB/6wz7D/tGBJcgrc5Iw9zID4sF/tC7Gtp+
 Jo8e00r+d64FBzSWbw62dpFBT2ADIyu1cyXL4mXwiNI7iHdQQvWFzhhpoX2i22tZ+mNx
 ImbYSax06R3oXhNtSauynOH6M5K2/lHN7HpMt7UEB7cswOJryw/z+GLCTSHcnbkrpua+
 fEGSatBegTs6oex11TPIc4c6abTa5hGb4waVevIa8YsxFhdACdMAewMRrkTo5SwDr1pP
 qZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982611; x=1787587411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUpfIZkbkjQh1GSKm3Neq9+gpYS9Taf5qFguVKBvvF8=;
 b=YDv3dfiSkgKRGki179AqP0J1fEVVbD8qqDBDlvEcKpZiizMrBmOf5YoTQW+de1iGgc
 pGvnzLHofDFUW7dfXcNDgkx5fwy69D2ztJiK25VrdjJYWS9N4Ui1BiK1p4rtAx802rFX
 RczD29QWUIWharb6tQLTAg2yf9AV6zvNC9vO0aTaVQ2BbiZD+gE+siA4tNPGxd++Uyrn
 FHO5UO+GrJt2HJT/D/dUBCcsrMrJpydKyPv05Youx90MN5o3NAlHrABJFThdOCQwWUdn
 yp0oaxYLAMGW/23ahAGgmnHZ4HAdiq9d6J553/yxjbakBaU8hpgIQiCUbBBad2FH0yCK
 cqig==
X-Forwarded-Encrypted: i=1;
 AHgh+RokfNER4F6Z81a9d/xfBFifO6WWsFxYG4Xb2uZc7CMoj/lb1MJcwiVhKQGIJhKakYBwYNjEQcBN94EQ@nongnu.org
X-Gm-Message-State: AOJu0YxUNZcvphJwhO7zWLrPNdiTQrXK5EY4+BqgE4IuXfJVCO113cro
 OQUTygE1relGM1lr+pSVTe9oBGpVI96XRTTMmSL9e7PIsg7E9oTksYj17QxlNiscuLiwuOE0xNY
 CoisanDwFLW59Fa5SiFBgblUoc+8WkFLDPPd5JugdU+7sLGclZ4fpAQ1Kcw==
X-Gm-Gg: AR+sD10xg15r2bGQ+qQ7Ye0lVC81O9HLe1a0EpVDfy+YU0GjDckvbc5xUYVW9yia3Xx
 jebYVvUJpepEcjBdl7msfglFkVnzXOW5HEU53MgzpryjhNE96/TqldokvVxCNlagHLbrq1FR2V/
 PsSRfEshXnKxWjo2lY8iejw4xzTFm9dDqTGOy0pSHVV3o18+Xcn1HFtPI0ATFgpkpd6csaCDvZk
 5klP6lKuuBFTvz8MDVc1RjyE8948c9RzIjSdCIcnenVTh/Zd43yUcNPuKtOWWT4GjUKtQ6WsVyq
 qaxPP7lL7fqYeAmZaBYJaFXe772GaLh0Lt4rvGjg2sc/JGONN7s4JMiD8h70Xo+T5npCv/Ajl/d
 hjvEK7qOPB4OesdhxvN+DE3n0k4Gww6qeRuTBQcs4n4C6LmZQnl7laIDZN1lEtkHzLZdldOEsGX
 0SDYTNMAULGpcmwiroi9YzNgt4lg==
X-Received: by 2002:a05:6a00:2314:b0:84f:df11:b78e with SMTP id
 d2e1a72fcca58-851bc2351d9mr141444b3a.2.1786982610931; 
 Mon, 17 Aug 2026 09:03:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2314:b0:84f:df11:b78e with SMTP id
 d2e1a72fcca58-851bc2351d9mr141397b3a.2.1786982610415; 
 Mon, 17 Aug 2026 09:03:30 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-851b6f8c0f6sm545923b3a.39.2026.08.17.09.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:03:29 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [RFC PATCH 0/2] RISC-V Sspesa: QEMU model support
Date: Mon, 17 Aug 2026 21:33:15 +0530
Message-ID: <20260817160321.3313698-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a8330d3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=OJFGyuVhfV-0zpwyQK8A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX94Wmaja15zxp
 XtuWhTNfJC/vDe8eob+MP55GUbXmiUSaryLndXpy/J6bxJ19LJheCkFFee3pniMD2m2L3Nb76ed
 IZBzBNFmM8Dw7+Sl0T6eXY2SNV1RFog=
X-Proofpoint-ORIG-GUID: I8MLp0Mf3LwnbYzgsk2TTecOPOqxozUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfXxviVi7yOufhS
 mftGN0xHA1lgy2466axKW/7RMwnRecU1L3stHjMholqdaxXJVdbNwx254VZDxwimqMpFOx59Rcr
 9REj+gRB6XxqcI6JJnFXhp+XczUd/h+WuzrJOsgSEBcgS+BBLYdLRiH7g4O2O/NHMJuh5c+lc3W
 0NA8REkWPKJA3+DiC5tJGkh6EyO4sGgqSiKQBAsJWFjjr2lO735UkoKsEhSlsdb/404S7duznKB
 LBEx8THZ0JPMssun8dQJ8SZRNNK7e9cIAarJm+tHnyoMq/GHR0ce/xrzg2VJOdt0iddllmk8nGM
 bbijtHHtc3FTzv/51bO33a+84V4UXEs961BLn7KXkN7de5BqaPGaJm4UNSCLhcMReQkLySjLhI1
 ci3xGWrxCkS1k7NWyY8BJsizryJ7srSB4kvzEKXWdpQBbvvNBmC6MicPytnIl3Xxx/xKmBwhG7d
 +CzmXaHg7IrvoZfbytA==
X-Proofpoint-GUID: I8MLp0Mf3LwnbYzgsk2TTecOPOqxozUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
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

This QEMU series adds support for the Sspesa (Precise Event
Sample Attribution) extension.

The first patch adds the 'sspesa' CPU property, the ISA string/DT entry,
and the shpmspc/shpmsdata CSRs. It also allows menvcfg.CDE to be set
when Sspesa is enabled, and adds 'ssplcofi' which is implied by Sspesa
so that it is advertised automatically. The second patch captures the
overflowing counter ID in shpmsdata at overflow time and latches shpmspc
with the interrupted instruction address at LCOFI delivery

Note: this series applies on top of the previously posted fix
"target/riscv: Fix LCOFI masking in sie/sip/mvip", which is required for
counter-overflow interrupts to be delivered and cleared correctly.

Reproducing the full setup:

Sspesa support requires three projects: OpenSBI, Linux and QEMU. The
matching branches are:

  OpenSBI: https://github.com/mdchitale/opensbi/tree/riscv_sspesa_rfc_v1
  Linux:   https://github.com/mdchitale/linux/tree/riscv_sspesa_rfc_v1
  QEMU:    https://github.com/mdchitale/qemu/tree/riscv_sspesa_rfc_v1

To test Sspesa, build OpenSBI, Linux and QEMU from the branches above,
then boot Linux with:

  qemu-system-riscv64 -nographic -machine virt -smp 2 -m 2G \
    -cpu rv64,sscofpmf=on,sspesa=on \
    -bios /path/to/fw_dynamic.bin -kernel /path/to/Image \
    -drive file=/path/to/rootfs.img,id=hd0,format=raw,if=none \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"

With all three in place, a counter overflow (e.g. 'perf record -e
cycles -c 1000000 -- <workload>') is attributed using the
hardware-provided sample PC (shpmspc) and counter ID (shpmsdata)
instead of falling back to epc.

Mayuresh Chitale (2):
  target/riscv: Add Sspesa extension and sample CSRs
  target/riscv: Capture Sspesa sample PC and counter ID on overflow

 target/riscv/cpu.c                | 13 ++++-
 target/riscv/cpu.h                |  6 +++
 target/riscv/cpu_bits.h           |  7 +++
 target/riscv/cpu_cfg_fields.h.inc |  2 +
 target/riscv/tcg/cpu_helper.c     |  6 +++
 target/riscv/tcg/csr.c            | 84 ++++++++++++++++++++++++++++++-
 target/riscv/tcg/pmu.c            | 27 ++++++++++
 7 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.43.0


