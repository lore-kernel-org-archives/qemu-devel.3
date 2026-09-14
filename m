Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80657C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E9p-0006Ti-Dy; Mon, 14 Sep 2026 17:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E9f-0006OY-7K
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:24:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E9d-0004Kb-C2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:23:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYSIg1553318
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CAo4YEYroVPzXjN1OsH/+v3oM7YEjIISkh/mWNw7pWI=; b=gwnfEv2Kxsxx3LwG
 Ozn2vLV0QsDCo8KTUwd4eVCUVAsZY0zi6s8U0wTUQ5qjSakYKWaW37DJ8M0gzHTt
 rQ0ZO/+ErCwBFV7ePrFVJB5+gJDleWKO1Ca4cv2z8gZuZA3SNv3U1ZSTO+8p20Kc
 IuNEfU71fGm6zfuPhk+liFDTstjzkGBYaTBrv8SRFvxEp8R3KASmgvqVirtT7uxL
 FCrAeFkoowqNuIhxmZs8KBDochbZHz4z8XL6IgwM3I/tOXL2ky+wN0ivRJSJwFzx
 tYzeFlUSjCwOZiqVoTvlrgFr6E51iwR9JmyQmyKjPD76cyrIJotiJVJnQ12JYJaz
 0v8NcA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet0s2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:23:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso3588976a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789421035; x=1790025835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAo4YEYroVPzXjN1OsH/+v3oM7YEjIISkh/mWNw7pWI=;
 b=PNUTNKbwzh4jNo8Nv49GpNJJlmrkEWdgmqCt9+IHq1dqjaTTjueYTX5vGAkx0R0tFb
 QIhHdETkUZL0T9Cvy7T6FeuM/YfxEbjfMOn9GRZ6/EnG/Wk6Mm+mQbQEoyzkC6pCWxZr
 8CX8NGCVPrZ/hRBdQqEOgtoExvbSPQm0wyT/pgiLpna3ZS5is59JiQBQwqplX1A3GJDU
 fy9OemBiBKtXP9U7LMEPQGZCtFBir/Tm+ocGPtaPLuCn2kqIPczBd8vEGYpH8of1SmdJ
 UgTzK7KVKwBuCeHH5RnaFzqHxz+oYnFWzlHqMRYdCCI+sjjnyAoEQPhCYqAy+poUtbg3
 la+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789421035; x=1790025835;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAo4YEYroVPzXjN1OsH/+v3oM7YEjIISkh/mWNw7pWI=;
 b=BpL0ceyz62EkJg8Q/RMgN9gt2tkSI0f0I3jFnQpZoS6LMV/2xpR1LPP3fDIgAc7m9E
 GA5OpfWV3autD4/mxFTGHMPi4VJQajKh3C4isAkli99GO6GIhl/QQkg+Ui1LafRTg9nb
 YqyqM92NqjVNGa5M8AmlxiiNfp1f2hdBKFNeaa8f+Pgrtbmn8SCGO9WeB1JyujZpAQFF
 l8MWnI99ZnRExVp07ef+7Xkq1LvbP2O9UdyV/tPtaoilyJ3IBI8p+Tjs60u73OSZmVeX
 PCpJAPPzK6xeu9KA0PWKAvk1ssR1S9gCpCAQKSDqOimt0G5D/Ibq5OLHeXAkdYcAdcVw
 1XIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTGosk/7hH2h2gVcbV815q1NScipsQjsGFOVnDtoyF4SABaV7ijw2c3mDmamRtOMM+loOv8Gfd5SDH@nongnu.org
X-Gm-Message-State: AFuF++kBziz2IfWXuMVio8xjbA4gbXZqadUpMcz4ndj+pSDQ3F32SRIp
 K2m7XoYiCveOeUnezPMaBEsVhB8Sy2Q5kozcF9I6siWnV+WlFYWedl8LtS/baKhSBIMStvDDCIz
 Wbq1mGqv4+TR0iSJxrQe6qRaNJM4RWH9T3xt7GXywL3leeZZ704zyx7+niw==
X-Gm-Gg: AYBFou32Uz5haTJtrr7WmEDqM0hgoneG/SMn6A/V5u3vSCfR5Ul+K3Mnchp1Xz/nhxW
 XEGVKKYNEYPwxKE0zZCq+cIi7M3WV5srrjTCKs7kmon4RCmt/OvWajTPo3Ypn5Yub1CHjV53ujU
 7AOh8GHV8a9VsDkPN3X8zYiqi7zZsYdvg83ulMansAaegOlhmbKJUWE8TPk2rBTfOLwjDWM/Znl
 fOSyjWB51kOXY/IMD1AF/2z0I/uLrZrPe7inLxZdDamFhMNPiH97WQEcwb8jGogsst5agJcB8D9
 WetSmhC2DvrIxoKQRuZF7C5ywlTHt3TSINIy7hujP7o6gS0hyndrICzVm8aFgOAA/RA26iSJVQU
 f4H7aw4lcJEapvB59++cIS+IPLBudJ0rLMl0mPbvPz90ji5MShZmuy8inTOVUShNQIlKI
X-Received: by 2002:a05:6a20:c99a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3db4061e365mr9642691637.19.1789421035455; 
 Mon, 14 Sep 2026 14:23:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:c99a:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3db4061e365mr9642634637.19.1789421035014; 
 Mon, 14 Sep 2026 14:23:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bc03778c7sm18593781eec.9.2026.09.14.14.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:23:54 -0700 (PDT)
Message-ID: <7920bcdd-5f8b-4ccc-8d56-0b7cc2803b0c@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:23:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] tests/tcg/hexagon: add rounding conv, sffma:lib,
 and sfinvsqrta
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-16-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-16-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX5ZnTHogCD598
 d5byVir9og+ansxVgXYGbiu96F8koxHwvfB9V6hNUnVa5yiustYoqwDwjzFPfbqQ66IzQYYJn4F
 j/G+wfC44KVg2UFJ4Hcygt2KrEhHFFA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfXwjf0wvj+QEEi
 SAgZFpHMqr3qdoI4ANfvK04lj7mf52eqwts/0z6E1vQTAHXzVlykOYabCM49H+k3WPcuVoFduJg
 jGrSqE2xNzB71/lbqJ10UmeJdfiPsT2MW/rby0J39WrMEFiBaKHM0r8tTLCPh/Q8jJ04/KvGcHm
 lWiB/l9TIs+ugDjwNGqFgJIAmeiclj71DveEZ/cVK8UgJV+bAF5FEx9xZuUspiab5khLkO9S6UT
 wqivUxaiMHLZ9mqkO5JwDHEo/PqsU5rWn2wDqCO2+pq0NERr7a25NI8t2H8L38oiOmVJFy02HZQ
 99ftirWlja0R/VQ6npf5zhJrRuXK05IwRap3Z97EAFZYlsbkJrnzSoNALKQLO+s5agay+fQh8dd
 keIxykQlAUV+zscnodmITn5QwroaErbtPnPiPDGYDm8dITJe4FtsNkoSzpMGrKmV92lco7M8CiW
 fdldua5LHD2onzSuNTA==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa865ec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5vgZK_9ftmj1mTTofCQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 0sG2dWv3vBCAgS2S_qxgfTbSVBue8Ox5
X-Proofpoint-ORIG-GUID: 0sG2dWv3vBCAgS2S_qxgfTbSVBue8Ox5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140305
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Add round-to-nearest float-to-int conversion tests for the non-:chop variants,
> sfmpy:lib with Inf-Inf to verify exception suppression, and sfinvsqrta
> with a denormal input.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/fpstuff.c | 99 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

