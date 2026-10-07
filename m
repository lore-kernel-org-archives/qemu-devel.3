Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFDBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbz-0001lT-BJ; Wed, 07 Oct 2026 05:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEMQp-0000P3-N3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:51:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEMQl-00028S-Mf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:51:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jW732481348
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 07:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZQtqoVX/rTP4bKM66IQAHSm/v/EqNRjKbhfiVFETvRg=; b=R/fgwoGT9rbTmiBs
 Tjh7zX5tCUSINVddJFrOt9GW1WhDm+lz1z7Hgz9/bDMCQ/HqleYpOrbe8Lzp9el9
 gGRphch0bXaiiu1wwiwukLNgY9EdG3JmI+uugbAzFY23EDzU6sG3H+VxWAU8OuG9
 KJSCf8g7StK/UV8D8gi6xBZi9xbp7ZdGkljDybS4egIGyz+Pxo5wzshGcw4Ge1tU
 1LGstr6DYByULdSvFTVTeVUKE9iPifTuOfL+VG//i6JwLAgkDpmh27KmhNLHFPfV
 4t08gSusnFXTMNRmr1rFkPCpwc4k6M6etVtKfVsTZ7Ks1NV6EVHJZSnxrnFXm86r
 jNWC3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u14qv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:51:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso806746385a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791359472; x=1791964272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZQtqoVX/rTP4bKM66IQAHSm/v/EqNRjKbhfiVFETvRg=;
 b=jIU22Ir5OALjSfg34qDqgISRO8iF9grJWi3WsCHfnpWRDtKzRUYiI2d1QpAKqLWzuf
 nEKaaPHdzRvYdnf/qmIQ5k6i9PPiLUnlc9I6DTxbodrRMYo4Jl45AJRObwgiTTQK8t8X
 wvU6yYSJwDyoXDgdgz/8SAc2YQyJzlrQnBq5NnNFck6BlqUDvG/xq8mECDm3xDr9IK+8
 859sNnSkbdYubukSv5buTM5jc9AAT0nZVf8Or4Vi5ihp3YvAaPxGYjqAEsLNVog1dDhI
 T8jSqUjO6Yt2EPc7F6YHPRjkJLkolNWjU+diSca8e0Znk6/3uFZUfG16cUha4B4aL7JG
 2PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791359472; x=1791964272;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQtqoVX/rTP4bKM66IQAHSm/v/EqNRjKbhfiVFETvRg=;
 b=r0zW6E36um6HoaQoW9L4oX5uvtyk4RBmcgdDqBm96KhQ8vVpVYYr9YAfH7vBW5BtmL
 itSxyNjYAAdo/D3SCHohP5u1BEd2uSgxxleXF/OHLg1F0uWk9tpf3uQRbNA5vzzKl2B3
 KFuRZcyNAtIJwRj+FUbTySNRCLC4ZQ9Bbz5DftQOemGXmtRIw9eeUBynAXJDDfHawxUI
 +b4bKng9p1sOVJqj2wLDNisF2+xFTyUjUhVGkB6QONLCWiSsm5CDZsHM1zGwFqgk2vrO
 CMGqx1wIt3ZHnJBS15DzJ2JyYnja18xmUR95cI6Jo+ABH5Ox2d0L7g3AXks77ptUUR2c
 ytIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHKQNCbb2tuLDQk+c5Iid38+gkstqgOaeYds1A6jeYRocZJGCh4zkUcMXUW1pT2bNEFt+3/Dbk7kET@nongnu.org
X-Gm-Message-State: AFuF++ldHtgqwELel+PeV5dTILzEBjLqUEuuEaMouuronknjzX3WGMMY
 6Bbq8LMML3VLx2gdikHRJrNI2HiOZXzjTDsXnKDo8g343vzduSCvMzO12YAQVY0SWPQAFlj3b36
 yZOqruPlW1el2IaIhmnps+ILphWhE4inVm6RZ+bhIDPyxip43og7MtLUxpA==
X-Gm-Gg: AYBFou1+zP7GIYVN3a41JsQk/W+54PkpEsbPC2QRBaDyaDKNorzuQiKjUDbcYOV4Bm0
 oLYb+bgKgSj+RoodF/tf5MENBlzeDhu21dbPsL8vxvV7Xh6k7rTgyOi/QQv7QPyZKqWmCScwDTg
 9A4Zz2qho4pudhvRx4AZ27wEytj3z/rYj6NNb5iVlN4Rbris1T8LrdAw5EFNTaIj0pCLV3UlQI4
 C+49ehwhPfrDT5qxMjgw7yMVjK1BxczCMirUhlItwejIVFVPi5u0avNiCYMn5nyAPMo5vFUsbxX
 d/hLe72BiiGisbYAN8RYdrvA/gncHi3aSRRLWrmnENSUfhlkCodE4BMk8GSACEwW/UNOAP/C72B
 aDljCN/RVFBTbcKSISmLmb/fS5f0J8Fvi1Q==
X-Received: by 2002:a05:620a:6f0e:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93e9b7e3fa9mr255015685a.47.1791359472440; 
 Wed, 07 Oct 2026 00:51:12 -0700 (PDT)
X-Received: by 2002:a05:620a:6f0e:b0:939:de6c:cb45 with SMTP id
 af79cd13be357-93e9b7e3fa9mr255012985a.47.1791359471874; 
 Wed, 07 Oct 2026 00:51:11 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c75b4e3b2sm1541459f8f.57.2026.10.07.00.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:51:11 -0700 (PDT)
Message-ID: <b0bcfbaf-e49a-4005-b40d-4e64678031d5@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 09:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/apple: Fix obsolete PGDevice function
Content-Language: en-US
To: Yundi Xu <yundi.eric.xu@gmail.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Dennis Mueller <dmueller@qualcomm.com>, Joelle van Dyne <j@getutm.app>
References: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzMSBTYWx0ZWRfX9RDcgBO2yaBT
 A9jFALz7Cq3JEmWkp5IsDTnu+eorcvfNmF03+tGXL3Jb5DGzcjtZJnJG9pRxbhjcr+fiyBQkug1
 sjlLKet7BXeqeQPAiNaOh4DYasZ8Wxw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzMSBTYWx0ZWRfX0fDPVO98lZNk
 grskkJnSYtNobckNqtCCEZgtny7a/f6IJIJdHBqKMesjUhQDwYdZjOetjYS65lwwl+to67zPDP4
 D5wM8U8JArOhh3upHke+02elhn5Sul87e5vf1EDZoyoZWWt9CjNwhfbuojmLTrjL45J+iNwZjkz
 TWPT7+S87/HWki+nViRTIkD8wz3aXjelLqTFR7SQ93i+ID9oZVKgONl8xzBYO8hz7ODjpJXG/Dk
 Nn4k4FN1Lpp/D+WS0mXBq9VnqSXV/ffaAUUPyPbDCM6KkZ8FjmkbldMkderZ+3flrS7ppVya2yU
 NBvWZ7UGJXs1eWItsWS/XEIAHIqh9lW83w1TFpIudIeiKYGSdHJsqzsgc+nKvUis2PDD3oQTZ8o
 S7NHSxqO0Q/s0KCOqhYAJjZ+DvNY61KCm/Vl8i9ThtGshdmHK+X3tVFJ1kxd6x485ZlMcjzdb3S
 u5WMgo1gHcfnlYQ1Wng==
X-Proofpoint-ORIG-GUID: E8BFMqoBNlPOoVWlBuMPm3GO5uc4RZYv
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac5f9f1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=0s5TjalLHGbX2h47szYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: E8BFMqoBNlPOoVWlBuMPm3GO5uc4RZYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070031
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

Hi,

Cc'ing Akihiko and Marc-André.

On 5/10/26 22:59, Yundi Xu wrote:
> PGNewDeviceWithDescriptor is obsolete. Replace with
> PGCreateDeviceWIthDescriptor.

Joelle did a similar fix, can you compare?
https://github.com/helixml/qemu-utm/commit/b795d6de88fc52cb6ff061e0e034be51d8e9c474

> 
> Signed-off-by: Yundi Xu<yundi.eric.xu@gmail.com>
> ---
>   hw/display/apple-gfx.m | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index be0061b9db..e730909c7e 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -767,7 +767,24 @@ bool apple_gfx_common_realize(AppleGFXState *s, 
> DeviceState *dev,
> 
>       s->cursor_show = true;
> 
> +    /*
> +     * PGNewDeviceWithDescriptor() was deprecated in macOS 15.2 and 
> removed
> +     * in 27.0.
> +     *
> +     * It is replaced by PGCreateDeviceWithDescriptor(), which is 
> available in
> +     * >=15.2
> +     */
> +#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 270000
> +    s->pgdev = PGCreateDeviceWithDescriptor(desc);
> +#elif __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
> +    if (@available(macOS 15.2, *)) {
> +        s->pgdev = PGCreateDeviceWithDescriptor(desc);
> +    } else {
> +        s->pgdev = PGNewDeviceWithDescriptor(desc);
> +    }
> +#else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
>       s->pgdev = PGNewDeviceWithDescriptor(desc);
> +#endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
> 
>       disp_desc = apple_gfx_prepare_display_descriptor(s);
>       /*
> 
> ---
> base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
> change-id: 20261001-fix-pgcreatedevicewithdescriptor-3ec303c2500a
> 
> Best regards,
> -- 
> Yundi Xu<yundi.eric.xu@gmail.com>
> 
> 


