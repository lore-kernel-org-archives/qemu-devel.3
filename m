Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E1606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hX2NUxEu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kgr/pwl6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMbiy-0003rd-1B; Thu, 29 Oct 2026 21:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbiu-0003rO-QF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:48:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbir-0001If-Me
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:48:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKjZf1579385
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Y4dmIN4hycdDKLHBBjtGcZdaWUQP7V8T+ezPlFx8uY=; b=hX2NUxEuk8HB09AF
 h8lMparAo5SGaQ0DjsOnmCiEXMp6rLk2SX7cnQgAudWY7Wscm7LgN1ZoOkkBMKTg
 C0Ab3YrCHZ2a+gk8e7+wlQRV+t9DXjvX5f9EcF50hPz5xiQqmR2LShigdK+fMK3O
 4d20riCA913OSpfN9P80J/3QJj+QiwkQ1yRBtvMMlYGioqgzoPczF1x50kdgCkVt
 6iDGYbGmF5V8F+ILLNetSTD8V/uz7sJnf6nKnNnRbMwoAGxqMkv/gq/eRb3bpkMu
 EMO4z+27ioD11yKfE0fSYhBMSNQQGFDTZRw5KEKWTG7vyquRoml5xknbKsMBOWxv
 qKVK7w==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgp67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:47:59 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4db3db8687fso393751b6e.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793324879; cv=none;
 d=google.com; s=arc-20260327;
 b=YMJ2BcHbmWpnFyt0dJWWSjomd9VIlxfISU+nLEOl9szrBiXdxLqox+Rj2QM6QH3Eno
 dVQ9J1/egTlCUpY6q5Zy9gWKj9vCBYt2x/5cxZ3jS+lO5a9HCBSMANrBy9D/BEbV/y5O
 KX7ceBYVYT7u7GlgXw0D2gLYipz/fMYJiQ4/6mkwH7yOQWeLDMGqNFlrmo8Zj3UExDPm
 TTjJ5SbweAlh3/2ti+gdm1yrl7MPs4L29OlAkNquxHU8Y5yC0iJ7kCduCiTNUU/v2rRG
 7kx86GSU54HM/aMEw2/y7XpIaJ8pjKW6sTin8bE+s04m0PgBFi7EK6yymYdRCWtCvWze
 ouWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Y4dmIN4hycdDKLHBBjtGcZdaWUQP7V8T+ezPlFx8uY=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=oeQyflCCDWr8psmk0XE8tCZvONhEA6booi8kNGWr8yXdIG5agx6w/U7qzasragnk/8
 w9/zIsHlhZ/Lvd1y1dEvkORpM/6BGZLarj7ohSWy8tiLWzxNIm8ZhD/Auk1YWczw0nUK
 OVIekzMxjni8iBYYULUq7IXCZILqpUhPw0cmlqSQHupXrf73+OfRVVLq5lN3/KteHOQD
 v0Eer5YaheuSAshlnkbo3SX4i41iDWPyVWUoE0BRqnCBa0N9LTSH8rIDU2zRF0njBKGW
 hYFrj8ZvVmgUE/bL8vDZnCihgpINX7Q3r2eC/OW9lvvge+9PbTyHLi3j+mNFP5LGv2fx
 38pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793324879; x=1793929679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Y4dmIN4hycdDKLHBBjtGcZdaWUQP7V8T+ezPlFx8uY=;
 b=Kgr/pwl6OM048Ikz34Uzqc7wTS2aTYGkUDxnQXfvyB1DLAqoK+W+1LtEwcm/heE2hN
 sx3s2F4UXI7J0Xzdk/+4iTFmlCNWg7HTekEWU/RHYs1VoVHPjJew4lZ4AAbQXDR3tySU
 JuQJgzkfrNvQjUzd4ADr1iLH6V7tT7ky95+N25uaf8T4VJs+2Hxqx7E60LXV5JVP7CnU
 7/Y7OAAKlVZ8HR6yOLTW551+do5eqlIUi3qIs0NirP9uV8yrCH3rnLXcBUdyJL+ta8rK
 mAWNNLHafP5kPY2CaSiEuMz2LP4fGNo3GO+Q23k8WIMbSJk6xb02IQPeyXNnuJ3D+Phj
 cQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793324879; x=1793929679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Y4dmIN4hycdDKLHBBjtGcZdaWUQP7V8T+ezPlFx8uY=;
 b=mP0fQPMysjPBjosSHR9xspwrnrAlpCPhxVlblDTY2QtagdDlLHtN8RzYIN6TevId8F
 lyro5SQgfQITyzPstfKHssdFHUOWh765Ou4iVcY7k8o8BvTr966SaHdBBTx9RPnh4BA9
 /I/qXYrWf9to3ez5ymWmZPtZF6TOnsJI9UgOX5BWAYnbAIcbMepkiPoYAm3ERAWVa2+s
 tbp68VtyzvvXbclNOeRD/2S27uUbvZ1WZy+Mcm1x9e/D5sQQxwar75zMEqfOi9jRhb4O
 7ApbfnufCPqyBUwM5YzcRU/rE2nLBVDXi+zrnCJCGiFyT9nnSTs42AZm3QIHFXS6PCc2
 wNFQ==
X-Gm-Message-State: AFq9FYJN8HZKBEwv8O5v9G18NzcR9G7HXmOS1qAjQarGKrYKVHZvqWNp
 uJ8gpMyKyBaArgLD4mMkoJ9YN18bDIXN18naHv3+fKhPSwAY5dIMO36Fm9UtdN+Oo4sPRkbrQHx
 TKCdfrANOBDe3UficJUwZH/97fW/dLNKaGgYfpnEDsWnKo9FombrccdMF38ApprY7HblMiBeRY8
 jtBkaxrhh6lmieAdd3QZvx9Zvfs7ah0QFq
X-Gm-Gg: AYBFou2rAgKFb9/X0Jr3nOy6UjXlZ8oqFc/U52lO70NfkuCLfcr4nMBzsloHYVBP0Zj
 93pW9zKBxsFG7gb7ua/ZLQF/SGZi+CrFmt9ROKAOv34+fV3tbC+9zPT6zAPUMPaE6f6rJRaoqMr
 alCrxCslmIKqOq/QUFjydpQjfayBGol7ikOPjhZ0oPxMddeLX8JhnWR0liKufjJHoZnqVafGLa5
 gZ613tRL4efHcvylTw=
X-Received: by 2002:a05:6808:10cf:b0:4f8:4a95:9b3b with SMTP id
 5614622812f47-5640df9396cmr728333b6e.68.1793324879036; 
 Thu, 29 Oct 2026 18:47:59 -0700 (PDT)
X-Received: by 2002:a05:6808:10cf:b0:4f8:4a95:9b3b with SMTP id
 5614622812f47-5640df9396cmr728328b6e.68.1793324878577; Thu, 29 Oct 2026
 18:47:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:47:47 -0500
X-Gm-Features: AclHuK9hUT4dyPt8qsj0DwyIjZmpf0c7GaTuYJ-ybT6C_3B3bONqPtdc--2IYyw
Message-ID: <CAJ+KCYP8FeOWd9ghCi-+vOB_=RRb3Tueo7n67pPRnpsNCJxPBA@mail.gmail.com>
Subject: Re: [PATCH 6/8] hw/hexagon: describe HMX in the device tree
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: afVPBAUebyqM_aZBusOau5WvqEibxf23
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwNiBTYWx0ZWRfX+qllv/E9sRZO
 Zj1o9CW61YAfKPBRU8NevpFXrFVujcO8vXbrmqD05xUqJy3NgZOC4VXMgjpF2wwFn7lz4I5lTos
 irIaqzEFEt9z3v3licWkq5z8iJ15WXY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwNiBTYWx0ZWRfX9JMVh1yAbB3Q
 HmaHogHw9yoxtZ7SaV+/0UiNfOsr/3rkvjD3QNnOsDhT/uNx/oRy4+WwiLPPWKlS1No3kc6WUxz
 ZXasxH/6COlu3Yvb6D4qanpDZtT9umWt7h+f4yIJG6XM3IsFuDBAMPTcZ612wVpQTi3/0KHEV8W
 kiLSwfLTjBEyGwaMTbar2FvPF4crRkU5qBXz9QxqfuS/8xPCI31d9qu1ZuiuHyJDpGY0L17hwhn
 gFJLgIpo137jGWAaKsK8pcBqPiMr104YV3VUUv4Y/ZAHPa0LSogRnrpDo1wF5kZ4uwhrIxl2ux4
 QCQch4sd1so7Qkq8XT7ULS05/f0HW6k+GWemA2sMilUJDRCcpuPpqW7Vf+5oTQmQRMy2zQhDaxs
 eiqlPR7CmG/Zh8b1q5XF2Z/U3pipEw7iRzaLic1LoU39P7rzrXeONkuhh64V3IpbwiehI/UZMQo
 evECvWegR5jQlJb6snQ==
X-Proofpoint-ORIG-GUID: afVPBAUebyqM_aZBusOau5WvqEibxf23
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae3f74f cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=uCBZdDBFx-Qh9TLS0TAA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300006
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add a /soc/hmx node for HMX units.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hex-board.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/hexagon/hex-board.c b/hw/hexagon/hex-board.c
> index 3bf09e4e7c7..f38c244bb2b 100644
> --- a/hw/hexagon/hex-board.c
> +++ b/hw/hexagon/hex-board.c
> @@ -106,6 +106,12 @@ void hex_board_fdt_add_hvx(MachineState *ms,
>          qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
>                                 t->hvx_vec_log_length);
>      }
> +
> +    if (HEXAGON_CFGTABLE_HAS_HMX(t)) {
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hmx");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hmx", "compatible",
> +                                "qcom,hexagon-hmx");
> +    }

Should HEXAGON_CFGTABLE_HAS_HMX check rev >=3D V75 too? As
it is right now using it will change machines older than V75 adding HMX.

