Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A85CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXemF-00047d-S6; Thu, 11 Jun 2026 08:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXemD-000472-Mw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:44:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXemC-0000Qh-45
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:44:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCT0qh496557
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4bc4dNNWV7PSHolIkjyQRCbQgU9kET4IqKaqlNUEnBo=; b=U23Hpfnih2KqwFrB
 HltJvTPJqkz+JbqJ3XDBZEesNL9+8oYnMPrSSpfmvSsgg2xyMXhWh/pwWaReT39U
 imIrlL5jdaRHUUDu00RhGgqdMrf1353OqO9rgIlgB4QPMemlJe7NU76EyIXHzJDq
 xfOZQG6ve4NTQSPQKp6VfC+rCeS8YLihPeiC//YKrwR3gjIEIj4RN7mpYSdhJl8S
 qJI56JyAue2Ij2Xg7BB2aG1bNnTTXOS4/oFU8mD2f62kLufWrouUI1jlZZ0nm111
 +SMqYRT2lW24QISIClJhZbOebfz51BJNw+44C1UqJPeOeCzT9jiJBwK0rlRAajT8
 jmWiNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ubdv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:44:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178fc89b2aso29665371cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181890; x=1781786690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4bc4dNNWV7PSHolIkjyQRCbQgU9kET4IqKaqlNUEnBo=;
 b=Y0oXG4N+/GKB+dItOLACjps7mm4GlSWCwztuM0iSUC0uJMGseubP1nKHeB4O294NmV
 HcahgLXZdHcMiuBVbUf/s2poRVk4hNw0IAS4kzj01tfpwgPB1ojWOox5keeSDt0U7kY8
 H8Hh/YtuygFfPR/KibykIICMgRt4lEOfLsxHRkzh/pvMSSaDJniFppukc2ALN9+39A4e
 X1vBtJ7AHySZ4lQrRrkb++Lcns3dv5xa7+0XviQZnRYptr3XC0dL+Q8m5ImepSFLyzMW
 2N8NPItmyd7hHgHpm5kaTLDTxOzkaelKMAdRANIGp3//KFOF8+d0Hs/y8UjkbrxqVSiu
 y4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181890; x=1781786690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4bc4dNNWV7PSHolIkjyQRCbQgU9kET4IqKaqlNUEnBo=;
 b=OPrezL9o7Jc68yoTHPZFNVKMaD4If/9ljI79D6196CWdiYSBsxYn2GCtlOMrObaUUL
 PDSw6iiOdps8pLlSJDSufjWTLnzGQdJmzS1qfjor6ueK+yXO/I+AamUGIeD7XDLLtg0Q
 57Tv0TrPpGm333/KTFQZsG3Nnq/mYVU0+1zQyunK/HxBQX5HjJARcT+DvjnEl9MDe4Ju
 MAcU/W3DwaI6pRwbszFDp8KdwyfAla7G+5KutwEeUEuLgk98LsZdmw5wCQJFTruj1TKd
 6vGPRnai2MDZq9ekwFvV59yUdKXfp4L5O9cqw90lRy/VlwxfQ2toUCqAeO7LFYZGMhCK
 iWtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Nr1bruKrYXksMl9FYGLNsvI2OqRkds73M7aHr0y4WoF5KsXBB3BKu2uFOMSwhG6I4BZdZQkDiDVju@nongnu.org
X-Gm-Message-State: AOJu0YwzwTAL+VbcLo/MyZzyIi8MRsja4JWZ3ZeSCeS2qZHO4MgpomI1
 KuDv6HXn5yuJfWPppfxr9jQxLaG0+swSSQYjpwdppUMab2YnJSoq/+iI1SUqwyMKUQNK8wxPJn7
 zjiaWtIROMfn4jONgV+nXiDJWUbrW2zc0jcfqjHzrfBNHrkBR31zWJaKbMg==
X-Gm-Gg: Acq92OHiG+T1GzV+E0GMChZPV8rfR+IXivXVhkQlk0IiOlJd2sLjb63aW3YBcgvluQX
 QILuDTUJtdFldJQwuE5hxjoBA9jkdumyi+xS3ySYof9Pe4G8S0trRjTPQeIq9wqU4ZxhPf+wBjS
 5KtO7GxkROzqha854Vw6Uwq5iibz4/AnhC26oNgFeyI++VVWj+hg3VDi6ZnxslnhURum0OQ/PXK
 0P8vtwA99Nwoeu4gIIjRk4W2srAYRx3ezto590iT/QGWgWxZ5SU0eSej/bT7doNaAOWZwI40D9F
 05a7yiGPUCL32aGv7+SbTiGwU5mmeZzZJNaVv01pbRrjMWXTmrdM4sSWFejmpeUrVrH0BF+1BKF
 r01gOdzWa3fnosYXeo9BMVWaY+u7b4XXS9T639ac9eyqexqiL3l0Z3ldBhyqVgoTVGe1sV8ELmV
 UvbSMQ5D4=
X-Received: by 2002:a05:622a:1786:b0:516:d66e:7b1f with SMTP id
 d75a77b69052e-517ee2336eamr40605391cf.31.1781181889772; 
 Thu, 11 Jun 2026 05:44:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1786:b0:516:d66e:7b1f with SMTP id
 d75a77b69052e-517ee2336eamr40604971cf.31.1781181889395; 
 Thu, 11 Jun 2026 05:44:49 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e5153feesm50541155e9.0.2026.06.11.05.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:44:48 -0700 (PDT)
Message-ID: <5fe6cc68-4808-447b-aef3-366a0e830434@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] target/riscv/cpu: add CPU unrealize callback
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
 <20260611123412.2135600-2-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611123412.2135600-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfXwb6WR/gvXfNH
 KVzw3ISK3aGvIn5RwiKkj0b3m5LfTNQl3G4QdoBQCm3JWoZwg4eeXU0CqnSz9xjCJ6w9W/Ukxi6
 oiBgemUzn+OO3nUL7xKbgdzSn2yWry4=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2aadc2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1RuTZz-hwFsd0XIn-eAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfX3hDo40hGv3dA
 7/I49Mb9CFBcrLKzx1/6vpooio8rWbHMFPtNhCJ3ErWDNPXVsPq08SkhD/FTqSaaI+kYkDIN/C8
 Wo1wjrs1pfNYAB6muTtvjHHyUP2doJr5FSaIy4MlXemPn/nar4H1wppXf0f1SrZ6laGSurOkbnR
 l1Kxwl3nksFNWEwn1XL4nGgHgblwjduXBNB3hJCz5hpcNnOTYMSI9EjQULDbbNP3QLr0dteDiHn
 QrdhJ0rJVGuuKTQtvygytZNXz0wDDUN+khH0n23R6zoSpC8O231GyiJS+G5vx/GI3WpTs3QxEEE
 3aRrFcQWaUmkHgQDkaKoPRlcfQBKtJGHCXNOsfGibnI4OLj5KNP24yEZlYIZITZyDwDmSDw5/F/
 tUzClGof6rAWN+E/m4QgRRZ/kfNCo5mawZZC8KNcmOYSFNAEfXmiaVNRMtGKMfy/0NRoD1ddWhQ
 l2b2aTzA/ReDXNtZJFg==
X-Proofpoint-GUID: 65C0phgqY_ZXM5IER3k38p-WtR27_boo
X-Proofpoint-ORIG-GUID: 65C0phgqY_ZXM5IER3k38p-WtR27_boo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110128
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

On 11/6/26 14:34, Daniel Henrique Barboza wrote:
> Next patch is going to dynamically allocate debug trigger arrays during
> realize() time.  We need a way of freeing them during unrealize(), which
> doesn't exist at this moment.
> 
> There's a lot going on in that patch already so we're adding the
> callback infrastructure beforehand.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/cpu.c | 9 +++++++++
>   target/riscv/cpu.h | 2 ++
>   2 files changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

