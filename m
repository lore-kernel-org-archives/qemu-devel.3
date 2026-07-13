Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B35C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEmS-00061B-Cf; Mon, 13 Jul 2026 07:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEmQ-000613-KY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:24:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEmO-0008QJ-Bn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:24:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9M1IS1090406
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=; b=PwLm4/Ro/AC9Tuc3
 0BUB2GXzAuhaeIOibPLWrwzqsotbqoExj1cGGurRnHw2Zul/i/PhwiT9yyVVfWdP
 LW5uhUpz298Xp0fsBwrcAM5hM4OnRG9ZMSPwUrcXvtgW7qvixHNwwS+AmH4zVLzy
 IE36LohwLOm91nqsNpn3MurMpGZWaASeYu3e5cDUMiA4LNoj5KWB2Tt9iEUo1AVe
 7ZgsfGhQMvytWklcQbL/3G20A5QO4WKG0tWoZQSCXwM4h/QEt/oW3ZqGGnW0e2I5
 Gw/gnYjtwD1UX6sJKTjZRSymgdE2tXxZ7wum+h1swRDoVzyvlEWYd/T+H0qG5hH6
 F2MW2w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrdw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:24:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e934385db1so53095606d6.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783941893; x=1784546693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=;
 b=QFW9zeUHaSO27CjLR++YoB/l5e2qwFMYwvrYeNK4kFCFPxskzuVRmjhA7Dee3gi2G/
 2pqNhFT0AMd9CR6HNqqFHEv7LENYXdkTsWjnpRFnVijmFjHJg2tZ6OmeJKuDG7TSlpDw
 zLw6po1ev240fWWTi7aWf0ScO0asaSadGfTQhqNFdvNnckZCInAcis93Bsz2kdM/hBWS
 CHWVihIDXnr2Yknpl6Pxf+MeP5SFDhv3F09fywMCGlJaYrImIXA8MKQLNKTVPj69PnXs
 7v9xumfmKtXQ1n/aoD2emf83TGBmsH90o4hchwVYJTukkD7wDC+ogEpnOBJMFJ39FPWW
 Lr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941893; x=1784546693;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ViudphPM4M9hOR2212tvUxyZaHkBoXeiNCNvSY/bh6g=;
 b=UJIHVMCpNkOGKO3S0/bsWBjT2MubD8uJgzfpMxrrchthOm9708pzaE7FjaR7F6MUZ4
 OLOLZarNwynC42l/6M0Hxb9J0pg7pTNUBYoPpRcwkIbe1+kvo8mho0+V7zO6VwNcPPtg
 8NyeiP0gjGCRg6tgxOhX+mOviZ/fM474kWe+2yHRsE0DuvCFX6RM1/4Jp2h1suuZacFD
 vFKRnMxdFRwBbB3cK6xM6vyde488KwE/a2lx+n846kXqWXpFfEt0D+JlP33S4WRIG3wM
 B0CnR/0fjG6ioYUB+ccpW7dz87JQw1iERdVVYpZgsBhnYdnoke6qOZphCtxrv8bZv+dt
 QIcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVIiYILIMyiHLywwAufO2QvyJoRMRiV61kCpPtVL8auSLFDzPcfI8iw2vfeoM+dOI/EQrm1bneVpBn@nongnu.org
X-Gm-Message-State: AOJu0YzSm/iAcQapqz0PzFBwjRwXwKt7LVW1SHro9X0y3GFL9hRyXVX/
 QRMw2I9Dn1UjDVQem1Wu9cn7U0lQ1O+C26ZDdVfW7ZS/L7/33AqBagZK1I4D0W69SRhEpjEAcrI
 GFFJc2YAv5TOnPkENW0yy+4aVzULli2JL0OvB4DbuDsBf5MGS6SZviEa6sQ==
X-Gm-Gg: AfdE7cnIN2LVE+M1VeCLCS2o5MeXaYN4yPeRbf9fvnPYWroSQul87kpZDuhgJNgrzLZ
 M4XseKN+KLJ21XYdLf0+i6nN7yDq1KAu0LSYsXnMztVqQpY/TrxQ3h/jnH++7i38LtmHLBr6Bxb
 MIZqqlgtkoXnfIdl00iDedyDoh4aIOJCRtW1uq0Dijy8TkfoUd7MEMC86WnkGgy7smwaStRQjr3
 2rkXVkXi2DF0MRSrd8S94WYgCrH6qk952py1W2k0CrNPLyvPu3ZfJCkrPgBw8FKcDXPEPhCEzyV
 716NZOArvmg2rANkDe+2xfn8wcSbprzHqW2pRYwpnSZXHcDb18dG51ee7AzqN84p9WPRLXhyFru
 srppmO8Hs96R2ziEGjazU43pTVKrv9PuAFQ8Sa7IHgH2rzlKCmxSdb4HMkoItXQ==
X-Received: by 2002:ac8:5f89:0:b0:51c:241f:a6ef with SMTP id
 d75a77b69052e-51cbf30be71mr88277931cf.70.1783941893278; 
 Mon, 13 Jul 2026 04:24:53 -0700 (PDT)
X-Received: by 2002:ac8:5f89:0:b0:51c:241f:a6ef with SMTP id
 d75a77b69052e-51cbf30be71mr88277701cf.70.1783941892828; 
 Mon, 13 Jul 2026 04:24:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm548705105e9.10.2026.07.13.04.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:24:52 -0700 (PDT)
Message-ID: <889c5e27-8597-4d0c-9627-448bb5b6d51f@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l7ZVuZvHxPAKDQGWA-IfuIqVfuEapLU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX08AEHOdLro44
 AouteMttCHbTUjkvXo9jNvV6qUNKadKR8aj6cgZ4XUivxFSUS6J97ZkHxyyTE5LkH+ZjOSICM7I
 jeND/Qpzb4Ulrbiv2tIbrQO6TjbYpT0AcuBv9sq9BrHIdeH/V2kGPbk4HxNHTXVd/uxqhnlXOqk
 vstqxhUD/P3ordwLdboJxyGn+a5SEMtBTvla4va5QlBCT/JIKG2y2IqW4hPq32KNi8pjmjElVza
 3NN+JGLRihWi9suM+Om9DqUA51DFrKUCLcd1gCeqaRErHWm+8JtU/bgeP/asX7qxYJ6B2nK6H8l
 qifSbawGx2eArixmMHRJMZu4QUj6fbJ7COzYYeFrB2ilH4z78nOMgZQE3aI+A0Jbo54HQew+nr/
 FPXxRkdZ74YU8hR98lb90uVc7U4mG10y2sW5FcQiJt0VBMsk6wW+lzCdlfU6R2I9dkzI2sLwa8G
 fTc2uhxJOw2KMNDgk2Q==
X-Proofpoint-ORIG-GUID: l7ZVuZvHxPAKDQGWA-IfuIqVfuEapLU2
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54cb06 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=JmANKVZToQFHMbjcn94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX+GQKIgXUN9SY
 qa7pQg50/f2J44r0imn6ST+4DScAjxtCIC2msOejPhCGjMYlQORsEE+EnW5AKnt0xUr95fvxES/
 YZ5FKzvrLnRd/iYsambmlVlKcfNNtTw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119
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

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
> as dirty when refreshing a lossy tile. When the display height is not
> a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT = 2160), the bottom
> tile is partial -- the last tile at y=2112 has only 48 valid rows.
> The unclamped loop writes to vs->dirty[2160..2175], past the end of
> the VNC_MAX_HEIGHT-sized array.
> 
> Clamp the row count to the actual surface height so partial bottom
> tiles only mark valid dirty bitmap entries.
> 
> Fixes: CVE-2026-48002
> Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index b2b69923b75..559d3954b87 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3004,10 +3004,18 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
>       int sty = y / VNC_STAT_RECT;
>       int stx = x / VNC_STAT_RECT;
>       int has_dirty = 0;
> +    int height = MIN(pixman_image_get_height(vd->guest.fb),
> +                     pixman_image_get_height(vd->server));

This could deserve some helper, anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +    int rows;
>   
>       y = QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
>       x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
>   
> +    rows = MIN(VNC_STAT_RECT, height - y);
> +    if (rows <= 0) {
> +        return 0;
> +    }


