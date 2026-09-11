Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F5EC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52DQ-0005wU-5S; Fri, 11 Sep 2026 10:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x52Cl-0005mb-R6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:26:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x52Cj-0005b6-Ua
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:26:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCiYEC3505473
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 14:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rPJ4UXaG/TCGGikDQau9VeUk6K75f35QxLYdIXu38vw=; b=NS2Zr0C2Q1iLqsWY
 rUBEbBt+tQ+mSEGCmuzJEd7uohAyEdJKctFhoXMzBcOMdiN6TLaK5G3JHphp7hax
 6b3RLqG7eDswGXy6MN5snGarwBKA/IAepBYW/O9wkRmXdznsDS080JzHV1ycnkKs
 NPPCKNbTcuHBs++NKwCZbBDw+66vnDHCOpNfu5X9lUnGZo/T+nO3OPfZ100zjXwn
 Ip1HPKaxk/ovfAzuk1nXqKNeJ+8jwgAk0x7V4JKxXF7G++TaGPf5sppOuvh2SjYz
 s0ceROybxHZGdaXs7dtu1vB4L94uc3uSIlKuOzurylRTxvFT+IZNDvnVmslH8oGk
 ALZPHg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfhwaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 14:26:10 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6b1afdfb685so786277eaf.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789136770; cv=none;
 d=google.com; s=arc-20260327;
 b=f49ruJqiWUiNwww0W0z+WtITRDhSSo00S43LF1SwCsbkdVw7o9Q2dKMsKh7S2sTgbX
 ryOUnqOpc5IGnniOuhHjiZlgJUjzNoiLbbW2uyhTOdrrNcSumuYv3lhrFup59l5T+Nk5
 66gxlcPRiOMl0KTgVPsjqiGxIKpI+oXepYyKjDzBVtuad1vCsYASuKoU6r8RtvmJi57r
 /eZecxg5TebAd4KMpM5+eUd8VprZt0uM7oQ37wUFbcVY41eCAEG6Vz0HzvxexfP3D9A0
 GCAB5R5+Wh1ctr8IRyP1I+03EG2i1WzLXUOYzrv48z44G7X1ErQ8a1UbSn4VFITRuW+Q
 Jp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rPJ4UXaG/TCGGikDQau9VeUk6K75f35QxLYdIXu38vw=;
 fh=uKfw/aTr54ViMc4JemaZWU8rXWScmtNvEvZW3Qmnv1A=;
 b=Ch7Tzr1HUb7hP3ZdZDWurphwa6CMy1bgesZtWVsDZt+7j/glZaewudpP49rYPegJME
 k9iw8vTaeynHMbqRT+Iv73jZTJ6a0b0Qn/6YcdjUNEPARZmSqQ/PPjFtNtJt7joTIOrD
 k8tRTs2q0FEhj5A8rn6lr6hHj1pKKBu1243shpBYSE6FZssbdP+f1VzLCAc9jTV69c4z
 eSHOeyu/z6IfjDqLJfXNRnqkd6kKTZKtn6H54qC5Ni/73jHtrDM7c0dvdTbKh/xvvivc
 jeAKXJJQKBp4Jntbmoy//LmsOxbgVyq3aAGsgrsz/AtpXWsBn8WWUnHZJOC+bOc3+4t4
 rnjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789136770; x=1789741570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rPJ4UXaG/TCGGikDQau9VeUk6K75f35QxLYdIXu38vw=;
 b=Jmw1HMPz0O1RAcwINV5hv1Zflp0+dGYMU2NPk/2txnBI3jNao3rTv1cE6LZ0OF8Qwv
 w5U5RZ+ojYUx+yq/LyLKeRqoPKdR4KFrwlCr4np6fNdrFVo2a37ykEYCqw8dcgwWIkQn
 2PpbRU29E+gg7tvT7pt8jXe7Wjf9nfNszxjTLamZfMRxnnrZlq7iebJnIUnRLMsYuwd0
 YmBe0MAe8KCpmgZFq7BguAJLeaydERdshIbYJvsDufSBXTCapj59FVeInYM0jrjnedWM
 wn0Bf56DDGICtRAfpiSLcER0eAtXkmTA1K1A+L/srRfnK5g1SQM/w5FaXOp1/DCWbD+h
 Bl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136770; x=1789741570;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rPJ4UXaG/TCGGikDQau9VeUk6K75f35QxLYdIXu38vw=;
 b=f4KaMbbf4XPjCf1BNvJRooKC58DsjGWFg/PUhN8rua58Ls3RDDb6U/HyFNIx4iVfBN
 wD87+ijN1e6i7EUq1R39+drrURj+/F/XxYEu6ZAUGcFHoqsgCbDXu0JG9orjV/JuvXAL
 CAmJzJctIU7K4aerVN7kPKfg3uKUyjSM72PZ2wiMjKte2swNULDMYCkQypIMLZBGwTGL
 Vu/uDXY0W62f5as8GE/O5Zsx9VfOkNI3QbsD73Cfgvtq7hAz/BEbVWnEIxJcXggVrPnB
 /8LLNjwNqNtfqkEeuci0V7W0YDJ+hJ1QxFZtrwhzyZzspCZHGvIhzdyS3kPRt2F6P7a7
 F+Mg==
X-Gm-Message-State: AFuF++mjXlO5v8IfJoMSImUpcfWgklm78UqrxZ0FNqs5/T87O0kwTPYR
 qD+i8Grg0e0jC26NRGhU2j7IXkwEh/PrCDU089UgLBEt48S6E7Hvu8TU7wTPkLoIi+FxRKsc2AC
 RKHun/i3K9IjS8cHzEWFECeTgOyhnai+7myuQKcR4VTTeurXG/li1NveI43IDrx7Kf2aaKo3v9r
 bKO/tnyUW+srzrokarmssLnGOlrw5Dp+8M
X-Gm-Gg: AYBFou3DyQIRK903S8NkgP7gz1/qn8PLPJ49lcCfWmdqUpAy0fjr8CAFv92Y/xktOFx
 e7Ds3/NjYfkOZAe1YcnQtCz1JN6fQd5Hh+h/R5QoMafYDQsAsdeISBDEOepvkdLnEnBSIN1u2kX
 fbI0efSKPZCLS/exR5gBVOk+2GjRWuq9ydyTh/rwTD0vaaKxfdz2ab6qkT9Q==
X-Received: by 2002:a05:6820:16a1:b0:6c1:177:c7b1 with SMTP id
 006d021491bc7-6c10177cd2bmr2457061eaf.62.1789136769673; 
 Fri, 11 Sep 2026 07:26:09 -0700 (PDT)
X-Received: by 2002:a05:6820:16a1:b0:6c1:177:c7b1 with SMTP id
 006d021491bc7-6c10177cd2bmr2457029eaf.62.1789136769227; Fri, 11 Sep 2026
 07:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260911140645.56094-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260911140645.56094-1-marcandre.lureau@redhat.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 09:25:52 -0500
X-Gm-Features: AcwNN1V4iRal1eTb02Zq6L4f_S1LUh_N6z0jo9tiScnjqfA9pznmeW-euf4WKzM
Message-ID: <CAEqNhNYuyodX0kJOcLZE_s53ikH5Ym9wmGpc8UYGYTORR178Vg@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-virgl: guard new_blob with
 VIRGL_VERSION_MAJORS>=1
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMiBTYWx0ZWRfX66Z1n65zRBN2
 4f8mX1wBQ3plMx37PR0Xz8xmnMdX1ePrr+SeSwij6bL6zwxV5414sS0Z8S/wJaiBlMxoPGo8PKy
 7288n5tZoMYjxXrMV844xbMXwYcWh/AJNoJa/J793eUPfznzJeSACNYTKTc0pP9/Ivugiulg+Rh
 0HemPACoAu7KHxeJC4fwEmEFgggcODSU3N09zELAowY0tdHRM5uq6g94gJrNFgpAQyARpOOzied
 Q7hXtLf7qIbZb8joJ7RLChPEeMLNdHsENp1seQ/MboNQZl+Rd+LdPZP8ZvE6hM5QftrUHGlguwO
 tGMiKZwdggGumlG63RERkBg/b+eDwzyx1jRLAwfCZPeeHwqaZ2YfEaXAVtVuBJZIOmKUgYPpeDP
 AoZcg+WwxvWB0qRXKbH1Lg4lPpZuZD8YEVqTdBjSYzsMw08sjWDSxRCYo5DNvZu9tYsCA3ar8rg
 qNx1LXHiNu6AXDeL+Mw==
X-Proofpoint-GUID: _fiMJXX7MDM-BGOlUJTjXJcLSSmB2fPw
X-Proofpoint-ORIG-GUID: _fiMJXX7MDM-BGOlUJTjXJcLSSmB2fPw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMiBTYWx0ZWRfX/TG7whVgxT2V
 7D0YI0Ott2i17QXM1b3iJlfW7YU/gYq0lBuUJhAyI7vSsJ7YcVEkuUKDu67PeTXgmsLBtsYRhVS
 clbvt4fHzjibOJSbofIdC3T3ptlzkGk=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa40f82 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=6G3tjBsMHsZMpl1mHSYA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110202
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, Sep 11, 2026 at 9:07=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> virtio_gpu_virgl_resource_new_blob() is only called from
> virgl_cmd_resource_create_blob(), which is guarded by
> VIRGL_VERSION_MAJOR >=3D 1.
>
> Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce virtio_gpu_{simple=
,virgl}_resource_new()")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  hw/display/virtio-gpu-virgl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 1c9380e2a6d2..f45571060fea 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t resource_id, u=
int32_t width,
>      return res;
>  }
>
> +#if VIRGL_VERSION_MAJOR >=3D 1
>  static struct virtio_gpu_virgl_resource *
>  virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_s=
ize)
>  {
> @@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t resource_=
id, uint64_t blob_size)
>
>      return res;
>  }
> +#endif
>
>  static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                           struct virtio_gpu_ctrl_command =
*cmd)
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

