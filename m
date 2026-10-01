Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD26BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxc-000815-U9; Thu, 01 Oct 2026 13:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxb-0007yR-7f
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxZ-0001kg-E7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsdeR2686928
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VSvHqsO8L+dHNYmXoTf0zUJrWVOq5QYYEzf7PB+VsNo=; b=pERRZlrKmO8vMWBR
 rypvB/uubQVYgkUHCUdumKQiY2GkwrXh1p8NkceA+iciD+GGGabZLzfvCpRzINbu
 0tWvuGH4KSM22UvsdjAqPpdpvLi2uFeQs5Yd3uF1JaBIxqgmfAyVdidRegUeZf2J
 oj6csdeKkhvS3SpXf266vMagdAs2hb7pzIO4ieyYHJWNXZZxYDS+bI8SXRHocqLy
 UBrEGgjTkOYLW+TqKEJiHr5SMH2NwohRupkvT5bEq4UGsRaylOrAbXHLD+qwJWh4
 EaLzMdAtZ3bePcbmkBq/XDPTYM8Q41l3pg20Tra01Q2p2UWbaABudBAua4ChwJGD
 NJ0G7w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-146e698b8adso625132c88.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877153; x=1791481953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VSvHqsO8L+dHNYmXoTf0zUJrWVOq5QYYEzf7PB+VsNo=;
 b=hsdcsOpbfPeVeO5K84xFDo4FFvZdbw/iakM0JR8UPkFgRPdhfcPNWQYX6Sq3a7vMwc
 mC+BboVpJeY9D605a4PGcY/8XcyFhcJuNMmZW6uqARaa7otvhRACpvDuP2Nqw3oz+N8R
 x6TFdxaY4LNyESNurJ7B0ynuZvul5qrAZWziY7KvCV5Gee8JM3com5bziAPiJGhUgN89
 /vs0EwzcBkp+g/YPLU+7InlXJIChoXHVkSbrIOIZIpiwokDKPa+rdcSALwA8ZSeTlIYt
 Ezbe/BPUilcOQ8/r6HO50cbJUsm20QvCsX923FGOhW+oRPOfbvlceNH0z31rWoH/YEs5
 cfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877153; x=1791481953;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VSvHqsO8L+dHNYmXoTf0zUJrWVOq5QYYEzf7PB+VsNo=;
 b=sCWIW1boZFiGOgE5Mg+Ye4YF2rLq7Im9yoVkAy+cM9gs7BbIRdRX6KuzkrELwqS2SC
 UiaaWuf10G9H+aoDx3JotnYVvTflhSjDn3fGuyFVZ9FZoakadFjD9AqXVGLrF/1w3HbT
 ywagtTdzK6b6AgQJZ/IwJCReF3UTMVldIf/CIaIssvUsaVhYQB2BNSl5JQTDsApIUPm8
 MA4GlcPs6ehLQB6t3w3Svl4ZAjwO+dYMZPAor+8XRV5MryjyAhoJEwScDcj/sOZQILQG
 QlA4PCMc7crt8ecmYigAaA1azig8FymVEz/7eAoI8sUBkuqWQ9XoDUzUhZEkIA4toKLv
 emsA==
X-Gm-Message-State: AFuF++nyU6uSHTt3Haged3zrRhOc0oEhn0a3yOT4ozcm3MZzgf78V/l/
 1Z7ZDDRnotQCYEtnPYNNLnI8P79zyPgEV1VSiuAhaOfJtZSnJ6Ex5z/4ihRCBG2v2/fhlnb/Wvv
 mSZb3iksTonPAlI9hm0i5AXouqO176Rz0vt7+Ru6QYCo8lspk2mEVVRFBM9lwB3qziA==
X-Gm-Gg: AYBFou31I4w01co9rBWlYmwBLoX+Cdz++B+ApMZLUR7mjelxw0GmUM3ZFoFxtoJ9qtl
 KA7R8mxv7EhfUqCArRlIEhlbqbubO8Jss2s+WPW34lJoSAbIrBUpgp6kXHAWOKEGOqjmVcLWK1d
 h3+19dBfW+xMuFVFLKZBtop3brUhI5cQ4ssUwLxRWCM7AXeEdOpEcrIPwXVJ+Cl8ePN/x/LCoke
 IwKDNlwmsV2bwUpiralK22hLD1lwcfl1brtq5RP+BePKNjannA73gfhGbNFDoWYGPy6DxJCdUTp
 LWIxQezFp9MFX7QZitxSlyWcwWVoju7Mjum0HAMNoDOx25pbLcKqtfgJfwUVEq03HorAns8hJpl
 9U46Z2t+J5jY24q5sgOwbBgH92tOs1p+uUZyWyCO56Yuu2+PX18yBqHBZbJTU
X-Received: by 2002:a05:7022:7e82:b0:149:f2b3:efcb with SMTP id
 a92af1059eb24-14dd10af1famr4063849c88.14.1790877153279; 
 Thu, 01 Oct 2026 10:52:33 -0700 (PDT)
X-Received: by 2002:a05:7022:7e82:b0:149:f2b3:efcb with SMTP id
 a92af1059eb24-14dd10af1famr4063807c88.14.1790877152638; 
 Thu, 01 Oct 2026 10:52:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/27] tests/tcg/mips/include/wrappers_mips64r6.h: add missing
 wrappers for and, nor, or, xor insn
Date: Thu,  1 Oct 2026 17:51:48 +0000
Message-ID: <20261001175203.8673-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX0b+sQI06rGnJ
 fZ17Fp8yhkZ5y6aDkKyuSqQKja077+4ffdmBve4y3S2cJQfNihnEXPDLIU9tLJQ4RmnDv19HQex
 2mxpImtrbp4BvqYFmF8WSuT+ER4bbnA=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9de2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: TjFJ9c7-TcHDEodNcuzN2XGVGRFuxPWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX28U/TaoLp3Zj
 DaWaKgFRcOcmh0pQuhSl5mM3/aECxp4sQ80BictGbz0M/Jx0xeKkIu/FIaxQgdGjudp5lF0ISea
 kAcdmam21jIKnImwPX1Oeej2mlRB3ah0tHNGshm5s7oxJA+p3TEV54U3uytUXu3Ozr36nUjfFvh
 Z/N3UP0e+8Fdvau75CjrIgmabyrvmgiJlLEjiSFRb2gL+q0nmehg5BInkiblgu2rO76/S4gu0ix
 dFreQecXNyeMRfpXUdxiEsD4R/K4TcD7Ow+cDB65n4dghO/TD1GzRAjB0ledFCBF1r2f23fL3gm
 DySum4hG4upc1+JSmBmCqHfZjXZnEJpWp1F05A13nAKFn7FpC6YcYVPH0jKYQ/CATXZphoWr6e0
 rf7ooCdTtVZ4Cr4T9a5lPGZiv0JcW0foQ8i9tacsmtZOrse7i6+F9S+Y5SGBPkUiaMJY7oJrvPz
 1PFv+XUdvmWUZJsu4cQ==
X-Proofpoint-GUID: TjFJ9c7-TcHDEodNcuzN2XGVGRFuxPWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
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
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-13-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips64r6.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
index 33d03de50b2..f078f534f05 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -47,7 +47,6 @@ DO_MIPS64R6__RD__RS(DCLZ, dclz)
 DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
 DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
 
-
 #define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
                                         const void *input2,            \
@@ -80,6 +79,11 @@ DO_MIPS64R6__RD__RS_RT(DMUH, dmuh)
 DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
 
+DO_MIPS64R6__RD__RS_RT(AND, and)
+DO_MIPS64R6__RD__RS_RT(NOR, nor)
+DO_MIPS64R6__RD__RS_RT(OR, or)
+DO_MIPS64R6__RD__RS_RT(XOR, xor)
+
 
 #define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
-- 
2.43.0


