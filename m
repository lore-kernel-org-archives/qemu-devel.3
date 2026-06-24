Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8225CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8q-0007N1-2r; Tue, 23 Jun 2026 20:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8m-0007M7-Q0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8j-0003AD-Ln
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0vve1177559
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4TfHkAcssF0NJF9dyAvoTDljZN9CfROAV6iKH47t60M=; b=nQZHXV7QVEJx+4bT
 Ckf6lZkVt/mo1YaL12iFxJQJsc6LcGlTO5VSy7GSMc8hTFmRmNhpYiGlw+lv8Vy8
 fqIoP6aMZysCY8aK7REbmx4ujdk+AIkUryLk2j5BNqsKo9hcJLku6zTi0gindSOH
 KynPrH13t5Gl5uIBfCByU1Qe+8kIk0DDBwrsosPhh5GW3fw7hqi+fggOLywVMQOL
 ncjb6KDbEWZ5qz4Dg74g2RkkwY7e1ANx0DwCIqjhsuZc3JmOq480hUS9dTZJ/vZU
 cbxro7wjXq3RZ+z+vVrQAHtztxRKlzRiyxUkZyY/ahGGtKIdNEBvxIQVruGrgTTA
 eK4Yug==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe6bd83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8db8b467f13so10534646d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259607; x=1782864407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TfHkAcssF0NJF9dyAvoTDljZN9CfROAV6iKH47t60M=;
 b=IgyWZf2GfwDN9/P3RkD7RHekH3A9sBRLfx/dy8flf1UzcMGKbS8rk526AwzM6TsBgd
 QfH4W/nadVTsnXRni2F9RrHOOtIjH75mjDC79W9BZK8SIJqKA7c6wf0Vomu/twuuanHV
 mUhubzBixB1+exv6ENBw3Bn0AMWuGDhtwYRF72PlebCeDPG6OMiQJNF3OoSiAfAC7aiQ
 0plIin+UbXdqM1JMQ+ZxZbafwxW7J0MXCJkbT7R2QaIM/ha5E1mfFItbPdHUGDhXB5zu
 9Qdttt/sNZ0idKaRbRv0eS0YHN8Ow9hdSVJb5CS4H8GDFB0ujD5woI6dqJz4S2J4HwWS
 OyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259607; x=1782864407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TfHkAcssF0NJF9dyAvoTDljZN9CfROAV6iKH47t60M=;
 b=LC5NyS9bf0AQ8WDLnYqunLkWU83P8O4oIG6Z2EdgnaAMaa2tIjKFv0kdFKetZdG0bP
 akDrm7/ZGPtRFzPVsvPZ0qI+ZJzHe9detzmSv7OX6UkhWFOXLNqD7tkhTabJN1/i2e2E
 R1tWSXo4rDeGwy5muVqBot3LYrILRmdhn6Akfb3uKOJjrFD8eTjPYCfoIhO8S0oTY/q3
 muqe4m6/x08fOWtUPgcwGmxn+fk/DwGrtdeZvdEo3brxlgM/lBWZ0e7CMEimGgTGcCef
 b8rvmuya2rf3BGY59daXqGYeJ3EI7DTExiH8IxgmPxvor9feNo7CLrSxICtdkq1p/RJ7
 9juA==
X-Gm-Message-State: AOJu0Yxn7OC1MZuOlW3AtLfELH1syB/f5GCjWdvV51Y6OYgmJBbdS2Pb
 HAeXcuv40/h/c/fli3maxQKFXAreGyVzRRZMT1raRcs7eOgCNkC1gL7H9xxneaQk2YLEQbxhPRL
 /YKdXAkktFxieAOyU+Rt3q2Um7If2ouN6utfC6+A5dQuniTAxTcIPx0wrf0Vs8a/x+w==
X-Gm-Gg: AfdE7ckLCkIAO/PBe4+s3Xu7/zrJngzRIkOAyPRQyYlHtLSpKrP+rG7KdUblUKH7uA4
 NxuSsfoYeUbWX4OKo10uLIkLFANHfseT8/meuWhrwVLAIdg1OqGlztfGPw8ptVeQi/GEwViizdw
 zRCobvAEHxOHzzxOo+e1rryJPgS9dXm6AFxq3tqMAl1bjCwUyk4xl7kpVtF3SjiC2g6RG3BkYuY
 5qwUd+KhjiWvAuqCHsO7zfzhoEd1mfB/46oJqtDMxrROFCc1m6Y6YFE0Vip8TxM+GYoewBxCEMu
 m3I29+vxpuWVhvMVeLcLLHjUrzkEPcJsSyWKYlq2NaOZ2Vq16HR+KtH375I+suueT2IRxcSj/6A
 4TUDlWQr+cAG65+JeM5dNECethKvinOZZEKUOzdognea6dw==
X-Received: by 2002:a05:6214:4803:b0:8de:ca40:c3b5 with SMTP id
 6a1803df08f44-8e535b0b8eamr24192126d6.31.1782259606526; 
 Tue, 23 Jun 2026 17:06:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4803:b0:8de:ca40:c3b5 with SMTP id
 6a1803df08f44-8e535b0b8eamr24191206d6.31.1782259605805; 
 Tue, 23 Jun 2026 17:06:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 02/24] target/riscv: move TCG only files to tcg subdir
Date: Tue, 23 Jun 2026 21:06:09 -0300
Message-ID: <20260624000632.2149359-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4CE15BwovwYecmVkmSy63HrYDNJAGlZT
X-Proofpoint-ORIG-GUID: 4CE15BwovwYecmVkmSy63HrYDNJAGlZT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX9M5JllinGyU4
 mnrdOWbNw9OxMmpmm5UUj6kg5GXs1UVk4K8Y/CPNTvcnCn2CiKMEAo/osfucJRUYNfF5is8b7gv
 HkmS6e4NncYWlaV0RIWeehGsKF6Jzsg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX5GhJloi4Gu5M
 xMKPMX77q/MyNNhYwPlFrX2TJesuxcCzAHWsQig+q3h7VeHkN4Cy1hCBFa/5HZj1zQYaUkh/48q
 hGrBoy35XcUyDgkrmuyfWDExjxa8FKJ6tllmk9I3yiq99ybqY0CSsAcDUh4OpWlBpqXNEHEX9hW
 2V1CH3b8L+LOakP3/NggK5ziB4Mp6HziiCuxpuMmV6Al3c2zKVnEqBkRU64Lo63vxg/qwTALB9e
 f81OHRhXmMveQ0tq4A9+f0IyQdCK43dexP3Hypi+KKnk4xbI4igbMflluSlqQq3+sUhbZzEiNdL
 DYWmAUzOfv+UiDgGscltxWVccgCkKTEcnoYtoQWE2gu+L1sJeOLkbDC+FWwPew57Gf34jSEH8kG
 khgUCNfZa69AE7SduwUr38Vkf/r7nw==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3b1f97 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dWVhGV5Cy5NFuyiy0EoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230199
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


