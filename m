Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B41CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIq4-0004O4-Pt; Wed, 27 May 2026 14:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIpt-0004Ho-IB
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:18:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSIpp-0002aN-MG
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:18:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RHtdxd1575126
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=za1xWTehmTdHA7cTPL9gEx0Y53xCHo797Wk
 RogY0dh8=; b=lAWsiOj9sufRdcN4vCd6M2UUabRm4jveUFNSGo0aXxYSCxDc6gB
 kJU/IkwYEQp8s5BVFp1AQAs3j+Y8VSwViX2Msrgk8ukNxon2EmvksQF9V65BdOac
 qur1L7ElFVj5U8cnUCJQ1rt30DKqUrmWfGsbgpFYmd2gxG9obrikVteeLF0CkKO6
 Zm8ksAbkve2q25IFko3YOK/L934Z1odptZSI2rwEzoNxkXSRN+UdI9XJnadfILXT
 Yi/igMuYZnlSdKEjy07ltw3VoNH/OcdmJLUNSchr5LKJNxI+OnrlMxweBK1I5eKI
 XxXg4XPMTLzGxL/SDwI5wdzuEpO2XjoYwrg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxvphswb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 18:18:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b7105dfb5eso77437536d6.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779905907; x=1780510707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=za1xWTehmTdHA7cTPL9gEx0Y53xCHo797WkRogY0dh8=;
 b=RKs5BMX381vH8qfHJ/03dadLxnnzJj1iXTwhh7iwFF/CAB+01/bN+29t0vB4JjbDeU
 Zh0PAoWs6RT4GZtdke5CVqICI76VubGzfeQd6cdFoJEnmq11+Aj/5d/AMck8y5vwNnC2
 lwmsitP9CkgwKOHzS/FrrouaMRipuj1DiSD82NE8pqQGktYrM9c47WnAKGl+uhtl7K7b
 MKWVyxjLTdCs0pjmErsBY8XYvXiRDDolGGiQwbthtdLAqGhq+waD050gr0Da8GWHiyQ8
 Ot1jwihgVmnYqlQPMFYsWSa2HbfujtBQql1MJN+Paj921cfah/mpSG8B5u/66L/AR7Sc
 /FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779905907; x=1780510707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za1xWTehmTdHA7cTPL9gEx0Y53xCHo797WkRogY0dh8=;
 b=QA+XM7fNEH+toyVDICfFlTD8uK10CfEQ6dUf1NDsqnEEvBoYvqlBJjnEso7nyFM8ai
 SAnuROP0FZV4APGi9Cs67DRPlr5CvNGNM87RtcD84vcugvOE+Dk2fCmDl54IN/aaM0SL
 5LLEy0txQsdT4cSZtC+zLGJPY2edz7+6ezAlNlRJIcQf+Qga0LeAutsSGB7RZz01IjPl
 1jKPg8ohmOJ8+4LqOUrYVLfUMFmgfT1yaszFCkDbALxDnR44S6zSFBCAPIpIPXovdkxS
 odrsbB3rNH0Cw1CfggjIr3DF/k957rg/iZ/eDheM7q1roxHGY+yIByYXo9h83kQbBTmV
 Y6Lg==
X-Gm-Message-State: AOJu0YxtG0YnIGTZDajG+LbgCkNOFpetmm3Bvj/AI5bA+IUEeF1/DA6V
 EuM2a8IZpRXdTyITQMNfqEQplYJe10xZg5fqsIi2jkW2YIWq/BXYa5MIqQPtLLy5almgUib0TYv
 DaMqG2Dwg2dyodHL52MhkPLr858IJndW3Ps44rCEVc9UFApqIKCzXxSEz8YdA/HxzIQ==
X-Gm-Gg: Acq92OF78p7S2Jl9pBQPnUyrGE60nWSCu5XxJUBB9iDhI+fkOseWaFTqvBq+rfgK3Of
 X4uSfGlytR+M6m5TgvFC9N9RdKJRhMUWK81KmZE5JoHDBt1SoX/QVp8Cd/wRAS1WTLGumewyTeo
 Gqvo5GHL+gNSus2c41/fG/cpuUkwqPVrxkMh7sXRmcSwAEYxhZjdt1jjAJ5kxueQYPteCh2FAhp
 yRlPtEqIrATgjRYgO2Sqt4SGqpuWwNtt+YzdcciNY3j/O9Z1rIHqMvdltKdhn2o04DWUCzTr6xV
 TIDJoIM/cpolpxy0g5ndhzrv31wtvoVZaOMUd80bDB9B86fk2jYCYOeyMHBeNdYSnLnLTlISwEg
 JbHqy+JtB9PgxudHVS71WuBfdpoJIZ7aPG1/vny1WPdECNO/xYcL5egfM6QmLOk+GFJ7Q5A==
X-Received: by 2002:a05:6214:3bc7:b0:8cc:15e4:1208 with SMTP id
 6a1803df08f44-8cc7b65aa0dmr391512426d6.32.1779905907231; 
 Wed, 27 May 2026 11:18:27 -0700 (PDT)
X-Received: by 2002:a05:6214:3bc7:b0:8cc:15e4:1208 with SMTP id
 6a1803df08f44-8cc7b65aa0dmr391511926d6.32.1779905906818; 
 Wed, 27 May 2026 11:18:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80df081asm174454426d6.18.2026.05.27.11.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 11:18:26 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv: deprecate 'debug' CPU property
Date: Wed, 27 May 2026 15:18:21 -0300
Message-ID: <20260527181822.1945644-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MyBTYWx0ZWRfX1qwqKzLtXHXS
 mre4z3MQDCTrp1F3YthqF3chuXU8EA4HKhoS8iyqG4jqKBDyz1huO6GSU/ktFYHm4Ewemx3YeQu
 sKbL14oy/UwAqyk0KcuLbZy8eBTZwJ6v6MxFytGwNxqPazwxgGltQjK87PgAQ3AC3tgo/2V8/La
 0q2ch+XvGJSn6514FGXM8MWTgOWirKqsHWdarFLspUOynVDMFN2SjsGC42KI/NUrDwyJiFI9lGj
 Jvz6oN44vDm9ZKeuBTPgyjRJE2MXYRvbz6hTnkJwTxiHytEzHAKQoRE46IPEhkX3QDGDrpnAhCl
 KhOa2t3/CaYBqunYmFlJa0FUDmRRybispXUpGeUk/yz6YuwM9jkpES/pK1kEL4cmSrhHqi214VO
 FKc0zbuvtNcVP/qGU5GpqPT/iyEAaNLXOyWGQWR/MsU0MRernsxIKcyjdVli70YHG9wGKWKYxTo
 5OtqV09sbOKRfsPa6DA==
X-Proofpoint-GUID: Pgre763GlpMeal13KVCt_IHlRIbxrGqN
X-Proofpoint-ORIG-GUID: Pgre763GlpMeal13KVCt_IHlRIbxrGqN
X-Authority-Analysis: v=2.4 cv=VqoTxe2n c=1 sm=1 tr=0 ts=6a173573 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gcUx_8-XaRmPhs3KbAgA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This is a re-send to rebase the patch with the recent trunk changes.

And, adding to the previous discussion we had about it in [1]: I believe
we should deprecate the 'debug' flag and leave this ambiguous 'Debug'
support we have in QEMU behind.


Patches based on alistair/riscv-to-apply.next.

Changes from v1:
- rebased to a more recent trunk;
- added R-b tags made from the 'sdext' series reviews;
- v1 link: https://lore.kernel.org/qemu-devel/20260119175900.249835-1-daniel.barboza@oss.qualcomm.com/

[1] https://lore.kernel.org/qemu-devel/e4b61f26-c0ce-4017-9b6c-cdb8b679d2c0@oss.qualcomm.com/

Daniel Henrique Barboza (1):
  target/riscv: deprecate 'debug' CPU property

 docs/about/deprecated.rst         |  6 ++++
 target/riscv/cpu.c                | 50 ++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 +-
 target/riscv/csr.c                |  2 +-
 target/riscv/machine.c            | 24 +++++++--------
 target/riscv/tcg/tcg-cpu.c        |  2 +-
 6 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.43.0


