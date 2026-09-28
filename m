Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194CDCA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB84h-00087J-WC; Mon, 28 Sep 2026 05:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB84f-000871-0h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:55:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB84b-0008DS-Vu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:55:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M4a8322569
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yKiqk33jXQ7EB1poZoOMm8649M635ktiIfaSYlQCFvQ=; b=R7ivvOVFvN+o3Lch
 ueIz5CebGzblggFPtmNUwz47yh8uf2k5HXwCjxi/+CQCrzjU0O1568l6Gf3DtZaV
 sZuV5lkOi+4KcjgTWolKsTynh09zgPozQz1j0BOWWGM/fGWmMTfFH/R1ZhdAkqHl
 dlEAzm2VNiwbsftapvjQ8iAhcrkcsEtNl9pmPrk4VpaDN5VV11bs/JVttsrv4zf1
 IabDP0pGvvp0jaDA15BlaLRDz+Iw9Ss/qKCVXaQ9gFt2wqaC3K8NcjSOREdXqoU0
 xfOpj19ngXBGZT9mGFt3t+RUDXAujWsvFoKuzzaSCyGkHvU1bCY4HNyNZLRgC8tP
 UgSZZA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1kdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:54:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so589116785a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589297; x=1791194097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKiqk33jXQ7EB1poZoOMm8649M635ktiIfaSYlQCFvQ=;
 b=MnfKyQZQaEkdsXSBfGYH30BMP8i192tNzmFaofv2B7GwzvLZbYQsYiM/vXuSomIfJN
 apm1zSP9VA3KBLCeOW7/mJ4uo/iAOuIQtlLmtiIylErojGjQVG8YHPYLADwxwh6EtU/8
 TpSwWBYdRv3TiqbFZfXgtHH5biuNVAocCDMgOG1TnM9QY3g9D97KmP9X+Ahpy5G/ks2r
 omHCEKsaSixlhT6rdkAIT9467o0Lgo51gzyrp5CeNj6IoMB5Zl9xxf266kwQiPZiaVH/
 AlqTEEGsq08Pyzp1108QLSiMfZOm4cmNDO96+vHEjxuwWiKht4VklIuR1Vy1g7VzoLxF
 UFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589297; x=1791194097;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKiqk33jXQ7EB1poZoOMm8649M635ktiIfaSYlQCFvQ=;
 b=mwI13h6DLCfMdOKdSxLphoVcqvBsJV2eBWdyWoJVZ0eS43RlKUAcqHid6evsz0MJs4
 +cJhaQU3cTEfFSfSMEXbbGz2QLg2IJcxp+20AkbZ1Y3R3eieQF9ZuR4w8UIPnDs6U3w1
 8dRUPHxgoae+eK9uvGWRE4EN23bXhsd8FZx2JCuDlNdB+p2EhwgVUJA2U+fZli9pLYF0
 RVOHOqJCG8R/N5K7qhFABT0s5fny5jU34PbFspWeKOWiKI1zSaOOu0C5KZJmsfdDmg+p
 JiYgJ0t7n4KGaGOFuWYAroS1MSB2fmyVdzghdFwBr1hxXfiNYcux/q9W+uSabR7at/TQ
 WSdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsk+sfmPauAFJrXQoAWhy3UuBizSOn8c+N82T9cyqzrUkSi4zjvbYqSxCwdewSrmSHoqgK6yK8mZxI@nongnu.org
X-Gm-Message-State: AFuF++kM6z9UbFuUBnIBWLFaKkayP6XT+DaTRMATA2HtYGDlYFHspdoD
 /OBZrUj0jHoOu+yNYdFSwQqGs0oGrzxhpK8qoqS0Klpt2QQnNjUHqJMwLKVBzEiCI6L1oEOMCHh
 ZqK8oXzF5EFlf/K/kKRSg139GU1yYhdLIiaprK26GOWi83SUUNkS3lZZ/jA==
X-Gm-Gg: AYBFou0p8uBpYffSNLlRJavEMHDzvW9zUd+HVJGqLYHPKwTKQaekmuQMFbXMD64HVM3
 afmEAEQgzBjgIY/Ysk38vg4HAJpCjlV+8xcNmoXeWgILfMwjcH6cBlsAWIcg1eDK4jnFZBZ25S0
 afw321DoL+WT7O/Pd+4PufNGxVfvVEWL1i2dHBIOji41+ANOjWn6KygG9KBpNG42zW1jJOAg9hO
 nvPwWfahJgmWbjXTRwkZieJOplhHBUZ8UOYZNmAyDgJu9cvEO8EWZ+o98NrbKcD6uKa8kalfEl2
 7MWxzar3YzwD03dhSCUFXpfilHXqj7e2YpJBnXnJIxwJKeMtE3z8DpX4nBG3RhzAh4DETzbV63z
 9M48vF7p388TKCPe91tX3pbHp5/+HQOsbRg==
X-Received: by 2002:a05:620a:1b9b:b0:939:6dea:ce79 with SMTP id
 af79cd13be357-93c43ce3316mr2014457285a.47.1790589297534; 
 Mon, 28 Sep 2026 02:54:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9b:b0:939:6dea:ce79 with SMTP id
 af79cd13be357-93c43ce3316mr2014454785a.47.1790589297034; 
 Mon, 28 Sep 2026 02:54:57 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0056e2044sm32932135e9.3.2026.09.28.02.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:54:55 -0700 (PDT)
Message-ID: <2dfe1b33-b8b7-4d21-b597-7bcd2bdd78fc@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 053/101] tcg: Generic expansion of tcg_gen_clzi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-54-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T9wufcaUPIZhAremddlV0yU9n7P7lX00
X-Proofpoint-GUID: T9wufcaUPIZhAremddlV0yU9n7P7lX00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX69ZwGu2ew8kR
 vxAmVAYBhzgvLFsGGKZ2T5Fs5LQx6jFsbZaM9UO93XoKQJfM4xYY4bijmKYAV7a1yAtnLwdlUD4
 GlWtYCfD7ORatRIp/Oph9PpSUjpRLnA=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba3972 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX8QIesXoPYRTG
 4FQ6g8MzAozdhfzOOIfdTJtv1X68LYEjNyzeiH6Dyx867LrLsb3obgPj+BbcVy3ZuCPmMFNw5AT
 8aDqRE3NsYaQQPckzIC1HjD21Jv/FUG3BrZWHGAj12qPQ4C+wNHMK4cEviHayt7zO2Dxa7cntkQ
 HFONRDNb+ncqOSaoUR5tDDo4POliAoMeHa9fcA0bC0Ks/tak7FhdTctGVkEWjKXqvbyJPTfwEQ6
 gHqgj6c6XClgkfzLBW2/+EC1tyPjggeQm6PxG5fvCZ8POEV/XfVGp9ro4JmBIOJ5fNBA/zZTWI4
 S8Z3+gwtvomXVjfANajY41YEM/96iHAUOOwWWV+wgX7Vrh1JWJHLb9yzcZdvX+i9W+aRyCsFrsa
 R39Vs+KmzLsimyJ1epq0I4adbkRmmem5yza+R8WOn6RoS14xLRAJjHPl18I/f47cSI7GL3B3RuJ
 Deb1nZjP35mdfRPxy1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

