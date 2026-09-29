Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8166CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfJu-00008Y-ND; Tue, 29 Sep 2026 17:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJr-00007w-2f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:24:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJm-0003eT-3n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:24:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3VgQ1723967
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 djzzjDKPF9sWSy10pgDi5Oz19zt28yyzvKvs7qu0xRA=; b=Pd3Ni11uOGhMnO6h
 iws3nzuCTxkOCxB7c9A0b9dkzcmSJMW/YmplS/1SxApbc+73cyEkU99T5by+dEg6
 PLh00nYcsSYorlIvxBLX2x4nlzmiZZwF8HySqJG72QUSvxz7JNcR+oLZWLq9Tktx
 0/wTBlQhqw0eeTmRn5DSX7+sBzNdjX8cz2EJYxrzql6Azna8KcPsKpV9GLQx4HFo
 ohGWR8dqr9mfkShikn95zIu+rBvum1bk8hbgKHnXh473Zc6pcOPUfNzpvmWOPDk3
 aMtg5JRz7j1pF82N8Vwp2SKSJ0zmd6I0viz3sKPi1k1fx/eswOv7Por8d+lCZetG
 zGDUMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97rrh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:24:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6896776eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717089; x=1791321889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=djzzjDKPF9sWSy10pgDi5Oz19zt28yyzvKvs7qu0xRA=;
 b=ZO40H63cc4mRvB+yqv7PprPjnyg/KN6mv2wJwLdgQaBdshpK0MFdJpeux/80scAmMt
 Oyc4ZbUzt2mUT0jz5L//lQG4QSa5ktDbUnVFCXpa1Md3FMJSTrTjuR2EtW4Nmi5mhfyI
 Ijzey2uxF23HzIvlNGT8bPeDz4GtR5jH14vQn39Jwb35+tgslnpBNbJi3t0wX4wXo2x3
 sFQvGXZtjXQoRFcZC1/JlM5aeyh8l7553uNbgB1YA3K7X0fZ8ToNIjntbY6BE+DY5WNa
 Qbg6H9DEmwhQMg4D9JVgEujNJD7T5PoX4g1Ppt/ImMmd4LN9dACWwy6rwuggFkcywcnC
 PtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717089; x=1791321889;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=djzzjDKPF9sWSy10pgDi5Oz19zt28yyzvKvs7qu0xRA=;
 b=03zsyCGaAqLWvN+7eni2WPMezdP5HwrYyAVCPQg6IxBSQwPwUgSVzXG8nYxxviQ7zX
 VV/Pu6cUA+Q6jMf/apgjkuxomgRNgdDXmjhGyrFYaWQvyYNaHGoc06TfrH5nYLY3jz2F
 kw+0W5f3PzOTQH59e5HVX6NnMjrN9FxnjIRvqNyJZepLz0RbCxPBNydpN7mOHLSs8JJ+
 Ho0EgS51Bp3Zdec6MIP4MhM/1p06/y9rtel2tVBVg7gaZnMWNPaAuQCQ2b4UUEDauifj
 ntr7hLQOKdorZACOZ3R+hcAZ5xMQ4qbq4RnmTOOD8JPUu5v9CkvJBfh4lzObhb1faexw
 Eh0A==
X-Gm-Message-State: AFq9FYJcafAYhWy9Lf0miQzoMGvHqGGuln72+DeBsk/HGHkQWkX63G/r
 6j9rU+k0Ai0wZH9jl8ASHE0HKQx3aGFb02d1LnNMyRYbIUAqn7shtPFmTM1lErb7OPHFm0DUwA0
 3/aiOLRCEqp8PhYedr1FQVqErR2DDzEFjmy+JxmaAAbjRklUrmIe7duS1yEWXhMpqqg==
X-Gm-Gg: AYBFou1odX2q31u78aQuFmU+smKEpzLVMkWkoJHBSr4zgIdRo8Cw26l/i3kSVvm79ZQ
 0Fz+ewxbbPpVMzHBzXbPHPCM5WYW9e1IKHh0OwtKORaQ8fk33JyywGMk8NYVt7OWsscHnXbuKp9
 lwYTWoxeJYIEvuzBG0MZm+LYIKW1H5KqHKRdhQN5OnmXkgjcHAG77KysOmpkYXy+ve7RdUhC7am
 FcyhQw3vGl3Q+RN9ApA20icp0XzXbWvYVupnkhEquMOb9HGhe3as82IHAdFk56QZ2NMZTnRw9Yw
 lgeUwFk4KWkSs3Xna2sYMY7r+NvvFru0ZLDnFnNwCQ7muGytvtI8Qu3yH3WMiy1FPNZ/emSRhjS
 soCH2Hd/TMUJCZC8+oBAJ3Z9d9RVL9bdlH9pHuMMmPv7I34HNaJ22E32bnUAn
X-Received: by 2002:a05:7300:a145:b0:341:33a0:2930 with SMTP id
 5a478bee46e88-34c63bfa036mr976411eec.29.1790717088258; 
 Tue, 29 Sep 2026 14:24:48 -0700 (PDT)
X-Received: by 2002:a05:7300:a145:b0:341:33a0:2930 with SMTP id
 5a478bee46e88-34c63bfa036mr976340eec.29.1790717087111; 
 Tue, 29 Sep 2026 14:24:47 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:24:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 01/24] tests/tcg/mipsel: move dsp sources
Date: Tue, 29 Sep 2026 21:24:16 +0000
Message-ID: <20260929212439.110454-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o64B7Gu_csrnH61AkkurfQRCtmE6v12m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXxWcCgj5yFKg7
 LsCNJI280JaIIzz2yTHDHgmz0ZUeqG2adkgLTRaWuiPi3xp6ZHPO6mvj7b1Q06/48vYrQihLxKn
 7yAoPNkv0FlG7OaeFbgnoB6IcSClO6PxwN97c+L1BMmXIdiq4zWguxQJHALHdGOiYjLcSX6+lBE
 stv6p3qCOAVenpDFAFVEjfk/GXefFbwJ2HjF+Vt1FUBATSnVv6JHWOZx5h9lGZZ29hzHuEL07Lj
 0pkFaEE5z7pGNjdBMUKPml3mtAkIZQ1i92AxNsntVpSmoU3P50hJuwfPaEiFAB8Ui3wvBmRDiUv
 zcsntqGZ681/fJHzEOTIq9ZFnEkpv6dlm9E4wQhSbMmfQ7V0zlHVbHSKzHEKYjSvjJJmx2JAGlC
 411lZ3bKG6mPPMbmEG7uBL4TvcXbf/GQbKjZ4T4bsWFVKJ2RiOHFc9hUVrYuJs2BZnwrvJ07fsj
 tm9v5xHvRuDjHG4KLFQ==
X-Proofpoint-ORIG-GUID: o64B7Gu_csrnH61AkkurfQRCtmE6v12m
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc2ca2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JQ-yqmddgqYmtexnL3EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXz2sJEglogVqi
 zDN3kL4hUVniiew8f6pwYnk8ChT635bzmwNCzraUrLA9rwIn1FaA+bSMS5Z6FK/R1nlI+d9V5R+
 YzqhZ/YlT+eEOjbPdAWQ0mu97ZIFZys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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


