Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E7CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxf-00081P-96; Thu, 01 Oct 2026 13:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxL-0007wb-CX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxD-0001fz-Uh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsdVg3512250
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ABSd95PHebkatyqYeJJQekXdwtlGNZTYXGlQlhqcWzU=; b=SNnx78GxOXGBOJhM
 Rk3Hsk2NqRdS53lVVbSAbmxB5MP3fhLXnXX4mRGBY1ybLqSAu7PD18syTpLtVkFE
 nN297LvKMSKCcoAS5r8t9kkRwdq122ly99+dDjzusv8La2UON6iXZ3z69MMP806u
 D+7QhWCPPVA4P4NyoVv1sLIV0tbqpsN78TIhevuOeYNzZ6AeLBxDOfZghr/0uanh
 c8qgay1jnxOuob/42N+ez48igEuA4TjY9WRDvOWnIIz8MqYWtu7RpI3VuX/CCgut
 Z7Lk6RJ9xuzFM/F+34kP+K6elgANoRbEs0Raw1jXIhSMowVehRpy/SaRAfoSwkFl
 YoJscg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9dyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1438492fb40so4669227c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877141; x=1791481941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ABSd95PHebkatyqYeJJQekXdwtlGNZTYXGlQlhqcWzU=;
 b=GLarxSufWF0kqadxiKK0v1mF6/bkkTwUTrVX2Lhljyae4+iBPHXCgC5boEgrA0lUqc
 gUkkMdGo4Mom+WVk159JmwhImJy6fb6NC7YlPsQ6dMC+MQAn/KR09i7WFPaiHQo33hLF
 0LcPlFAg2Om68/DpN0iIgBkENK61Du0bGkLkeNpTem61rdKzERL1vXDZ96TTxPogdf7t
 qLDtSoBhMPOJZY+ocXue8Laho/Grq4akgeo9UV21ssP0X118HQqVmZLuE6kQSWqhnOn8
 CVfxMkfGtnFsZWs0v5Maa+taCzcg6Ei7s0Bqh0DnABF/hTFJSRDAsBaGPDY1ufqVtR5V
 CNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877141; x=1791481941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ABSd95PHebkatyqYeJJQekXdwtlGNZTYXGlQlhqcWzU=;
 b=l3xI+xMi315NDlDvkoUaGzRwApIa7KPlNbXxSx5OTNMmKyr//XUU7F7LNZ82xo6d9/
 84VJqIGl3uR3gBggYpRPX1PTEf16sjv4UtPvoz+588X1NIcJR+kks3izKiauVA02zhWz
 HpoynTs3FN8e2TddNATh3UEyKS2/zZnCkLo59rHoTp2w3pzu9ZoPcmg3r8BpcQZJYFQl
 XXkB/foVG6HA4AeYfyT3fL1YLfVhPH29OKyiVWTpqNDbC1/wqahgXtSbMHIf+oP7m4U9
 Q9a5SbnOywetbS7DTRTHO9R2fBfnNRhIPIBkfi8UzJbXfI/vUmxKU8RmmyHefh7GE2Rt
 mcYg==
X-Gm-Message-State: AFuF++mXjj7tQbXxD6ia6Pd/9PZyDTxZq11vVV0B25BHiLI5ykI2trKC
 wL4V0EDKdSIloh7VYMUb2JZ5mUSGVX63edwqDfAdcQLm7JA1Vd4qrW1/JMHrvWqiloUwAG76Tb/
 NwRjpP3ToyyqzhhOs/fPAGB7am+NN36I6dcknGQbKJ/m9yMbyNXl7jyeqheWyrIea+Q==
X-Gm-Gg: AYBFou2i7KHTKhNOPiguB+uChr0G0FyPFy9q8QkChLhoY2cq9EJ1qokLX6YqjmyZXNt
 BsVrmOxF8f3GM0U1MTbWGgedTvrrQWjqjKUIVWLP+mwbwSzhEHOXDTPTZIJTZJ2ui3EUTRozxHi
 MdvWDx7XuFRO00fCbmq2W9p9o5Z8pM0IyR8GeiO/jsMyiQPFBfPHfnxLcpIOfLKnUT1khabAiST
 oX74RkV9inBCi0o4WbxsiVsMrOJ3w676TkWeun+Do7ftVCBcyk5aiCX6bcIxFmPw05/qp6azHMP
 ift/BFk3oy8juHmj81FIplE7y8AFSTTv2mmx0Ce29R1hLhUMwsJeLhrrP3UGwPy9Q7zQI/J+Z8G
 mI549HQgr9oW7O4UNOANhd4hEionQkMILTZq7H4RUCcZyxyH4hFr7CFart1vM
X-Received: by 2002:a05:701b:450a:10b0:143:2719:566c with SMTP id
 a92af1059eb24-14d33c4df02mr4679271c88.40.1790877140417; 
 Thu, 01 Oct 2026 10:52:20 -0700 (PDT)
X-Received: by 2002:a05:701b:450a:10b0:143:2719:566c with SMTP id
 a92af1059eb24-14d33c4df02mr4679202c88.40.1790877139045; 
 Thu, 01 Oct 2026 10:52:19 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/27] tests/tcg/mipsel: move dsp sources
Date: Thu,  1 Oct 2026 17:51:37 +0000
Message-ID: <20261001175203.8673-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXzB0/yd9csBQ7
 0pO+5JLVfxXZ/KZ9eZv3OzFcEH/ndPehtoK3iSjcwaPJGWOQFmtKy5pa3Cn/AkhllxQbn9aVazd
 QbyN7eZzGUiDF5OWH13Ihwk2lcYqvHA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX5LN7RYHacKKC
 GrkklkyP5214V8OrVjeOG5WHen9AwEnn6BgkU8CZRhZxg3ihK9tvFQoz2WPl+8LEX4Rk9dOIZAn
 N58gKJI4UIrfMrBQ/grM62QPwcsZ6ycpDBlY1NYZJkOhYxsWJuiEAV4SNH97kiitmqfGZbplHKh
 zuR+pqYqhlwvn6E2DaEqewCup15sdWIdKrBPv+NxzKkgyVZoCjVyZ9nVDK9tYrt/9HiowrtM6P/
 QzlUHOvJkp9UFuptXGqr9j45Bq5He0fa0OeJ9f/crRSQCIMWIsFR+EBhyHzlXFbXW2fEfbpgSQr
 kzIlslWGm6xz7nSBTH6IAKC1ekWZgpetYKfHNkQe1DQlVQHC1fLduAodxJAphpFZgSRnVdCMjel
 4e0OEZKbodGYTlxdyiVv+N6JyqVFE/1a1cd9dq5vhvGE2lDHEXjZQFuWk32HT1Lxk2q64tIJ2t9
 Cq0iLcR9Ze9r7Je54/Q==
X-Proofpoint-GUID: a1c-pUWWnDnqQPA0zxZ1HWkQvtdZEusK
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9dd6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JQ-yqmddgqYmtexnL3EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: a1c-pUWWnDnqQPA0zxZ1HWkQvtdZEusK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/{mips/user/ase/dsp => mipsel}/Makefile                  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c         | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c         | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c        | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c        | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c     | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c  | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c   | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c   | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c  | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c       | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c      | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c    | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c      | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c  | 0
 .../tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c    | 0
 .../{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c  | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c     | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c   | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c    | 0
 tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c  | 0
 161 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/Makefile (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_absq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addsc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_addwc.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bitrev.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_bposge32.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_eq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_le_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmp_lt_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpgu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_cmpu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpaq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpau_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsq_sa_l_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_dpsu_h_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpdpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extpv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extr_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_s_h.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_extrv_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_insv.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lbux.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lhx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_lwx.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_madd.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maddu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_main.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_maq_sa_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mfhi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mflo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_modsub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msub.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_msubu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthi.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mthlip.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mtlo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleq_s_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_muleu_s_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mulq_rs_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_mult.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_multu.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_packrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_pick_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceq_w_phr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precequ_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbl.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbla.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbr.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_preceu_ph_qbra.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrq_rs_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_precrqu_s_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_raddu_w_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_rddsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_repl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_replv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilo.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shilov.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shll_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shllv_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shra_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrav_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrl_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_shrlv_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_subu_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r1_wrdsp.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_absq_s_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_addu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_adduh_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_append.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_balign.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_eq_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_le_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_cmpgdu_lt_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpaqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpax_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dps_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsqx_sa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_dpsx_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mul_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_rs_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulq_s_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsa_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_mulsaq_s_w_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_qb_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_precr_sra_r_ph_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_prepend.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shra_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrav_r_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrl_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_shrlv_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_r_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subqh_w.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subu_s_ph.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_qb.c (100%)
 rename tests/tcg/{mips/user/ase/dsp => mipsel}/test_dsp_r2_subuh_r_qb.c (100%)

diff --git a/tests/tcg/mips/user/ase/dsp/Makefile b/tests/tcg/mipsel/Makefile
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/Makefile
rename to tests/tcg/mipsel/Makefile
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_absq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c b/tests/tcg/mipsel/test_dsp_r1_addsc.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addsc.c
rename to tests/tcg/mipsel/test_dsp_r1_addsc.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_addu_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addu_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c b/tests/tcg/mipsel/test_dsp_r1_addwc.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_addwc.c
rename to tests/tcg/mipsel/test_dsp_r1_addwc.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c b/tests/tcg/mipsel/test_dsp_r1_bitrev.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_bitrev.c
rename to tests/tcg/mipsel/test_dsp_r1_bitrev.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c b/tests/tcg/mipsel/test_dsp_r1_bposge32.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_bposge32.c
rename to tests/tcg/mipsel/test_dsp_r1_bposge32.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_eq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_eq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_le_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_le_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c b/tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmp_lt_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_cmp_lt_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpgu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpgu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_cmpu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_cmpu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpaq_sa_l_w.c
rename to tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpau_h_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsq_sa_l_w.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_dpsu_h_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c b/tests/tcg/mipsel/test_dsp_r1_extp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extp.c
rename to tests/tcg/mipsel/test_dsp_r1_extp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c b/tests/tcg/mipsel/test_dsp_r1_extpdp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdp.c
rename to tests/tcg/mipsel/test_dsp_r1_extpdp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c b/tests/tcg/mipsel/test_dsp_r1_extpdpv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpdpv.c
rename to tests/tcg/mipsel/test_dsp_r1_extpdpv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c b/tests/tcg/mipsel/test_dsp_r1_extpv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extpv.c
rename to tests/tcg/mipsel/test_dsp_r1_extpv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_s_h.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_s_h.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c b/tests/tcg/mipsel/test_dsp_r1_extr_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extr_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extr_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c b/tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_s_h.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_s_h.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c b/tests/tcg/mipsel/test_dsp_r1_extrv_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_extrv_w.c
rename to tests/tcg/mipsel/test_dsp_r1_extrv_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c b/tests/tcg/mipsel/test_dsp_r1_insv.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_insv.c
rename to tests/tcg/mipsel/test_dsp_r1_insv.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c b/tests/tcg/mipsel/test_dsp_r1_lbux.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lbux.c
rename to tests/tcg/mipsel/test_dsp_r1_lbux.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c b/tests/tcg/mipsel/test_dsp_r1_lhx.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lhx.c
rename to tests/tcg/mipsel/test_dsp_r1_lhx.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c b/tests/tcg/mipsel/test_dsp_r1_lwx.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_lwx.c
rename to tests/tcg/mipsel/test_dsp_r1_lwx.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_madd.c
rename to tests/tcg/mipsel/test_dsp_r1_madd.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maddu.c
rename to tests/tcg/mipsel/test_dsp_r1_maddu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c b/tests/tcg/mipsel/test_dsp_r1_main.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_main.c
rename to tests/tcg/mipsel/test_dsp_r1_main.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_s_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_maq_sa_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c b/tests/tcg/mipsel/test_dsp_r1_mfhi.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mfhi.c
rename to tests/tcg/mipsel/test_dsp_r1_mfhi.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c b/tests/tcg/mipsel/test_dsp_r1_mflo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mflo.c
rename to tests/tcg/mipsel/test_dsp_r1_mflo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c b/tests/tcg/mipsel/test_dsp_r1_modsub.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_modsub.c
rename to tests/tcg/mipsel/test_dsp_r1_modsub.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_msub.c
rename to tests/tcg/mipsel/test_dsp_r1_msub.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_msubu.c
rename to tests/tcg/mipsel/test_dsp_r1_msubu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c b/tests/tcg/mipsel/test_dsp_r1_mthi.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthi.c
rename to tests/tcg/mipsel/test_dsp_r1_mthi.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c b/tests/tcg/mipsel/test_dsp_r1_mthlip.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mthlip.c
rename to tests/tcg/mipsel/test_dsp_r1_mthlip.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c b/tests/tcg/mipsel/test_dsp_r1_mtlo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mtlo.c
rename to tests/tcg/mipsel/test_dsp_r1_mtlo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleq_s_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_muleu_s_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mulq_rs_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_mult.c
rename to tests/tcg/mipsel/test_dsp_r1_mult.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_multu.c
rename to tests/tcg/mipsel/test_dsp_r1_multu.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c b/tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_packrl_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_packrl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c b/tests/tcg/mipsel/test_dsp_r1_pick_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_pick_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c b/tests/tcg/mipsel/test_dsp_r1_pick_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_pick_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_pick_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phl.c
rename to tests/tcg/mipsel/test_dsp_r1_preceq_w_phl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceq_w_phr.c
rename to tests/tcg/mipsel/test_dsp_r1_preceq_w_phr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbla.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbla.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precequ_ph_qbra.c
rename to tests/tcg/mipsel/test_dsp_r1_precequ_ph_qbra.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbl.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbl.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbla.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbla.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbr.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbr.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c b/tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_preceu_ph_qbra.c
rename to tests/tcg/mipsel/test_dsp_r1_preceu_ph_qbra.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c b/tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrq_rs_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r1_precrq_rs_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c b/tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_precrqu_s_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_precrqu_s_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_raddu_w_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c b/tests/tcg/mipsel/test_dsp_r1_rddsp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_rddsp.c
rename to tests/tcg/mipsel/test_dsp_r1_rddsp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c b/tests/tcg/mipsel/test_dsp_r1_repl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_repl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c b/tests/tcg/mipsel/test_dsp_r1_repl_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_repl_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_repl_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c b/tests/tcg/mipsel/test_dsp_r1_replv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_replv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c b/tests/tcg/mipsel/test_dsp_r1_replv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_replv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_replv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c b/tests/tcg/mipsel/test_dsp_r1_shilo.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilo.c
rename to tests/tcg/mipsel/test_dsp_r1_shilo.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c b/tests/tcg/mipsel/test_dsp_r1_shilov.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shilov.c
rename to tests/tcg/mipsel/test_dsp_r1_shilov.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shll_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shllv_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shra_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrav_r_w.c
rename to tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrl_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_shrlv_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_subu_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_subu_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c b/tests/tcg/mipsel/test_dsp_r1_wrdsp.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r1_wrdsp.c
rename to tests/tcg/mipsel/test_dsp_r1_wrdsp.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_absq_s_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_r_w.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addqh_w.c
rename to tests/tcg/mipsel/test_dsp_r2_addqh_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addu_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_addu_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_adduh_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c b/tests/tcg/mipsel/test_dsp_r2_append.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_append.c
rename to tests/tcg/mipsel/test_dsp_r2_append.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c b/tests/tcg/mipsel/test_dsp_r2_balign.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_balign.c
rename to tests/tcg/mipsel/test_dsp_r2_balign.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_eq_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_eq_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_le_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_le_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c b/tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_cmpgdu_lt_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_cmpgdu_lt_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpaqx_sa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpax_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dps_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsqx_sa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_dpsx_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mul_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mul_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_rs_w.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulq_s_w.c
rename to tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsa_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_mulsaq_s_w_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c b/tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_qb_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_qb_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_sra_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c b/tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_precr_sra_r_ph_w.c
rename to tests/tcg/mipsel/test_dsp_r2_precr_sra_r_ph_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c b/tests/tcg/mipsel/test_dsp_r2_prepend.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_prepend.c
rename to tests/tcg/mipsel/test_dsp_r2_prepend.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shra_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shra_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrav_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrl_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_shrlv_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_r_w.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subqh_w.c
rename to tests/tcg/mipsel/test_dsp_r2_subqh_w.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subu_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subu_s_ph.c
rename to tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
diff --git a/tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
similarity index 100%
rename from tests/tcg/mips/user/ase/dsp/test_dsp_r2_subuh_r_qb.c
rename to tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
-- 
2.43.0


