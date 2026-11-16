Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF3606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWYmThYk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h2IwAHbJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT2Zz-00013V-IE; Mon, 16 Nov 2026 14:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT2Zv-000138-VX
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:41:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT2Zu-0002fY-1Z
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:41:23 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfKsu612126
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 19:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b2GfXHlesJhZE/ok3Zgsb1xgRDknc+2SpLjT3f4kbS4=; b=YWYmThYkkGCSsn5D
 P3uheJov71CrGYrW9kq+IBGhdZ0YuRbJFd71QpbnLGHV1guJ3LRgcwOOocsGtH21
 TX7/xP5E9U0/HWtq2kqoLIY1S/CB6i32OZhQutQgpWL5fmLQMfhdTZZQjNxykvqE
 JhGUj1vdbYFwsAmNjXgUudqr0xMTZNR8X95d+jRW7XL1iYXuv8u9OajpLC9PxsXV
 HIEmnrTWc82eO6FzPrJm1h3CLsGU2b8BHK+NMA7gxq5AENibAxeuJjP+IlhXzOb1
 6Q/yegVVUBTQWNNXHMXJ9iifBqVUmZElxzRv6nDKtmpzwrbMkuVFkwLTeekneYks
 IfExtA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gjcbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 19:41:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37628596fc9so10169727eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794858079; x=1795462879; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2GfXHlesJhZE/ok3Zgsb1xgRDknc+2SpLjT3f4kbS4=;
 b=h2IwAHbJ9Ht9U214xkh0CKVEAVxuTq3Zl66D/UaB8XQyVEPuseXvAPDriyI2OICw3S
 V4pYxhp14wigUSMb4HqKZl4Z2t7RUCX/xKrk1bG/6qJbFXY2lwzPJMfK6tZhgBuqxh6q
 gh+gkmzgg/yxt1FxPmV9F4jvHgTCvZCBb2Y+gAH9LQ5WPbxuqtSa6liCfg2eGu1UUqrf
 PrJBR3eQSVdDz+WdBrfbu4ID1NbQj0e02a84hIOKfwhtQjI/HL04Rq9QIQ+N4vXTaKr1
 kqEsjJI1LwQbnqqc0rDbyVh7V1Syr89rPgmx3NSVyb4bQrrSHTOhfQ7EJh2JrYniy7Oc
 fXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794858079; x=1795462879;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2GfXHlesJhZE/ok3Zgsb1xgRDknc+2SpLjT3f4kbS4=;
 b=EWmvy3JSAMnXKxjF79+x4hYeD3KR/rHEXMUT9xOetANKomTOKian0tmVuCAkuT5+Te
 j0YhEeJ3RFn7F0HTfSwg9NrTt9+3a8R0mrFDCM+TPY0fjjn/hdcW6h4df0qGtNueVJup
 YzoeeEaCsfA7kNihudb/UNphiZNdNq1K3G8weqfB9SU7D12HFWvFT1T1THZoI8yCrCkD
 +KN75PBmPcBiRCS75eamaIiLwm5gzuoRdh0xC0FHPW/5uEYrz3r/80oxnLJM31XFcIkF
 ayrEBE3AukmSgg+pPeueV9yEF8x7ixG5bbxa/+zaVqnbJEdfy5t8O/93kfY8Q2WNJ6pz
 w3rg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+mOn/95ZLTcDENQ1SaBE+lG2W6m5YVM1luK5qbc9G9U5sXBqQ8O1ItoapQkWtkKHEV24SCrnLE0zU@nongnu.org
X-Gm-Message-State: APuU4Z9k3JWQ4FtMYqzoKEbzUVBAqww0tya5HXkhmbIJo8wFIuhxt+ed
 zOmcZb+tYZygH9/iK9j4hfa6jvQHye5pbamJMCQzWVf3K8ZxNG9CBYzlJDWwOK4/Elt/Sjxcx2k
 /DQRonTpRR5cE4iheA5RFiWqcG7FXXm8gplsY6vgx6tRGggpdARtlEpazVw==
X-Gm-Gg: AYBFou3G2lPhLWUJiG94Di8Awcq8kdmdochhXoV/jo0+OYLvJmQpJhVSsHyju4qPyvD
 T0j+i6JLU/HsqcVHY1uQpdE7F0mVy3XCNJe1spjIhyfnN2lT36+UKugC211RIEJFACAwd5oNAGd
 1j68nMXM2DuPZEnaLI0ewQug35KdlI+1cGZBCthUjpOg74iD7WQEROpkL17AWMMGr5XnRgk4fqo
 P2wDfUTU4VfK+cJjth8ffY/p4F3H4cJoKfxFZMoUxsB+EMBuXAT2vcDcPPvs9izv5fLt6FT/P5i
 eFDKgz0xgnNrtFJMd4Hr0KaiFDloK3dzB/VQKo4KFPkm8j8R1HkwdLdmk/3Z+c4d5KQmn9LEfSb
 1/bArVyD4KSi7XzlhMnPzq3xu9yY7PG46rQso8ad1OR2+j/WFGY4eRkLSgR6ILFcq3TVHRqWH2S
 H7mhFfLo/u14WJFsQnjvxqONgJLV44eSL4orDq0h7hsTo=
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr16697107eec.13.1794858079171; 
 Mon, 16 Nov 2026 11:41:19 -0800 (PST)
X-Received: by 2002:a05:7300:3b04:b0:369:fb01:2eb7 with SMTP id
 5a478bee46e88-37965daabf3mr16697075eec.13.1794858078591; 
 Mon, 16 Nov 2026 11:41:18 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm39732627eec.23.2026.11.16.11.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 11:41:18 -0800 (PST)
Message-ID: <57a50190-2ca5-4414-bb0b-d12e246bf10a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 11:41:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/hexagon: add MTTCG regression coverage
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261116183855.817574-1-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116183855.817574-1-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3OCBTYWx0ZWRfX1xJvQzClTdJ5
 ADYIYuZelB/8CQ5f2/QR3QRetnsi0wGOwUhLJ+rtGdBmzreVfUK94jqIt/bZlhmbrje7yeEQTLN
 +ofepcSQT91unmTJh76JAy16cLUS4Bt7+gfXrhpHk0iRx83qChi0kMObml0j62mBpOBWKU3DkdT
 pbNaV/aXniQFGXN7ia3mlG1AFNu6sd9PDtMTlkRjhRfvnqsvEADFmSg95+WOqqgtY2K45faDXXs
 mQplK8n3FqkZDCwg1kCESAS5JKyDhj7rclJoshWVPN190yAValWoGsmOJND3ipnK31VLSH3WAok
 jT/sYbNCqyN9SDMxdgcoxzauwM84nCf0DlB/oxJuuodDD/NR+yto8RxhExTdsdtfgqHXJ8oXQcv
 9PiV/4nWfljd/j3Y1ieKFR0hU86hQwFg+pv9C0/1oAlraLZ4W9FIvSH/lNBJJnpdHyq20vB8ctj
 4VlB6GHtDbXAfmem3XQ==
X-Proofpoint-GUID: EGlx7ZBou8UfOaNxSA7-Lfc6cj09qpsh
X-Proofpoint-ORIG-GUID: EGlx7ZBou8UfOaNxSA7-Lfc6cj09qpsh
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb5c60 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-vkG8orWN-PcWsPKrxQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3OCBTYWx0ZWRfX8QeXhN9hv89f
 dvnH3iZo0FszpwFAxrdeHYx7iuAveJReB5tQzmarUbBsB11XFF77RcfaMH+3IDHYJ0rLmTWzyKS
 GwNr0+EltMnScv4P/b3rJ99fIHL/I0c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160078
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

On 11/16/2026 10:38 AM, Marco Liebel wrote:
> Use the v0.3.4 standalone test package to cover guest fault state,
> virtual RTE stack state, and concurrent TLB and IMASK updates.
> Run guest state in both TCG modes and force MTTCG for the concurrent
> tests so they exercise cross-thread updates.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_systests.py | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

