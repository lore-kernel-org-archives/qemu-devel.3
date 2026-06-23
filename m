Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB4CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6ec-0003fZ-Mk; Tue, 23 Jun 2026 15:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc6eW-0003fC-S8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:19:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wc6eV-0005Ck-FD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:19:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NHr8vc113942
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 19:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BWvukd/5x41y6eBOHBWju85y163If+PLjOWr+GA6xBA=; b=LnuS6oStvplMMuvw
 H5EO3bdSYtUMPlt4LIQG6VsghtUIgxWiDkLJR7dtTev5ACnQ5VrDGmq7atpp5wlh
 aDyWdy8UqJTewqLgxNGsGIGc5MmPke4pTTdECLYi3xFQUzugqKdgFxpDmMH/Gnk/
 Bv9EnxyGyFwPPRB7iIkUWvWNjfgeAXk7xdMlhGik9WMxi+nyCqp00d9QgsCab3uW
 jlAujT0+7POInb9LkA8LA8LXLJoGAi1uFl7VyFDT8TnWK69/dN4KH19w97fChQ3Q
 A8IVVDaw6bCGrgoj44TYxmtDmEKuQ1ee2lekLrfFxh09Vm/TGNDDflQEK5mSXnaF
 jZ5ACQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvuagd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 19:19:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91574ad681eso18243985a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782242356; x=1782847156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BWvukd/5x41y6eBOHBWju85y163If+PLjOWr+GA6xBA=;
 b=T0AP+NMa694RWeoSX+0XgsIYvHfIDMzCyspLtfOVRtpiA2Pjv2WFu1XCsFaMwRyN6T
 2cYtVu/Lt8vyudHJAYWE2S+jzTYCkZGUfhvMmV+Xdtu5hQDVeRvbtFSwopmcbMPSPdas
 2JJBs7nL1AVwsHnsKVHF92Z/4YKsvhhB0Lc/FurB6gGywUDipjOa2Z6RiDy6llfA/Rjl
 BLUaxWZNx9MQNER0jlYFdHhTxHC6GYtCUOkw7MMneKY+2V4MG5dQUnOpxJuBuiH/c+dH
 hYL9ozTbJtN1s90OjbgqudbZWNUOsH/SvR/dCkjsVPWuVa+40al0P/34inLrXrNRoqJ0
 dUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782242356; x=1782847156;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWvukd/5x41y6eBOHBWju85y163If+PLjOWr+GA6xBA=;
 b=sFYSYAbv3SxavV94Sc0wZLXUZUScgrz/Me1VnIOjhpAi65U0pHWyGZHM+AyU1Hql14
 7Kfz2FgiIbLGAb+r877oTg9NJV/4JHwa4jmVqWWAEiBNRniF+eiBNjEPxfOK6mKUJdMU
 0F0qoc9CCSyRFJzS9bnPT1Fa6/iNwGF7DrAsIClmh+cxL6oDfUvj/Uk0T6pIczbsoCZE
 cJcANprsUwa6BO42VtCqcgJPZmdW/+4akb0t+88IthhZTspmVNGQmvPCRJp3ubqIAkph
 IjxNHY+uTnn55TOBThklgKXX9m0yNRNrOtxlIeUnELX/ef6FA0/z6I1nsrlW+8jOFx5+
 /+6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8aDNpYFm8d8C+SQQtrF9qcFGLThhnut+12H1B3JsbnRjZZ6DZp8c0D+93Imqb3bUnagL2F/nvXibTO@nongnu.org
X-Gm-Message-State: AOJu0YyB3gZmi+K4F9WS1nDY35+G4Q4uXj6B5DMpeIVuKeInQUcaR4Mz
 8sF87EotwcMWEx/DvjNVIz3pkKiqSTj20UCN6ovg5Ocr0E49aPb58vNRWFHK+BdrqQDQFaxZ8+T
 o/PzlrK4yDfJzBem7v5EUilfqxI1TAOHFG3CVQ/kr3Le9m5w02vthhhHwUA==
X-Gm-Gg: AfdE7ckHDxBHt9qjZdZRYm3hdAk6EvAKx/BXfFqUyNrYRsK5gjq27VKcwWK9fmfB6/n
 V9RGhRLW6K+yqrp5JrjwUDtqTUERS4/EceI/lHVpcNuQdY5VZWlipRqRkDbe/EqL8BtxQ78ZEXu
 YWQ8q5Sto8tcewaoD/ZZlXql6195vRG1JPKlQG1xrjPQB8qXvefco0O/Zmz9g+w3v3RfTjrKE+G
 suE0lWGX8lrOYUug0aFb+8cIk5kAxvHdF5r1ONlfy+/gPhQ2QLKSijf6Z+jgnfXslVQwEP+T/2R
 zGg5jolEgTj2HD7XRcFPb5igfmNyUSL84/wrI6ZkKahn/fezTIok01aCwe/XPlH/TqAlGH50jjZ
 DPUc9NFnAXeZY3f2K7CugGMo/QuaGFzDGtVqHmJWIJQhT
X-Received: by 2002:a05:620a:1712:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-92783570710mr63351185a.36.1782242356098; 
 Tue, 23 Jun 2026 12:19:16 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:8ee:bae8:2bb8 with SMTP id
 af79cd13be357-92783570710mr63342885a.36.1782242355389; 
 Tue, 23 Jun 2026 12:19:15 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926000c1c39sm337032985a.26.2026.06.23.12.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 12:19:14 -0700 (PDT)
Message-ID: <f5acff3d-d756-461f-8e01-5162ef94936b@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 16:19:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] target/riscv: move custom_csrs logic to tcg-cpu.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-11-daniel.barboza@oss.qualcomm.com>
 <755aa324-6792-41bf-be40-ae2155fefa27@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <755aa324-6792-41bf-be40-ae2155fefa27@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3adc35 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xYj2K_4AjhV3JU0JadUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX36YLpkkZ3QO/
 tK/0tvPMvZDMMMOdypoBWkXDcw4+NCDeE8r/pZDF+77EMQQXpyzBTXUBrBk4AjlGVJo3+7P5sfR
 qil92rT7jQkxKqjddcVw2T0ePWAvH+E=
X-Proofpoint-ORIG-GUID: SidXFnf-WHyw_bUbXYoKIIeqJaQ-v1jZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX3LthtDqFPZqy
 OBmS2ElRdecg66RE7ifl+/d1LqNz3qJevdvLH5Yh5sWP3z+CjWfhf5B5+j7/0mKyBi1yhl1RpIm
 xH0v/IhhmIV+xH8U59qTJxulfWJ/4jrDFEpjAMiiQc1xKbQUJhaIAPR3PfBLk7W5YBbsHlMSjFD
 46MAvadQb1AmhdAM+iRbtJX3cXTnqEqW350LISrn2CT6fN6IAp0PRqA5jBeDjd49hUjyhIpSc1e
 oWatE9P8H4ptycyyyIlEZB47kjDHeE9JbETN5di+d2t42VE0ESykR5TVnPgtxTnYvojoAUWvIbW
 +jlNc2wzsMkZxyn5U4aDwRIVcUpvwZIKfenid9a8b1M5ZjLH9Mh9HklHBBa+4RcSJP4eGH7TP+D
 iiUCBMtvRdT3mDHxoJdt2JBATb/F83AO5q5BwWU+oBg1A0SlHbRNQYzKQgSuP6cNIeW/gmlHbOP
 5EdcKa1XVK3cFob7+lA==
X-Proofpoint-GUID: SidXFnf-WHyw_bUbXYoKIIeqJaQ-v1jZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230159
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



On 6/22/2026 6:02 PM, Philippe Mathieu-Daudé wrote:
> On 22/6/26 21:31, Daniel Henrique Barboza wrote:
>> We have a couple of CPUs that has a set of custom CSRs that uses TCG
>> specific APIs.  Move the related code to tcg-cpu.c and do not set
>> .custom_csrs if we're not in a TCG build.
>>
>> What we'll end up doing, sooner or later, is punting all these CPUs to
>> tcg-cpu.c since they're all TCG specific and KVM has nothing to do with
>> them.  Another time.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c         | 24 +++---------------------
>>   target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
>>   2 files changed, 24 insertions(+), 21 deletions(-)
> 
> Squashing:
> 
> -- >8 --
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7582874c351..4e58a5daaba 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -570,7 +570,9 @@ typedef struct RISCVCPUDef {
>       int32_t vext_spec;
>       RISCVCPUConfig cfg;
>       bool bare;
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       const RISCVCSR *custom_csrs;
> +#endif
>   } RISCVCPUDef;
> 
> ---

Squashed

> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Ty sir!



