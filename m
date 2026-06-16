Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA89CCD98EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdhA-0001zq-QB; Tue, 16 Jun 2026 19:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdh8-0001z2-ID
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdh6-00081v-Sq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLTTJf249039
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cLaTi2EGw43VQDgmKYWuiKPQ3z4n8xDyrig
 7q6nz+pU=; b=d0z5JdHDAHF2nptxlvrqxX5LWEqvbD16kphca7FCQitYAyf/QG7
 wsHIwkL8DHR04xYWGJdLMAgbzNNYTnrU0JxzQHoOrNROkTzTVsTuHgB33exb4fEq
 6D6VV02MU0O/XZGQsWQE4NG9HJuWdT8BnLcvv1yLh0tUTa+BLfbjZ2JUeYXpu8LR
 hdovQjHOvXF3pIgMXvml1oP07D2x00AqUqDcmYBsGwlUaWKme6s0Il0GtF0e+35B
 XmNgVo9OA2NzlSmqJv93vl0Q8JZyriJY7PX0OUzKHiDG9O+6yijPdvFpfAcaWOA1
 O+uxnuCwBDBvHQ0eSCcVUN/HnHCIuRIYKQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet0dxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8db99816792so7964796d6.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654385; x=1782259185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cLaTi2EGw43VQDgmKYWuiKPQ3z4n8xDyrig7q6nz+pU=;
 b=iSEqbsB76rMnnH4WJTcC1S1P9STLWasrh2diwJ6DNoN8jx++0Z8ZBPqR8d7VS6DThz
 d9KeKa82DJDUKs8GKWKjk/Al4pX8YDFw/br15//3qApqg6pR1u3Bis2ytsNbbB2PSnYk
 FeioEW9Uu3dOYQ2Gn+SHBZ6/n5l2e+0S3h0Csxw3g5zfdFG9axTsmXrfZXNj+YKZQL+C
 SnS6P0kA0L6TAkF6kyQaoYia60WJYiZNBKXJ0AW3VulN6LAWuFfz+UvYSGrPLJrrX/Io
 Ojm+QOmQFi9tE0cWtqddrVmxig0VmOhp3jGM61/nekkn7z4EEHTPMUDE3aV1W6REzvFq
 7S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654385; x=1782259185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLaTi2EGw43VQDgmKYWuiKPQ3z4n8xDyrig7q6nz+pU=;
 b=N+45QcKcEM50+2Ru/FfXDqhuMk+LAKlqXR6C1amepzjKRy9+ct8lnbfVLayQp7PRYM
 v8/jetOlbJbly3WXLCTbuhKLtQZBdA0hKebtsixaC1yB8oHefFyjSurVU0ND8rSFNG5K
 fReMaFTGurnRLKHp6MnbqcCon7AjpbM7yuUG6Fn9FZz9Ts+FdLyUt5uit/hYEutVrl3n
 WZGZVljD1Ai3u3+izpDzM7g2pH36+gRZsC8Tu7/XLo4N9VolgBWmyBwKWEiCfDY9zxCs
 dOAms2nRerpBE/R9025q0P3tjRVdx108SWZvNPgR1eHqhDXtPGttCLqYQcRPzk7kc/Ch
 MhIA==
X-Gm-Message-State: AOJu0Yyjb2dC39V4w3YLExKD5/F5r40eUUFSXLK8gfXLefrKtXpBd3Pg
 7Kk1MaXnDUqPiBTVLwDqjAo1ynADco/JFqPKDP94YDv4PdS/gpm+pNIpkk/757yyTrhhwwL7WhH
 EADXv/C+vH7e3ki0psVNxj+uXhoAwWePD13fnBMnNzeMQf8Up51C3MQg+JzKAn38lsw==
X-Gm-Gg: AfdE7cnWckinaQl2qMuWJWaCw8RtI12pWGmVbFOXbw5XUDFPxfMoDDnEchKs3vTlnQ0
 OamlO4adAFnGOG4XDzUasXP8mxjM0h4qsbHOi9ffpMqKsdMegt0tDWb9N+aZDVsreQy3DoAJor8
 K5cHN1drQRIHWl25WXFGDtrOYRU+DCGqNmRhwIX1BEppyf7ZlWolE/c49ruYzkwyCNHiMPlcg3v
 pqeVNANY2cTR9WX5B29Kdj86QcqtKtolWV5SnPcCbZ36GWKRx3tl4OGnkXsNcMEI/riTymgrggk
 7/nGYVBx5LbUy4MvP7ypfrY0d+z74NJFpvdLe3IfuuKtfg/zZls/SfqC6XqL6YG9F0GPM2/Sapa
 pid7pSTrNVKodiIzTf/yNaYJBxvR6HbZP9wZx8961CkC6Y78he5ncPrZNxRc=
X-Received: by 2002:a05:6214:519c:b0:8cc:dddb:eeaf with SMTP id
 6a1803df08f44-8db5e05541cmr28832116d6.40.1781654385169; 
 Tue, 16 Jun 2026 16:59:45 -0700 (PDT)
X-Received: by 2002:a05:6214:519c:b0:8cc:dddb:eeaf with SMTP id
 6a1803df08f44-8db5e05541cmr28831736d6.40.1781654384717; 
 Tue, 16 Jun 2026 16:59:44 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f132178csm50191986d6.7.2026.06.16.16.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:59:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/5] hw/riscv: more FDT cleanups (PLIC)
Date: Tue, 16 Jun 2026 20:59:34 -0300
Message-ID: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ROowGvVUlUGmNuR5i3NBal1Nfs6UBK-j
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a31e372 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cNeE1kvHBGX1SwQoTBgA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: ROowGvVUlUGmNuR5i3NBal1Nfs6UBK-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfXyF8P+20vJJ5U
 u9nKjyR95aYebZKBP3IDLLLWdBdLHIxohN3ZwEFeqmELLiXb6+khENhENOgtJ/EMYF76kbg8sOk
 Omb0RBr32XiWlos0a2xT4P4LKgYsaEsDkZXQPJSLKYsHA3seZT/v/7B5qEsk8v5DZyjhkThf3K3
 y37QAk2tYLGsbK6S/XcTxhI1SOTrpavz5GErbTiXUbIkEfQ8P4mdOHE82tkNGHvOZm15fEn22Ja
 GRNPk38l59tWOcLX/0+W0GnSytyrsfVn8ddU+zp9s6kcRDwhuilDBnXecDzjlnbZMFEO38uQIft
 BqWj/Q/j52jiMlvqm71GfSDWuXCaFKXdI6z6wEkF9U6j4DQIOAV2ylckDkjZtrtCMyY8/jvcnv6
 5sK96HubcEDN5uCECYonxq+0/0pRipbN7wOxuG6EuOBu6RiWJr7KQ63REa6jISfbRqdQcI1f26I
 laaCDVQzobYN+rNkgQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX07040SoKHFCe
 TOdqE9DBci63Tb7RgKqpAzh78g+FZM3tVfV0Q8aGUIu09RRa9FzBXhi8aiGyO7VL46JsLPozJA8
 ev7Elp5Awy7gn1ciNAuvUMLyTR2ubNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606160242
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

Hello,

Here is the follow-up I talked about in the first FDT series that was
just merged [1].  This short series handles just the PLIC controller
FDT.  This time there are 2 FDT bug fixes in the mix (patches 3 and 4)
that we were lucky to find.

Expected changes after this series are related to patches 3 and 4 only:

 $ diff virt.dts virt_patch.dts
 189c189
 <               rng-seed = (...) 
 ---
 >               rng-seed = (...) 
 285c285
 <               plic@c000000 {
 ---
 >               interrupt-controller@c000000 {
 297c297
 <               plic@c600000 {
 ---
 >               interrupt-controller@c600000 {

$ diff sifive.dts sifive_patch.dts
 >                       #address-cells = <0x00>;


Patches based on master.

[1] https://lore.kernel.org/qemu-devel/20260615203734.954428-1-daniel.barboza@oss.qualcomm.com/


Daniel Henrique Barboza (5):
  hw/riscv/sifive_u.c: remove unneeded qemu_fdt_get_phandle() call
  hw/riscv/sifive_u.c: use intc_phandle in plic creation
  hw/riscv/sifive_u: add #address-cells in PLIC FDT
  hw/riscv/virt.c: change 'plic' nodename to 'interrupt-controller'
  hw/riscv: add create_fdt_plic() helper

 hw/riscv/fdt-common.c         | 30 +++++++++++++++++++++
 hw/riscv/sifive_u.c           | 42 +++++++++--------------------
 hw/riscv/virt.c               | 51 ++++++++++++-----------------------
 include/hw/riscv/fdt-common.h |  5 ++++
 include/hw/riscv/sifive_u.h   |  2 ++
 5 files changed, 67 insertions(+), 63 deletions(-)

-- 
2.43.0


