Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7D606A32E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9ql3T7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kxPQf06/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl9O-000258-Jy; Tue, 24 Nov 2026 02:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl9M-00024u-90
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:41:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl9K-0006uL-7s
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:41:12 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k68m3225389
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0O0TNazQUKLQQxcvaX7GBcTQ7n7vJtd5fRE9qKl8x88=; b=PH9ql3T7CZRvpNXB
 0Aov7fWt4cd5f0dmbatmT0KC3kN1sIlLwMxGlG7IJUZbV+lVHu/1aabQtE+zzZ60
 Pay5h2+AxOEXfEclpQjpPUDnUeCT7A2x/7QKtrIK4HnQJgu6so6OnNf9Oxi13H1R
 EPcRzriOvQec8tb4o1Olz7abw/Kd8On5h96DGrxPI6izURxegqbV9L7nBS7APWl8
 T+khFBrfIdYfMcKu98EaGpyppWulJIMqTum9uzZczhCoWTS85gFleIwJKnxf3sdN
 msCJvJWCRONYAqiD+HFKz1aqfOpItr5QQfO4GeA4t2xOeVaJTBTo0/hTtQ/3S4fK
 +YFaZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f1sx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:41:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso487621385a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795506067; x=1796110867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0O0TNazQUKLQQxcvaX7GBcTQ7n7vJtd5fRE9qKl8x88=;
 b=kxPQf06/GBsAyn/SwHc4Ki51xDZYip9emIOASGlejIcPubnz11b4Ijsl2eerGwnisc
 ZwjK0SEVINWmbduDdT5bIFYw0hUqQpLH5HjdnNL5RbItwTdaKhDgnUajbYt2qwAO/9/U
 2M4w67HOgw5zN8FvHMV0+4nuSTTnpI6xgUanmhA8Kx3HH2Vgmggxfr+VSZsnS+r/7MFb
 U49l2LtlnBmpW1VZb9sgGMcNOjtX7hKgscVkOL+fPnE7/SkHc/F+0ePyARG2jgXjwXSZ
 7/r/jlM2sq6dbP6nf73Fn4+JEKWvmW2/QUHWBRFMtS041CQebW4FqZaThNAj88t0z5Ti
 fn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506067; x=1796110867;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0O0TNazQUKLQQxcvaX7GBcTQ7n7vJtd5fRE9qKl8x88=;
 b=AfAaxFXypeNSwdQ6y8qAzWMeiHRZHqAZsM9uIvN4FgDfWmleiupXIR2MJWngS11p2W
 sUknj2j7qedxMC8JTPHhi9jowrFuDkj8EGXoo+dNW2boYJESJ3CDYYXHrAsOgzYXN0Sj
 klalM/ck7AOjDG9T0DDz0kFiqbSgDUBrjZuM7g9pYmnMS1bECNk+w7i6l32U+fsuj9v4
 YV4Y9NVO3VN2NJaEHNMsvOUwgKVWz9Cup+2beN3ccD1Bdfe5yjc0ACtTUmBrODGA5qPx
 FmUWqUtiDeEvLubh+gwrIjdn9nxcZNxjC5fQCIATFXtXwSEJJ6pW9Omln6S94Bt49bCN
 OP8A==
X-Forwarded-Encrypted: i=1;
 AL+hErGaywcZ8zQONCr+GE86SfvqH4ehbSrrt1IhtPZ9tBZZDj5YFCzoIlQt5jtdSGA8o7yq7zazY97C0VBc@nongnu.org
X-Gm-Message-State: APuU4Z9gawJLioh29LQl5cz1plKr5bfOCv7b7rnwnmHMToJ214mFqpeR
 13dodl8qZvkUb5N6Zuo62sGWUxs8M1YRoUcgnLSmcey3EkzY5lpXokYV3/qjti0sA0HUJALxbyf
 SZLWejyGw2bL78xzKTfv1bXMNut6xzBP0OHhITfncHJmVtV0ttuOx0eDtzg==
X-Gm-Gg: AZFdTZdFGZImDnrI68fhniNh2t/D8KOZCIKD6Ljgmpbq6L467U5inrXAj7+rq4N29/G
 bY/8PMxGWW+9s7YLeaVRlL4WmnAiCj4U1dI8mDPPw+Bw59vx5QQ/Ozw86ZAPLrYjlvSXcr3ebw2
 99sT2OaUmeciewj4xqxzPn7zCUgvVEX+mlVfuJr0pJJsiWtiaG43et6vQQ1oQ/qSvoyzixO6sNG
 48fpfopIC1rmw5Z7VVrC9aQ/fe9MQ/cCW9b1qYC8cA3vGuI+SIvUOT3/81v1+q+j4NpgtmfmVqJ
 spD6UQxTUt0ho4mtEtqsBUNPhBCzS0PfcbZAVHuXsKyv2BKvo14Yc0ynswidJ+awI+iQ7BtsAa5
 9DAzVK1cIns1O/m7QZjlr24uy9KWdEd7BGmNpYHRVfnmlItWKRg+EhsrvXQHidVnEDalKgdItsH
 UURGmaF+U=
X-Received: by 2002:a05:620a:6011:b0:949:733e:ddd8 with SMTP id
 af79cd13be357-949ba9ef1c1mr2159741585a.54.1795506067103; 
 Mon, 23 Nov 2026 23:41:07 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:949:733e:ddd8 with SMTP id
 af79cd13be357-949ba9ef1c1mr2159740385a.54.1795506066694; 
 Mon, 23 Nov 2026 23:41:06 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm26403633f8f.50.2026.11.23.23.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:41:06 -0800 (PST)
Message-ID: <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:41:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
Content-Language: en-US
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20261123231319.377104-1-connorkite@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261123231319.377104-1-connorkite@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX17NVFo+GDAi1
 OsZyiWi4H6zD9tE4FwG7EkxvIXS6bk67oEQGcVl8sbXZ53cdO6HWlo3agazjMxspNNjyZfBF7gg
 ZiSoPZi0D+TCV4KwKPfSiN3ntkbKFdQ=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b053f94 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Tgs5-w0UsqH80BqOBvgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: lFb5mO7yoaZ0tNSvbfqTa_UbVjEF8ZLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMCBTYWx0ZWRfX4Mdr3bVHmEdX
 OSvzJq5MFiASfUpCiqG5k/1HKphrGm3mHCaqS0qqpO8fRB50GfQoIx5X1FNF6QWksTNqEufcRKP
 SzhM/7ETJ3eqX2oS9EaBCMIOEwtySzmp8fK7QuZKBf5P6TIpm76GsumGRHYRlBhPeSJaUl9RuBR
 59O2wIJTkdKlZNHoqkk1EcwlO3iXcVv/F6lGSkNy6kTfT16bc2Wi+XbbTXkNdi7xD1IVaMJbw3j
 HjltU/FhUm+llRNI1yj0ooyDVCobbXl3FVQk9rW6Yt1O0z8UnAihh8WGZWdEGE/mPiMwaSQFa9y
 XyJCoPvzDlPFXztwJ8dQac1T6K1CdPylynA9mtWX0V38OQmPLIvz7U3ttpawgf+LUwwoFXFwZeU
 WXUwdznUYM3J22W/ZIHX7Q+q1JMKWYevgj4v/898mVN0zmqbBRx9061nK5m7oiHRnP4Jb1Bf1+Y
 ZpVvkFsrypwkqga72Hg==
X-Proofpoint-ORIG-GUID: lFb5mO7yoaZ0tNSvbfqTa_UbVjEF8ZLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240030
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

Hi Connor,

On 24/11/26 00:13, Connor Kite wrote:
> When a shadow virtqueue detaches the buffer associated with a used element,
> it adds the descriptor chain to the head of the free-elements list. However,
> this currently happens after svq->desc_state[last_used].ndescs is set to 0
> in vhost_svq_get_buf, introducing a bug.  Only the first element in the used
> descriptor chain is added back into the free-elements list, with subsequent
> elements being potentially orphaned.

Not really added to the 'head of the free-elements list', but the former
chain tail to free_head, then makes id the new head. Suggested reword:

   vhost_svq_detach_buf() uses the head descriptor's ndescs to find the
   last descriptor of the chain and reinsert the whole chain into the
   free list. vhost_svq_get_buf() currently clears ndescs before calling
   it, so multi-descriptor buffers are recycled as single descriptors and
   the remaining descriptors are orphaned.

> 
> Zero out ndescs only after the buffer is detached.
> 

Cc: qemu-stable@nongnu.org
Fixes: 86f5f2546f03 ("vhost: use SVQ element ndescs instead of opaque 
data for desc validation")

(Please check this is the correct commit introducing the
zero-before-detach behavior).

> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 462c86dc1e..1afd3edf87 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>                                              uint32_t *len)
>   {
>       uint16_t last_used;
> +    VirtQueueElement *detached_buf;
>   
>       if (!vhost_svq_more_used(svq)) {
>           return NULL;
> @@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>           return NULL;
>       }
>   
> +    detached_buf = vhost_svq_detach_buf(svq, last_used);
>       svq->num_free += svq->desc_state[last_used].ndescs;
>       svq->desc_state[last_used].ndescs = 0;
> -    return vhost_svq_detach_buf(svq, last_used);
> +    return detached_buf;
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


