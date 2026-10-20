Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eyrvwelk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bQ9p23hc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFC1-0002G7-4w; Tue, 20 Oct 2026 15:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFBv-0002DB-M9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFBt-0006DF-Sf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:08:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7hjc3499149
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MVN6LPtLzxxQj35/GKhbaR3SJot65QWrPFqfamfKxt8=; b=eyrvwelkxYMpQWst
 mbjOwIg9rc+e+suonVKZHSSMDj50feWffC1ch+KLt2f8g/3fiZdBU96gynfzao8F
 EtUiYd/ys5WYDK7QZ/F85e4aF0SoGeh9uCFX3igyBPpDri66Xun61WnYZb8zkuH+
 jHM8e0gmbyN8WB0ayqCUOowBD3ujl32xCzW15NY1/XJX7Ur4DKRYx1aiiDYSEzbo
 0CjDniWDMdcagn+kkTAx76ERpEeftwVFgboEW13hW6LlvCqlZk/nNTTICyfpG+rZ
 yfi2oRM9gxP3oxXNf7Of5mo97pNBZaZ36Yaa/QHjE9+D8HH6R8r/9aqTYUJsQFp6
 SZjq7w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabg77u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:08:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so1074408eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523284; x=1793128084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MVN6LPtLzxxQj35/GKhbaR3SJot65QWrPFqfamfKxt8=;
 b=bQ9p23hcrmVx9JCYeUvJ7QXGe8jk5P+Fo4VpzWfav54ALPBuuGOutPQEGWh+AY2Llo
 F5yoBnVNJzd95I1Ot8I6JJag42zW7sOfK9fosShwuesMCDrPIbvHP89paqv5bOwKZgIS
 hlg6QCoaP7xO+zO+awrk6pNrTGssy6fcdV689bYK079KCeXMB4LafMEJWqmNt+cnRHGH
 z0Z2fSfUv0eHHjZn83/2ohRFiLUDFC4HSrfgjvm+YsorV2ZRtuFEU8uZYWQ68BUGYnHa
 i+d/ebAeRSUdpjJWtUf9XgCF+Ro4omkqrO1gxO9mFQpy7RFsgbswhGorjx+esAru9MW9
 DyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523284; x=1793128084;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MVN6LPtLzxxQj35/GKhbaR3SJot65QWrPFqfamfKxt8=;
 b=cfWkWJC1qKgovwUvwR8T6B8IbG7nVnEoMbrV4JiX4IVfZ+Kc1sHxYSjRwBTPLzq+lN
 8yMJEafFVdtQ7y7ksHoKq+lUgGs2lfJDKhElXZZhrwtASx14ksYpvhS6SBaQkXf13u0T
 MRT54XiCmPzMZE23r3XBokmIxtR9IF7Ux8lalZh5JovqlWRo7kTBASysw2mTVmbwHSjP
 HmPNE+o4oMtvCneuqsr1D1uOp/+41IgZdlmgRD6NNytDxMbK/3C8k1OMd75QonCvkKyS
 gcPh/JEYkXXAj1WvANMFDDMgHrRML0YQ3gK1ztU0Vd7yfKHasJybXPZkxZ7BwXcOkfFx
 kJ7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfKLW5OZb1AcTQdUc4Xu2NUq9/BmanVHncfJC1ObtjirvuZzQojePHr1IjNlW9mwSPM3z8CmgA2KL3@nongnu.org
X-Gm-Message-State: AFq9FYLJu0mkrfXF/krUnEWF7EnqQ8csX8E2QBh6Ko253+LRU3C4yElt
 O4lFsQZKtAqXzcAL89hhH7AjUZ8FCHiLux1O1FWrxUWB4j14HLp2TAYigejcd9oZmMcvDuczAIe
 N3aJHkkiq+B0g7qSaEfoZ0ufbt4mwGmAeL98/esduZ31Tyr5icNJso8iWcw==
X-Gm-Gg: AYBFou0/jZyOUD3l68FgB1bmHqhAYpMoSHUVH7wjvRGpckNCL2TzIU6KbWzWGz19haK
 SdmgRV3GNDb7l/LL/+tUGYqa0hWMUoAXtSiwQfgLUmDYJNGKuHkDWaYX/muHQXM9F7VbDW/5yCJ
 DCEBYhPGjmRAPeBMDqGoI/XTQL/8iq/oatqiT1hCIRNygxGE644cmjAr982mL0ac/o8k8JiA42t
 1UHwJz46xvnXEJgqWz2T428BtoDZHIultb9FAd0n/6/uuhWbSkAo/s5ufirDnt17cfNTETyRYIr
 Vp2CLzT6GaeIpfIzA3NDYdPFxxdU6ANf58GWEUGXH7URMfjUouAPH46517cGK10M74vsA5cDdOw
 2H6vHEFb8zkUSomU2uJzfqjABh63irMJRucXFtmGFAmucL11/UtC5ZrZgNdaN2BHDbcGxCA==
X-Received: by 2002:a05:7301:160a:b0:366:6c79:212b with SMTP id
 5a478bee46e88-3666c792450mr2335572eec.25.1792523283816; 
 Tue, 20 Oct 2026 12:08:03 -0700 (PDT)
X-Received: by 2002:a05:7301:160a:b0:366:6c79:212b with SMTP id
 5a478bee46e88-3666c792450mr2335536eec.25.1792523283234; 
 Tue, 20 Oct 2026 12:08:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367412b24e3sm502352eec.19.2026.10.20.12.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:08:02 -0700 (PDT)
Message-ID: <95aea5d4-0d7c-4f53-a981-9e4c8536be89@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:08:01 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/27] target/i386: Implement and register
 CPUClass::exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-10-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX0WOBn5eKnsN2
 LsfjVpwYovCU+WMErD2ZH8nuqAyVnRK+KM2vAzIzIZjIQcDZtjSiYVtBFu/seaMvHss+295HVzg
 n0yKP4LltGtNR/K2fqRmmezj1NmheaI=
X-Proofpoint-ORIG-GUID: wnor9SUI4JzV-LJDUsvPVrGN-dfHucdC
X-Proofpoint-GUID: wnor9SUI4JzV-LJDUsvPVrGN-dfHucdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXyd4675NmKSOx
 V8gFDC/3Cm3HuwDsdgBFznom7XYmYkHeLHJsN09dcxFYzLULRLz0RycZyPmQFUuMTmFYp12uJ86
 EQbCy0o0V3+gkQE094DDWBJDF4VC0dcCAmYcY+06H6ws7S49LL1Sp9F3kCIaQZllcXhPVJVb7aN
 Z2CnyTKr6ID/aX1uYUFgo5rXT92ThbUgV90TyP3WY1cbO0Yu6bNWlgVy+lmsjXv+Ci86YU1cpMa
 6PxldufYF1AdvnFrpyxyVLrJ+N5fKngl3zYJR3pj5xCB0YR8XWES2RkcWbAUs/IPNZGsEL7Ezmk
 I6TvNnJrX+RlUgTZn27U25UCC3Om1WDRjSKPUlooIfghsvsbnNxpDeAPhdjzu0EhrE9T/HV03rC
 /SUckvJY2o/7RUzYjWEMNyVBYUidIZAeP0Shf4DZXd2ZmaIxclENIKOi06rj3VSVVlYgBPxdBvf
 a1Ap4I3UoyHQkDWKOsA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7bc14 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PzVO9kEAKNvF3EdRzRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Implement x86_exception_name() and register it as
> the CPUClass::exception_name() handler, so the common
> exception logging can resolve X86 exception codes to names.
> 
> Use the new helper in check_exception() and do_interrupt_all().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/i386/cpu.h             |  2 ++
>  target/i386/cpu.c             | 33 +++++++++++++++++++++++++++++++++
>  target/i386/tcg/excp_helper.c |  5 +++--
>  target/i386/tcg/seg_helper.c  |  6 ++++--
>  4 files changed, 42 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

