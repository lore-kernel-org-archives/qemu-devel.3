Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF1C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtX7n-00075X-6m; Mon, 10 Aug 2026 17:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtX7m-00075P-1I
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:01:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtX7k-0004E0-Fn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:01:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AKwkCA3312766
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 phUPZ49cSu3OtA6nLyllI1CxeELn8U6TMtMp1R10Gvw=; b=gHjUpjAb6q+IG8MX
 1GoghkqU7YYE2O4yTHMzAjQ+AQfrY2/1h1/BXCRmN3DCZkA7cUOWgdso7OBNP/Z5
 jwwLtN3+2V80qVd1SU8YBSGUx6b1ZDewTu/Eb8bUKZsLlSoFaD78lesofV0vqfP9
 EPXa/2IWnQSuk7r+HWheuVREbPeVZc6JUQS98zwmjeUSXv0I+YqCAJ41ZOXQvI2Y
 lRjkrKavXrVuY1GjoULJtOWW9PbSAR4wcjdWWbvDBMUp/p4EeCp3RyKiJPHl9zaN
 r7cHNHTILC3qLbjuI0HtJx7nzWOObPqPwxJC1xZspC88kUjl9MaQ9oyUncIKJBDs
 7wY0Vg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v3uq9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:01:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce64c41efso43722681cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786395689; x=1787000489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=phUPZ49cSu3OtA6nLyllI1CxeELn8U6TMtMp1R10Gvw=;
 b=GifbmmqB1cxK0Cwo14IbDv5Gamd9UllP4eaIpcmhOyCQBiINc8ZwNa48yA9FI9iyUk
 c/Kksmy5g18d1CQOtNa8TkQfTF3NNCWRvGpuw9WZtAwByxLDqNpWw2OX5J3FeSaWqHZs
 H/mQam1Xf1M+5WkUWb3fxfIKu/+Y+zULaEq4gdlLv/aFbgymLkwG5eOuVD/2CLv1038H
 +JT0/9FtrKXmQt44/idtCjiFyjmWb/hCkDrZgO4BUZqcUv7PfwAljmVpAonfNLlPuwIg
 uenDgu5Lwx2vjZ8AxQFnH2j47k9GE7a5QWU7K1rBIj8sNhineDRE0lr86rlHbQB3M3UL
 uZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395689; x=1787000489;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=phUPZ49cSu3OtA6nLyllI1CxeELn8U6TMtMp1R10Gvw=;
 b=QO4pYjP5sxYXy3slrwT1yqLBnuPdzHWP6v8LCDQs/yfQKY1xM5RIAWSbIeTb7dfbPR
 3KRN+bHUvKx2ydGkED/71lZZ3YzO++naP5+C+IvJSe7/FcHnXbm6hX448LbMVc01bvED
 6ruEMmCUslnmP/G7ZIQobe9QQH4RbL4tLMCyP9zXGpJTiTrFf2oRBS8DbM1aDEFa8sWF
 w/WRlI9xXfTiTDYFJIrVK2XSFPNZGdUXRxgLEoNEF5+FvdVLY4hW4lWuz4TS+2UqdEns
 AQUhXM2NscrXIIWgALhwqYQZzFldIOSplZOrOVWA28Xhsw5qKamj5OB5C5eYo0YWd0Dn
 ubJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6UsawOCXeFeIJ5ZxjW4Z6vmQ4+/g3azvOE7F+GFZKKEY7XHxKLc/fnnpDnCRg9mNSzQ9RbqhSjERZ@nongnu.org
X-Gm-Message-State: AOJu0Yx9qdUJImzsRa7oQcpMXjsyXs0uHnqLCD3AJUk1G7qbSInugvrG
 0UnsbJonO6exW8s4G3wddtuibYEF32xmWdmn8u7n5S3UDYT/Ghm7yv4b1wuHcyE6rOEKTuXO+60
 BwXwF0km9koVdR4uter4h6Kfwp6J2PIWDFP9QZTLRneN/dLTmNlhipYn7lQ==
X-Gm-Gg: AR+sD11YsTuCak8vDMZsLJU/kIiDvmpW+cxBvgXD19LggFMB0RZvkvqd7M8hbRtssLC
 ESbOnhBtld07MVRiHMctJhlOyUqB24Us4p1XZ3N4i1T+nydq/vt9dxEbm3525WLT9kObZT5LOHw
 JhvDRlnaG32/XWgSoPGpT9WoCEJxHQlfZjyEOu0tZH2icKmKubGR85qWkLI8igk6cF3CV9wN+L1
 OWI0aQpDrkPraN/QDsfjhtGLiL6eEUnPIT8pYVuQp4b5SXUKwwBgm8DBfwhrw/XPzZitiY96rR4
 sHwQGygGRcvYYAPGqikfoZ83FiNcJmiWQ+rZuNbi9HuxqgHeLj+YHqjP62epjjFV4oDi4OyG63g
 QOc+U1GGu6i+KgDpWWLUZ1clHh6c/yNR1nP8=
X-Received: by 2002:a05:622a:5145:b0:51c:8571:1ccc with SMTP id
 d75a77b69052e-52d4bdba81cmr63069911cf.41.1786395688855; 
 Mon, 10 Aug 2026 14:01:28 -0700 (PDT)
X-Received: by 2002:a05:622a:5145:b0:51c:8571:1ccc with SMTP id
 d75a77b69052e-52d4bdba81cmr63068841cf.41.1786395688345; 
 Mon, 10 Aug 2026 14:01:28 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499740a70c3sm17141435e9.3.2026.08.10.14.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:01:26 -0700 (PDT)
Message-ID: <cb77e1a8-182b-47ed-bf94-66b9bc1e8628@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:01:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/39] s390x: prevent crash if given invalid CPU#
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Corey Minyard <cminyard@mvista.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vhgMzF_vqYk1YREGIpV5CbQZLuqPgKzx
X-Proofpoint-ORIG-GUID: vhgMzF_vqYk1YREGIpV5CbQZLuqPgKzx
X-Authority-Analysis: v=2.4 cv=c+mbhx9l c=1 sm=1 tr=0 ts=6a7a3c29 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=hx00oezb0UTb-gfI68UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX9wnKm99v6oFj
 xpxEn3jNzOqCUycf0MGwvibuT4ZmvjoepQIr5nICw60owITNKRaFgMyfDlBkXtDX8fUtKpYaBX4
 ioWfz2xTRLs5cRLlSHpDZtPBgvOTnYB95lgpAoXk217Fjt8lAHLJjpLVhtA2gcJmsikwKZIduZf
 Fd6hsBGgfHRzvAdJesWOcC56ZOhsteIEa7xI/lL6sihxuzsKylmXlzYrUQFzKcH+yQC44oYTnly
 WF8v9D+x9uiZ6YlCKpSvWlP+6LcuVk1YdxkG9pzZbtu0ISRUgl13rssoVCdkhQt/oxpTPruKnt9
 fm5JCunes49G24suMSLSTOX2HwYSoHtSw6R3p66a6GDpG3Y1kXP6OjEpiszJUm+g6ZoU1J4QF9q
 VABFtNVf0/eUvU/IY2oJJuD1arm8DQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3OCBTYWx0ZWRfX+NzZ/TRLBt+b
 1EE5GFD6NSCyDJi5/26mmaKWFxD79OF+3Q1PwDaxp36PZNKgTDk6WehetVtw3mbE5hygx7PboiS
 pnYwTSqpwTj0Lsqm4lR44idWHvJFisU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608100178
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

On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa49554..d0fd894eb67 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -729,6 +729,11 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
>   {
>       CPUState *cs = qemu_get_cpu(cpu_index);
>   
> +    if (!cs) {
> +        error_setg(errp, "CPU %d does not exist", cpu_index);
> +        return;
> +    }
> +
>       s390_cpu_restart(S390_CPU(cs));

Looking at commit 6af94767daf ("ipmi: Fix watchdog NMI handling"),
I suppose we can trigger this crash with IPMI on s390x target, is
that right?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   }
>   
> 


