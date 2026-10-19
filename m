Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F672606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q0AVAPzf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQ0K6AGA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw37-0004jI-UK; Mon, 19 Oct 2026 18:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw36-0004hH-OU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:41:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw35-0004Cy-1O
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:41:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZPQc836428
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cXsZPZ7oms8UgQo1QJMqi/54AATQ1y7Qr6a0RRQXk5E=; b=Q0AVAPzf+N6C0Bng
 28mmVDInB4oruwXVxjwlwQYb3uxjPibrDXNv2aqNYG/HDojsCckIqvj1C7vej380
 acTyO6bCSN9ej6RxxlJ439De9c2Er+to2mpYz6huJ4sTFXrY6HDd9lMLDit8ZJoO
 XuJlNe6Zs+ir379dCwKuGnIa8HcPNnnHfAmRhIqBIgt5e4iSGhRzP5jHZ141+T41
 XBnUHevqseOAwz3y+2J09pTWH1qhCLI28BJDSX003fQFwV1zOobfIzqmYoFde9XF
 3Wdkx6oCiBdp54xcNVWByh/K0/0kLRfN3Ez54OUnTkzzZvQ8RyQ4IMJui5MT3A8V
 N2ejFw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kkdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:41:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so72054eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449701; x=1793054501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cXsZPZ7oms8UgQo1QJMqi/54AATQ1y7Qr6a0RRQXk5E=;
 b=dQ0K6AGAJ4y0VJCiPle2BJ3FBEEkdpk2YKotwS3cPgeby1LSuf3lJPn0ykBv15Y4HH
 JUkp8+d2N/9lvq28rcowShSd7f1qNJRT3FWnWanJBRDnN9q4CS9SdX76oXPbIg6ij++V
 WBFAeZmqZ2moKPSM7+KvxkgbEcbfglm9QjYwy6d039Z4rurMgT+D1tGJ/mx8mZsuVhF2
 rtsm7+TJ/aLetCw+ao19nDqKiza1VITOKsN6u+W0BATfowfLZ19tJEb2/dKIckQ0MEiG
 9ZZilZC10Lc30TUaq8rxK8Cogh7u3Lj/YEehSx4+W7RBfd60x49ZSn7/ufkVRmrK1bVm
 i/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449701; x=1793054501;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cXsZPZ7oms8UgQo1QJMqi/54AATQ1y7Qr6a0RRQXk5E=;
 b=Lz9TgYd2yF3XxRsUR7slpFc6/bbd6MkPObbgChLZAFQHm8iqhFToqgdN7+m59xwod8
 UVvX+3VUOiAeuQlW2qixCJAU85o6y6Kbp8WY57yg/OTwTfknE9Yir7GSSpJXYMx7nEAE
 nQde4A6qCU5Snb2yY+36a+Gi5/JK+zu7dnP9x1rXUqJG06+3G+4MTlO9Yns+wVJYmxoe
 HIxKBUkR5/vKuZxnXwgeC3wZhaO4uMv57edKXfhBgjerZWIJ9M7h71AdJz9BH4BVcBb7
 w2q6JMrZIxVd2QqkZVEfzgSX0xvK1v95TWafQ5zhXKsDZYq4ufsEr4G7Kg6ui/XcqngA
 4lhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRV0JqcAsQWutTwthCH6e3RiYFQNMeJMSx0pfJtVjFy54Lw4nRUu0mPqFk+esCXRCX2LraONq0nb7b@nongnu.org
X-Gm-Message-State: AFq9FYL91+y0R5m5bWmiHSt1EFVkO1FzUxC3tDKsSnky0fzffczJUdfs
 yBLDTzhe+75y26lWYNoLy/yBPA2t/fHl2rJD+itMIDbUzgsB+NtxRkg7BhREKXSGvXfEDb14qlT
 tFJEtfSxgmVN9Gf7TUfa7bBbLzrsZ3drg6uqQncn5swmsfOOHAgsq4lAjoQ==
X-Gm-Gg: AYBFou2r8cd4yRlmO99bQQCZ9A1nhrOPDc6XYLxzXPO9gO1nXRJsen6JDee9hhts2/l
 ZnNKqupt2/K+GgtyZsTvJlWVc6SZRKjkHIEG02bT9Ut9Nn6ghNgkj5O5B4y6VAVWdxQ1bzpQgrE
 hTcpOcJaKS0bkGBl5ah02BxoCLRMAawQQ62JYHZxpe97uJ75oU4K4m/e1nTmS0SG4S8Vb8hl5vl
 ZuUkdoU/7fRY6jGVxqmeFSyBby+MFTDdeDzci3QfozqZsP/s5A2cZJnJ4s0XEmlI/dL7+xJWZpg
 41SZZ1eH0dc8wdpY02mLoJ+SCgClbjE71o4JhLDnAIN2gWF2fdcVh8/k2iDtiQHM5M4VgEG5RcX
 dKBM5xJu9oBrnjF5vOAij+lJF/2U1JBqc5TYoPLhfTghWilUlnfHM0gS1DJu58FqFMCtKMg==
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id
 5a478bee46e88-361a341c8e6mr17723057eec.37.1792449700778; 
 Mon, 19 Oct 2026 15:41:40 -0700 (PDT)
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id
 5a478bee46e88-361a341c8e6mr17723011eec.37.1792449700202; 
 Mon, 19 Oct 2026 15:41:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082f7f6e0sm39492665eec.27.2026.10.19.15.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:41:38 -0700 (PDT)
Message-ID: <92e3e0b1-c679-43b5-b031-3641da074ea4@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:41:37 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/hexagon: reset implicit USR write state
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
 <20261019223253.3243067-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019223253.3243067-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ETABEuUweyvNsnOKIRMpkkOjacWmPE3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX8YdsPUn25gAh
 WbTXFezJUS223s0rueckz3n+/upxorWgim0wBo5s7OT07Kr23a8mfSMNbYFG+LUPqdccpXC3ffY
 23j9TMR1WyamlbhQ6v8oY9W+vFIBCA/toeUlZ9t3pR82fvER9aCBYLNWDb6pvLZ5dW/Bhu2Mjgj
 FtOHwIRr6nJgQDxE10J1gUnIjUIsinqfq/WeWnUWd2i5wMhiq0c0KSFcOKUH9wH5mIbrpbO8VLV
 x1JkA6r2F80aaKfW/ft6qfbjTFPNhkfGNU5YRcj5d9E5r36KmfGJd5B8jlyohplvkIfviq47QCU
 bZu4fhyhV2ttll3HxY0vXU3YdfPCHM1KvITOlsVELnf5VmwDidl1D7DsmzPYc2CEzX8D3iORAQq
 oZlAZr/fyoRembIDaHbuZ1co41K/pk8q0D6ehQYDVRRqxxeHdzaSZg+3s1vG9XLfCv9XvSsdvmX
 acnN2cNMzaBZmuW4vOQ==
X-Proofpoint-GUID: ETABEuUweyvNsnOKIRMpkkOjacWmPE3O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX9djX8k5oGzij
 0Wqa5W2x0wl1rMW6kZZkOMWkYt7fNrKaWRnof4rjRQvICPnKpkyHw3f1JkrqxL6jClq4WEwyy5p
 YqT8kz4koE5n5WXAkMdkoJpSv4ifkJg=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad69ca5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=37ExK8SP7zd3Lk92wYMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190090
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

On 10/19/2026 3:32 PM, Brian Cain wrote:
> implicit_usr_write is per-packet DC state. It was not cleared before
> analyzing the next packet. Reset it together with the other per-packet
> state.
> 
> When running qfloat_v81 ubsan reported:
> 
>     target/hexagon/translate.c:725:32: runtime error: load of value 192,
>     which is not a valid value for type '_Bool'
>     target/hexagon/translate.c:874:12: runtime error: load of value 192,
>     which is not a valid value for type '_Bool'
> 
> Fixes: 3e98496691ed ("Hexagon (target/hexagon) Implicit writes to USR don't force packet commit")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

