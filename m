Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1C1C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtqd-0005Yu-89; Thu, 09 Jul 2026 14:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whtqY-0005YY-T1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:51:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whtqW-0001NF-En
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:51:42 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HX8IR2374378
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 18:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0219WFoIG9cv3gTyr3CepuQxnkhzu+xSZXWhzRALbQo=; b=Dn44FTgaFt1ZPuWb
 lo0KpeiVFQ/dT7YiWQd8Dxs6HiPMerIFGCIG+6HetzW6k+Q04mu+Fe8Y/p5hzAXC
 j6NHSbcMzFp5GmGpBk4IKel55hqmJjeZOc69ZhMMIGg4i8k9pn/GneDe/X9i4b/Q
 1Ewm0WwhYKaa+wg49XUrJP673tBnXYoKtJB9kqJNWlWbq0cpZgrkecEu+RwE0v7R
 zerZ1RuZuijYI5Jck45ZnZjWQ4m18enNPYp/wQr/GiCkV2haCzoe+0kxP7DoDEWw
 +Ffe7sKOPtyj1LSR5pEhnyB0lp3wI34nc/iThRCjhAoQnvgn6EXivt/eKfZ+hs2j
 JV7Pog==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5gxjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 18:51:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so1102131cf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783623096; x=1784227896; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0219WFoIG9cv3gTyr3CepuQxnkhzu+xSZXWhzRALbQo=;
 b=QoOEer3PYL5r29AcliuyShqx5lXieTLJBZJjIdwuzxHMweuLPEuoIePBMY908ZyBiD
 IEZuefw974KxfdHyWKkPRX64cMPkmQbB8SU+ZPDk/cos9WOoa1dAIY+leiMg9aOYgoBL
 sPRdrucmCriifsZn/ps1oWKUwJZmBkivWhSoUohTUKycsSpj6yZ+V1MGi8bUOkz3LxKL
 bYlA8Pw4tcpDA+YGaokVMw3JQRfFRvA0wtv1+VPFVs2lGbQTvR1APlsFCVKSFvGiq1ie
 f+vc+KR0WgjPh1TPur8FfsOIqnvH0O/68ZzsP3IWrqsAWPPuB7bN9gwwFSwm37BE0DfO
 KkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623096; x=1784227896;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0219WFoIG9cv3gTyr3CepuQxnkhzu+xSZXWhzRALbQo=;
 b=b+YPErLhug9YtJS8ZpsiL7e3LIYveSNjycqbuRQgh+ECUPxcBb9P7oTsomAH/7QjWg
 eIs3mugc+ypbhbrxD42DjcGYK2HoHp2fQQyHHU0VPbt0EhHK7xF70m61Nzol8hZwBDbl
 EQLi0WkAqBPS7J2WnH9/MCt4FJ3Jqo7Dmx+iMt4G8gSMI4w7TEV5Yf3oNXNOSkBV3TLX
 IX4RbHs/SRZjOwblnFPH2N1kRfPNIIposJ1/J3JUN5Pr7LgZOTe8JiA+dl2V4qu7p0j0
 EkVNmXfXxNNCc4AWA4xQuObFGi7H9zKRYUGlPf1pziWP3zSf2pJ95eXXMIMPPtX1ElNp
 AU9A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/BXl8oSvTO19650GOsHLr0+i6y92B0ggx6tTsGHmRtOT+tyipY3h8bl20lxAZP53M4v3KGgTkCd5T@nongnu.org
X-Gm-Message-State: AOJu0Yyq9V9+YSnY/RjfwWWX8HnwOXma4a53h2LQXQgsGQfyizNImwOJ
 SdXuAtPxuXkE69nh1taIg33IcLiWwijLII62A/zecZWlv8sgaxEwoN6wyJkdLtPbilRySHuGWS2
 QT/wLXBvXf4LOw7ByheVsmfJepTzWbaYPPFZA8e6b0LPZE7Zqb6kr8oS/TQ==
X-Gm-Gg: AfdE7cmj2HC0fH8PBvlWugggaeNBmH0xJYLTe+EuMg5Cz/fX5ldw4QL6dqinfxoPR7C
 YbZa0Vy+SzURYarCv+QkcFrJg+g7uKuY59D1+cBgJlEzuUc79dR+8eXkhQDAUJ00cFyj62O3ca2
 5Pxezpc7fFExDxKOlHUNkJ/+kuU4Ro+8q1TyX41YWTeNtH4A7FxLAAOkRW8JKNxjKKOKoZ4WbVP
 ywwCqU3u2To+EjDrHKQNr+cxvsyIxoOeDRVKPENKUvqfJaeg61MxPVFHtEOjJkpvxLtCKJjwNg7
 VETwwYmG0iP41w9BEtrY1J4qBJOI/6joniKcdF43lIUxHmihFI2JFcOaMbYhAPMyKDOUN/70gLc
 nF2vhXEi1RubHw6KMyyZRCYHw49Uv8PuGcqnHU9YYToBGDYrhvNsjAfLZxJwL0Q==
X-Received: by 2002:a05:622a:1349:b0:517:9407:5c36 with SMTP id
 d75a77b69052e-51c8b4d5975mr92267781cf.53.1783623096439; 
 Thu, 09 Jul 2026 11:51:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1349:b0:517:9407:5c36 with SMTP id
 d75a77b69052e-51c8b4d5975mr92267521cf.53.1783623096010; 
 Thu, 09 Jul 2026 11:51:36 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm52674121f8f.14.2026.07.09.11.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 11:51:35 -0700 (PDT)
Message-ID: <b5129342-87dd-44d8-91e7-9eabe165119a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 20:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pvscsi: translate data endianness
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20260710-pvscsi-endianness-v2-1-c512e6c8849b@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710-pvscsi-endianness-v2-1-c512e6c8849b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a4fedb9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=j2M5GpQjiR_YU7jwvZQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NiBTYWx0ZWRfX/owyLVCdGjQ0
 pp6vdNNxjKvDGC1SYvEwpCIlGdYbTgd+RjXCY9iFlQwtSwMkfXAaUqfUmSM77a/w5If4QowUdrA
 xt8dNUqEzEmMF/tutxhsOzxSj2a39bA=
X-Proofpoint-ORIG-GUID: sqq0pOpVuYbe5d_gbdfY6bXCoPN2vMdL
X-Proofpoint-GUID: sqq0pOpVuYbe5d_gbdfY6bXCoPN2vMdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NiBTYWx0ZWRfX0R6akdrH+YBp
 6Ep/inwNcFklxA4XQkkhIiNrsvrTgKbHtslBp9By7WbK+uVNffkACp0LRTN0HjT3DlgWeGjRpu3
 tUssfH7P4EtuataniLhr9F8VqKXHIqTCw8voUZjT+sOalRC0U8L/GcEQC6KmILYIuPP+kLNZmA5
 hDcDFHso/wIi0DhO5nPAsTNiUMm2gpF9Rli8+mTk5QghXLQvpCAqPeXWz7ITTghtgG2phvOUxIz
 brdts14jAFgJntN8KQ0h5P820r3+c+ln1ldNYOgo9fj6NISIXXloPN2WJi9FTuMvJIl+fl30Ouc
 Dr/0D0YoNgApj3XC/6G7oRGQxICpi4haVnyk4nnfZSVyXrQFdGcuFSqm4jbqIpvlDFS32WF/gFl
 g9w9BEo+i5WUt9HTSCdVgwbYg52FMUSosB8E8X/dG8PRv/5zEwjrPV1HBBHVkfXChBOY95KFKGy
 VlwlFlx+tNdzViVv8ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090186
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

On 9/7/26 20:35, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> This patch improves the implementation of the pvscsi device by
> translating the endianness of the data sent or received from the guest.
> This ensures pvscsi can work on big-endian hosts with little-endian
> guests.
> 
> This patch assumes, although not having found any specifications, that
> the pvscsi device is little-endian, since pvscsi seems to be used only
> on x86 platforms, which are little-endian.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes in v2:
> - Assume pvscsi is little-endian instead of native-endian, and thus
>    replace tswap*() with le*_to_cpu() and cpu_to_le*() to convert the
>    endianness of pvscsi data structures to/from CPU endianness.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com
> ---
>   hw/scsi/vmw_pvscsi.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 11ae6b9b7474b9bc87621137eb7911361b5fd721..e6befe9be2c49d1dc04e6e6384f9d24f7a6a4273 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -392,9 +392,18 @@ static void
>   pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
>   {
>       hwaddr cmp_descr_pa;
> +    struct PVSCSIRingCmpDesc cmp_desc_conv;

Nitpicking, s/struct// as PVSCSIRingCmpDesc is already type
defined.

If you ever respin, please add a comment in hw/scsi/vmw_pvscsi.h
clarifying the choosen endianness; but can be done later, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks!

>   
>       cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
>       trace_pvscsi_cmp_ring_put(cmp_descr_pa);
> +    cmp_desc_conv = (struct PVSCSIRingCmpDesc) {
> +        .context = cpu_to_le64(cmp_desc->context),
> +        .dataLen = cpu_to_le64(cmp_desc->dataLen),
> +        .senseLen = cpu_to_le32(cmp_desc->senseLen),
> +        .hostStatus = cpu_to_le16(cmp_desc->hostStatus),
> +        .scsiStatus = cpu_to_le16(cmp_desc->scsiStatus),
> +    };
> +    cmp_desc = &cmp_desc_conv;
>       cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
>   }


