Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE6FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vG-0007gu-6o; Thu, 03 Sep 2026 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vF-0007es-CK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vD-000730-PF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH9S43203931
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NKbvep5Em2quy29io/1xtBX6QfJ2hLwOCn9Q6oahR1s=; b=ZxmVSUQhK0buxSky
 HNdBcmkIgKydDg2jValiaxM62QXZ2/ezXvtoS5TTkVtD6KxxIF3KKxKd8pg+0VBS
 pAylhsOtnV7DchtdJj25IIxvS0k0Q7SIrB7ZChfnixHyp2+ahTz3AZbmhEMY/1f4
 c2EG5g0zYX3MRtv9o9Nlfwtl4kOMHeqVN7/Xtb3usCQDUCrlMI0djmFLNcpzRVIa
 ac4ZEM9w+L+02fOAf6h8jWkatjpuv1umBzzHw8+epvQgSM0OmfA9SAl9ncrodCZL
 hLmzHwCfImaJeTNldPsAvCYQGDbJGQ9IsPgE72AGxcTEz6av6dnsS7tPB/6Xl8Qs
 mGY7bQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10hj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93918756165so542232785a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432233; x=1789037033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKbvep5Em2quy29io/1xtBX6QfJ2hLwOCn9Q6oahR1s=;
 b=i4A4j8SvuF0gkn0UAwCi/Hygk/9ECJn83hLbOXpLrvS+Cca7cv6XBwvYwGF5m4RD78
 jrGVILT57I/cpdU5PIuwYlayC2t1WLEfFJcRuG8bb8OFtU31XaHyY9/0U0ye7jY5bxd5
 OHoXWPHa0KfnCxPfiQIb7xKDwXaExhZ0ZTzWQR6UKQEM4+dKrRfjLu9dfHpFt8iuQ7B2
 EZkYXHtQ3/RTE2gIaOcI36/MfIksBHI3y8gMQjTivWINj+6dyeGA3Chznf5e+iCOMtJL
 4LQFell20Ee1SFemcX38msScg2LsjpNlFkdY4f+dLSE+94rf1QISh56ydx2C2N26iGgK
 QUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432233; x=1789037033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NKbvep5Em2quy29io/1xtBX6QfJ2hLwOCn9Q6oahR1s=;
 b=YFAC+CtzKRY3SO5peLJEsgtPEsuEZ8mkybbFIU1NLhbAUR0tUjiJAoPtHjjKVABMhr
 KIHjAWB2pJiDoY0WRci2xG3yGspSKXC40ZKXLc6OqxAdomY1Zq62zDev9a+QPOEYJp4e
 r98R/1WCBss2Sv/9Pvq4PirLPez4RlXxCNS3Cl7DNjEOcKA7SqdcjKivROhsTGJvdC9c
 wUV0k6Tqb1aQh5m464DUWWuY+9FuQa0ZvBvf8VsL4lH2jPrRbowEr9RAzniowILwnW+R
 72DIWS+FFDNKa1wNi/Ep8pERNoxEzMIVMc8H+FmXQ/ffnOcqKpD1HbKul/AvFf5Dt55l
 vb7w==
X-Gm-Message-State: AFuF++npBV1LzgfehMjsE8lZf7INGdTBphxFZPD0KqMOjnATSTnUQBr1
 85wz9N1KZNlOwt5q+lHy+M9qo6MVDTYS8ahAHtPKwzob+kjM+XJ7/bRtIIs/60omiF5ncg9UjGl
 v+3FykFq+dD/2QeZ2qWL0mm6entwA+GZQiPv/imO3ujOa+jE/i7EkJwQK/S20RjtnEQ==
X-Gm-Gg: AYBFou3RW+53Ze/rxW5TqmtELUWd7n0pmZDIL6aWRHFZfPQCYKOjbHUvnvBTpOxwvZG
 UbUE2gb2iIJ/oBwojhx43N2V+vRtKn5tjlZy3eR7SyZPmCMRM0FHCTxvpsjI1QBDv1faCpxdVce
 hCBWCmm6HHhMInTwYLyG/h+a/TugWA7Df/dKvUfiqvP/Mba8M4n0l1awrY6QxjThf3oZs1x/Qhx
 dEKlnCWJC2bhNXBfnXh3g2Yr7mwc51t4Yq83b1sMAriZ5myM5CL0LQqmmDktLdLlUvJzPxoJPrr
 SCy4t7EQOaNkzrS5yiGLYoa2BLH7/IfG3l/s2pEud2w6N/xWY4W6g7jXembBekZf/DjtwpKe+HB
 M146ughpTxN3GN7vz+UWn4F8J8qinUz+ItQ6HZP2o
X-Received: by 2002:a05:620a:4442:b0:939:6de6:951a with SMTP id
 af79cd13be357-9396de69720mr633009985a.49.1788432233432; 
 Thu, 03 Sep 2026 03:43:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:939:6de6:951a with SMTP id
 af79cd13be357-9396de69720mr633006285a.49.1788432232958; 
 Thu, 03 Sep 2026 03:43:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee131fcfsm44360325e9.4.2026.09.03.03.43.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/51] target/xtensa: Constify CPUXtensaState in
 xtensa_replicate_windowstart()
Date: Thu,  3 Sep 2026 12:39:18 +0200
Message-ID: <20260903103936.62355-35-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX3Kc9ankfVyak
 ht+8gWCqCc2yCCMPJqk0OFFvFRbnLK6ILV3XuY56uMsbrkqUyH5bDcuh3TZmixULmTIRlLVkKNx
 lPxY7pN3KADbNM0XgJTxGZwKRVcfNhGYUyHoZsJviYwiqc4/Wth7pU2C48Wk+nGu8Q9W/8EAtkx
 DwG8VBF9IWJ/uizl/ceuzBL7r2ZB8ijSHVFU4ZBlmMUd9yBxaNjd6spV5Nyb0s6jZGXGKBse31t
 CdlPt7W0LorhO4O4DzCotNySxJCJAb4ObnxWuGZHHp8PBM507npssa0xqhc9O5lBfizk3kZzyzv
 VUqntXet0QL5PE8+D+4wrd51bFiQut5cn99ZaDVf+XTyolqV8qpS3UW7iNlPgxQ9/Y9CfKMU3ql
 CC+PYnJnga7Glkif0XrbabnIzh9G0+K6/mXu/akAa+0e5hI96xQ2baKeXQBdYCGthqI9SqAsxB5
 ACi0GVpLpIyo9cpqaSA==
X-Proofpoint-ORIG-GUID: 3lgt92T1POEdWYZrb-HRgaB2rtC7PoQu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwkVZ6/h/SoT9
 /BVVjpyFh6E1qqjGw3TYQPH5Dz7jbcwjlCRda+NOfPrzjZD0OvuiwxQ03ZKI08MYZlQ4lZYNTbd
 tw9v0pn2TjGMp/YWRghud0sy/cu8sx4=
X-Proofpoint-GUID: 3lgt92T1POEdWYZrb-HRgaB2rtC7PoQu
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994f6a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WyWAz_IcRkS63iEfKG0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add the const qualifier to CPUXtensaState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20260901095229.72018-20-philmd@oss.qualcomm.com>
---
 target/xtensa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1ba..49d6ad9083d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -708,7 +708,7 @@ void xtensa_set_abi_call0(void);
 bool xtensa_abi_call0(void);
 #endif
 
-static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
+static inline uint32_t xtensa_replicate_windowstart(const CPUXtensaState *env)
 {
     return env->sregs[WINDOW_START] |
         (env->sregs[WINDOW_START] << env->config->nareg / 4);
-- 
2.53.0


