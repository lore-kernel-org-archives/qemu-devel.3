Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D81C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMpj-0004TB-DL; Fri, 21 Aug 2026 06:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpf-0004Pa-97
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpd-0003P1-BH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9LuD62006089
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=; b=CYeqsNFMTEsFzDKp
 wjmQfbx6g+S94umHeOXG0HNgFNNxaWooqbkuO0EH06YaccqNL0RR2DTRYtd5IpnO
 g6m92JBedg2pWvtzRYyT3jD/9lDHQtCLw9BmBz5JYLMbTPByxAOE3ohFo97nLSic
 o6qlm1GcdzfT3ARvnUCHQnfxLpm643XKKg0uIsPKZR/dB0muTvpWpwV0KZTEGHvM
 D/4JH6pHh+9EK0FP7TJIaPeajOUl/bJ7DLwfPdMXxHGO6aPvSNCqiyAGe9M8Lh2Y
 15s07bckP43tdoRuHJGXQWmrTUrIS3Fke0Gx0OM0ird76KUyELIMAlQF1MOoP+c4
 Gf92QA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddh64n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c083f1818so9019251cf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309430; x=1787914230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=TCN5snuSsODGAnKEAFXczpx++aKTAmu83EFzpkXraUHQSBXpH2gsGWGJHNBRFcUy1K
 fClrDfjedLjgimwMrNIlmh2GmZJWC5BWa+C9OwE2gxTFzQVIbek278ZAbSW/G74R0iMc
 kcYCFHBbl1b2+zG5c7O4tNGqVybJIcC8wEFYWA3JXANUqSAJqbp+AxOPh8x9gDylJzCy
 1hnDA0cKJzlbrkIXJoQWx+0wC10GyYcRmXBtTVLXKM9ElqFfOz5kqO+8Iwny3aikm9vb
 dRMfAA468sMbLkjrz5LPtPnaVfkTX/I3VVbLh2asccnjOFb3Z+eDXCnDLWMc+cPObgiJ
 0FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309430; x=1787914230;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=Azv9ZFtenN7HzJo58aaOcAUZZkdLDUZhO3XH9+IRke4GPV4WnL+C3p+K4OZv+hSNJN
 I0NYeP4QI2txipRKdCe7jowY/sLtNybQuE7D0QMLTf21wEkIGAWsxuMGjerw17JzXs/S
 D10DldOrcq1d6QruiK966GGi4NwEf52MrZuCqL4dJAge3W/TLPVKKcOtOri8QuWV3qqt
 cf/LErRjHvakA8o88y2OraRnADzN7EFQjCBx6soCluCOGCHtPiiiZijBXpipWeCa+yCB
 8sYTDR9g/yVSy3kWOBbr8v3t8Nj/WuFDwGUD0JXJhiESf6AVR/wEtZCPygcZdkjUeCM2
 SxBA==
X-Gm-Message-State: AOJu0Yy9wkj6Pju3LW1mHZ/25/9/F3XkE/Up+W8fzeY4IVCpC0fL4J79
 /X7VKmvpFi8xocdUAWKx5h7kGNS7Uf6swJnEpaeuIZTy5bFxdsX5fHRUNXhjehRlOCG7X3Vd/QD
 jQYKqpcfokbf7iMtCaBNEEDZaYIyv2ej1i+LADPW7uJHwlP90/2QluG3kKlxbjN3jHKnc
X-Gm-Gg: AR+sD12RwldJGm+FrFOMxfI6ZkPzJlUWNFFHwWBUDn96UG3hgVgFUa1vbKcpdBhfqtB
 5m9/66l20KUS/wvVGazVAeNcuwzH8M2cGuv9Qna9KbYoZnJq8oCoHsK1rHVv+MZXpVH9GZSXcVt
 vS3/m9fchPxsWHNGyfaTGFOgMh5/+PJbh1FeA7f4Zl+QewwzdNk0RkhVbjSncoBfB/mVvixeSGW
 GJgIV2LXSdyqztWf8chh5a22daippSVxctTMSkBLZZSD37OcUqGtmC4cgms50kZM9Ag1Dppw/iH
 sxVhFbY3XCzHw4CGY+fvmBPapD8rDJzCscR6oCio+KNp+0dnLdaUG/NH517QOnIj7XPprj8EODI
 1Mb8ebbg/bHS/tUqIlmyyiqbYNmVGB6c8+nI22kZPJg==
X-Received: by 2002:a05:622a:1353:b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52df5ba9d3dmr34679781cf.41.1787309429935; 
 Fri, 21 Aug 2026 03:50:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:52d:6c36:db32 with SMTP id
 d75a77b69052e-52df5ba9d3dmr34679551cf.41.1787309429541; 
 Fri, 21 Aug 2026 03:50:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b9b81486sm12994635e9.4.2026.08.21.03.50.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:50:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v3 05/15] target/avr: Constify CPUAVRState for some cpu_*()
 getters
Date: Fri, 21 Aug 2026 12:49:39 +0200
Message-ID: <20260821104950.32108-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXwWSQbGzQvu6R
 RiWDDtwDlf381PY6avjbNL45C4uU50tiAspjncNegjWmC3tg3UCOxO0xU9d1n97S72J7A0/hoyc
 fRpAsb/uB86R5HvhVtzjDkkv2Qf+NcM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX0HEsjx+kDJsX
 bQFcJ/ckihZwSwq9ZnoqPKLuplVZA7xQXtrPJG5+YWO7qsruX9ky68x6GMuLNx9tlpln26ePgiy
 GJXgeNRR39HvP7r0BwIZ8DqWVpBXE2N4tNfvKuMwOiV96imXgJEwF8KyLbucdgTVoQnYrNHG0vk
 4bPZuclkhFTknxgEBMq04uV0d7PlCkRNLOBlZKPeWVDJMDXDo55fBYdLrVRXYXMDnJwhjCQlt2t
 L25C6v8EBLm6xJTIJnTME8ekdTC5h5Fl/VM+lMcYGToRg4KGzAjoZ9nUMEZSgn9JhpX3bkf1dmL
 Vkn7O0j0WoG0tgUC/CrG2IPVnCC3+8Kl6AqS4Av0Mdelw/v8nPqRU8ZFlbLThKoaMD+Esr6tJCM
 Ry5y8FmgJQAPXwx9BNYjP6T86KPxsr33KO/p0GIsvNFvvW6LATEnl5MVNxz/HG5UkfvoG02Y+AP
 HoVDiLbKM9HrWSQFwyg==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a882d76 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=064F3_fa85QpgnnSfTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: f55yaK2LuD9DZGHf82XDsngG-8P3dR3_
X-Proofpoint-ORIG-GUID: f55yaK2LuD9DZGHf82XDsngG-8P3dR3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPUAVRState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/avr/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b2..1e4e839bd83 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,7 +183,7 @@ int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
 vaddr avr_cpu_gdb_adjust_breakpoint(CPUState *cpu, vaddr addr);
 
-static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+static inline int avr_feature(const CPUAVRState *env, AVRFeature feature)
 {
     return (env->features & (1U << feature)) != 0;
 }
@@ -204,12 +204,12 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline int cpu_interrupts_enabled(CPUAVRState *env)
+static inline int cpu_interrupts_enabled(const CPUAVRState *env)
 {
     return env->sregI != 0;
 }
 
-static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+static inline uint8_t cpu_get_sreg(const CPUAVRState *env)
 {
     return (env->sregC) << 0
          | (env->sregZ) << 1
-- 
2.53.0


