Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70563606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VCenN1te;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=elgkxJuN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKENT-00089W-B2; Fri, 23 Oct 2026 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENO-00087b-RY
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKENM-0004PA-Qt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:28:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAUDv2164238
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tl+HxAs841e2SSvgyZ6QvvuWw+0V85CwWXn6j88yrO8=; b=VCenN1teRuAnrfk3
 rDV4a8fJn1w71sXE1U6mF2ef40DgYE9r9erQwkDaxAAKt3pjRb4+RD59TnIMjrks
 nyuuW8SQ3E9F9VbpozhePYN6qANDOimQpcERz8K5YT+0nUQm2xXso+AcmxdqdqTw
 AvlKiO4ysiULQMXJVM/UadW3mMbazr2XoYMwFgYqUIqHUW3PPNBtaL6bCLBXgUaU
 +Xe22EJfLqlxKCpNkFryc7Qtekpqu96WvUPWcs7zn6wBeAiMxG3XwH5zuSJ7TW3v
 bBUc3t54XVj9QOcwxqIEohINaHghwAO+VcvON0rX99CWY6DnE8nluA8tQRd2qFyq
 IQnpew==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahv2yn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:27:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c5ab5c136so127514285a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792758476; x=1793363276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tl+HxAs841e2SSvgyZ6QvvuWw+0V85CwWXn6j88yrO8=;
 b=elgkxJuNCqBq3To5mi0UyloU4nXXUCkFXnF6aFVYQ08cQGyC01r6mI3S//YQ6ea/Dz
 quFqkGGLTcNGfFZD7UrAguxiTPZUOIveeZEYKwTGQ9TwVSWdVjrxIv5FKgbQibkr2CNz
 1BdJjx2xZm+Z94eOgPO4jd/XM6xtPzMfTD/04hAmSbw1km+9h+UESfFSTaGEtDM4v5+/
 rmfWSlyztvCGKHsZpaQhBbMS6wJb9uol6Ak7OlZTGav7eurdMu2kFUKsv5heUSoA++PA
 wiY2891NNdZEHtqx4m7rS8/0qQNDEEqXx9n+i/LhHbWmhltjiwTrprVtKVZV0F1TWN82
 nZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758476; x=1793363276;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tl+HxAs841e2SSvgyZ6QvvuWw+0V85CwWXn6j88yrO8=;
 b=YgWIJ+ivlgwrHUBHaCdYYk2wtcdOsp4glXgKf/678TJKgpVzqM9ZQJD8YB8GeVwVbS
 TELR7l8i2+pgeS8kUTu2CZzskRO7cgFEkWlFWWiUkHuRecOzklCsSnPJw0e9PzFGdUIv
 PQgIif1HQXoeq//ee6GAIGkMxQ5E4tqwduWi/HrXjvZf+ZXaWoRxG0k17hYDUQlN2EvB
 YjNJy/ebO0bw88+O19ZVKooSjL/0zZWTeo8oVR5YBHkgsAh8Iz0G6RzvRNa1bu17jqrg
 mmeljX2WVarNEj4DAHXQXFJfKyogWgOWLIWYCQ0PFgAnsz6DqVCiTUVEMarLFoQpMg/9
 awIw==
X-Forwarded-Encrypted: i=1;
 AKwUvByERySunVJPZA+w7y9mEEWFf9iZHlzLx/fcC6wuvexj+A4DD07+aiprAoVu/MIjQYZnpwceQ7zBlkcG@nongnu.org
X-Gm-Message-State: AFq9FYKDYTH3nAz1bx+sr7Biivz8HDgjDJQuX+UE9SeeShYDTY5vMWGN
 c2jXmFROrPvKrMjFJOb6k2FVWZNA4EpDpCjvP5oiTFCtNFOTLiiNw8SdjSOv5BN6a8zxmkIT9dk
 g+qRGZa0F4FbjLBteXAYdiCJ9lsYghYzzhLNYNsg2roqUSm+nH5TiUHYWvw==
X-Gm-Gg: AYBFou0yLXhMUlUZDIZsm8kedWqzHMIexpihNP29onLLO6/Hj0Dnr4z0rzMyjqwMpJu
 fSl1mHBrKP2JEd67198awZ8s1I5PggNGSopj0eqomFE9qRRmqDfuulidBkma1xD2UYXQ7aDkrR4
 QmMGO5KNwFNUTydzlyTEM6YkoTkCIryz4rwfmgBCK7TJGJwdm+triL42m+ltLd2izDXd4O3ODIe
 FxDOxjsX0Y2S0E7m+qg5CeduZ/sYL0YNKZhjnyOfDF1Xcg/mDold64Tg6hC8kTnh79IyvNGowL/
 s7+w7thPYcb9biHlhvyHrGNyE0hIoFTVvageHdG98wphGpOuNLa7kx3g9880CscoiqxS3/A2CaK
 ZDvLn8EM7l9m4dTMVdtavfjFDXgEBwK/7ew==
X-Received: by 2002:a05:620a:c4d:b0:93f:3565:813 with SMTP id
 af79cd13be357-93f6f54c963mr352782485a.9.1792758476004; 
 Fri, 23 Oct 2026 05:27:56 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93f:3565:813 with SMTP id
 af79cd13be357-93f6f54c963mr352777985a.9.1792758475412; 
 Fri, 23 Oct 2026 05:27:55 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edfb3fsm5345203f8f.8.2026.10.23.05.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:27:54 -0700 (PDT)
Message-ID: <7af3fdeb-2b1a-410b-8652-cda97ab2fe80@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:27:52 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/hppa: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX4DIajccDUxOR
 8FybLNfV3CQXhSYQG/9hQZsMSqEHYKFbLSlnE5aDi0d01P2lw31xPXhskctNRAGENeBHO+SN7YL
 VgE7B9uiX07reZEKUlArnu2nZp90xbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX/Kc9uNn3W5Ct
 JAUTipE/n77HQuvJD4Dhv8SbqAQJlqV6F3GzgAXKI4+tfIYcXjob3yAX76P2pV3RVa8uWxXMDqr
 yLSung1yHib2a6ylgE+B/yCVeqXscb0yF7E4wzHHPz1alQoGsy8IQ0dLLHtcvKnmlkU8R9MuvhH
 9lgmfhd4szMuAKZ4czDa7rgeCyhqJKKQV1kCnSmXCWnBg+I4D2M/YNZHURKEf/YBz+qgx+oAYs/
 jg+RiueatakYjB9msUC1rpiSPhC7tYrZC4ewWCZsTnuVo3sMTXoD1wOOCkaCoGutb6rpDZ6v8Sy
 deEIfaDWBq3U9wGnr+eo2pwcJz2fMd3e4C23KN6Gh1pEM1Z0nzoT+7/n0NL4kODwHT89kQfZ9SG
 Mbl0mjXOd6v4I/0+/DAUXlM6nkOrjXPTx506eowdHNQmInv+4zSWyaiMn1La8cJNQzlne9YtkTH
 lQiMq2e34J09vbLoE9A==
X-Proofpoint-GUID: 2idV0hNMoGncE3XSCVySSVsYs99OAuZj
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb52cc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xh7zxzmAFXcAh5Y_SQ4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2idV0hNMoGncE3XSCVySSVsYs99OAuZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 14:58, Peter Maydell wrote:
> Convert hppa to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hppa/cpu.h        |  3 ++-
>   target/hppa/cpu.c        |  2 +-
>   target/hppa/mem_helper.c | 21 ++++++++++++++++-----
>   3 files changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

