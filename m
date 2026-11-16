Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BF606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ss2XKvhX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TdJ2zPDc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Tf-0003RB-1J; Mon, 16 Nov 2026 16:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4TX-0003Qu-CU
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:42:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4TS-0004U8-EY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:42:52 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfD6o2589434
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9Ne10hSZ1bysuJif610NkBTUVlf56XK6UrywWaK1hM=; b=Ss2XKvhXide/ujOP
 UPPAk8iyFJIhdAHWCAaxGyaNUy76EQLt5uYgoCLJuBZju6X3CTpibjtiBsONwM2K
 9GLqvcGV4/TfFrEf+aEWSD+eXvx4IRXDos1HBuQsA7xEXhcDOm5lEmWVCA9WA1Em
 JV10Ahgwq/a4/Rx/wJ2aWAUprYa61st6Jxg/DV2sdDI+InBd5xrc8IwuXDZ4jDch
 qM3wkCy4XN3anar4U4lh00l42sRbcCCi36fgAZ/GwIYIIwjxFZXioFu/rZzzHrP1
 sGDR10bo6EarPpIs/6DMvSpJQl7wx/0YL8PUIsXqOrQhrUFrpXj6kqjR4JvoyaLC
 zvENZg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2jxwm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:42:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5655022eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865357; x=1795470157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9Ne10hSZ1bysuJif610NkBTUVlf56XK6UrywWaK1hM=;
 b=TdJ2zPDckTwcY5b4+NXo2hh/wHfxuInq4kgxezbxgjCz2Bap+Y8CAOv6Xsm0fSt/Ng
 y5PayCqtMbOv7BIOM0LoOQqbo2dIb2UKh9BNeN7H6uK9ru+Doc3fmyLB5I8ID1LiRiA3
 7e2CrA611KOReXX5r8UICeQv8pfErJXgr3dgrWyU7KLB783c/8U2UABEOKMFZCDdCP83
 cLcE1VrR4SmlICwZ+QQDz+/8SeAWcwp31WOisHeq/33jInTfPZp7SR3K936I1u4Crh5z
 z7d7dbpAmTQ4kYMNZTMu9LaMTI5bQZ1BxMZcfc+kpa2PyKPzKAVTjOmQCtoPeJcDWtCB
 DD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865357; x=1795470157;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9Ne10hSZ1bysuJif610NkBTUVlf56XK6UrywWaK1hM=;
 b=0VvSvXlCkJYpLjBGfYf0KW5GgNpuV6HAYh4whgjI0YgxEFBbLQvhea0mPyb8eiZU+I
 geEzu3X6Dhzo+HvDB6aWyCcFYSt9pLMAYjTyq1VP9QRzPqrxb/MlykSYueS9eraAxUKW
 0g5cF69EfalJQaT/jczKnXDRfsPSlxaRI1kd8VhQlWxyohtB5OHMzVHdAu7/+IQxdFzM
 1fSGtqO+RAzuKTPqAaaDmguVowy3P4bqQzjyhkinZ/79FccqLkp+Xjqb8J0oaO7K4HTj
 1G0Gvq9OWcREte2SMlzFmL/DQ6fdcIhupgTD1SrDHkp+MXjTqhw34GFeyD+7PcHPLf/f
 PNfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEUlnuyWOHYauvw9JaKN1IhYrasEE+LA0697okosLjD7zoXR02ZdOBtIeAAAnwIUT/pSGIvgYft+Enl@nongnu.org
X-Gm-Message-State: APuU4Z8urhyJ4Fz80ASqOms1h4y+AwhErhn57JkpXWBjIm3Ys4L1jXjg
 BnRRR+6jnk5tsSKz9455DLfhbOlfQLnFgmZ3sOwXZBU5zllXTJFG5O+NDInheZofy/inHGZRGC6
 xbzo2fIGY+/A+SndDI0nb/Qr2SSXDzTYdyboR34wt+GXdd0HIXPSpum/dnA==
X-Gm-Gg: AZFdTZcZLzjS+tsazM4BwP7kmUmAmjnj/dAmC4L3BdsKn6tb8h4vNL/1+CEncN+GoRr
 95bcnLQuOuIqg41+03Iti0l68t8xFOKa8FcdMiElL0RtSh9dQTdDs1tQ5RWYBx7BxPPDQ4SCqvU
 kkTK7+6U0Hmj4nl0L8JJrmBcj+1tP6N8LX+gNk1pedKrCthQMDW7SK4g6DuXQXtCBcbJsZ5BKab
 kZZvDTnxve3GlMxh/ItPfpFyTFiu2Eha/6AtPUr9zTlSu51IB2qUKg2fyUxAbV38wABBZbQvoA7
 WRk9l+lOzK2p9u3ik4yTRrGzMh/l9jL5WDvfhPUNl9EWf3vDWNejzjqtLd5BTnQP+/VwGkfG1S3
 EGOK5Se2mgwBJJqmpvYs2ZGHDUlbvQ0QD9WIYpV8JUQnyqeiHkmUGQ9IsBEdQbtXmqV5qpI1W3O
 NM2rpQJKOr8Whi/xagra2UnFqv8tlL/fFcNQGVKf86MsY=
X-Received: by 2002:a05:7300:fd0f:b0:36c:da71:37e0 with SMTP id
 5a478bee46e88-37963564bc7mr15922548eec.2.1794865356814; 
 Mon, 16 Nov 2026 13:42:36 -0800 (PST)
X-Received: by 2002:a05:7300:fd0f:b0:36c:da71:37e0 with SMTP id
 5a478bee46e88-37963564bc7mr15922521eec.2.1794865356259; 
 Mon, 16 Nov 2026 13:42:36 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3797f98b9b2sm34815026eec.6.2026.11.16.13.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:42:35 -0800 (PST)
Message-ID: <ccd0d13c-fe75-4b78-8b40-af3f90d05204@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:42:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/48] hw/arm: declare arm machine targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-37-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-37-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb78d1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=cMJvq2R7zkPP4twINeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXwsfjadib2REQ
 JphARtl87aKCjhvj7QDKeKkUKUnAtPB3fXVyy+UJowxcMFc89wqUFpxaR4CcRx8ezm/3wnU41+U
 QT2sXviVdllxnzTabKbum8Wzlsv+4p4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX2+m6di6hkVat
 a4ZKkxqN/UkSj+EtQTulXe7+avBmKfPrWeTN3NGWIWFJJh79hGLIAbYXGKSWTOszXW01bdqcaZm
 20eBB2zQmqyEW8qnoFEbDPaA5nnetl27AgQNoDBpoqXWHi0CTJBff1etdOxdEpayfaXAH0iQJLu
 x0yxwCU2lgPr8c9a4hFuil9nK9aMLsoNMVuX/Xbq3ixcpb3Gwxt7NQJ4NbOIFrnq4JKh0h40Wt6
 2nOCSQU+oc1DOJyZNw8oxojGe87Eubw/nj0PKEyMm3y1fu/sHKoSyUveYCaNOfTzZlxMWKMJeDz
 bMdewduo4UL1nk0phlI/6TUI6m+1QGIZtEfflj6T/xUinbtUc26BK9RqYwwe0Yq2lzds9Mq2ViV
 jkvrY9Rx4CJNUBnEbVYilLn01eMpqPO72V80S/vNss0I1dm5LybJRW+aBQYKR8CF1jp/aJPStAH
 mG9lNUDtPWPniRyPFxg==
X-Proofpoint-GUID: -VJAiiTkvDdUpRSxCczFwX-pOV9DCYh8
X-Proofpoint-ORIG-GUID: -VJAiiTkvDdUpRSxCczFwX-pOV9DCYh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This prevents creation of arm machines unless the current selected
> target is arm and enables removal of the 'is_available' callback.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/aspeed_ast27x0-fc.c  | 5 ++++-
>  hw/arm/aspeed_ast27x0_evb.c | 7 +++++--
>  hw/arm/raspi.c              | 9 ++++++---
>  hw/arm/raspi4b.c            | 6 ++++--
>  hw/arm/virt.c               | 6 ++++--
>  5 files changed, 23 insertions(+), 10 deletions(-)
> 

Could we have a variadic function to set target instead?

This way we would only see
targets = qemu_arch(SYS_EMU_TARGET_A, SYS_EMU_TARGET_B), and not expose
QEMU_ARCH_BIT at all.

Regards,
Pierrick

