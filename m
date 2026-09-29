Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3004CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUgF-0001HR-Bq; Tue, 29 Sep 2026 06:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUg9-0000yJ-IM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:03:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBUg3-0008Kx-Do
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:03:12 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7U1RT4087181
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 10:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mYMFlC43ZGhcw6NKVpOwaPGIJQwKz6lGjt+n+3e4yWo=; b=KPHvlnnYJHoCc7R5
 uezU3sPjbd6VoaiIkBBAwKiUokhJ+r1ed5eQjqHJ17jULgzF86cNxeYkGsVWFqGs
 v2eE8Acy418g8Fnjf+uIVrR+pmgykZdaPH3Eca9qP8Pc/3rS5fjiZ/rM2iTmiS8J
 rNc9VOtjFhRav3WWhQxt08YLi/JpadHPzW+sqPN1la9NQq1PBvu83/WXS31BvGkB
 4l2mup/bOK8EoPaNrAGs+TTm3WjNc+5w+ATISCYgeE+kzRnBedbIzZglwokVnW0t
 vGWXDOHmswmgJ+iKICohDL+bbz5KDIrh+N5EKHqdfZOuaZmfudswzHQ5Ew5BHLbf
 XdLdhw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4tedh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 10:03:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7b502c0d9e0so1744680137.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790676183; x=1791280983; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mYMFlC43ZGhcw6NKVpOwaPGIJQwKz6lGjt+n+3e4yWo=;
 b=HtlkDfQEjP7a1mch10yTTiP/a2Ap53aPfoQAlufynQW7la43I4EbClgX2FnLsljBN4
 LPCbgvh8qpdneCHYbHYuZCcuuyA1NK5res5eaXOA5b52K5r+ONjWGoAcHugTKHpgwNQX
 dV+uhvFWpane0YK/yaJFpD3H3ZU7pqlI+nXxcrn2tZtfyY39qUN4HUY24eievNZQL3GS
 DnCZa9kfnfN6W3xeiIYNfnA1NW9NqiW8I9dUxIg74FSX/O7unx+Dy+QH+OIPVmqow3Hu
 sNDCwi6NOnWYpuTP/H4ixQQwgtfj691Fuh2jzDY0xwa4JZSm1n5l6SEBzPWNIsHEu+3L
 itJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676183; x=1791280983;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mYMFlC43ZGhcw6NKVpOwaPGIJQwKz6lGjt+n+3e4yWo=;
 b=Ki95GakHZl+DTixQAR5C4bFaBDCr9bl/0K4/F5C+YHfCXtKDHqDRj084nvrrf78JQM
 +H/NX0vy+hWrAeexu8iKeJmaIb7z6eQUQ2egH4Idhi8zpmbmUH5Lgz86HJlus5E0Omue
 TigvsYLs50Rn2o7haC+LDMa1DRnBG3Y0QH1jcHLXbThIItO9DcROv0iiXIW+KOIMfU9G
 bAzK4nzkFJtLmPyeSqhH4oIB5FmovqHABKeK4j1eO5wRlTnVlK9AqiRHv5Ep3es7Wj1O
 3cs4xolQv8/MWgjqwDdgOOPDiSEcTy04zNw6CVPGhxAsC0tLHB0toCF3eYunlsyA8xJb
 Jr8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpOoHCvikR9gZ+y+jMDJcbDB6p8bfWYgppUmKN21bcYBtus83DSfNiIj3N/6GUhGoXJtPwnJ0Iz6Ju@nongnu.org
X-Gm-Message-State: AFq9FYKZJ9iW3aHC27zpTE+Ki/qQhjxUTcsw3BtMbdkqECvDEjgaVSMw
 YONR9fBaS823dhehWc3vB+16bCAsz/FU9KCCeJBfaRmRKh9U0G9GczmMXEnX815qLkS0MP1+ns0
 f6Ej4HC1YzhTga/lH2/9dUNJxaYFun7kWwyzOa/oAd9dA7nRBcTUNgjpRfg==
X-Gm-Gg: AYBFou3dwWPhn66j2Jbyb8CuvoiJ8L5X9cBLWfleuoRxx+O06zRr5bIkWNcAHNgtMGr
 qWI2ZNOr5Zr9aL3cbj+a26eTtoIG8HQcUdO4hOkz1HrFTQx4yX96tLTCtbqdJsvoHfpPzRZ9efE
 W56DzoHVJD/Kvd7YnmE+XWgeWOfkQyxrCgRwS77ETuaTnIhptucMoD897Hjw+jXrt0F4At5C/Z2
 iU7dlhZ4hhdPHQChuy4CPYnBYi+m7aNKxL/RGVy2Rg448WEv+8pFEVrQedLGL4yF/rHlztLVHVY
 mChneEH31ZI270ksaGz4/F+XD+A6p9NgaK3Ur7sNJid4OfxBmwVGU49dLJT4W6U6isXRIGTiRML
 QXuz1QBN7Vz8mcQ91PCWX1W49xHb04BhM5A==
X-Received: by 2002:a05:6102:a1d4:10b0:7af:8089:2727 with SMTP id
 ada2fe7eead31-7af80892b7amr3919959137.0.1790676183219; 
 Tue, 29 Sep 2026 03:03:03 -0700 (PDT)
X-Received: by 2002:a05:6102:a1d4:10b0:7af:8089:2727 with SMTP id
 ada2fe7eead31-7af80892b7amr3919950137.0.1790676182741; 
 Tue, 29 Sep 2026 03:03:02 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af507f33fsm2821357f8f.24.2026.09.29.03.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 03:03:02 -0700 (PDT)
Message-ID: <8da988fe-52af-41ea-9aec-d20da1d3d1b7@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] tests/tcg/mipsel: add dsp tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfXyk0lbB8lQ29L
 OIrl+NlMi01yK/HP1E7i7fzuuXvPuk26TKGC9sOx07dafJhWTbiJE0DBjNNZv4KNYXcNyLpxI5X
 7LVGbVDvcZ8CeTJmLcGtws6ig/pNlzg=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb8cd8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOSBTYWx0ZWRfXxMEaMiNSdySC
 cT7RPXCo1xIC4okJckNBapR56A1MvJiRJva6QyYo7SrELZyrp0yBo2A0N8ldPZYU5tW7tb0KFlV
 FLKxCEE1RdoKECT6/xMI/AevivFiSs+Vq1AcPpZ2QZWXMwIsxbhB5k/lDK6bkS3xzoF1jh888wo
 K6eD9rZRonjUC1E0eJmMD1lJ6ZSwnj+5+DWSvNFS6/OvSwl8AL6P0atRT9Fa5iP7TWSVbpLLH3f
 V8tpReCUoF8DZWeCvCLFL595Ko2l9hmcAIigQwuyJ9+niHTKwytpLVamneauFERvp3caGVO30VK
 Re+9jYOMgXfX/ix8BY8W5J7OMAzLIZBX1Xcv20LJtA2mtJJlQYm4CJhTmMY8wJIk93jGaYFjDe9
 aDeOTPUuxFAauaCZVkg1Dxjftnti/xZGWa9Sqb4TQK9f/Jnmtoq7brYCu76rFX616YFUUp3+s5z
 Rd2157muZkZ28FLCpxg==
X-Proofpoint-GUID: vPBrTsG78Eyc-JhfYEeA6BG5R2jvhkom
X-Proofpoint-ORIG-GUID: vPBrTsG78Eyc-JhfYEeA6BG5R2jvhkom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290039
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

On 29/9/26 09:39, Pierrick Bouvier wrote:
> Most of tests have unused or unused but set variables. Instead of fixing
> all of them, simply silentify those (unconsequential) warnings.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson_options.txt             |   4 +
>   scripts/meson-buildoptions.sh |   2 +
>   tests/tcg/meson.build         |   1 +
>   tests/tcg/mipsel/Makefile     | 184 ---------------------------------
>   tests/tcg/mipsel/meson.build  | 188 ++++++++++++++++++++++++++++++++++
>   5 files changed, 195 insertions(+), 184 deletions(-)
>   delete mode 100644 tests/tcg/mipsel/Makefile
>   create mode 100644 tests/tcg/mipsel/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

