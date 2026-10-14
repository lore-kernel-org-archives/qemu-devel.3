Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0E8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3fp-0003tv-Kz; Wed, 14 Oct 2026 14:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fo-0003tg-NL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fm-0001yL-N9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZi8b3468853
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dBlkP96O9dswanBaZMq4Id
 lqlbvb4Fgj89x5Py/+INY=; b=X2GhvTEbYj19Y3xOwx6rYKJjEsAhcWr5MX/UBS
 g9gpJYQj+fVQ2n+Vdo66X8xSgARso7LEVIkU6A1rgyMwcmd3fVczvuoffb5gJ04A
 dvCKj2+m2JiihEbMkosYXLsixu+1EdcrHNVN6QfZIt7N7d1TurgRJH39l3SbM4Wp
 qb/Ckh44k7UIeGN6hJcXCT7D/9KZd4pgmJuQ5PeIZ0s872ndcBOMvqeu1sB/DEC7
 XxqaPPGQUuZ4dJuZAq1mymZFrIFBhq4RUr068bgjcsbS2yYmzZODQ6MpGJE7krCv
 ZMYVvkkziAT7bZH8ejbe/vXmePRRLDixhlkFLyFQ39WkwnJA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78egh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1867695eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002351; x=1792607151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dBlkP96O9dswanBaZMq4Idlqlbvb4Fgj89x5Py/+INY=;
 b=kF6ZCST1KZIeGWwhTj0IgTZQ1W0/sBaqlmofuKmipM1ar2DryJDAsiEaqhyfBXFXQu
 hYscKoOhJgmyQE9jDj3GfqJmBUMad3h4nBeAjdljlj9PauFgysuqMEBg9mYSRPWOSpDc
 4uqtxHFmzTK9gdERREP0HlWaSD6NOpPzxSXgIS5LEvPM/i0trdtKSwrZJu82fJpN0TtB
 0JcHA96ENAFOhA51bWryQJdvmhucX/yqRR0K9yjpShwNV9r6t0V+oIl+voAb2Sigq+rg
 duV1J3U2hU4498gw5W1wJIx1dEFCUZm+eRGdhL05UuGonSJj8xXiTS1eM0GSV9GdEb44
 neXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002351; x=1792607151;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dBlkP96O9dswanBaZMq4Idlqlbvb4Fgj89x5Py/+INY=;
 b=WxF6+NIppaa+hiAxnvuZ6z08KWFYJDKsAt2jPLhUW86r7kYH8VVNLPJ7EOqU3xTFKd
 0tHm7GeWHDFLmoFy0vR//gWeVH5aKEl87311o9NCZ397oIv47lZQTcCebU9w0D6a3S5o
 tX2Urr92WBZmP6HJXkLgogco3lRTZvQIrmHlyyOqiv3UlQV62ZVbFS9X3M1Ctr72LveR
 jeUd3sOFuP8uZD3J4mBCMAhSeBMtOv1CPJaTdo+D2S4IGIIBZm3mbGqF1uUd6dUxmJJJ
 fxQjkirOKszwD5SyF6SYZ3bQCLg0SuylNe203quxxXRnHVHw56W5UilQmKJHfULIxYeZ
 QfCg==
X-Gm-Message-State: AFq9FYK0FcQu/Wa4Cd3Cru/dpHE+sMnpt12jeChrtk4RrQl7Xp+1y14B
 n8YAVE1SJ4P5bbu5gtPAADIz9AhCnJQooVfSF+PS6818J1hBCqIlEEf22o4I+klNo7pmL4bQ9pc
 jntKh/+k3CnkSrye8ChlkxnEZ1IGg+BRGn85OWfV3MZFjQ0GVZ+3kC+hgO8KupmyDeg==
X-Gm-Gg: AYBFou0GWajp6YsuSz09nqmoqyvIaV0s8LpL4mUlcMZvEKS/oK/F63zvZRwx06KK4Ho
 8JL+F7yJuwb2v0HDckSticPWc4y5mTBy6xRS5AxgMNsfmNWN02UDtuqKbsOMEQiLq/IorXV3ULc
 g8vYHDH+nDvQZrB3jxC44jjXhrGI8ltv4Oa3k2yyZiRBk8FFJlgCGHEhnNqymMxyxrpk9O9THRD
 7nHOhjV7bnr9mQFFX+OfsRzYyhFOE2emrQJXjoNucE0hArlpXZXA9qLg2owcUz3JmsA3b9hHzZa
 9c8oAEriJuOvcgIz4XYaeoiW1hqxJzrbTAGLXKBjE/pqc4T1nbcKemqcrEs2x/6FCTC03go/xJe
 paMk0vpHpMuJ5SBCIQVFbykdQyr7DTwzRwJwOk+Rsc9aFFuX6RCRVPxe3HN0r
X-Received: by 2002:a05:7022:7f0d:b0:14d:4b54:8062 with SMTP id
 a92af1059eb24-16a5f01dc49mr25605697c88.23.1792002351140; 
 Wed, 14 Oct 2026 11:25:51 -0700 (PDT)
X-Received: by 2002:a05:7022:7f0d:b0:14d:4b54:8062 with SMTP id
 a92af1059eb24-16a5f01dc49mr25605645c88.23.1792002350346; 
 Wed, 14 Oct 2026 11:25:50 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 00/11] multi-target: add hexagon
Date: Wed, 14 Oct 2026 18:25:32 +0000
Message-ID: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfc930 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=d0C3LG-tqr2QDOkIXKsA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: lR-M7KhryxIk0W2-APIXNeCW5EwWqxk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX6q4Waqrk/zGs
 DtFKxjU1LBPmsrfVyiDEP0qQB7srEXBd8IXa3UIoLyRyporM2mfLT4vMzeVPL+ItzXTZllIGKGQ
 GhK1JN6NR70s3OwDqFRbUTUg00ox6Nh+QadDJdX95PVR1aQxfNk9KrCNmnJnARPFnwonfyVZ30P
 EHjtGqmVrI+JN3R8uR6ISDWxHXRC5ZGL0f0t1RkFS3oiQN+ilNTHC0Dkx/0OAieKZJj66yx+2IN
 AUmf/Y1tUiQozV9H8W7xX4EW1jLoiWDr/fmt+rLFolPXQgT3zX2F/URBUwDFEJprArc+Cltr9m3
 fgvHjRmXksrMkLExp2jAduIEUy1AHLwqPmfDwrjqla2vqfdDWIfchl90UuEy784busLPt3PRnN2
 hkIq89WHjCoRT8kKWt8ng2MH8f7ftruRiJl+NhCWlat1gSa73XVxg8NFGZLFH1S7tfqJxR6lxTN
 0wKr0tINpVrKH57tvMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX47Qj2DKlUh3Z
 ramEJ9BILbRjsfqCBsoLyjiG5P9TeG8d31hPHZafqQcocPP8TWoJ59ZR/4owQ2MZHWTixK2kJ/v
 Ae4vpNPVgf5gGvQ6f1EoKQ9Tw2T3kTU=
X-Proofpoint-ORIG-GUID: lR-M7KhryxIk0W2-APIXNeCW5EwWqxk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series makes hexagon compatible with the other ones we already integrated.

The biggest change is to introduce a semihosting interface, since existing arm
symbols conflict with hexagon ones. This is also need for when we'll integrate
riscv soon.

v2
--

- rebase on top of master (one conflict with helper renaming)

Note: this series is fully reviewed and I'll send it as PR on Friday if there
are no additional comments.

Pierrick Bouvier (11):
  target/hexagon: prefix helpers conflicting with other arch
  target-info: add target_hexagon
  hw/hexagon/virt: make machine available for hexagon target only
  hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
  semihosting: declare semihosting cpu ops
  target/riscv: declare semihosting ops
  target/hexagon: declare semihosting ops
  target/arm: declare semihosting ops
  semihosting: use new semihosting ops
  semihosting: remove common_* functions
  meson.build: add hexagon-softmmu to multi-target

 hw/hexagon/virt.c                   |  2 ++
 include/hw/core/cpu.h               |  8 +++++
 include/qemu/target-info.h          |  7 ++++
 include/semihosting/common-semi.h   | 24 +++++++++----
 meson.build                         |  1 +
 semihosting/arm-compat-semi.c       | 56 ++++++++++++++---------------
 target-info.c                       |  5 +++
 target/arm/common-semi-target.c     | 29 ++++++++++-----
 target/arm/cpu.c                    |  4 +++
 target/arm/internals.h              |  2 ++
 target/hexagon/common-semi-target.c | 26 +++++++++-----
 target/hexagon/cpu.c                |  2 ++
 target/hexagon/gen_tcg.h            |  2 +-
 target/hexagon/gen_tcg_sys.h        |  2 +-
 target/hexagon/helper.h             |  4 +--
 target/hexagon/hex_mmu.c            |  2 +-
 target/hexagon/hex_mmu.h            |  2 +-
 target/hexagon/internal.h           |  2 ++
 target/hexagon/op_helper.c          |  4 +--
 target/hexagon/translate.c          |  4 +--
 target/riscv/common-semi-target.c   | 29 ++++++++++-----
 target/riscv/cpu.c                  |  4 +++
 target/riscv/internals.h            |  2 ++
 23 files changed, 152 insertions(+), 71 deletions(-)

-- 
2.43.0


