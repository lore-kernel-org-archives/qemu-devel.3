Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F92C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxA1U-0007k3-CS; Thu, 20 Aug 2026 17:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxA1S-0007jM-Lh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:10:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxA1Q-0001Nk-Vw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:10:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7acD587678
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IRFa8PBGHnBGeWrxOBlD/fGonGDEG+aUh2svbB/9l9s=; b=JaZEREp3MT58vjBS
 nRqVGxM+lqA4abr6XaM5eV4Yz1vISi+0/5U9Y5O7+aI2P7ug747+z2Bu4dNjy0hA
 B78Aml8Ou8FWF4Duc/NNXl9WRKWh8r95B6bCmc8z+lfV9BpAYRJfR0cPtwN8MrPM
 XkphDTamq8Vt/UIfAk+vWM8BeB9bWuM9pa0xWcz7f3dyyV01313KkW58k6CVrZjl
 EGIOCV2XjxFwxJUyCoeAc/yc66EaB/crRJlMG8ZyvT81KQpOIGZqZtpSMDxe5Q8j
 FIhPuXUWwd2BkfZmW2bHqTkqzcy5dSY4RthjMS1q3Z2gBQPMfpjRcMo9FcZQQMQO
 29BA5w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8ay0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:09:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so2571141cf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787260198; x=1787864998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IRFa8PBGHnBGeWrxOBlD/fGonGDEG+aUh2svbB/9l9s=;
 b=YbezhwIWkSyW2dCSF13Ve/h7MMf0rrB7juYZIWPusVdYREwa9hsO/NVvyYKGE1WaWQ
 RdYS0IC2ubzCVva1CiTrAHEWSlo1BPtbCjWjnpUS/iSc94DLy1Ddtb4/AZs07jDIw+Yg
 9ZN3XGrSvTn3AXfCD4qAqEr7OFoMRbE+VlZeO9GBvqXaM1SzzZeMo7gWNuH0BtwX71Zc
 /bEsNYzdhJZlXkkwk9yMRx5XLbBbNmitUgK4l8nRUlZ1KHf0hFZtF8dkqFB1kGkewwVo
 APQEfqFNM5mSbwT/4aDmkKJLZPp9twStW98GaSoxboU/rrDP8EqwmYoIo88gYE7d1ltH
 Bc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787260198; x=1787864998;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IRFa8PBGHnBGeWrxOBlD/fGonGDEG+aUh2svbB/9l9s=;
 b=fnjsoIlINwMV8cfeUp1ri3q2Kp++xJfpa/48RLpcTdRSwrr27jtAH5afeG6hR8K/HT
 uoevn5OhUza/8Prz3BNuCprkHOAb3rJS4meo+vxbq0z+ED39Q41A7J+8NhBXBo1wPWZs
 CxVr6My5PcyWi0XbChAYMZhdEti0nCcKblkZczHsZKn20aQ0Ai5ceM3CjgUSf8L4y47A
 TDOrJSWdAdF1iUzpx0FUMygyOK2QP6OudyvRCmXwxHyz2r4aKSzEvmFcVPk54iG6iSA3
 +nF3Ev2cmGl1p5fsakds9iJWXRS6dIFdUNz/TjLo7CF6rsRYVuZHVy0MmYEkl9oA2MRe
 dTUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF2yWaB6uDLlQpQ3uHYaXKRCmB86e/NOsz74pwQS7r8P/TIMncJtrWEYMSWAZpz/6vAH17h9Gl+AWD@nongnu.org
X-Gm-Message-State: AOJu0YymHFGa3QdmdFhkLF/RfoDlbN1uyTtg8ZfDAqxY7CFj+7nhjOn+
 4f8n5H64w2lq0SBd+VAhqGPXbZIdMfvwtA4QlVmKDILgnfvbQtUsKpiA/LTNQ1gHNMs0TonngQL
 5Q9RMFQ8iHsN/bX7ASXVn7z6dpIxMBPw2kAZiFOl4TbK41t3xfKr/kLBMRw==
X-Gm-Gg: AR+sD10ymjOWoNXNswYD2vibyzdxBUKEz3Qi5cqr3eWxGO7MD0zRSVO4ZCDD22WFQD1
 qLSBO5Cs5TnEA7P8W/J5FPhGmtlcoGDLREBgRbC6SitIEPOVRptxyd4nzPYEF1W5NlHEu+u1rC1
 Az14AxgbT4cDkxpdRVU0bxArj0wI1RNv5y9LsR+QPm7TzmGX58I3tzSiZrDqOeKXfvcGxolRFBf
 oBPewpWslmq12OXPFV800LltAmZigHXGYrUnDYnEFfSNkJmljK1m9tvCdd79d+pjzgj473J6yis
 OsNbM7Dkmh9weWjky3TVz83ER0Q9/yloOta5yiqbS65ZBCAh7QGyQXxQgHEwNBsCwXI9O7Q3wUr
 gz4hpte5WMqUmLwda83GHt1IlIATIwWm+4zU=
X-Received: by 2002:a05:622a:2592:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-52df59ebf4fmr13995731cf.26.1787260197944; 
 Thu, 20 Aug 2026 14:09:57 -0700 (PDT)
X-Received: by 2002:a05:622a:2592:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-52df59ebf4fmr13995161cf.26.1787260197487; 
 Thu, 20 Aug 2026 14:09:57 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441c85sm17144936f8f.1.2026.08.20.14.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 14:09:56 -0700 (PDT)
Message-ID: <c502e858-4e15-45e8-a195-cd2f9a7ac686@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 23:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hexagon: assign a distinct htid to each DSP machine CPU
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819130341.4076146-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819130341.4076146-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1OCBTYWx0ZWRfX2COTniVOPhqb
 wyWtV4y026rOp1kA6in6UGcRLpVOr+tnJO8yYMyDSW9alXTV1azHM+C4m9ty7KQkZM42o5wIeCX
 IVb1eqorjETjoFIOYBzO3DFU9RhgZhc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1OCBTYWx0ZWRfX/JYSUAUr1VHH
 yWuUjsQ9s2r8yoekAAywxDzI3tjFwqJ5RvtiVMSoolljQnFTHIK+2znqxK8SAezT+cax4gxLQX5
 obZZhPDHKN85+sda7inwEOiizxxKnsbk/gABC+Dqtql67V7tefGePtfTt+kNhvq56+DidwDNQeR
 gGpN/3wM1sAVuf50wHh8Yvtgr09OL36RLpOgRWKI7Ya/9wYMougstuVtWdOmMO72hrPw82c43KJ
 ASIUfc+yqJxDE9UsfYnwt8jDaduUqM1YfL8KEEN9j4/pSfo2JfeRYxeMS+dK6hKAcl4B5v19B6k
 7o4iv2YiNgVrTSAR9+VIBcb11CfExddTIz4+Gp94uZf9boX1onnCYF82/1ssw4B0ANQWKOhVdOB
 /vT4MDU4bLigHpWIOJ+l/l6gGp9mcfrh7G1CS5rhVzXZZyXKDVJ4t2Prqmoej3c7CunAMVpdG/h
 1WVhWRkgYAb+42YrMWA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a876d26 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: YX-cgsJb-EYGC0f7wkRGcQi8imEwO4pE
X-Proofpoint-ORIG-GUID: YX-cgsJb-EYGC0f7wkRGcQi8imEwO4pE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 19/8/26 15:03, Brian Cain wrote:
> The htid property defaults to 0 and hexagon_dsp.c never set it, so every
> CPU on the DSP machines came up as hardware thread 0.
> 
> This bug was causing h2 test failures.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/hexagon_dsp.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

