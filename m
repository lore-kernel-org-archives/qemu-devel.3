Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C15C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjElD-0005cY-LS; Mon, 13 Jul 2026 07:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjElC-0005cD-HD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:23:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjElA-0008KI-Ju
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:23:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D77PIo810519
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=; b=aPhRryu7QJsNEoZJ
 /MzJ+rSAbO9RMFEdeDH5+o/ooPzmcrR3rc0cvY1t8hONDsn3veBlbaF5s6bw8jhM
 k2STG9f0TUO4iaWzOMyfqEgaDw9CA2rHElkezLBSugG5hJksrjR24OytSUUF2o8d
 TU4YQPWZw6C60PhaQg+tSMBrSwpttaOe8VAhz/0/yLIShJFq47lBBxMsysbRX5Oe
 GfHUd4tsmBzZiMIjb4Wr5+PlFhAaUA/3SrmmxXjw2Jm3pAWdclZlJrwUk4y4die9
 SnHSIhAdQdH5UgL/9wukTcUi6areUGKjYfkp/4e92yZ6SCrbOwEpEHceL731ZwR5
 nBiilg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrwwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:23:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1852a86fso35873901cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783941818; x=1784546618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=;
 b=DLkeB975yg/cEvNtUBKKUeeuIE4JzFAXRKsgTZtg+DEY9RnG1zxzUjZ05jP1RSFWUv
 01ssj54h4wgrWFI0gIkncePUNlRobD4q3i8G3O2/spGDLBB0CVoHPk5tPzI6JEnEdJo/
 2qbtSNlNTUdYggS8pnvO3uPal2h8tZtJ6Ud+l/Js/04oY+dZBB+hBR5i40oXqS9093XN
 mDmg2Q5ZN2MpeC8XaA/7mQ4qfMN3m7417u327MGAQ8dGY15MN4jUZ2FLeb3p3BGUsgek
 Wxqru9AseGGrrS/04r1jjZ5PKYcpyUOMb1Q7ha5h4uE7E0s3JYYzsVreOc5dEy+SixLW
 vplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941818; x=1784546618;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVifJTfriPy4tmWUFSiU0jYbGkRe5BZPwX8TNBMseO4=;
 b=DModWVG9Wbr2R9fURx+k+mAYx1FksX2wOXAHjCiOnazPnIrt/NCISiNZVW2Qvn4gy8
 KkYXTBsu29Nkdl3fQuxkT0tHvmXuKBc7OPoD2SYmdhmXP/ckOcD8hg+dW4S5ZmEn0ZLX
 BuOCn2ab+2hUPUnB2AMZtbVLcE0MSl7PEsBXu3YlpZVKd6y0o5HNyW9yBHYD6Wo3Y292
 JCck5VVdU34p8G/QZhLvLVBr4SDCKkkW0d4ENJLiMTn1oLz+P0tMQe+pLqluW95xiUEt
 7rh2+L0wbIWZbTub4lOqXYSaCpPQhGLFZcpeK7tRmK+crKJ5UNUp4ExaIl6qUWKmqUrF
 pYYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCXDIAo1Dff17bFIKgUnJNmU86o6LTm0Ro5u9xx9E+3z388tng40MXoSN1R9khww3zybIQ1lrUjaO0@nongnu.org
X-Gm-Message-State: AOJu0YxAEob4+VvLztOPZV+DYSbDP5WbQ5EeEXcPA3Mb/9awAj0/fKJ4
 pECjz4x+/ET25jgvOrQ3kHE96Vfm6DV4xm33ngK3J4sXaEAvP2PfjfIQq2JlmHV6WxkMri74hv4
 tLYy6GHdu8PM3PKLPH/tKQaomSTuIJQZcVYf46zcxxOdXfP4yNRXJPFxvULE9blT5ZA==
X-Gm-Gg: AfdE7clQDxe87/MQGEMxnBvbuH0md12/dLDAPxm2L8jzeVcPN2ZF9CuWJdiUlMiFt6S
 L9LW0icBx1gTGO+1bVwhnwsKcm9lIHMd2eZzWQdHwKi8UJSrVakctm1lJVEh1Uc/Z6N94VyFtnh
 VIxlS3njV7aQm/MpWl+KE04GaBbdEF0Cg30C0GNmMtXQxj5EjetqD1xjFGrkHbHvJ8XIZN88QZv
 lwRc9pv1c5x/TNFJfEiL0aX7eqhZLjNF8orBwV4WRneaTnbcL8LYyOuibW42HDQ9/410c5JmPY3
 256jrBYz/gll7tdKulgRsRD3msemBP/up2OoeVnUnEaQzBR3z/69kPizTrFp4J4ND6PNB9EDAsa
 AurpGnd0wpThEojq0nUtHl4XRfeEVukNzmK3F4B4Msmg9k4J9VcMFDvzvgkcyhg==
X-Received: by 2002:ac8:5985:0:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-51cbf046db1mr98852441cf.5.1783941818200; 
 Mon, 13 Jul 2026 04:23:38 -0700 (PDT)
X-Received: by 2002:ac8:5985:0:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-51cbf046db1mr98851231cf.5.1783941817051; 
 Mon, 13 Jul 2026 04:23:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm548507325e9.10.2026.07.13.04.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:23:36 -0700 (PDT)
Message-ID: <98e1bdb8-2cfb-4661-8189-9071b09e2629@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ui/vnc: validate color shifts in SetPixelFormat
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-3-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54caba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=d0EF2MyI_0mXo9OA3MwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: MD_rQpuBBeOvbXLeEomoWFs0bm7tSzHd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfXwlmwcmS0fr5B
 YBm/Y4tAXtJdtbBEbA8jJOEf9LrxKptcRSrobzeSwWaDeHXFQEdEbNcFIH/NW3LUIwdHix+axSH
 PxBZGjXvBN7mFAdxukaPyWoQPMivN4Y=
X-Proofpoint-GUID: MD_rQpuBBeOvbXLeEomoWFs0bm7tSzHd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExOSBTYWx0ZWRfX4T9q+TCWUvcb
 gHjLIdkvcpqzdBK0gANE/3DWam3Gt3ctqQvIjsWyKkMpxjJbgEgIofU2mfjb+WANS7E9oVQ4YLc
 pDrLK5EP8+bFs30zjD6b9Z6puZw8c/d092+gRZ/ds6m4rS0+IOzowkUBsN7k9Tk2N1POTnUJ5Jv
 ph5zIybRz3yheBARl/KgQs2HJ37uLg/J/RxxNzEFxmDYwREcfFEU8lFKSGBM8ay3voNPFxES4Yl
 hid3xA132VIcsdUM2rKzL55kQ9xeUfESBdYWbiLyhdJHe5OJtNHaPcxUonpKoG4PBc5Wj1QT6w9
 pg02+hlZWu4rahcrWTSC5u0xmTfZeV/sAnxe9h5tWW13sGjoRtzgRgu99b0gfUsqXS6MiUKeweb
 TDri8vIXCOIZUZacbIiqKJnZguvv8BGAfiEiYHkQ2SNHvJDZ3Bggsjk8mO0n7YyhimkEP3bOT+m
 U2iqzTcz0twQX080ccA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130119
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

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> A malicious VNC client can send a SetPixelFormat message with shift
> values >= 32, causing UB mask computation
> (e.g. red_max << red_shift where red_shift is 255). Apparently, this is
> not covered by -fwrapv.
> 
> Reject color shifts >= bits_per_pixel before computing masks, and cast
> the max values to uint32_t to avoid signed integer overflow when a
> valid shift (e.g. 24) would set bit 31 of a signed int.
> 
> Fixes: 9f64916da20 ("pixman/vnc: use pixman images in vnc.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3948
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 559d3954b87..94a38242c56 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2276,18 +2276,25 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
>           return;
>       }
>   
> +    if (red_shift >= bits_per_pixel ||
> +        green_shift >= bits_per_pixel ||
> +        blue_shift >= bits_per_pixel) {
> +        vnc_client_error(vs);
> +        return;
> +    }
> +
>       vs->client_pf.rmax = red_max ? red_max : 0xFF;
>       vs->client_pf.rbits = ctpopl(red_max);
>       vs->client_pf.rshift = red_shift;
> -    vs->client_pf.rmask = red_max << red_shift;
> +    vs->client_pf.rmask = (uint32_t)red_max << red_shift;
>       vs->client_pf.gmax = green_max ? green_max : 0xFF;
>       vs->client_pf.gbits = ctpopl(green_max);
>       vs->client_pf.gshift = green_shift;
> -    vs->client_pf.gmask = green_max << green_shift;
> +    vs->client_pf.gmask = (uint32_t)green_max << green_shift;
>       vs->client_pf.bmax = blue_max ? blue_max : 0xFF;
>       vs->client_pf.bbits = ctpopl(blue_max);
>       vs->client_pf.bshift = blue_shift;
> -    vs->client_pf.bmask = blue_max << blue_shift;
> +    vs->client_pf.bmask = (uint32_t)blue_max << blue_shift;
>       vs->client_pf.bits_per_pixel = bits_per_pixel;
>       vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
>       vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
> 

What about instead of the casts (keeping the if(shift) block):

-static void set_pixel_format(VncState *vs, int bits_per_pixel,
-                             int big_endian_flag, int true_color_flag,
-                             int red_max, int green_max, int blue_max,
-                             int red_shift, int green_shift, int 
blue_shift)
+static void set_pixel_format(VncState *vs, uint8_t bits_per_pixel,
+                             bool big_endian_flag, bool true_color_flag,
+                             uint16_t red_max, uint16_t green_max, 
uint16_t blue_max,
+                             uint8_t red_shift, uint8_t green_shift, 
uint8_t blue_shift)

?

