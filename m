Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E278606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c4J+2SjP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bg6w/SQP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrUm-0003HH-Jn; Fri, 30 Oct 2026 14:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrUl-0003Gt-4C
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:38:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrUj-00038O-MX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:38:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu8Qb373415
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lfmQWKHoHsFJjpRZ32bOsnNPrAR9wXkDimZMVAWRowk=; b=c4J+2SjPLN7U7glg
 yLL745Ae/atEHbzjf5O/SrrUo9c5AvpqwyaNF38Kbau4EBNWbONXavx+EG9nl2IT
 L7AG5gOv4PIttkN438yPQmzTtxp3mxOsbSTpbvMPqiqhCS6fJcu1tlluY0kGHhB7
 FceJIogDefWGzKXyeIZ3RXVSx7VwFO28CQvEmdMX57Z28enZRuVzjtnDKWY20YIs
 tNt3AUcNc3yrExRnkG1Pf+vuHga3zS8b/t1SsB1s0y8id+0/KANchXgheWmzNPlL
 ZlnA3dJsEJjqHfzeF/V3ZsUxk4iLq9mHD+nmAitRSnLW5JsD33C6BhBmSdw+GCOC
 02yojw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmgcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:38:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-943e8ff02d0so93713585a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793385508; x=1793990308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfmQWKHoHsFJjpRZ32bOsnNPrAR9wXkDimZMVAWRowk=;
 b=Bg6w/SQP+M5ey+0JTudJiAmCDzPd8RYPTmsf8WqNOmTtUdpJB6iY16IRobkSaHvxGa
 sqCqUZdkfolWQIaCqU2HETzoOMk/CS7IVpXJrn800spoLwbu2/8rogQtS/CXuEEeyLdg
 BYh7nvR019P+k9+uc/eI4Y3J9FqpoKICobGPydOQPMLS3GTsHlwA4rwejUVI5zS+y0Pa
 v2h3D91GCOQ6SRjJP3e1TysFknkyHP7Iq9T+pQ+LIhrEnGdrup3gE6Far4otvcVlpBoG
 98LT9MiEFLbQTR5pqnyBY3kYFY+VX0eXzdghMdAEZDnqPQyBhlcRvMwSvPkRXpr+wRmr
 x5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385508; x=1793990308;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfmQWKHoHsFJjpRZ32bOsnNPrAR9wXkDimZMVAWRowk=;
 b=E+1JM9e1VNvaGLCwbV0Lu6siP5kVNxcIRMdkld/yBPG7cbqshubAU8n2oioYyZHL+b
 rAdtIWiZPI2X1zebAZL8Uxzdh2f1v48M5rZyEpgUFHR1Ky/dSWO2BSCCvGDjTnxyEaP4
 N8xHez/qseKHKf9JN8aBmLx0oGIY4JqtUsn6ShcNmq1LZG+BknZWu/+ukMf0FuS1a4gX
 yKbExnffNfOYsWolSafe+w1bG3kxRj3uibywLeq5p6YNNnTQZnm3GKmPHQF3EnrTSiQQ
 kQ4ezo+oHP3J6EdAtuLrqcODJThfRokiNXZDpojrEXD1Z84ajL2QK7WVef+MvBOoOswF
 2HQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo87GFnQdUD1TcClJkh81yeUdNfFCoPVK/Pu2pS64pMZdIYZZIGA3S6ZiTWXGgbp3AXAGfkofpN7OR@nongnu.org
X-Gm-Message-State: AFq9FYKeqitFMCoHCwvu6ugXZ8VRYgcfaBhxpxb6v9MmCJzxNOQAzwR4
 qPejtTGyg1jHKeFsXbA9zX52VIQ88gGz3A0zew0uZ1XPS+jzO4H47X6Vwc4IlL7joXZE2VYTytD
 QnkTluEETHDbblsDe3nO9+9OoP97HlNV7yiOXG0HNc3aNf+AXuACpAguVSQ==
X-Gm-Gg: AYBFou0OXkiDxvULMflr58NiXCOyVrsPhPb0gjNrQrYTPk1Xd4b6q8LCoctn+D7fQYZ
 g/Bw4oP4YNDzI+IEjYWatPjD093s54zojkWZo6xUsKRPq38pN6kVSQay01UY1dayh2jEN2M2bSr
 WPY5r1eNQz8bpOpYNBRwSYAhyzy3VdKfnxiu8Y1Uv5NJf3y4bUbA8Ypvy7cR0RvJtWiThFcMqQb
 92OZBY46ZkOM5ax8IiC8Bjmv4SnyemvgJt/Z7eOEkhraZJEm6sALz9sp2RnidgChZ6R+2gHISRc
 rED+pE9PIivj1pA9dLGZgU4U/RWJuPniEt5/pMyeDUDDXMGv2Et6CktTApNRtR4Zfduc7U7keTb
 Hlju8/dSI2B31as5TOdbRVRk6drEZrRGib+yqFWxYn+ZjV1d54hKdACPj6Ew2pWIqocN1erGaDh
 Dd1QtGnzcOYm8U1dHJbJwcclI=
X-Received: by 2002:a05:620a:4586:b0:940:f224:5a69 with SMTP id
 af79cd13be357-9442178df00mr539413885a.65.1793385507614; 
 Fri, 30 Oct 2026 11:38:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:940:f224:5a69 with SMTP id
 af79cd13be357-9442178df00mr539409785a.65.1793385507014; 
 Fri, 30 Oct 2026 11:38:27 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1076sm80718605e9.6.2026.10.30.11.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 11:38:23 -0700 (PDT)
Message-ID: <58da1949-2281-4f08-9a79-d1c15457ae05@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 19:38:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/sd/sd: Remove unneeded forward declaration
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261006094447.43491-1-shentey@gmail.com>
 <20261006094447.43491-9-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006094447.43491-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NCBTYWx0ZWRfX7vUOx8f87XmA
 fuzrvmPCzIEU223UXrkBnEV6CsuMry7eie+f5acIyWPWiYglJdKIuKzoYPT8k+lBPeipmSM363G
 HuNq4+bDkHb1dBuMfSAQd7ZBGlgzAcV14rTYsL3OSx3K/KV8z2zctcGNd0fx5Aondyg8mygs7fr
 gRhPPG4pzz5ewnl6hNMEKVOtUxdXEgOiN8n/3ibswpm75V89dsDyJ/sdkQZ4A2MTYUq0tGqEhvz
 C0Yh+JLT9k4ug7nKPKcfrUNuEnoG6ag1bqn/dkVVpvvYcoqdGkXKsL//V3Xx+Jiuaiu1WPuZvzg
 UVbXgWg64+bPPNsYR5/iZSZADNc+G6gKiJmVa+TCX22rB3+q1EyqxvLITO54Q0OFt47lX0Au+qm
 maMMhkccxUKebdl3zfp+yQT6p+daEdef9ivrgrBrHL+EYq6QLJTbY6QSPVxxK4COweM1I+61ZCo
 Wv/Mh/KJUwJSkXXaaMA==
X-Proofpoint-ORIG-GUID: QW0qXakSpVegCD9XYXgAr0SZ-SwRtSfa
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae4e424 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NCBTYWx0ZWRfXzGA2XtOzcWwr
 sO59vzCl0G6O/entEroO5VaMvohk3Ty2NwDhMGupnx57FgLU1u9hmQ8sOQzLfNUEqRYXbneLzg6
 pDbfaocxbsL/6dHsj3HCK+2su0F8cXw=
X-Proofpoint-GUID: QW0qXakSpVegCD9XYXgAr0SZ-SwRtSfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300074
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

On 6/10/26 11:44, Bernhard Beschow wrote:
> No need for a forward declaration of sd_realize() since it is only used
> after its definition.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sd.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 6295e7a942..e6452226bc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -209,8 +209,6 @@ struct SDState {
>       char *preset_auth_key;
>   };
>   
> -static void sd_realize(DeviceState *dev, Error **errp);

Indeed, since commit bda21477f523 ("hw/sd: Remove unused legacy
functions, stop killing mammoths").

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


