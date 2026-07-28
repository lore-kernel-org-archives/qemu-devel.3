Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47298C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocN3-0000eN-0A; Tue, 28 Jul 2026 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocN1-0000e1-A8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:36:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocMz-0000TT-TX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:36:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3b7fQ1701852
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eGcPvgzg96/uZtd06AtwxJbkAab5DOzMq6pivJ9Cbag=; b=IZoPF2bcUMz1klXq
 DyD+gZsbKAbzbVM66Rh+iXk0qmUUbiMsBwTVOEnydrzy8XyOnvx+DzMuPCtrWOfc
 dwczHsW01CHAtF9xN8bAEVytCILNV2sro0UYD6JbUs2fjqMkOFW6/Q7DpsAWe6wQ
 40q0eTO06oitMnpacFG3EsNHOZiOcmce0/cyLx89yZPAu2eIqtlQNxfRm+RhbqXe
 2OQ15j5pwD5jKcfUZ3X5izXlMVN1IEcPWsHkrABYBOdgKeNy0fEhScXWIjEV2GgI
 4wNBvaHh4pjxyzCsdu1STiNcJvJjCmdHr+jf7GYe0ZaYacQsyZAzMfEZyhlz/3MQ
 RxDMVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hjnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:36:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so44056941cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785224214; x=1785829014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGcPvgzg96/uZtd06AtwxJbkAab5DOzMq6pivJ9Cbag=;
 b=TRnbE3+IDK6oJNA+FC5tnxS7FMB5Wt5jbS/EYqcqszgLGJ8/dcKxvdT/fUwwT1Uv7R
 KW+7B0WspeZ45lUkjPyuES902LpbeZDQq5Z0EESaqkMbeAZfqJviYvkeTDxd5ARJU/gi
 EGVARKO6O4inWrRyx4FqK+G/huaqAxtJ8qkuHJ+a/C9K0dylMIFSI5jBNTo9OZOjrUGc
 yAboKN7WoVL46O7WZSZQ+ikwvbUTPJp/aULTc4AJEIwDT11u1tZXAt7++GVR43lv3ulq
 HzgGK7hwles9sv6eur8+hJlxae/yI4A6/pRHPk3/p3Es7aMoOF8r0n0iPAe8kVtPINHL
 cdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224214; x=1785829014;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGcPvgzg96/uZtd06AtwxJbkAab5DOzMq6pivJ9Cbag=;
 b=s8Urf1jY7gtD+9K+ayUjRDYs6HQ6YAUMPr32kUMG81XOH+ANh7St+NJnFBtqNryEMU
 YoCAAjZvikVXMnhCkawDFCdQ2AzEAn7oXyrauH5LQq+DQROLtjjgZVQOY+r4xLs1Ih/3
 DlgjXfGAlYe9ww5yW44L0kQ+PgcBnTTu1uFrwCnLeF2VqhVERnUib0CVGa2EWc6KjbTt
 fUJqNs1yoe9Htxkwe/0gXUHm7O4tG4cga4j9WYg3LE8rDlSnfdsVdcwySfCqRP00A0t4
 IXxilMyxdXzNbymrU9SziFSlKRnvQgorw68Fd84VHLpvMVrQZTeHL6faXM/8SY1MsQrM
 1UDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTO/kWh34Su7w6TL4G+MtWlSJmjCfpRD/De8YyUUSyJQWkjA4oTTdWQcgdBA2uQUBPHoMMnLVBkSwL@nongnu.org
X-Gm-Message-State: AOJu0YxdsR459aylZtkri2YjxMUtr7iaK12uoNvt7cwo6z3CuuDc9w2F
 l+Ad5heZw17XtB8b5CDsC5kEG2RfIWR9xEpOfTV1Mrw8UlxJC6KLkNQ1MWf6xO0Z1p6o7d+Zebq
 e/QlvZsbRgHQGFYU+royK+tTTONSoqCjMrV/a/8tT0Sn5MrG4LnR5XMkscw==
X-Gm-Gg: AR+sD137C6AocHWszl79DiSXMX9QdP2CxEt06Dm38hPW7XhiL+w36LSRyPWzRjm+por
 dJ07vtIaB3anZR4za8bjqRESjqpK7D3I622X4i7Qi9cvSiKCjDGty625lOZqCbYzti+rsXMG0T7
 sc/EodHCemmtw4EWj4ZgVfJq1AbZgODZVyLeWXQw84FVv12i0tsJg1QhcGTzCWS2QgGxAl4Feug
 qc/wFhnw34CalS0thb/KSsl/r/L9ClDrEb7MyhvKjpshZe5qmOVe5w4hliHdl24UnKSFBz9g/vY
 1QJEZyf//cNUMQzB/2aude30A+oafThmL9AEZ4BGoMdYk1jQPcq+FvIKtYGR+7j/nL3gk5UklSG
 4ag+b1pg6R+BHoJ/1nb8AzZNFf6ZHs89yjjsyh3pWPWKfhAXzGQM=
X-Received: by 2002:ac8:7dc9:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-529d6ffca4emr9867111cf.28.1785224214430; 
 Tue, 28 Jul 2026 00:36:54 -0700 (PDT)
X-Received: by 2002:ac8:7dc9:0:b0:51c:e14:87a7 with SMTP id
 d75a77b69052e-529d6ffca4emr9866751cf.28.1785224213871; 
 Tue, 28 Jul 2026 00:36:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c338fsm56945885e9.8.2026.07.28.00.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:36:53 -0700 (PDT)
Message-ID: <1c5b223c-301b-419a-a686-0170ce3fddd0@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 09:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 050/103] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-51-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728044248.137626-51-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfX50aTEk69JNO5
 5uMs5Mbdb+aX6I4aOLyRnsTbA+IyGM1vXrMduVHhgcnyBXe4TWcoorXIChMLWS6O4nytZG551hV
 KF2uemS5qTtNBsYG9N99myiy98RoxOooaBfYPQ/vwYlVKG7RWNj3FZDW01lc2kiQi5q8PyHgFin
 Wt2+mcP0F5xXKuqG//2j1NgojYw062ZdGHRfefidh9S4ePON3XLJz8GQ49ofEwE9lz9B5y/AF2i
 zCQDEBdOEemRLL42rOulKd+urj9vokf2Yy+Njkya9gM10ZOfoIpz6o/jOj+RljLxroz/94GEtvK
 NUv/+SzNZ5f0HjITE3sQ3qM6Be5rhQ2xU5Xlwwtsvfh7EEvC29p76xe+Gd4j0MJUNA9rmxUAWr5
 FYaWjIuWj2i08jkFkv2xzrBE/jNCxuNTQIERhCyEpu6IKIjUq3L83p/ejDOMxEjjWu1qwCZI019
 usTVmKhyfhEsEMCQ/2g==
X-Proofpoint-ORIG-GUID: njVlhKLhuWh-2OZNGz-r9P-RSXFqZOAg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfX02hBrQtMto5W
 NZlrApTz0rowpkaoCgfD8l9gsChzYi1xQSCmnTTCim1tUcxJh6IBKqxwjjY+GDPGGVLhoQQse3A
 olwXvY75wlNbF7l3qI9d4xll/fsHBDw=
X-Proofpoint-GUID: njVlhKLhuWh-2OZNGz-r9P-RSXFqZOAg
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a685c17 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JV1jFzSIkSeHzW4z598A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280064
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

On 28/7/26 06:41, Pierrick Bouvier wrote:
> All big endian targets were returning a wrong value due to this.
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/multiarch/sha1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
> index 0081bd76577..6cebad2951d 100644
> --- a/tests/tcg/multiarch/sha1.c
> +++ b/tests/tcg/multiarch/sha1.c
> @@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], SHA1_CTX* context);
>   
>   /* blk0() and blk() perform the initial expand. */
>   /* I got the idea of expanding during the round function from SSLeay */
> -#if BYTE_ORDER == LITTLE_ENDIAN
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>   #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
>       |(rol(block->l[i],8)&0x00FF00FF))
> -#elif BYTE_ORDER == BIG_ENDIAN
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>   #define blk0(i) block->l[i]
>   #else
>   #error "Endianness not defined!"

Orthogonal but what about tests/tcg/multiarch/sigbus.c?

