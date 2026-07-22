Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE82C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmYpj-0003pU-Tg; Wed, 22 Jul 2026 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmYpi-0003p2-Db
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:26:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmYpg-0003hQ-G7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 11:26:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWSbJ765311
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z0ZYzJzQwIdwp2lAcZZ7wcu30tRltzPhg3ehR2ipWXk=; b=LRe5RmlPQdY8k4F4
 2uSmqMwwoH4RmiCiCAtaQYF7h+HFlXC9I7qGvwiJsFqKFu7oM9D+YLqjZa920YOn
 wVFFNeka8Hr7NzjdX3D3n01CnRFs/30NqpaT/uv06KtPL6gt1F0U7P4hzZPgXF0i
 PJPq/TwUxDmReHKqhHrsnXwZG4bGaQ7+/jRP0rtsQnfnCjgrArdA4aqYO4cQ/B3w
 mvwpY2PliiObvTbHlM7mbOTE5FmmpDW+thwzDnaH8dx+60RnzHgqVcgGh2gFstrD
 luFI9crpM3npJ+DSFV1stmF3RAUhNK+/w/lKl3ZxNnjwy66fyRShBd5DWxty34ky
 QEESfA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2sp2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 15:26:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-522de3c645dso117086811cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784733962; x=1785338762; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z0ZYzJzQwIdwp2lAcZZ7wcu30tRltzPhg3ehR2ipWXk=;
 b=AdVgXAXe+HvZWbOqLGtkdaRDaVlzC0heEU64wWxRtaI7Y0L9ABhbir1GudQyqJ04tf
 ynSsevxIcs1UF/CMrIbCisK9Vqhosea+VnZFUs1icXClhThCKTCPoYoftYVebrkrgd2c
 F+NHoKJkYpzDe/KvtRxiwt/azUb/Kxj9E1JVbvM6Ln0oe2STCDk+Rm+0qmdgiNCoDoVq
 Vi4W9umimNRXUsf8neuwnL/FWMKRE580F97O4pvyShf5OrThkiH8rErnh8bie4aRY1gw
 tH2eSj4SH7E5bxBDcDjeSkmlu09hyCDMULZzG5Po5VXhia6JHdScQtvA5SzbZe3ZpMAT
 9XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733962; x=1785338762;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z0ZYzJzQwIdwp2lAcZZ7wcu30tRltzPhg3ehR2ipWXk=;
 b=srdyJBDzX5Yi00AZLl7XIu3OeZlTPUimtJXA970ZdqEg9kmFjs7dO2Pf94wgj2KkaZ
 9nJs6gya8c+vKuhMz0b/XShRHKTJaA57xg1qtosQBi0JQ+H3wPV2h8NQ8ctRTqGVwHFS
 Tah0EdAu/FUyYvbQo/bkFJTx5B4wLxWWlpY7jqzitMq7692DLcfO14xTFx4eLCDGCPxp
 4R9/G0ubt9e4fKrtiQkUAjaF7DraFa65JZR+gxnACl56tzmdJHTN2B40stcxVzKaSbN3
 me5aXdezx10e2x334VOR+wAQHv8YdXHpvQFxwxypWJQsNmiCUOSUVDdKNIHQ2pJNH04V
 CeZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrj2et511elB+sdhKxFgU/zDZA+R7Ch5ReB9kuqcvUPrUCnnLxfxhXrVOs3QRlfqLp9bPb8W+upY17P@nongnu.org
X-Gm-Message-State: AOJu0YysmhlBvff4Mdvu+m4vQC+Mkwj2KwZ0IbQ+Wc58R+eLmlbRXmki
 QLnTMW6C0vd9q/Ln9As9K5wys4sEJO/zDjmuB16yukSdwGDmAA/ULaM1YzJv+8BfViA/op72Ceb
 FLn8UEPKIvhw3xGzzb4H1JOW5Qs0zEJ+5fxrv7/dto1TgVM37ilBuWCcK/g==
X-Gm-Gg: AR+sD10RYKJNYZFkC6pbBSAPOz15NwqjWmPeAMNp+bCYwj1de4SfdXV7MhBGa1shdAe
 M3y71cFvMKBcIuWc2xeGwLb5RV410W3nO/g0emF56JaCXW0wyWUgaks76/h2rQomIUdguky7xPq
 wGeNJcgA221LGaWS2w5j+zA3qSGGD0Hl+CX2tS51wWP6iyBLupJGsz9QFVVtAaWTzMAlfbutTWx
 EeunBuYiAyJI59z65K7h5YYPuZMBZjSHwCMAJhoENeU1Fr0cBtuRbojBK2IQo5xnOyuTJWG8KJo
 E/SDOl7Ec06JALRS03rVD92UvG86+gyqkS5vjjCFpFh7z/a4blwlCjYiPFSLWVyqZUal93FqREj
 2DKxTw2MoHvimjg7Qfwf1baEF8mBVs7yd5AJoHkB9+B5nZW90Jpc=
X-Received: by 2002:a05:622a:54c:b0:51c:404:af7a with SMTP id
 d75a77b69052e-5213ad609fdmr231913601cf.31.1784733961871; 
 Wed, 22 Jul 2026 08:26:01 -0700 (PDT)
X-Received: by 2002:a05:622a:54c:b0:51c:404:af7a with SMTP id
 d75a77b69052e-5213ad609fdmr231913251cf.31.1784733961480; 
 Wed, 22 Jul 2026 08:26:01 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm6575210f8f.19.2026.07.22.08.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 08:26:00 -0700 (PDT)
Message-ID: <a57273c5-410a-4c9e-bbe7-938f3defe9be@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 17:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/m25p80: Perform a size check before erase
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, alistair@alistair23.me,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260722151503.491139-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722151503.491139-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1MSBTYWx0ZWRfX4hz6Tz6dr8bl
 Qs0KKKd7TdJ9jAwf2ytsK4/Uy/Y//r9sUzT95rzVdmvjIjF1SlAtZMTSW/hqc4wvuLduB/wHD6/
 HdARxODBaGwfhhzarIWjGSdQMNzUSK4SMhnnFH/Z6rN/LnQNYJ5ixp+bi1FkxrabBF5zEamMIMH
 bceBFvspNlwcA1IVhvXSCICyvVRgSPy3i5kKVNstI0M+hvpQNVVDssDVzVkA71+lizOjXFvTWHP
 REFZR33WUUhOg3nTVcnJiW3hBUZ3CEVYYD1As1CKlxVr/y+hroDpm0Ip6ixXmRiULS4bMGrQPYF
 sIpPGwi4ugk9rBDbpAzIuMeTKE8iKXUDlQk41Y0ww2CmJXXWqAbIGmqFvkWIcLol0EAEGnBdwOY
 lIEx+4l+EykuOWrydqv7m94r4X7iXvlIUoqYTxuvLH0+0DbzyMoAX8DVUD9kAydCupGeLVVjhMl
 4/KjByi/aT3VUitvsMw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1MSBTYWx0ZWRfXxDS+RF+enBFZ
 Hr5H7mqZPig/Qph/qKZsP9cwBehCjwo2Camx5sq+aHHKzDnWYD7fUvN06bdRT15po5WCw1bJUe2
 cRsy5k8CbPpsBPg2idqxA4uVtoqrcds=
X-Proofpoint-GUID: VeLDxtbZKWb-N6t-spkOdqyX4m3o41cg
X-Proofpoint-ORIG-GUID: VeLDxtbZKWb-N6t-spkOdqyX4m3o41cg
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60e10a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=JF9118EUAAAA:8 a=kMUSBSKEocR0aOJ7gLgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220151
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

Hi Alistair,

On 22/7/26 17:15, Alistair Francis wrote:
> It seems like the erase operation can write off the end of the storage,
> so let's add a size guard to make sure we don't do that.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4049
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/block/m25p80.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 545e0b5728..54eb12ebbe 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -648,6 +648,13 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>           qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write protect!\n");
>           return;
>       }
> +
> +    if (offset + len >= s->size) {

Should this be "offset + len > s->size"?

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "M25P80: erase operation overflowing storage size!\n");
> +        return;
> +    }
> +
>       memset(s->storage + offset, 0xff, len);
>       flash_sync_area(s, offset, len);
>   }


