Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA93FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDTE-0002Vt-Cf; Wed, 29 Apr 2026 18:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDTC-0002Vg-NN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:33:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDTA-000850-Ks
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:33:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKcOfr435457
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AGLaEI7ZNs/GNFUvJGPZVPfGfcYo0Difzv8UX1rtRxU=; b=MWCK3Ee9OY85PVPU
 w+i4hfxPtNnee3NlZWHYScsctD4cT8pKl6ecKqnTbR2SuXcC29dkCaFwCKrYUGZU
 KlDrN7gdc7ZnKtPVrIcNEqbj5SX4B656er8zzjQiFOS/nwzAFjRdQYLBqwjOYSFu
 zKvSL8+ByWiTTdTckryh02T8TXC8YH1MA3ZDrb2QHkr2HKfL9HK6pV/+fZqjMk8i
 Mxjs2FqcYJtmEjRToJ+jUQaL0FbVVjxTfJj9VsZpWsB5olxXZ3PT5ZyILKgUITgu
 eeWAd9oNF8uudt6imx8boo2hU2rsamw/FJkKCN+iS2yMgnWVYuB5LBget86OYNjY
 kz2dJQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxctfh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:33:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2e60238adb1so1149006eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777502002; x=1778106802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGLaEI7ZNs/GNFUvJGPZVPfGfcYo0Difzv8UX1rtRxU=;
 b=XB7aZkbzvFKDLfIeETakjD3qy5WckW7RdhbchE/JXXWbOPy5mClwXscOXcZAoAW4Q1
 xB9JDAABLSkzoWV0WoOQ1Un9noLOc/JprbpHOkZI6ldj3/BJ4vQSyDiFOMCHzCs2rARq
 of0M4gu3WJZchankZuIADsLFSGCVdQ5/kvAhP0a/6o8MDDg3+T84An3lGYviJpKiW/gG
 Igp1uGFeXB/v8t0jO1W8AtapLaes/CkuZePcj1DLnDYlNm+07O/pUqvva9Hltgfpm+l4
 3+jb+PZMAe9Zv5fYMtkFxnpz7Mp1Mz7pHSoZ9Lk34Q4WDTldVbnqyWtwpEAbW7YYgH8G
 MG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777502002; x=1778106802;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGLaEI7ZNs/GNFUvJGPZVPfGfcYo0Difzv8UX1rtRxU=;
 b=Fh9cK9YkBRmVaJr9/8uJW26iZtqZy7FotluGGAdZuXI5J7us0Y4RYT08+EPtyWOMHJ
 IcZ19YHV3dPL9rqi1L6YRYj+fIUpmBupIMgEYcYOz+Mfga1jH7oYOTa2WTsJzYVKhG44
 CpXSa2xZYjYOAbN/FH+5fAcV1R9h4ZsViNnUMtEUkmC7R7zqqbLPe/UT3Kl6R1KADmS5
 t33BNUtXsGi8fZw61kBLaOmczIkJCFNuGxY4qIZrJQZ4W+WtfbfuJS7yWDU03zLKCeGH
 oIEN03at1Do7zBtTHtiy+obNuIGtir/NryG4bv3qjmradg32UEPQTcFfdztb4tFE2CyD
 5vWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J1N9L3w4ePIeLoP2ZV5fvJ13lKUqXNpIcdtzvgxCn16S7zZhI2MqElqtXFs8P2gajCsxuMPGRAV/H@nongnu.org
X-Gm-Message-State: AOJu0Yx2627bmBlydF3QZkUAtjccxIsU+ZVpRs3PmG2Jqg1S/3y8umIW
 w4Y21eieEZ6jYocM3KSct5tSs2x8kBHtUlDPc3Ma6+PeckLvpp1hPsztA6mTEKU2Ih2ph6FWkFt
 /bjRJyFwh/jFAqQ5ylgr9HSOKEy862ARZxpfIU41qK/U3OZmcLZFb6G5cIw==
X-Gm-Gg: AeBDiesHJPmSZPXsY3BzSZBnVHpXCe8wKOj/SUtQZFW09r1hVhqkEB0KaMPmvpDZLQA
 I/r5dLNS/B/feod0dtbzI/93D5g/qqyYw+/XbyMU50yFUc5WY7+QyhXxdpTQ8PRYNj+fd2u07Vi
 SKn6NFPNDCvB/Y716tY0fzqAriqd/YIGIGmpEY7EE6myKIYFZnRJPa0Qm8CmieUHyIQXT6rPSy0
 7IWdPOC3dUDebnDinMK3yf/ZjjIk+UI1X08jHaDtehGOsg+aJZauYf2Rz6bmjUciWIJOjK1fd/J
 L0U3gi3DXOSSw+tHiZ+mVq8ZQM3jseXQCjswnWb1AYe1lplvqOlqz9uFUUi0MKuSvNA4CQvYr3m
 4FZTS+N2hypN7fxqIGkCHB2PdI1oiCeSr7tAg2TbZkov3KEr3GENYslsbpjFYs8UGRkJdWYoZs9
 Kqv/VzB29MM7GE3+DPpCGFBo8Q
X-Received: by 2002:a05:7300:cb07:b0:2d8:97d6:6ac8 with SMTP id
 5a478bee46e88-2ed3f160a0emr85017eec.21.1777502002213; 
 Wed, 29 Apr 2026 15:33:22 -0700 (PDT)
X-Received: by 2002:a05:7300:cb07:b0:2d8:97d6:6ac8 with SMTP id
 5a478bee46e88-2ed3f160a0emr85001eec.21.1777502001713; 
 Wed, 29 Apr 2026 15:33:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm4049951eec.24.2026.04.29.15.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:33:21 -0700 (PDT)
Message-ID: <aec97ff4-0405-4fc6-acbb-9541a995d0ac@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] bsd-user: Create os-syscall.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-3-67a8d09dc13e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-syscall-nr-v2-3-67a8d09dc13e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BLElLyTRqQlvsXJLJJ1GjEX6dKF7VMQI
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f28733 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=zPWb69MtDjhs_HOxvHYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyNiBTYWx0ZWRfX/+C0nQikCTdN
 WQOmbcaj5qtJoXWzgfgcF9/XzQRMPcoSvbUR1spsIwr3bzzeGfjH9rlbfF+kx11PhNQ/wmgfV7A
 JXfYRYm1RQ+CTL6MK433ZS6MG6p9IIZ9sJiSxQZ59qkItZGTmsB8rxSrNCBRf7lbgkWGER79OXB
 MqRLm40CowWQCMrdB2WnybSK3aAvFMsYkkLh3x1KMYdpmb1o/G/+xKkgdGw7YWOhxShUWbmxYtH
 QPv6pu8UjykJXylujGkB0Foy6uTOhw7gOJu6bL/Pr4nra7piDnDKm1LGXqPCzrBl7an2O3uCXrS
 FkJtvmmk9GQXHOmMYE/EMpcEZ6Z6zbpIVdNl/HBcULMPTnb95g+YIAeH9Fg/dciWKblabwIxh8o
 K/V90dRvszfnByi4B6ZUPCAcyG3j8SiaHf4GYTd/7d397E4uMO5GH9qcohr9mTIuoxMX2FaCZvh
 MPxBRPpLmDe2Js0a7DA==
X-Proofpoint-ORIG-GUID: BLElLyTRqQlvsXJLJJ1GjEX6dKF7VMQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290226
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/29/2026 7:38 AM, Warner Losh wrote:
> Create os-syscall.h. The purpose of this file is to define anything
> that's different among the BSDs, like system call numbers and
> time_t. While there's a lot more different between the BSDs, this is at
> least a start at capturing it.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-syscall.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

