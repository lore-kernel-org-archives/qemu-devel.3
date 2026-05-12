Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055B9CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoT-0005Ou-DN; Mon, 11 May 2026 23:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoR-0005Nw-CC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoN-0008Ve-4t
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6nuU2186483
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=getQ+Ritum2qx2D/rraq8H2SVe/ElYyf55O
 gtuhohaQ=; b=RY+JBsdLJiZ9WgHovtAUZgE0jcuWbpAczyuxX3sPfjRkxr0Eo5B
 VKxzz3US/s2Oz+RCFrIGWSd0ehxaiz8Ud7/jV/pPh1a1WHVEmp7iTO8BQoQmDr4B
 6N+lj2qLnM2KgMOJjcIA+LTvFhdvtk3XkNC9Cc3uyUgcAXc4gniezrPsJ1vg2b8K
 YubdF60EBgvt7VI+sDEtCK7XrUTweHeWPl0p38+6n4SfHA7/q0gx1FULP+SeCH+x
 1ZaYLK/9OzvYHHQnKSkW8THb2Y/AKuFHV00VAIHmdsi6W0wMUaaWFLzKsp3vrXKI
 sQKtZcJLK63w9VVjpYI8J31qN2qIkvJF+tQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2992s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso3518193eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556572; x=1779161372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=getQ+Ritum2qx2D/rraq8H2SVe/ElYyf55OgtuhohaQ=;
 b=CnGcemr9Qd+csOGPXSIJFeEmevDbNAwBc+ssxHt0zLejXXmExWvfybwz+2/3ha2NPp
 V/HnXa23CjCH+m3QJe0Zcx2FabBafm3kt5IM0ZPunXiOTDxyUANgQ9R1q9vxZw11HV2W
 wn6c9bFi/Db3XfZYiCAQJuatSYZ+vhP3/4AV2hIaAtp3WrRuCI2pZEP3eLbcz0Kf5xHs
 /91p0wdWUdWygAAEbpNTJRyky4D3NOmX0osPruY0gHhSDDo5N2Ej5j2tBazAXtpbq1MO
 YhmNXzer1knn0ltcQcO901F94XC+6YxqH+AGndiG82r3S/DEaHA7ctj+ynRGDy3UYN0G
 fXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556572; x=1779161372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=getQ+Ritum2qx2D/rraq8H2SVe/ElYyf55OgtuhohaQ=;
 b=s5VuOsJEfawW6YZZ6r3jvcL6fj+GTOzwE82KyuEFg6v81gbT+ZYoYD3BHLkmOIILBi
 K+SJOO6OuLzqEwFoJhWWVa4V1XhgcQ72r4Aea8wuQH1A3Ln4e2UFb6bmmIGyP95ChNNF
 YgzG3WJA1WWDCVLMfBjL1FBFmRF/dYQIg89o9nL9nRFDgp7mROfTOE1Au0XFjHeyzEUG
 UhCt9MC21UqkYXN4Ka5VsYb7Lfayrf9cNkYzVC59MXm9amtfFp7RWJssluOCP9mm2r/R
 7OInFipqmJDIF/5AlFI9LqX/SMZ+3pza9zdM8/im65gWw7jrWUF6ChZP5VUR7QEQng4e
 Ge2g==
X-Gm-Message-State: AOJu0YyOLt+XySoVAnipEywNIMusu+5kbtOT8/ttaQ2Mo1nePp3ZlXk3
 uFuaTDhhe+aApbCbScOaixKVRjiCLtOdhKEs8ThRJifGq5jINfxcMANFgb7sTwfL1uHgXQGDV/R
 QuUB0n/w9IIKyxAnQGRZFc8iX5Y63ADQyLCTmL3QMLF4E0XcJMlXxWTHYHu4bKlNL3Q==
X-Gm-Gg: Acq92OFbV8bnbYXLlIxNwOF5Sphltsb1ZCWwc0sQVV4+ww11AX6PjfUvJR+iF+MDGFG
 eRrQDuNoU/Quqv49jSXSjL6Sddjwji8zkB7sZDsucfU7ipsBGmsuUqij8rn/11OPXcaMbWav12P
 WvNhtlT1uR1Y+zMHT5TBkdl7oZgB645LzhzcePC1AttRTCYfkBdUAUkjQ1UNNE5Pz3NvpSOSGSX
 AIcWyiM3fUUG7wulu7jFgQby2UYXOdAimMgTx6nuycXOMHqxsya9KoZR1mBV07c7/X5fWyhf8e1
 KGuYuT4MJWwrIp2Ups0YBTkQdxyTz7R0X9wWWiN8PMFAVH41k/udQqCuI4nealnm4osFZNtIPAS
 gDaC6P6iOstuKlf+wnPRIsWC982RG/tuS39fePJPsxHE77QCobdOPYnrLLOkZ
X-Received: by 2002:a05:7300:fd0b:b0:2c4:dd55:ffc1 with SMTP id
 5a478bee46e88-2fb4b82cd05mr5773267eec.2.1778556571540; 
 Mon, 11 May 2026 20:29:31 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0b:b0:2c4:dd55:ffc1 with SMTP id
 5a478bee46e88-2fb4b82cd05mr5773250eec.2.1778556570873; 
 Mon, 11 May 2026 20:29:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 00/14] target/riscv: remove riscv_cpu_* arrays
Date: Tue, 12 May 2026 00:29:12 -0300
Message-ID: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XKCB9RRMv_d8H0MMoQrBauHwsP7_XPZn
X-Authority-Analysis: v=2.4 cv=CeM4Irrl c=1 sm=1 tr=0 ts=6a029e9c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeHbPI0Qzp1-PBm7oVcA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX8Gl3TeFyos+j
 504yI6zJ16EDtdRQdjwUznRrg/mIhxdC+aYM2+mEE7sLh8asSCmP1YeDCplWtixdxxKzgIvT9Wt
 hHqCcbY1Xc43nUT6p5vCDaDr8ZVxkDVv2rxcRLlAcjwXK43MhRlDtJvyc+q3//ZHUBanBVmwF+E
 N4NfhyUC/s6mhDwNBEWGRkGbtmFZakM4XSyUA7PW6boEm5jZDYjMB9l5tMzzAA8hq85ocB929pf
 2wmxWP7KZEpISXySSs+aeJiYNWBFn6baltfa39Jhr4Hcp4ySFOcto3FdCelM5VProKcsVsJBBC/
 fe0pm8MmewBc48HGnVWljVP32+2icOADczTqu0z3o9RrS/UXrPiSYoLsQ4nGaiFf6+QLsu0Ry8n
 zXNgEC/eoG6J2TWIDT3ViZ7wn3ig1A/WU5jmEUWioQqRV5WkgQb2ZXMnXKBvs/71tkL8Ti1qDRj
 l0VRa/f0TVffcrdwuSA==
X-Proofpoint-GUID: XKCB9RRMv_d8H0MMoQrBauHwsP7_XPZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


Changes from v1:
- added a new patch (patch 08) to handle riscv_cpu_update_misa_x().
  This solves a build break reported by Chao.
- v1 link: https://lore.kernel.org/qemu-devel/20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com/ 

Daniel Henrique Barboza (14):
  target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
  target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
  target/riscv: make riscv-qmp-cmds use isa_data_arr[]
  target/riscv/tcg: treat all exts equally in
    cpu_disable_priv_spec_isa_exts
  target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
  target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
  target/riscv: remove riscv_cpu_named_features[]
  target/riscv/tcg: use isa_edata_arr[] in riscv_cpu_update_misa_x()
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
 target/riscv/tcg/tcg-cpu.c    | 144 ++++------------
 5 files changed, 157 insertions(+), 369 deletions(-)

-- 
2.43.0


