Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12BFC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdCnc-0000HP-Nq; Fri, 26 Jun 2026 16:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdCnH-0000AZ-Aa
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 16:04:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdCnF-0001I7-ME
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 16:04:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJahHm2324890
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 20:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A2/FU1xLbkYV+voT8ssCBTyWdlAce5DEF6tSBKrrm58=; b=LGRZruV9yePqZDOs
 ZF6ReJFumsKC3VP7OkcxcZhkCaTu313AMvP10SBkN40/k3b/dWS+0NSFlBRhsGdb
 J2973F/vPHrzcAoDx9VImWyFpBaeCLkRmqay7fazprlmwNsVbmehZTQbgf7/5+b3
 O0C28rVJ8TkREvTbbe83E+dt1TCnkkbXtpnqQ4EKx2FKyYuJktwLFXMPz8naplUe
 J+4a2PLwJWkEe+bXgSJabnVfu7NKf8HCuwn/rFDi0lwssuC3kVu4aveHsXUnE5IA
 hSHenjHJzjjdFvFmbOGYpE6Z2ZZhvCrSMubLq3oEFMfTrK2ywrqlwbyIw+ZSrZz7
 RBVdaw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv02m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 20:04:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a87264ea5so13396231cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782504290; x=1783109090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2/FU1xLbkYV+voT8ssCBTyWdlAce5DEF6tSBKrrm58=;
 b=SvdJacSWirwmn1LIIbOJPznco5AW7qCEvZrRLL5uaJMZtBQPuJUt/8ZlsMAsq4UJ4u
 dtqD7zpVwYp7K+lt0GaZ62O+nQHs3HyiYsmjBTGTdi2YB58cYdWMFt8fURtL07Hwd+DY
 YNbeX5d7Zm3VXHcfctQpO7V8ceNFjZDobw8BeLAtHXlgmBXxBdjlGH1jTo8UGwt1Kz77
 rYf7KIojBFn+8LAkI7VQbr5xc6+DvF/L9h23cGMmU6W6OMBU9M30sbpsjVb3lUfjPBSo
 lsEi7W2a8HMy2DCv6Fs6P4joBs0c2+WINmc2I5J9ccMgH3ad1sKFxCV3aj5kBuYzXEs9
 p7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782504290; x=1783109090;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2/FU1xLbkYV+voT8ssCBTyWdlAce5DEF6tSBKrrm58=;
 b=pJrZ3h1K4s89jz2FbbvfMbLKw1GbsnGdQnjHTMVoxkpAU1xt/WljgDUJNmVCEc1EeS
 3MceX0liIonpQdyRyQDHbrzQbSUiPQGV5Re2ZGVyAPQOw1NUvJFCDSRrwnqsngTzkz6T
 joIJSNHzDKHmUWDF7ieBHZ4nAL8AJ0Q4+kGWN+2SURufrvSCbn/d82RtAHGXzcUKVnA1
 1gqO6YBrzIM7chU5qYYmIrnu2raCXLc0CkFssCxJpD5WO+aDCOv22Ukd+c+VvLoPV9TO
 Hh6BFGv9PqmjX3pzjN2cIqObZ3ObUDQdG84ONuDsyBG8xCELUNBwcZLba70OubGzYe8M
 DKQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vvN8UQfnWEEYsYgoa7aaxJYeoSGsWO/S+tGeUyVh9BEW94wMdQ3THg2gXJRlWJI7GOmC6Lr/El+6U@nongnu.org
X-Gm-Message-State: AOJu0Yw1Bo1x+opsP8B7+DH5Elg/V/DA1Gypeg29rBSFPtpODWcf+mfN
 FMNM1eAXLLK1rQGxYh0xmEPHanC8mLGftFRw77XfV+AJJtg/JMTVXC03zB34iBV/M29PSZttGzz
 4yIPeMYagO9z8dX0rVHsDe9//sCGBDAbIhOMgCdzqgrRXAUpGr000aiy7zw==
X-Gm-Gg: AfdE7cmERq8d7Md4TQoJhjITmWtF8PJeQ/sX0nBKt14msCLrYDWiq48bGSv1FNi3Y3L
 ejSbgeIUR5+eHHqpdTsyXwtSNgo7Od7FUw3OBT25DTa5Qey/9S1Cytp/2pYg35RGyZEWeomQg4v
 xkcorh/LZZDrgN6Rx1LOfN6kZnm25PwKLhQpRmcWl8OFw6Ma7g3o6s9SYE/t6sHOUrmP+2G052y
 EHnqVAJ9L+v5CDKaFhhBDtz7D0x2gJ85TbbSvDvjviuaSAasw/WCUJZ/YJZ5Bx1MAVq/4kTlGbF
 E6flIeQPLrWtJRBOWuY0tPgjIj6Cwgywd1sORxE459Qb5Zxf4s3Q2WpI4rm4v9woRQE78X6QTNG
 49oCOBe2VDGHL90z57PKawk8Z5m+xJcDwFm9uWKCMlR6i
X-Received: by 2002:ac8:7f8c:0:b0:517:5b22:f4ac with SMTP id
 d75a77b69052e-51a72758a91mr114057301cf.5.1782504290347; 
 Fri, 26 Jun 2026 13:04:50 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:517:5b22:f4ac with SMTP id
 d75a77b69052e-51a72758a91mr114056561cf.5.1782504289763; 
 Fri, 26 Jun 2026 13:04:49 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51b0cc9csm102941891cf.31.2026.06.26.13.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 13:04:49 -0700 (PDT)
Message-ID: <1d9f53ca-4dbc-4d64-9811-17bf0328cb3a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 17:04:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] disas/riscv: Fix 6-bit immediate extraction
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com>
 <20260626-b4-disas-xthead-fix-riscv-next-v1-2-74228a3c1b21@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626-b4-disas-xthead-fix-riscv-next-v1-2-74228a3c1b21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3edb63 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=7u43oJkrPVBKl2x3A14A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wfy751D9nUHc0ERMFcFXbpzRYvpB35Ib
X-Proofpoint-ORIG-GUID: wfy751D9nUHc0ERMFcFXbpzRYvpB35Ib
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2NiBTYWx0ZWRfX/V8y0E9oMN26
 qA3LpvsIK5P6bYQAx5XEtZ3it8B+fePFd8WTHug2sgiAmA1rJSj2toWJ9Qihjqnzv5uGCuKRlWr
 e21uE7v4bt8ZzRGbmMS5A0xm3sYMo/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2NiBTYWx0ZWRfX3Op0T4+kYTg/
 XRj9ikILn6fzc6rfpjf+133XncGxY4nNJL+SQu6VTqeedzxur0J/V1/J1cHHL1btJuavwDNc6BJ
 +6lnT+JzzjGzn/Mooq3OUIkIt6aY8ItxOZGx//mUXFb6Nyj+cAJkWsrYAonkQvDcW0mSi1IFi5i
 J3zC8NA/yQEkPB+KF1KSRB0xzmefETjXlJoOEH4lsX3WsL68Y+2kHS+hjQgSWD35LkLppuoOFaJ
 a5kt+42r0LElDNOr7Pcs6/bSk0shQZ2Z+BoCVWjR1Eqi5Ka+qB/vEUp5QK+LwreyL4jTjSRPQU7
 0LfeFy2Ue0w3LWpZNujHLN0oAO53M9xneFPSOQodbZX47MS3dpR8ZKsYNcM4Fy0oXEOPqpn4lwP
 PNYgD/DJiVrWinsY0mjku1PkmiwTA2+nAjWM+EwRHu1Ew23nfTZoZl4w0uHHkHDV//g3PAQGcDz
 pErCqeNiI++6Te9rUkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260166
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



On 6/26/2026 12:13 AM, TANG Tiancheng wrote:
> rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
> immediate field is encoded in bits 25:20. The old expression
> left-shifted by 38 and then right-shifted by 60, so it kept only
> bits 25:22.
> 
> Shift right by 58 instead, keeping the existing extraction style while
> retaining the full bits 25:20 field. This fixes the immediate printed
> for th.srri and th.tst.
> 
> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7f1b26277378c225c963d8f435cc7a2fc6e4a0b8..400a57083f90be18ccd12415797bce0df974784b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
>   
>   static uint32_t operand_imm6(rv_inst inst)
>   {
> -    return (inst << 38) >> 60;
> +    return (inst << 38) >> 58;
>   }
>   
>   static uint32_t operand_imm2(rv_inst inst)
> 


