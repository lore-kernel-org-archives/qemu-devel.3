Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83886C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAOqW-0005hg-7O; Sat, 26 Sep 2026 05:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOqU-0005hO-Kx
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:37:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOqT-0000S3-0d
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:37:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6PRAl110967
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wa+xw4J00ediGMqWyhfF1ERC+XJMDvuaPpV7wF4dcX4=; b=XlOWIwSnZC43V0+5
 HtqkGjWEdn8ltQnf8fklFtLhO1hngjahC6ENlPK8A9F3g8Kinh3sGxDu14THzxvj
 D0i1i32MFfb9TqKtVv/rC+EtD/dK/1aqdxSnRQNqOkm5/dxKwfmOECdcYZ0AxP0m
 fzLRcpGU4hFjvc70c+3JUIsyjGuI3mHEE5DGdvBfRInac1iHuo9lZsVKrm6B/sXw
 d5gxA3FTfZTcpRhwsyZkS7TZ+WYzJ2GASEnMgnq6qpHbkTqVxWcpaV9knfFxUnk2
 +ztU7dbkA7W6d0cMJ5sh1tNKWF1jwMEbI1mJD5xP6Decl0ZKlEq3vJu37Q4zKEAJ
 qDdH0g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50s8q5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:37:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93be1861d2dso270922885a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790415442; x=1791020242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wa+xw4J00ediGMqWyhfF1ERC+XJMDvuaPpV7wF4dcX4=;
 b=VrDoQ6WCUTLIHSXjzKkOmO8XlnD2dnke1e60RNtH/hi5v/aZkv3nZhrI8iLvnYMOzq
 zDnO6UmMmBqTbI0mxG+VBCHaWDR33/8DzCMBCtKRuvMLuOTKl0YqviwKGpQyb2/JNYhb
 QfmMugU9qn1YaaLk2g3B3R8+Q7jRSTMA55rJMoDjLI3/0z2b4+wqSeYEkdV7wr15npid
 zJY7qAp1y79ntuCDXgfxSkPMWgkIKIRB+FMY45UNuIO+GUXaqfTHP+MpWBMjIp1Z4/PE
 W2kOQwWzLF5TBNoP+IGmSXFtUbShdXlffGrDMQiS1iPQ7eeF2nc7oeS2qyc9cQYYf6Og
 pSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790415442; x=1791020242;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wa+xw4J00ediGMqWyhfF1ERC+XJMDvuaPpV7wF4dcX4=;
 b=mT6RKIjAAhz6ZlQG00RwCiwFlaZAHXmtMTyWY+DWY2ZHl+1+F+BY8z0wO4OycIOuqz
 lRzVtrId5nLZSOgLuae8Ma5pRg5Zxlyn4hoX72osBqthhmBJWMP7kUaN+EKP+4ZD3f+1
 eEb6vIFKtUQxJQva7DVJbjYWoGdG6Ylby6qI6h2/nTy86r7wnOoCVo8j8GacWuZj+4nq
 /R5DLbqC0k9Z+u3GbXv3MVSGL7g2dGcXnad+e2GqfuCwk3YMwQZgbBREUO8Jek5VMDdn
 56xxsdBSKBMTpBdK+F8pxWcZjZiD2+22qU6j+77/4yk82RT2/9VU2WuCz0bAyv7gyyWJ
 RoUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz46wMPaelzAuasLovu+2qiGGbYqZI6OtRnUu6ecT93Kh/jUZA1Cv1Gp0vmkbbM3tsOhfElJF2qJLlN@nongnu.org
X-Gm-Message-State: AFuF++mFkAye9ihnVFEn/wtJO4/g+Z6yBLUQmbBV2NVEalSPbOxjzlqw
 LgI8bBLw4Y2uz49a4QzJNLDTEJ/W6kw44ftLyMfLXNEOmisNVIYHNqAbo9DNwPrb31CxxIUnaA7
 AfaBfKQE1bd2kRHfY7pBDUke/2d061GGqx8GGlvPYYGZ1mrHLpNBQzM6a7w==
X-Gm-Gg: AYBFou0ZgHjIE2VoZQAnkb8rtJLZWgq5LBPTxJqAWtx7SWV+PAPHi0KRdai0yn5BJ0l
 mSbd4Bhqh2ps3DOmTJChiIo2gkF2zm3DRVxrBjRRi0J2FQ6e11rvjEMfMASYN5C8diHSjtGsOy7
 o2g51Ac/MXJaGog/O8+zJ+SM6vjTEwW9EUi1apxNG27xvaC0vpF4a+TkxT3kRrAW/cVoJh2zwxm
 Y1tDBMVdHb+iwvY2AZELlhb3i71ulx5q2o6/CV7bDlm69amu3vRNKTO1FTO6ASdQQqAVGohav6N
 KfoG6J5Zc4kUHUk2Vm+6B9x6iUYuLXAken7lth6sZDNTYpVGeGIOmKVP1fQre3H6ppvpkfmWduO
 POrwHIE7dXoC4BXfhi5svpz0RiNwCHQgFhA==
X-Received: by 2002:a05:620a:46aa:b0:93a:463:1296 with SMTP id
 af79cd13be357-93c43bc49d1mr875365085a.18.1790415441620; 
 Sat, 26 Sep 2026 02:37:21 -0700 (PDT)
X-Received: by 2002:a05:620a:46aa:b0:93a:463:1296 with SMTP id
 af79cd13be357-93c43bc49d1mr875363285a.18.1790415441163; 
 Sat, 26 Sep 2026 02:37:21 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0658747sm140579915e9.1.2026.09.26.02.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 02:37:20 -0700 (PDT)
Message-ID: <6390f7fb-8061-4dd7-9fee-9c2fcb222b17@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ide/macio.c: use pmac_ide_transfer_cb() for disk DMA read
 callback
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 den@openvz.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX0cCu5iVB4P8b
 hyJ4Hos0ZVLFGtqx6n1MmQ+Fwq0dMiyY2MqgccTeZD0sXJQupko/lhwmBrHGsOvfGKuy0peTClY
 +IDk5z9IlZX529ZPR8njcjrCv+w7fa8=
X-Proofpoint-ORIG-GUID: LgOqVm9zHGAYrflv9MyXx_vsUBg8vWG9
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab79252 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pcZqCyVeAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX6qbtOQmAzjpA
 4+ObAKTMovWxsTL6FtKzgA8KMFRnNSXK1sr4Gy1lrLsB+hMjhx9sV4aRjBv08HFR1H4yhnvhh8d
 mwfGlLHygdxmp454U/wXrsni8fYmimqXN655RwfnK8K6bkJhm2IZHBOjPGRn9pXwnNjP3XFGLzD
 2qC1iaTKrAA6B6MlvK7g0OH2fRn71C2Lj8HyNb9STR3QGwgNaXE5w+Tp4Xe0ZuaSLv+WH1xTx4L
 S0E3OC5TG3+0OhnKp8oTsYeNlPyuB72/nBfDTyR9MoG9YR4WB3Y6RXnYnf2wJvhavrGZzIVlTMG
 ABdc2qKMRU31MS89cw3m6uMVhELkl7ek2L5eG/cKHUqDYGHTHODDNZIwDtwcjTcqNEr7cZYNBLQ
 J8QiBewwoe6pBn137NcEtzBsXVktI4d8uwSbS8B3ka62+wxjUz5CMoVjZxVmyjS1RHBr5YhWQJe
 XUkZ87e0xcdx6zz6cyA==
X-Proofpoint-GUID: LgOqVm9zHGAYrflv9MyXx_vsUBg8vWG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260038
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

On 26/9/26 09:44, Mark Cave-Ayland wrote:
> Since its original implementation the disk DMA callback pmac_ide_transfer_cb()
> accidentally made use of the CDROM DMA read callback pmac_ide_atapi_transfer_cb()
> for disk DMA reads instead of itself.
> 
> Fixes: be1e343995e ("macio: switch over to new byte-aligned DMA helpers")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/macio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index 40fb4f3b4f3..a95e68083f4 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -180,7 +180,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
>       switch (s->dma_cmd) {
>       case IDE_DMA_READ:
>           s->bus->dma->aiocb = dma_blk_read(s->blk, &s->sg, offset, 0x1,
> -                                          pmac_ide_atapi_transfer_cb, io);
> +                                          pmac_ide_transfer_cb, io);

Copy/paste error?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


