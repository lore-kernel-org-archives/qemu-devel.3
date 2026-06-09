Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98C8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWycr-0008An-KE; Tue, 09 Jun 2026 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWycn-0008AZ-K3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:44:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWycl-0001mj-UY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:44:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClUej2693944
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wrDt01ffe1p6PHx3ey/DFBSk6D3KMTjYNLBde7F5rPM=; b=dL/8r0yTzQijXrkM
 6365TnunuKLedgTE2arWYlqtFEe7l9xZO6O93nL7fXwBT//gSqPsMvLX0YrTIAgN
 tqAdeSnfaQLH6esmsQbijp/sAe4r/UQ00jP/WLElCyPK1A0C5qK0SbVluDmRy8sc
 fStPWbtIwJb4Fto1++03ixL3cJKflVMaLDDCqmT8hxwvGk69V2GzHEt/Lv3uBYPH
 UFBzkGC62CDDdZpC9+H0IaILHnr29tJOM/gCRSn+mYq19hfQuY7i7X8M858L5EbO
 xUdCvGq0LSyHcfqlBIGDuqZSremKDHO5x1WZpzd7I5ONrLhtufk32+yvisG9z2/L
 xQCrDQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v1txr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:44:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso5759507eec.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781019857; x=1781624657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wrDt01ffe1p6PHx3ey/DFBSk6D3KMTjYNLBde7F5rPM=;
 b=hgaIAkdcv8bchmdna1jRLQHDhZI/G2x/RIFW8t3wljd2JpEfZaYZFUG5rsobggbcXx
 QdNkMWl7Dg6WE1wigGjafgOVKJNsKHUeJnC/W/oZjxBuMgxkL2LFpY3o9dEMJDMPB/ND
 PW4AnjFs7fVm7ULZyY0flLfXlC/hrYyNoDMP8PAsZRLd3uCVxDJt1Dsv4B4wanZ6i4Eh
 EqXIweR4+uTOZ3aXnOCqOGc9j4fipwhUxaTtJP3GHH79aDvAyV7vgVcdYoCaPw7TJM1L
 2CEMmzR7WjPvs5RTyuYsqqfPhLMfXpYnM31CzgQ4hbUbjsD6mENlGON4U/DCovmJnc2Z
 IIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019857; x=1781624657;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrDt01ffe1p6PHx3ey/DFBSk6D3KMTjYNLBde7F5rPM=;
 b=rfMUJskwU1ygbuDxtI7dbc7XNJS1UHOXOPRaieIJbon/7sFKgxfvTzFl7gOLPc/pKD
 feQxEVqD2uca14g7Nq0Vcw0BR7UmpIWNC2r8unHPrbXYuRVIFOzxebWUekXbtTBl6EYj
 sT7QRXor4M41ZOaKwqMAShPkPAdKjY5Agr9wPQyixszspHbKXkeaZjqScxDsodiueNvr
 7+RsnmxcZrrWa+j/Doe4VqQo/nRiN4N46XpfeaCY7jop+ZizIW1O4E8B3qzzLmx55pw5
 PeLbIIN/ijNjgujiqCDB7erivZ1IhSwzJqJ2V3SKh2f1DxMxNFESBPHQ1UbHeGtmnB63
 uGyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iAzoZPCgAQbV9UHw7iOflB+J/NsYfwvjOImDq5kBfI4aI2CylH0jyE+LKn1b0eddqz2XNHT6z/oxa@nongnu.org
X-Gm-Message-State: AOJu0Yw5mbq/TZLL75dKvRsUi1IBa6ZLjgtplpDgjaAv8CtFy70JnuCy
 TFAqIW4JVMNHLFfYiDkXP//ci8AsexRaIbe8iFEjuVlKlK4kv3V7RJn8jec4hguXl0seBv48wlz
 jmjvJjj6Ktirtp70H9097riu6VJMm3xlM0lzsSVA1RwcG2p1yAWqFUG/MBA==
X-Gm-Gg: Acq92OGns6RupxoaHrGP8QAd/x9RoFb0/mOqiHswh/JmnQX0lyKPFEDiopoI21lvPGT
 EbOapjoiiixn9dY6tJm1fOL9l+ce2ZWWDohhWjvLbeGLLKwDTgmpEYd3BTtCvPwJZwR9itjqknf
 OBW4IH6VXf6Ph8uBL+DrgOJTNF6uDzGHgHzlcknIJvJi3tp5+cDSSVANk5E0Yp1p8pMyuYWuQtS
 BN7QmyuOIoNKJqzNBJI/AwITsG3KJEZVMnSXJ9WTHhKp4SHTXcASmF3cbS4qrEYNv7JC+pKjoiG
 yyI2U+ezenZT1B8jiwUNj0nmkfHfRnVPGFErmlz7HJpr03X1l+l6eZETt8TB5tGcCjqzd7Bil3o
 ERQptvJSzPHTuWPL7G8RCO5XJVS+HdzjgBfxMyFfbk4OcJGutbooRvDx4SxhJGBx5xo8hSG5sTm
 5Yj2Z7XOOELj+dPmk52jCNFChL
X-Received: by 2002:a05:693c:3749:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-3077b75b5demr14126905eec.22.1781019857256; 
 Tue, 09 Jun 2026 08:44:17 -0700 (PDT)
X-Received: by 2002:a05:693c:3749:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-3077b75b5demr14126866eec.22.1781019856616; 
 Tue, 09 Jun 2026 08:44:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3078c1ac378sm13846913eec.1.2026.06.09.08.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:44:15 -0700 (PDT)
Message-ID: <70e1d7d8-b8df-4e31-bfd4-966252d0b1c0@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 08:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: build macOS signed binary as part of the default
 target
To: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260609-macos-default-signed-bin-v1-1-e013ccb5ccb7@meta.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609-macos-default-signed-bin-v1-1-e013ccb5ccb7@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a2834d2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VabnemYjAAAA:8 a=EUspDBNiAAAA:8 a=WBBIVVo1XMhSIsS_LpsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: qCFXdZ_sgOtrU9uuco9RsFoclq-kvJsX
X-Proofpoint-GUID: qCFXdZ_sgOtrU9uuco9RsFoclq-kvJsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0OSBTYWx0ZWRfX35KNFNaO5b6y
 lb2Cx/acnOhEMwamRU0+j6OgBYr37mDbaPGgliS3+XbvNaKZpGmS8kVp7yitsn22MxkZA7DlQzM
 Y/tKfAK7/9fGd2m/zCYg5g3cqyG6jLY1L2s7td6cgXWK/ctldYkAHJ+sMOLb/6dSm25oFWZn1wX
 NFN+h2zvmf+G/DBFp+th8tB7wHDGZjRhN1LzKv5bVacd+pfdTUEfjBOQV/mE+NN0Rwv7bqpvwP4
 SuzgY4Bgr0FwPPSy8VE0Ag2QgryIdL+Aw15dnXr09vx8u/TbF6zxSuR4OarCpTuuW1EYdipOlQM
 bwBtrV3+s5fQ0lwhSXHp7YJVlIvAAAj5/f/3E4BfygOXgCCROZGmGtXNwkr8SsRQrnh+4KH3cCe
 THG5tewqLh54orIaLXhAsaDtBRwHiXz/WCds6+gbaArQT5vBhiS4u+RGPMIsshZZkExiJcvERAn
 natMtjnLy8hRExtgIkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/9/2026 2:13 AM, Emmanuel Blot wrote:
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
> Toolchain on macOS hosts generates unsigned binaries, named with a
> `-unsigned` suffix.
> 
> The default target does not generate a signed version.
> 
> This patch adds the custom target that generates the signed version to
> the build by default target list, only for macOS hosts.
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index 19e123423b..e026851309 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4453,6 +4453,7 @@ foreach target : target_dirs
>        emulators += {exe['name'] : custom_target(exe['name'],
>                     input: build_input,
>                     output: exe['name'],
> +                   build_by_default: true,
>                     command: [entitlement, '@OUTPUT@', '@INPUT@'])
>        }
>  
> 
> ---
> base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
> change-id: 20260609-macos-default-signed-bin-a75612cf7a85
> 
> Best regards,
> --  
> Emmanuel Blot <eblot@meta.com>
> 

Congrats on finding this one! That's the right fix.

I looked around this area and totally missed the fact it was a
custom_target instead of an executable, and since it's never used as a
dependency, it has no reason to be built by default.

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

