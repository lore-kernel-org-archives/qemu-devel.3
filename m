Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69245C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbW8-0001Vi-3R; Fri, 03 Jul 2026 06:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbW3-0001Kn-Vk
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:53:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbW2-0001N3-6s
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:53:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rZuZ3136103
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b8Dld42oswU9eWtRizEp44Fgiwn/q+pdpxqDw3ITnf0=; b=bHvyTS/jbwXH6zx7
 +T1EzcYDVYzRqY2jPNVM5ul+kybooXoVC826yMnc6LH9VC4NWzoMIql1uDun+wqB
 pf8GWqAVX3NEK2JfEbniU/yNwyivtMrOBQkE/O4cCnBZlAGxuJi7zpchWxJT52jO
 J/HJDbw5HbJnbEK+QFvybEqDNG3BBxeXBOhdXmC600CKJWnQ7NNSt9zflqDWpymc
 qgTu4r/30pFGe0zjVhk5Ofwg9fS2DUpGWlQ+XPnMGe3EiE3ED7FOTLviq2Wv09Aw
 u7Hz9AvAX4tF80hdA3mkIM/kKywjzHgVADw7YLDt6suMeLkzuTMeKoFz9UtXakQ6
 wRvbCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59ww8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:53:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e8004d60eso71441985a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783075980; x=1783680780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b8Dld42oswU9eWtRizEp44Fgiwn/q+pdpxqDw3ITnf0=;
 b=JqatD16PGaPR87h4yKHZ6V+wIUyn7lU4zBOzFngBzRByGO8ZiP6BOm7kPqZk7Tox1I
 QB1wFVCeKsZRigyFlfjXQSFv2VmJgMED0r6pqe+Kag3Oh4tE0AeYgOXThxcX8KcwhcvK
 /OPg3GJHWJhhkxzIgDbkFOKSHev+n6mmSW0unduQZjYrCbui0r7qbb1+30JVnR570atI
 /2ZrxFwJrFbHvcgMZXvA2IiHfE/wQSPiLrKlNSz5hZA2eT8E5bPxgSvkloma8AmOgNp+
 zqtcVqxDZ0dlqRho4riXBT+ZBMMsnUyg3cEONOg1wmovo3rWBQwAALOpchq+0yau/KlG
 uU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075980; x=1783680780;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8Dld42oswU9eWtRizEp44Fgiwn/q+pdpxqDw3ITnf0=;
 b=HioI8oDCRCP2x6EKM5vax2dOdi1c2Z7luuIrPAlZBtD8iCh2j2AY5gAItHdVwlIu6Y
 U3iJQA4+nIHJHN6Y4g27jtwTvx6F3yFCEDrg6FMKohuk75zCg4cUwhGqaEIVebUFJGLM
 c5iYv1GUO5sQtCgMa59VR0hm2wEacVA+5oFsmbwyJFSoa8IHKW6NsEDKXsth5VdGOF/9
 3abXgtYtthYehHXtuxeX83PIB9zILhi4U9swZZ20CW0lN0aliWm4JonhCEo+D+Ps/OuC
 BmpB8c51CUaqkG0yJNjnzZk5UJ5boJSdEFAre4xG9NXFG4I6PLTIt7NtpftC+AGToDdh
 EaRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VgbCce+yont9PkKPUgPlls4dJA0BtDN+AmMpfzKYia4Fd0jqwVKHVHHJ/hwIi6H6vZbWTEPCygXJI@nongnu.org
X-Gm-Message-State: AOJu0YwNmembmw7+tAxLmQkpD8jO1/vaYYY4RITbeEI70tcG8KiwZy13
 s5YWu2jv1pdwZr4/MwtGb0qW2D4ZujO834E2c+p4MfO/k5rAAfbgixG0NJ5prCuxiT3RTPsTXg0
 a8OdAhlL0+f8VXB4BzQEez+X0tirFa0W8/TMMASrMrJnAw6qBv7sSTBV+Uw==
X-Gm-Gg: AfdE7ckZeew7pAM0dsVCMYIO3npZkxBfpUgF0NfKMGemKEe4R2m1wqaSYFAzu+8GcQD
 RnjizWi7JbODGoX4uej84jC9/zrkhJuq3Mg247PN3ZnvBi3kPqKhp6YxZGDdSrawll9TcyBDWni
 igIhjvlgzCt8cTCn+o0/hTOVlMSqRlm6eVsbHNZknhNc4zCr933mS2gD8fqS2N2WF46OJ3XPd64
 5LcpnFVpcu5tk5YKom8utO4/JnGrDd8SG5yZzXuwou0xdgub1zTZTPQVNz4HYiKdVgQUnJUtZNd
 WV995UsRZefHcVKGbQ3u5uE9qDRx2gsSxbSraE81T/5i9zO9lNjqMHLcg+XIA5LsswRiyso8JCw
 P1woNzIkoyFVP/rTlYvYW/IkRXSHucwW5qTrd0++4O2Vy1HYf1rNEEBfk1CEXKw==
X-Received: by 2002:a05:620a:370e:b0:92a:e2a7:d565 with SMTP id
 af79cd13be357-92e7b3a88f0mr1150721785a.49.1783075979971; 
 Fri, 03 Jul 2026 03:52:59 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:92a:e2a7:d565 with SMTP id
 af79cd13be357-92e7b3a88f0mr1150719585a.49.1783075979575; 
 Fri, 03 Jul 2026 03:52:59 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94cb64sm18019333f8f.23.2026.07.03.03.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:52:58 -0700 (PDT)
Message-ID: <247d4f24-f560-4312-88c0-fb222d5c0244@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] target/riscv/tcg: remove unused
 riscv_cpu_get_geilen()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-22-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-22-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNSBTYWx0ZWRfX0osLG7eNyZjV
 3lvZTTbHmfjsCXl++MxazLHd1k/iSg6idXGZ82ujUA74u4ZUcsHt3fiWKblCZe1PxBh45nf9hBl
 J3qeAMB0XbsiEW+8LAm7u5aBzYl6CDA=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47948c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: fX3gYgE1Ntmf7GJcdZJ6dd9uo21W8HJg
X-Proofpoint-GUID: fX3gYgE1Ntmf7GJcdZJ6dd9uo21W8HJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNSBTYWx0ZWRfX061VC6l+C/CV
 ne1SXDKlfNsJuUG1bhZI3DXy3kJZeEJapwp2c2caJ7uF3Cr1FfDHDeShZ8MsFf4pGXPTegIxY32
 sRReFtZqMgEnMt6knLup+NUUomgci7GrX/XCybpYiog1tFhFeHI9qlSQHU9d/3z3b//Fmkh0r+c
 ulIEE/WH4TthhIHLfA2newbzM7wnCrGhlS9TSd5HgO7VsnsmpqH1eM9R/SCD+Z3sKvaORfsLtl/
 SGGrEi6EEXWEE6YyV+JgDz2CcQNTOttzCwjrJtmn+2lma/Pu7iwVkUgyb6xDBh3BzJRLshB7GR5
 1FQg1cpGzBgxlvUgunPHMPEToKMRUpQ0PwQhFMW2DhQPM+aI7kSP1fQmy5AUsIxJQxyzPDuYmy/
 m84CMKU4yYBpkHpHUzkKeIuhxsWYUNEwuIqZy+f33cnR5RA2d+FfHIg7UTvip6+fZjnD+po8lzK
 aV/cFS5OFCmWG6zyN/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030105
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

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> No one uses it.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h            | 1 -
>   target/riscv/tcg/cpu_helper.c | 9 ---------
>   2 files changed, 10 deletions(-)

Preferrably before patch #2 "target/riscv: move TCG only files to tcg
subdir" if not too much trouble:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

