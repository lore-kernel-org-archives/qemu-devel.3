Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D861C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CVd-00029L-Cu; Mon, 14 Sep 2026 15:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CVb-000295-6V
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:38:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CVZ-0005Ci-Dg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:38:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYmei1013153
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tl5qJT9zIqWBAUPrNZR/TLtv1Xtl1PnuvXGbp6/tF0U=; b=P9cjfIDQzYT1IYAG
 ynudr3hLfMlnCddRj8QJKcG02IxkNUNkOT2mfPdPIULRNE+aqrFSpZDGi8EMUMsz
 45Ey88kSWpEKzmj6xKXYbfEKF1b7haaXymQaesZtPXrrp4OPLX0kmXpp8HdhFXi8
 upprOub4NoK4gabOysba5wy38y40hXHInyAeYMWxyJuhRsy9Biiy4f8YaHtRMSm+
 nYsjIhRibxVJv8C3W+a4xoU+9LYGbN59Pw5YEOzMiC/QSFbvq707romiLSO5WCJR
 XUBVtm4pqOIyXLyMxKfon4CW+jxbvut4ULAbI62sN/ACQLRxj0qDDKDw39U1UW2m
 oBvAew==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuqab0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:38:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc18ced1a5aso6848027a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414706; x=1790019506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tl5qJT9zIqWBAUPrNZR/TLtv1Xtl1PnuvXGbp6/tF0U=;
 b=JEoilP7m+tHeuxh9sXOVVKY0Fx1X5VT5LOZG4rQxHWG+ZVSISSAQzFB4Kib2rl8iJL
 AXu8GwTU62EDJ05eJ3fMuXbMtGHO4x3bvcediRr9gG6MFEY8OP15HzxPCzoqXBx/XuAF
 PCII+arN97zJId6JXF6bH5MOnneu0GHI7c4dfi3fDwn42ir5OabClzktFZyS8mB41uiL
 rxJvUntoEq+BcnTfazbqdBQ4yZ9p3GPrs217ofCl1aW8/IFgv9SVarcOcGp94CFzsHiJ
 0Nue7q1WMBmoUhZcNQh0yWhAKTG5w/Uu4ZU8SwVjqwjjA0WtD/5aTBDngARURhaSdnyi
 U1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414706; x=1790019506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tl5qJT9zIqWBAUPrNZR/TLtv1Xtl1PnuvXGbp6/tF0U=;
 b=NbEjk2VOczcDPV8UpviCXvuVT+6ov4g/GB9W3iF3zb3v/GeCqFxctFrbpGUzKQzROW
 JU/Hfe452uAQB2+zzXGS18rmX0NqB2Ng0rLsiFLFpFX+NNg5hi9gPGcs8TTtlLVvmQQX
 MRaVx3IycphgQ4Sx2PSzYOYpvW0Bki0ofia4kGBVBrncBJBSXdTYQBWAvswKsvrzGkF2
 yDJc8VVzgZ40XHT9vOEFwx3rJKQqvA3HHfMA0mqVwpNdYT/671Q0lYXiK/AE+LOcI5jf
 nPkZYRgVZ+d7J2BTRGD3fN17TAsPJYPySYfa4/cXaIl1PHLqEYWQHk/YN6fG72mhAQ49
 fIHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoPGL3d6EXx9sqawPPqdvSIm1wnZvp774jmask3dXicAzstH0IHp8bfKke3MAhd2RS0kgyZ9RBl26/@nongnu.org
X-Gm-Message-State: AFuF++lGn65Hj9YUiKeoLkrkKoOJLQzlpKe4STmza6YTMxRZ/abp8MgL
 F1sud2omAlxjoHXm6XaW4CoxaN/YjzMGEViGo3uiyl5WkoOyUKTVM97ZOXjsAgjvPoL2UraVaez
 VNCr8c8YP1pYVQu+i0fORoLAbrpW7hMXfEtbaIz09ITX0u5DACwX1+4ajpA==
X-Gm-Gg: AYBFou14ao2ndlVRiADNelO06sChGwjN/Gg4Bb0cpWcAKhT+XXEg9XeXynoMMnriBUM
 rAcXM5ywhIy1295NUoRRcbay7lM7b/2vdaGH9WKLuxd/rnkrQu61q1MOEpbRz6NK1DGmW42oEli
 GYYSMB0SD+pEMm9/yAVdwG32rsjuMhWEJncEuWlXjTTrv8XukYMscjt92SSPs8dc/IGf38iuMES
 nEje9+b2x1NeiePeLPUXLI2WnslpGLnAjC7yQrLWpng/n2QOCc1lBMrXiVXZF+YpjNvPMmptEVX
 jRSdI0yd0WqulzQypIEaXnPREk2ocSMTkSzliJHMsim0MbRVazzNEYuftuahAyJaQTUNEDXX6TD
 t+xHboLS8sibUrQ7K325b47CKTlFVuVsVctrbo2lOiZCkWrUT4t7qAwY47mk2RMXsgAqj
X-Received: by 2002:a05:6a21:6f09:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3db4051cbbemr7690821637.12.1789414706193; 
 Mon, 14 Sep 2026 12:38:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f09:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3db4051cbbemr7690769637.12.1789414705793; 
 Mon, 14 Sep 2026 12:38:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ee07f2sm25353444eec.18.2026.09.14.12.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:38:25 -0700 (PDT)
Message-ID: <d6605e3f-5175-4244-8fd2-9c3a6285b811@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] tests/functional/hexagon: add HVX tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, marco.liebel@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
References: <20260914155134.2191912-1-brian.cain@oss.qualcomm.com>
 <20260914155134.2191912-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260914155134.2191912-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OSBTYWx0ZWRfX9YWss7xQ08Q9
 DpbkXZm9Y99/z+6uVNWJHYwghicf+jFOg3sZBNNre5z6jBM4j6FkhmfeIv7WZvorlNU0u8Qs/aN
 9Zj7ujD1P4MnIRo1tjNy/SVuvIy3ZPaU1pU8fVFeMjwqMafRmwN7aVlCwZXhGG/n1hetSCKyPFV
 AkJxA6KdE2Hv7Plg9cVbbR2g+k24SXg2mcqjhUr3LH2JafNFOOl0o2gl+Suv0CLwnqW5a6M6AMq
 oaHP+6S0mX0jzrGMtl+m+HZhqGnE6meHEhRaM2rq5UmXXV6vbp+ASWzRmHatceHkkcpY3sNUcXD
 hAl+5/fN43zTkLtEb3aqeo0J7MsW80F1tdBVNG13KETlX+USrCl8kxk94U+CqjThi7Gr0ITKeNP
 IcIAT6WsIMQelLVRD8f91pevXcWnXvvDZq3mpkatO0QYv+vQVkYTXwOUdUy8OJx26nTYbZz3Gm1
 wXewHj2ac3JZ3dUdMUg==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa84d33 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Y7J_grYvzkkogfXX_o0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: kqAKEvUYlt4MEL4zWJEoOs4lRHHtu7wC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OSBTYWx0ZWRfXw/a/fJ9jQVSM
 +IzcXWc0qt444KsobjBXilrc5fmsPy9YJcNE1Kgfpg4V1hjzA5W2YIcSf4gnuAVeEanNZUGERMZ
 pZOzZRqczR6U94lUtdIjmr81bghKjHM=
X-Proofpoint-GUID: kqAKEvUYlt4MEL4zWJEoOs4lRHHtu7wC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140279
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/14/2026 8:51 AM, Brian Cain wrote:
> These tests pass now that HVX is modeled for system emulation.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 7 +++++++
>  tests/functional/hexagon/test_systests.py   | 6 ++++++
>  2 files changed, 13 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

