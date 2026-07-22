Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD19C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZVa-0002T4-Ui; Wed, 22 Jul 2026 12:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVP-0002Jv-RM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVN-0001t1-4O
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFXvng1176064
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H6F4c6ZXZ7/13bNnEfzay2q6tLuwbiq/PA7q9gycG5s=; b=QXNps4d7pC6PXsUK
 XtX06PwV3nrpLRKG1RSMwBNdca+wIrKtMRgNPsxdwf7BEI8yhI1sjTcXZOUpCcP9
 J6lxTa0PY/L3eT06N+IeFCTb5J52Eh71me2EgnEb4uW+GzJTYpSinjRZI3oncPhR
 CtVWiQtU4gRz+mtlnljT/t/juY1K0wsUx14hj/Jiddl1D9wHgrEKgOAB8HyYtwAP
 ik9kc5T9LsAUaEmSrLfcoXGcDD90tfQ18UfurGC5J8X4dh88QuZCvviN6frxR1m1
 ktEBfF6bZwhhjnR0GbRhB716KMfTU6OxqMotdKCwXQtRDYxshFPfH3jBh5grb46c
 isXkwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm10sk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so347851951cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736545; x=1785341345; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H6F4c6ZXZ7/13bNnEfzay2q6tLuwbiq/PA7q9gycG5s=;
 b=hpgppU4Ij+uplrldybL1plWNQyY/fgW6Gx+WacF60IY2cfEk7wCnUlIB+UMhsdaSh2
 YAg8rmOO1e3YE9MhGYnhfUCbiICi0N3q5USzu4mkbn5pyy6YIkGgG++0dB5hlQ0V2FYQ
 r6kz7cWEUlmOAD7RnAkbWed07Aa3ALymoJuf7HLUQkxi0d7YriqZPWswNMzFrVQUYLAF
 JjyQjSPoZWv1jslGfHOt7mYarYpuj2jh54eG7iF9AI2/SOE6ksFEeO5t4Sn7DHo8PYbM
 hRA3KQDpJ0Xb0q8dLsjq+338zgZhRt7O+9yU0M03BJdPMYBmq+YS9p3kUywNSYdj5Hut
 rXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736545; x=1785341345;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H6F4c6ZXZ7/13bNnEfzay2q6tLuwbiq/PA7q9gycG5s=;
 b=J5dN5ENnws3lVuqRjh3V9klVQkybXs7Rcuk5E6798nqz/eL1kVWqnEhlNqyKrobQ1v
 nP328PSCNZgjRz2uBva+e7sZeNXbqi/6dmwWFybTbUcG0ndEsLBaNkK5V2gZO66XtuZU
 wraIToWR1qbfcrb7fDH/qf/AVR8HcwZLMVbMsqotZ9TUB69lSUy5MDNNOfo6IN8GjelM
 f2xOZAhhWkUeKhIG7QYrkch5hyR80CSjj8mDhTV90UKKrrT7krRY5Tjged68PpLGdcm9
 hvnTT4VA4GrB7xX7LEaJBa7zSxWHdCPNZS7w5NDaxl97OxZzNhHmGcY3b11sCkbsfNE1
 1kkQ==
X-Gm-Message-State: AOJu0YxUcGGKZcizjKEXrSSENOhEpyTaIdYonVCcKXpZZl9pJ48hMbvX
 1y/GNYYXEgvH/2rPv3Q8h0ukfr1nhkbCcAbxSGJk3qr6V/h265mVSiJ/Hs3BoUhNlW05JexVkEe
 w47pif9+3PJRGYvQBJkTeSElEnZRSgQ6wQrHFppRZK5KC1CNk+r/ne1C28S94DbCGFQ==
X-Gm-Gg: AR+sD11/wRL81zUtckVymVx9gq4WHjCAVHpMF0lty44hKrzpULwvF9rW6k0XSxWzdyx
 S3xvWvr4gqp/cqISBtk45XC9pgqqXbR/bYkXs3LkjKiHMuBPSDlTwyCcOQpoTs3F3c5sKfy5c/X
 SRbQR/63xPAoqJ7PEYi4KKkTyRjmekqCYWAIEudCgHcFWa0BNdmWzcoc30Jb40OE2Gn7I+hRJ2w
 CO2oqwvS6lRYK5vUlPIsHKt/+ZRFLRSlSycesBKoxczW4eDSUTQwWVvTDwlvA4pcz3VyNk3JunD
 OPS7DzKiMD/ipaqGCmv2pcSy4w9uVTKhhDJH+qyOQGyVRhJVsBo+5zin5zGoUUdPnEhy3peE97g
 kdTKx96/gdPQr+UOzMMW1dVsCqCP7EDXnUWOCnYNeqPUZ+OOIL+O2qZM=
X-Received: by 2002:a05:622a:11c8:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-5213c8e2f60mr228084411cf.5.1784736544593; 
 Wed, 22 Jul 2026 09:09:04 -0700 (PDT)
X-Received: by 2002:a05:622a:11c8:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-5213c8e2f60mr228084011cf.5.1784736544092; 
 Wed, 22 Jul 2026 09:09:04 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5e04e9sm43116425e9.2.2026.07.22.09.09.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:09:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 5/7] target/microblaze: Introduce local MemOp variable in
 LWX/SWX opcodes
Date: Wed, 22 Jul 2026 18:08:05 +0200
Message-ID: <20260722160807.24031-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfXydaWbvLcxpBD
 awPIqSZeWBgk8ozbw4n4f7MuEOGmktiao/+gOuWcTeG1Anp1SAvXrrQCkOJnuU0j4PzSVppW7Yh
 CvnG6LYuK1EDugdfu1igIjOExqGfO/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX6DtSVByMjdqi
 q51B2/IcOVWhft7PPwW4crGpeRh79DoAZTRxLEKXuNfgmDmDmzucaqKbwXYetO508uWpW1GsS1O
 AhUf0SwO+iqANXiRgxGEXg/LsbsZu0fnINzIbk6+N/17Fd0T6FXBYdpYbJbalpX5xsixjmZKckT
 26hbNb4JlbBHuXTw311z5Fk1Z//mPGXhHnaCqBTocol6lnuM8OoDAeTuPjmBC0zGhgCJasCgz9b
 Pgh7mIQvYu7XGvykTX5kReQKe2vFyCGboDqfb5P4OrHfaKV49eHeDpRabcKFk+lLDPw8tqXAhrT
 8xzvTJJhZPKZzpm5vU9As/ciZkfWgW1ZmfcOKOvJrzH7Lg/9n/LRUhhPa/V3XtrDyH9T0KOaSVU
 5y4Ed+PoGBTxyG/XI9inuWwBh/H2wLasy7rbQ33fRdkxPgCjbEuWGwo7HMOLNkmWL5V49ExCLC7
 u1hzY1tf08orgfV7XRQ==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60eb23 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=d3npyxWmdYZUjDIn49UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: sK-H2gWYIJd_Qw5CdVpa_9inrkG1rZzM
X-Proofpoint-ORIG-GUID: sK-H2gWYIJd_Qw5CdVpa_9inrkG1rZzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Next patch will pass this MemOp argument to compute_ldst_addr_typea.
Add the local variable in a preliminary change to simplify the next
change review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d4826981913..581f4b48c92 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -814,13 +814,13 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
+    const MemOp mop = mo_endian(dc) | MO_UL;
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
 
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_i32(addr, addr, ~3);
 
-    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
-                        mo_endian(dc) | MO_UL);
+    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, mop);
     tcg_gen_mov_i32(cpu_res_addr, addr);
 
     if (arg->rd) {
@@ -935,6 +935,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
+    const MemOp mop = mo_endian(dc) | MO_UL;
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     TCGLabel *swx_done = gen_new_label();
     TCGLabel *swx_fail = gen_new_label();
@@ -959,7 +960,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
 
     tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
                                reg_for_write(dc, arg->rd),
-                               dc->mem_index, mo_endian(dc) | MO_UL);
+                               dc->mem_index, mop);
 
     tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
 
-- 
2.53.0


