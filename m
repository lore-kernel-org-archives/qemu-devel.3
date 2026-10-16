Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620C2CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmey-0007d9-5n; Fri, 16 Oct 2026 14:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmeu-0007cb-CG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmes-0002wU-8t
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5nOb2914757
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Qf0Hc5fCYtNExP7sbU90ES
 gIZZ/+l9UBfRV0AskOVRc=; b=I4LYDMeJ7FLCUP1qRvKSCAkXFFHI7kcupXUCKp
 8Ww+h0DJQ/+QRDNIwXtDFdHU+kcP/yJ0F+engnOKzVdslN0G0vQAUNsm0FOJD+qx
 TL6ToUJxStSX8p+lv9+r00RXDZirRxsCffvcf/u6AYE2uadimFKLM8Uvxh8t3JcB
 PP0HItNyy7eZwnctPSi52CavCFiez10fNXT2iquCgYSFVl0oxexq9Xit9+uze0yY
 F9ghJMad2S5TsW2B2JzmPkt7T7IyL5msHE+BRSDEh7ZPOqp1Zc/LBe25pFRbbKji
 N1oFq1/47XKXcCMse6TQtbIOvT6keK0mPhDQO+SkQIP+Eh/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq16y6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc435388657so218267a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175275; x=1792780075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qf0Hc5fCYtNExP7sbU90ESgIZZ/+l9UBfRV0AskOVRc=;
 b=ftPUE5kNYf07tsxaaa3vIWICpQKkUq38sMJtGrsvADiGLvi6MPQf6XGYGcyxKHNAZE
 7plE+D9iId+XgteyqkY/e8HoJZdf51DYxnGXKyjXu3/wF+sd6CvSk01SAHDOl9UlRrFX
 kLb0SsON7kdDs8PTys9Aa0mZ8MJZouSUMetkg3Oj0TXtTabZ5zJLGcMofJAwZ7Cyt77I
 XPyGmFmKAvsWqdkDfld1NZrweYqUrmcyhKhHOs8MnkUUwF/oHLKR8XRkNyXUGoaebLzw
 tBkGfiI2kM+F4qC2ai/OwFm4BehqSJ43KCaoqYp2zfCg+D2TIW9JkzhM539N+MEgIozm
 kYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175275; x=1792780075;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qf0Hc5fCYtNExP7sbU90ESgIZZ/+l9UBfRV0AskOVRc=;
 b=QwVQikoHIWcz/DTj+okqfLZbWBavaLTXKNSyHfLJvKl+akT3yJLe6S4kH6yt7sIW62
 aaGsw0NJM5SlaHY4j63NJ+/Yi5B2qoxETMIdf/q4CEc/5ebhiHdi1c3QxQNa3mELvTRS
 OFcu8V//SnHEY+qYdCLXuEB1umKByboz/1geZZ1eVOpdnAZozSGR9ZshmIBtGsoMnlEm
 wWgypVVTvKiQgKnHFhdH3tUlwZ+SWOWnZCUhIRYj+tJIAHKljjklk8y9TR0N/fwjkaQV
 kkaGnwoMGK6WrRuZny8khwd6FeBpEBPgh8Hy6rgXetz9b1aEZK4/SGNi3yMPc/RacEeA
 fMxQ==
X-Gm-Message-State: AFq9FYLtKs3KzKEX74qDY3iLiDeaxxQZCJqKeztiTTQ4c7DRl6pZ0TJt
 NqqPB26vMT2/xl2SU/1HY1ti/dlnne0UApsHAAhlvTaNLvcYnlhgTEPsAOL7sa+RaNjnCq69lFf
 6wuMUYDw6w+HIk6EpPNAGBo/s9QUUh1syyPqMzSGpgdVymhs1gI4QJm4PjR3m12hGeA==
X-Gm-Gg: AYBFou0gcFTrxSWTS4ggqlaoL5oIH4rrjvraG0brT3Zn78kcyG9CQh9Nt33acWn7Hin
 YYcAALy/PCbEMxLCWhPGeJowiuQE36bp71VlOSqAR8jLT/P21f9Kdog/+Zwhihhn+anKIdRmrGI
 Wivnb4SYRgEyxSeS0P6dUfhR/b34422RJhieOS7yBKmFIlfej/rmYBQnL1pRXnl1dUqHqM/9O0k
 Lxh5ff+PjvLW5JRhYFBeQg8q/SM7cEdq68zVoWm6nHyWwB+i1+ekwJy9OlHKAk5ocUqQVq6AAgX
 Odj3Xp+GTrSNgbQL7T5RBKTTZe4A5YJRx5q5Lf8h2kzv6azbe/02ynrAr26c9QNu86XduBmFSRU
 8RTejX7o1M2h4n+qIuJwUOnsuO4SXGaKQYoW3jbHMkeJqCdgLfu067edVyRUBCBk=
X-Received: by 2002:a05:6a21:670b:b0:3e2:24ef:d887 with SMTP id
 adf61e73a8af0-3e2260e2b53mr147764637.60.1792175275006; 
 Fri, 16 Oct 2026 11:27:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:670b:b0:3e2:24ef:d887 with SMTP id
 adf61e73a8af0-3e2260e2b53mr147738637.60.1792175274506; 
 Fri, 16 Oct 2026 11:27:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/6] multi-target: add riscv64-softmmu
Date: Fri, 16 Oct 2026 11:27:45 -0700
Message-ID: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfXxWBAEAPwMVgO
 Mf+EDUm2P4Sq3u2F5UxVq++eVlVHWOfIN5p0VckV1n8M9iJB3adSMam30lQxYWJOcNlSxBFch8y
 YbqxxCyMI3yyM8o8fEDpd3N6xE+NFkw=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad26cab cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=l2v1Hlwuwtc2NPfc1QMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX48THxPThH4oX
 1ufD5cVmARMOyTa6BUxZ/A60FIdw/ZDVvixdtKYSvVeyu1PfKirhpLZk1r1kp/RF5ItTS53Gb77
 WgO37+y12RL0Mk1hTCLATLUoaJw2bRJOy4pw+bdWMotwGEVosPinvp5YLt+r/RKc1+yJmbgE2d2
 fwZ4L7i2LSUqLe7IHESDD2PsnewNCyWqyOTaQU8cUftfAsXKRaPpeJyLBcmolof6ug47zsKOB1b
 HiPIuZZz8YJ4X3iGq/XeeoZT7lga7l2lN8aOxUtJK/4JtKVDRelUEZA2wxmiiHoMtSgar5EXSjo
 DcN+Bjz7UggZT+GqyyQAhnlHRqMYEZmTpMA44GxVEuU3ATv0Efm4X3bZo9ksWBNZq1Cs22EPtU2
 dmE/hzjssgKlQlYoq09UPS0Qfn9DBsfoW64C3ILNDmifPW774jBCLA/fDBefDUpBArX28qV+qNL
 Hkr/6a1REtn7lvlKo7A==
X-Proofpoint-GUID: Wkhdvj-AtBeUPpsNJM5Ir3NwP7bMIXZn
X-Proofpoint-ORIG-GUID: Wkhdvj-AtBeUPpsNJM5Ir3NwP7bMIXZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
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

This series adds this target to set of multi-target.
Changes are straightforward: functions and helpers renaming, and one type
restriction for this target only.

While the series applies cleanly, it will need those additional two series to
build multi-target test binary:

- Based-on: 20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com
"multi-target: remove dump functions duplication"
- Based-on: 20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com
"multi-target: remove qmp_query_cpu_model_expansion duplication"

Usually I prefer to wait for series to be merged, but I have good hope to catch
the freeze date if current series is reviewed, and send all three at once.

Pierrick Bouvier (6):
  hw/riscv/virt: restrict scope of virt_is_acpi_enabled to this file
  target/riscv: rename virt_acpi_setup to riscv_virt_acpi_setup
  target/riscv: prefix helpers conflicting with other arch
  target-info: add target_base_riscv
  target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv targets
  meson.build: add riscv64-softmmu to multi-target

 hw/riscv/virt-acpi-build.c                    |  2 +-
 hw/riscv/virt.c                               | 12 +++++-----
 include/hw/riscv/virt.h                       |  3 +--
 include/qemu/target-info.h                    |  7 ++++++
 meson.build                                   |  1 +
 target-info.c                                 | 11 +++++++++
 target/riscv/helper.h                         | 24 +++++++++----------
 target/riscv/tcg/bitmanip_helper.c            |  4 ++--
 target/riscv/tcg/fpu_helper.c                 | 16 ++++++-------
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 +++----
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 +++----
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 ++--
 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 ++--
 target/riscv/tcg/op_helper.c                  |  4 ++--
 target/riscv/tcg/tcg-cpu.c                    |  1 +
 target/riscv/tcg/translate.c                  |  4 ++--
 18 files changed, 68 insertions(+), 49 deletions(-)

-- 
2.47.3


