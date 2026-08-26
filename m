Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6AFC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCut-000115-Er; Wed, 26 Aug 2026 08:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCus-00010u-49
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:39:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzCuq-00061p-2I
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:39:41 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCNEsu295692
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pZyNP0sCBMMuY5+Csb6vyMw5V26TKU2er8wDT7hGl2k=; b=gbXIq6qsdJCe0Sti
 L1fF5/amkjq79UhZIoJuMkTISTOZaIAON/5EXkc4a1ZB2MrB6OqrUFfzuwrwfHYA
 qHxQWAV2h12UH949A/S9JQCL7Hspzv/pnmi6nKYRgQszubYgIGJvaF3XGdIOQil5
 2jd99lEq5PlYxAQNDJeCpkXYATn7vy7sxQ/+JqkZWDMO2KbtEovirPmi4aWw80lC
 KfiOvOJMHtkCqhKC1NYH9yp9hFD8YAI4xHrWk1VoW/2HTGjPq8hYk6C/dmn6lU7g
 F/zPowH1bIWHgrCDQe1quolEypqgDHKqcuQLFA4MZzoEpeJdu4xsYUBj0fEhY4aR
 D/eqzw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03u01vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:39:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a23afcbso13453921cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787747977; x=1788352777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pZyNP0sCBMMuY5+Csb6vyMw5V26TKU2er8wDT7hGl2k=;
 b=ARDT642hd8RfzH2X8CYaVVlkZURD9LD2K61qbEibdMDEr7EWGnR2ZnMzt31dinFzIM
 4oXLlP4H5VGi4S6bWZinGGIfeFeDu+5KksFZvhBktaMysWdks2gjMbOgzu7nMq6KP5F2
 D8PH1xVpXp/D/B+huX4GPWB15IGvbjpBbIIgQS3iB6WYynsMclf8/vmoP5dNYtUPFEz6
 3Bs/PMXY8nwC/vNQeUw4ibAUYMUn1bDY5tquW0DLL7scxALBcoV+SvIG8wZVYsy1R1LA
 tD81PEDRjU0BLdxdKOPVT8uS+CwqYOfo7DHw7W+yns2BbiBJn279f6XhnLVO1bRWts5G
 AQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787747977; x=1788352777;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZyNP0sCBMMuY5+Csb6vyMw5V26TKU2er8wDT7hGl2k=;
 b=jAM2g86Pdkqa8l6c8NZReKRr/RfDtkH7hYaRpGpj3HiDxAu/rBJjiCwhzeVE5nb8fI
 lCzts2yMK/HCetkged6r0jyiWlyIshbXc4u9CJRNA87aG8s2752DoBRbzU6IyLJvPnfC
 N5BOO/TQTSOA3bgOGFJ5bB6CheZzIdgJ8KFsDrOOrcohssavxE0xZ+7pYpsn5R8Xbl9B
 UmClPaRJS0ZGmcdy9x6U8q59pKMeqEKJBE8y1B8oqh/HdLS5tkP5JcVzR1RcQ7Mqrrpz
 3R1LfKLYhR/EUe/6J2hfLyc6bnETXYq8d0gU0wlCHgkG7leaSUuYNt6dAQu0WZGOIX+c
 7KwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYu+jx7h1BPXE3AiHnc1hNAeIMw8zmWoWAUGAwt1hLNdfG0mNMU5W7OftD485RWOvqWJ/BalK43+yb@nongnu.org
X-Gm-Message-State: AFuF++miwRXADz6M2QXAy8MgGXx/P9pD088NgsGroKZcD8ZEEd0ox+vd
 oDjWKsWfcc5Nt49Uaibd0evFTSZ8V42Cpl6Vj9eBbCuyuCHhkgYax8vDnFTr+PCnA2MaX41MZG6
 2fMpj5AyLjleS0p9FM0Ov62ipkL5A08goR+oHIDPn3R7WWdlb/+xZKOG5bw==
X-Gm-Gg: AR+sD105s+rU8P+VPHbNSZXe8UorIHbq94kfcBOjjmewTL/Qd1r1SBLTfBPbmiMfnkh
 gElSBxD6WkYjWREifrQsJ91FbQyrsEL2jTxt52QDq0NTR+hd/YxVjMMHoiR4DmF33PGSN2NCV0i
 SK0t2YZc2pni20ShqgJVDwr0HkqfGWdgv1FZ8A8LFis/B8LPk+53Intr18cS16d6WMIAYyJgfuA
 /VPTsa7mbbuOmUdgPgyK1uutGjDjeXDCns8n6gKNrTBiV0HtipXKMj/i15zjmXAatqg3IRz6euk
 af2aldhBFbEMwQxdyS7dmUJLLdeHjmjhuz4ep7qyov2y+zdKt5+1pWEGwblh9L1iAWzSaMeoe5M
 p4VItmmqD05/kr0e6VF8d
X-Received: by 2002:a05:622a:1347:b0:52e:f66:f17d with SMTP id
 d75a77b69052e-52e42283a33mr60842921cf.12.1787747977026; 
 Wed, 26 Aug 2026 05:39:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1347:b0:52e:f66:f17d with SMTP id
 d75a77b69052e-52e42283a33mr60842411cf.12.1787747976329; 
 Wed, 26 Aug 2026 05:39:36 -0700 (PDT)
Received: from [10.254.188.74] ([185.104.138.96])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b43absm470648866b.51.2026.08.26.05.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 05:39:35 -0700 (PDT)
Message-ID: <a415e322-f75e-43bf-9f0b-beacdc04c33f@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwMyBTYWx0ZWRfXwRxigTMIr/2o
 kY2LIIvDLhtzKub3mntXf6U3JRenA8ufg/zDtRPdGP9/IrlBMHk2wqJqxf/bBBYWYp2jeyye3V3
 l8bECUOiqfhJbFIuAxldomKi3mvVpE7aFKA/bYd+mUJymhG98KXznSD2QBRG+mL8xHZV5pzAFQY
 f3/V42wm9YGWtV9XUBZWeB/ViImA2g1V89uz0m3RyroqDD/XewaCS1WnNwfPnEUyoRN1N30Ed7d
 2CyWHQ9alRiLA8TOdVtPewy+jLyOpDsN9Denu1zWI3XmEnOT8SknB2mT9LqQN0lh+Vtkh4mFC8u
 9EV9GEselSHrFCYT4vPJ0kMm0cMNW8kQ0YbCimYaO3HKtI7gSqI3HfRpkNduccGki7iFWTn/CuI
 Yxpqjn+oKukJBMnMaqG0n7Ntdhgfc6g6KdBVukw895gVMDUjqPfj1fA5fD8t181QCXkpUifmYSg
 AaQSPSAD4hvmrfYRGoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwMyBTYWx0ZWRfX72pb8zVhcHME
 SfgDgduniXIhuFWa8nQvAAWj61opqXhcbeXs+2qMfEqDgu0GZC1E3M3f37Ac0Yhlcdnd5oAkt3F
 7vmJjS5hrgXZEQ6AJ0vUBoi5O7nOOjo=
X-Proofpoint-ORIG-GUID: jq0qcxoAQCnzDa2Yn33wuiMUQMVOHz_J
X-Authority-Analysis: v=2.4 cv=RcqgzVtv c=1 sm=1 tr=0 ts=6a8ede8a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=KRlTYBX1Q8J3JuxqD7zILw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=jsqAP7AhX1rkBFyPlasA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jq0qcxoAQCnzDa2Yn33wuiMUQMVOHz_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> mon_cpu_path and reset_seen are only used by HMP monitors; move them
> from the base Monitor struct into MonitorHMP to properly encapsulate
> HMP-specific state.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor/hmp-cmds.c         | 16 +++++++++-------
>   monitor/hmp.c              |  9 +++++----
>   monitor/monitor-internal.h |  4 ++--
>   monitor/monitor.c          |  1 -
>   4 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 6b1114fdaf13..6718fec97047 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>   /* Set the current CPU defined by the user. Callers must hold BQL. */
>   int monitor_set_cpu(Monitor *mon, int cpu_index)
>   {
> +    MonitorHMP *hmp_mon = MONITOR_HMP(mon);

s/_mon// please

>       CPUState *cpu;
>   
>       cpu = qemu_get_cpu(cpu_index);
>       if (cpu == NULL) {
>           return -1;
>       }
> -    g_free(mon->mon_cpu_path);
> -    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> +    g_free(hmp_mon->mon_cpu_path);
> +    hmp_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>       return 0;
>   }

