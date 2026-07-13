Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C576DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP2x-0004FN-Nr; Mon, 13 Jul 2026 18:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP2w-0004FF-Lu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:22:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP2v-0000Fj-1l
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:22:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJAgXd2159303
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /N11u7afjODbWboejhYBSLh5Pi4U2K/AZNchyN5l6BU=; b=a0kE11KOHSznxPan
 sfMYnbiFNoFhvpfC8QKK1HJaC6Pik/jKIRrARIUVuz+u35mVa2ChgZf2dT5hPhax
 cDerwP/Cfy0FWedusQeNBCvq8NuaInqXnvCfvjDmIHPss5fc+zITM0+J4wvaDFdj
 GRYCKbet79HdTyuBK/GQpmwL8QSfvgPEY4hTyZYyfbh2B3ZFQsF0Q5s7pl1WqYF9
 g6PtQIPRW0KPM3IIz7xyRFsbll4LrSMPtxku5TP7bYiXRNRVMOsgGaeJb6MOemzh
 UhKB0L/cgqssOS7WdsqjOVlPHBA9XWz/GQxS0JPKxq4DhwiDGdMYU1NccTub/k9j
 EhYVcA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qtx1c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:22:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so5329425a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783981358; x=1784586158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/N11u7afjODbWboejhYBSLh5Pi4U2K/AZNchyN5l6BU=;
 b=f+O9KjuLJvMEdNXVcKkwkkWop8tcUurJzlVLTBHYIwbr9OnANW//9l85rtpnUedmlt
 K56mEhyNVV9lIlSJs1KqdUvD3+4Qg6XUBR9E40eeDd59GFEEkxlqgXBdMEEQ+oBT5wV4
 Guk8wn+jhpRvMkSgtHiSolHNXYj5p7D15tHZDfrUSo3NgTcdGXLpoajp9MnGpBFIhb0K
 jY+1TEfHxzPhkjq9FXwtUZqERkwj94ix8xsNCkIWSbfdtmPwaeq8OHQCk2Rp3lXf9FhG
 NcrfY8CgVrQ//xRmHbuekIyjGhdayfULkVvmPROcWClBxKH1J9ZqZsh3zNW0aFZEsXl0
 F1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783981358; x=1784586158;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/N11u7afjODbWboejhYBSLh5Pi4U2K/AZNchyN5l6BU=;
 b=nT0LGzO8Ua0xHD/AOGS8SUWqk/mctH5/3UOSoHzAFsxjOhIjRjL8BrVi/NKnYNCqQv
 IrNv4roXFgBTIhwqqspQOtvGjlI8JRCrVorlh0E8ZCYXgjyHmP1Jnbs3oIgnxgZQvFKf
 XSHnjA6wbw9/V/Lg6EifvUU8PjmKKxC+GLnyxBImE5AzjiuWrFv42BlHiam2+/CDeJ5i
 vKYcM1/ie/Z+lg7tIDEro3n6BBtVmWlrIe3cV/TYYUU6KRbAiHJDapejDUbn3FonIaLy
 jky+Buj7GBcncD87o3LrMMM+M6UyNxuWY9EDzqd5N5CJRLAuUVqgamFYZ+qAmzj2uQsJ
 I54g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6B69BjaEI6di+NU1AJ5Q2wuu9Gh6GhQE+5qlF4nqT98y6VV4yJTDq5RhEmCx9G++JhuhOcMfOtW+R@nongnu.org
X-Gm-Message-State: AOJu0YziEbdtRClcFeM5ly1GXGwX//udogHwk4wjlZwmBK3RWWFqokrO
 Ih5hyj28ANQyDiNR4FrzU9vXBSFFjtFRzvmgs+FEdd6tpcKAWS9g0ZPERuBdump3kspf24dBfpi
 G8M4kzAsmkctCmuJPBHjb1k5LLQ+C/Fblaa9n86VWEBSdUH/NRWOQV8KVDOS0mS573g==
X-Gm-Gg: AfdE7cmxTFF8nOjRktiVYAy3cxpGAWDc7uH99JNJja/dW0E+EpIhpOB3ys4C9JQzp02
 vagZLhZ+uSnKEp1coz0wbCRMsl95U7QgsDxaMsA/Zz+9paVGXzoMdNSaO468sdSfW3QVXdPXbh8
 VT0pluRmSwSDpzyQ1gcUMdkWh0NfILiarm20XG30tooM21MaJFuDzbgMRBJ4aTf9B3NJ00Aapew
 xArD/+bZUqvo0IYyDdldgxi4pNmFYb06G9m3hNS8voycLXGEVWn1MIWpxs+p9tiWmluqR9K0oyi
 +skMYikd51W6fQXBW7Wq9q4ObbyPoDcvuzeOdxnR6oE/smGHaY0FQwzWR8I680GeyNpdvXU6xaK
 O2inlDF9Ym18X6jPoMALFVXRbXwmTWF8iqaTy0Tab/Z6ZUUZZovS3LATIIOF0YgJkAZb2oXmZHA
 8yXQQ=
X-Received: by 2002:a05:6300:2290:b0:3b5:4fff:fa0f with SMTP id
 adf61e73a8af0-3c1109ecda0mr10286345637.14.1783981357828; 
 Mon, 13 Jul 2026 15:22:37 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3b5:4fff:fa0f with SMTP id
 adf61e73a8af0-3c1109ecda0mr10286326637.14.1783981357393; 
 Mon, 13 Jul 2026 15:22:37 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm39950287eec.15.2026.07.13.15.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:22:36 -0700 (PDT)
Message-ID: <07be4e07-8f0a-421d-af89-9c20d442ba04@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] target/hexagon: add COREDUMP semihosting operation
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <a2e686ac0ba95d33760e6f83dae711ca30a0914f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a2e686ac0ba95d33760e6f83dae711ca30a0914f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX/pgundYfC0uF
 jiY0qAUp4IznkjV5qfyqDwd2Y300iocZAFp6QizCOyrTghEJzHeL2gz+PSKE2H7dUBztkJOhxy6
 2sqHPhXULfRa8MMxm0stcxa1IaIxv4csLpbW3ioMH/xm4dsncX5ztmnAa0uG7O3SfIdcyPG3Czn
 r6lSayLqatlvt/hp5HNSxnJ7KyVE/I5xq3fered1NANy8Q7XT44qZB2j3utfPfwmd8Mr8f9yqCu
 8pBs4Ll/i1199ZCHTa1vXj1DvJVYdH+57Gm06PRCufcUNWvo9Jyu1lmWMF2z2oGN/pcnQ5ywKo5
 C7ppZ1ZYp9ZjOcI8QNKFPNLZRi+H2lOzsQ90nd9Grt+1L82OjSU5Aa2/p6uNg6yjy7Nn9ygx+C3
 yeyyNTkxOTZlstbJPhTgYApSiuxlT7SnmReb1zzCrPdHlU3An6ZM/WipxNIfkBc7KcQ3xaKSaVk
 Bl1yd6AOwQpTxSixThA==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a55652e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FMWDG9YH-Y-Q0creWlIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j9ZGn1NPYMnOHWlpJ8_IC1HECIJDRXhp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOSBTYWx0ZWRfX54LvOz2vMkEE
 QbcoPRqdR8xXL9SFE4kdeM/VSm7hUmBxDmWIHPwyGQPys2mViWDZxoOmrJhUimswG8l4XE7GNIM
 cYO1ckN0GI6Q2wqocE/B1XX7+hUJ3V8=
X-Proofpoint-ORIG-GUID: j9ZGn1NPYMnOHWlpJ8_IC1HECIJDRXhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130229
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> Baremetal Hexagon programs invoke SYS_COREDUMP (0xCD)
> through semihosting to dump CPU state on a fatal exception.
> Implement the handler to decode the SSR cause field and
> print the full register file, matching hexagon-sim behavior.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/internal.h |   1 +
>  target/hexagon/cpu.c      |   2 +-
>  target/hexagon/hexswi.c   | 143 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

