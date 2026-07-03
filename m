Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E8FC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiH4-0001IM-QI; Fri, 03 Jul 2026 14:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiH2-0001Ha-J0
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGz-00027E-Uw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiU13675109
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K8lsPPKzzJwd0y/OCGlzb8lCS44FcRpZbXEsejG/prw=; b=V4VGVc4iiX/RKl0X
 F/SipalqrXVbsbGx3SxkqBRUFm/xiB+9eUvSKplfn5tgr8eK1fc1tkmbYrH8D3yU
 MVNE+MJECHgW+DMOgisnJi0c5XRtsGjx6CNQ8DhjD157d/Ic9NIJy+6kf2P+tQ9b
 Malua6igVk+aOzt63Es35EJKXw0gIK5b1zCNc3T6CmjOoE+isfOg4LD2sBqgLHZ6
 Nc0ZkfOHgLNI8GLfvL0xS2mOJJGLzIm5ly3Ag2iYW3/lEfDkbj72fYyEK/tMn6sT
 2Lhi7CVMFRNaogJK151rq66Xzaff6ZE4/+4HJ+93rHXvZNN6cOZZiSZlKddD95Vo
 QDYxHw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj18db-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:05:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ee2847cbd4so8212386d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101956; x=1783706756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8lsPPKzzJwd0y/OCGlzb8lCS44FcRpZbXEsejG/prw=;
 b=eh7k6QZ+KnP+6fnhpmgJQJR0qgTv8L/TaHOUcmI3Ukf3VRVW6YpNnh2fxQ0El672yq
 +H6qn/WQdtbPcZirRjIGJUDQZjYEjXj7WRjnj6EKyRbPyt0NzCqR036wnnCWvXvbCewm
 xg8Q+l4M39AxTKidpT4IQLS1q5sDP3MKzYTkUdDT8lfauHHC2kLfgkFocwhqiLK+NRdj
 +twvNlZoLfMdkh2f0F6jkt0GkodzqI2IT9aAOwc8twYbbUG53XCUtfcsV7/QjoLmm02B
 dxIJzGQkNXVh3vTMVTubHxXks9dP7oskvsojxHiBwx3q485ai1PDKiURd2lublOrAfRf
 +gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101956; x=1783706756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8lsPPKzzJwd0y/OCGlzb8lCS44FcRpZbXEsejG/prw=;
 b=P05lo73xbtSPt3JB4hIL/NXLxOmurMHbszkcbffzZL3+u250AO8+96KGVUdEc41EO/
 n6WWk1canBWwUpt91lUX2PAonsK+rvZCIDCpV0sswkKJb3vSZChhf2UkmG2qW0ps6GEP
 4jQVFDOLNphbfDLVv0KbtP45Udt9WBOXuK/+6zQG3YKqKzqsbTP6e+Yj1AtYG43coGgn
 F/24O9pu3JHvoV6yENgO+nLtv5uvHI0Y5Fk91mYrMivMx6HXoyQKkOpU4nOVMiTpTffR
 UUVq28wc+nrM1TBMuhBt3IYyHd1CNXuupJOghx/8WunaCivsVW7o/D9Z4zXWmHIbA031
 XFMQ==
X-Gm-Message-State: AOJu0YygyWWuAkeo3NtA9ueXFsD95uI2b0RrrqDDuPcL6ggYmREEB20Z
 ogRC58ELalBSqRD68Gu6XXHdX+elXP1IIs6F6cbTLuBgY+bUZv3Wcd+NSL2QojZDHk6HIvfetOL
 MiZkQX5WaWC4d3uyPnWFaLchQqsUsp2qS3HFDGVtHaU9wFbnPV7MuDoPqzxWM4rTXew==
X-Gm-Gg: AfdE7clSHMdA2Af6n+zmyrClR0SL8lAsWUstC1qikqwwsykpl4dCwgSrL0cPbZV8f3a
 VAzv98IrDPOqK1blwsVogztSL4QGkVvT125IZq8kFmx69JD0pSZOow832x19Hn6AeGjIbhnrVJp
 TtqPoIS6VK1B9+GBXVl7kp46XI1xOKCr+DsqrPbE7SgS0jlNZLXJIo+uEbPeTIZEO37BhxJgJr9
 6/+cBsAjWi5ojsNwcgbTfZmyVNCQnrna09wLfBeqP/m0hu7VHt9PFfezH3ZtHupZWBV6/2YQy2d
 4otn/jJSeaF+2g3AEERT7nmhuYbQCVQvFKGWcXvMmvskhX5NkQMmr8h4NmsE/krs1qJAx6TPsHU
 h2SCrLl9vQsLq0mq3jDYROAM/VUyeaVrKcPVATVkTLJ+nIw==
X-Received: by 2002:ac8:5e4d:0:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51c4c2ef12fmr8272051cf.48.1783101956196; 
 Fri, 03 Jul 2026 11:05:56 -0700 (PDT)
X-Received: by 2002:ac8:5e4d:0:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-51c4c2ef12fmr8271371cf.48.1783101955601; 
 Fri, 03 Jul 2026 11:05:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:54 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 04/24] target/riscv: move TCG only files to tcg subdir
Date: Fri,  3 Jul 2026 15:05:16 -0300
Message-ID: <20260703180538.3346781-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX6nEoKJEOVK41
 gLyowhA2iUSIMT+zS1v1SQen0i2vwI8xu9my35+JvuwQpg5b5RJg+iHpjY6NC8ysoHUWolNGq6Q
 hc8lLVWV9ZdmuuDbivnbQPZLOMoOhdc=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47fa04 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=aHvWL8eUnyL-D0AylNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: gP2RlvWAlG4PCgtLMO2gdFK1auTTZ257
X-Proofpoint-GUID: gP2RlvWAlG4PCgtLMO2gdFK1auTTZ257
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX7tXCLbMsl0Wi
 nuQ611COOwyMLnf4A1TgZXkfE/76/QI3aILNfbjEtIUK9OcnuWrMy9FA5Kt9/90lB5IikPCfjlQ
 kbdB8Z2akny7jFH5pRxxG+Nay6FTehci4USVn7IDgXKcWjeIR5Joi7zRCfg+RIyvb+ucALeSJXj
 bE4R3IFFGOuRYsYQ2pBpqmC0kGXUMdRe9mJjbDKJ7OmCYhJRLhVujUNyapy0l84mu1SD2MCGfyr
 hThakWSLQSbqajGlZXf+l4KLGvFpJVcacg+lhRhM5zqXk2IxtoOvDWIPKrzYLqLQWFASCnW9j3k
 QTdV8Lsj0TcYQxBabBxriRd2MpSTNIGvVfwtrCt02V2NlQOSO8V8uTzVmUep7yumqlDcHHFW2Os
 isG21nIMzBu4M6OuMFSqL4CZy4fwk662XXU+mQU3CwnClR134jFsBCFc4S2nAAxEw5PzTFENibj
 G06EsTwjMhRNHdL80+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
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
 target/riscv/{ => tcg}/pmu.h                  |  0
 target/riscv/{ => tcg}/th_csr.c               |  0
 target/riscv/{ => tcg}/translate.c            |  0
 target/riscv/{ => tcg}/vcrypto_helper.c       |  0
 target/riscv/{ => tcg}/vector_helper.c        |  0
 target/riscv/{ => tcg}/vector_internals.c     |  0
 target/riscv/{ => tcg}/vector_internals.h     |  0
 target/riscv/{ => tcg}/zce_helper.c           |  0
 50 files changed, 28 insertions(+), 18 deletions(-)
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
 rename target/riscv/{ => tcg}/pmu.h (100%)
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
diff --git a/target/riscv/pmu.h b/target/riscv/tcg/pmu.h
similarity index 100%
rename from target/riscv/pmu.h
rename to target/riscv/tcg/pmu.h
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


