Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1F4C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokOE-0004ll-ED; Tue, 28 Jul 2026 12:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokOD-0004kr-1u
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:10:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokOB-0000pn-9b
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:10:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcq843076171
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Ky0q5rAgaKfNbPrfqSDswf1VZOMbQ6LIFjH4eiu35g=; b=lAGFADVuF4+zGsKc
 7R4LLeyPT9MMoHtXbY/U42bH9jxtRuGU90DWsmAuTwWS5WDKquXjmJxHr7s6KcuB
 odHqoyp53BwfFbEi0tiJWr1DFKje4Gh8C4tUJbetLrj47nTwsv3BwbyCmkCQC9Nv
 X835Y4Kl42fZfeU2IZ0Vn6FdXKPXa1dRBA7jMlp7eSeIq9UdhSQ7ztvkJIuaa+Tm
 gyRhZFJQ7IAVUHrsA/fG1RrxdJluHwsv23qJfgO+WVI0dmOKTD6ooNObQPasnXZx
 vwDD4V/iLCRd0umTnIqD7gEvsfdzezrK9M3xIekmbjHIho/I6IzFSGzRScajzFIH
 YM9ojA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19k88v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:10:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso41977941cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785255041; x=1785859841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Ky0q5rAgaKfNbPrfqSDswf1VZOMbQ6LIFjH4eiu35g=;
 b=KKMdAlFeP7DyOV3XulI3TaXju9kSFhHYri13ps7iMnCwmBIRh+Q/Ic2uwLnZ+tXlZB
 FBmC9jlfUv4tcFJTQeu8dx3Alt05nXJcAqCJAFbjVzd0hq3rHU7S0phjMIRD0NDoskto
 0AXp4v6WzNC2hVxVdieeUyxTY9Zizs43smqVqPeG1ugiA/+F+G6zq8gvAVXrnfpo6wWu
 nyvClH4S4BY84nIDkBFuN3IeIw7cluDhzuJiv4Psq5GrA5adQPSQAH9+KPzDZ2VxGpSP
 oyKLAQS9EmXJeS9o01livSOJRrarFJRpsGvKf58D0g0s1Bbc9dSQaX8ueZQGMbEwAtRz
 y6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255041; x=1785859841;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Ky0q5rAgaKfNbPrfqSDswf1VZOMbQ6LIFjH4eiu35g=;
 b=JiMlsqQmK+TK3IDFCaqLv9t+pnAenIkJJjEhdsVAi7g1thMKuxr19N7tNDxeJYObwv
 ogPoypnYx92XwsAJJ0XeSMW01twES6HeHXqDBC5Ar/kiDbMxh0wxnIgZtw34EKvRiYtX
 pb7ajgDoMKPcSkwimhhYDiZOqFdruZ5ZJcTCnl8LZt9gnzv2jRwM0cRhuzwZcrG7YHTN
 TCrl4kgG7HUaDk8Q7gjQmYaMsevBjFdT46Mh7jwJLpPcWkg2jBhZCMZnJv8kR+wJPqkC
 DCGk9eKm1El82F4eaBDxghpaCzdxQLQcxsmpwcgp3tAI0CstIIIy8Voyy0s/74PCxxfB
 CEJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg8P+p7n/0TkIr2lRbyszzEh1NoQsjIMA8k+VfIapReoe5rH6tFx3b0+ZbvrMYPENkf5Q25kxucasA@nongnu.org
X-Gm-Message-State: AOJu0Yz5KkslUHlSEFERwdlV9wH+25k51Rkbd3xZhdRPCSLonOiTfi42
 8V7Go0praN3ilRevwvow22FtRYFGVWTBRrmGq2gFiTNsu0n9cZAQAEv9UJ4iFI4TlcAs52RyjJc
 xNRGFyb/W95qBpHcXkQitGcXIYYo3/kRWu6DxVs7nxwqLlAgasloI5RzYzJ4k7pVWbg==
X-Gm-Gg: AR+sD11c2o3jBqHdztzgHd40P1V/nG246NoTzlO4GCZyAVvjS35Nzo+Xo1tHAFw42/K
 KmHLhyEbncOaQQ6HsWgjS2dhep1uYmf/Cbkp9ipgDcyik7iUcilzA5XrvHRqRm6LX9pDuqYqDp/
 Nr3oB/y93xnRKzcU8X3FcGaFtZRBZH68Viy2MAcNYvVD+7zyBEd8KBHqnmZCv8zlj7+C1soRiMR
 LvdPOoBxPpmWUcG655ILXwIijuRzNiaqJmMUhurpaeo9bsBwBoDQPScmwLopTcUcQUd8S49gEYn
 IM82YrQnnAb/FQZ/6f81UyfkAp91m/PKSHsV+7nRmRShZqcF8XpGHCMJXFjYIhSXW4oJcTgFMcZ
 4Z2DyfylQU6ujpSSzlKDF35upcteP4P+cbNeabNBMj3QB/aVNKGk=
X-Received: by 2002:a05:622a:1444:b0:51c:1d67:379 with SMTP id
 d75a77b69052e-529d7106556mr27092501cf.23.1785255041278; 
 Tue, 28 Jul 2026 09:10:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1444:b0:51c:1d67:379 with SMTP id
 d75a77b69052e-529d7106556mr27091781cf.23.1785255040624; 
 Tue, 28 Jul 2026 09:10:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af22dsm80319165e9.1.2026.07.28.09.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:10:39 -0700 (PDT)
Message-ID: <68b8d3b5-27d5-46dd-ab85-d5e18b8b15f0@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/nvme: fix cross-namespace copy dif buffer overflow
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jihe Wang <wangjihe.mail@gmail.com>,
 boy juju <agx1657748706@gmail.com>, contact <contact@xchglabs.com>,
 david korczynski <david@adalogics.com>,
 "Brian Chastain (off_by_one / Curious-Keeper)" <brian@scalingsuccess.io>
References: <20260728-fix-cross-ns-pract-v2-1-4641b842836f@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728-fix-cross-ns-pract-v2-1-4641b842836f@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68d481 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8
 a=pGLkceISAAAA:8 a=VBowi81kAAAA:8 a=J0GrWIi9AAAA:8 a=EUspDBNiAAAA:8
 a=hJUlrBsUkIxkKlaUM20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=uoxt2CKr5i4t67rzx1zf:22
 a=3seXTzszHmjzhzopxh8P:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfX1tUuGudbnfHJ
 EX10/WvOUhIfJbRrCaNEfzOxlTValLDgAL5uSoFQaOdjoGdyOfa6l8xqczZEfS0LFk2lDVzE8d1
 waDDAuWdf3OojDv6akq8y4Td4eR3k+YJFOZqM/tnR3vD7Ov9bZIaWFRGvWzKl9twny4aPtEL+3B
 Yssp3nl1X6/UIZ8WLwn6iiI8CED+NACAuuluZgvItbQcxuoOIPTv8H8zuWk5g/8QdyqQ0O1EQaM
 eQATRoIko8hRtlzMYxvFDT47QjUXy4rLp97O0eMpfPkNh8cBeN78rnpxJpfspWq3lAT/OMNGX9y
 qKZS6g83z/yHBVFKmUeyOyMe115ZVDuw1t/1eHU1+YgyVnhqEh97nUNRgWuMR6DnemjwUy/puek
 2TEKn1Emw0IkMU2yYiob+9kqWsTry63VjnfUaU3jnWEsbGftVFJ/qoQJf6ul3XLWhsu/yNFEhEE
 T8R4qBk5xqaVKk44VMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfX7eBPDkIFX/3B
 O7OpL7IaFRIW11IEJ0r9zXUIrYT0NgFz/x9ZPaxO9mej4yhbU8wQf7kN2fXCj9AEy3E8zOGiMea
 zyd80oU0cM7JFrMVDAHcszGmfZY+WVc=
X-Proofpoint-GUID: PUqeweffr7WBPCdZ4dPGuEKfoyQ4mH9_
X-Proofpoint-ORIG-GUID: PUqeweffr7WBPCdZ4dPGuEKfoyQ4mH9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/26 12:37, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The NVMe specification allows a controller with multiple namespaces to
> use different LBA formats per namespace. One implication of this is that
> the destination namespace may have a metadata area for PI, but the
> source does not. In that case, the controller shall generate the
> protection information, but the bounce buffer is erroneously allocated
> without space for that, causing a buffer overflow.
> 
> Fix the allocation.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3692
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3841
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3853
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3936
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4031
> Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
> Reported-by: boy juju <agx1657748706@gmail.com>
> Reported-by: contact <contact@xchglabs.com>
> Reported-by: david korczynski <david@adalogics.com>
> Reported-by: Brian Chastain (off_by_one / Curious-Keeper) <brian@scalingsuccess.io>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Changes in v2:
> - use MAX instead of the tertiary if
> - assert that we don't
> - Link to v1: https://lore.kernel.org/qemu-devel/20260728-fix-cross-ns-pract-v1-1-20f66766337f@samsung.com
> ---
>   hw/nvme/ctrl.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..7f28d2e3eb49 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3210,7 +3210,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>       uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
>       uint64_t slba;
>       uint32_t nlb;
> -    size_t len;
> +    size_t len, blen;
>       uint16_t status;
>       uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
>       uint32_t snsid = dnsid;
> @@ -3331,10 +3331,13 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>       }
>   
>       g_free(iocb->bounce);
> -    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
> -                              sns->lbasz + sns->lbaf.ms);
> +    assert(g_size_checked_mul(&blen, le16_to_cpu(sns->id_ns.mssrl),
> +                              sns->lbasz + MAX(sns->lbaf.ms, dns->lbaf.ms)));

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +    iocb->bounce = g_malloc(blen);
>   
>       qemu_iovec_reset(&iocb->iov);
> +    assert(len <= blen);
>       qemu_iovec_add(&iocb->iov, iocb->bounce, len);
>   
>       block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260728-fix-cross-ns-pract-6934cc8205f2
> 
> Best regards,


