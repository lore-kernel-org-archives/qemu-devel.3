Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D624AC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXxf-0007lE-QA; Mon, 24 Aug 2026 12:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxe-0007kj-4r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxK-0002sH-NW
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnPrC2384751
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HmXN1FC2VSv39mbbaJczSHSh7tqSHBnhh8x63yC2gGQ=; b=KA5IS/30a5Z7DzSR
 pFrobh4W/KL7eJrzjWGyJck9xK1wsW157Nq97JGKNoz6QXD7NV2hBkPfrQgfgALo
 4rLNUd7IROdPiyR+hkDKI+xCg6481CAa3j/MVtZH1UPMYKCbbq3wOPMVeGD3aeR4
 5Mer6BxbLjwvEVQdFZyrKe40BHOfJbxEThxuxzeOeUDveR1xhrJ20HnOWSMGq77H
 SeQeTUyYmNmzphgaS+ZpoWExRr+c8wNcknoOMN6HrHm8ZQLJdKIbduwuJ+7ElvM5
 mCHYLn7gSLSzH729DHmQjSgDR46cnVI7EYFyIsYllE1xedWwMqx4USvgyXLZ3ijR
 +T4fEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv79rf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so5566352a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787590526; x=1788195326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HmXN1FC2VSv39mbbaJczSHSh7tqSHBnhh8x63yC2gGQ=;
 b=GywuTpLjefZmaE+E7Tdhi+wTIERlXBr9YKnsTN1RDBmvI5pmuwwTKsD1dAWisHjP8J
 1Ebz4cZQ45xrxxeAoGeL1PScNHsDw8Eec8pEVJR+OKRoydRU+J4dv2G6VQfkliWIqoW3
 U5V8q/ZiAChmjsRMl7NHH503pjnchUnLa5jKSVRLql/A7g147LaFkGgxDYNwAQc75Evp
 6llKb6N2baGIeommJCo1HxefTCnvUsYRDvaGDQ4u52e/TRTSgiBbF9F5qfwlNn7t/Ox+
 STxtRuGWfbrwlzqDbLXjtjG7IVIJP3iz+X/oNm1ggG7bDv7rM57ZMl9vYb8hiO2D+vVG
 GJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590526; x=1788195326;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HmXN1FC2VSv39mbbaJczSHSh7tqSHBnhh8x63yC2gGQ=;
 b=nrAlsnyKCAovXZ/whvRJNnxpF6z/LnqdZEiBg+iB5B4E9g5O9ZKF9tM9hnTmHzanDo
 ReJe9mYzDeQpm59EWayoDG/zaHz4crl/bqb/WFhmxLju4eQ60ApN4ykvsC72xDxodLKw
 hFJK9rXTp6OoWiMmXcbTXDExx7Ld8r1BNM6o+m4pAW9mCWcy6qPu4UmphRXgDeBVCKrf
 FmOn9KMR9Ip5Zw7vwZwE1aM45Smq5SZDh127PNTgK2Ts00KprC5nnJZhuHaa6km0heH0
 DFxQagGsWaXsJZENavpds02HwNkZrEPE2ntei9se9tJPs7w9WxBHqTgbJ0hD4cVIJrHK
 wBhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTWp3RDdv2tZ/JyaZjusYvFVVkY6z4PVCIZjw0Zs1GS6sDeowyCoYEPnWTqGL3lD2osadNs/o7LHP+@nongnu.org
X-Gm-Message-State: AFuF++kLmzMbq+gAgwDIv6iONqUYchbtbVeCbG05cMtb6bymfd5OtgI+
 nF3zPcmLba89Nk8YPXP8SH9e4SpBkMuY1REE8s7WuXodObtdJtX7PVHqHmPVcgtw1SNvLYGSfSh
 5oaZRPE9uG1PIIpmFmsP8VxG0ks1JNV38nqyxb57a4at729eksWsShAvjuQ==
X-Gm-Gg: AR+sD10KxzaDpbR0ZKQ2bI9ZtKuOaFCuvVrKd7TePh4ULkgQfbSPeciyBvLQswjvSeX
 8kAVZ3VBqIds2ij1EwWGYeVfyhPU0fX8f5sOTsk8A1N3Qz85s25IrXdQPQGenw44KS5Uhp3l1Jw
 8SAO0W1wuGPiyGWjjfo3LNkeE/UTt/ihYctJomBHPTsOKQcFGT9eIFBbLrhOSXH9YsIOR8Gs66s
 L0ax0k6w0YLm/ICIiL4VYX8ax449jXS3CGMId7HhpGDnwdw75bWHs8ZV2U1dbvZJB4I7y9pr3W0
 3c3mjNkQLNP0eusi3S4s/dmNSXsBFlhkqpzcn5qRwrzjx5LE5llilAKXpcaebtvRVHsZ0GZ17qN
 O41nBgi0O7lGBaYCVhT9mL3CuanXd1gAuZXrCPkSSpj0NgIl+gH/GORusRugufbC3M+2k
X-Received: by 2002:a17:90b:254e:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-396464d2917mr478055a91.9.1787590526150; 
 Mon, 24 Aug 2026 09:55:26 -0700 (PDT)
X-Received: by 2002:a17:90b:254e:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-396464d2917mr477966a91.9.1787590525714; 
 Mon, 24 Aug 2026 09:55:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d993d1sm181715a91.15.2026.08.24.09.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:55:25 -0700 (PDT)
Message-ID: <4d1a6daf-5723-4879-83db-ca832794b8b6@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:55:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/40] bsd-user: move sys/shm.h lines
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
 <20260818-misc-2026q2-v4-6-09bf5647c98e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818-misc-2026q2-v4-6-09bf5647c98e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c777e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=femUYTpxaZuw2fT67VsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfXxG0uZkCjCVsK
 BvCwxVrgRHQd+UZDCT0N4JSwW9H1im1mi6zjzSl1PlJOtwqZp9/WT3XS6UtOcjL3TRHH2qlq0E3
 cWisahV8Hc4ldjn06n8eaMVPpnP8sgI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfX1SvB1doN7YVW
 z9jGFQYIvsJJG/BqSCQ98ldyyaxzQufh2LvMymCSDEigQBEAoqhAmW65Er1pqGGTQgZidZ2cDbY
 KsbJPazRhLI+dLNuanbeAkLLrQGBxDGKJ6BFA/xUokUEwAzPqQ227B0RBb2I1uWM3TadqjJmfRY
 axiGK0lH/fjS8yff8kuHhOQFbFqNeVjOhtaN5SqPsNBF1TeqLYqv6RtO+aJUdlcPfl+o7Ff9YBk
 iVPrhQ8tlk6ZbpaLhegMY59WAyB8smgh0yKyOlJ/JMXoFyDlTqCGAZEK88lM7OTqP2+1GxXP5Wt
 gCk7SmBSyHgALWT+zOtpzSLcXIYz7dfanyaon1XbLQFcbBCA5nlB3JsM05RVL6mU20yoE/+oGCF
 ZBrcO12CI8A40Ng6MOuZxCcP1Q0wk+FxsDlzmvorQOkhuMV/aHYqiMjFqjJYpZwSLaS7oMewFvw
 enxCntC2atoG/wujL7A==
X-Proofpoint-ORIG-GUID: 4wsZ9hryg275BFfR5giEOBJk3NuuFZHC
X-Proofpoint-GUID: 4wsZ9hryg275BFfR5giEOBJk3NuuFZHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240142
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

On 8/18/2026 4:55 PM, Warner Losh wrote:
> Diff reduction with blitz: move these lines to the same place in the
> blitz branch.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/syscall_defs.h | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

