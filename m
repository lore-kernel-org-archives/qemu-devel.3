Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24DAC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7VA-0001tg-Mx; Tue, 21 Jul 2026 06:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7V9-0001t8-4X
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:15:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7V7-000814-FK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:15:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L8AFcR043308
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LShOPv4BeyEL5Axh7W9mU65AE56rqdRHg0idrIiWpIU=; b=T3EK3ah9c6cMK1G1
 GTmeb0TG5FG9tSW9x9h9Lm77C2pi90OY1pvQMc90uLa0bLTN2Dx6mRu9ZQpA/xtz
 HYWSVD7y9qNHPMeXCDwqcTxoGx0a5xKb2pJl3X4GR254P5GysJdhnJesuxTR1XtH
 e7Z6801GkmrpPkjaiI91AvH01xUXcgWP/HKhHKdYzfHnrU/7gqoV10tNpr1J9B1n
 CyaWt9yikx+3aAkVSeiUTDHtOxCACGyIy2+VeWeSq7UwbeaIe0m2APp3R/kWv92X
 lGvzMolT8OpPX/veN5b5XEU++M0wBNjDMvJS8+5Q73SfrZToFxkBqGzBELTUPRFU
 0poyBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as21er-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:15:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so196196461cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784628899; x=1785233699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LShOPv4BeyEL5Axh7W9mU65AE56rqdRHg0idrIiWpIU=;
 b=kZnPhQrUMCwqOgKdsYr7tVeMTa01l5mtpddHOaSGFtp46n1DSKajDODWH4vkYGv+Jy
 L+TN5aYGErnYsRmXPYB/ipQtFicg6YkLlVtOkxrNwhWc0Hg/eOKclInxUttYUFPKiXHc
 uAXn6hHfK05rNj8NnonZ+icklR54jmJe2inyttF4TOqJFhJeBEV2n8ITroKTCaEgVX28
 3Du1BmNGHCmMWub+glIyLqlzty31kXreY8Ofd4jynLeDRkxeA6bFB7scDOm8fcuKKdr0
 gCxRS426UAgnoH4u7d0BusRLWzawcIDGg52nZAdDd8tphZ/YM6kN+DVAyUD+X5wSdxiw
 5DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628899; x=1785233699;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LShOPv4BeyEL5Axh7W9mU65AE56rqdRHg0idrIiWpIU=;
 b=NJfqthoUX/oXNRBc0rvNskjbkT5wYfpDiC9YHr0AjrPkCsDe33Y484wyBUPtLufKoG
 BI74dOZFCJOmZIqR/4bqSEiqpPJNtvhKrB5chPk3bc8zT1XjaU8MA0pKdCnJHEW97WLx
 incelz3xH5eLX1U8Zt+VK1QYrjY6ykyoaMovnoxhoW6EP8ZoKgNKlxi1PDcouft2BJhp
 3Jk5Ij3dJwGDU9ne93eeuf3MymsHOzUqPSUbyIUzdV0VGQ9SQdt6xKpCjp5/0r6g0yMr
 Gi8toCGnZRTEhHxznNm1FRTaaU+xhLV37rtKWV3Fw/qxpD0B2ynuF8mfqABv7DHFmg5O
 fAQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+JyxoJrqOJuAtOih7lIKOLHmctz4SexQUBz77iq7IzK7kafXQATYud0qVjKyPEtzdGzOS/P3xR9e1@nongnu.org
X-Gm-Message-State: AOJu0Yzk2a5ZOB42kC2RtOlHyHy0du0mPk1hajf9vqfBp+zax6E53mLJ
 15u2qFMotVW0o5AoPSg2Yrg76zgXz/8D5D/CcbRSqBCiCg5Yb4mtlLKESXY8eJ73Du7tu9x1wXv
 PUVF1nMvkF9opZFB8AzrjWEDvYF4+1aJqipXuZtQcd1ACAyGyqIW7IrPElvx9CQ16VQ==
X-Gm-Gg: AfdE7cmHuHVvOUAuewtf/bAestIu33yb44LLz+m4W/oTrZqz2TPaXB2xl3WDunaPcOd
 vCKK8rOCv0HHTAeGgz8lNZXPGGZwl+2/d2SqEpijXq551JyCJMjKV+dEEw5iNDRK0BM8YxIyXW4
 Jk2O5Wa/1DfYFTNQjLKXHvWN3XtW6wOkDymugHHHhgSLdhRPgKEMTq+dZkz747D3GMJ+MjT9Lwm
 Y4TosDbWFPP7S0GqfgZFH/lWNQlwieTSnjU0JDtyVghGF/ftnFQ6zUxix28Sul8Mmt6EhzktXUb
 fRf35OjgPUiOqBP9pCNxftHIZ0A8hXXkzL1V0+B8p0R5+/pjbvMF2D2X2tjYxASlN8bZHx39diQ
 MJ7+Ii4exJ2JFh+VD3hu9nmxXL/h+0uIxvTc1dT5xbgxaQ83wAlo=
X-Received: by 2002:a05:622a:1b8d:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-5213bb21216mr168864361cf.15.1784628899125; 
 Tue, 21 Jul 2026 03:14:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1b8d:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-5213bb21216mr168864111cf.15.1784628898675; 
 Tue, 21 Jul 2026 03:14:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653d38dbsm53306255e9.15.2026.07.21.03.14.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 03:14:57 -0700 (PDT)
Message-ID: <449e9086-ef22-4e4b-bcfc-702236e0e3fe@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX93ZZwqJifRvq
 lvladgd4j/mhGudNjzc3MPysasuyoFXXTVpzVN64L4gKCtHKmClOVGAEaTVp/D4Xj4VkNfdnanC
 WhIDCUq9b/1RYrgLJ2jL68M49ulPy7vjD3GRQBtlYEKUT1hG8ew4S+gXy5RqLXsh6ivlxwXqEEz
 +2zTO1e6qQcBIY/1WCdsQvYlFv+HqhBdLeZow4KZWeigFxJn4xVeLvZL1V8XhCiTJsoYfcg8TIP
 BG3a2IKIXpZEF9NWGbfoAQPpMFxvH3zMEZziuhydNVBNulrOzWG0vDtyqakWSnHliefXVxVQJys
 ePt9eVU/DnFyadpe2+E2iw2SdYkcVUzXqHPISTkHyEP77rvfvyS76hg/NllgLAE/DNeXEiLd6AE
 ThgQn9zi+D9a8LHE54Uic17NxcBsF/0aRFqcJCtz69uQPicgBMGWLGDX23P1aE9BosDUwBfsAn4
 3K+8WKhArmWkWfzlHjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX0LiEVmzCS7mJ
 PA01n4CM662V2CxVx1PbB2GryrGnuEfWFpa7PPIyorC7XPwDkWXoQpIstl/YOq/WSCU/t2jQdig
 PSpLMRH50RZ40kGwjGFp07b+6L0hcRI=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f46a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=2wDRPQjDpsjqHasrlXEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: vhnFIZWQwdapEmO6i44ixzZZVOvuNmsq
X-Proofpoint-ORIG-GUID: vhnFIZWQwdapEmO6i44ixzZZVOvuNmsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/7/26 09:27, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The qxl_phys2virt() call for guest_monitors_config only validates
> sizeof(QXLMonitorsConfig), which covers the fixed header (count and
> max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
> buffer size to qxl_phys2virt()"), but not the flexible array member
> heads[]. When count == 1, heads[0] is accessed without its memory being
> validated, allowing a guest to cause an out-of-bounds read.
> 
> Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
> the first head entry is validated within the guest memory slot, preventing
> guest-visible memory reading.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
> Reported-by: Tristan @TristanInSec
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks.

