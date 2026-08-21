Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB02C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMqx-0006cc-MC; Fri, 21 Aug 2026 06:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqv-0006TV-B1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:52:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMqp-0003o1-EJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:52:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Lhi11983011
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=; b=RSRx2pRyoPH91992
 TegltYhU0tO/R5qKaPcuk6I1gCHJUYczezQuchbrMRVFzZpzDIJnD6Wb0n5SaIeW
 bOeILUUkC2A+kmp9V5ZMH2hP5zh0v9+gZNRc1dx9tOG0HAvjdWI7akODFeC0AYU6
 tGMsbZK8ekY1wwp/5brntsKsuWQV6TDou19nzU3bx9ZjxhyAgcfs7qxtTMPvyNyz
 HgTo2MV1cfUNHJX55mD/4HE8z6ki145icNv6MPiSoTrpTwUPrF/Pjz63Xngxihdf
 nQvaU+uh5xJJ8gdfnBcLLMlLdopcZdNqXr6v3fj5As5gXcts7q5Hzp6gSvM9pYc2
 P4Ij3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdshx51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:51:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso70879185a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309513; x=1787914313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=eP5vRFRMU40n5iPck43TRvHULiEyMoNT2Nm4yC8nfwVpbjhyxmtyCzPYklfLFqP6XF
 zxrQfwNbIDShZKLtx+nlFRAxQHslqOrOvaUsxs9ZG+Mp03IfXjrn3rJXCcvQmLpmlton
 mdoJ60/T9avA5yZnst4NXQxohABES1juootaE3tOQT6WEfwHihzORzOc593fBas79IXr
 Kagi9Cuh4/BV3s5pOP/Tuwxtj1/SbDbi/K4nWtCqU3jRa4PJ1akF1l4vIVXYZFwjpJGA
 lE4rmc9UEO7739U94P8cWtrApgNKV90eRGVupe2W4gk7ZZm6vlOUxeInPkBiWv6F2bJW
 fGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309513; x=1787914313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iDP7SSBBed9OilMDhZqOv3xXCrS8V81wrx791E5ihCQ=;
 b=fto2Yuix7P4n88fwp3cnUlRc7HaWBZM61k5H/r9abq4tt/W5oT7mrwCyD8LbvVYYay
 LkY3pFys58A1OmR2m9SZXbGtYykslTzfMFiAgKDK2hGQvR9NMy3d9rX7fbcR8qyedf8y
 ZClIlBlo2NazcnW2gj9oysbPMQN+vcx3ao70G+wg4/OYP+3S2SUr+6Wg8nOtJzUFgWSQ
 +IeQtyGy4yc2jivin4qgjYYcfq+mXEpWrAC3riiFAV3RImUplxGVXAS/RHYKvJLtsKJf
 Bt3Mv6470ga/pMemr6kfyys5oxyK0GIyuYL2t5Y27zmIlPjvEmcVVi2PjVMKDtCYWuc5
 aA/A==
X-Gm-Message-State: AOJu0YwcvrZn/oWdlz1WtRI0g56cOC9F7tN5Mhkt81bc+jKuFN8dFzGD
 1U/UdKD9RTBenfaw0shI18fcioRmhkKuARKXlUhAmZsigktvaL8BVaBsEhuMlSqYh1f6Qyan7/M
 9l7axIOCTteAyqfnjgRVLqqpcuBP+spBiiXrwblinvHuGsL0AN7p88+uMdooqbYT9vAHZ
X-Gm-Gg: AR+sD127ctD6NH2p3a6M6z8PX7iZUl90DYUkRQcChu+ThEDzTS3bxLkIYVSjA3GkEe+
 +wQnWxnWpmKUpLOEvP3AHZA+xECeokVuUiaPHv24+Rrwvk16B+Kxdz/6AHteNo9Vgb+3rDS4YsV
 Pq2OwBT7w2bdeKzzmjD0m+4jnHbkjwiohuUCc5i7pEzg/LDuPkah3qbllOuHQPAPtDiHa6FZK5L
 i5DAA18l2ayczDrXS2p5htR+dWsXLG6c0mserL26/iB8mfBTOPzIaQ+NhYY16BIvJkeFJ008gBM
 LHGlLldlYBzKAbYpqbKzvs10fi8O+1PvJpRU0oPXSGkOTvengUCMZKfX41cUJr1Ccp3BLMquGTE
 smUASNp+9HTRQpxM9iZuYWRpkcgYF8BncqWGW2R8/eA==
X-Received: by 2002:a05:620a:f0d:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93739574e95mr408166285a.12.1787309512948; 
 Fri, 21 Aug 2026 03:51:52 -0700 (PDT)
X-Received: by 2002:a05:620a:f0d:b0:930:f337:ebeb with SMTP id
 af79cd13be357-93739574e95mr408163385a.12.1787309512544; 
 Fri, 21 Aug 2026 03:51:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22642065e9.5.2026.08.21.03.51.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 14/15] target/tricore: Document architectural interrupts as
 not implemented
Date: Fri, 21 Aug 2026 12:49:48 +0200
Message-ID: <20260821104950.32108-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q6kFTTPrrxR3jjC68IjLWq2vgxiyrI0M
X-Proofpoint-GUID: q6kFTTPrrxR3jjC68IjLWq2vgxiyrI0M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX7Lsrec6TVLP+
 5p5CH3Dg0URQPWNhwCOoVIgyolslZsRUQ6qZwWkcQvL5MqzUCslmHnfnUe8bHYjRJaM1oifCux2
 fqaXDL4Ly5FeER33PGu5sR7+gBcNeDg=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a882dc9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX1B9qvUfc9jMK
 4Q612Epr0KVcZBmF9iUcTru7ZCgRqWEwQScpj1kveh2y0HIZt5+4/n/hVYeYl8VQO9npWqqF32P
 VkvIrMTpjaHEap1cnG+FJcrYMesIuaBFWWZ8Xvr3GjCoZkz2zVVWwciT+F2/BQOGB4JAOEY1yQ9
 BaMnm2BxhqmcdA5NrxwVwXyvsH4jvwL/MDBYNwVCRzEaWk89e0+x5WAKT9TlmZXCnAxeMOLTPci
 84Pk48rT3gofFnH3bLJGgL3H+qHx2mORItDrLp/ZwP+0cPjc8eS4RhEXbOMGwmXYk4xgjdXPFZr
 2wpY3sa9EqpAwZQU/TNsRcIcX0bu0jxT84JyNwZm7PVsa6ks/Ylp68SnaVUb1RObI/rsp7CKGeF
 vTiJW6DP9V0XjytbWmW7CaYh9FalbTw2DU/EKf2c15CEHU4s9fhfr8ApuOznPb9GcwiRhSqDONy
 h1zLS4WcUVuNfZVui9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

As mentioned in commit de680286b52 ("accel/tcg: Make
cpu_exec_interrupt hook mandatory"):

 > Tricore doesn't currently implement the architectural
 > interrupt handling.

Add a comment to help understanding why this SysemuCPUOps
has_work() handler is simply always returning %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 6d448727005..82b56c3cd56 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -113,6 +113,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
 
 static bool tricore_cpu_has_work(CPUState *cs)
 {
+    /* Interrupts are not implemented */
     return true;
 }
 
-- 
2.53.0


