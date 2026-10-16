Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69645CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkpo-0002cR-Bk; Fri, 16 Oct 2026 12:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkpi-0002br-07
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:31:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkpg-000392-91
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:31:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5jLn996906
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tm2RfbeotsC4w1/KJWbpCgO+oAgs+D4tNXiN9ORw6X4=; b=enWGRKVrx2fjJzkk
 0wWfEX7+AztsL7CHqTfRv2XvdPHCczAgUKAlBlLcaP2vMd48Jng34pSLtMEraQsW
 HzlbcFiEovcfntcuT0qkO6fBy7yWPLXrpcjK2XETEqUz+F1jvJLmT+MObWF9t8so
 nZrMFaZ0P/FcP+v9xCbCKkeT5OcZ9IWJ+GYi6aneYcAsCifSt2SdvEW0xV58npd5
 EBujhuXUJes8uDeKJlwif1n/jN9lE8GKULrjTVzxkVu7HH9a3/wpEjXzHFt6OjBi
 ByIt/W66JtqeidSnHKk3T+vM9eclv0x8kkxKBxTqimwDFQFz+FdmObi4KkLFe0NW
 AJqWXA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjtar1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:30:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso68743eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792168256; x=1792773056; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tm2RfbeotsC4w1/KJWbpCgO+oAgs+D4tNXiN9ORw6X4=;
 b=hU28sVdF0XsmVQJWSWCXj7qT/hOcsEqmbvoZcIhmoLL1RuYQMxQ4B5K5glE2FS6ZF4
 9vhl3eXnMrKtkZZWVdVfhLcRGznnBvrqvTx5z8Zr2s6Ap6kKx36BpFoCxTVQfdcm1OTC
 JMvj8WPgFqJvp8XZ7O8LSC+TrAI2xMHTda+COG3/ltUWkxCVt5SG+lrPAVHTTt28CQGl
 fNsrEAf0C6x3HIietYnlMpJYFOlUO+UtjnIgy1cVxbzRGWbnuTJnvG/2mEYoYQzZF6MY
 urj8bIgvfIH9v6EZGli9fpygm87LIbj1XbzDswtvERUzcwCb10dHBDI3DiUWhuMZxg81
 /Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168256; x=1792773056;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tm2RfbeotsC4w1/KJWbpCgO+oAgs+D4tNXiN9ORw6X4=;
 b=Dh7c6KBPHQm+pX5N4N/JB0nVRrJdbcQ01xATJF3ycDyx1nwP+L0IoVrrAPp9NFnA08
 W+wQB+nGGWlknqwowzEkNJubYF5ojpJZ6XqlM6qEslc0sXvM1tPyhI0yGj3hczOkNSkp
 WOivMEBMegdwG03ZPEaG4xkH1cTtLpHP5cRlZeh1FIlq1boN1xbTXJrje/yieGVEldje
 JLEmHhRFPAIV6eUiVb45mZtMrcl6rYJEb5fn/7cWuklj6kfQ4kb+qU6DIttsArorj+wI
 MlWLsM+h8uHv+O/PTcdlQPwJh/DosvZX5ZC6qtcC1wjwdJgZNXFM6oyogREFhvTuyy6k
 DExQ==
X-Gm-Message-State: AFq9FYLQ+noDgJ92kIsQQf2Ta7Fp40wg6EJAQCoxI8yIfmPkfeIxS4Df
 u7hoQg4XPOE8IB9SDO+CI6VDoDZPeH5HQ4yMdbHMoRh2AjskTcyWGq15D4xCuyIBQoEUOiB2kQq
 +49wlk6bbowQUyta0oui+dGzwEqJoGi5Zqt89YK+wWSFGW06DD+SUo4RP2g==
X-Gm-Gg: AYBFou0lc9X7UX6TVVwxorXq4dLjJAwxSY1u2rFetymnWAAJtB09vIQOdhFCoso35d0
 3Gv4UGZCvf0gGfYJPxKaMWhNEqav1LKziuahz+yrIjuzcQD1ODVoQOKWh2L2LqT4ViKPSs3YVpG
 Tc7Ce+85Q3m+NREbuEWA9TQ9TGGuDzOYqmatzL2YgsH1gTygPhvkWqpDdR2Ue5EJESlEL6VvqR9
 B26d+LICJCNZ3aKXApZDD+0umcUdasBT4ANSPPT0fsrJv7h79UduEjkDiCYHbijB3o6EWH7p0oo
 oPRlCm3FNVlB9EB4bzUhU5e/YcMTXHS9bpy9yU14p+Y1cODkPkVVwcBg/w/J+v3pqO3rJ/O8rzu
 avMSxqgxhTNNLsFkfki3k5EC4FO+JQmOffVsMlw56tEt8WcQpEqabVcWsxqFGYn/rLw9OkQ==
X-Received: by 2002:a05:7301:648b:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-361a2448d7emr322805eec.35.1792168256175; 
 Fri, 16 Oct 2026 09:30:56 -0700 (PDT)
X-Received: by 2002:a05:7301:648b:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-361a2448d7emr322771eec.35.1792168255469; 
 Fri, 16 Oct 2026 09:30:55 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607bc950f9sm8801877eec.0.2026.10.16.09.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:30:54 -0700 (PDT)
Message-ID: <fe82ee32-2124-434b-8ef8-b33e92cd8353@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:30:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] hw/core/sysemu-cpu-ops: add get_dump_info
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
 <179214395192.1157317.14342665925366918420.b4-review@b4>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <179214395192.1157317.14342665925366918420.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX28bf7CjNmNb7
 2aFw396KACzeWH65QWMsg4oBh2Vk0auhAOvZIdFMFx33E1UlQPxNittmMAzn+BT2QHya6EHWKwz
 9gX942vK+wSQz1hLQugqRZMCell56vIZlVULN2KB5hGPvMRIsBCWWdKkbhjiz6kp0vkW4FK6cXu
 AZbuE4Q70GBd6ZuUCspVQf1nHc34ew3svzFyd9jE1PrprXgYejXLB7BJLKSR0Ef4UjI43dN3yQt
 ph7GIv5K1GG/iAip5w6e76bLqbdCvDDo+0zWy5h9/bGRjO1/FbCOxmha9daUru4ftJgycLXp9sa
 6c72mo6oGAPAm/FG4QfkZ5TUsKG/Ph9db70arhWtF5DrSwtKTRw0LQaOeNYzhCpguwORv/xDACX
 E8oKKNlsS1Bl695pDkBfpkXLiGI9y2q92/fUIBnSf0WdTZJ0Scs58lyawXnahMPuVYf3+iQDwuU
 3OuYV4QJSyLOpvELEXg==
X-Proofpoint-ORIG-GUID: yoalCw8k456i73BpAnYADe1acs9yWLIC
X-Proofpoint-GUID: yoalCw8k456i73BpAnYADe1acs9yWLIC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX9btN6q5lg3d0
 Hfk+h29NKE/kgsvhuvP93MFJp+Wf2ErdAVyBlrfyKCDnBSwAxpqlApqsZwcdkICo1fK8qpwNM0y
 I9plL5Jay+iRUpcWao4cBGNKF1DT/+8=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad25141 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=hNA2tNHf4vyb3O2_rwYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160065
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/16/2026 2:45 AM, marcandre.lureau@redhat.com wrote:
>> This allows a specific cpu to declare its implementation of
>> get_dump_info, needed by dump.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Message-ID: <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
>>
>> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
>> index d125540262d2..0b6bb42dc2cb 100644
>> --- a/include/hw/core/sysemu-cpu-ops.h
>> +++ b/include/hw/core/sysemu-cpu-ops.h
>> @@ -11,6 +11,7 @@
>>  #define SYSTEM_CPU_OPS_H
>>  
>>  #include "hw/core/cpu.h"
>> +#include "system/dump-arch.h"
> 
> Instead of including this header in a bunch of places, why not add
> typedef struct ArchDumpInfo ArchDumpInfo in qemu/typedefs?
> 

I didn't think too much when doing the change. You're right, I'll add
that instead to reduce header inclusion.

Regards,
Pierrick

