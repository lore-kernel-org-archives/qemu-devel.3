Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF8FC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtG99-0002Uf-Ic; Sun, 09 Aug 2026 22:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG96-0002UB-8K
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:53:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtG94-0004R8-Lp
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:53:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L6qv13434689
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tYOXr1dTyPQGGUKai8jSpzKfKTWZ/j97elMT+EAK2jA=; b=alfWgxaJCU6FSP/x
 x4VlOxHpXl1GNxAdIJJGW9zGB232uaE2ThV0wk9MWPQxFnbF3mdS57JsrGdx8rPx
 mVsQki9ysTabGElBZfAz28xqSY/uva/sfVZD70AKXUhyFnEBgdvBYlIFxoxfD7Kz
 nRLjQKmtBNI52V0DSS5lef/k9LEBb22fGH5L3zta+f/PikfriIEU8ZXNyUz3hSM3
 rw8P0DCBY4rAoOvUZyFXZcc33ZKDDn6zCbAJI4Cd1o1HWIVhm3h47hfWZNXQOsgt
 /XxnqPaqNPHJ5dci5xxoSAi2d+8jJo+fx/jJALrUGtvJASDETui4T7wfMH1EeegN
 a2eS6Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwwr9m0he-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:53:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c07f25de2so10708541cf.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786330423; x=1786935223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tYOXr1dTyPQGGUKai8jSpzKfKTWZ/j97elMT+EAK2jA=;
 b=hZMp75giWJHM9jXTCbLHdTKF3kVtWKI2XUc4+dyXxxSrKDVJGsH8dH9aq4Ka7JUvs2
 yVpfNiKaSplNxY/rwKR6HCf6vp9j5C2Zt/jrikLy/YxVbZ3mmUWO++jrfiTSgojq26eQ
 GNKU+KrpLlnW7lF0HbgzGRET8NT5LHK4z748FD5+JPjkYisnnAKFd2hqv6SgpzBH0rEA
 oCgarCwQpDeIojMT4vjx6+63So9pvH59/9N0yj2FwUNawv68/UIHH5t00G4H7kvoJOrg
 l7fe4fEnns7Sb3WtEJrnPLAWgb5X0wK4iqGly0S71GjYtdFvbOqritZOqb0vcUw/uU+b
 CqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786330423; x=1786935223;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tYOXr1dTyPQGGUKai8jSpzKfKTWZ/j97elMT+EAK2jA=;
 b=XwcLNjAvyKTKwJNaXCPDJgEvJJF6qOFBqKY3ohJfeTR6tK7wNhWd7qE+v6vu1lYImy
 5bcFRt6eyHKgqx9lR1KXKmP8BVl3SzEhOiNshE4d7Mmhh6mk3fBlJsx8iZgUmZxs4lnx
 pg2DiEIND7ODZ8gebksMufZWy1xFXRYZGPHHcTw9/RlxibeXrlB0ft6Io3O/gCqM4F5+
 O9yzX1pn/2NBkGO65L6p/uzK0i3gvKRXKCZCgP42YnCR4vFM9LWTlpFwZu0Byis0dyr7
 uaC9ku7mAotd14rt+PDPb8esA+PWlgySg3lT0/vcfZj3b7Lkk8CHxQujxiqHcTUZh8N2
 AKXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCqhbg6gQEh+RxlmVJ8NMvS6Su+4yVR5PL4Vzas9b+Y5D+tYvVDSb/c3v2gOZQgvFFVXz3IBTxxxX8@nongnu.org
X-Gm-Message-State: AOJu0Yx6cKYHxc+GbJbAJtlMbgkKEYaEkn78AAToECX4a0xZ4Jpp4u8a
 T3Gi1h/jdp46xxRHVOqVpzIs2W85tV66A0rgD8Tj2U39ayskbfnHzCY2BGeneWYkedNJ//GQfm8
 QsIA11uXujIyIFTIbeQGCbFiVL/rD51wyd35Au6d13rL0As/+R7iTFmuTwA==
X-Gm-Gg: AR+sD11gM8PxEFl7zwI+0gkpOWwCAA2PRHz7pCEvuUYmx6ztyeJN/Pe7r4be7Or1uGq
 zaYf8ai965zVSrYJ56aljc3xPS0Qaxw1gY0m8QUO4sgrxhcUYheO0FFLr8O18z1K/lcvq7pnX/Z
 kQyh8oFYsTwvUplSNiVMLljea+uVGmNMvWFEW78yFJrUuvFFgInMKVRX9+LP6ZsIYGzdoZJbkoU
 njmbLLLQfiW2CHs9hnJfi26tPRWy9SSqVVg29MRz7qG4zHaNM26JRcCmWy9PrqVF8ImLtbW+xYb
 VuaT6Hj7n2feH44LinyGw42ba93Vp62Af7l6HGFz1VEiKsPDwvNKKN8I0D6T33qNZfNlacGL7NH
 r+0Hlx4wo6/IZcMA8Liwc3AIpSL9yzSFnn8U=
X-Received: by 2002:a05:622a:407:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52d20a165b0mr193534121cf.28.1786330423310; 
 Sun, 09 Aug 2026 19:53:43 -0700 (PDT)
X-Received: by 2002:a05:622a:407:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-52d20a165b0mr193533921cf.28.1786330422921; 
 Sun, 09 Aug 2026 19:53:42 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e702dsm299190525e9.3.2026.08.09.19.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:53:41 -0700 (PDT)
Message-ID: <98fd96e7-7271-47f7-86bf-bf48fd44c613@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/56] disas/riscv: Use signed type for vector immediates
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809223545.730664-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d73FDxjE c=1 sm=1 tr=0 ts=6a793d38 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=ICxcSt9bB_aP6qSnrdwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ctZk-jwrQfuk5_BiO19UbQykIdl0XT3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfXxLiDszDRVnSy
 HMMJqLyvA1V9XIgLyte6uWvCTY/vlbN0C/tipCtmyBJmwvAdO/DCvQ0ZJp6+9+ek+4MR+1MXruC
 6ds2VVuwyDBrPtDp/Gh8quQR4NOcTyzn4VnNvnupjKe3UAjYw9sIbOHLT2oCIrZPMUX67CaB180
 Zuvrha6DiHhUJD61o9TaSKqHpGAyVBlVlnXQfkzqn80TKlBDAy0jOKvknnMdqkcf35QexU3YYaO
 v1JE21l68Ug6y6pBZO2gq83TWcWXVVmT33VaCtctrSKJQ86X3L+G4VKuwlPphkvtC/CSwqdFhQa
 ACgiAzG+dEPdQ7pdFNB785Knf0UdoV7mLsdfK346P8gteeEEv/MxhNRmfxFF/tDHEFpI4/wt4g7
 86iSPhEzxbzF/Yv434Sbb5rbPTUn80KQyHvaoT62cNnFHKWI6Itj0C8aZI3VpbLqHDbHun1+KSw
 8iegE+zG5IibiXkpEaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMyBTYWx0ZWRfX4zDCtaAANtCv
 p8aLJg1Ang3WIwRN74fa14twdsDMOwDKA5gQJEmiW2yLviWCljD/wYirQABp4a+y4OIFt9Ob7rj
 5VxkVh45n8m1/X+bSee9Mn9Kj9StTK0=
X-Proofpoint-GUID: ctZk-jwrQfuk5_BiO19UbQykIdl0XT3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100023
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

On 10/8/26 00:34, Richard Henderson wrote:
> From: TANG Tiancheng <lyndra@linux.alibaba.com>
> 
> operand_vimm() sign-extends the 5-bit vector immediate field in bits
> 19:15, but returns uint32_t. This sends negative immediates through an
> unsigned type before they are assigned to rv_decode.imm.
> 
> Return int32_t to match the signed value extracted by the helper.
> 
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

(Missing your S-o-b)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Message-Id: <20260703-b4-disas-xthead-fix-riscv-next-v4-3-84c566330bc7@linux.alibaba.com>
> ---
>   disas/riscv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

