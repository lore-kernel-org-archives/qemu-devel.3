Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E17BCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEVa-0003e9-Ay; Thu, 01 Oct 2026 06:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCEVW-0003dh-M8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:59:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCEVU-0003ZP-Ct
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 06:59:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xnrW1661097
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 10:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LpFCNcSkvOvWBdMaXT5h2gNwq2rEZcgH5ZJCFraudCo=; b=XLbU4ZgULm136Jfv
 JbHHkcwcByPIa5/1LoXLtK3jT3dcskWd+wUALNmGCxwX6075LrR1phcWf3GQdmJr
 1Xxl8pptv3KT5voC/G4Q7HGgHIk7kiUgof0y7etl2rZZw2NQKHVC66i1DEZI35D9
 s4/BobezRHZhdKm890eU0crwfA9vKM8xC8pritUIx5Jw+xM2n1t+lKxPYcsRwGBL
 q4b75UDWae7qcgBrj6ch5ILDvCssqDsL65dj02Mfp2hntj+VCcV7ZXu3RdUp07tz
 Ana6UdLPKwPSI8XeIYfVPn+obesgbfu1N7EIXcahY+i+at1+TcpvB7mIlFhzgfl6
 Cet8fA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pm3r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:59:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so330294885a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790852356; x=1791457156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpFCNcSkvOvWBdMaXT5h2gNwq2rEZcgH5ZJCFraudCo=;
 b=SOtmVS8k2cGbZ0PRQU2QJPw994JsTjb2RdHYWN9pr/tA0CjCnvN00RR0V41MIUJl+h
 epvgqT5M2k3Dk5ifSvf3rPEOsvpRsgvp7BNBoQDmGciK6OLa35ATJyT7cZd52FM44odl
 9e+bmO6iT9bf09fuorarjPWGYeNQdPg1jx3GF1iDZdRi3YNOKbS1on+3yFUQ/RIzftra
 1oDyB0T/pz2sGudLlw8xMDeSNAUAaLD0VSpP/dKVvptpxM/cJCJPHNtMxeIIdMxvjxx+
 mR0PCZBSaJ9ZEi+CClXLHGkZqP17jYBnkTnvg3cFhAhyHmGeTzjn5tgwgrq4icP4q5dQ
 qPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790852356; x=1791457156;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpFCNcSkvOvWBdMaXT5h2gNwq2rEZcgH5ZJCFraudCo=;
 b=xfN2Jpt3hgsdGtHXSLPHEpsLATVLXdReE78vpL76XwPCJszKrT63m+Odk2YVqaSp/k
 VezFZ8BYYpmYk8ZxuSZ1Zl7HVgT1Z/rjay8slb0qqpJjULQKj4wlmv8R1U5Df0W8/SJ3
 6KykxSHQfq0GMnK9kVl3EgzQOPGtiB7t0wITrgsKRDatBy7MwL1m2jKyhWIXSsZ3a+oC
 6O/wTm8esd9WxBxOUtQE+SP+o6mN+91AdibQtsIhnaO1xjsIWeYx4zkqwziyfI5Llm9W
 pXBn8BSAOtmWi/8DQ7efrYP1JdIB+T00ncnvSpPGlvZHl2+ddLBR2yyfWa61rFdDtz+f
 ekKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByizANscG3Xm7dU012ZcM5ALgiXwy9WrbSckSTWrkzdGAoouB/7bBfC0L+EigOWuQbBFSOC1NFcg1OR@nongnu.org
X-Gm-Message-State: AFuF++lpc2XqstGgk/ksi6wC8bbct2Brwera4fLu9xE6ygjjkGT4Rx+u
 hWgHfdMKJIOfUIN5d6YFOA4stgXfNuftwG2yrSuqlXAYIgIarjIv/wXMm9gyXjHrdkU7Pasa1bR
 r92LI4X6lIU822cGjTITani830loZbi/BG57adqh8Vw6i1/M55Fl0DbLuEQ==
X-Gm-Gg: AYBFou34hEGC/p81BvzFwLDju5X3cKKkTiJvH0BuZwhd0hiJAyz3ag/+/Sb3GKUtbAW
 OsV3HNjTA3YdJYxUx4190FMiFhDUSbYK+jROBcaqsIS9kCMjF0OAmlS2AU/OxqFLwB+FsQpD3fl
 yYT7HwPHVFBWqdt6RmwIpYSwaiFwy81/xtUCY3575fdXEY60aIJtR9s3+KOjCf/EpIYWNWKCGLo
 Jiu9ICTppIB6s8IHBGLYsRFUR+ezTnGm778MK54uXrcjt9lkgY8GWLMjYeBjQ1XeMfC38FHQJUv
 +tFkgcrDZOk8md3MjNTuoKkTbgPAKi7NDrk4SKw8eDWru+KRKAFJZ2t56rHe6p+9kGPcvijGJ5N
 N6j5NP5y2pviKHveXeeNEc+KANuixays5Rw==
X-Received: by 2002:a05:620a:7017:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93ca97a83f1mr775454285a.26.1790852355755; 
 Thu, 01 Oct 2026 03:59:15 -0700 (PDT)
X-Received: by 2002:a05:620a:7017:b0:93c:6976:e3a2 with SMTP id
 af79cd13be357-93ca97a83f1mr775450585a.26.1790852355062; 
 Thu, 01 Oct 2026 03:59:15 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02209280bsm13702025e9.4.2026.10.01.03.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 03:59:13 -0700 (PDT)
Message-ID: <25c82098-07bd-4ade-85e1-ea35ff7d2037@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 12:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vga: fix OOB writes after external surface
 resize
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Chad Jablonski <chad@jablonski.xyz>
References: <20261001104112.2167807-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261001104112.2167807-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HHp_iTy1dvgbjEMWdJkhM_AlsQyjNesl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX9l9ayN1SdL+9
 +vPsJqEaRcCoZII5vyI96hF57g2Ij6M2B+tN4IGB0gNmVM8oK0yEmCpsH35cgcCI/ZFgufR4FDO
 ZKaDr1b1WWg8/YvJRiP+pBg7W8LBxoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXyo81OxkDpj8G
 e2MxyimXV8JQowkeZpY+ydNXTkY95Y2RtcTQl/JvzqopxWKFoSsHOtfNjhbQwA1EmOh0QRmmfAx
 EvLHk+cDYUKWuuHQ2n8DgbCk/Pe1tkl9qhiz93kJiXfdhUems8QG2otLnkw+hpHN/DrsuiYzCNE
 IRdGOFhHSaL5v0xaa3rzGxltkgFs3NSDc7CVlVEkKi+Th2GGgRfkoC4+20f0Xns3oj8eLz0rvJU
 iYs+D6iyN3wDjmB0FeiNOpAt+qqZ+ZjA3nfdrY/V3uCgaCYRr0DcEWNYK9b/kq3m/Q26YM0CkjU
 M/NMUrFZgRbVzkAcipjn/i/LI++NZH6SQpzkTWKTeuZv9UFnoaIUDXqGDSIzdSngU2gOmL4kbW6
 rwcZdk/gbQKl+WZI9kYliOUFbfz+vyu+dFob+WpVgC5C43I5Fbo/OqmS0AtFXr5yptqQkVzv2qu
 XxO9V2IdQI9Z/MsImng==
X-Proofpoint-GUID: HHp_iTy1dvgbjEMWdJkhM_AlsQyjNesl
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe3d04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=5VKOrE_a3cXIK9zXM5UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
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

On 1/10/26 12:41, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio-vga has two renderers (VGA core and virtio-gpu) sharing a single
> QemuConsole, with no invalidation protocol between them. When virtio-gpu
> replaces the surface (SET_SCANOUT) or destroys it (reset via
> qemu_console_set_surface(con, NULL)), the VGA renderer's cached geometry
> (last_scr_width, last_height, last_depth, etc.) is never cleared:
> vga_common_reset() does not run during a virtio-gpu reset.
> 
> The text draw path was fixed by 418396be80 (CVE-2026-77913), but
> vga_draw_blank() and vga_draw_graphic() still trust stale cache against
> a foreign surface:
> 
> vga_draw_blank() uses last_scr_width/height to memset the display
> surface. When the surface has been replaced by a smaller one (e.g.
> after a text-to-graphics mode switch, or a virtio-gpu reset installing
> a 16x16 placeholder), the memset writes past the surface buffer. Use
> the actual surface dimensions for the memset bounds instead of the
> cached last_scr values.
> 
> vga_draw_graphic() decides whether to recreate the DisplaySurface based
> solely on VGA register state (line_offset, width, height, depth,
> byteswap, allocated). When virtio-gpu replaces the surface with a
> smaller one, the predicate sees no change and the drawing loop writes a
> full VGA-geometry frame into the undersized surface. Add surface
> dimension checks to the predicate so that a foreign surface whose size
> does not match the VGA geometry triggers a resize before drawing.
> 
> Ideally the two renderers could coordinate through a console-level
> invalidation callback, but these defensive checks are needed regardless
> as a safety net against any path that replaces the surface.
> 
> Fixes: CVE-2026-97889
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4579
> Reported-by: david korczynski (@david1766)
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vga.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index cb0e28b79b6a..b9b8c529419d 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1641,7 +1641,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>           height != s->last_height ||
>           s->last_depth != depth ||
>           s->last_byteswap != byteswap ||
> -        allocate_surface != surface_is_allocated(surface)) {
> +        allocate_surface != surface_is_allocated(surface) ||
> +        disp_width != surface_width(surface) ||
> +        height != surface_height(surface)) {

This if() condition became very complex and is hideous to read,
could we split as a helper for readability? (improvement that can
be done on top).

>           /* display parameters changed -> need new display surface */
>           s->last_scr_width = disp_width;
>           s->last_scr_height = height;
> @@ -1789,9 +1791,9 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
>           qemu_console_set_surface(s->con, surface);
>       }
>   
> -    w = s->last_scr_width * surface_bytes_per_pixel(surface);
> +    w = surface_width(surface) * surface_bytes_per_pixel(surface);
>       d = surface_data(surface);
> -    for(i = 0; i < s->last_scr_height; i++) {
> +    for (i = 0; i < surface_height(surface); i++) {
>           memset(d, 0, w);
>           d += surface_stride(surface);
>       }

Changes LGTM and make sense but I'd rather another review on top
since this is a CVE fix (Cc'ed Chad and Zoltan in case...).

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


