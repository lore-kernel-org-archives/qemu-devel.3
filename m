Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B8BCA9EC5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSc-0006Yn-D6; Fri, 09 Oct 2026 18:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSC-0006VO-C5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJS5-0002cB-Mf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Khq5A2870995
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=o25ggg4HEkpCJkdP1Ippwk
 h+I4AyWiWp8oamyC9YcEA=; b=CdPZ0mVI04rofpUAV2I9JB8UZoMF1m0+lechpY
 sjAg3Al3a45uWgvvMzBfuGhSRqCDBMNUTvG+WM5hcRhHo0pmfYFP0/CwunXs8kl2
 xh7zpq5u0JJthtglL4OiALRvIynqme9Lo3kJEJaLfadNeei6AKe4qVhjTPT7f0tT
 WV6+9z3kS0x4ZhNjy1/KWwVH/BTrQpaZIete/H6tL8I7MzvFzr651w8ImTqaiCbD
 yC+epLrBldeOJXf4MU1aPBuL8m2bgNVfORIIMRWByyMjm4hXHZwSqTnWAShzHDs8
 61WI5yxND8aAeOcYeaUiEM/abJy90I2duSFG4tC1Xy0YyOqA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8h0ew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:30 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1663fb7e005so268145c88.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586350; x=1792191150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o25ggg4HEkpCJkdP1Ippwkh+I4AyWiWp8oamyC9YcEA=;
 b=N+LK9kdopw7sTopy1qwjJ/ks6lHSWoOcRva175k6bZ4ZEeSC80ThYmlQ41AUwaYC8G
 7cL5zN9BXpwuvvfggUubi4pq9mRB2xVDEjCbs858PIruI+P3lGA2j1G9+X3bPLsLNyBR
 qPevb3eu265eoG4B718ALhTLc1Puy/0bAU0XHKbNp32X3xAv4J6d+LOdhkTWi7kaByf+
 W04WhwZtMXnUT85oNM8Up9uW3BD81Bt3TiKJasi6CdE78LdCmVXB7PU9Tnt9kqzYuevL
 hxmXq0FTYAGNO39GfXp7LXCjIEGpJieZvQU2YY1EJIeE8PNGWG91zUIYJH+DdRisCfYh
 zarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586350; x=1792191150;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o25ggg4HEkpCJkdP1Ippwkh+I4AyWiWp8oamyC9YcEA=;
 b=x8D1wmBZ3LNeTjnvK89FRI2kAVq9uM+5F0c0qfao7VLw/w9sm1ECj/SKjk7iOg3lAW
 D4M6ANniJMS36g7AEukRD+41JI6pYk2mICCorKADC21I5OP0Iyo3wfSF+BWHAY/jrnLH
 wS17wuMkM5GeJyNjZLVducRsszr5UOavEU351MhVN0Sk7PG3+KLnMKPco3huc4mesOWN
 fXZYiz48kCdjdeIUA2bHr071Z11frNge4UteeszXsyaUVjI2yH1u9NvCSQ74H2DBjeip
 YSQEVvxmoW5SB145RYuEzxnJDHQwc2en96A1wv7vD/BuPpxNTFRUCKIHDEij0JOD6hQB
 u6SQ==
X-Gm-Message-State: AFq9FYI6Mdr6apkttxrG+B/a2yEhDovy3WuYp5uNDA0G04m+rtitwODv
 XMj1NrKlPliCKGSWjTXfVLU9E/iCB5n/muSV6tFBeh/SPYkWpdSGPqR7c2ThIH/7Ouhn3H7v0a9
 X2UQLdV1BEyuqw5PFWNr/FxlH/H4biRMhowIAC43P1QIJ/ZojkADG2zdm1Qcl8XWXAg==
X-Gm-Gg: AYBFou2S/nofdquldzaDq68FjJBNe8rfIRLeuwSGmo6RSHsqdXnrw/dKB3ReTtQQued
 BykJ7aFTPcNWAcZ6QFGz/riM7TnsbVMtZaxrK7ei+MJLKNtFF9agt2IYc2+3ijMtXWDbdtXw8aZ
 hyQH3X5GJkQs+Ra3NPpAI8EOrTsDvblspBKxvWXwNfOrEsRhaaDSush4UC9VyglZGEmxUZsSa+v
 oqU8jemSXhUlMYvs0/iHLAdAAj78eQAG5t8BJFp6IYGhW/Xf2WGMpHNDJZ8stP16pSmgzalTWHd
 JJTGxaPSx9h9tlki9mQxUxXqUwQXf2JAVN5IcUwpXc6oPbrqZIA/wcoe1jBFeGvvcH4O+TZESno
 yog5Ptt+k+UV7+uzIsp7CmpmbbqcKjcB3J6052j5u//Up6Kh8sjLOrk61THYx
X-Received: by 2002:a05:7022:3a8d:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-16a63099055mr5238644c88.37.1791586350241; 
 Fri, 09 Oct 2026 15:52:30 -0700 (PDT)
X-Received: by 2002:a05:7022:3a8d:b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-16a63099055mr5238608c88.37.1791586349533; 
 Fri, 09 Oct 2026 15:52:29 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/11] multi-target: add hexagon
Date: Fri,  9 Oct 2026 22:52:15 +0000
Message-ID: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ONOyTiaB c=1 sm=1 tr=0 ts=6ac9702e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=lAAgIVWG3TJcsid9O94A:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: izVG98M0QERolOMQJXpF_bhi0VYMtchU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX7bjAe78NYMLK
 inmtWUvYZERYVY3ZlyLL31cqU1Go7V/cpUBVznPeHn7t7uBmbhXWKqc5aN+yOocZ18pnEBIMosK
 I4x8QUx2XsmAcZY++9LH50XATrfxaSA=
X-Proofpoint-ORIG-GUID: izVG98M0QERolOMQJXpF_bhi0VYMtchU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX6w8omLwKDhyC
 bMGJWOfESGLMhRbDtb4q3S+ofcji1epyiR9NtLHhUNr00PKtXjPySHFvLXUXRMY8u8h6Io4N94P
 xuYipbm6z6n5Kqr6uZVvNy9O1HNs3xyKt9DS1BRafsf62N7tJsV/MzkmBpcKIMEGR9/doI1KMGt
 jULwQI7DZg8lkxUfNBw7bGn4R2I0eLNu+1kjmLF6rfiUFkRAeWe4O715Oy3BmiXvJHUYmcUxxCk
 jRYeRr4NZV+2dMc5Rv5ZcA8do0A+OO1PEDMCx3gTQQaz9RUnJvzABZ5alsvN40clMpygZIV5G2D
 Uk0Fq0/hURV94TBmTLS2+VVND/UkljJUysNezVG9ZZj52KpmSbUup12Nw1Fill38hUEYN6SLKzT
 BuT0TMv1geIhERsDdNMgrHXxP3S7sqQmqQ0r8l4LtZSgy5tlYOadSGURVBVITE47ZUrIRHgOMFh
 De2npqEzcCo+2lk5hmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090091
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
 22 files changed, 151 insertions(+), 70 deletions(-)

-- 
2.43.0


