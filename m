Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F7CCA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvGB-0001mI-AI; Thu, 08 Oct 2026 17:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvG1-0001fk-0z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:02:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvFx-0000ui-UP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:02:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698KxsQc921790
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vp1iBMTlwbES5DWMTm6OFkz3GJoXN/iAGArdxhTBRPs=; b=hBoYYaHEahfo2bLS
 LFbehUIrCYiFW5U8KhnEZXyU3GUxLmJxIwgC/9vkfRl+NnjqQZZNyOeU2o58CclW
 T1chCITC8qEymiPEe5VCadubNE5ndWo7sAgaqx50axTuamQn6nUE9fIuJP8xfDFD
 lsmvdJOteBCLU3JcMYvUvNHwrwGmFNtxS6yl9MnJBL2ngzwCBnmVmcG2T1qwaua6
 c2AJFglM+ICRRiBC/uPLnmlRjbr5tI/kgrS2OQYAeWLJ3Sqbh9fb/X9wIe2c6/J8
 Kx5JPDVYl3YLrs337ujU82MTsOsjhPJBHj59PJIs672FjL3VCToYGOK3wwCnJh6N
 +USWNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxw8n1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:02:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so11611933eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493344; x=1792098144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vp1iBMTlwbES5DWMTm6OFkz3GJoXN/iAGArdxhTBRPs=;
 b=c164mWcrY11RPy4AqrTVEAt/30Zfd3n/2QeZM23bH//BLR+IuziZTheE7cn9GTfsDa
 pJ/iQYHYR8pAYZhC6VV/UmdK5jmKvekaA/AruHifLuAjTKMQtRHhK4QVoM32EdpE6LQC
 ySF1gI/icnUYgr6uZ0fPg9CkseFwhZfdl8/kwFHwTPWvCkTy4hGyEOKydbVYR0koAzmh
 qDjUttwBE4DlrXQkw6RJIgkT6QaMETKLUsb4g7LK8X4ZWs6V5hrolL5j78D9F90tZjmv
 3qP2gD+QaRTxHp+Iw4AJ6h2VJx5Vyg8+iILjRHr4eXAMqpVplGttunBqiYzELyp8HeYQ
 3nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493344; x=1792098144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vp1iBMTlwbES5DWMTm6OFkz3GJoXN/iAGArdxhTBRPs=;
 b=VYoCwVtoLh31lu0J1zdXnu15IK+la8kkWBXjB74rLrEPJQz0ZNblbeevKA+gZBUSVW
 Xk4JnGy5H1VUUR4qfoWcGVr7LQ+2HMQjlMvwr8tXYjw33EoZEbHZ/HRrq/tGyPmjVk2i
 +bJJcXpm49T060P+Qf1x8P6pFmBeNsb3r44aZ1XHSkHyhAJLEnjklKGjvHDPAHlK33mg
 BbsdhCUJRQvTLahMVg62aTJZglTHTEv5CXnc+aQlpIZzRfn+6MB323LpzjZXUeevkEne
 nYhEOoLkZtpeCC94eCwfP4MGDSvRhwADVuzGKuE+f7SkLFC7KPHiNnBwitwQXVMWiaus
 LLUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4QQvU6BdYFwEF94j9cldrsxCAm/e8eV1wQmsuaf/JnPz3Vp/zQ6KCIk8rk77LZw2zkS0NxQ0oEume@nongnu.org
X-Gm-Message-State: AFq9FYL+VvXj3cp6IPycTaK4CqpxD+knCVHo6nKRaw3RVEHZEzyPZqRo
 YE3vfUZAdVlcbkolf+hEEjZFfUgThXqyr8BEPyjEJ7MA9rBw8IlstQ63MzojbnM2xeQ/XrZuty1
 WqHAN2jSWTmFruodaYaqmfvhwmMZYvE3nfdPRuqCn2SHQhLHevEE8Hj8SOg==
X-Gm-Gg: AYBFou1mr6Qymx1T0kxut3zZiz0oPY9Ou7DwWFYwQtLKMikbvnJVwTV9npcWKkgieM/
 iRR/FoxQgz3I00c415YWm0wCw/RrExUDowgzMsW1e2626Kc4curSe1oT/RYRTtjiM5y07uG4qoI
 aw1e8qBSxaedRXzdXR77WMXiIWJTeVLuN4QTJ6qHo511qh5r8R6RMPqaV73E/pAyf8T+n6Y7Gth
 2dZ++jO2+ZEiDy0gHXToXF4fIREbOIFpwZA5oaPu0ov0GZHa/SfMAH1ETUVudUkIKW5N1enxXeH
 SdLwM21OtiJd3fkP5z9dlJ0kq1eBO0gFf1kYbseQ09j69iJqmXs+3dN7ELV70F/K91GYqRzeI1x
 1/nsSsQhqSCk99CwXcNwDdHXQma2Y5jDb2pRvC/9tOW31ouRQKg0jnQDAdRXQiai7r9zt4g==
X-Received: by 2002:a05:7301:4b0f:b0:350:4fc1:f22a with SMTP id
 5a478bee46e88-3537e0ba5bfmr60758eec.21.1791493343563; 
 Thu, 08 Oct 2026 14:02:23 -0700 (PDT)
X-Received: by 2002:a05:7301:4b0f:b0:350:4fc1:f22a with SMTP id
 5a478bee46e88-3537e0ba5bfmr60730eec.21.1791493342817; 
 Thu, 08 Oct 2026 14:02:22 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c843079sm647444eec.1.2026.10.08.14.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:02:22 -0700 (PDT)
Message-ID: <004e7582-763b-48d3-b83e-d0e5b2a4618d@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] target/hexagon: Allow temporary HVX write and
 future write
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Taylor Simpson <ltaylorsimpson@gmail.com>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX6TwKCAp17rYt
 oz7QOmk5c/ZUasn+TKL5Mvr86+h/nLHG0WV212Otp+4b/2M2WpG2gltApa13DPI7T3ZyIKDUbJx
 v2q1XutTjCmrY9m9InBrn4wVtHBEgRPOCD3llq8v4FhPDv9NnNKIZ4/oFORS6SrHuOhW36E9DFR
 6P3tMhWt8WtGC/CxevMJIvUExMcPcalMgkOKHVdpq2jHkwSJEpqjZtMrmIdRyAVW5fg85JxFBml
 aOGzciEvtcaCwOkyDMN6wY0Y78IxRHPIvRMVquLKHcq+5LBgujjThgEo8XDEL6+HDEg+7wIDi84
 s55vBfgcyw1xAAqiQPYRLRSt5JN2AVJNXWJREHEXWT/V/pieyCNQGiMgQBiCYvVNi94fesvHAeB
 RyZ9wnpEGX/Hag9UWOq2E+bYMqxTjy7MHEeeJI7dLHC/8xLsl4VKRcshatc3kbDhysXSYeZ4kTH
 D7BiXPbwthDccWmjmsg==
X-Proofpoint-GUID: QvE81_hods9N6UEhVCbTIwul3KLawI1F
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac804e0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=h4qdQcoZ7bHrwCybuYkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX3MaMsvzB6hjr
 BAxYCdLH66hvXsbRyG6Pbg07HMSK/dJAC0JGiZxAHmEoGZe3btqDW6gXDaTXtLw+j0L+KkU1FxL
 qphp/TAvxpcD/J1g1srzf3WgewScmOM=
X-Proofpoint-ORIG-GUID: QvE81_hods9N6UEhVCbTIwul3KLawI1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080083
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> HVX packets with Vx.tmp/Vx reg writes were incorrectly rejected.
> 
> Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h   | 20 ++++++++++++--------
>  target/hexagon/translate.c   | 31 ++++++++++++++++++++-----------
>  target/hexagon/hex_common.py |  8 ++++++--
>  3 files changed, 38 insertions(+), 21 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

