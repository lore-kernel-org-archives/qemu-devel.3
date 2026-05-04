Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C27CCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwg5-0000Ne-Sj; Mon, 04 May 2026 13:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwfT-0000DI-GJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:01:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wJwfQ-00079k-AW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:01:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644E2gws1186704
 for <qemu-devel@nongnu.org>; Mon, 4 May 2026 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UhLShSDcKBBhFkIrP4mymoTnKTrya04D48MDyeCCX1k=; b=K2Js1rqUQV7U59lI
 HJ1YiefnLPIJ5V6URzVa8l/E+PiMFNhLH3HJftxms9BQ2xRt2udRNjDqO5wUJOrQ
 BGqkXFWmFJuSyB9GdKMkL8xsxtx/bVBMGeZbKZhrShIHqBrmh7WZIVYPL8pRBAGC
 +ZV4qLbWH7nQx2IJKJzA0DJo7WT9vcvYjkwKbQ+xm78ZRzLh4pCxZKlwfY5QJnft
 SKTuecRDnpJ6KpvTvLP4V3QxyZNNVvUIl8NiQQvuZs0DVXIUyzRftMim4ua0f20I
 Oxf8ZYUIs80DyAVPMr1kvxeedb0EdhsT9XSIRc+PsIwmn6oukSBmqDUKnnS8LpNM
 OePfIg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvg8nts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 17:01:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee34588671so3898206eec.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777914064; x=1778518864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UhLShSDcKBBhFkIrP4mymoTnKTrya04D48MDyeCCX1k=;
 b=VXHT7mqysuI+nDC5MUii4COYs/FFzFP7PQJt9GByxjanHXKkN2NyfYYejFMTWXWTTq
 A/yJUC/q+X5wyvlIWE8ni2GQu547mgYX0wvGkWdXtMhnmlXv1K6M1GnWVvkYnsvU2qMX
 bXdzS+sPVElQVoHY+eHns6u+xqwCTOJdVl0CzXTALmWDWHFl/LGuWhMLoxA6xVXswFzh
 cEM/urZPrIreOFCB5GwtJClO9m68+xZlwzP9PQXjI6LwHOCuQzccpx1wofNtp84ew4rP
 Hhb0VScnM6Lb+UTm/UFzHe798WH7Ty8Thd3s62JGqZTyLDK+sd/NSDIieYV6de1tz6pb
 QKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777914064; x=1778518864;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhLShSDcKBBhFkIrP4mymoTnKTrya04D48MDyeCCX1k=;
 b=rPjfwNAC6924HDPQRjmGl4oIBirP3rzPJas/vB7vO8cjq4OOfW12RWk4d5pSfI6nKf
 eelhg7VhQvtQ8+0ErlmZPMgj2SOXClVJogw824nH12g43e7p60A0EWF2DwIyK7hT33Tn
 aoM2/2QmC7AmDQ/j11gr5Aaj/RK2L0VhUawc3697GWp5RCcJ6rsB34Hd1pq1882/i3n9
 k+5MX5bcFui/plAZgjLjIGYFb0hbeb+LmBsFOO10gGAjOEmVL1yGf5EQHwg0e5gbmbu5
 u1sBSQDkCmVYTpXY2F1mAn3NA8MzNUd2zu+Jwnxdb+7ddf9NGmp2vaAfcseU8WR1A033
 I5qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fSuwZneOoKlmFEoo0vsOsWGRPimfQ/3KdAcBm4brp6weRp2vOLI75J+McjlMevmiF7ohkTM+pYI5j@nongnu.org
X-Gm-Message-State: AOJu0Yxof/C2iR5LBPP9mk6KMkK/SAzjIgeH+KAuuzQkdLs3LA2NSwHf
 CEP/HXVlhzFNLd6golUE5GjxTpBnaU61T97UjZhMDa3ogdKyZ2BTp4Sn5UAgy+SawJSgGZVr7Zr
 +kfhrP+vpGJr6fHZM9ZlEg7Mejy1nxVl0IPElPVURJhuVXNJiQOt9j34Nu+yhUBbQew==
X-Gm-Gg: AeBDietB5qll9nswFrjG+4X0o8v+Dn8N+8wArc3FqnyexmoGyd7qHdgVYpOse/NpXn+
 5Vo+IL9RInlFarXNnwhnoBFaieqotSMGlmkD5VdMc03kLYefR7aH4SRXF33XvhXyfzL2GDfrS5N
 2ulQz/4d08MG7Ls3AEzSOHQK7xF3IRxfkn166Zg6h0PUAn4bImZ0T0Y2LEsvsAFwbjRo7fk7eAV
 wybebjowd8MmM59eRRwFqJ4TT6HlG+1f0MSydPCOSlR2lDwP1NmKsSS2Aq7buACbkRGiSZXGrT0
 lubJ0OMPMfExJk9TkMEtmN6y1GGFcR/7hFzjg8HCBzKdkO7KD9NYWGfzRD9XEbCVwtP6i20OohU
 TpixkliDBdeVj+o1VR3FEZPaphAtuQfpvDNLvbBRKlXG0MZAb861CtkX8bpGMjCfFbHLJYeDvU7
 3G5PCdHdLLDQA6N1DwWLXvbtY7
X-Received: by 2002:a05:7300:f194:b0:2dd:144b:6c2 with SMTP id
 5a478bee46e88-2efba28b289mr4376994eec.27.1777914063728; 
 Mon, 04 May 2026 10:01:03 -0700 (PDT)
X-Received: by 2002:a05:7300:f194:b0:2dd:144b:6c2 with SMTP id
 5a478bee46e88-2efba28b289mr4376937eec.27.1777914062617; 
 Mon, 04 May 2026 10:01:02 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df82a141asm18790764c88.8.2026.05.04.10.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 10:01:02 -0700 (PDT)
Message-ID: <17b0366b-dff6-43df-9300-8043c18d468e@oss.qualcomm.com>
Date: Mon, 4 May 2026 10:01:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] bsd-user: Add call to do_bsd_ioctl and add
 bsd-ioctl.c to the build
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
 <20260502-ioctl-v3-19-a05d4cb1bdff@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260502-ioctl-v3-19-a05d4cb1bdff@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f8d0d1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=f2u1JbsltYlGJZ-p:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=FcYDxu9WqEn1UnlWz24A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: UlOKNOsP6T0_07yhNsF1nXHKC0dcSFKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NSBTYWx0ZWRfXyag+Z2g2yqrd
 VS25pzY8Ku7khjZvyIjpaxPJK45MxDjPnTv4c+NjQj35yB1aLF7whPfjAiVtQ0dc5WR3z5Z7S4Y
 FbRZ5d6+9wJz3CdpriZRoazd4DkLr3xwrZy0UK1Daj9eeMIXLytTGckjN4fq5Xa1oVGnYggBPyD
 lJY/vxUAgSFCITrClApMa8mIrQTEm/7rkK7Cc8OAZHnR4vTYa7J6JrVxJr4vpNWmnkmdQR9/tlX
 ewctoofMYGvAJSAetESkZo2igl3vtqDmaKRE6XTvaSWsU3zgOHDak0i4nO/GY/ylGdf3j3rdQDY
 qmz0LZo8remHGtMG+cbFsdvSvijmQ7UiDK4+Xzs+ysywvaKu4cK8gnb1hpPF9Tdun/f1jXGJ9lG
 aBAccxd1RG4Nm3O+rEBU73+E+CXpFg==
X-Proofpoint-GUID: UlOKNOsP6T0_07yhNsF1nXHKC0dcSFKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2605040155
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

On 5/2/2026 10:09 AM, Warner Losh wrote:
> Finally, connect do_bsd_ioctl to the build. Call bsd_ioctl_init() from
> syscall_init()
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-syscall.c | 9 +++++++++
>  bsd-user/meson.build          | 1 +
>  2 files changed, 10 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

