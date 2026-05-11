Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4452CCD37B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGl-0007rj-KR; Mon, 11 May 2026 05:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNBo-0006LV-KA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:45:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNBf-0002MO-5W
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:44:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7ANMK453161
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8oP1PEUyx0hhU1MFWVAeskP/sv79C5mSmsH3GTVdaK4=; b=OlCk7faoTcJUn6ZI
 VtHErqpH3qgSaiAbjW8inml2FEABq/CHdYH8sG5FAoB/JAU2AFBTi+rJOV4pJRuL
 kNEMZTGFUSna8EQv+k0B/ety28jpd2b467hwdB1LwOB/iPpp8dnyliXVbC5P0mpK
 F8nSAOPBMf3ez0C7p23sjyZMeKZKUHTn5d1V/ezze48c+MdckoQyK4eJp71WJJRU
 vdBk+Oez6GC+KTYg1bx+QSX8s5GbHU7dGryJozXQMk4Lf3thLVORwO8KFuTUUJYx
 IQoSJceiQvqYVvFHcFWMDeleYjB8Qv5h3ETj7JDUZ3LjKGp47Cpd9xnM0nOVmFHg
 kFrtVA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6gj5q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:44:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51494d74d4bso39795841cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778492659; x=1779097459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8oP1PEUyx0hhU1MFWVAeskP/sv79C5mSmsH3GTVdaK4=;
 b=IOlujFeCaQwUSSSeEAlOdRnmXrpMF+j95G84ncaDt+ouSvZR7DdZ1n7njyeCC3vsRY
 ZN0CAWTZsGJgziYNC+1EkhMyQfj28nyfDUWlxikexbby22/0u+tDipivy2EePXnyyLfL
 rk7Fs06G5y63PzsE2Seutu4i6+DN1L9NdBEMmNSPISVHK1NfNkhBtE52Jp8kkX26sL9r
 S/Kcn0r1T1ee9czpk2hMCc28kN2LbLYVhpIGXLewNQ8bLn05etrTMmN6LD1V36Xja5ja
 WbY7suXySAnuXC/i0DcalV6FbR7VPfQ6LhRFBF4HjWFMscG/Ml+0Fuzfmm+rJOtnGvzP
 DUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492659; x=1779097459;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8oP1PEUyx0hhU1MFWVAeskP/sv79C5mSmsH3GTVdaK4=;
 b=aRVVNsmkUKFC7rtzTMyX4fbEuCJerXDE9Yv2EcM8I9/4TYX/8ksHGg5+f9nCne+4CU
 pcns8vcfLAS1kaFZ0NZ2dXU4QiSh/hFICj02nqTAQh98c31HaGPSslx4V1lZF0S41phO
 10nk55AKKXFLRMJ5mnRPNEX6E6Ha7ueZBibZ3Xv7mS8zm2hmrX+lyyxD8VKSfi0XCh/w
 fZuaznqT27JtqNSsQT7rTf06+uJyQBkl7iZTVmvHLTGXly+t4ZfBsvGXnjmdxOLd16uQ
 RfF//WCrbz4trfKB3iDgMHA2LGNHeGAX/4yMnkG9QLM608LdO0/SpB63n63GbNVEZZjA
 HayA==
X-Forwarded-Encrypted: i=1;
 AFNElJ837rOoq83u82aWYGih86erA1lj5a99VAtcG1c51i6d4O6g5KmS1Qa9k60McAs/XEpjUsYdjdp8dCfa@nongnu.org
X-Gm-Message-State: AOJu0YyUGpA+JGxiUp9wLKUwy57wX4VGMQi6/JEYI2+MdgZtEXq8ohy2
 CW8ZAoOhlkPUXMyYs5yo8QH/QSTyV1AyhoJIm3+rh8xoAeii4JXyC0vFE1NVyiUDCRJaaBz7XMl
 pkWVg2tCc6oAj32n6PAggSEl4BrQunFIsya/QuNm4oSefB2JvOjY0NUNH/g==
X-Gm-Gg: Acq92OG9tQvrUIoGHgscB5mZxH1Xl3Su9MNc31oUxzVY4qwlpkF8DtdXuldxbrtdbWr
 01fXSDsmN5FYHsZ21tyoHPy8N+yW6uG/oPmsbzgZ2LOCALqDU+ZW8CmFvncCcXIgoczqe7j4CHa
 O2Wi7SGdD+hyHFTjmELN9/SIVm4VkztUwvtaBxcXvKE+oz9bjSTkOvAfuOT9R2Cp/U3coQWYbhs
 +pej6mrXGYZD7tK+PpdDJhuzbJVd5T38AyxuX6Y0PY6xlP2i7+L1ZTjyJWjzkAL3TReAPB4j2qh
 IoGkYvLRD37e8hv24BDi6hiSwyZXbRNHdoCWjzUIirdzhpgWhwKghY9Pl+9Ewalr8vCP+shiZLm
 84zO+6tmNZvDErKKxHDBRYsoFPoiyH1d0HwsneykTohSXmL1lhA6Hlda3p5k=
X-Received: by 2002:a05:622a:4d07:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-51475b12eedmr234755591cf.6.1778492659566; 
 Mon, 11 May 2026 02:44:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4d07:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-51475b12eedmr234755281cf.6.1778492659093; 
 Mon, 11 May 2026 02:44:19 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5149f5a6484sm62744561cf.1.2026.05.11.02.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:44:18 -0700 (PDT)
Message-ID: <4943fcb0-0a8e-4514-b390-4a929eebcee1@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:44:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Remove unconditional MENVCFG_CDE from mask
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260511040534.2862443-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511040534.2862443-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01a4f4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=l_KUQgyWi1ag-XAO3WoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwNCBTYWx0ZWRfX8GitB6N2uJYz
 CRKS5bYBCDpKy5+ghhmLi+JaodT7ASwWOxGogC6Yqa7XvKR0y3dUfQgyGpKajlSnW1/7y93czgL
 Lmo/dXwESSi8OeMrkJuwDC41hw+oKrya4bjyxBi/n3jU3vhIZJ1477p5y8woTjCs/ScplFOzcq5
 pjuEBZmEPIQszIDEJIGIDW4lmRPJhcuZ9IJFpb1e/TmNymehXF2W/LU13wXIWbs6bFjnAk387uw
 cjEA1XnswhlOhQIcPfJ/oTvTVPhAWJfv1L8aOtxmxr2rY4zy/oRAHjpIur2KWnA5OfeU3NqWeO2
 COWeCMz0L/SzIgxsrkzHVXbCL+QmOdcPuuGnG/fnNp8i+gcXVO97zh5qBhC2sEjjIEgeLa/9L2h
 XeTR7jwXiFpqRoTJyegrz/hJmpshaAYiK4VqnNRInffbC5GPbbCASvj4Ww8YQ5ZR/ck1NhkAFWR
 wvIbgSkmmr2Nq/GGXGg==
X-Proofpoint-GUID: SjlXUQmq9YDr0DBK-TFYbIjKl4staab5
X-Proofpoint-ORIG-GUID: SjlXUQmq9YDr0DBK-TFYbIjKl4staab5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/11/2026 1:05 AM, Zishun Yi wrote:
> Currently, the MENVCFG_CDE (Counter Delegation Enable) bit is
> unconditionally included in the base write mask for CSR_MENVCFG.
> This make the subsequent conditional check
> `(cfg->ext_smcdeleg ? MENVCFG_CDE : 0)` completely ineffective,
> as a bitwise OR cannot clear a bit that is already set.
> 
> Fix this by removing MENVCFG_CDE from the initial base mask. The bit
> will now only be writable when explicitly granted by the `ext_smcdeleg`
> configuration.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2601/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..f6bcf128a147 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3175,7 +3175,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>   {
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> -                    MENVCFG_CBZE | MENVCFG_CDE;
> +                    MENVCFG_CBZE;
>       bool stce_changed = false;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV64) {


