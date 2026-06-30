Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE391C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weh8q-0003Rm-Rs; Tue, 30 Jun 2026 18:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weh8o-0003RG-FZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:41:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weh8m-0003Fn-KC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:41:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDebe2959993
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gQ52A0amuAyRMZXv54aNBZy7llfPhiNm8wRr7Hn2POw=; b=ZsURplx0Tc+1CToL
 a2QwlCtjbP5oSmellgWLjq7K5R/8g5Z2vdtSvooo9nrjFVGQO5GF+6SrWzL9AgcX
 mxxUnxCGB3DhDFgL6WhBHGGDJjaCKAdi+WDetwtIVMDZhAUNV2Z874w8Ul34nf4u
 4AfKTLa1cqfVv/GiRWyt1VNvkZ1DJ3HQun3LciDWV/41pKhREJrdWoJuoL73NWhR
 qYWDlfwhogodp7z2iV0NjG6Ky511V6uoIEdpPHDC3vZh7rwpaMguUHFFsyuSbpgW
 dHd3fjbyf/9Rjr6S9jjbahNlB/Z6dOIzMnMC7vHrL8DvL+T0+vs7qVZaXpDZjJsg
 ow5tCg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9117rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:41:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92b4b575561so286987685a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782859273; x=1783464073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQ52A0amuAyRMZXv54aNBZy7llfPhiNm8wRr7Hn2POw=;
 b=CQvg5uB4g66eTif6KLrBOVz1sLww2tmtXUACRXpBCKIBDYl53YSvPGTk6aU7SoulNv
 dL7j9H81BRPP+XtErBEmEZiyS+BAnWnQFiBrIA4Hl7fLymh+KoTevtgZWQZBKiAEjsNx
 l/ruNpG8FFJkqtCsq1YyIFWRTu5jq8AIW7iD/wwlRZhx7u08Yl/XdMaTwSPksuLeAW5k
 CJOQJkiOnAWDxCl71IafLddJpd2TAcX92zpkrCm22fmnLrXKmOaNA5ljs397Jfq8eLyv
 6S2UrSfCC2yabXigKHyBiZlimeqMppgbEo1HZ3yEYjqhUUKjeYAXGEAg1RC0SXbj38pR
 x1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782859273; x=1783464073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQ52A0amuAyRMZXv54aNBZy7llfPhiNm8wRr7Hn2POw=;
 b=lO/+egkldmzXoKa9yLzhWjJ2l85KMeU7oWZ/tNtPsYZkm1r9uRh1+C0ukJHparUfaq
 bmNaUqafC/PD8P9fV3+Xbu1RUnCP27Z6RTIS3mtCjcOGXEV3GNo4xtvZyUQsUU9wc8nK
 9qBQu0oYVSDdlqRsQqm+ZYZrkFRy1aD5fOuQESBzWI/T1bVGEudBBPh9XUeB2tXW7DHn
 FTg5orvwtSpW+sf9W1anWoXxkhDNvbLs6ULStYkziwW5+3G/dAw9W/3Tl4AzL4JX4v8d
 U52rJJGsyQhYyz2e3AVKfWE16snOIQgJ43jFT7tBY37ltOSH/jjfsLOo9XqUDbM0PnL9
 vwYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Qpq3IEMBGODnzdrp4fn+zrYX2ymTY9+HSTa/e2Mw2sOUykKp4DsF+gYA/QSY9DGPZrM1QgsrGgvRF@nongnu.org
X-Gm-Message-State: AOJu0YzJMhF6MSsV/gN0X2Py4qn4QozBH2XeVeEpKuRvrNdGZXbuzi9j
 1gKuImBBaM/p51kiQMX9qQYQbtBhl7dheod6E5B8ujToDPTv2Ef68bNsqWRWrV/iGm7fkmszsyM
 zo+16A7IEOxD2u3Hwr0G7+78nKGAQ+YaBwybK8yYIGZrgZWz1+rVlfdTrKg==
X-Gm-Gg: AfdE7cnXTZ/8vjTYRzUF5phwMMj7n/ilVBklybR71oTvld2/GTRhzHWUuIlL24c0GT1
 h0OZhyjAklCvWXrv7fqpcqNSmrA9uLf+d35TuUpQawPVICL8mMuTvNrjEVBabs4G1JMKTGauNa6
 QR1yHC6p1fddyaRNanDvmQUpOclYhU0icw8YEmfZXnqlA/FzCdrdtDhqCd8YT2N1IDF0j7eMezG
 hX7bClHq2y1KhpS90gt0XHk7uAzSFoK9SN1FsQUWE61Yj4qm/P6grg7DSqvMulY/GEFZCdUTPq5
 1MsgxtDkoct777M7v8yBPtrgktNxSH9WcGxOiUIjmRi46QZrDI6NpjxYxGmO1kcVYKOJlsZAavn
 I1lNQ63sY79+j33JyE2B4PBoQ+6hzos6bCk0ogu85KE5za1GXg4VwUHiwAjYNxQ==
X-Received: by 2002:a05:620a:2b42:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-92e697c24c8mr486398985a.24.1782859272625; 
 Tue, 30 Jun 2026 15:41:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:911:e11e:dc0d with SMTP id
 af79cd13be357-92e697c24c8mr486397585a.24.1782859272233; 
 Tue, 30 Jun 2026 15:41:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756778fac3sm10838459f8f.32.2026.06.30.15.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:41:11 -0700 (PDT)
Message-ID: <2d93e964-29d1-4ebc-a128-5dd265fe527e@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 00:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/loongarch: make VReg aligned to 16 bytes
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, b4-sent@kernel.org
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
 <20260701-loong64-be-v1-1-9c7d65e00697@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701-loong64-be-v1-1-9c7d65e00697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uXyg0KVEdNYKWK7bpnxN5bwwHv4EFtkI
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a444609 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=it_qkGhcUfOJB4umuX0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: uXyg0KVEdNYKWK7bpnxN5bwwHv4EFtkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMCBTYWx0ZWRfX09/KPC3OqFFy
 8AQxKbZDIqZUjEhAtO9KUPP02FOSQCQX2rfLXeLSFYisvI5F1nnIfzWti+KtsCMklM9HoeQUfBV
 lZr6C3VDqRokVGcOViVpFOcBdXbkoBXuJvsN97jwlTNjt+bvLFW3QL0m0YsJ85uhAmi3gTesGaC
 3GLN0gIqKr5JkRWl+fhPZSsLBu5Vvf8DbpocGLVC25P1I6TCI9xkYRYPi9ZXi0ZWk6AZ9ISu8yO
 1kkyJh6hHhXRw3MeK56eylJtKKlGWHzYs/+t5KyZrEGGXtdQ0C+PwpCcmpPAs58r72rCyPOsobY
 5GaFcoQdYVl6X1DnmFHlf39cNAYbm85q/1+RmOPBrcR+BBbOFQbLLZ5JYBCvO/LXDvseXQ9UURe
 Ppil1S2bEm+r4EO6HXYlEv7B5cX2LU0H4b+sm9yL9YGNV1xDtnr5P7WwsQpXbyWB/MZt/ZN3HHt
 UtdPZwpi4c0FFvOIdMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMCBTYWx0ZWRfX4iVqtSqSAu/k
 DZn+0VqPtzjKbvhp6spua6+bwwajN8YXADDfsAm83VWuWaGHi8XEf7QfBjiVfmsYJsGVkhh+g//
 z8IR6aVSvHyhtdKoWeZEC+qjPeD8BXc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300220
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

On 1/7/26 00:15, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When tcg_gen_gvec_* functions are used to operate on 128-bit
> vector registers, the registers are required to be aligned
> to 16 bytes. On some platforms, such as s390x, __int128 is
> not aligned to 16 bytes, which will break the requirement
> and make tcg_gen_gvec_* functions operate on only 64 bits.
> Explicitly use aligned 128-bit integer to fix this.
> 
> Fixes: 008a3b1662b6 ("target/loongarch: Add LASX data support")

IIUC that would be 16f5396cec2 ("target/loongarch: Add LSX data
type VReg") with the first trigger in 57b4f1ac188 ("target/loongarch:
Implement vadd/vsub").

> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   target/loongarch/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ad30c73167ecf6d8dc6faa8c6a18c212fe4fce55..d3eb35953abb87dfb34b8f3340f8dfd83264a484 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -275,7 +275,7 @@ typedef union VReg {
>       uint16_t UH[LASX_LEN / 16];
>       uint32_t UW[LASX_LEN / 32];
>       uint64_t UD[LASX_LEN / 64];
> -    Int128   Q[LASX_LEN / 128];
> +    Int128Aligned   Q[LASX_LEN / 128];
>   } VReg;

QEMU_ALIGNED(128) on the whole struct instead?

>   
>   typedef union fpr_t fpr_t;
> 


