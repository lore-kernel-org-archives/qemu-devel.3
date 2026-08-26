Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E596C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz91y-0001nZ-Fp; Wed, 26 Aug 2026 04:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz91x-0001nQ-Uf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:30:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wz91w-0008Ng-3X
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:30:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6Rfq53689279
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E80MuKudCzIYw/TIrxiD8rbYf9FlPcIcPbyF230iehw=; b=SEED6k+T+wMnDyBL
 4284jxPi9xmDVISjG7u1JmlcI7PCfZjHDlyQ5w3NY0Si2GuSUrA+BfRCZOnnhwzU
 9qO9M2BBcVL9sbaWiEeah1Za9ZjRQu17aH64bEvXxxiRQGx8Q8sATRFxyAzfxQYu
 FLOP3jOWOjGVzeaP81/slWZKeWt3CEz250ooiOEG4H27xC48GLKV+HaVgWcwzlu0
 g4Z90D5iBXd+fYgSwwJYva8TarMxA7EI1LAw/fvQuB+PgSMMT3S/svULOHDKAgOk
 K3WSy4xrhVJcjhn9jwud4uhgvzlBzmV8IExibTvT9JYiXl5wZDIz9nH690JaxSEa
 mxobRg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn2xqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:30:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c26012cd0so7114001cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787733041; x=1788337841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E80MuKudCzIYw/TIrxiD8rbYf9FlPcIcPbyF230iehw=;
 b=QbGGepzMGt3y9SG4+aeeoAyR8hVqgdN+ZvteKzCBYvYPhsyVlX7FxFMEykgK8FUrX8
 P8/WjUX9WZI1G606sgpQJsZpp57Enik3kYRnAgPhzgDB1OVo8/Gai1DDWUu/jn7Zx71Y
 QwkUYGDd0LS2vlTLGBYXDj+GAJ0CnibH0I+J5gBz47/Dny0QEAfdknrhbBEAJ6VaGd+p
 lqMbLUnqpmJTKuGmBBqVEVWD42op7GmsdPqpUrymmvVFdyIbkoq0JLBIj2QQl2at1QJA
 ejPRD4En2AvPzSlYNVFksMw3UyBSsLy/BpCX5V6+4T4M9PFLpHpfAFxEsCCJUODAazSc
 LD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787733041; x=1788337841;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E80MuKudCzIYw/TIrxiD8rbYf9FlPcIcPbyF230iehw=;
 b=feg3ly6l3Am5HQx2het4oMB57OlKxSwiASVmiAuY6EdGlkI3u1FJxNumvu1GvxN5F+
 Jr4FHuDgZX1R8ZfF5JprGzoRHsilGWVKf4Tz3OBEOT75J5EM79bWx7s9N5iHDPOb9/pS
 4eZc6yElnNunwtIoUmEjJc4E1E4cCsYaYdUI0gJW0tTWgg4JDK0or9kKnTBNtNdEDlys
 5sFnHDPybQLTGDhQTu0Q1NjqdYFihzTp8AZ8Y6Obhy7OIxRph5RnHFghkCLsNira0flS
 Iff+OZRusvlRYQM8KkshLtl6qTo6maqzFKeIaUqNy5dELQztRO8gH9MCms/hbynp5hhS
 Pk0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5VGRBNB1YP6nPKoRo96JyJ0tf0+Rmg7B5sewOlhtppMkuoFR12oT8rPPxWtERax1aqKCL/7SrsKZi@nongnu.org
X-Gm-Message-State: AFuF++kFZU6MXXWqes2fWtylxT0Yl0wYN0dMTK7DELjWVXUSY5x2pwfV
 Tv9I755z0VsIZ+IgMieGDkW1qpl1MBH0LjBTJ/dr/keSAbJZO3qWFpuZzIM0eeUnPz+z0SM3keD
 f47JJR74LKVkNJmj7hLGD1xtqVWHWoSMv6UQrKLjtV3UCqhWy98YIUa+XJV3rbtRYhQ==
X-Gm-Gg: AR+sD12khuJynYFtLFsaM/qiD8zw6/tJHxc/8Hha67O3WdMABzqBsIOAPeg92jVoLSu
 Bo4b1qYK3KVeHPHZ2DQL3xJIBTQvV6u8wcHISOFWYgdKObUvC+lBbQv7ICptM4177rvglOMts8k
 klZsEntazg6MECWRfDLfH9Rn4I2oNG8RkK8rj2CpVNhhqhQ8NI4Cm3cHd1HvQQqyyoNr2uCKpCN
 IBLXs/0U/QNhSwh35cARDJZFQH8yBU89N2M9B1E3B5GMt0JbJlktlubsTVRXqmDM/4nViwvH8zr
 0ht/SMn3GTefqDB09H4Gud9SfoNGClEE9/5OsLz7ksbnUryIiaa19cmrzUw5qpUeo9d7oo36b14
 V7ei2dtwnOQPkJQ8xWqG7o8gFo58zA7Kls2QVe0w=
X-Received: by 2002:a05:622a:5918:b0:51c:10e8:ac7 with SMTP id
 d75a77b69052e-52e423b067emr50804031cf.37.1787733040527; 
 Wed, 26 Aug 2026 01:30:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5918:b0:51c:10e8:ac7 with SMTP id
 d75a77b69052e-52e423b067emr50803451cf.37.1787733039984; 
 Wed, 26 Aug 2026 01:30:39 -0700 (PDT)
Received: from [10.254.188.74] (14.89.66.37.rev.sfr.net. [37.66.89.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499fa55f4f3sm2835215e9.0.2026.08.26.01.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 01:30:39 -0700 (PDT)
Message-ID: <1dc2848f-8af4-4f41-a709-18842ed6938d@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc: fix trace-events
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20260825074114.853069-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825074114.853069-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K1APvMdpQ2XMm3CxQgYSFEmqKKbCGDwm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2OSBTYWx0ZWRfX910eFUOkoJ5W
 JAWBdvg7STfzCNE0kiNBhyA1o3IFAn4XmTAHf+R7hjJADo0o/nl4EszAAFAZwDuEamWOoebufB2
 i/hHBCxrpZwwOYMMSOIFfXNjLwRO8kw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2OSBTYWx0ZWRfX8XiWS/DMJVzp
 Zap5ymP3Q9HB6QnEdOE37VI+t5ife3RvoZf52cuNZ7XMsW60sfbsBbilSWa1MnxuQcslmNvQIVp
 crdCBpH+qEgpri9MbgPcK5y4liVo3bTldXI0yFp7fsqYwl4CvuJJNm+gnBS9y7aZR6y7mMrsX5e
 7GzrKNWyPu1PUzrKRuAA66I/AIOQld+xa44Vv46PSW3VgLVsYDFn/20QKhbRoi9i6Nd2HDnIPbj
 e6TSq8Sr0VDpu55o4wRM7jAYCFj3Zms9Duu2Mrq7sTsZUoTvRKNlPtf3vzhxbNvbuGYUDbzMeGR
 ynQB/1fVX13GnyFuAOjfDnUHj+YONTFhfsfoCs3SHlT+i8N22+HDR7fWO+BXIy7Oo5z8t53hvQz
 MhYbVb+0Rip+MRyyv2D4twdR96AcSxYkS1gQe6D15ECMVz4A18/90ydgqrvVke0j+jXQi6n62wp
 Gixf2K7tZBrIDj3GmKw==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8ea431 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JQZmDyB7+sUo+n2VpL1TLQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=5-BwNDHKl_Qbma-XASEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: K1APvMdpQ2XMm3CxQgYSFEmqKKbCGDwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260069
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

On 25/8/26 09:41, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
> trace events.
> 
> Fixes: 8041d1730871 ("tests/qtest: add test for K230 gsdma")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/misc/trace-events | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 16db4ba0cc17..0b8be3d0f226 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -446,3 +446,9 @@ iommu_testdev_dma_armed(bool armed) "armed=%d"
>   # k230_decomp_gzip.c
>   k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
>   k230_decomp_gzip_write(uint64_t offset, unsigned int size, uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> +
> +# vmlaunchupdate.c
> +launch_update_write(void) ""
> +vmlaunch_reset_enter(void) ""
> +vm_launchupdate_finalize(void) ""
> +restore_host_x86_igvm(void) ""

Applying: hw/misc: fix trace-events
Patch failed at 0001 hw/misc: fix trace-events
error: patch failed: hw/misc/trace-events:446
error: hw/misc/trace-events: patch does not apply

already committed as 8fda982a7c083251635a2ce41dcc068ed0e5c124.

