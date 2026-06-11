Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E053ECD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXlIl-00051p-3b; Thu, 11 Jun 2026 15:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlIk-000518-46
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:42:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlIi-0007sL-4p
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:42:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJ3VjG1389429
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TvylKnl8g91nEdStL4aCH+mwsBpLvFowEhkt4nU/E0E=; b=UXDl0FmKGNeZpgf1
 u99IfEB4vpImLbQ77iNKbBYUtv+ST0NeA6AiERjAT2DNk/zaVQ6nJzoWvMv4HT0i
 3lIC/vKMs4jEpkmLFkN4pfnEdrcdn9KBZg3qN3biz+PxiEhAnB851FWVOOysRroX
 DqCpfA//3vOMrkTWc4jYadSQHxkeoelpjY/3Bb1x/pMUOpaehZYa3qmooooWdxCO
 a4rLtfT7bLjlxRhfCBMyVJivEa9cdwUxONLvbDbWNkL/kPK0ZaN+OGiCEzQeZlMB
 Xfo7q2aC3e0ONBDQF5bYY04ZRXUwqZ0zKC73z2THIHxs1A6ILWVZkkewMIPYNk6g
 9prcLA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1658nx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:42:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so6240716d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781206969; x=1781811769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TvylKnl8g91nEdStL4aCH+mwsBpLvFowEhkt4nU/E0E=;
 b=CBlkxE1Z613Uezp5xknhH6YqVlT0GbXQT+EX5Hl6mCqO9IgZJUA2owwDxmqt7Zq5qO
 OG66tDk+nE0nlPT/fcWtDJq6QJ8pSOcwK41lo19IZCv5IzVHbLOqLdoRbyuFfv1yI7xM
 ih+XF00rvRXDiTujozCGLje3fD0IzHcyeQ60eP1918ttCh/CIkuKgxkJPRpf7NgXEDri
 biNe+cHiWZiZxFcPsRvgO3ZvU76lNGM9ldwbAgBIcWtJwPrPLdQZsbRcdxjooRavfQ69
 pKYJY4x1WU0mHlMF4xSU1D8Zw5pJWMqZaTDMMzC+ueDhW3wUKzj1gAZfFN0AwAYZC2co
 CpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781206969; x=1781811769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TvylKnl8g91nEdStL4aCH+mwsBpLvFowEhkt4nU/E0E=;
 b=GKFnE/4rbOr/mGQvunQdfYR7WJun2phSiQpDscORIYx4mhKOAjZkkEsiF+K962iQcF
 Z/u435XksBKu+UlXJTknJ2EWxzTT/16fPY9Yxqy3OLH4oShwpxie25ijVhn35BDZy1Nm
 HBIwmn7Bmw0KmiE6bu5HCUslwzMLoR1VEtHi0ufrE0g3DliR5mKr/ZFkw3LoSfH074kL
 75gFO+g5NnelOAzQs4EriH53SgZQp+lfnbGtqa4PV/KxxT0lGeBjpPZJdKe/+D2z+v9+
 Fe01mQyXmLxYFuaJA0wo5Z3A0aceSB+ehqz2wP2SWfuCIYG/S8DZm/ZhowuMaCPwW84d
 mQlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jAscXg/8w2uvHv8kg148lMevgqaMdnqoHct0i3jFSMRhPXymnWti8ZE57du9HmKvs5XN1dg1UffAY@nongnu.org
X-Gm-Message-State: AOJu0YyEt2GXfHkQvS8p+itjul2YqhAHOAAafBJttIY95raL024N+5HM
 Xn4Y37Orr47GPkbW19mfhpUPcQIwOf6LF6mAksMyJa1SbldNIj3+tKzNaZqy45iz23vNDbn+EDd
 7K4ieO1ouZvKb2FBujM6ZZI5m9XZ3s4Egp0zbu++fPeWSy6KVeK8eSKc1dQ==
X-Gm-Gg: Acq92OGVf87CXrm7V9FCZMoqWdxsm8mj6Nc+o6gCS+/lnZHyr28QKgsXZ8wAmXuC9Ep
 PxitR5B1I03zxXkMzgvzSqubjCuXfpLn8DGvo2UnnWqqnOtQaui3/rpxlpNwuj5Bf980OLCWyuB
 kqtYANxXTf3gyIhdgH51Gs9hh7oRuWlxt3lBkEciiWSM/wBnBDA/FIEIIINpy49H/EDhEBEuBGP
 gp5S4VoWV2CiXTEpT8ix5wMi4Gd+NR8VyhL7weeOjEGp1BA0+yuUxl1VMcZjKNUwdbtewDGfsgB
 cvE8XXqINzxhuux3FWu8nPSJQgzfxN97G+CzFTWIcxuUy/OZPVGLbbMhhPdgcl0MnP7LTc/qrpR
 6Vyn8NGw/9MwXwfmYC6NHGLDTW7a9F/pPTCyH8h8Qtpr2q3OQaOF2CIK62H5tFnUYLVnjwlQT
X-Received: by 2002:ac8:7f83:0:b0:517:c65c:3dba with SMTP id
 d75a77b69052e-517ee1f07c9mr69215041cf.38.1781206968814; 
 Thu, 11 Jun 2026 12:42:48 -0700 (PDT)
X-Received: by 2002:ac8:7f83:0:b0:517:c65c:3dba with SMTP id
 d75a77b69052e-517ee1f07c9mr69214511cf.38.1781206968321; 
 Thu, 11 Jun 2026 12:42:48 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm7059225e9.0.2026.06.11.12.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 12:42:47 -0700 (PDT)
Message-ID: <1476df56-193b-4524-a51d-a175a0b45726@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 21:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/22] ui/vnc: switch LED handling to Notifier-based
 input API
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-19-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-19-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5NyBTYWx0ZWRfX9SMjQ+57BGQD
 hEc5v9EW7E9KHs5XfCAbVY4P3SQfljuSOC2gtn7U3F4vZysn56gLaArEKzPi4ch49BNB49msdt7
 +X1DRnJpkBFfGvykySlUtiBskhNA6NeLuDdYseYtppq1bk20NKyawusLxoSj3dgl/MiuH/gt+E2
 /3GZVSTtWbevxiN8CQz/xHkbJN1NDL9BYuUAy97gC/2gAwFg/Oy14yR2BV49XPQn7o2A2E16vK1
 eq2h1N9CgiXAN1fxvDatSv6iq1wpWUDSVg2T/WhTp+5JsgNd2vTEfRl9MHqHE+NXK2b3VQPTPuI
 eHXgAeQsH81phHN4s8UXAw+/sjfL9pCQ+QgGlOCUc/vmdfiUr+8rcghwP9KfLuUjEBrJ+PeGLyS
 OnePl973vVhj+2QNMiaE0alzFfKdacbgF9b25ynwgWP2Efa9GHmfqYghXcz2ov9Xr6TKDALoDCX
 JdRRT+IjbVe5je2aIMQ==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2b0fb9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=BqTtkzC31Y18jNUxu3YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: j2R7R9I_2NkNzGNaDM2nETVXRP6pOeEn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5NyBTYWx0ZWRfX2PB/NSWjefAJ
 zM85pFaOEd2fvlyTT0h5ffYqlNfO9QVEXk/krSrWW9TDBYH9KUEn7uobXg+QZ/4CmKRG23/b+lQ
 FiDyyv6inU4ndRqYCw4bG+m5aEL5JKU=
X-Proofpoint-GUID: j2R7R9I_2NkNzGNaDM2nETVXRP6pOeEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/6/26 12:57, Marc-André Lureau wrote:
> Replace QEMUPutLEDEntry with an embedded Notifier in VncDisplay.
> Use qemu_input_led_notifier_add/remove instead of the old
> qemu_add/remove_led_event_handler.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.h               |  2 +-
>   tools/qemu-vnc/input.c | 49 +++++++++++++++++--------------------------------
>   ui/vnc.c               | 11 ++++++-----
>   3 files changed, 24 insertions(+), 38 deletions(-)


> +int qemu_input_get_led(QemuConsole *con)

unsigned, const; otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   {
> -    if (!entry) {
> -        return;
> -    }
> -    QTAILQ_REMOVE(&led_handlers, entry, next);
> -    g_free(entry);
> +    return modifiers;
>   }


