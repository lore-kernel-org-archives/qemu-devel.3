Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA6CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCcU-00060n-K2; Mon, 12 Oct 2026 05:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGCcT-00060X-4S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:46:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGCcR-0008AN-GC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:46:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8LETC1754822
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PSklA+5UKvRrwa1xxzJWTWgNmM2ZYrymyyUyj1CxUIc=; b=E/1ZjuT+dN3CCO5y
 AalncS+BGvVcSDsw4bh7zEC+Y3dy9lPgp9YsIAUsAPMSzzToH+SvRni7pDk19JaF
 RKeuDgBmDOVqk43ah2vbSFyJCI8Yp2utRUuttpYaey2x7Zh1l9pplbR+B67qMh74
 +Jss16Avr2Vrgak74wiAieO8ofmAIvUcFP0ZW1J4qe6tHpNN3v5u9FNCpHMYZCzo
 fh/H4vyocxqNl8CmOzGebUOzcbNEXCjieBQmx3Evt/R+9+pCqAVwks+6lLhdoVHY
 urseVOgfnwxEEW1EUfAyUAZ6ztvL0Xc6mav+G2rQP5dOCBNQip0aK9Gl7oKWpA08
 PPWz2g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j7126ft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:46:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso306592085a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791798406; x=1792403206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSklA+5UKvRrwa1xxzJWTWgNmM2ZYrymyyUyj1CxUIc=;
 b=OqvlehatXPlRFKJ8iA01RxmcylCGq0AOOqPDk5NpRetawbNdXfqJ6RuNG75NLyAbm4
 iqQG6B2dRIlfcaf9DK+8EFRA5buEAPdfYTRV1kNJKVTfKQhUvv3uu+0W9oWeohvFzpMv
 aJ8uUh4xCTA6aA4NlA7QHPGrG4O0/DXdoMy46LpC6W/kvSM0Tizn/4+0cSs21E7WxIO2
 SYm+2I5MQZh3E4RUAt2xcdZQpVpB7IfGCeNDWY6eByghlLr9ravb2+iH7PDlKSKh0Wj8
 M3G/NwN8wHugzK8Sp1+N1Hm5ogO81ZjFs23Sbg1NFB4vXHf/E8K22c0LD96pfaxMT5/5
 9htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798406; x=1792403206;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSklA+5UKvRrwa1xxzJWTWgNmM2ZYrymyyUyj1CxUIc=;
 b=2G4ou+v1InxP/6Hl4qIDZonaEbDADOUjrt5EtZ9QQp6yUrDZc1Oa7c9/TbprB7o4r/
 fBOuVDSK/2qI67BS6M+NU93uPAd1nv2X56ALlaDb2kfTKsPhBSCw1Q7gF+nQutDFTi32
 UYv37XKHMLrCy/xv6At8eV8sAY0wVC6r8gdccL/XX5WaxcRJ1bRr4CG0GajeJoHyglj0
 SyXt/wNgzrD3FDEDHNmfZKbQ5z5LlcqvwA2JCqkcEJ4uWqT1Z+KpKGfXP86b+Cj8OH4g
 qvSvxne7vxORrRR0GI9cj0m2LeGYquMDhPfWi1xF4KEy1yyG8LI3+ggd4FmFsUhHlc2H
 pgGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzowDaSYKVyceAvDZxObUy3dbWQ7qzlRTGGeg8vhH9FCgQ6fPiZito2Acr4X/oEVrHReh4qpa0FXy8O@nongnu.org
X-Gm-Message-State: AFq9FYK5EgIjqF4iSNpkFNRPe0chQtg/keaakoXAMpa88mwghsAPyn6/
 ddOualPs/Y4sg62UtpWM7M1YQx497G4hdEJCbVRbCXEmkQUXt+UCSYCrMvOhBmh4PphSOK8eu+h
 8w1San+S8WzfuczeT1YhN5CWH/NUoQb4T1ZkAtZTKtqQYSkRKHgB+qPoy4A==
X-Gm-Gg: AYBFou1qvmZxWlo7DN08SNUwvNJPg/VKM2x7UW0XXXAr74Nh/3y9D7nUbHkc/DY92nV
 NO7NkZRaC92Xg3X44lPol/NyK7QV36YuY2ATPHLmjIpyw3qQuzhl9Gb0Gz1ASUaucQVyEFtpeUc
 aRuQ5yJn+1ulsdfy1CiFocntqG8ErpMJGym3ZxJPZ4nBSj+4+TvgeE98JfXs/PVKvOXR2i3Rq9K
 ADxOPpYvVBbEKeOUP46NQx8zPMkKzJzCjWAMYD6TleACFkWPSiVd4cOWCVyNm6isPS+xEBtCXle
 eEqCc3FHd2twPE/DncygPzF4OA3DUUY3rTAWokS6atzwQczjxG/Ll7CfW8ANP/GzNs7JzET1drv
 nWZXhX2CMOAWM1WV08qwb5IFnzMzSiRlSHw==
X-Received: by 2002:a05:620a:63c7:b0:93b:d79b:9a57 with SMTP id
 af79cd13be357-93ebd274840mr1330852285a.56.1791798405601; 
 Mon, 12 Oct 2026 02:46:45 -0700 (PDT)
X-Received: by 2002:a05:620a:63c7:b0:93b:d79b:9a57 with SMTP id
 af79cd13be357-93ebd274840mr1330851285a.56.1791798405151; 
 Mon, 12 Oct 2026 02:46:45 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm270044145e9.6.2026.10.12.02.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:46:44 -0700 (PDT)
Message-ID: <146339c0-79a8-49f0-ae11-cf3d0b98c107@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 11:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/riscv64: remove forgotten
 Makefile.softmmu-target
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261010225351.79098-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261010225351.79098-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfXykurSO8Vx0xn
 2niRMIQp4L3riDnqh/WoCre+NOW5Cyp1jxiuoQNRqFYLWK1BIGLZpRxA06ZgpU1N/GeGHO0WdV4
 K3G+annB0702mKjaZvGEHfKa3gPLG1c=
X-Proofpoint-GUID: 6xKcRbLgK6PCKtlh2x_m17TmWn7APxuF
X-Proofpoint-ORIG-GUID: 6xKcRbLgK6PCKtlh2x_m17TmWn7APxuF
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6accac8b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX8VX7YUbSXTcb
 UdKGiAtUxZ0REYOWy3oIwAdzgIUgipeY7rxjf68SZgYHxLI7TStPctBLIxC+xVP2uP/26x0GKHS
 jBba8I5bu5dXaQU8xemcqvAIXGqVjWj6euYAQEe9v+LHM/L60TJ3m5nDktA9910ESgNOx0y2s/l
 Ner5zZvnvPtVkObvH2gTflw1arRkl0uvfrzX0xN477cLzyuwR73p7pqll7pLivYgY5AQtmCfK09
 jnqaxTCGJsDrh2on/cLB4L/eVpyxx7s5/lQIxDqn+NLRsJWG8BHVz4K8iAV8JZ9HHVFZOhYIXlB
 pqwzoYk3/Lsxyhcs/g49LaM7G57rae6/eZ31m6/W2f2bjWfkCounn2EU0jVwAoryDy5DjVRkxi5
 uL1Cna+qu16IADnD9Y2oNuxaYfd/fLsWcZGyEUdVHF6Ji7lidFBQb7YZwvTxUb0vze7XaAGL/AC
 MazWQhgwDEmUWuNajYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120038
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

On 11/10/26 00:53, Pierrick Bouvier wrote:
> During meson transition, this makefile was left. Its content has been
> correctly ported to tests/tcg/riscv64/system/meson.build, but file was
> left.
> 
> Fixes: 57ad9fe2596 "tests/tcg/riscv64: system tests"
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/riscv64/Makefile.softmmu-target | 89 -----------------------
>   1 file changed, 89 deletions(-)
>   delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

