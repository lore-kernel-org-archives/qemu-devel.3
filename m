Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8934DC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5d-0003lU-Q8; Fri, 10 Jul 2026 17:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ5Z-0003LR-Qx
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ5X-0004qt-Vo
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Ehc1892273
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S8qlgycSTJcCt1NmO2CiYGSD4smZGGH3PoLh0rbZ+uU=; b=MIzXo4w8iL+3OeG7
 5NrAITxP8ECO33rX1xn3fpeGgEL7/w8ddX3xoSWRPMxszm+nr0C7O2IfQW37LlzF
 NYfoQMzvz+N7n0nCAUHqPjEcPmX07U8lH96YhUl34Tl9MSYE0nC+T9qlt2Sku6Wi
 8PaCxSIelbhyxfFnLUbsUtr7uMw5JUnU4yS8mSfhWV/6kNoyE2rgrmM7hQuHX9Cq
 IGSj9Eb8u0qas3JvR92PVlA9uh+q5gDOqrYQf6zPpo6weIe81oAacn3YciP7WLts
 stWXOQno74HacJRYmPtaL69ljY8aMqoiTEQdsVDY6r9tzS7TOPfcpDlSvYv8WsQi
 syQGpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs33t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517e054fe07so25562001cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720119; x=1784324919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S8qlgycSTJcCt1NmO2CiYGSD4smZGGH3PoLh0rbZ+uU=;
 b=ilvLU4AEKiuJ/Crysdf/ddrZght3QVA9isDFkJ6XetiHG8WpeaGxJwqduQw6t/pOph
 vR/f54z9ItZ1U35jW2xOsn+FmRTOO/P9KjytuJIiXNJYgrVWzsb8I3qvdj0JQ5CdmJ23
 QqHfjOA+rWw07VHdOWauJa4xynkVFX0B1F+aOzirtPqJwKlcj1Ab6deUfspLZya2pI6U
 bNV+wdJOMiW4kFz0tXBzrYLzWeoHhCLLmCRO9awwcvjv80xWzH0K53CH+e3RGDj9/awp
 VoRw/UQnN0DG3aeOCnGYRz1RciLQm3Y0UZ64136NWRfL918aRs9Uqu4Xp8kgtXxZWuSR
 Anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720119; x=1784324919;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S8qlgycSTJcCt1NmO2CiYGSD4smZGGH3PoLh0rbZ+uU=;
 b=EhHuZlaMV/GMUsLdIWF+vDCMqDGA9vpRHgX2a51/ME5E7+/gduW5anPJOXsSAraMFD
 dQdjLzlldP5Gc7RqlGEeLZ+KkhpegJ0dkj98F+mxe5dretIDJDEqVhTTh3a4dJBMaOsR
 xKtL5YExY+2QrdT7NYQMGcTVN03KlYN8TGpGOizBTcFSNHuUcmojbb4iQgdUy+ELI7qg
 T2XB0vo1xw3cWZr0piv2ISVJieyRFfo0ZbQV3MKZC5tLj0X2XxHYofN9Sf1ELKrN1sq4
 /wM762QMrSn2fzUbfJZe7fdXgAHwb9D0MnVJwQ+IuD2ihNYMClQE1mpl7DFMDrNwL+uF
 BUeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RomrPyp+N51n2SSFIwcKDJ/Q/YFkjVaU61Vtpyt0OQHKeZKsMe2VjT0PByOQZEXqgoPwB4hLGWW9ZTS@nongnu.org
X-Gm-Message-State: AOJu0YwPWb6lWTmpZ79IzPmIbbT/HgQI/lGPC1jvNNngrU/URvXHnLaH
 3RzG4wiw2pRYAYQfW6rI4lbmotJ3yBjhg+sQ5O4c1qZ+eqUAOAw+ggqujz8xjEH9+heH0FXWab3
 HzGCEdhgAx9iUlcipZGYImY5HCp20WuOj0ftNyU6xk7BOaaVnFCTChCI+ig==
X-Gm-Gg: AfdE7cmVyBpJQ7HKFE1botIVr0Z7S0XP/AGuPn/4MsC5JGAXzidsB7ZM351aJ9/ASO3
 B6stwhoYzohJcIj7w90iYur2one7GZ9Sf3Qu0hKMRGoAxW4LPNh2rW1ynJA+Zcv9hdOyR3tQyiP
 DsR4wWM4hLUILujj2kdmy6EL8VFSOPFQP8/0YgHNlP5CLHWM+/6luThERY8oLmapoT2QuKfz132
 HHkwaIfMhkz/MZgxxCqQNqnt52Vf1U5TaRilpH1+lApHmx2AIxlXhCHyPmGdPaCrkBsP9C6TSHx
 7chJHuVTbUYEGyUQhB1pwfvKY+vZTHtdQtvsmjr8cgA0ihGTA3mvvZ1mQXN7WV+tO4cZcEIO+jT
 O5OVzT0h6eqaqUGltzjseHVqFpOH1cKwxklesI2Ao9zxh+rDDcfHfbeOIWs0VDQ==
X-Received: by 2002:ac8:7c4b:0:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-51cbf0c4a59mr8214501cf.13.1783720119476; 
 Fri, 10 Jul 2026 14:48:39 -0700 (PDT)
X-Received: by 2002:ac8:7c4b:0:b0:517:6d82:ceff with SMTP id
 d75a77b69052e-51cbf0c4a59mr8214181cf.13.1783720118961; 
 Fri, 10 Jul 2026 14:48:38 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73b161sm149404535e9.9.2026.07.10.14.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:48:36 -0700 (PDT)
Message-ID: <e37a2ba5-f43e-435e-897a-6ff0ac1573fe@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/51] exec/watchpoint: Add CPUWatchpoint.id
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h5F5cM4C79lSS6vNTtwursiD-xeGgQQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX+uWBO8znJk8W
 lGWZcr0hj9HBpMfju+FKBl8gb7uewc3xuvxQCUcPvig5l4bV56D/9+FcJaQgFcqE6hgTlwt3tm9
 qC06N7JJgW7EzigIrSy76f3bNAhRSp9A3+anek2trlKEbvhEupG/sm0YoPUoGmGarLYNGstygTn
 0jVP70mUHriydWmhfF1JAI2Ipu5ZGTijoq0Wb22lyxoonzWcGUP7P52v8s7T9L13ZmGTqO+gzUn
 G05BCf8Ay9jdqedzJ6dj8dudY1WGVeo14LLVs0gk1cZtpV+CL/CS3WzjZQJW7DobeFsmk1h+56Q
 B6YxmmZ7uRb6F0KeKRqaEfs0+z8eE0kursorsKDD+/z1xk6OkMRfV9i6CNe+G+eos+YfZ+Nf+bN
 dB9J7n5JLCIsWmJV2Bflu7BJV99gKcHizdGMvrAxj60oMOv3T9MNHbATUF/JjtYUqK/7JBunU2W
 vK1jPuzJTyLxkjC6F+w==
X-Proofpoint-GUID: h5F5cM4C79lSS6vNTtwursiD-xeGgQQO
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168b8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9olXxKvZnHtY
 uBORYkStlcl3WGkg4bq94SqLdZG4VANcSXR0brQzlOL3bM6JLggKUdycJWSSs8Ah4PZ01BY+7i8
 xXtgtyzEoxuM8g6FBWXpxbKNOFuMMuo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/7/26 22:53, Richard Henderson wrote:
> Add an identifier for use by targets with BP_CPU.  For most targets
> the index of the hardware breakpoint resource is to hand.  For s390x,
> there is only one resource so use id 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h           |  4 +++-
>   accel/tcg/tcg-accel-ops.c           |  2 +-
>   accel/tcg/user-exec-stub.c          |  3 ++-
>   system/watchpoint.c                 |  3 ++-
>   target/arm/tcg/debug.c              |  2 +-
>   target/i386/tcg/system/bpt_helper.c |  4 ++--
>   target/ppc/cpu.c                    |  3 ++-
>   target/riscv/debug.c                |  8 ++++----
>   target/s390x/tcg/debug.c            | 11 +++++------
>   target/xtensa/dbg_helper.c          |  2 +-
>   10 files changed, 23 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

