Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E3DC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6szA-0005LV-Ey; Wed, 16 Sep 2026 12:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6syp-0005KA-M0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:59:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6syo-0003s4-21
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:59:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeEsX3365364
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ax1se0gNN/3xADnjjnXr8VaFvJQk4FnZpZLtXPqOqRc=; b=ZVuqH+h6vEsFKFs1
 6vrK4hLCVW4SID4Ko8jqDUz7qtOPnxUWIcSJy7fVYVyhEc8lttmCcqGDD9OIbzod
 J9i57DIc17Mf3EPuMvEIKv5laygV06AzqSG7APoP7PFHr4wL0l/jiHxxWEEvJm/a
 xQUjG/xHXPYMnZ6VVqAT74P3+LKRC6LswQ1TArpbruq0+LSygMwzI4xyenBsEsiO
 H0Potsp/jku9sN6vimY0Z67k4erc6f0d6QEGUJEpGPQvagZuEFb2vMc/dOvG6Xqc
 hl6JUBgDVHFdF4Zz64MuUl3xQozd7+rgdjVPdE5JJPBagp5fhPc2Sr+/5Vr+UBZm
 wXZS9A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqjckuky4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:59:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so7074485a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789577968; x=1790182768; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ax1se0gNN/3xADnjjnXr8VaFvJQk4FnZpZLtXPqOqRc=;
 b=VFLaa0WQ1XEsUpSwA389/S1kjTJUo7YDWPLpi2lzfK/LB7IOi5PyFl355oSc5/Qg34
 hsMduPM6vmErCHnhh2For3weCI0pQdGAstzKXCsHnPabujOD2cE0vYhvKkg/XhXYSZym
 tB0JBQDxOWMSIVlDswIcJw0BKd43180Qbx63lqyWCnc+r7LooVnezAnAg24pEc15Bhnm
 YaCt0Ioo+jUcg+XIetTGE3slbHyfF8qtySl4AeOHnkPwwOEnaApUSYiL/3b9rugyWRZp
 +dezx7TysvCr776QbbK1HC1eK/rppvt9p+TtZDyCQUXfL3thK25ez24qS7MBP+7vXldZ
 I3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577968; x=1790182768;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ax1se0gNN/3xADnjjnXr8VaFvJQk4FnZpZLtXPqOqRc=;
 b=Nr6Q1tu176LowoFxXw2LZA1cRi4zNYsHmM7ZwhmUoNwhc3rvOtxDmUTOJcoji02fX2
 bifdhFUQS9mcNi6noVSfNwyzCEoyHhUMDXPKdZ5xhVfbpqF9tf7h/E2lwMUpjbqL9TYl
 kmRDnMsvGQwOdbuExip5ZLMIjUPRluKwP0xG8gWX3cSUWTEAsrU7GX1AShT/bF4Ucxac
 MRqSmjoAHkYtkqKNY1IXpYZpIuDuRBsxSMDX46g02dYi8djUn/uPyXhKES5lxlX1yHQr
 73f6DegMp4jIFuOvZivfsjVDCfoTnD7AAkz7k2eAkHAtiSM19sg+NEYRabYg9QPRWyqI
 OnsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcfBNJwfCvlqSEraVoQsCVgX+RzzpBgUEI6EG41xbd1i86E0cUP4qf2RtFqzzUTH1NBrXSX7j/Frfd@nongnu.org
X-Gm-Message-State: AFuF++mOu10RLgsAnYdHPm9XYbomezD12Gvz6XEQOMkI6nRgxLLjzCVe
 O+HYRUZApICK+dVi522qagLMEluKF+0a4mN1t+F2Cg0TCxG6IJd1Zfk67s5rWPr8/QUQPS8cRIt
 7Cp0dUP9Tra80jONOG3F9ys8NeZoGIKMSnbXTDgNCR0zXHubC36rltvRHeQ==
X-Gm-Gg: AYBFou3wix3RBp4NfBFUcZROxdBG2g2VToZix+WWfrJi+TTtEc00EwfXwD50HzSmLpr
 i/Mb4Qo6PPFc3NB5uV5nrAXAtKqE4n/8yXkfXYqTc+lB2W8K85ty+Bm/G6zkAMPhoscRe25zTYy
 bdlNqpC1W/m/pjMb5i4CsM0o0aSRufWxoIx/IYPxtKxQozwPfj56c+ahjenSQYVYgS99yXRKwu+
 Bt6H2KlDt3AtvHSsozh6kekSR0dve42f4qsmdEqPR2Zv3mzqfIpkK8Uu2GsJR4qNN/1OJT4eKe0
 FMMQAteRYaf49+6egAk6v0tvfxQKVRZfAjnKZaA54L++vMrbdzQGUxXlW0DC02/n7AatPcdUwXE
 +/71sgQTyma/bLw3cgadbKX+IsYGzpUkuqTW4rol/+LeVXGGo6xG6KVAlf7O1iDAxPV7J
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-39e1e2659a8mr8229132a91.1.1789577967619; 
 Wed, 16 Sep 2026 09:59:27 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-39e1e2659a8mr8229085a91.1.1789577967153; 
 Wed, 16 Sep 2026 09:59:27 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm10051395eec.24.2026.09.16.09.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 09:59:26 -0700 (PDT)
Message-ID: <d2fe7c6b-6f63-4db1-be78-e529130710f4@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 09:59:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] target/riscv: Widen riscv_new_csr_seed()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-4-babc367b60f5@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-4-babc367b60f5@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX+mj+1gQJji4o
 zP5PuljuNECUcXn65ttZX4I98xaYQRKajYEbi/AX19FNW+4gCqaZUTS4Fp3PwIl2kjQ1wnPsCCr
 mNsFrYqTD3dYaC3S/Ig5ibuO7ChxvAE=
X-Authority-Analysis: v=2.4 cv=PsIG/AM3 c=1 sm=1 tr=0 ts=6aaacaf0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=SDCjXxXI95NSL3v6CPIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: MdTeSPiiP3uX1RgZuuSyBPT7LHSpipFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX6hBeZ7Uu28KI
 4S5puKTnMCywuNE8UgvNxZEA5DgSStcqrmUm0EeHcjV/CFvakOZNEO24fhJesFyC/Oi+WFHy4ix
 1mONr99gH6vAv96qt4+OpNQWxjzBcQ+tM6sTMP7NrFSMcVWIIygnbd/pRS6Jt3ptxfZKSP8dDWJ
 fL2c/sSpdRVaxvjmi/etbqdr3dDKxHGMW9hRm6t7qPnv1feWoAyFXZTruhPuk6XTeqxY/avPG/3
 zu0nDV25uzVCz4NKkVf4KESWdmQGwImLLubdQEfrwiWJMaj9J6zXsCETkn4rA1AfBC/YC0Cg27D
 /HA8tWalL3EpDthi5CsmEWTFUyIdD6f6WowjwZ2k2QARChGZmOPL2ZH+1GH6xeaYrLmCVnzk9xo
 q40pi9wQGu8pknrzI0aaY0fIM+V8cfjG+Dd/e9TATVuEtBZkU8q/wdwzOugKl+0OkoEmCdJtrAy
 PdytLJw6mFaSEPw+U9g==
X-Proofpoint-GUID: MdTeSPiiP3uX1RgZuuSyBPT7LHSpipFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/16/2026 2:18 AM, Anton Johansson wrote:
> Since the function is exposed through the cpu.h header, make sure it's
> rv32/rv64 agnostic.  Note return type could be made uint32_t and arguments
> dropped, but I chose to follow the existing CSR OP style of functions,
> in case there are other plans for this one.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.h | 4 ++--
>  target/riscv/cpu.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

