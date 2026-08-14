Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF1DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuss5-0007LC-Cx; Fri, 14 Aug 2026 10:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuss4-0007Kp-F6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:26:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuss1-0007h1-V4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:26:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EDx2Xd2433174
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 14:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYjEXBY5yiOZAhNYiWxSNygJGeEmhLqUz1wR8+TH0ZM=; b=OFwz6U8ttD0nigPK
 toUxOcdRS5XKmz/vLibOvn3+eE3wq3uZ5jJFUyWYHfTLDNjzF5qug0pbmKQbJl8O
 To255weE7Gb28Z2DZiPtKiKN5lPq2uaCxlhszwqbDj+9cV/Pl0qquhhToTyzb4iC
 p0XXxDMhnX8vQk6YBv1hU0eXIKYeiyiYSyzHbSKwHWqAii27E+kyMb0GKwgm3vw+
 uSA7jHt2G3R0MiUsyJPe1SQiItNo0Mtzx2jWPnK6ytN5Pzas9RX9gtCsNg9pankY
 k5Q64gjnOLJq1APUCRcn6AnPpxRIDN7iffEGTSPjr0izrNSF5WjRs7DEp1dx7QqH
 CV7o0g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1nuguhx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 14:26:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so20694771cf.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786717602; x=1787322402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HYjEXBY5yiOZAhNYiWxSNygJGeEmhLqUz1wR8+TH0ZM=;
 b=NB9Uat9gXiqRDW0jCijLgD9nFF8cLsjoaCanwu3mp4UrybCGDNoHhgSRHoviQWKUXi
 UdKa38jpgXL6HSxCSkWyGtLOIQmjuL7BDY/CoWIlOFJxAbdXDRwBR9tn5kr2dPc2t/wR
 nzBJrgEWAoTW+bFui3PCJHR04J1ZmmWBtoYEZef8Yg9fQAqKqwNK7KrTX/FQAnzhFkZn
 Z4x/On3wZwL7TkcBxne+Q+2m5oi1oRuzGBUQ7xW4MUV+IyYNz0gLB5WFxQfT3gd/qiWz
 XKG5WBCa7DeOHSw0weUO5vXi2crLz22ii0/UqLDm1xGfDRqGnYTW701LFhGqkXPP9qVX
 ukyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786717602; x=1787322402;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYjEXBY5yiOZAhNYiWxSNygJGeEmhLqUz1wR8+TH0ZM=;
 b=tLOLVxFmfYJbmzD+ZYuKcbtMQk1dHnseLWGtm3ab/qzE0QEic7BesyozALDP9JoKOk
 hjKA1/pBmQHy115tZBtpqPo61SQvraOyX6dWR4pNvCxgfZDJd31MefeuUHct2UcNGupa
 tHUFWsGipgErIjXJUxirFOvw9UjyZtIivPmakPlG6htYN2IyzGInQizQZ1YpOACz1pPw
 NXduLPqZoSzD03KGQMX4reAHQ5s9kF0YBmqG3XJXzSOKyCUHo7CVSVqWh2T68c29Caot
 tGU73R9/mBbJ0ota19BpkWRB6AABAnF1L5U735aVLcDMQbQiQ2Q2MoHdPBi2SHpZjMS1
 MKZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7O3uNwpn/mxCLatswjn8yLiforZB7IUuFqia8sPIM143s7imIUfCBL1t8J/TaiD0kk0Y8jwJ6k2j4@nongnu.org
X-Gm-Message-State: AOJu0Ywb69ObO4rjTbRONHwWknoPHlU8UlC8mRNz+wIyymqnkukxa5k6
 KMEKyMIPJ4/KYxu5GgwIHvW1pkfbaaiTMJmr63DDjiReeOXBTNepledSWZsJTpYMePPo3ryKCLh
 cDSRtMg5E8y1WkRdrgPj5VOZi99W/23TGDiJSY3hVPNB2+PSS92Vb7TpqxA==
X-Gm-Gg: AR+sD1164qYmrGhW1yRGBgITozyT/DcR/3YkfUIKMdjjCzWWhIk3Aso0W9iLENwquR8
 Db87Y2LtT7RklD44OOT4RT74a6redRzvch16QsglReGV/ujt/gHXyvAkeKe334BfOGkczhf/Gfs
 IOZwqJJqcadDTX3J9eY9C96Lj7Jm0vM75yi3KCqLGA3CM4IbaMsSRtXvNAvVIVbtCf12iL7Pydn
 9gzCe9QbCBDblmf4azNeOA6UvbNQc3cwg6d2d83cI+tG5KMUBKk9tb/73aPl3k7nAzsP+L/SFRZ
 /NF3dZ5ua5NvtlUGkOiW54UoAbbA/B4MMWgY6pVr3IsRQq/Pir4HMbfQoZudbY125gFOISG5qna
 FQUx7RpfNvFX2MIIt8RGUcyI=
X-Received: by 2002:ac8:58c1:0:b0:51c:2068:a9f8 with SMTP id
 d75a77b69052e-52d8530d77dmr60368761cf.5.1786717602495; 
 Fri, 14 Aug 2026 07:26:42 -0700 (PDT)
X-Received: by 2002:ac8:58c1:0:b0:51c:2068:a9f8 with SMTP id
 d75a77b69052e-52d8530d77dmr60368221cf.5.1786717602110; 
 Fri, 14 Aug 2026 07:26:42 -0700 (PDT)
Received: from [10.111.143.121] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21233a195fsm107266266b.6.2026.08.14.07.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 07:26:41 -0700 (PDT)
Message-ID: <ae8c473b-770b-4aad-8fe9-8951a856c555@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 16:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Define ram_addr_t to be always uint64_t
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260814134035.2733355-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260814134035.2733355-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMCBTYWx0ZWRfX62uI7rr76mjn
 ZBUBf3ULgTrjZPFPwKzuZS36CTfvbxNkoCZW5AwS2IKfEbXyzxnKo4TAK1tG9i7UqoDCamepf/M
 mZQJeN2igQxLQltIgJYasiYhhHrlKk6Ly0Oop+qHmjFC8ZpxwiDpoX4ufSeTyFiCSVSDHj0/qQo
 3gMisZb60D84zVPwlyWPwBI/NKcXGF4SvrFMEtisJa2MPYVj8FYsJ2p66zF4g4VrkW59/7QUshu
 QhJEvo7oma7jje/WRp+e3q80YDrT0mA+dbrrNxUVu/xAgBxTHUYlo0NYj3cO8Tp3JmrVmaMlOW/
 /g6KAoRP1uIIkjVcaT6ydTGq1oRel/jqlX86kWneSPW/8PacoJU8s/+3jLFH9nJFG4JLB+76cc0
 sREEsEiKmv1Auh/Cm28wKVHYILK6rHYPAf00p+apyB5WyrSS7rP1BVHrcBHpLIo8FinihGqDFVZ
 4R91zqklC7XA153x2gg==
X-Authority-Analysis: v=2.4 cv=drfrzVg4 c=1 sm=1 tr=0 ts=6a7f25a3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=S56xvJB5AAAA:8
 a=KKAkSRfTAAAA:8 a=Q_RaKJzvMsiaVHDKxxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=MH9Ivq0PDQRhlrFuIVvX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: S7JtkY1kiLm0T6rUsTo97NSLXkzgZUBi
X-Proofpoint-GUID: S7JtkY1kiLm0T6rUsTo97NSLXkzgZUBi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMCBTYWx0ZWRfXw7YKKd+UiHES
 uwhS1gJ7QBEwOSJMnxcD/5tA+5PJ3rRGYBuhd5KKloYi0EYnuiciqoUsg+Hcotk5uXoi5H/gDKe
 pDqXQT4vc/jt4g6pwB1h21X1W8essxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140110
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

On 2026-08-14 15:40, Peter Xu wrote:
> QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
> least the system emulation part

   (see commit 372ec46b9f "meson: Reject 32-bit hosts")
>.  Now it's safe to move ram_addr_t
> completely over to uint64_t.
> 
> It should be almost the same as uintptr_t as before for !Xen, except that
> on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
> differently, causing unnecessary compiler warnings when use them in a
> mixture way.
> 
> Hopefully, this change also makes it clear that ram_addr_t is never used as
> a host pointer in any form, but only an internal QEMU integer based address
> space for allocating ramblocks.
> 
> [1] https://lore.kernel.org/r/d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com

With the commit sha no need to link to that thread IMO.

> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/system/ram_addr.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 129f6b8757..06caca1506 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -15,15 +15,9 @@
>   #define RAM_ADDR_H
>   
>   /* address in the RAM (different from a physical address) */

While here we could describe a bit more:

/*
  * ram_addr_t - Offset in QEMU's internal RAM address space (not a 
guest physical address).
  */

> -#if defined(CONFIG_XEN_BACKEND)
>   typedef uint64_t ram_addr_t;
>   #  define RAM_ADDR_MAX UINT64_MAX
>   #  define RAM_ADDR_FMT "%" PRIx64
> -#else
> -typedef uintptr_t ram_addr_t;
> -#  define RAM_ADDR_MAX UINTPTR_MAX
> -#  define RAM_ADDR_FMT "%" PRIxPTR
> -#endif
>   
>   #define DIRTY_MEMORY_VGA       0
>   #define DIRTY_MEMORY_CODE      1

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks!

