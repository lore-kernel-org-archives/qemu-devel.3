Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D983C4453E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmk9-0003fq-9F; Thu, 23 Jul 2026 02:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmk8-0003fC-6B
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:17:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmk6-0006rO-A3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:17:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6AZj23016472
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=; b=jrjB2ovNQ7Rq/RfN
 ho4y84Ag7oANSvwPkBt1YzRHj2kRX/8SVGpJHQ0I+egkqTB5XfufDl+NBAZbcev0
 l1QQJDqBIy2zxLS9VZd5Lnzqhow/7K115yy7DWaC6XCgTuVRM1OtTNDoGLzb6ZKQ
 NWIvL082bNGlNCYf9eVHW+B1HTxI9bIurtn1ytjxHmWCPhYQDz1YxfkaOwtxfDdX
 mAZoCRioklEP7MSdCerMuEsurI9jLx5eYw63ZW+9rcGUxzzJfxTPx1HO/JyReIi3
 25cq9cw0s+IRHjW+hnMUlmiRZv4iO7dFtAhQtQdJzD+lZ/yc/VK/9W4Edfr9MYpv
 dB4LPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2vvcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:17:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e62e3459fso60436085a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784787429; x=1785392229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=;
 b=Ny/lfOt7N+19aEGl/fJLZiVReaexFMZfsVYFyKClXS0R3A6758gWzJkwbTeQlM6UfK
 boZ03T85EXdI6hd/BxzHu34DhS4wzgLt/L4GyjqM+mzZI1Ldzgnk4/jpJhBc6pjLK2zD
 id/TT4tuS4CqqE1ebFHdYqqxDHjF4ig8Kopt41msUjWJGjQU4oqM47Zk7D53i8kBba0z
 TXnGKGTY4Q3kL+a9cAR2x0e1/Ixfl22DDpjMvzvOdcXZxEgGoRmoagGwYERGV5b0kI3l
 nmNUduMEiL+ajOZBj8vveEQq9HCbs9kb4xzcfHLcof4KpcT7521lNqYTtrNoNTBJ6yA4
 Y+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784787429; x=1785392229;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7yveroT3Jrswv3t5GgZlyF3krE4zg30v7QN+83PhQdg=;
 b=htpGOuySnkYq3PCaobsqnmoK+bCcHjJIGxVeO/xBAOVQZk8mrHPQgF7BJwNQ54MHFJ
 EWQQ8vjMpMiU7EjUdqTviRwB641Z1jNDwWceLENQo5kx0s1VgFQHBD6YhWrEQ0QlhYpC
 ebpEWqSPooQc1fkBLiJjsvNgOMGT+yWB3o+cFUUR6nk02QlyC2BNBsKbFPyYuJklunOh
 J3y6VCLUftj2k5czCzqMp87WUt24NZMIT/38TgQSH7gqHPheSj+X6TINg6nsDGtWNwld
 qmS+dCTRI53VIID6dYF7oSkAmjH6w3V1MOzL96hhHdLtvHciFuhbj1e0zsypxnz0nVhl
 mTPw==
X-Gm-Message-State: AOJu0YzrI0i2pk6TIp2oKOyMUhfR5/DNUjy9elWyNgOMCpzEcr2dLlvr
 UIaAxrcb0ROtIm3aoArn99f0gGn7xDyPa/Jr6ps/XXJIzP51xdngleniQJ6YokaPUIAU+gPuVf2
 KvfP+jcohCb6UMQ+y46gR/guGtVVjGVxoCoNeUmVEOih+pv9l5LaQEbWP8A==
X-Gm-Gg: AR+sD13qphZXCGn9mbzefQk+WBI/qeeMEMzSc0Cw62F5J40+GmQyJPQWwRtdz+Xipz9
 xei99sl1uibEzRDX0a5gAXs8Oa3sSm9NQcLqmSpC+h0aC8EY8INm+a4mGPDHU3QpdyCLIBflifj
 a+nzS5Rw49kuHZPAVVaJCHObmr8pcj9j3QKgYypDu7rErRI3v+xDMiYNlR0R7Te3ToEPbDoa1ek
 xpjqsmcJrM6rAwPEmQvajRx/d3JmyC9zNrS8wvPNvcUwvtkTjVg+KQpn3jCF02HjK8qDs2ju3F/
 rCpHFJMjVWjDDvDgC1qC2fiQE8y1nEAILk+c0XY0dgkDqnX2rNbGhgW5/4qhF1CtUGSfqQj6z81
 d7mWxL80+ITMimvLm06HSDGraX7RNBOKOoIV0Zm4tzCh9gAgVRL0=
X-Received: by 2002:ac8:7f15:0:b0:528:38b1:b54b with SMTP id
 d75a77b69052e-5283de0e52fmr15754811cf.20.1784787428921; 
 Wed, 22 Jul 2026 23:17:08 -0700 (PDT)
X-Received: by 2002:ac8:7f15:0:b0:528:38b1:b54b with SMTP id
 d75a77b69052e-5283de0e52fmr15754661cf.20.1784787428388; 
 Wed, 22 Jul 2026 23:17:08 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm11768525f8f.0.2026.07.22.23.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:17:07 -0700 (PDT)
Message-ID: <14f4c087-6d7b-4839-88d5-8134b8120007@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-5-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-5-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfXzribeHUKMh63
 /FhsTuNjXo8GoFnukqZ0aAYogHzGq9UoQbWoBoJztqCp/9L40/a9hZ7a3tpISiTKLnbMo83r+zn
 X/o9mRdfJ27qh521gMKWWgrRu9vtyR83BAPe3nhkzj4xx5nkPjKPjNWCujZ91082hvgrMUte6a2
 bYnBRWloqKJJ/aPSJ2Yis5djJ2PmcbTgSJolPAqeY5rohkM6kCZbZ0OGnRV1+AMdpJ3sJFgEedJ
 qSINiTKRYq16YbVdpoaqKbGIS0My9TsfiGXxNTKf1b4y0ZcHhWyHEudYNMLkaqKV6Fi55Z0+47h
 wEdejrNtZTcjZPi1JGOA8gTQHepYWr/7b3nzEhC6HqsqvE28DXKMyZ7WdX+y6XLEthDFncEiY3P
 gXq9E4rm5exHd+3CT2K3gBuDUUqAnWgTfY69UR/QfE1lJHXfztIWJLSsc8JT9MFf8Y5F1IA4pIK
 9klH52sQwwol6ccTVqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2MiBTYWx0ZWRfX1GWzj0/g/FyG
 G767ojWsmqJ/t40RzRkmt+A6nkYeEtk1AsDAGeCSxmzY2kPJBo6eLf6eQW9x17sB18Un2rS/6k5
 2vlxuhu20xesmw74RV8uhrDC4jj81nE=
X-Proofpoint-GUID: yZwgN8R_9a-qexP7SrLTFMyEBXsTlGDs
X-Proofpoint-ORIG-GUID: yZwgN8R_9a-qexP7SrLTFMyEBXsTlGDs
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a61b1e7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QyXUC8HyAAAA:8 a=yhWaLJ035AIv3j_7LEMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230062
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

Hi,

On 23/7/26 03:16, Junjie Cao wrote:
> Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
> execute across Conventional Resets."  If a sanitize or media operation
> is in progress when the device is reset, the background timer is already
> cancelled and freed via cxl_destroy_cci(), but the per-operation state
> (media_op_sanitize) is heap-allocated separately and would otherwise be
> leaked.
> 
> Free it unconditionally at the end of the reset hold phase.  The timer
> that advances the operation lives in the CCI that was just destroyed and
> re-initialized, so the operation can never complete after a reset of any
> type; preserving the heap state across reset has no benefit and would
> leak it the next time media_op_sanitize is assigned.
> 
> Note that Section 8.2.10.9.5.1 additionally requires a device whose
> Sanitize was interrupted by reset to remain in the Media Disabled state
> until a successful Sanitize completes.  That latch is not modelled here
> (reset re-enables media via memdev_reg_init_common()) and is left for
> future work; this patch only addresses the resource leak.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/mem/cxl_type3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b842e71c66..a5e6df3033 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1361,6 +1361,16 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
>       }
>       cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
>                                512); /* Max payload made up */
> +
> +    /*
> +     * Free any in-flight sanitize state unconditionally.  The background
> +     * timer that would advance it lives in the CCI just torn down and
> +     * re-initialized above, so the operation can never complete after this
> +     * point regardless of the reset type; keeping the heap state would only
> +     * leak it on the next allocation.
> +     */
> +    g_free(ct3d->media_op_sanitize);
> +    ct3d->media_op_sanitize = NULL;

Maybe we could add as cxl_cancel_media_sanitize() helper in
hw/cxl/cxl-mailbox-utils.c and re-use in __do_sanitize()?

Actually, I wonder if this shouldn't be cxl_destroy_mailbox_t3()
to match cxl_initialize_mailbox_t3(). And if so, then also call
in ct3_exit().

>   }
>   
>   static const Property ct3_props[] = {


