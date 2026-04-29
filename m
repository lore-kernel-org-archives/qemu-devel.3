Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8186FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDra-0007QT-Dy; Wed, 29 Apr 2026 18:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrZ-0007L8-4V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDrX-0007eT-LV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:58:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbJqt255379
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q05af1DKRFAJVz9T0P5OXxIxo4ZUovCZKs2+KqfRD8g=; b=IrmrakkIt9OiKUnv
 PVlny83BWJ5yDFjZzoVNCB97agrPjMkeRTvfGGol+lsy5Qvf9jWlqNqd1skwszQD
 XOms9OCJz40CVdZFc7MS98gonU7UOXIH8JjrZf0s17nLqyHDoCu4asrHWhq2e1b5
 lyaDsFBSVJQABKLwcRnaAEtVJmXdOr+0XMkx/2gLy0dnrmn9WsQgBBNOl3ApuMxB
 u0WO0v9BR6J4R2TvJOVKxNfg1FZEdSkamtmQb1I45aGuu7GWHa+FYu4McfVK7SjZ
 ljZcBux/1iOxAZVBwA11eYEkIxKxD006CxTadrxXJev0xteWtRS80vO/3DQlauMr
 Zz8ofw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71hd7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so1628334eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503513; x=1778108313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q05af1DKRFAJVz9T0P5OXxIxo4ZUovCZKs2+KqfRD8g=;
 b=iBywBeQ8VTwQs04n74P1684Lmo+h33WwmOw3JX9DkEudtt+gO01aVwALSqBOLeyMrl
 hwW36NRh3gDDtvO4fCFocEqjcTjqABjJJB/HEYYGjSzM4K4iLyTI+QEbNv4ihcUJbxoC
 9HBkJ+VdYsDUuEt8LmzlCL0JzaPppK1PdZHl/434UEOoB7e65sDaR8VJe6XVpkF/Nc0+
 fQFtO47bDi1UwKhat/JE33CicILf9nAzZi/BpGqOTZtdgl4aAbfvCDtPu4WUVzL5O7eg
 QxauqIr6VpuDPyOGKgHuqZbem7lkJR4qUhoSRMLehMYIY9Xu7AU4s+IYKXmwppIw1QG7
 AUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503513; x=1778108313;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q05af1DKRFAJVz9T0P5OXxIxo4ZUovCZKs2+KqfRD8g=;
 b=IzrsP7I4wSon/rOmBLkOViB+m/kDff0frqTq8mtxjQ8qB6Qcgj9aAXtQhV6BczBTPZ
 iZJ43tZESyQdOkR0dMm8hk5D4VNi6n3G0GViGZQcyYMSHECC6FXG155PtsTy/BZo2blI
 +K13zTfOgltMMZ3DIJgO3AAUTAvGj3hT02ox/Y1KSQbXQEXjdZtJohK8GuRawMaWGetg
 h8ZV+wnJXwni7KCdtOag+Rh8m6xGgaOHP696EZI67dgHBsU0zNqGz2MK+QpiGfKeTCeC
 0y397r15sez1GLTA4KEmc5aaNWuPvaiWNUwP8WROGZ9pMN+DNXs15VvB56VAfxCzqSAl
 mLJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/77ApCc4SnMfFqdi9Nei+YRDoW7h4Hw1XRc2JHqnfSom1/FitdfIF4JaJt5oGr7FlOgiqScx1bZ7Eq@nongnu.org
X-Gm-Message-State: AOJu0Yx1Sjfsw2VZQdFJnK/8LIllmAAnJU7EiqoRf3YKMa28CRvzHFuK
 uWI2Ro5sra2oZokTkSHfwU2zVsZads0IwJaA5Jm+F76m4DGqFbeQgi0uMgM3X8qFreN131FS2nN
 fW/9Ub/1oudt4I/ZKLPovth1TMnGbQgpY39NH7+zZ3o1zdQ3OwXYSZ+R5dg==
X-Gm-Gg: AeBDievtvRsUd9UcBBLnp9+KayTwZaF8nKSex4/43TFnZjJZHxgZtaAgODr0o1SGN4y
 lrkrK8RspUoRFznLV5DW06VmoKETqW8zXn5h1Ssesp4xufqxEAtyCtgtPQqwi8W2kG8n4S/lwgv
 KsiJ58SpgEvf7WBfhPqhWvAEkzKp+DRESshWWWnt6ookots7pKTcQ1tAzt6iA8nsNawlbpfsHxd
 vycHQOWspSFZS9WxaS5cQERqcPRt8VWY8jaxVpTA7F3yE0kiGcOmu+Shn9S+mFIR7ga7GorRrLb
 gk2gCxBdYT2s9xJIN54QJXqeNRzGCvInkUezl3lJq795m8vKRVYmiU3RNmRfFeeJL3j/312gPVY
 lCBCrmMAEaCe1Vis0f05t3RWbgsuJIt7czYIxIalKR06y7sJmngPfLWEBJjzbq+tHVsetAg/nFm
 Ur/dMNsVDYT3DrTEymhaxqGVLN
X-Received: by 2002:a05:7300:e781:b0:2e2:d94d:6185 with SMTP id
 5a478bee46e88-2ed3b9174a0mr139748eec.4.1777503513294; 
 Wed, 29 Apr 2026 15:58:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e781:b0:2e2:d94d:6185 with SMTP id
 5a478bee46e88-2ed3b9174a0mr139737eec.4.1777503512804; 
 Wed, 29 Apr 2026 15:58:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0ce05bsm3952263eec.26.2026.04.29.15.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:58:32 -0700 (PDT)
Message-ID: <b1302cc3-88fe-4fae-9360-b15994348e2a@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:58:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] bsd-user: Add FreeBSD file I/O ioctl definitions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-2-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-2-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7baKB4UNY3wyUf5ZxL8v2Fn0q-R7hRMK
X-Proofpoint-ORIG-GUID: 7baKB4UNY3wyUf5ZxL8v2Fn0q-R7hRMK
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f28d1a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=CNTGfkPRrCkcOj8_CuoA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX+bjL0+kPBtqy
 3BKXzpww3GKWtJ99a76S03jOAR5rHdJWVh8LhsfATnPEEBTJiE1LMRmf2dH49cEp19f6VVauYSO
 fFbNUpAf+2q+tbkDdOVlzKb5BBDH3tvrrxa7I4YY4mQDgPq4IJVdEqYZBuEht4CFtWd+2fBk8cy
 Fox+UnWbJM/3aiSPUBkATjD73IJ1zfeHVpI5OPLS8eq1gc1A+15Yamci7Rx06Oc89Nu/9ZarAXJ
 CGrd/VBzGcP/tkN6TkexfWLarMix0YgIyc6y1qgy1yFpHNJXPFwN0dUFXaPKi8Pqyu+0OQAgYIq
 tR/Y57xW/P57vSECHo+fqKE8/dsq28LTOXQahFlNFzyJjUj/gJN8vWBqLf26SlsTNlMn2Xccdv6
 MEZtUG5R5xyt3m4lUMR550QPfI+WIz8YV1Fr7KE6BFxMVEs4tOr+m1KkwsxUhXLxN0XU/W3LZsl
 BVzjjbjAixvuWtvoPJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-filio.h with file I/O control ioctl definitions including
> FIONREAD, FIONBIO, FIOASYNC, and FIOSETOWN for file descriptor control.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-filio.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

