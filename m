Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE22F99C61
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDpEt-000827-Ar; Fri, 17 Apr 2026 15:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDpEr-00081y-SL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:52:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDpEq-0001qe-4Z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 15:52:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4Hln4068746
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R7GgNgpaFoyiZAohKRO6C+MbRnsb5iRJHpZoYmgqciY=; b=jmWBtVSBrbwuhidV
 H/EOvqrymhSEcp9bSmhXndsD5JnFuhRKKYTeHE3TwDjnhYjNI9CBcXifen6rwrzb
 9w+eDKyig/NZm0PJUdxXodLntA33uNRnJSYpAen7upYy//s2mHrlgZ0dqwdHmMw5
 dxCwiarXWSa5cqEavowLytFzw1Rwm58sgthBoihw+8FgEjh5rwlf3wW7EkMnN3jQ
 Qjm235lXzPgJBlVx9uHiUnjnRIkdjZX6erMni39Fm25ejOg3cKqSHhJk0oet2wan
 Jnao7IH73IF+3aYtqZf/34VMu0CCxE4Me01tD5HJO2+EsjvQ2HBdpGu1qxHlTUYA
 mxWcfA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu265y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 19:52:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c16233ee11so1611738eec.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776455544; x=1777060344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R7GgNgpaFoyiZAohKRO6C+MbRnsb5iRJHpZoYmgqciY=;
 b=LYB/wmN4/MZ37YsP0E7AZs6HlbUYkozGv+/EaOdi4odNWefMwRgviRg+ypKA0UACR8
 Mfz+8SSsibMr4Bc0c1LS0X3/57gH+4t48kBdyylNAjD+bSy7Z+DhPvOAEQkgO8YkZMVo
 giveBnJ4Jg2WAKtHTsq3nTFxaKw/0RXoZ4kG/jhWsA6NQ9R2myza/hyAo+ICBOdu96Fq
 REjr6ocErZZALNg5cvmN3hvTe2FuKMlWVoJjsxzQhpfv6KGyFO7/TqPuD0ti4IB7/RIm
 cogqKMiB8gq4rysc+mLfD47SdncnC9rfY9W1IWHMtGxLLPNY+Me66YO5cgvgtdS04Nh/
 3RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455544; x=1777060344;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7GgNgpaFoyiZAohKRO6C+MbRnsb5iRJHpZoYmgqciY=;
 b=MUA5pygPgmsi3Buhoofe2/6NletbtRuS+0P9EZBh7R3YMq9PD+qk6SF3AqHC8RoiDD
 YxAxzPiHzTjQ/1kPcHUrOJ1/op5HbUDNBD02IXUxCFwcTuKPj7/kB9UinrZq4cdmxDLY
 cNQBFshjjV/3LbQ1LxyZczv8ZoFAG514n8AKX8SvbsE41ICeimCagTxBIVVKzCh3LAYk
 w/W/XA5vyMPCgQCuqYR9SfG9gYDgjMO0nV4VkYuHopLZxL1PQYRA5trvTVeNaukBQspg
 aLO9EUVOB8TPkMdG0aSyvbjazhA0/+I/iqvGPQHSmmhidDLIAKp2PChHyQt51RAETSzT
 6Gbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/01O8QH0k+FKjTO+qBYK/P1+ZQJ62vxouMQETJEALoN+o+wUW/czPaAKNPuS5kv2IiXRngQC7rSilE@nongnu.org
X-Gm-Message-State: AOJu0YylSCKdlYiz/1ZzhKJy008AzEWj/CLF1ammXhZtRxMJ4qkJ9c+B
 v3ITy0XtF+zIs6J067BXclds4wSZ9nde1YD3A0laebR0Q38b6lT6zBTPp8TNnIsTX/4Yp1U329j
 LNCgoA2koM9f07a5cKF3RuN1WdTd+KQiLrD9id4fps64csoRQjv+lM+EQFg==
X-Gm-Gg: AeBDievoBwjmJ8JAJnQhLmItx64YncBfRIQRFcJOP15qaXjg7fc72v6Yrrw4mgx0vmI
 k7pokxUUvEj78mZPSvwks4szGZtoPbuhsEml+M+EEjoQPjhthVkXiQVtBdtzQlZO/yQVzoCGjg9
 S6/11ZFpy+yefOG9HYi3LmkxdmxOhkZQD+YPY8fu+7W3gJH3iwtNOJH2XcLcaEd2N7pD+LatFTd
 yjC1Mnks1d8hup7/XPXRq3ACMSSZeudwSxuryd7zaESFb9R6JLpOYh0ltyLOjpu6j9i+A3ABgJu
 FV/3kmnd/HWZrUMl3MWpQPK3p4XkF2ucGsrbyFF0zd77UWX9cd2KDbR4TI1wrM6ELRDsQ104w85
 ShcMmbm10zyvg1Yg1qaZncKTvnDewo9sMOJWTA5BLlHDL503rOuvySkIyUzjcjUs8WcAhjCrChW
 BH/U3shx+k4IDUYo+x4wvhtxYT
X-Received: by 2002:a05:7301:129b:b0:2d0:239a:23cb with SMTP id
 5a478bee46e88-2e47873bccamr1828210eec.16.1776455544286; 
 Fri, 17 Apr 2026 12:52:24 -0700 (PDT)
X-Received: by 2002:a05:7301:129b:b0:2d0:239a:23cb with SMTP id
 5a478bee46e88-2e47873bccamr1828201eec.16.1776455543739; 
 Fri, 17 Apr 2026 12:52:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ab8b89csm3589147eec.12.2026.04.17.12.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 12:52:23 -0700 (PDT)
Message-ID: <d1cd6fd6-67b0-41f5-8f19-7e7c5a3b5308@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 12:52:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] MAINTAINERS: Transfer CI maintenance to Pierrick
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260417110550.70068-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e28f79 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GKQJgnKHtkyUwfQ1Bg4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LSol5vwHXeZFNG0l3VWNVnkTZ8dNrpgs
X-Proofpoint-ORIG-GUID: LSol5vwHXeZFNG0l3VWNVnkTZ8dNrpgs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE5OSBTYWx0ZWRfX8k+stSMQNf95
 QvIazlSowR8ZOd/S3RyTJJNCW900ASAOkwbOG+28mLX5L2H98u7QKbltipYrPrTgopWYOdsvher
 5aWuRwcaKXRxh4bgN9PEs5a8TpiunMJN/pJZG/oDG9uOaWrype7lBNi3FlY+yPFKmkw2/DC8FKQ
 8PaHD7wmTlHBXVmPTYPT5tVtVM/+DgJaqCrz94X7raH8NNFCbtHJ18RBA29SdWYqeD0DQeiZ2DB
 /Y+vC21g/o6mdD8EM84gIyibqETDu1xxOSo4SL1ZJgNg2fkxMSkVqR/VqYwq2GCdqEDgVwP2O4I
 oIQCO5Pm8exVynUZXPQwLZb4Y/1p772PDVCWLNveePLlDEFYjGnEimfa6i696Jyk+KGpFEsB+S2
 jZTWDkkxGdOkskNUIJ0RJgi4RPlzanJcL5zQZB14/T3kiEfBJ7EDhqR3gwhZSgfP8k6nyfQbvi9
 WjcTQ6bnMNX0pt1t6hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/17/2026 4:05 AM, Philippe Mathieu-Daudé wrote:
> Pass the torch to Pierrick who does much better and useful
> work in this area: https://github.com/p-b-o/qemu-ci
> 
> Remove me from custom runner files since I don't have
> contact with OSUOSL or IBM.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Thanks Philippe, I'm glad to help on this.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick


