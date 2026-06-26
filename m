Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B7FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdCnW-0000CF-KP; Fri, 26 Jun 2026 16:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdCn7-0008Sh-8g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 16:04:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wdCn5-0001EI-JX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 16:04:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8h5x1682085
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 20:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y38j6Xdah/A3WTELcJ8HGxsz1c+xI48ymFQrxLd+uok=; b=eaqYvklMWGfUrIkB
 vcWG8UzAjMjU3i5pjFXMxpmEiWo6lq8KaT2MHKhGnALorUAgpoMCKGAy2Wk9FyYw
 tvFNn4J2s6kRkB9XNFDyNALK2MvQy4NmGzVOhu9wQpC7m2aDGlpWryMuSsaaM2U5
 zeDTFPFsk99JP1U8+N88XQBUvLcJGlEvYHbjKRsvSK4+Jdbg9bc9sKw8eQh87ehF
 gCZWExaMe9ZG9/MxL3A+rGcaDTEOlz8ESHfpfLoHRGgxYSih6sLbX5sKTlCyPfUo
 D2q/wWo8z3+fOq1sLGjxrWx+YaiD0keN9Q+Pk958gzVhiH4XbRhkuUwD14R+RKkB
 groebg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdv1ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 20:04:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-519899aa6bfso22366451cf.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782504279; x=1783109079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y38j6Xdah/A3WTELcJ8HGxsz1c+xI48ymFQrxLd+uok=;
 b=jq2/0bGbG4OnIvWfIqRDwUnRY+YWs1NSodn+hNQSG3DjaYTktlXdnY4om4Pg73TOjg
 Cfn1n6sgAj/fBlhftzPdazCtnlM1qhy/x47Pmh/5ErHTbmUgzd7LaLdNaHlKLZvz6A9o
 jRsLz0zUiUFkQXdtoESE8RdR+tnoLsqfJW4ul46t8CZ+DI3s7nil6MU7s1h+s0U4zbYX
 7a8Xk1UJOL/mXvXhclgm1L5xzH/77DQ5zi85wk04eJFlCPTdME95nsDy5cnBb4/Id9K4
 kApxA6u7R3IKGqCpIkBUC7F0akQiTJ4JizmFvIyzR8HR8gmFd0p5sIYSbAUvfacdfyRP
 L0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782504279; x=1783109079;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y38j6Xdah/A3WTELcJ8HGxsz1c+xI48ymFQrxLd+uok=;
 b=YVinLBOnC+/xGAW6lXH51ZlPMIrR9QZELKZmtvmTU9qSfOD+pKFUOrbyUbsYug/iuc
 hqgouIkzo7POHWcgOZtPKS3M4cVn/3X+Ji1bPpix2nGFKezq5+2H4Ocw4wDwGni1a/jr
 eDNfM/RZYqFUlgDG8s8o1/g+MzSb76bNNHneL9ANUIqUzMUYL0WwBxXBDQGRRrY+wF44
 3lVtZpklnXFyiGB7vFcVybQgK1a1xsWIh7KLIQITpUfxosNiggEeOQuYwnHxRT8sve9J
 p8Tc5WzQ4SA1xKnyRg/SFkagupvPL3NG5ZMw5cFk9ioQ92WMHbXyzaqUlGjFqzjvp9SU
 BmBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9x+8ZZA5FPXkCR+68IciJEIroalgO994M3XA1cucTZXc6nxsnax5d/61vSJWRaPFmtrGJpBVC7rtqj@nongnu.org
X-Gm-Message-State: AOJu0YwrCGVncHQAcg3Za+Z6JNLzGsiDL3Q2lj5jnIYPxooXRgcMzOv3
 s54PpyQRrlmwK6q0W4Vobl2+t3reeh9f+5M5gU+YkOE+9R92FCxpvfxMGvonIw2RQbs3Qq0rySP
 ITWZPseQV0k4MhR/3IfDCU6ZwQivY9VS8Bd5r/g/L7ll6QQ/NcpmqehEQHg==
X-Gm-Gg: AfdE7ck0wULvlyU+vTQOgP1wd+14HoofAwzy5SzzwICiHC1+73J4iYQpWMssOGSDpV4
 xeTKm5KpaXN51Y5d0loF02g1gvssfTh0je7CTOrYhcopTzHWg7Q+UxvTqQ7bMmcuvr/LaT+9qnI
 TgY9KbjXAIxWuyS4vnKigI2VIdMYtJD9aAg+HpH19afIqwiIh3xE4l9t2prnWTUVFhRc98aHQql
 vogm4dJ0l68NEYuqjIb3+MJkU7i2NaHpuhPJCogj7sdzqnBXhhL0VIOL6DEnDMpIO8GsnRiaqdS
 Z4M2i4cDj6Ac02iUOZF+k1f/T0UPqji8Nq5eHEg4ZlPWaOkdK7aYxfqEDxH5sq4uhr3Fdp4SzL2
 q5LbqxTNOSrzv5r+oOEW1RGYr6klOMO09VcN91UrevalW
X-Received: by 2002:a05:622a:1a8d:b0:517:5e32:af23 with SMTP id
 d75a77b69052e-51a727ad929mr119369161cf.23.1782504279396; 
 Fri, 26 Jun 2026 13:04:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8d:b0:517:5e32:af23 with SMTP id
 d75a77b69052e-51a727ad929mr119368681cf.23.1782504278874; 
 Fri, 26 Jun 2026 13:04:38 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a514b5271sm106828621cf.5.2026.06.26.13.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 13:04:38 -0700 (PDT)
Message-ID: <e3494fab-e080-456d-aa9f-db65ca947b89@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 17:04:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] disas/riscv: Fix th.srri decoding
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com>
 <20260626-b4-disas-xthead-fix-riscv-next-v1-1-74228a3c1b21@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626-b4-disas-xthead-fix-riscv-next-v1-1-74228a3c1b21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3edb58 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=QfbnSVPwDX3jWXLam8QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2NiBTYWx0ZWRfXz3p6P6ctj4xN
 nbDDT2+W424DYwkDpLxF2eNfCFOZhjdxtgVASxhu2YV2sMGM2yLmc6Gv7Ni23piRPfSEZgFqvOM
 ylu/J3Rhm4HWqGxyOpXfyqMmPi3F3Gqf1n0sjisf2EG2gu7iqKccSyHp7W92klHdLCzRIeBnO8D
 ahxkBUeSBUoWO3c5UGOn/QuC93nA8YhPplHeuGrLH5cGFEvkZKZbM740E4F+2JhASYsGZw2n448
 3RGGAaChEV4Opt3yUaDU50yKuRCAL5qcea8Vwkp0GPmVuKUpANm2y+jyfGYdgX6lUte6cgtunbx
 d/lhRSdIT/2RiVdU6bJB/GQgzenBmRbZnboXfeOR7jWpqeFL0fd4Kj7pq4KPqF7L0DverUDBIui
 3kTEEggU3mZD/DDA9o+qgdDkPhmMUpX4cmV/tfdsjBmBigEaUuGLWIG0CVkwKvmPCdvaiK9RHcq
 bUPXsaM0k+YJpqTMqTA==
X-Proofpoint-ORIG-GUID: kT55ZKraoej_7OwARWz-nzV0N4Cfha9O
X-Proofpoint-GUID: kT55ZKraoej_7OwARWz-nzV0N4Cfha9O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2NiBTYWx0ZWRfXwAO4faVSL18W
 8K4JvrMh1g2p16CvJWrapT60tOy8cJtVra526QOlI8OirCG74i1uk96V0VSsufPpgeYaIbnPHlB
 /vmYHZMc4Ufq3/gSpjz3UR4mVKUoebU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/26/2026 12:13 AM, TANG Tiancheng wrote:
> target/riscv/xthead.decode defines th.srri as funct6=000100 in
> bits 31:26, with the 6-bit immediate in bits 25:20.
> 
> decode_xtheadbb() switches on bits 31:25, i.e. funct6 plus imm[5].
> Therefore valid th.srri encodings are 0001000 and 0001001. The
> current 0000100 and 0000101 cases use the wrong funct6 value and
> decode valid th.srri instructions as illegal.
> 
> Fix the cases to match funct6=000100 with both imm[5] values.
> 
> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-xthead.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index fcca326d1c398a6745984b9f5d90fc5f7d54dfd9..2f2ddb8dd9a13e17a28539b4179cd10fa93c5941 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -315,8 +315,10 @@ void decode_xtheadbb(rv_decode *dec, rv_isa isa)
>                           op = rv_op_th_revw;
>                       }
>                       break;
> -                case 0b0000100:
> -                case 0b0000101: op = rv_op_th_srri; break;
> +                case 0b0001000:
> +                case 0b0001001:
> +                    op = rv_op_th_srri;
> +                    break;
>                   }
>                   break;
>               case 2: op = rv_op_th_ext; break;
> 


