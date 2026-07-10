Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C7BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDFo-0000o9-PW; Fri, 10 Jul 2026 11:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiDFm-0000mx-Bg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:35:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiDFk-0005Fu-Ee
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:35:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AEcOT51176235
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yvO92o1FBhJfTYk9NDMNmn9qAonxfBHrzVWDs5qPKcY=; b=nO1F8MHPCQE95h6o
 UCEodapxNIAxoEvYBnRxhpLKALKq4VNIGnkvf9IS1IpX7vxJ+6/Nn+zMcuMuoSF3
 STUltFI1P3Ak2QuevEklCjDXH4c8KYyQhsT/I8GM/qZlN0a4lotQiXYjmIKmwSDh
 r9kXHRYw1/j4n/2BaK9ieLIA4zVJWNjgjjspW55HDfZGBci+UxLJQZJyMQ9b0EQf
 dJaIqrd3DB5PQk8d2iajZXYi4yaz9nhfjfX8bXK92Z0/R5hhAsEblzqxcCopI1BV
 /ans4dT1Ao8Vwnun7eJK5DRBkjgNiD2csNhFgEdSKOkPKTGYQVSoWpuMy0cN2e/I
 bcWpYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3n5ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:34:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso10558581cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783697697; x=1784302497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yvO92o1FBhJfTYk9NDMNmn9qAonxfBHrzVWDs5qPKcY=;
 b=BNcxXiuALi7IEgCTWxc7mGm+PCdFn1qpVObrV+4L4q9SdpBrU/oiU/E4M/S42PhSE8
 Q2Q6OnQrG5NbZlwLIvSVbgA9ODHTyyfaBw6lJoEHL8nXvClmnZOat7aGIVUXQxSqze8E
 AiVvnaw41t1tX9uEfbYhEgmgl5a4RzlcHA+WffOJ1ZWgdAPaHF/6FsrXnHgeCwffyMA4
 vxlWaEuaaNv9d1PKNtNzfDYWu8t5Gk89HC3Ia0wlBNkCKEUScYvSBn4jkhZnZnLvXctF
 vyqKID6XPgS9EZPfIF3yIB8OZbLVezHR60VXlOroC5B1Pr0WEkDUUN6ykMsKqnrpRw51
 xsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697697; x=1784302497;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yvO92o1FBhJfTYk9NDMNmn9qAonxfBHrzVWDs5qPKcY=;
 b=V3dGaxP+KjpsPpR3ac4yg6MEoLT9cwUpcpP1/HYFOgrklapjggz1CCs8ptyneGB443
 r990zxMZLfmmzxppYa+x57cc1+q/IXDvP1jOL5PIdGCncUuJSQKoov9BvsRmA4cnD5kW
 AyuL63zLtgc13CF1vp+owV5p/CIRsLn6RRem95czHI5AJ9EZNbOPtJfCzo5ByLVMDKJM
 Sfuek4R7HKA+Uj4vdAkNJnLt5dJ9VArkbCrs8cEXwMi3mBFDJkm8PcpXpPZj6F3bYukY
 c0SAPcIj6iNPQLB9dwAUG4ai+sAWVBQekWhSGmudv3W9vQw8BfqXulapxU/D4YLbXmkc
 xp9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrptot77WKl/7O6ore4EtrHweocYxeFVfigc9TmOpr6J/g19eeVBwA1Dq8lqKhF90uhkzUTxY1idH/u@nongnu.org
X-Gm-Message-State: AOJu0Yw0kYL9M+f42HlcUoiLQ7krKEnhrlIicLHf6qp6DcQZRUR0WecB
 Yu6PLlobtcGOi4xDuDWyFDXex0k5EQz/dgctjjsfFM0QmMzB2JKD8SbCQ2Af7FPxvBJcbY0ZBQq
 6/GgwBEPcjwFGk57Fleeu9j8YENYNfeUFvs9Hwa1jYPyw5zXoj2Xl5lID9Q==
X-Gm-Gg: AfdE7ckLN9NOvf53CD4Rad9rRTuEh/Qrqrm2zHsyOGAqFYVGD+VfwHDSmlf9EOBxcbz
 L0M8io5ffPjK5c6dAON3SsmSroRkcuVh+RkKtUSolBM2K917yIa4gLnqX9CVH+/OwAvctFTgUc4
 UGbQfTMOgfiKxw0MSoloZ3ywHgNCKJn9TLX7vLm7TPbqWE8jjZwx/98XAorcTTUsPa0veIMS7uh
 qYBq+qjx7r5Ww+gWmhBVM3nM1tGl9rcR6+X8u9HlsdL9/4n3h7b6gS0Z7jgfj489nE5qh4qySnK
 z7+v6LcyyCxElGWWifgkLKUlke1i5vmDR9PBM4TjCeI8qRCArJ0BRqOK1okja/JBQe/6LbPX7nS
 7gh5AqhZNtgkMeTeQnUztBWKtY7giQpj6y9DuAjf/Ew6yv2iRxB03dquk2AlEWA==
X-Received: by 2002:a05:622a:95a:10b0:51c:9193:fd9d with SMTP id
 d75a77b69052e-51c919404a0mr70347371cf.67.1783697697303; 
 Fri, 10 Jul 2026 08:34:57 -0700 (PDT)
X-Received: by 2002:a05:622a:95a:10b0:51c:9193:fd9d with SMTP id
 d75a77b69052e-51c919404a0mr70347161cf.67.1783697696785; 
 Fri, 10 Jul 2026 08:34:56 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm59970239f8f.14.2026.07.10.08.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 08:34:55 -0700 (PDT)
Message-ID: <5df23403-6da0-4431-be8a-a74c82298894@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 17:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1NSBTYWx0ZWRfX8ERrBiCQ4lM3
 5Wduqgmfw0yTdmNC8m822hRBbPfNOye9rQRsuz8pfTO/kyao2o+aZicsPJ8Ht4pTvNOT7Lcl70w
 c7V8cTlK5/m6THhLsvjnSvBtPV7QkPeVMmc4qfVbYfL7pRkbMeY/BPelGD3LXSB45MoTuhunlTv
 a7/btTQgSYseiFI3v3w+0T+X95OZ6EDONwRZjO3BwYxJpMqWzTLQNw1un7uF0oqbwoUyQUpvJ4K
 n6LsLVJSY1A54oTejPvgp+OmSWxBywWmqXHP2jvhMDfrOtqq+wIiJnQk5oABlvX5ANWsiCii0Lb
 wwaN228XqhMVFsGtvR5Yohy2cqM6QbCp7/Lo5D+t7q8aEhSaagIehv1vNzuAgvE0pjwSiKBWkM6
 ES2KpGqdt86EzPyXWBm6ZiGCDveuRa+KWVNi+heGMG7XLmEDC9UZskFfLX3q7rdfjE7O/zabuX6
 tHUc4i8sIY1jIfe+frw==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a511122 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=6b3zXhvIAAAA:8 a=qWurVJCvpz64fImHfXQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=vnv6_c11HO5uxQbMB8V9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1NSBTYWx0ZWRfX1eQUo3NqZksP
 7mzPJLDCe2WonyXLmmsF3xxMirvg6Je7lB65SlVWHzF8aPWjpL9t0oepoM2Z4i+D2LOYr89/SxS
 UWjXUWlanaLPhGbiIfBbDEx6kX+nhws=
X-Proofpoint-GUID: wdRPp1GmzPRzfXCw-jJI8A_Sw_qEfgLP
X-Proofpoint-ORIG-GUID: wdRPp1GmzPRzfXCw-jJI8A_Sw_qEfgLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100155
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

On 10/7/26 15:47, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> A malicious guest can trigger a heap buffer overflow in the
> vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
> with large width and height values (e.g. 65537x65537). The allocation
> size width * height * 4 silently wraps in uint32_t arithmetic,
> resulting in a much smaller allocation than expected. Subsequent
> VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.
> 
> The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
> this via calc_image_hostmem() with uint64_t arithmetic and an overflow
> check. Apply the same approach to the vhost-user-gpu contrib backend:
> 
> - Add an overflow check in vugbm_buffer_create() rejecting dimensions
>    where width * height * 4 exceeds UINT32_MAX
> - Promote the size arithmetic to uint64_t in mem_alloc_bo() and
>    udmabuf_get_size()
> - Check the return value of vugbm_buffer_create() in
>    vg_resource_create_2d(), which was previously ignored
> 
> Fixes: CVE-2026-15264
> Reported-by: "Vulnerability Report" <vr@darknavy.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
>   contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
>   2 files changed, 16 insertions(+), 3 deletions(-)


> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
> index 503d0a4566f..710d5452977 100644
> --- a/contrib/vhost-user-gpu/vugbm.c
> +++ b/contrib/vhost-user-gpu/vugbm.c
> @@ -13,7 +13,7 @@
>   static bool
>   mem_alloc_bo(struct vugbm_buffer *buf)
>   {
> -    buf->mmap = g_malloc(buf->width * buf->height * 4);
> +    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);

Just curious, would this also work safely?

        buf->mmap = g_malloc_n(4, buf->width * buf->height);

The GLib description is:

   This function is similar to g_malloc(),
   allocating (n_blocks * n_block_bytes) bytes,
   but care is taken to detect possible overflow
   during multiplication.

>       buf->stride = buf->width * 4;
>       return true;
>   }


