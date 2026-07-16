Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FC4C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTdw-0000HF-Ur; Thu, 16 Jul 2026 17:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkTdv-0000H0-7j
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:29:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkTdt-0004q0-9L
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 17:29:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJpDgW3453727
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v2QtmzcVRYl//aZPfLYvGI6oZO7uunkzl7JDcj3HFuw=; b=kO/GlSK7CsxHuRuq
 7Fr40gdU8aQvhX3mqrvgdwEEs4FhvUMi1rSE5HETstuGQybnnCXs3OPnIGMpLHB+
 75CwY1OwrFEh136HKTguVQwdwwrQo8GTf3uQUcwN2arRFGczyvhbLhQD8sz6VX/h
 3rwnaqZw664cGJ5r66ysyWD8+xzCHNBsL3kMkVwhQCVfN38zon06wK2A9IZPRa4P
 WGKmEz6G07AO8jUPBVfxCk9vnUhWXfVNVjyspG/K1IIXvDIVb0qrkZO+vzPt+OJ4
 yeQebX/SPzH8C9lwWm3yREXh+JghnxnFVuarTnrj7wFd0wM7MbRhOZ4rOibcEiWS
 J42+FA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9hh2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 21:29:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484739a9cbso592170b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784237354; x=1784842154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v2QtmzcVRYl//aZPfLYvGI6oZO7uunkzl7JDcj3HFuw=;
 b=c73N+F9ejXpUhOTZXiMmBA1v4GkclpYj7Q0J5vxCtQ87tEK/TZROB/6zQH+5iz+bsA
 O6JuYu6v4sGXpdImlhFCQIMP9N+oQyuuPs9dknDPoqyLDcucfrB3wOR+NHPGioy8pvNW
 hrIkuQwsf+pQZI6El/QLe1pxnhTK8+dYzSYEsiMkykCBUIW9NX2ftvtrzbCDFhLJ9Oyb
 BljrfhIAlHvIuyc9i32yRFMKx469PITtAFui/fv8YyBNQtJeiqO7mZf/WJemQrz4zZoz
 yug+uLghusNhuaIJR6Oe/PDkOK9cNdVgeyL/m9xCmlkp8ArqgWoV5yXBJf7xy/p9K0sR
 N07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784237354; x=1784842154;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v2QtmzcVRYl//aZPfLYvGI6oZO7uunkzl7JDcj3HFuw=;
 b=VbQ8bLNa68+5snIkbxBzoISQBPvoJDhP19BQLFf8Qw8dj98eniDa14bDLE/cMhZrYn
 xcfSN1iwOAJfPRWtJaSNgPwkTGI8qaTeSJIrJPYx+BbuXWkLuQfyPV8ly6qm+Q4t9J06
 wtvm2dgC2v84ibwQIYOiSeTI6S6XFQbh6LU/6o2UeG7IswdLyjtEhGSwzzP0TpFWfuhF
 71pG9iYcsMksUyi/Hl/FZlsb8buVuwiRs+lCrmuG8aI+Caiz24W0zrmMNlodiCWO2wBd
 JFOv8D4xQytpvVKqTRbns7kfrYdFIe336TH3rjgFPOLQVvsdRliKB2N91TLaGTrvq2pD
 eJ4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo2u2D8jNBbfNj3mG4wJxuiFOEC9H7Qlw2BOFdEhK2EA7BykMQQjJCskUE0ENeSCAgysl9oXmagjvP@nongnu.org
X-Gm-Message-State: AOJu0Yx4MidCOCrk8hJYdvzssiEHTwdX70wAF05wrsRPvQ3qBkR75hR5
 AuDmOX0foE6NIo5exNgwAwF3Ds8FqDxOObJxNfeac/0IEEMzv/glS0UOnOsdUUdCzwxgSyu4mPO
 t2M60LmjIeCdW1B+W9G0v11Y7oKntLShexFbb63rePmjO6pWf0LZuIRK3lA==
X-Gm-Gg: AfdE7ckXYTknhU8HS/aqdUdC5ABA2hUBrKwsYmcxgRYsUW4i2pDnI4rQrGDoe2zF1su
 7shgLwmQ0Vi6eScsU1fQ/YHVcRBrHv/KhUFFNQZx1q0sTlaOptuaNcdTfPsZoXQvyBQ3EtlVqzK
 I/o/CDRC5MuL3Fo1dtLuJptK5QbV5C6nVlLpJjFpxDbhfh9Fhd4cQUgKQ9Xt7mmDLsDAt5a0Nvq
 Tkw/A4aG3o9jOKwd0AmAFm0oWAVRcKjouzocPN/K6v6C0GTRTpNm4IbvjajnsEz9YOTzefBU6IB
 66Zzhz/vR5eazaNnB8EoQ5DPaCU7YtO7I2lodCY/4/0sOrfg4hN1Z7JFzeTdc0oGED391HXtOKt
 Shar28UKuHKRYZTreufsn5Yjlvgj4mEpM4jyZzvaNN+09yu8Sp/Hwiso6r96r2wsj16HZ
X-Received: by 2002:a05:6a00:c30b:10b0:847:852f:c28a with SMTP id
 d2e1a72fcca58-84beb07b4ccmr3148552b3a.5.1784237353682; 
 Thu, 16 Jul 2026 14:29:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:c30b:10b0:847:852f:c28a with SMTP id
 d2e1a72fcca58-84beb07b4ccmr3148542b3a.5.1784237353228; 
 Thu, 16 Jul 2026 14:29:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f818eaesm5422092b3a.58.2026.07.16.14.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 14:29:12 -0700 (PDT)
Message-ID: <400965fe-ef8b-4ab5-a877-023469d0cc07@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:29:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: fix -Wshadow=local build error on GCC 14
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260716184207.3357340-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716184207.3357340-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a594d2a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JZpvNUWX7_RZYYvoSJIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxOSBTYWx0ZWRfX0edD/k9W0VUy
 OzSbHtnUqG8HePm1j8YYwJkm+Yemu/p2jxCyO/WelWc74PvdSD3k1lZUg/TysqrhRzz52/6/WxF
 SCumSTNi2xQPxUI2LotJH8UET+CyyBUbKQMHdmujpXSmKIPM7aSo44VoIESOCdCqXaUNAYw7Aks
 Lk+4SLXQUi0HCfd3cokVbort5TlMklxAT6R8oDddtut4wHXAzRsllaGMD6lciWf4Y+QpNenuKd6
 BhW56kI/5XY16cW3CPuTkIoCBBDzgBkd43D+ns/2X3vjY+mPqVnaci5orAKU266lPkKih3cGkho
 w5dzSDvxgDHHXcjNRUeOifj/0FWA6kxW69hki6ouyT1PU30J9QlelyAFT1M0XihV16pPZLWJh7x
 ATNsmTFJycim2e8JCcRaRzsfbOhl5HRHOmU87cxL66JVbSNVjUaZI/wUW+jIJgqdW6hOZ9loGwp
 sXsoQT0diZ8T3eD0BhA==
X-Proofpoint-GUID: 0I4PeKhZoX0UzBdf5rEnDAfVvcC-HggP
X-Proofpoint-ORIG-GUID: 0I4PeKhZoX0UzBdf5rEnDAfVvcC-HggP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxOSBTYWx0ZWRfX+B6FLQmLAJ/J
 BeMDpduYd1N70lBPAqYaNfA7soorERAYwFKyYCfLniHc1pomyPAWeye76PfER57OvziupD0hT1d
 Jp2y4hhNNJS4jJDi/Eb+SSr8GuRHSw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160219
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

On 7/16/2026 11:41 AM, Brian Cain wrote:
> With --disable-hexagon-idef-parser, tcg_funcs_generated.c.inc fails
> to build under GCC 14 with:
> 
>   error: declaration of 'HALF' shadows a previous local
>   [-Werror=shadow=local]
> 
> This became a hard error with GCC ced651b7757e `c23: tag compatibility
> rules for enums`.
> 
> After that GCC change, DECL_FILE_SCOPE_P is false for all
> enumerators, so shadowing now falls under -Wshadow=local.
> 
> Rename the local variable to tmp_half to avoid the collision.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h | 4 ++--
>  target/hexagon/macros.h  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

