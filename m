Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EAEC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yvB-0007Ig-7r; Mon, 31 Aug 2026 06:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0yv9-0007IG-2s
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:07:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0yv7-0002N0-8l
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:07:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xLxs4081777
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 00w1IMURz4rm7i99No7qXBIIG82fkRgdQU3Qu8obpqc=; b=QbbjyHJifXA+UEUt
 MKLN8OxeJKLS0J1Zo9+11GHqd3DVXCxoHbCy/pWyIHalofrAdEv3iJ4sCxvFfMg1
 rZhaGLAUBZUlOAYnA1hWG+qng2vWKQAyVcC2TOswC1iMsbUw6OWOWH8fbd+JM9Oz
 zcutsCAcPWR2DLnU/P91r5itAO/mQnLjhvUtcAqShZ8PwrF4x3GXDGIkD55jE9vh
 eMqZkF4/0yvzk1i8+e+CHmg4/rPGAS/nesq/UP7PnBMrM5cf3mpIHO2dDoul7LAP
 mIgKD2q6H3+GM5sVRyu6GMMWwu3jDxtewdnGym8vrzu7G3N8uhUCokhcZd+OGihk
 +SspgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h24ck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:07:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso470204385a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788170834; x=1788775634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=00w1IMURz4rm7i99No7qXBIIG82fkRgdQU3Qu8obpqc=;
 b=OWoC3GviFUWNCC7FnSQUs/eDADzYoJ9RKoR45BpWCQIAVfEnp3mSxXIiyl3dZVcLnX
 Yu81Z8yj4Z3GYctdkflR2EXvLtUDvHGbPJbLTbFU4MWxu9gqfP0QUvtg/zbpusUafPjJ
 h9osHzy+VyW9VeY/bRMwOujjFr/lT8vY8SI8GkadCjwgGsuEQHcYtf+xhtIR/Q8DERTy
 a1Vet+8l1KPiOuLVXg5ajjRZUsNAumTClIneP7HJHWJh14RE9AosOz3Vkg0PWXHA8Sxf
 QbwgrbpnDKVghwGzcI2SM7iBR9eOloVKHkbe9UMgPHt4SxUPqCBNAxmxNCDq5BjgKLE/
 b2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170834; x=1788775634;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=00w1IMURz4rm7i99No7qXBIIG82fkRgdQU3Qu8obpqc=;
 b=BOSaNiUXTFGv3CVsZrOOIf3zM/FZGAZx3CAwxht35juYEcNGmD4zxr9TN8ZLB0Oo1b
 rVPjNRfDtK5pqQyxyVE7C5tj/SvDFOr2LSXoPC/2uiCkZvH9WBSFGmYRv8RJNNHh8IvU
 7aaXqGH2qgA5sxdPn9vh+PBn52l0awsCXBDBQLpf9lmY1q8Je1H2WHj4TP9wNezjdl0w
 roD7Tl9otpSAU4Xr01RaOev8klZfZ7b3aIGdgEgd49te234bXLcpS/xVnXSNVHgEYgJT
 xTZTYos0ecb38tPUU4k9O/JIKD09DTEq0Hzzls/VYYlXsyBA/hIi0rDZ0eUh5kfjVb0t
 VTJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPqIKqYStxSPoXgADSOcq5tgJzHX+whLHQnUFtDELGSbEkb3JgulnQ8FmSM6A1SN2U/rmBXmWWBYJx@nongnu.org
X-Gm-Message-State: AFuF++mRNvKtxJLL3o0tgPOpkYiQmIPsZOJp57o2DWSQHlhj8P5zJdAU
 OjtcUzRSJq5wIGLUQIgrDKw+BOy42CatsCoUaCmTgsHnVL+7BGJ2bL4A49WgonRMqR9f2rzzPTT
 c0ZyuUBMBFi4x+VZjuVK9j+qECmz3anLAGET9E/sYhZVQ1/3fu90n2MBWQ8SBlBGVlg==
X-Gm-Gg: AR+sD13jA8ex/yqjUpMtHoRliZgj4dz6iWkDfjmgDQ9kfTTxwK7zYjF3p0Do+YWHyXv
 f7CgZ7iP2hJ1JganTQOE0HK25diikYa2ingE+juuNZpwTgXsumLW+c06RsVislsjHuZYBeAPHlz
 O+zjPwyDLKN0PDHtsRVCBs///jp2CuCxBUNYI4moJI1DuaBzmhPjfddKNFEy0PAxHrMptUBuLZb
 o89YbGMrtVZep182uqwC+pe8ByxhtvyW/5mK0E2/+vbhqtxSXQJfqrYYK9MRyIy7VWAjkkImcZT
 16igxzlgqlpeDB6PGKG2vWzDbwlwqMKe9gLztOuALuyY3F7ZyNilT+YBezAid1uVOjTOXXogYre
 LMT9Z2YaSEASPQRvOblMRlHzD2N41iNiHCg==
X-Received: by 2002:a05:620a:44d3:b0:936:78c8:91f3 with SMTP id
 af79cd13be357-93936cc2ff6mr558881285a.11.1788170834238; 
 Mon, 31 Aug 2026 03:07:14 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:936:78c8:91f3 with SMTP id
 af79cd13be357-93936cc2ff6mr558876585a.11.1788170833747; 
 Mon, 31 Aug 2026 03:07:13 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc6446sm322673445e9.7.2026.08.31.03.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 03:07:00 -0700 (PDT)
Message-ID: <b5c70deb-bdcc-409d-adb2-54081a6b3102@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 12:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/bcm2835_ic: reject out-of-range FIQ source values
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20260831081709.77725-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831081709.77725-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a955253 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=ptpCNiVU-4DG3ZlGizMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfX4UZz2+Wr1k57
 xiDs8ugBCTs2iEdtTS7Z8K24/0UdQsaI2mnbSs9EbDtU8I68i6APmVu5DguGXnVSzLjy6VPseQ2
 CjWfg5q9QYgFCi4CeA5L9UlOQ7/rymtm632M0j5J5wHDpA78gjIwBF3HM2gu7nqzKhS6VC+3OOv
 Vn63ABiAYahHTaZ2+WgE1Y9qAAQdPce9G9JKuqZ+xTS0T2b7kxrQ9RcHWCvqEk1yplvWWyPf49I
 2eko3g5omR1mCqrozjvVeUFB8I1G0nMWz4qqa8epjbzfRRsej8sgP08EoBax7oKhKmGK3US5vzt
 4aMjNvqCPbE6Z9yGjpWDUmVt+gOO2Wmv5+KsQ06bH+ohMoDbq6qjIMfHyn5hiyKucvokzoenLaI
 jegjYH6OQAntUkbpR83RDrb/gTJMsJJfsxGldqHzjxCvEhk16w+JpXcHTVvExA1ADnfYtoKF0fK
 vBuL+mdcDMRB2yQYqJA==
X-Proofpoint-ORIG-GUID: ppTH2aT-TS_NKG1ALenlC7CD81bEZI0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NyBTYWx0ZWRfX6w9Ec1i0EAca
 u6Flw9zjWNRYsS1+kKR86CbAn03X9OmAlub8tMNdyJYkHV/rUHKHSs7Dz3bSSQ5RvLbsos9kiak
 ZJgBRKZrhJdujyPG6U54tuORrIpbRuM=
X-Proofpoint-GUID: ppTH2aT-TS_NKG1ALenlC7CD81bEZI0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310087
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

On 31/8/26 10:17, Bin Guo wrote:
> The FIQ_CONTROL register accepts a 7-bit source selector, but only
> sources 0..71 (64 GPU + 8 ARM IRQs) exist.  Values 96..127 cause
> bcm2835_ic_update() to call extract32(arm_irq_level, start, 1) with
> start >= 32, which trips the assertion in bitops.h and aborts QEMU.
> 
> Reject writes that select a non-existent source and log a guest error,
> so that a malicious or buggy guest cannot kill the emulator.
> 
> Add a qtest that verifies both valid and out-of-range FIQ source
> selections on raspi3b.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4368
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/intc/bcm2835_ic.c          | 13 +++++--
>   tests/qtest/bcm2835-ic-test.c | 66 +++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |  2 +-
>   3 files changed, 78 insertions(+), 3 deletions(-)
>   create mode 100644 tests/qtest/bcm2835-ic-test.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

