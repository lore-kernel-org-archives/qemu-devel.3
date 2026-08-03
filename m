Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8BCC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrJA-0002AW-BL; Mon, 03 Aug 2026 07:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqrJ8-0002AA-5P
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:58:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqrJ6-00055Y-CO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:58:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673AMYv53882594
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 11:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AIBMHhgVldKAmDMRpCZQhHx2n47dSoioNMUxqglmPWw=; b=kzCUVc3kB4lpsHLM
 5GB4isAA5bsxmGcj17Y9JfrO0lRyICkiC64TtqL4e4wYRJLLC9o5EEzC54KVB2mV
 GLVM/sgUQohsTJBZWkxY0DO3S3sxw24cL2fgRi+X0ZpFzzBnB+QkapENjuwCaVoB
 cmMs2T0oI0zYD1DgtT9j0MoC1Glnpd7udZdfd0mVR/Opy1S+sBiDnw5fYnb98Zhe
 h9WyPlEwfxW7hCfhfjQFo83fX3l3NTd7PS+t/kuXFrfEECUNWmXhpvPbDy55dHOR
 N12vE9WPxB2ToITi0jMOqiJ4+Mb5el1eJ8hkq8093k9n9mOaWhdBlErolAJoaVsr
 t9cJOA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhkhdh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:57:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso53914711cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785758279; x=1786363079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AIBMHhgVldKAmDMRpCZQhHx2n47dSoioNMUxqglmPWw=;
 b=h/2t9xKjpeYfCqPUor0M9lnf9m7y9jIragIJF2PbXQ/LmOx4hFgG4StvDojCcbWBcm
 EEDz2XB8mj1ZdmFJmRezxZ7ALBcbDM/c2HAdgTmhz2IRF/LF9p0+IDVKPwBb+oaJdgAm
 WMwp3WkMziGErBNDvqDfTxpV7Rg63lNZH6fTLkHqcQvcfCMqWgzGnV4MAzaxeW2RoDm4
 QC0SmIUjxiuSHMlLyQ7Ffn2jbTbsHG4kcPOOMQP95tELraI5rIgtrHrB8lz7SvW6STva
 dRHRr+bZ9yqTmNm9eamzCrPVnIzJ7Tjx1OH2y+8otbnvldCuppQxRZB1sQytbgUv4fGq
 UuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785758279; x=1786363079;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AIBMHhgVldKAmDMRpCZQhHx2n47dSoioNMUxqglmPWw=;
 b=H4CdhXGP66beI9jqiqjIZ5vTEw90cWOR4Olx/1eiERi4HpRjy394A8BFPJbDof1V6F
 xNaba5uYsglgqA69FLo8KxPEubsTME4snv3Y3R5F3ywdHEkv0EO7VqSwm9lqY7qJW+uG
 mTtC17M6aBiEOcM9OHYNo1K/5QWPj0U/xPD7MfZwGW13XOf+EKyLC0ISnWQXMl4nj/bn
 zCWSxblsXKiit5dN7y977VJXQLoz9/Encbg5I2vIL91CaFechEsJxwBe6geBmfUkBpDL
 3Le1O/O+JXzZyl/4rdwXpXb9Bee60VHFSwR6pdmvnkUfqUBBIZz3r5B9t4E15xgec5/t
 7Q5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg/OA+2HDq65KuvidMFyZcoSL+S2dEM50kpCAnmpEvoo/Ey6j48G57A6T2yvew301Q9aUoEWwU8Upx@nongnu.org
X-Gm-Message-State: AOJu0YwBpROK33DHHTZKgWamJ1Yy6wTbTXMceg8W90tX6kTHaJDB49IG
 gfUmjMkdkf32mcamP12bmc8TyR1+gDXitHs2SsHFW5plpC0RVa4SOukiaCBv1egigAzg8UrBMP9
 +GGkImgs8pjnoPZx8axR83rMpr1GBw8Dlewf9uYPCamGPdbBhv1lEFeofxg==
X-Gm-Gg: AR+sD11wsqXfih7gpJ536u9QBgyZ+c6h0NRjkjQHWCp3ANATuF19Pd9Z0se8qa+rXej
 aq7xlo9cDFYijhzQVZD+CHfaTkI2FeGTNU7mVB/B+zvTPw5C/7o7CLkGA5AV5eZLrKKiwnHeIZx
 E4jZpla8m4gn6BoJcyNdpc/b4gAHZhrWAIWzpxRjWocWdqaMgiZbNT6x+F9lX5GVKncXWXq7U+j
 c0Ndx7yAIrLNK1W1he+k7lddjOQipNL+RbLPHczzUPeVQ8IqyYCaGeaznVIQSbtc8tQHDtYj+He
 cLmEkw1h5ABZtGpe1qiig+qyaO+eaHkphxoxZRWXVD/ZdRLbRTeic6ckSW09j9/9trpyMEWnJ/I
 A+PWjajR6UkuyqOV910GcOoddYBIATCfNC7hbAOdlbB56u1UGo/s=
X-Received: by 2002:ac8:5f8e:0:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-52b4c434065mr170657511cf.8.1785758278992; 
 Mon, 03 Aug 2026 04:57:58 -0700 (PDT)
X-Received: by 2002:ac8:5f8e:0:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-52b4c434065mr170657171cf.8.1785758278466; 
 Mon, 03 Aug 2026 04:57:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b6745csm228031725e9.7.2026.08.03.04.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 04:57:57 -0700 (PDT)
Message-ID: <dfbbf33e-cd29-456d-ba50-d551af00b9cc@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 13:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vga: fix panning_buf OOB after text/graphics
 switch
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warisjeet Singh <sinxx198@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HuuijqYuXQChwxkwnQsmiphdYyg6M36G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNiBTYWx0ZWRfX0di78oT2HUhP
 EaX8n0AXLJ8eq4jWnkGfjQ/cX2ipuA7bfnVL21bgmyVIZVeo5Y5vzE3P+p+/dyy+8fDAOJ/MyZ4
 XfnLa//6yijuPnCAPZ1UkUwiipU4nd7L+ss9HxmZR1+1vLWm3PjClhFefxjsR3giZyLZLy+PdCO
 1PfDiLi50cQHNmdQZMA2aOxfzAdxlOVkpM5hLAY9m80pJN75FWh4Nx8KLAooLkNOVz8VMQE+oqy
 FJRzUoL/+CI4AqK2fZK4TNG7O+5Yu8i9XFdg0gqy3o/PZ45aJhZc8zpHrRRFrlpAxej1+mNiZPR
 wGSaj9RaI067B8lWXv0+TAI9j+r5ntXEyp8zSMfpN4O7TZz3V7bGcG+LNugg1WXonCr3e1l4S8N
 vpStrc2brYGA0pLfX4CpYUtMbeY7U02tcxZI0CnaTapaPuO+/+hXAY8Kl6fmOk6qN303p9j4Kub
 OxjyVRzROFuUsT+f3Ig==
X-Proofpoint-ORIG-GUID: HuuijqYuXQChwxkwnQsmiphdYyg6M36G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNiBTYWx0ZWRfX864thcoLo+83
 y/Rs+tkWDs0Hd/9UJ8gyGIXHFYMUre1paXrVZnVHIpC49VQb63Ln58btLMmWfKaj2AIc3pu0Hry
 SVkUQk0WZ2mfpKVVtFzlKtySwQFnSgg=
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a708247 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=C8S5FPwDg-0hFLq6KXIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030106
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

On 28/7/26 17:14, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The fields last_width and last_height serve two purposes: the text
> renderer counts in characters, the graphics renderer in pixels.
> panning_buf reallocation is guarded by geometry-change check, so the
> unit mismatch can trick it into thinking nothing changed when the
> resolution actually grew.
> 
> A guest can trigger this by switching graphics -> text -> graphics:
> 
>    1. Enter graphics mode with a small width (CR01=0x00, 8 pixels).
>       The predicate fires and panning_buf is allocated for that width.
> 
>    2. Switch to text mode with a large width (CR01=0xFF, 256 chars).
>       The text renderer stores 256 into last_width. The text path
>       never touches panning_buf.
> 
>    3. Switch back to graphics with a width that happens to equal 256
>       in pixels (CR01=0x1F, 32*8 = 256). The predicate sees
>       256 == 256 and skips the realloc. With horizontal pel panning
>       enabled, vga_draw_line4() then writes a full 256-pixel scanline
>       into the buffer still sized for 8 pixels -- a 960-byte heap
>       overflow on every scanline, every refresh.
> 
> Fix it by reallocating unconditionally panning_buf on
> vga_draw_graphic().
> 
> Fixes: CVE-2026-17516
> Fixes: 973a724eb006 ("vga: implement horizontal pel panning in graphics modes")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4085
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Warisjeet Singh <sinxx198@gmail.com>
> [ Marc- André - drop realloc() resize condition & commit message ]
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vga.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index abe3f8e07758..da0c331486eb 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1647,11 +1647,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>           s->last_line_offset = s->params.line_offset;
>           s->last_depth = depth;
>           s->last_byteswap = byteswap;
> -        /* 16 extra pixels are needed for double-width planar modes.  */
> -        s->panning_buf = g_realloc(s->panning_buf,
> -                                   (disp_width + 16) * sizeof(uint32_t));
>           full_update = 1;
>       }
> +
> +    /* 16 extra pixels are needed for double-width planar modes. */
> +    s->panning_buf = g_realloc(s->panning_buf,
> +                               (disp_width + 16) * sizeof(uint32_t));
>       if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
>           && !surface_is_allocated(surface)) {
>           /* base address changed (page flip) -> shared display surfaces

This function body is huge.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Orthogonal but since reviewing, should panning_buf be declared as 
uint32_t*? We could then call:

   s->panning_buf = g_renew(uint32_t *, s->panning_buf, disp_width + 16);

and

     return hpel ? &vga->panning_buf[n * hpel] : NULL;


