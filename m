Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9169AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7zN-00039L-BF; Thu, 20 Aug 2026 14:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7zL-00037q-US
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:59:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7zK-0003Pg-Eq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:59:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIIsC83705812
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OERPTC2dYFwk/j2DORf85Slz7VwpfPv0q4nYv3mnuAI=; b=XVe6jTnQQzOrA8ag
 UmztxWTQNjJ0MjBi5PD9ypT45/LRxrx7fhs2noGbsp/amzqRaYEHqPAMrz6NvfsV
 wWgB5M5G9LC2srRLp/aZILPYgfZutxylZNI7M60gP/1G5+pvZuV89EJ8Q6DovCe3
 yw9gZr0fpTD/GXYwoX7EOYiecVOfNiguh7STowEyLSjqNTmO08h84EbTuzykwQS3
 CPGXou1bczcstOZA9DrdmBylxdpX3n4AacIep0bt7wDeaV4BgDdxVpyaDbKd8FRU
 ka8/giMS6QsWBP/5Mf6IUj+GIgAs132/o5wjH8JN7UtY2SUfoCsr0kcbu34zc4+a
 op2tCw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7u7tj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:59:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc12e8e22b7so440727a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252380; x=1787857180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OERPTC2dYFwk/j2DORf85Slz7VwpfPv0q4nYv3mnuAI=;
 b=C+hnHDs4wwlJSAe5hpJ7LQLYW2rFWKdwxcQANsDZ955WUQ/yVK2GzeALa6nHxn7Qo5
 WG2VXYNZHewrW2Fy1Ulgf4tAzHODF1s7UaDinnNtsPfi0QvXaRxsceSSaEi1zpWwqyMk
 e/hgQMll01yd7psRm7WfU4IkwIuuzh1iAe+XmK3ZqJRSdv/txvroaHSIcqKatLAMvnd9
 T4AhWjfso04n9gFfacDoN9IJPbYOLZQtazokIXTYQqYoldlaoz8PEA6OXYbifF3XpQB4
 BWbX9JSfR4zXWh5+gcPDPGP7PtET/jDGDp9J2LBQNoNFh0uDi98oyPUfCjhTFO73YvQW
 tduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252380; x=1787857180;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OERPTC2dYFwk/j2DORf85Slz7VwpfPv0q4nYv3mnuAI=;
 b=nbbFUf4CUbIT823DAStIqlAtSISE1JyD1ntH8PAfI/SrEsOtROPAOU+c5/TNyrKfqa
 B6Dsi2HaB8DsuzgKXUB2BEn7U61FpqSOvgW0fDbRzT7Kh5wThcG5RKewRHB9Ahn5fofg
 ka6a5xX1K1zUUEkOaeBL0vSAtMNYDPA3oAWQDsun/1VG13br9hysF6Dlp3ZiicsJxpUH
 S+NQNof8T/rCLjyptTTHELJdmEVJY57TaKgooW78iMEuez77IssMt7xqmlN/bSozVDLO
 Ne4vLvwv/aGOsPsATz/HsccaCouWSsxIKfZr3CpkCF+Eg05H+qEE+HZFJTs65RkGh9jh
 A9Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RonMdjiPQJEjnl02ouy9RAAeoxPKtLb16GqWrEnQYtfBq76umW+8snfR2v9kOa3nemh9op3GOxf0SWl@nongnu.org
X-Gm-Message-State: AOJu0YzMREyGsx9ZFDxpa+TkVK0lFRA8wdSyVTvj8/iqF1FKOYq7t/OI
 tKoqpTDvuv28RHdsnUhbFrmU7uSnZeTkn1fiRfMPtKa0p3xrJG3GYOSHJ5/PsFhZLQylH/iaDwm
 mHF+npKXCFhoPJIg4do6PXgxKoMKmYM9J11/i0NmOglIo+09IcbLB2jr3tQ==
X-Gm-Gg: AR+sD11CyKqr1ndixNUJ77b8m5K10KjuAZpW4HgzUmPAzPn4qYtsSEru47/9sIY9eqe
 NB2s+8TQFP9ogHdN2gZHXyflIE3iJwyqg5xbvi7LB0d+YX1FgfEGd/3bFjrEPi3W5MomVuxr2RX
 hw56gz5cbyFxAArYTWeJYfWxhXcePMsXiy0K9rhIanUQnfwH3lLtlLFMgVlN5ztD0wSJPz9+k1u
 qrc8QwaCZA9v9xk2zsKagynq5M2xKreeSJushb7pbcDBD9IJw5uIzBFjKuL8GjURWzrv29ETkby
 PXNEcl6yzyEfM9zzaIxb9txxLSJ3wHLGFeuuEZU9uN+2r2XjtswlB3fyliHBJRWiSuW0Y3+IzLe
 QCiSnchbe+VTZgXqY2GZKReCoGFYGyDViaiw8PuU50Uu0qFcNd0hQO64R5DhED/A2yYRX
X-Received: by 2002:a05:6a20:ac43:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3cd2fd03751mr1293067637.3.1787252380390; 
 Thu, 20 Aug 2026 11:59:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:ac43:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3cd2fd03751mr1293005637.3.1787252379970; 
 Thu, 20 Aug 2026 11:59:39 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c98ba384sm14004964eec.30.2026.08.20.11.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:59:39 -0700 (PDT)
Message-ID: <ea55ff47-f84a-4ef9-87f3-43c2b24fa56b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:59:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] tests/functional/hexagon: update to v0.2.12,
 +test_{interrupts,sys_regs}
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX/QxxR5SevJ1Y
 KuKSjAVVziSzmoMr5plF/wKgcXTbbzKZQ/Q5Eu9svtjhxbRCquy+M5+5b57AAQZ89KKWpY9zekU
 /o2RPh7A7BwKt2K+fNJOMFBO4XS1v1mYAJxm1Y0yrt7juO9ZqIOX7D7P/tKh2nh8F0+0/jzBsri
 oERAt67HPlwXibvwTUSmJsOLkk1Zisu6yU99SUO16L6g3x6wryFvUVy/5rtZCPipxlDc1b6YEiJ
 NhZNgrlM7fA1ha3JWynHBZ1C0PbnYc2rKkSEGXNZsWFyIadK9UMvSvRw4N2WWJUlHhsSH1QAtiK
 QK+0qEI/L0QvRNPKo8cjaTrRUq7qcPYKd0Hia2eaa8JrQ61YskHphVePdJbrNLYegJz16PqB8f0
 MNGhlkOHWJp6soCI4c92IXODSqAwsNaABNCxwy04d9UJqz+KWPxpkFHcCEczgpbQR/kbBO/ogBk
 Bk0brZxORR7225y/9jQ==
X-Proofpoint-ORIG-GUID: kWHnpNz-CcHMRUW66ier1tYUcCIb_FzE
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a874e9c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nWQVZD1EBIOV9-eoRPEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfXy9HBBO5rEgmh
 EDP8IWyZP+3inJjmLZ+orFCJ38bM1QFQWankrAz4EwqayslbOj4dW9s0fCSa8MqlhF/T9xmpRYK
 LmM+wZApRxn/kG/339dTHOaIf1jEFjk=
X-Proofpoint-GUID: kWHnpNz-CcHMRUW66ier1tYUcCIb_FzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200142
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> test_interrupts also now passes in full following the iassign{r,w}
> fix, so enable it alongside the other arch tests.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

