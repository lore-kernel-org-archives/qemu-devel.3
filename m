Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27449C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX5b-0005ao-8p; Sun, 02 Aug 2026 10:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX5Z-0005Zs-Vl
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:22:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX5X-0007Eh-Jl
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:22:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6klJ1487430
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d2q/reO8uZ2KyZcixC78w9InMfLs/52Fjo3ODSBEwG4=; b=BFInt2XmmwmBSJqV
 xvjydH+fc8wQyn+1s6Vmc0gQ/Knl5NcBFM8Mf2lP7ESvu3ZP+/vFxpV22Io/pQOj
 5JO2x3jacyH2JJga5Xo5gUWtbnAi/G5HLyR0JNHk9vpFIeurUgxRf3jDxbiw2QVD
 Metf74YJuInXURieNcZiZXnJOjB+C3F2CtLKgH6h9bciZoy+bqEj2T/UjfSKw/8Y
 qfbAjnePCzGMvTyRIwueNxb/oScc+f2s70SJKwYibaFnp7FOn7JxzCi0O2mim+X/
 8yU2iQMxwcLIEU5gC/v4TwZTFiEiKnRetg72Eu/wAm8RzG47NJQj9doBYqIYWf9I
 lG47AQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6k08b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:22:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a97644aso25344781cf.2
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680570; x=1786285370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d2q/reO8uZ2KyZcixC78w9InMfLs/52Fjo3ODSBEwG4=;
 b=EZnYW/QKlTQR3jIRysQk/ViZ99adBBgBZHB4bqbk3kAoaCl6NtXMS2GFXCZ6FDnEDW
 euvgXtETMAo3hHG09NCTAo9if6Wn+0i204DLTLnzDG71dYnHhopE4xDZ6AkifjSULmX/
 ms8gpUZp6Nq1sScdJz5V/UkONDeQ8JD0yUZkPAEOJj+oDkSeJ6b34IF+krwMOhrkxYBz
 AW6Qt6p1pPnd0KMV2JyNeKDwqK9QkMjeNHvUfibEhP/wBnvJtqJDDVuLulZmszVSVXBQ
 6swLXqnn+AsZ0TRzbjxhz0qlewBRgTypwnIrY1ppix+zcX0eaNOoQtNMy6c7Pr5Vsn0L
 zqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680570; x=1786285370;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d2q/reO8uZ2KyZcixC78w9InMfLs/52Fjo3ODSBEwG4=;
 b=osf8Zi8h7Lkc/FNha3u+Ar6AH1INTaXJHXcbF0zqztK1NJXPJSBwBMxRbSZ9b1TiHC
 fRdlDXU5NhYKK97zHqA5pcPf3I4vcpJemvB4oaXSWgPl4pm7EYmq5V4nz/oVXKOWgy8j
 gw+GlWmE+jvK7KZKiMzShWPik255qhXNXjQYxCmjA1EtidivI9wltByoHoWWn+d4zKyS
 KlPRxt0TWZEbGuCmQYz5XUlcZsgiHkRvL0MF65BHaSwyjdwkmv7L8cIaUR4Owlh1xyZ4
 F5vlVJt/WWmGlMI8a3H73dk42tzppcGnoUiWZC8GSnOeO/AD25YH9RKtj3uJpemmLKIL
 voyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrl/g6lDcuxFKfERXpnG5VqncdUQSY5Tcu2m7s2F4kpcWfU3ymHxQ8yMw4APC1vSHA4Bfha7wFm7Z3z@nongnu.org
X-Gm-Message-State: AOJu0YywQI3uOQn6ievtTkFQpIswl/SAo4Yfd9AmbV8ZaSZNGoUPtCE7
 dEfRhzC8/KJ+lhmDoJd1EMcie1OESEP+VqNoWxuVR8rnv1017UmoNqNKsb/Su3IsgsH7xTgFhqz
 JKq7QpSSBqARYJm3eENB6wbaQNco7TN/AV6NZutjK3CgigJQGe7XjWeHNme8RQOP12A==
X-Gm-Gg: AR+sD10DU6bDv9W37HdOTEE5em7EG6bHt1fSrM9om7m0g7KLZ0i1clXmAs0PQ0+VDkG
 wqYQjssN34zJkzdCJf9wH1Nkl5Ad5eOtxo7BSvxlhUbhLzyqUvgIjOvLpuLvUVuRxeNNEsCFzxv
 VTsP7gOcHXUMb83LHVE6hxMp7XGalLuXYxhckMPQ+NGRn/ol1JW7uaZLafMNcCrPjf/rLS5uCEo
 c32wLRsCHWWR437EI1H25eoo407X5Xg1Aqs30dZtFqUeOkGVng56H+5XX4411mHVgE5yQKjNAY4
 g+lnsjg6Vti0uKPJV6Vc/DSoNfQ/RcRq2cBqq1vhkJ6HPSvqp3Xyqgr3r+wX4ZxM5zGJHnPTTMv
 1h2Ssof0ptTz5CCLERVCNIBqYC2+uJE5d+4GqTq6/I18+lO/hVqA=
X-Received: by 2002:a05:622a:5147:b0:51c:1ec5:d00 with SMTP id
 d75a77b69052e-52b56854622mr133007821cf.44.1785680569769; 
 Sun, 02 Aug 2026 07:22:49 -0700 (PDT)
X-Received: by 2002:a05:622a:5147:b0:51c:1ec5:d00 with SMTP id
 d75a77b69052e-52b56854622mr133007321cf.44.1785680569311; 
 Sun, 02 Aug 2026 07:22:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b21e66sm127715405e9.0.2026.08.02.07.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:22:48 -0700 (PDT)
Message-ID: <a6d1d127-3007-4efb-9d30-aec89f2c4f4b@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/s390x: Use op_ld for LOAD REVERSED
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfX8FqzvyOO5clW
 LkeE+7slODnOAjP/x+y/DNzOVa98wOYX+UdvVzyDEt6VfZQF2bQXgrPsDhMaTAnYmWTxYIZSVmN
 9ehXjecOn90NaeDO0i1Wed9eq0nlA2k=
X-Proofpoint-GUID: SkeN4pTZTgw5ctwxAj1ZKbTl7TVihpHT
X-Proofpoint-ORIG-GUID: SkeN4pTZTgw5ctwxAj1ZKbTl7TVihpHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyOCBTYWx0ZWRfXzJd3rDF95H+H
 M49Wz5iSy6RB1mypizwhuI1YwLbSze0YNzYEoSWJLBOLMw79qntSNBx2UIG4vUTY9y0b4pbmF/j
 wfYZBAshUCgrnJodjlpeyacHiqVwgFJxd8Ls4Tqt8Ah3GH/gZJTz8BT7BpFaHtAQNUxAzp6pJxS
 JmHbULpaltyY/ZxhAzH/caZvnFqEHr6dZVRc/RmhXDORao4ptDmukJRe4/gTVa6WbogrPY3gg6X
 00d8MqaN4pbb414HLhAxj4vE3s5FpdwinXCFUo/MhuqtOGQs/bEgHyggk6pieZCpDeyQ7F67smi
 0q3dYlacCNO/OCYVGWCg4dr+CAXxc/52wnkKn4Gard8MA0XOfXSIIhfk+MazwPJxwVDMtnlmn2n
 JHwKSevEu0yuToAOFPjleXfmiVvXBEQSpDEccmcUkhXR7HhGXlFKFMA68FhefvIpnDOzDop6SG3
 yckN9/X2nWSWDjAAhKw==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6f52ba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020128
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

On 31/7/26 20:56, Richard Henderson wrote:
> Use the MemOp parameter to op_ld to directly perform a
> little-endian load, rather than a separate byte reverse
> after the load.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

