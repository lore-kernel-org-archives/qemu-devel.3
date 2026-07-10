Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A26C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJD0-0003W7-E9; Fri, 10 Jul 2026 17:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJCz-0003V9-AZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:56:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJCx-0007Vo-Et
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:56:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ool1648751
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZI85Olt6Tqyu/rupFmmacxe2KIcvQ07Yymt7b+3xEJ0=; b=lSPPmBgIjvaz6ve3
 W6RUYuZgDp6agKvFlPaP6FAqZoxluQF9NwfO47Z+qWlM9HkoqedvaqinUR5Cg/Me
 /eUffUJTzHTJS0vh2NjJcf0wViSA/WWXAZhFdAJXnct6av+fqtozETq/c5T5PhKD
 SMfG+XrmkJPmwzdfmcDIOgTsuQt/Qc56xfZaLCxs1/KO4yX43+/yJYlOZg8hZ+NN
 x8/oyqhT11PisRg7X4GLijB5ppHJdxqBc3LKDFCwCSfMTPBgI+1jCHO4XGqdH4st
 rjhP1TYg6rrIuoSpzD+qtTVuS0Um5R1cT81uPr1zA04f3ugwJ/6fj82GkGTDRnLF
 uWZTlg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhebt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:56:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ea24a2db9so149633185a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720590; x=1784325390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZI85Olt6Tqyu/rupFmmacxe2KIcvQ07Yymt7b+3xEJ0=;
 b=YF3PaUZW5hBieUiaHBLN//v1RPiEh0E+92bm54P6/aONHFpUNWFzdqZ7Aic0VE8FLX
 oUDyShHYk52V6kB7qfnvkleSA/lyCyz/Ewaeg/fIPUDJefRWmnrQHywEKqnfKw5aGNf/
 khe9RwzLdEnqDA2wU1IyWRBblvidlEPJ2mFtpK1xYIkA+g0JY9/exUdxA2jc3307cmPA
 9zXMWGsAxUGJKw7pJ9p8HL5agGkmOO9xZmdfo51kP3rN/orDAv/ftN2YPSOuvjH8xIr/
 zqRdJMlZIKXt9ixNNeJ4CiLq483mj0P8X/5CjhAnhR/O6z3sQSR9FJ7kxUN+ObHlcMVI
 gpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720590; x=1784325390;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZI85Olt6Tqyu/rupFmmacxe2KIcvQ07Yymt7b+3xEJ0=;
 b=C9Zie3bLyaYG49Z+BKAqnZarusz5yxsE4RPPbZjc+ThCxepUvbkcONNXA+/wzaf1Qe
 QPbbNdMPsUllBKnsKSFp0M1gxzxtf2JNLf7hayeRy+5tOf7KrPQMkAp7nNmbPMMGWmLt
 FYutWElifyJsZtTnlePK5n1CrT2DH8Va6Bp8JGXcRh6vOTNVoVO7yMUSYciKaN392mia
 G/aH2CEF6dC0ql2kEHHEQ6kjCHbq+iwwADR+ebKOYmwi7wTk+iLUwNbJwu0LKERQH3mb
 AWHa8jexsGsn2d7562jslK3GOgFoB5CGOA2QVFdjYL/qbeuqisr8CrecqmcAysUEXNuD
 XnxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8xtoRMfGO5CH3oozAKXYVD3TLRP8jQRXK3KUKEIiCo1lf2k2Dq77DWHSeNoZyBKa+cNoZ1Cn3dZdF@nongnu.org
X-Gm-Message-State: AOJu0YyxV7eK6cP8wLM2om+bm1OiVBL0cRGI52fha0gl30DLT0gsVk25
 rw0MR+/+G45VYlGXp4URsTzsPU92E1yZSPxfjyOFVSq5w7JOirfh6+UIGB5nYzW0G9maWF8c1Pz
 fU8yan9Ka9lOUh5m11CW4JzodOC6hZSK8+HIP7XI8YD7cwLk+hkluiB5ivw==
X-Gm-Gg: AfdE7cmXr3ziePwLuBujbOlWkmF0/+bryePEaDji7cJcUKAP6H7XtmrK7g46IGOvax8
 0zT+Wq4B5e7dV2FM2iNfnLBMTmg62QBnmQgy9IjGiJixWbeHGyRndybSeqcXVHuoSLzYB0guntH
 DH6ywCP0XQjGigGpDkNxLNZVqpJbKkp/oDBBKHs1xIEq4/2jFJmM4Fb2TcS02qTo2ZveL35V09l
 i09syjnqogFXlS+BAPS9LIPU8xlZZ6jIiEB7kmgwJyHQk4QqrDr9LTO3jrfDgOwVBJRM8Y6S47J
 ZxEYpP1+Lq3W3KQtzpzJYZtEiON6cQ53wVf6IApFCtZMppsTB+KnjvbeuH5IQ/TlGvqXnE6y/N7
 /FQH2fhVwu8wi4yAQykJ1NkWRBti8Vk86DxEC6XmbZYpc2m7pCT0+OgPg/WIiuA==
X-Received: by 2002:a05:622a:4c0a:b0:51a:8c9c:7f44 with SMTP id
 d75a77b69052e-51cbf2af35amr7323121cf.71.1783720589784; 
 Fri, 10 Jul 2026 14:56:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:51a:8c9c:7f44 with SMTP id
 d75a77b69052e-51cbf2af35amr7322931cf.71.1783720589294; 
 Fri, 10 Jul 2026 14:56:29 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm90807135e9.1.2026.07.10.14.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:56:28 -0700 (PDT)
Message-ID: <c65ac09e-b87e-4a0e-8265-c4ae27d0eb11@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/51] cpu-common: Validate flags in
 cpu_breakpoint_insert
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a516a8e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BtyVP-PJG_-_kDZFJ00O3x0g5SOKGMVi
X-Proofpoint-GUID: BtyVP-PJG_-_kDZFJ00O3x0g5SOKGMVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX/JZ9j2Y9SjBo
 BAlXBL3vXMXBHfkus5D939p8gsOTblp1tFwCRsdE449DI8m+4onwhld34kzqk9eix/LgmwcIBDs
 DSWDNQVTagadkyKJUdrgyVjgg7J6cVnt0GBUeERsca4qhgN58wCJfxV45CnqY84E8I1aQROjcy4
 BvB1D4/FoswK3xUgvxm0IKj583l2Eh/XHUP+8Vc+ty9WxVq/M3cZ2DQBVY5y5/SHnXaF5fzjq8W
 Dbir8gC24hnqdpv2b1iRnK55JkI9GYazrGWDjX3R/CroTrtyLTR/v3l+E6j/7uHx6Mwbg/N9Jbq
 f0414SRwJi911tvjuYHXeMpC2YcS+qsT6PVfhka80pxt61LVSJm7mizM9FofppizgnY17D+YUsT
 QI83cxTB07j8S/JXo6LS9H3XCny0CkJluNuNafw0Wb1InC1yiZ+PfQS/w+F2CsUBQ81e+nArI7B
 r0Rwp8tUkw98GU77MYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX5KFvPEmtL4V7
 UyT5Tk2E0wKO6u1kXgstWT0ZbsDWUGNfpp/Gr+32gGDRB5cgSmAbguCawZZKSsF9KxlQyHpaXls
 cOhKbVq7ti40nR7Mza3zcW8+heCCaf0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> Flags must specify GDB or CPU but not both.
> Flags must not contain extraneous bits.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

