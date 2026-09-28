Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDEFC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7lI-0007tN-MH; Mon, 28 Sep 2026 05:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7lH-0007sz-6B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:35:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7lF-0006NA-EO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:35:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MX22246483
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SZE1uZqb6l4pcfeY7sV8HeRL/Nn8ediLKBTfnBltiRc=; b=grhAiCSDAHNqAa69
 6y2y9IsV5O/hPOAF4LRywdRnozIgD8s/ope8u+S2qGOlN9axKYG2QR02/1vVp/zG
 nXkaI3PeZqdXnEt5HKGmSvugHaC68jN93r0Ea/OHcK1grU5QPb56+hAwl3OkHAIx
 bk+Pj0rLSp9nYOrHfPI4Atpd1NR+HzMS0DllzYG7ea7F0sGoSAp8NeYw/xZeHLMd
 vWWYJyDX1TQtXcF/Wlgzke1A9BXfjCXdhlbJHQNIwY3ArlnzEDiPwQICQarbYWke
 +zD7aL/rHu0ubsDVf3jnyOmwZeU0jEehrqrhr/svf742jiEJJgzGvUWs0s2nnu0G
 Am1mog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt10qr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:35:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c673116e3so280097885a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588100; x=1791192900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SZE1uZqb6l4pcfeY7sV8HeRL/Nn8ediLKBTfnBltiRc=;
 b=YJEyITDPdsmO2c7DOYqnN8iAV43hrtz4VJU+hQPJicO5DllfMWyEdlV7Q8CyvQRw06
 GLDJilzDM66dNmyLaspzJz9AqXgJ3C3v6MF3SHF6gqxpyGx/y2lCYLLDdl3gNAdc9oHP
 DYZGtUuY9ctLFVg2WmvXSQj04H64xBzKI6OGa2zYGVPL4mcWK7yztbrQG7rMfj0EJtWM
 zC2U+hCsVQQdbzQs2mtWOQ2UeScn+U40HTf8GxkpNsVPh/yCYRY7ouWKy27tDw9TUE9t
 hw7BaPvn5WSVrkr9eE0S9pQs07fnLiWS/Ekw6Fhf0eBXInQTWbtaT+GMdTsZfJUaWnPR
 rqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588100; x=1791192900;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SZE1uZqb6l4pcfeY7sV8HeRL/Nn8ediLKBTfnBltiRc=;
 b=g7VZopb/jeuo4jcFrjedQqpU+MI3A113mJjdBsIB7qxR7ZV+i15nxCvHELnJqmt2Us
 5P/ngay5mRNf82/wO3puJQyi8Ool2UcZup7QLOHYGqfaeawh1VgdGoVXUPtiFlP2vDRk
 Mi+p3kbX6js1/J5HZGu2WLpGjWjJxyz7sepwB0iVOWH7BI8Vt664pe2pgiKrlTHiePZh
 OslfpzZ22Ff6d11vGA8U9886s1CEfhmMuxD2NYXMs3omlDSq4942E9nzs/Q6tV/jZbF1
 gBSoWCtqaNp3raKtuwWarXUDjodKLNDDzUK8Ye8Y3ah2tX+1pA3tmoaPrzWB7ybJR2j2
 tDIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbbZ5Lc5j+YqXaA1/o3bC9Pkt5oLWEiW/kxlioDVZPIGBX0DUDwGO0v5HBy3d4CA75Ev3cY7gSQVbH@nongnu.org
X-Gm-Message-State: AFuF++nKmMYAFmu3s2iumynPauOhjCRjOXU5M0ZCY3p8NK+uR1FbJ/8S
 FBRP+ZpOarhYv8ujY1qp4UZOzsmVayptRzuFIwb0HqpzLX9EN5bkKsZe583EqBqLE61MlgEhLeH
 cdhWeFxiTfRA9eXcoI9m2m0pk9xX5Hq/fcu9D+nQQEZaz76eZeuB67oF9V/vHmUBn6g==
X-Gm-Gg: AYBFou0tLnC3Kv+7ouy+eHUtHKhu9lp1YseD+6B0r52v6QWewXVCpDxSBN6T95t1rGP
 DwTgXModHvsQOW+8dcAYb0rf7Zou6Ndrxs7Nq8CJ2C+aAdMwcLuP7cU9fr2C0XVza4v2a5ZMIZU
 H7ma3Aub/jNi8WASo/g9J+rzMX9llsQZE6Llj6xoVP1S9ZJ23LL1umTadYR3zR4z3IkuBSSCKCI
 HsK94DBeWRKQ94sME+sThzT6evsiqo3x4WsYuxKL87WmtfNT2CLxZxdG0U078WeusWKtbcRsHCy
 fTQZXV6ltPTXKdOJ4ME9qmgH8Bm20OLQEQNkY1tMr225p7fLS9E0iji0Vbw19GyvCBNhjuh9PTM
 cYCCydeJ4Y46fTtCB7KCmb4SWTiahIpDfYA==
X-Received: by 2002:a05:620a:2985:b0:939:fde0:a71b with SMTP id
 af79cd13be357-93c43a4b884mr1914845785a.0.1790588099797; 
 Mon, 28 Sep 2026 02:34:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:939:fde0:a71b with SMTP id
 af79cd13be357-93c43a4b884mr1914843285a.0.1790588099405; 
 Mon, 28 Sep 2026 02:34:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a84221bsm26426947f8f.36.2026.09.28.02.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:34:58 -0700 (PDT)
Message-ID: <8d37e70f-5ff3-49fe-9151-669d0d514796@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] target/arm: Split out check_il
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX69212iD41Dd+
 0RgXYZoQGptM7PKHEjXNPATRRbl4WchfNwGZtoAgB6qFDnINeMRcOBTV1lkugOpKGrLMB0Bsk8u
 TnSjHRXd8NcbNxORSO5ZqYnidSPbofu/y8Z4lmo9TIAf61ZI4rGga5udIU5L8eTRL/ssSAtNUTC
 TBLfYTSUJIU+fgyB7w3HHwy+KiF0u9Qjq3OhbTmwzOLw0wNFnsnOQNqlNNVPEGIdf9bkTbc3BZr
 w62E0JlKPI9q6EGsWUvG7Gzch3wkEppeGLGBzen0rjuxcIv8NJ/16bWaTjz8k4IKGfs0Yo9jjin
 A+zl22ql/fXpgpqEWPbx7RzUC7fUuxwros0XvYXsQawPBjUj6FJ4hDdDohx0anW6zqqV01K6vAC
 ifkVbGeBGeGRaVxYNBMExx0aLWpfeg3pwdKEgvz9pRmMS0XYDdj1A9szeoeJ+0UzUQaYw8DVTsL
 6rn+slNSyAgl7+SMuGQ==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba34c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qkY4aGdKiz-ymbk8aESEV_H-RH3jZcWP
X-Proofpoint-GUID: qkY4aGdKiz-ymbk8aESEV_H-RH3jZcWP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX7oYrsYj20Ken
 vuwRvfNNCe3Zolz0EqWcqTKaEsh3vDyK6Odwm2brKAHd0kHaEPWvoRrDbLe0jKsE8ZYKyMrTE8E
 U4b85UYXBXZUgie5p5yGptJBocjLYkE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/9/26 23:50, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     |  1 +
>   target/arm/tcg/translate-a64.c |  7 +------
>   target/arm/tcg/translate.c     | 28 ++++++++++++++++------------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

