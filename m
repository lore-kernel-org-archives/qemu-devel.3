Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23DFCD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGd-0007Nh-Er; Mon, 11 May 2026 05:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNBX-0006J3-QG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:45:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNBB-0002GL-C7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:44:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B73XIZ3544308
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kEM7janf1TKGYuurcGyVjEckLbQIeJ9ttI4EQ14vEEA=; b=bP62NoI5dly6zWWe
 z6+0/rvtVmEbgLmPxhDQQxDkmmgpie6+dwuYq5syxbXKvi7VNd6P/i2eq81/JKQl
 TW3JHMqFaFXQe4XZpGKze1t/B5Bt0pJ2sY5UlpRV/QGM5jLw/llflwi6gImj4DiK
 niP6Xx+4P4olnSSywNbx21t9v/aqgsj0VkvXHgcW1iuKLanBZYn+mc2AYuYhnoRj
 gP1zMzT6ppm0qV30avVig7LviaFDr8ibsNIRqmp4G/d1N2E/iG2hznGedijmcF5u
 qLJggUybhYfXhtObP6b7rH60OJRwTGZYeJqGLDhSwOICW9GSBBaPELGkTS8XokRP
 NvTt+w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dkskn58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:43:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eb21daf7ddso532036085a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778492595; x=1779097395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEM7janf1TKGYuurcGyVjEckLbQIeJ9ttI4EQ14vEEA=;
 b=bFqVB8tcjNSFyDBlTEeM3bgtrwfEK1PQFtRj49o30c0UKZA+vDBxI6/9Ljal3V7+tZ
 7oJdrIWNq//tEn5lreq7LxaLuRHMb/AyOu6lS7r5JvhiDl14D0dzr3WaZ5O2N0KxCx5D
 pqAwcHvoEUi68ZbGCYv5v5edzSvWa6Nb0OkmC4f3l0qFk4nGhw/RsaPlSn6OchOmH8O6
 mVS5dmLUhPJxralXQEcgAH4cyqrJU8qWP5Jf5FKVbWuOyz5qZS0M1Ajy1OQRP/KcErFV
 5VeYbaQCXHDoDiH9AJ70/xyNcsMUb7zDKk2XV59HpU/L9MDLxx9O3ftbpnnIv/to4j2F
 2fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492595; x=1779097395;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kEM7janf1TKGYuurcGyVjEckLbQIeJ9ttI4EQ14vEEA=;
 b=llGJ74dVKkZ42r2ftZcwztfM8gR62601dNSgM16M5xjb7i3TBHL06n1qdpCIbYBRtL
 NKnx7+XOk70BAU1sjC/IxUNtVo+Zgp8yYRhMmjpgYbRzHU7i8aYv+8ZbdwWXWCSZpvCn
 73yNF/dhRKszREI2tJIoGh5ays2Czu7ARtcVyK6MoucKm7/G47N3Vx1D38TjDcyUH4vM
 DElg75vb2DPz90w2j9BZUVIXRwU90/YFom8g+kqxcZ30+/tQKldaQ0Md2qfUYt7NYfaE
 W/1hFPVevinmcLUkTLy730UzV7ysG7Gu5jJiFMBBH+WxTukb8D6xTEypHzVHC5Po3VR/
 5FcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SCPpDLGd2usrTRFjud1cqyop25iJR0f8jl/Ma66xtsuBt8mCBu6P65kBcAJrKpQDA3szgpRX2FtNv@nongnu.org
X-Gm-Message-State: AOJu0YzKVwDgGb7hZbfta+tFqEPOXK8pBGvMjvcdIHCBQvhnKWyrLPNX
 W0z5ErmjsNzO6gTmeqdfP2B6G/uETr0gOg4OHM3Hicwh3RYALDOkECimQg0jbxkQoPK+oEmIU96
 C4JS0HlaMn+KQcby9qk+HvufmDfQIdmmFbhD37BJokGyRAdM1fsCwD6prXg==
X-Gm-Gg: Acq92OEkEhTeKUch7YsRPmi03rof2ll9YRPButJVEuu2ZoIJ7tE5/QEKHT8BHMd9ou3
 zzqr7c2x7TFiQNu60kMKRXOILEFatdWw6BYdLP0xXFfp/WjMlLbMhP0b/1Oe1rkAI5AWxOBHdSv
 FRT8zQN4puKR/NARaTLS5Kfs7uH7izCS6pbGH6RtPsB7RvpIBsD9LtpSNUfN1PevaTPdu6Vjq+T
 eBy5IT4rk23gMr3O5JZh8k5pggQKDCOJSPnBbqsJ5Q2BvbIuMuZR8aJ7a9s94HLmVPRrOTDk4on
 CBj454ipJWHldc900u4maNDvZm+cFJH2qxl4tUJZCtSrO+C+Hh0gGlYmbKQfoXwagR8FItLCb1s
 mYSVK6IXUHt5oqwbmoS+WRjmuwJg9mHkYVv8pCSy/YhnWGxvVksAVXS347Ug=
X-Received: by 2002:a05:620a:450c:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-909110f9f69mr1249103685a.57.1778492595484; 
 Mon, 11 May 2026 02:43:15 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-909110f9f69mr1249100785a.57.1778492595074; 
 Mon, 11 May 2026 02:43:15 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b87bd588sm1078656585a.29.2026.05.11.02.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:43:14 -0700 (PDT)
Message-ID: <1424f30f-76bb-43e6-9700-cb40eb31b594@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:43:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Allow mseccfg access based on ext_zicfilp
To: Zishun Yi <vulab@iscas.ac.cn>, palmer@dabbelt.com, alistair.francis@wdc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260511031424.2820713-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511031424.2820713-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwNCBTYWx0ZWRfX/6TDZrqTmU+m
 MYlXVvoIIgYk6shLylJ5EyrtpN/bj+LwoBbjOk+opvSJW6pwNp7Je2sB5PMFfSuEC9Wf/Xp5rBo
 kZXrZDL61pGHPLVhyeglTc+mbifKEQNC5QgUEiexchSU03ZGP4z5N3AooXFbWmo5865bPRXRZxU
 j7FT8fx53d2nXRPEfN0whoTMWEqFAkR3f3RXa2KT4Vam+SqMHnTQLAubkLIRqxp9mCpRwj0MHGS
 PQTCnLlZ2ouLct+Rqy6l69sALStozpeva9e+/SSMVhRc5W8FRtRleRrKfZvbTsJ1dG3mxxSdi7r
 IvdFJvyGc1kb9EJH0auJc/vZp4mgRAVOCkWbkas515yOr3l8mwkOzalmKw9WUq0TktECWzUDS+G
 iHCW3UPjGfcpxg8iqxHJtUSLmtLawDYmxe6qaOspAbud29rHyU3B/hxaBGuzSyugFHcs21QfrHM
 1NMtLDae5NpRQZe5XvA==
X-Proofpoint-ORIG-GUID: 133YBjQzMnUHX7gTcyaySP78hfSsKZBT
X-Proofpoint-GUID: 133YBjQzMnUHX7gTcyaySP78hfSsKZBT
X-Authority-Analysis: v=2.4 cv=cKjQdFeN c=1 sm=1 tr=0 ts=6a01a4b4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7WufM6Q2AAAA:20 a=mDV3o1hIAAAA:8 a=rGvZjCNGmgrfT8XSmwUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/11/2026 12:14 AM, Zishun Yi wrote:
> The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> to the RISC-V Privileged Specification, mseccfg exists if any extension
> that adds a field to it is implemented.
> 
> Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> with `zicfilp=true` but without the other extensions, accessing the
> mseccfg CSR will incorrectly raise an illegal instruction exception.
> 
> This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> is properly accessible when the Zicfilp extension is enabled.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---
>   target/riscv/csr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..40b17e773236 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -17,6 +17,7 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include "cpu_bits.h"

I don't think you need this header.  LGTM otherwise.


Thanks,
Daniel

>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/timer.h"
> @@ -783,6 +784,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>       if (riscv_cpu_cfg(env)->ext_smmpm) {
>           return RISCV_EXCP_NONE;
>       }
> +    if (riscv_cpu_cfg(env)->ext_zicfilp) {
> +        return RISCV_EXCP_NONE;
> +    }
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }


