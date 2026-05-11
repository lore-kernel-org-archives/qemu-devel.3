Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E93ACD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhR-00012j-6A; Mon, 11 May 2026 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhJ-00010D-Kn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhF-0007R1-LJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD3qEF774897
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=w1L9lppb5agHia6+CmgPu6eCWyrxTcWp4KQ
 yY2JsBhE=; b=L8dz5o1L38Yxr1zFSAzR13HYoFp22PbOsXA2/7Fg2Ij6Vcllj5D
 ziPc9pKtON/bEbs2j+b+BqMoMC2JBMVFvs9ADXFK30+QxgIhkgtLpaQ6F/sI89MK
 WexIWSCL9TWCFsPg4zTVhnV/wRDFGGIpF3HVxuqkUfS4958zN0o+SHhBPZF7sdMH
 pGly59CT/bMaxyjZA7J8kZOLKEbTsEyqPHgHR67ZyuWLpV30WDjRAMFZH47MhZTQ
 h5nBnB9CwranYMzUeIrQyrMSH5LZmuRVXPWPsOJ6d07ZhK3LljJRpiBJy7d+SfEZ
 kVfBoQ+W6qNI7sRYQVnK2dAT0dzFCFL+pyQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32he3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8acb85a973cso52051006d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506156; x=1779110956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w1L9lppb5agHia6+CmgPu6eCWyrxTcWp4KQyY2JsBhE=;
 b=N4rXFLVz5rmkNPyNPUed/YUWZ9SIj4BRwV3g3CiUoyp0qQfGUBc7ckpfIL6r70zIbh
 ah7paw+XjihQKV1w7C8tAi3nEsjBjK2qB5kuTlnkWdqY+dcZJ7mGMiWKhL2/L2oUrJqB
 1/gdiYyiYcWMe7Qx6SiN7RqU7qhMJJh2ChoFtmFzxTSbmhIROH1YroBB795KcTbkOGoc
 5GpnJYcjlI4lgYXtomUZ64T03FMjASe2Iv2G1H6bDIsSxnGWUxCQ2FZ4DgVxY5EGgH7v
 2xmjMhOm7T5Y4jZLlc8OUeSs2nD3uYLBRI/FLHDSeoFDMzMepwiJChqgoSI39e6hwUqT
 4D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506156; x=1779110956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1L9lppb5agHia6+CmgPu6eCWyrxTcWp4KQyY2JsBhE=;
 b=C3DWimEMfCx4V4habh1hGM0dq3DvmvR50nAFI1ebK89G1gxpCQy7T+ilmZNdb/n1+a
 029nigUYotg8smgV7DoyC3JgJ/o56FK43N4DiRcfjYP3JXGXm675W5CkX5DLVYurrpKp
 E0KvAyt+0wKMVJzo3wvTXEkWxtzJhKeMWbENdMOGGlFVdnV80G8iK1YsSjr+XPq4yLjm
 HnyDcJF/7rwqRMRwjKVSF+v4zOxlLAQdXMEP9GF82S1oqzsFZsY6cvUwIF40HWZOkksg
 w5MR7QDJ0Gi3j8SZ2hKovmp7qLEJ9G0WYfVGwhwz8bHJmSlY6oazvw3VutvMbj6YHtp9
 ozKw==
X-Gm-Message-State: AOJu0Yx4ZvCPAImoLZR3TX3yLP26SYBPashL7ZFo/8y7t9mDuFrlBsgk
 XOgeBQnSw2+/67LfPcm+suN553ZNAdHw3tHgNvj2bhIbsaQ68RQ6zFk/q9WIQFaWQNGIOwYUlhX
 6FykUm1+Z7L1epsm1rK2fwzgXgvLJUDFmWtszhcbq3Ju3CvX8PF2ukTQoXSnsoFNnLw==
X-Gm-Gg: Acq92OGFYiaCAzjAY12cJY0PYMbkYqCftOdMEVugidM1ES5KyZu9o67JUDQifRMkzx5
 sAVU4/qBsQgBl5TWLqTS2oGIp3KP/E67tvekmJjKIcT7ZvpjMMrYVRKtvfJOPtFZdR1mGaDhI4c
 SGQ4vqDt2BCJFQgz/D4unAdS9/qRolx46wckmLRQfQGvO75uKOa+KLQY/BPOvkgB8RJuu9Rgg28
 BdD3YLuWQi1oKayK2UDRrlWAIIrJm/o8CmqN+Sz3qB3XJTdFfMsxAftyq0eSl0rhH95Lq7hpfwK
 TP9f+rCqc4KZ7KsBexu3zGr7ebrt4qLyKJIcLShSmDBDbE9OBozkj0aS0bD+PaTRuX1Y78P/1NR
 jxICXcX21VH42M7QUiIem+6ElrZDXK9gJJIEyjhMs4ZVsyYYDS+u6mAI2qeb3
X-Received: by 2002:a05:6214:767:b0:8ac:a6f7:8a72 with SMTP id
 6a1803df08f44-8bc4600fee2mr363966826d6.43.1778506155881; 
 Mon, 11 May 2026 06:29:15 -0700 (PDT)
X-Received: by 2002:a05:6214:767:b0:8ac:a6f7:8a72 with SMTP id
 6a1803df08f44-8bc4600fee2mr363966096d6.43.1778506155155; 
 Mon, 11 May 2026 06:29:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 00/13] target/riscv: remove riscv_cpu_* arrays
Date: Mon, 11 May 2026 10:28:57 -0300
Message-ID: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FnSPsZOxkg-JKseeKP0ObbxEcAnulRks
X-Proofpoint-GUID: FnSPsZOxkg-JKseeKP0ObbxEcAnulRks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfXykQMiHUOepBw
 huNyPMF7ZsYMMMqesD+qU1SUeHXCbLb4xPTv3+kqmTjsvu0hsYJtMac0JYYhfxnTaPMW1qtytt9
 vnKaywMdwR9mm9am7ahcpzwre/SsvH4lnUyUzGUTPHda160nPPzDhYkUt2rkiB0uo6OEBiW+dug
 ZNpQwErv8qHplcLpl5t5kIGdKgn8YZRtG6Fd8txmQaE5Pd0dtAnORwB6zoFYxdVO8427hLpAVUt
 4uG6y+/XmMKSHekqaDbDca0LxScnwAnBx28INouW1fsfsaSL3+wvA7hJD9AzAmnJBPKHzBqYk05
 uvfA+aS1satVQbw3V1aa7K54DxSBO/6M+frKk2lsm2wyZU4ljUU4XwaQBkwJEvAdjRP4KO4f7Ss
 TtGjnlNWpZ4OnqzBbAVVwqiLH2f6UaKL2RIZrS5DSBWflK0z+OS5AC99D16ybjYtPjiKMHMAnRE
 1aV0lQCmzrjlgjCPO4Q==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a01d9ad cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=XeHbPI0Qzp1-PBm7oVcA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
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

Hi everyone,

We have been dealing with two sources of extensions information in
target/riscv/cpu.c:

- isa_edata_arr[]: an array that we must keep in riscv,isa ordering that
  also has priv_spec info;
- riscv_cpu_* arrays: used to set user properties and set defaults for
  rv32/rv64, among other users across the code.

The main issue here is the info being duplicated across arrays.  When
adding new extensions we go through a ritual of adding basically the
same stuff in both isa_edata_arr[] and riscv_cpu_extensions[].  We can
eventually forget to do all steps of that dance, resulting in patch 1.

The second issue is a desire for less abstractions.  An extension is
something that we report in riscv,isa, that might be exposed to users or
not, that might be a vendor or an experimental ext.  All these
distinctions don't require multiple distinct arrays.

I also made an effort to start moving away from the 'named features'
stuff we have going on.  A 'named feature' is just an extension that
most of the time isn't exposed to users, most of the time represents
innate TCG behavior, and sometimes have a different enable mechanism
aside from setting a flag to 'true'.  None of that is exclusive to this
class of extensions therefore I believe we should move away from it
over time.

There are more design simplifications I want to do in cpu.c and with CPUs
in general, but for now we can enjoy less lines to maintain.

Patches based on alistair/riscv-to-apply.next.

Daniel Henrique Barboza (13):
  target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
  target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
  target/riscv: make riscv-qmp-cmds use isa_data_arr[]
  target/riscv/tcg: treat all exts equally in
    cpu_disable_priv_spec_isa_exts
  target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
  target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
  target/riscv: remove riscv_cpu_named_features[]
  target/riscv/kvm: use isa_edata_arr[] for unavailable props
  target/riscv/tcg: use isa_edata_arr[] to enable max exts
  target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
  target/riscv: do not set defaults in cpu prop callback
  target/riscv/tcg: use isa_edata_arr[] to create user props
  target/riscv/cpu: remove riscv_cpu_* arrays

 target/riscv/cpu.c            | 315 ++++++++++++----------------------
 target/riscv/cpu.h            |  12 +-
 target/riscv/kvm/kvm-cpu.c    |  25 ++-
 target/riscv/riscv-qmp-cmds.c |  30 +---
 target/riscv/tcg/tcg-cpu.c    | 137 ++++-----------
 5 files changed, 153 insertions(+), 366 deletions(-)

-- 
2.43.0


