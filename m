Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0921C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpS-0001aG-6u; Thu, 02 Jul 2026 09:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpR-0001Zc-7d
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpO-0007y2-HD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0WEa518216
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dwNElXqi7zyKfAuUtXo9PxnySkGtUNnJixEe4+fNdW0=; b=KeZRg5OsKV89AoNt
 Kkd9ECzrTRc0xu1W7wEzx/zDPBgHnYSWTPX+jm9RvGaKzJUyLVCl98/0r7YgPXD1
 5pQkvDdr1Cf2GYYz/SS99+dkvtO04Wpfc/OF1kLJKnplQ300teNOomr3uUgdkzAI
 PjgYILv85TeFX81LMNLkiAEcEsOk/ZKhe0OCeLfYcMKY5e26fQaSZM8WBbLvafX0
 rqkoKgwIEv1I3r/83v22gNcfZVt0VzbEH+ZyHv3diN8nAB6+m5XOBIua3jv/WzBD
 8ZQ/1sgtf4OqE+enYChbaTuY7wPHnq8+OtgCkCqO2mhE4WK7Qi0s8VVyyz0cv9Vq
 grWMhA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc0fmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-737d2f02d2fso1841671137.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000300; x=1783605100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dwNElXqi7zyKfAuUtXo9PxnySkGtUNnJixEe4+fNdW0=;
 b=Sa86WrOwcjMkvweYzbs7xdyfgN08bBjsusi71gvmW4lxA+ML7tqG2bdrGrbwrcKOxO
 FcKnD0L4RktXRxtSjFSvFX6vPCMtEQZ73NvzCzxDNg/avH8k9G4kb1q1i3eFP2fmwoKq
 NR951xLhZR7+Zn5e5Puej0P27EjxMnMj8HscbPvRohCUE6AndvJ9qNFfQgGb6ehPMvKG
 sySKgOarXBC8JjAFmyiU1BLbmiUxak1SC9P4CJULlKSsAFnYMyoCgUFponUt2gWlqvU0
 VU9ThadMbegh3lG+uT58dtzTcn6EmbQSayhqtlgw7DBAQrWUEcHMnLqNywkIp/jRarVR
 sZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000300; x=1783605100;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dwNElXqi7zyKfAuUtXo9PxnySkGtUNnJixEe4+fNdW0=;
 b=iYn8WklixEk9BJyx50+jLeBXHCgxLUjJYEURn5LJeRBPmn48fSKiIWIRfWP2Jx0IMD
 EClbPOB/3xfMxq46Lc2BABGknDp4abaQ4ZN+YojlrChkghDM7wfZJAfNIpf2ry3+3P/l
 9VXhKlveDp3iGBC2Yg6oXIn1dSbe0ORpOm8y7m5lD15inSQyZkoj9ywyDcK3QBXQMwku
 g8m757JuAaAUnLKNZlD2E2DZGCECN8LIHalSVZfBBkhJlslT+4JMUzq0ThlyWk6klfQp
 RkqO6guTM8fgfly2vv9HstRFiVm3bAlTsyeNE1Tw22V+vX9AVitrPI78SI/6EnfFds69
 5iGQ==
X-Gm-Message-State: AOJu0Yx9sKISaky6NF/J8SnpYIGWw15P5CsU4vuQJ0mTupLr8IfKHDzm
 LzWnl1jEeCZBc1w5l2ancLHz5gGNIbrqo6ShVVXKoI/AzWy76V3u4QHlBu0BUGo+A/UQTv21EyP
 l+0QAbk++zeWdJkGm+IQs0QXnwAYv6bje1FMbYfRilPRcgbyCRfLo1jeZ3mff/cexOw==
X-Gm-Gg: AfdE7ckM3bEW47IHZaBfLojWU8PGpRqbvpPOfCoW2ulr4PTe4cbiHMeD7i6zmChn6lg
 svJhxuNZR0oYLTvpMqLLK2kRmpoyEiJUycFs0KdyUQC5ahqsx7TG6n5m35Bst/DSlE8G8+cs9MQ
 gsKYk0s6wQjwtVOdG590RyEwUFO6eKAJEbto/egH85EsLnABUYIvB0lqf+w8mSctAcqhZQBz5J7
 frAUm1Iw/4IjVM5yKKP1vub/Z64NC0tJexMUQCjixmsawJY3gHATH/Wre4bDDz5gY6ehJJdBIgt
 NOiVqtHdy5xISkjBF14FyhFpoe66YMLWtkVBdt4XbPQReDOBFh3yjd4qMGX/yng0fYhEZEDyI/G
 m0DaqcaMdQEvy/BWu1GFGIZn04aK0cgl/F8wahqY0raIivQ==
X-Received: by 2002:a05:6102:808f:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-73dbfca5c7cmr2698487137.22.1783000299715; 
 Thu, 02 Jul 2026 06:51:39 -0700 (PDT)
X-Received: by 2002:a05:6102:808f:b0:727:fb8:f269 with SMTP id
 ada2fe7eead31-73dbfca5c7cmr2698478137.22.1783000299214; 
 Thu, 02 Jul 2026 06:51:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:38 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 02/24] target/riscv: move TCG only files to tcg subdir
Date: Thu,  2 Jul 2026 10:51:04 -0300
Message-ID: <20260702135128.1188021-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j0GqOczCmkUb9hMzSIYr9KvaPF9UCIkX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX8jM9kvht7QUZ
 e4aN5lsSACrkz8V0TvqRbDwWaIP+sQUtwDSJCD5VsUCnFMZEoaheWvJW55NlAq53XKTVAHgtS4y
 0gt7FB5QbMWBAskp1rNcDn3kJt+3oh79cZwubMKE2aHwNsXor9d4L/C5A2mfiZZvWUC59wqwD8f
 lU7hAdHzKq0Nq6KN3aYr46PiBpUL0LjBXNqegDF4MLvn8wNjdQy/Ytp0OjOGh3Affy/wMPqztMT
 vhSa26xcoFiERjUaRfD6mIF77t1AV55S/zp2RzZ8ykK2xGJC63o+X6NcZ9w7llgq6y7ELQ2VGmN
 /7KGJdewk1Nf3bmZkbN1BSvwZgtXOSuQy247ckt/mzr/py83cuPWj5APmfw7eblN8sQyqcLARPZ
 ZBmGQwYUqsi/UjSm2uDUv+bUn8muTfm/+mCTOGTt5xA5LDq55WqDO5B+mLmp6zXlsYCpsXz9wRi
 SSDekFvAq4H9VfFd4oA==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a466ced cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=dWVhGV5Cy5NFuyiy0EoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: j0GqOczCmkUb9hMzSIYr9KvaPF9UCIkX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX3IxbVuQSp2Ds
 wmtatFNh+S/xK3OGUoDbRUvq+ZHP+yGei10qwAt+AoVjPKA7x/C8U5yy6VE6y4EpfVH7EFPl8fX
 qzjbMrICKjQEIX+xq2riWvyRR0tN3MM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have *way* too much TCG-only code hanging around in target/riscv,
where ideally we would have things that are shared between accelerators.

We'll follow the example of other targets like i386 and loongarch and
move everything to the tcg subir.  This will not only cleanup target/riscv
but it will also expose what is common code but it's buried inside a TCG
helper.

We're leaving some stuff behind because these require a little more
case to not end up breaking KVM.  We'll take care of them next.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/meson.build                      | 16 ----------
 target/riscv/{ => tcg}/bitmanip_helper.c      |  0
 target/riscv/{ => tcg}/cpu_helper.c           |  0
 target/riscv/{ => tcg}/crypto_helper.c        |  0
 target/riscv/{ => tcg}/csr.c                  |  0
 target/riscv/{ => tcg}/debug.c                |  0
 target/riscv/{ => tcg}/fpu_helper.c           |  0
 .../insn_trans/trans_privileged.c.inc         |  0
 .../{ => tcg}/insn_trans/trans_rva.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvb.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |  0
 .../{ => tcg}/insn_trans/trans_rvd.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvf.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvh.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvi.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvk.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvm.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvv.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |  0
 .../insn_trans/trans_rvzicfiss.c.inc          |  0
 .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_svinval.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xmips.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xthead.c.inc   |  0
 .../insn_trans/trans_xventanacondops.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |  0
 target/riscv/{ => tcg}/m128_helper.c          |  0
 target/riscv/tcg/meson.build                  | 30 +++++++++++++++++--
 target/riscv/{ => tcg}/mips_csr.c             |  0
 target/riscv/{ => tcg}/op_helper.c            |  0
 target/riscv/{ => tcg}/pmu.c                  |  0
 target/riscv/{ => tcg}/th_csr.c               |  0
 target/riscv/{ => tcg}/translate.c            |  0
 target/riscv/{ => tcg}/vcrypto_helper.c       |  0
 target/riscv/{ => tcg}/vector_helper.c        |  0
 target/riscv/{ => tcg}/vector_internals.c     |  0
 target/riscv/{ => tcg}/vector_internals.h     |  0
 target/riscv/{ => tcg}/zce_helper.c           |  0
 49 files changed, 28 insertions(+), 18 deletions(-)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (100%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/csr.c (100%)
 rename target/riscv/{ => tcg}/debug.c (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/mips_csr.c (100%)
 rename target/riscv/{ => tcg}/op_helper.c (100%)
 rename target/riscv/{ => tcg}/pmu.c (100%)
 rename target/riscv/{ => tcg}/th_csr.c (100%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..61874ed0af 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -16,31 +16,15 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 
 riscv_ss.add(files(
   'cpu.c',
-  'cpu_helper.c',
-  'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
-  'op_helper.c',
-  'vector_helper.c',
-  'vector_internals.c',
-  'bitmanip_helper.c',
-  'translate.c',
-  'm128_helper.c',
-  'crypto_helper.c',
-  'zce_helper.c',
-  'vcrypto_helper.c'
 ))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
   'pmp.c',
-  'debug.c',
   'monitor.c',
   'machine.c',
-  'mips_csr.c',
-  'pmu.c',
-  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
similarity index 100%
rename from target/riscv/bitmanip_helper.c
rename to target/riscv/tcg/bitmanip_helper.c
diff --git a/target/riscv/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
similarity index 100%
rename from target/riscv/cpu_helper.c
rename to target/riscv/tcg/cpu_helper.c
diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helper.c
similarity index 100%
rename from target/riscv/crypto_helper.c
rename to target/riscv/tcg/crypto_helper.c
diff --git a/target/riscv/csr.c b/target/riscv/tcg/csr.c
similarity index 100%
rename from target/riscv/csr.c
rename to target/riscv/tcg/csr.c
diff --git a/target/riscv/debug.c b/target/riscv/tcg/debug.c
similarity index 100%
rename from target/riscv/debug.c
rename to target/riscv/tcg/debug.c
diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
similarity index 100%
rename from target/riscv/fpu_helper.c
rename to target/riscv/tcg/fpu_helper.c
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_privileged.c.inc
rename to target/riscv/tcg/insn_trans/trans_privileged.c.inc
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rva.c.inc
rename to target/riscv/tcg/insn_trans/trans_rva.c.inc
diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvb.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvb.c.inc
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvbf16.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvd.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvd.c.inc
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvf.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvf.c.inc
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/tcg/insn_trans/trans_rvh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvi.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvi.c.inc
diff --git a/target/riscv/insn_trans/trans_rvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/tcg/insn_trans/trans_rvm.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvm.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvm.c.inc
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvv.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvv.c.inc
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzabha.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzacas.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzalasr.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzawrs.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzce.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzce.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzcmop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfa.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicbo.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicfiss.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicond.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzimop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_svinval.c.inc
rename to target/riscv/tcg/insn_trans/trans_svinval.c.inc
diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xlrbr.c.inc
rename to target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xmips.c.inc
rename to target/riscv/tcg/insn_trans/trans_xmips.c.inc
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xthead.c.inc
rename to target/riscv/tcg/insn_trans/trans_xthead.c.inc
diff --git a/target/riscv/insn_trans/trans_xventanacondops.c.inc b/target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xventanacondops.c.inc
rename to target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/tcg/insn_trans/trans_zilsd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_zilsd.c.inc
rename to target/riscv/tcg/insn_trans/trans_zilsd.c.inc
diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
similarity index 100%
rename from target/riscv/m128_helper.c
rename to target/riscv/tcg/m128_helper.c
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 061df3d74a..5684fcf985 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -1,2 +1,28 @@
-riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'tcg-cpu.c'))
+if 'CONFIG_TCG' not in config_all_accel
+  subdir_done()
+endif
+
+riscv_ss.add(files(
+  'bitmanip_helper.c',
+ 'cpu_helper.c',
+  'csr.c',
+  'crypto_helper.c',
+  'fpu_helper.c',
+  'm128_helper.c',
+  'op_helper.c',
+  'translate.c',
+  'tcg-cpu.c',
+  'vcrypto_helper.c',
+  'vector_helper.c',
+  'vector_internals.c',
+  'zce_helper.c'))
+
+
+riscv_system_ss.add(files(
+  'debug.c',
+  'mips_csr.c',
+  'pmu.c',
+  'th_csr.c',
+))
+
+
diff --git a/target/riscv/mips_csr.c b/target/riscv/tcg/mips_csr.c
similarity index 100%
rename from target/riscv/mips_csr.c
rename to target/riscv/tcg/mips_csr.c
diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
similarity index 100%
rename from target/riscv/op_helper.c
rename to target/riscv/tcg/op_helper.c
diff --git a/target/riscv/pmu.c b/target/riscv/tcg/pmu.c
similarity index 100%
rename from target/riscv/pmu.c
rename to target/riscv/tcg/pmu.c
diff --git a/target/riscv/th_csr.c b/target/riscv/tcg/th_csr.c
similarity index 100%
rename from target/riscv/th_csr.c
rename to target/riscv/tcg/th_csr.c
diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
similarity index 100%
rename from target/riscv/translate.c
rename to target/riscv/tcg/translate.c
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/tcg/vcrypto_helper.c
similarity index 100%
rename from target/riscv/vcrypto_helper.c
rename to target/riscv/tcg/vcrypto_helper.c
diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helper.c
similarity index 100%
rename from target/riscv/vector_helper.c
rename to target/riscv/tcg/vector_helper.c
diff --git a/target/riscv/vector_internals.c b/target/riscv/tcg/vector_internals.c
similarity index 100%
rename from target/riscv/vector_internals.c
rename to target/riscv/tcg/vector_internals.c
diff --git a/target/riscv/vector_internals.h b/target/riscv/tcg/vector_internals.h
similarity index 100%
rename from target/riscv/vector_internals.h
rename to target/riscv/tcg/vector_internals.h
diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
similarity index 100%
rename from target/riscv/zce_helper.c
rename to target/riscv/tcg/zce_helper.c
-- 
2.43.0


