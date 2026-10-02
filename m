Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C0CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 03:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCTb5-000439-5z; Thu, 01 Oct 2026 23:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xCTb2-000431-Tn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:06:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xCTb1-0003xW-8k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:06:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922KBct4004971
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 03:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4V1DXKfe2eqRNq01pixOar0RAja14miDIlKYtsWtnJY=; b=ZutCLzRlnELYslRK
 JLcTvawfJmZ8HMbnu5wrrPHWeO+6ZyYMk31V2Kef4CFtApXSNsQ0OMr4v/YidpYC
 9Qb5CSei+H10Yg0LwJnJtwV41gEjyS2CVWISNu0fIarYj+ONrypekBGjhPh1ufuf
 1zzqkq9hya1pvM0h+vP9zohgbjSUospcaThFZwFVGo2Jkitua0jETmpJiH2D3qBN
 iNc0bXRTg2/mzAMfHPZOJPVyhdP9neH0M5psrC8gRrBcxXifkhMQoJavrgey9C0D
 6VxQaqQ4IPM9MQFValCp3Tn4SbYtbcxGtRqVz1BbgkvgoGS1l/nm5VBrUB+/kaSm
 IdJiqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9aabxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 03:06:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so1004310485a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790910359; x=1791515159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4V1DXKfe2eqRNq01pixOar0RAja14miDIlKYtsWtnJY=;
 b=Xg0lcon9cpvKXCY8jZXQyTwLI6wDO0SZbmP3YYAHfRMMkv3Lrjook87IF8mBsnZz5l
 xP/QikKZjsXoK5p0pAqpDN2NfvbWSsplxR1SOEE+a1haNHetWtKiP36BPvYocza8XmGZ
 ivdP4i97xyMrn6UR+1IWVvXnb6rCFS935SzuMeOrkt72O3OY5ZoQ6HkJG6nDEd3WN8lI
 LYM3SqqgffG3iTYOyZElfC9dOkU7jNxMyPu/rCzIVaD68UCOfnqhxhaeibUC+ekGsjQo
 dvWAjoul81INU8Cmo0tdVs6aDpi2rgft/oD3HJsabW53qNp1eyexpBoxOJzO5zc6+/48
 e7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910359; x=1791515159;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4V1DXKfe2eqRNq01pixOar0RAja14miDIlKYtsWtnJY=;
 b=oqPGlpcfouEEEVCglCZf2qPxlVNz2S/kGlyy48KpdUa9tTK+aTTb5Np+Iws0MlAJYQ
 9oIjmO2umVvGusbRu43ZmN3OQNzGtbwevUcn70+peV0boDKaxoiij6rdJxPh3IhmDGgI
 Zui6Yk/sP2jWj4mrznrv+rXb4+Y6NRTxZnNqd6AOAaxa02BxMIs+jFOYpvgQIaa1vilk
 Czv62ZSIqeDW3ikwl8Jv3aF9vTfHPFBuZY7Bo6xTzAM42/MVDuVwoKWTPc+VwkGS1GhH
 7xRgCTFMiw8rGk2u96RuXe7pqNg96HOcHwErhYxFL64k2ZxnjTwlZKjSKb0JQc7293Jc
 lplA==
X-Forwarded-Encrypted: i=1;
 AKwUvByks2Wf90co/aInwfLmEcKJrB08xphWl+Wj67QCSCFAng72w4zBJ0eBEYwLUFEXYCzr4lwvaOyZiY5A@nongnu.org
X-Gm-Message-State: AFuF++mBtghQSzh/RLCc5A98L5WBSXTDFTN6tQ3/TcrBtkjDsxLBz0J4
 zhpNE61hgzW1P/bi6KXZoGGrdw4jlQwnJOPH8lj1xcX8q/03UQtqYMdTmT+49U0YA8Srba5hemB
 5F4TjVHBVfalPLs2oOLpndsRWuUZDOdfnbCF3uyD4R3qxsOPp259ld8ecZA==
X-Gm-Gg: AYBFou3P6XqkYKSruBO/Pm7NVzMMJ3rfwZ8JAvRbFSpt5kHdY/CwZXQ18MGVK0Z3g94
 aI8A0RpNHH7V6+PPgNFGfSENIDBLB8SiwaQfi3RkA2IPAkjXCKepugTVaeAljnyOZeprvD64l5D
 9NmfJtN/FCaZCvxMZ/2JR28CRGyOg6Q15tTU/1xq7wC40DbDqkb76NcpyFqe3d0mxGk18th8iud
 dtnoHBWnSoU9w3tArbVhbEJb55WPeE+nZWVx957zIBbOyDRB9WPS6oWpjwNjHvfL1gvwSOeupBp
 NjJJRLhvEz4FMvE8U2DucmT43NUdMzG703r+BzMxBSVPfJoRJhVgrSSQQVMcdvf5HGIzjIXkwBZ
 isWZRTItHKWrlaMsouZkDlpin61fjM0kS/LrbvwtnDEE5XFCuJsSE0raZrZlbdo590DOUPS3prd
 takJw=
X-Received: by 2002:a05:620a:d88:b0:939:4a44:5f99 with SMTP id
 af79cd13be357-93cea15f9a8mr244782985a.10.1790910359157; 
 Thu, 01 Oct 2026 20:05:59 -0700 (PDT)
X-Received: by 2002:a05:620a:d88:b0:939:4a44:5f99 with SMTP id
 af79cd13be357-93cea15f9a8mr244779985a.10.1790910358636; 
 Thu, 01 Oct 2026 20:05:58 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca24e65fsm112900085a.27.2026.10.01.20.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 20:05:57 -0700 (PDT)
Message-ID: <a59c0230-ef58-4185-97d7-73a35a74a401@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 22:05:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/tcg/multiarch: add missing
 test_pnew_jump_loads.c test
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Dominic P
 <gcc@gcc.dp11.uk>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
 <20261001163751.172720-4-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261001163751.172720-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxMiBTYWx0ZWRfX6w8imow6nQ0E
 nA4Em5XaoS0xkefAFYzgC0FRPPiKwYOXxckek/p3L5nRGIwrAyRljgnzVx/JPxhIOoYfxQHrjmw
 ke75RYRNgPGJvkM9b6YbMDyNCCRjN84=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abf1f98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9jVZBrrIhNW00ITX7ScA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: adO6feGUKyN2IFp1kpt9P0H6r1ruQStf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxMiBTYWx0ZWRfX8L6gxFasSWnJ
 x69M7Nu7B/0IxSmu4w6PugCjTkLCeNHVIJ766hvhZDhCBRX2XsiO+lSDE1Q8lSvo4h0DJ4yHKiw
 z8o+87Nt+IYTlX0lE4UqjpFUqJBaDax2HDsiMNJsJSU9PUewlK0g9nlwKSZS6/JEreKe08Jvzqr
 Q0njPwygibfpwikxdUo25/xNbn2XnR99d/OLZdt5B3KWIVb9fY87Tdrqih/tsULtxeewjafmuRy
 +1NX7wQK225sBoyHiBwKfY0HCEpv1Q8CvQY0WdphA3+gkUD4pGP3u4X/Ow5xK9rYRHexbE3c1oQ
 aZS5RLdpoDoFL+1bMqZmNv0vj8ZRM8nPEDqUzzL6uv0yeUiABkKqmKwEvhT+ytRu837/+TEqOxS
 08X1vslWlNXVzZnIwkS1iinJRcG4uDM76GUCnNmeZGgkoGWw5r0rY8QQwzxte2TXn6kCYDarhXw
 rf0UERpEDIW+ED7mlOw==
X-Proofpoint-GUID: adO6feGUKyN2IFp1kpt9P0H6r1ruQStf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020012
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


On 10/1/2026 11:37 AM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   tests/tcg/hexagon/meson.build | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> index 7b220174ff1..c46d90e3954 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -84,6 +84,7 @@ tests += {
>     'test_lsr.S': {'cflags': asmflags},
>     'test_mpyi.S': {'cflags': asmflags},
>     'test_packet.S': {'cflags': asmflags},
> +  'test_pnew_jump_loads.c': {'cflags': cflags},
>     'test_reorder.S': {'cflags': asmflags},
>     'test_round.S': {'cflags': asmflags},
>     'test_vavgw.S': {'cflags': asmflags},

