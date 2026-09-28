Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03685CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB87t-0002G9-4Q; Mon, 28 Sep 2026 05:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87o-0002Ee-8K
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB87m-0000FW-Ix
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:58:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MHQU2057736
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=; b=hIDzYnI5WqhozZ78
 fkg7mVO+f9SPdvYs/gsUTeogeoRN28rkRrswwpXUAvSWQB7/bL1kvD4NC8DKmgz6
 G4IOb9uaV4QQGzI/vUcyOEcwEXot+JletBN36rMArIPjHkvBwPR5FyAqsHIBeB1k
 M5KZh1AFRm99Z6BDgZYIewhMNjhFJPTBb1NS8aS0pfEgbtnTgC8POPdk8iWYrq9/
 763SFOV3WGjQDBK3IUqFSrLF39/q0CKbbVJvHLQh3SK1UxAqTMMzf6sxrEYCroAK
 mnGQyUsq7Oz5mljtBVBrhM1oUO6R7q+a0E6pONGFbsdz+3v/VXPTlPWfLihZzs6F
 5ovJ8A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubh12n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:58:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91454ecbd2fso37123316d6.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589496; x=1791194296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=;
 b=CZM5WIl5CZXfsLv+CpFXN/3+Y6kXXaJtgZ4b/ccQ8bRoOpcCkv+20NoEqbpe8TwMG+
 hMVbjQsDZxuQOHRqtH0IHx93wykh9I823iVR9LUWITpsJ0eqQ+VKxa0gnkA9javWzrdd
 2r0okczRz0sjsOQv7xKjD8eEJwlpOQm9tGV62yBEJOFqWyoZ82wsvb3Pg034JfiDpeLC
 TkM/0QkOWOPelTgn6hpTR+/nvcJ3cICC+N2qBu71htPhnOZ/RH59rdFBFK55wSMA+Li6
 nyuQ5hGtBcYjoC2VPwOYrpOx5ut6JF22TJPk5pKUb5A/tObqphJDc6dw3QQ2Ca15Upjq
 YZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589496; x=1791194296;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sqJEb65OHWhpd6ahNeiHBKCTBjRAXv/4eeMXcpCF2zs=;
 b=vq8p1KzQXdkz5PSaGnsrs9zUrUwFdVzQlLaDNv81UFccxsPXHtxChkdk6IXKy09z81
 5fAwdsgTwpL7E55LbGgPam9aXSWNpLknDMxeSmTlthdesg3971boZ/C30wJRne3+cZYg
 1qx0nclTAGt/BiF2EWzMCD+UPJ7Hn6b3Iu0SmDCv1gu2o1dAUYUHgWEwKG4DD0P+ig6T
 Wo84TzypgWutNt3zdjvBZcs0WPqezDDPQaCfit9nPawasGQjd17+r0aGTJYGfpiqLl6+
 wdTlNSi29gJ6JZE6kp7MgxqT0kRFF5vXMOKWQvzAl/MYhqG7abQSY/WIa/Igha+7KH8n
 b6sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFyiuod36g2obTe7rdIMpjOnrh817CQbLQCyN3kKoBEcJC9ONEkOhXeGGhivvQHuicy+GXvI2kFqwn@nongnu.org
X-Gm-Message-State: AFuF++nfjwHhWd1SLgciup2gPm7AMjR3EyYPu5DeM9AOpzRyCzW7DjSw
 MrIf/Y1UncMJkC9A/sc+6SzOt5o/tiBuTGoNhpkPZXdwCBDQgxNQxNhs/L680F/fuBx608dNboP
 7s8UHDjjPDnR8kultdShO+syJMXWEKrwEvJy2YOMfHgXvER1jUfRjRWgXTA==
X-Gm-Gg: AYBFou2BYswZzJxeZQLAmVvnSLxW1Ecq58Z7v1uUQDJaT/V0x8wpui00At+ctCDj0+W
 vDGJhxSJeYLbMeLfXdE2HWfOS/7dBwT9RZBLkQvqZv3xmI7TUm3ssX2plqKPqiZ8OosAmHfafk9
 KlDkPF9aXiY2QOhZbOae1mAU6w2dJHMjYDJpAQJ64wBG3aAJAVpV2xASBwxYKeIXzAEPS0cZoFh
 qQ9q1H+qbSRz2sd7WSEcge+IftKHg+h5/bUbwYAu18Jj+aL46nm5XpclrARVxqGb/7HgnAoWERZ
 As05IsGy58IVouV8wIllEPf4+BHl3jMtW923XTS4S2UYZH/DZAwNhppPKN1tVFLJ7uGdcYIX5U3
 wG/6jLNmAs0J4zercTjTZE4rdtgM/nJweNA==
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-93c43cfd3cdmr1915560185a.25.1790589496140; 
 Mon, 28 Sep 2026 02:58:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-93c43cfd3cdmr1915557985a.25.1790589495667; 
 Mon, 28 Sep 2026 02:58:15 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0016a8c2asm133527555e9.0.2026.09.28.02.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:58:15 -0700 (PDT)
Message-ID: <e0c2ac8d-e774-4a49-bb6d-5b9f755ad756@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 090/101] tcg: Generic expansion of tcg_gen_ld8u_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-91-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-91-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 11qFWArJBCDIoFT8okRJdG6DRyLjeGWv
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba3a39 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 11qFWArJBCDIoFT8okRJdG6DRyLjeGWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX1WPqFFtWZd/e
 7vF6BJT7k2NPTbdaxb1GmQU3p8RzD4ch/z7vLsH3A6nfGh4ORGmJkbB6f+bCVYYhY3Rpbf6n09s
 41mBeX82zjdf/TNTV1ai7wXrkbv1VigTIBAP8GEmhrlD23vIGMq85XYjgMBBQ2Pc9bAC4Cs4Ogr
 n1ZfVJhp0u8eJiRtAPyyV4N5AZjwpmas83dAtPNUd1/oQZoDXEc8vd20rkc+PhjksKaZaPxRj0M
 dPzNFg/WTNk012M+hLhrMDVBxN1Eapk2sc7ygJpDpIIN8pKc6WCqB7eFGzWFULN034kg5VM9gls
 9T6HEdr219J8e3J1jcFIupg5AJk94SBUv1YbL/C8376ddT62JhMBUivCikODkLTYOZ3DhBiLfew
 pZN66ui5yTr3ru2PV9ZsWnkmFuS09eK5/zzE2XYV5nhHBfUJA9cWXlNitAfS35a5650aLLG7Lqe
 80oje212CoyZZj0kLpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXw58mXi9lopQm
 CUISkRjVRn+T5ubAIppu9EVaJarIY3O4bdWm0+XN799i69lTO2aGcMtrfRi1jTyGkGw837DQbeZ
 P82GkF1dDYaHsM6e0HjvLPiJMK+eGo0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280039
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 16 ++++++----------
>   3 files changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

