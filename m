Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9818FC9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8r3-0002rw-7o; Mon, 28 Sep 2026 06:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8r1-0002qX-5H
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:45:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8qz-00050k-Ih
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:45:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MH9G546968
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b+sQL7hQ/v8IgULFeBm+3lyYyIRCONZvvWGf+Ma0BKw=; b=CytOdFcZhuiNShXh
 Tg3TxQ4PoPMLbdpbkfspYnqFI5BOTSUY9LEErvshQNge5EiOqs5tJd+RB9GgZ591
 pfmAoNWAyV/sGpgw9B48W1D2fodZdd05GsCUWArTv2ALrJYdLY3S8wkY4IgPqjLc
 LE6HxqVIYn5D2z78gJFw64+FBdSuzCNdbMtKY2S8xoNvwMu0y6RJGbdXldZ3CngS
 H3Jff2eQ0g6AMy4SMoQwrLUYN7K3ZoJVa6qWgQF/JYn9KsZZKskMhXU38Fs48YKf
 OBjht2d3YDwergdqq8xDdMm76uZcRt4jnQdD2yGPvYdrAcbWPMclynwBxPs4h5bT
 1Zq6/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4a397-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:45:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so540678485a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790592299; x=1791197099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+sQL7hQ/v8IgULFeBm+3lyYyIRCONZvvWGf+Ma0BKw=;
 b=YGjL1yLJTOYuwqMf+18ESwir7eh+qcdLMWCb/RLUt+PmIe9qrWUuwqE1nMrV41Wq0A
 7UjoqRcGmA2Fmubi7mKXkrOI3gr0M+htkFErqxoT/OurTlEEbq38oBx4Trwp1onyuVbW
 TLNhdeOwbDULYnQWv8FbuHD+2v1nM5z3YQgka91r/X71kCr/1SCQlpg7y34yGNp50Dix
 GJpDHEgoILzkh+sFU3bAmW1emkRuG7ana8pt/SKZzMteMPUM0cr+N2bVsCMTRwxnd7yd
 aIFCxb0sGA59RVcss1Rgkd5OHahsaxbMsBwMfKc+rutR2LyQ5mqiXvfzRcBiB/No37wu
 W6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790592299; x=1791197099;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+sQL7hQ/v8IgULFeBm+3lyYyIRCONZvvWGf+Ma0BKw=;
 b=N72tYcBKJbrEeP/6tJFTRUc9qO8+YR1iEWA8W5g5opHLaBWRAXFpqM0UO38mNlmhad
 e6seCpcbtImi/ER15KoKFNSwO6mHUSuCN1f5AwtLDEcX7hD5C6HcWT3ozSjXUurQkEM9
 ZdXEI4mmLQn+Ro+/gYnwRf80CPgFBGog7/62hwKGXbaB8QKaWSezKPIXy8Dk0AzlV27n
 zqYlrQG95QIsXcF4hsK3EqEF8Ui44pKWw52v1u54lDEFEl24ZkZCLEX+AUJMFXuxz/2b
 l6ahicVSbNtQu7KlEshKzNRqW4qXdjBU0CiSLAU3csZ41nUjGlnALD5cqp945xGSKipE
 BvAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvx5mEClqDAjG/XWUfzCdnWFFPDH22r4IJwVF+P2VfFOf0pvg8WZXswJQeJWu0HgHlLmmDvENR3aWK@nongnu.org
X-Gm-Message-State: AFuF++lfa4cgM63m15n8c5NBg5v30iXSuS2i+1oseZ+jD7jNj8D7G8BD
 VKGLIXCCpmF1WRrSpGBkQY1iL8/aNuSE694rct0S1iQVvufJsxJkzgscsGLSnwKbvduXb3Ni7V1
 Esb7C+3aUBFIMhqCXcXwdHrKj3TVaK7xW7xnCnyHh3acNrEdxxXam1GzaMfe+qnUOUw==
X-Gm-Gg: AYBFou13X9PnCLWdYytwfgkrP9KlTUG7ZTH0mDQxbK6trB4iwfx2rh0SD378O8GjuZu
 rkVUrAvJXzsEU9M+hqoO/0erqQ8kufDU9/zOyCDIn0M7VyHEEGB0hUHObEw5CWlXyOnTCVmbGzy
 RukslUVLz3i3Va0OPsDklP9BviF8fzgPsObM6yTVNhiO61QcNr4uVBCswHmri/l/iUH6EctzQHK
 9jM8MCn3/ZX8Uv9DMnfRt+A2wuyf8fBTQEG0brR8I+S/Aqp3Eh+vAe45FaqBIrtNlVEA+AD3Jsu
 FRE8a8bicIhwCmCU3NnGEkiFOg5mpAco87lQPzl41B2WtG6vu9OUqO1/OSo01qwp0oSUTswLNZt
 uFJVs0EYCxr2NSJOCHNmHKPAftP09aWd81A==
X-Received: by 2002:a05:620a:4692:b0:93b:d8b3:f9ca with SMTP id
 af79cd13be357-93c43be702fmr1954766085a.21.1790592299123; 
 Mon, 28 Sep 2026 03:44:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4692:b0:93b:d8b3:f9ca with SMTP id
 af79cd13be357-93c43be702fmr1954763885a.21.1790592298689; 
 Mon, 28 Sep 2026 03:44:58 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354c47sm27965634f8f.15.2026.09.28.03.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:44:58 -0700 (PDT)
Message-ID: <d91922bd-444a-4544-9775-f28507c2ae8d@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 076/101] tcg: Generic expansion of tcg_gen_ussub_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-77-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-77-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u7cL5LIWTQm5n4gcei2Bi2gml5GgS0sG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX/wygimxAnO/i
 EeJkY3R5u9frW9aYR0jZ7EJlk4mrL2jKs/gds8auq00ORmRphCszE77uBlm6P1XS2mOCc2AgmMq
 +wrH7uZuzMALtlPrzEpJajO7t+mUW2TAhNn7jv43fs/vK6+4c+2JG3T8YlU7irIzD2GNT+qCzJw
 WlznbmRkEw2PWrzYnQy3l5NVLtOIM8jGYi5Bz4jNKgWHE2Twai2ed3Bxf1x4TVNnWdIoac8zRMv
 yoSxOQ6Z0dhuoJwf7lVYRNC6k+w9ps11MiqGkeggRMwdg0F0QMoX+BlvYVL0VQQEd0lVsiMHvMG
 psByL2ZbNc6HaXBVBP0IY60bY7nDPSlf2p6J3Mh1Hg6hBCtFuwmgrwmPKGBhA85cJO/Fj0q6AjS
 x8zI83ZHmo/Y8zSBRX8JoMBP+iii76agSSiThLQYgW0Rsh3xCiNUtpbKlW3ovTUtvM1LGscXA60
 k2aagEIbJZT9hn4ZFDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MiBTYWx0ZWRfX3mtXoteKusra
 TpkgdXP8aXQSETIsgiCtgrV7jlO/mmhKjT+OHsXdqKdFiTvWmg81DVFMVtBwh54AIRpaIEtvRHp
 EAeD64prqbbRRc6Oq8fkC8rdjsUxjBc=
X-Proofpoint-ORIG-GUID: u7cL5LIWTQm5n4gcei2Bi2gml5GgS0sG
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba452c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280042
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 29 +++++++++--------------------
>   3 files changed, 10 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

