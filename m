Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B2AC624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CDr-00016q-Vp; Thu, 03 Sep 2026 14:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDq-00016E-Dy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDo-0001aZ-00
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3ZC01091216
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g6MdE8Fv+0c
 xX31f8S+L77/tz/VyjdABs3T9U3TiJqk=; b=bGpD8OymvbueUPUMAojeWgNI+cW
 rj2HwQ8f0dUhi1ZlzzSUDSO93xVZi+uj+255PBeCnxninIufAJuUpsdehf5iqoBn
 5vE+Cr75gSsm4tZ5h6Lx7nRFXY/SILnRR3+JO9WhRQmsDS90S8G9/+rkG4enS+NL
 HcUEamp+khZw8dzcX/+2B2iJLh2nI37MeSf5pORd338J6YG1nwrg/7Bnb83rW7cf
 bkJY6/p8zEfTkX9Q/9MnWZnjQhM43AxdiigtCu0RWWH7/BwXFQ2+SVjUnCzvkPg/
 TQOdQkrx1Toet/CMC7ORuLkohKPLvWXVF89aR7QevdPOIjmNjW9Ctb4JiOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekjxq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so6957511cf.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460294; x=1789065094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6MdE8Fv+0cxX31f8S+L77/tz/VyjdABs3T9U3TiJqk=;
 b=cidSvdgjsqhQt7H1U3LWeCRhZ92oOm7iaQR3RRbYvpQ+6qRrw8JtqbX2Ab0t+22UpC
 mdjncJmC67zi0eCZ78CyZ9n8dJmzznbE8OHFX4HT+bqwl8m6tj7IvYWmSR9J3BGK5xx6
 kkF2pvq7X84n5or7U5GaPXvSyTULCzhp16RZI3d1uoMB2PI2dtXX8VVD8Cm0WIYH1HKI
 PxuAb3nm8PPTPLLPc3k/JSwiCmFl/grJrpz5RTmpXducZVBNvYp/GgLkAUyuH4EkGGOj
 OaCBH2xfsGvVeQDyXVf7K6WwZJmF2V0x+deOMunxjMMExzW+nVIj2cosQ5BC0T6yAJXT
 ypnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460294; x=1789065094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g6MdE8Fv+0cxX31f8S+L77/tz/VyjdABs3T9U3TiJqk=;
 b=iuB/7HIMmj8zQOPsj371V5VXEgqcOlDkfXyqpaWZZJZFL2IaQBkONmqoyOT5tIMTzp
 k9/gX/cEytwaChYl6k1AcrSaAncQQPr1EabNkVB9eONblaGqEVn5Bbo/02ZpGmobCRmu
 c5HpiycMKlXU3HxqaQIAYniEmTq2nS/TY9q7Vm2Ymnoi1hMyDhWAei2dGFml9lgu0X8N
 ZR8fK5gZBhXw6q3B5rapm/yjNcggOmPz79doulEpQPxckgNBNDoOlrtFneD6VA2DqIXw
 P8s2iNv6Rs6ceDxsvkjs3DuMFmpkTDfUASloSrTPsKXKfVsOiUwGyrdWUAMDfVPN3W1A
 hiAg==
X-Gm-Message-State: AFuF++mxAJ+jfoE3oRUpB0pY08jpKkccIu+S4yFYeYUAPstphAPgfXkb
 t9HQIM+dOFDIGkcq+ZFxhWnoCgrMRRPVSme8wK5voS8WWUxYF2ER7rVQFwdU/TTYYBY4cgf7Imw
 7faLJDLZivKx2GLSFBBsBLrkXb898wLPY7PVGT6NvWmGI7HUWQMnooNFjcPxJCruAkA==
X-Gm-Gg: AYBFou3cdMaLmeSQtPC4l2RGyaALwyZEHkhRN0J9PjKFtuL6G+sjam8xiiIFM1tJ4WA
 VYEecohMDBa0yVkMeKB1JnV150XmC3H4LNkx1/mCdYDIgjC+RwwlOpKtjsL1q7fD3RGLs8zBs9x
 Gt7qBPFUXoTkkTals6GaWG22+uMf9NoXIT99BGf1umUo9Wo2643NQeQUHJ6Szu8XunDyM8ohrsY
 LYlXXrCCBJlNctAbv2KoP17Qn9KV+TTKfT4MYEiXmZXFzqcboTeeLdfluyWkS4fiD+ygBh7eZDI
 xUpuCx3jXVkWHXUX6PL83O53HTfqpSg4cweES3L0GvnqoBQeVvGCnacE3NXdgYQXT/dUTw3EmNO
 YQytfqqPDAUEUGYwwuN/Ce5ebMFIRd0RkWcFS
X-Received: by 2002:a05:6214:8013:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-9103eff962cmr13988296d6.21.1788460293888; 
 Thu, 03 Sep 2026 11:31:33 -0700 (PDT)
X-Received: by 2002:a05:6214:8013:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-9103eff962cmr13987246d6.21.1788460293248; 
 Thu, 03 Sep 2026 11:31:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Thu,  3 Sep 2026 15:31:21 -0300
Message-ID: <20260903183125.682865-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ktnPnKZLwPIiYSb_IQQIUjw0hfPbJmBs
X-Proofpoint-GUID: ktnPnKZLwPIiYSb_IQQIUjw0hfPbJmBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfX5JfH1NwEzXID
 Ujcgt7nf0F8I+tjAapdvgDA+6bVwsmHk3/e9bm6jC7KhD8PwAQ2mAdFLbfMr5N7BJjOaq4Da8aS
 fD3vLOwx2HdL+RWy2hwJPcQC1UfcNVh2f2DettTmQ/cko40vHWBxuWwrmstSXZFuyT0+alSBHVQ
 DPdwCjtDYnoMAta+gP26n+Y6hkycOtUov8R7+LXeckJ9FqQRLaDhh8iFfvviAk+IY7CKBct3R7+
 j3pMnv08mrPXtmA/hBW0D6bd+n58lU4U8cJrMrYv7xCELB1NpFtk6EKNzc4+XbZpxr3rMVZDXls
 eMf8hu3SuzbJG2IALMzQU6RyXM/mDDhkqirGj88djcIQSldOfxbluLdSdaNtmwiTNMW7f5LL9I8
 uQ6eXJ1lLGn29L9y6Qm56qsdff1R8/dH6UfDfCpD+9N/PufgguUyNSx3E1eXSVVtOxYPvyeRokx
 2Qmy+XmY2TDzqKa7IjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXxzrNaIAsAxwn
 ZENlAWKauC7a8oB+nYIUl7to53yyusC3DUBE9QzwkRe7bmfe9Kj5wlGd7TGR8AXFHIoOWtSX1zE
 5WF0aMf07OqoAmGS1sYEkzxl/dSUlM0=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a99bd06 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030162
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 61109672d6..4cc73de793 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3096,7 +3096,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


