Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B39C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHSX-00025S-DW; Thu, 02 Jul 2026 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHSO-0001kX-FY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHSM-00051A-B3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:27:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0W9A478614
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zPCsjYgc3n35Mp5p2rqWsxWYLr+fQeTr2WE6O7T29W4=; b=XY3v43NyhR6z4E7g
 2FE7MWYSlxEyvGFUTJ7Wp1A9cCSsT5FR6pWLa+1CkOkKHtwT/XnIr6twE5ejfCCm
 8pNiqCosy6qdKEfPPug2HsU2BTSTN/iHgGtBnqsxqAKcIrgoFrNn1d1xw/vZLpON
 rQcBfbHyqUqmTwA/7DzpZ3SQ3owwU2ogHaMInp6FoEPHpsQ872ADCuV7cJTYM1dx
 MiURLw2cUzGWJ05/58v+1i1W4JDZNTHoq1hBKNnSYwtKZRcd/iZGUQ8/21hBfbCm
 snXi1ByEHoDPLWJS/RvvXdZEcri2FT2Ivw+lic4ILtdtYup/PL+oT3J5UT3C4C7W
 Kd11CA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rv783-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:27:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so21132941cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998873; x=1783603673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPCsjYgc3n35Mp5p2rqWsxWYLr+fQeTr2WE6O7T29W4=;
 b=LEJNLQpzt5FLZ/Vsd9a7bGZH36P+LKx7/7TiJzN9hJ9IIDIXekJ/WE85MsYvbFddaR
 RfEq2k/7GQtBPQDgrmwVDZl0DTB5dae80nB2BgrBxYNeXwCxCAhuotyAU1rJxzq+FRW3
 3EDi7V1bTpI2pneuLRznj1ENSbkt4p3UruIUItdiWDtuBD7i2NB/AKeAsWlPAaTY/tcg
 6kL7ajhoIk4Tld9Ase0cuU3EXgxAQKAewJtHxzqx4ogTWgWGFtqBL+0HDJWo1K6VFbFC
 ipK8u9GyWPJaupGtj8lHzjlDeeBe7QmnvM6+lPLakYwCs5bstse4qXumytsa2XzI5faC
 cOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998873; x=1783603673;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPCsjYgc3n35Mp5p2rqWsxWYLr+fQeTr2WE6O7T29W4=;
 b=IKvygkFCNd0/YhDw9b4bmICnHlyXwHTFf0wtMJhoV7NEGIzpe5pXpU3m0KqsYVaRi6
 0vI7v5GxuBK0SPHizsW5JBG0HdL8AmwaIqUN64Wq691d8oFeyhxqltJH5iatgDZiSWTi
 i7lu7/pQ4isU0KUzfC4pyWay5PiYfEZw54n6UnIAZr2n46Jz7y8pYvvWveYZzn1Yb+fT
 nmY8g8yPGU6QzuoRP+h1EhQyEFW+joYAdFQyr0FjnheI90cfcMxmuiS85uSjWt4UREUd
 8bWqf6RaKVTug1hhXFkzY5ixI3PvMoq94+N2Vh3/DV4mosywa+imtBAm4YJPo0XzDhtk
 qo+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dw66f7ffRu3IuDztxsVwSQ9jTnY/YrXComhabl89XgSagbBOUS+qy0NFOlbEvascVTrJUmq0UADuu@nongnu.org
X-Gm-Message-State: AOJu0YzOI3txt8AEdaMMc1D5RilHlPdQ8T6fb328/bICwR4+yNrj77yN
 2rLm23dRYrqHvFYCo4PFBoJkjrT6pgAjrcPwA903Z85Ffk8SQQNijNtMpkvetTkRtoJg70eZHGi
 fh+1/nvk7f4bCMm8pTaz6tJpr5va2kAOT9ZgeFOl6OFuB+afPk3qlUa/55g==
X-Gm-Gg: AfdE7cljUbTrpfuyvUBST6iuhnJQfw5B9e+3H4Dp/GQKaKFqRCabCezMNk9rf8GHlul
 nEvoHKTy6uCU1Ny0MJx7Nq/BgQQYHpnev6tpfC/Itt4cBDBm8U0ww3MnqSK1RRUHeaHwql5Orgi
 7MU41XP8/Zjg0EmbANuJj8VrUTgZIH20sYxsxY2qMCQznRe67SrICbsk/ZeN8xPYYgtv2rXGEe3
 /cP4NKgK+pP8swwTk5cb/brQIzTczJ/9x69mSPJsIsXRsO3VnwjT3nP5jWY6TvmzC0TWHr+vtxG
 xVNSLEJFW93UirdztpOR1gzuI+ivk+y1F4VN5Gc0F867DeL5+7psYcK8VVj8UVi9P37dqpcScvE
 VK568fnPxDcvJkTlm3Ch7pgEHElrg4tauMdbrDBDqfeZM
X-Received: by 2002:a05:622a:40cd:b0:51c:232e:e9ed with SMTP id
 d75a77b69052e-51c26b3a3acmr73155921cf.57.1782998872709; 
 Thu, 02 Jul 2026 06:27:52 -0700 (PDT)
X-Received: by 2002:a05:622a:40cd:b0:51c:232e:e9ed with SMTP id
 d75a77b69052e-51c26b3a3acmr73155381cf.57.1782998872080; 
 Thu, 02 Jul 2026 06:27:52 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f471de83f8sm26031406d6.33.2026.07.02.06.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:27:51 -0700 (PDT)
Message-ID: <9d1974b9-99f0-4544-b533-80847fee2825@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:27:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/33] gdbstub: Reduce @type variable scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-22-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-22-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfXzopix7yYCvId
 Oe0gDSKW3NOxTpuHGwm9Nx5+fBElCCsnmqytrd4y6sxKFO0iWOIeX1fLU6L5RlCiK+PPP+yawDF
 M/9vUIXCWv2sLO5x3sNhp90LejJWxKwI0H3WiDVVkXaKP0I4gTOl12K55YS2RZD/6kbj2+VdgLS
 7YFWMu/5Uya+sVbSAAo0tusYEGEE+zx6s8gBtlbVIpkYbJfvRsgiF92D7UNyksV7rs5GWNoZNKe
 ZkNhgv/waCYXSBbrRKEf3B9h7sL0zihjJJv3nRaEDl1+wk7QDhhSXSymtQSwRC0K83Bzu5i6at5
 HM/BYcCC3w2L58LZB8v2PgLboilxzbAR4JdmqevU+LcjspW6tWvXdaMciWnb5sW9e6AqtO3ZXq+
 QPHfdfzk8XpAX/GvxxXHKmIjc/zMk2+xQOdvupF8c+HXeqAziJTAAQy7xKsgPY/jsCiASdI95GH
 7XA0inAuzWWETXGVixA==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a466759 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ybcUoSOC-fKh6DwX5hcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 4968p0tRV4D03AbXvk_OBhkttDufXY1h
X-Proofpoint-ORIG-GUID: 4968p0tRV4D03AbXvk_OBhkttDufXY1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MCBTYWx0ZWRfX0DzomS2ujxaM
 DMwWGW6Vl6Oz7xI940XE1Brma11ai+AJjB+B2iJP2eyDRVQJCQ9txha2y65hhxmDGt0Zj1QFPf+
 pelBmMetQMWNyhQcwnvf7P7UZyALCQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   gdbstub/system.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 414aef431ec..d5e09802323 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -126,7 +126,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>       CPUState *cpu = gdbserver_state.c_cpu;
>       g_autoptr(GString) buf = g_string_new(NULL);
>       g_autoptr(GString) tid = g_string_new(NULL);
> -    const char *type;
>       int ret;
>   
>       if (running || gdbserver_state.state == RS_INACTIVE) {
> @@ -152,6 +151,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>       switch (state) {
>       case RUN_STATE_DEBUG:
>           if (cpu->watchpoint_hit) {
> +            const char *type;
> +
>               switch (cpu->watchpoint_hit->flags & BP_MEM_ACCESS) {
>               case BP_MEM_READ:
>                   type = "r";


