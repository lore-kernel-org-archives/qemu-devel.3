Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7229DC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbPr-0007Gk-DK; Fri, 03 Jul 2026 06:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbPp-0007GI-JI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:46:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbPn-0007Tp-L4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:46:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rnal3123794
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MBIAIG4ETM51WJopral/r28AURCJLiayPssGKpcz7Ow=; b=WUk1weVcqAAIcHqd
 zvvnOlZ0EAtUQyCbwgf0fNk8wsH1Ll9VoGrS0diroO0Sw4fZA/YEEktyyjflBj2W
 p6LYe7ECgRoaapLd/TYglFxiBBcwCOMSF7FM5fdRJmLf8Mg3gn9hrydbWnOMsZNH
 bspYqewOq+AT8m6NO/GRuUVDWcneZqWwDjYXvt6PNnLAVBAy8M6xF8htz/j+xdyE
 VNbQUmpVJo6CYgNnZ4yHPHB2urDCDkdKnkKsv4WeBuRe6dJ3hxpHCfU1QfCr9D4M
 51RHy4/HGbxglXwEHIlFoO4QLs520tuiSVQefPwjtN7TBYBfrQyz9xQKYbYQV1UZ
 JODiww==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpcwt8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:46:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so44517285a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783075594; x=1783680394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MBIAIG4ETM51WJopral/r28AURCJLiayPssGKpcz7Ow=;
 b=JtVSiDNfhcW1gRtSqUsFsDYSQb7aM/i0OWEIVMirYgYvEGlp221j+X3R25zV3hvRje
 Bnep9wp6PcYMXJi9/m3jRfq1qI5i2KEOsi7NlB1eGHUhJUkgvAeXN8qrzeBJyI6lKRQd
 kKqui04IKG83qJeq+Z17CCgm+WklDPiVXLQuAa0wH3PmQLIumdcmiycXHw3FpwahthQi
 +FxgeMe7z/UcrCWI2E/6g2q1/kqC2OgzsZWmChsDZYzId7KMUglTUsbayXFTDs/JUbSb
 uuQqnshHK6uXe3yoJHr2A1IwPPBgp6JJh2SuEoK8ocxPuUq56qn6y8fw51LdUo31zdWa
 vAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075594; x=1783680394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBIAIG4ETM51WJopral/r28AURCJLiayPssGKpcz7Ow=;
 b=ly2M+dBq9/U10FHgpbuc9qnGsEEis7vKdGUDJXo355eY6LHP0ShhZ6bgJMSeR+NS6m
 vOgm4I4i+E+g+b8+30OKXPRKBhocSorXewaIvRUoQhE6CTxO9agxSbcN0g8ALAEmmmvr
 IXHyI8dTIYdvoNW4QiU4OuC6UjMj6ZihvjX1Hc+2fmKVuPNnSIZQM5RZdmKkzqp76Sej
 Ivlrw8D1ExhW2pBHk9ek5INQ8uwd0wqUvcOTzjI7Tax09qpuVbdARyRPLI8ji5Gx2g89
 1cORB73upcscqO0zVrC3QaLXM1RQQKEm93ZxsNnvuKyk2B64NASPWGUrwmyHgitZeZSh
 xUMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ++67XDfgiKm2sEGZj5KeUgQYiDr3RsApoN7jOHHSfLrHeX2TFGAulbjALOr9AeJldVXaK+ydM8XWA1@nongnu.org
X-Gm-Message-State: AOJu0YwPv5iunZlLmEVDIYj6Ct9g/UhyTTvAHBgF/qyyFlNmg4zg+UuT
 M11HEfza8NJIyB+aWYWusPrs0eM5jb7UAROcQBtFhkW8m58Xmz/c/cmLTTcTeUuB8Zp87+ULab/
 BX3vDzMxkNWvjAkocdfNCtlPMfmAkFxS0OF9ZxdOn9NscHxs3zVT+7ONN6w==
X-Gm-Gg: AfdE7clnx4Q7mox1tZ8YmQD+p88md5zf0304JzBdLq/mmYeRzEiuJl2QsUkHzKLwrhQ
 UgXsQtmif/RA8GNOEPsJf6WXqlY9/hJ8y/hf1FVSSTSk9CZq7zdZKagG6ve3jC8budlIjQetb+7
 KfOKLtlfufRQ+mBscIWo1wTMsgSWJ0mjJXpuyt1eo6H1Tz+2tbh5t3NcQW4GlFpDjAgPRUQC4BL
 vNPtC76lcg1bccLfMh5yq0fDpSYGxV5wMy5E3ocC14/OFcmSL+1u7vrM14fHMKFVEwzWzlDuUra
 llvAIeqoKML4JQU3b9ruRdwWKyigbnVVG2gxHcOkUqQAUo7JDrZhKjPyfo0LfCk87vrPhV7+ouC
 7OF8uVFW02hNx0CITqYjQKgkNgeArnjRcGWJOHdMlVzSpn43+p/V/hbggIcn3JA==
X-Received: by 2002:a05:620a:6013:b0:92b:1233:99e with SMTP id
 af79cd13be357-92e784d1404mr1297587685a.35.1783075593916; 
 Fri, 03 Jul 2026 03:46:33 -0700 (PDT)
X-Received: by 2002:a05:620a:6013:b0:92b:1233:99e with SMTP id
 af79cd13be357-92e784d1404mr1297583285a.35.1783075593325; 
 Fri, 03 Jul 2026 03:46:33 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94cb59sm18089477f8f.18.2026.07.03.03.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:46:32 -0700 (PDT)
Message-ID: <f34bb96c-d55e-472c-b939-ed7260dfd9f8@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-16-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-16-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfXybyJICCsNSMZ
 sMrpYBf39iCs5ZId6ldKi4yUI/CObsj9wpC3f7HrVzPMI5TAMQra/xMB24kCradoKnb9xefBiYp
 BrtIFs/Lr5yT55eQkYexbrCetJxkPmA=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a47930a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=GjH8pot8HpESF7PzaUYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfXzMNbaonvkugd
 nf5T+xsiYFcE6REeD9/PwSuiXvByssqZZeVF/5QJNuLs6nYXSeOkKD5oXV91qGQGinESnN2xtXy
 pUk/f7uoXKidRVRZc9m5cXElZIUi2rmB4vGETureA2IUg4qEfX1pqNSrha43zYqks21zaRJZDpf
 8J32uV29q70T0S+1zOexCLEnBuePorDIP6qYTETqJ5tVsn2IqThK+QHUPKv20ImA1qhyyyQgspc
 uHg7PA0lauxa2o84uKnDPR/uqCfc9ILqKZAjP1sMfFTCkVR1QGWUNbFYFBgC3ywGY6clP+lTu0s
 Hm+K2PWHDP0IKyflPKUhJfYlPtQM68mL6hMbi4tJdK3usdIDAtALUaUPtMgIH271oUobCvmLdkM
 KtRl/+DlGGOGJO1FVU8bgkcHRmpcTNEZsw6c0/g5Blk4+kqTMSDSjzdg4ak/9AC72WtMq4UG10Y
 W794+rFPowqFKXtGUqA==
X-Proofpoint-ORIG-GUID: oO6bqsSplNXPYZckVQ2KyIhzXd37a4L7
X-Proofpoint-GUID: oO6bqsSplNXPYZckVQ2KyIhzXd37a4L7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> riscv_dump_csr() is a TCG only function but we'll have to implement it
> at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
> ifdef while making a note that this function is unimplemented in KVM.
> 
> The csr_ops array is also TCG specific, thus the for loop inside
> dump_state that iterates it is also TCG only business.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

