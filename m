Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39985FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDxx-00059w-H6; Wed, 29 Apr 2026 19:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDxw-00058W-3T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:05:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDxu-0000rR-Ih
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:05:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbkqk3203498
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oJYeZf3IwQXdmeAt9jwcyvhr5xnocNc2AWd0O5Xhy3A=; b=oeEqil2CcJLDI2jM
 CO/OhqXZGpkLIlfBnclZynBWihBedMuIjw2P7aDSXhUcl9hefhE4TB5uuuoMPf1P
 be/dea+EgDfszqLauSaPgt+X8d0FmlpW6MrExUCsf9snAPWSgZ40QGXYhMU+wws4
 HL5C4pE3YKJii6b6hTRd/1buUabtHGXSAR3nbua5XpHEhPZItqQ3OGhJSwRtN3D6
 AwWXil9610skd8GgyRlVccvV2Bv8c+c7LT0eN3CFtQm7ZVWhmeOMLMkotCctRxNL
 F2gpRuy6pRyVo5CdU+SNc+JHkq61uURX4bZVM3pPP36KKkf3zay8uRX/Jpeo7jK+
 Gn1D9A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83t14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:05:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdf75bc88fso629267eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503908; x=1778108708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJYeZf3IwQXdmeAt9jwcyvhr5xnocNc2AWd0O5Xhy3A=;
 b=MpCrDTZG+buSfG8Vw16ZJnucd783k/Am6t6dpkAF8K1XFQfVrCzZqXCbQp5ExHmXpt
 J4XZ8antgkhMs91fL/P4DMs1W+d8trQCDfo1YVEQkbDva6c/VoZsQuwkS+gGZzGBuaVk
 LUe0/RumJOOz5LPGfSURf/yGvXqbqaJTYRQjT85op+GDySZphQ/Hb+ao91EQUK0tc30i
 2xfe7B5i3dK8vTEKNWsu6oAGo7pPFzqunFWKznHZTTR7cp2dWsOHP15hoE3HQhAjVfWr
 UaBk7SDQPX96EzZldxuTRMJCXcQ/UoA5TLJoXobT4y9OcffXBhLddfcvc25oVswevoZu
 Fs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503908; x=1778108708;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJYeZf3IwQXdmeAt9jwcyvhr5xnocNc2AWd0O5Xhy3A=;
 b=PmKo8uqeuTK97j/9ENPUYHvIl7BNZlumo7HSEgzDoJiSpUXTly6pCXi8+4DBDhY+M0
 +r8XVwp2wJD28sP/yMsTlQcVvxQqPzL44knvnARg1n4S9SaT5kQ0UBpaRx0+DaZzqWXY
 YxuQfvFQb91qznnyDr/6e/LAEgnP405twocHC3rvyoTeX99KH8NqlYFer2AUdMjahN8G
 /2q7OOzYxycQ+Cjw5jGLHR6Y9mpsiGQmd/YNzlqcuWTxyIFKLDerpUoBPPVLSdLVtwaO
 8lPhKWL81emfcTcwJ1Alvj7lBIHXP88/Gr3uIrJV8eADWCe1FFSh1rnXzHz3eyP+xnDn
 qmMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CMdhx1AGGKpS+vEIJnMelHv+YONUnNsoAlLNswQgqgy11e3B1psPUNSz4vwRuXdJB9uiDmuJ7XbRI@nongnu.org
X-Gm-Message-State: AOJu0Yxown4vX63/xCjLkeBFyKjo8uV3RGYiersgXD3kdS9wA1tyYutN
 GE83D8JTO6fTejIC20lHBd/JqlnytIQWm8E8oycwTxKt4XkSFMdaWvH3Autz7rc1WdblTYQF0o5
 8/BDwEr45B0j+AcNx7HldyWd0Wg40LUJ82uIxe/2nXCluCXgOmTRJH5KK9g==
X-Gm-Gg: AeBDiesV14RpHrzQM8IZiCYKkISVdON8swSPeRzGuSlInDiOs3L37Ga/SGdq6pYT4BV
 G0Q55LphRTW6tKJi1r8L3DbWoba4QcZWO7A07QZc8bGE4E/pHYxuxuwkCG1tVxw72rX2Crjlj9e
 CwU0Q0qhapvU/0CI4dmR0a/TKIOm6EKWWy6qmFLieODPGmTFK49oPD4LP9VzYSO6o1xx44oWj7E
 EyScY1/HW8p3ND1YVymxnvGrHyMw8RKWWMjl1gC9YrkeVY0j+RfiQWPgT/lla6xmlhTubjklW4h
 JQzH30HUXjT5TFZHwnvEWOxs1fzrVE8WX3UCFxryuCl8Zc0UdJF5ujnFw8cANH4z3/kOQcqr54Q
 lfyd2KRPhT86J7/U6XBAbDQjRYpvnGTblrNr8yARqqbVn1O1NWPSZA2PFY1thzLc1MZkqywhiub
 MaVdsIrXCP3fH+h6C14si/Z6tj
X-Received: by 2002:a05:693c:3b04:b0:2de:aafb:fef3 with SMTP id
 5a478bee46e88-2ed3bdf8c6dmr148895eec.1.1777503907989; 
 Wed, 29 Apr 2026 16:05:07 -0700 (PDT)
X-Received: by 2002:a05:693c:3b04:b0:2de:aafb:fef3 with SMTP id
 5a478bee46e88-2ed3bdf8c6dmr148880eec.1.1777503907442; 
 Wed, 29 Apr 2026 16:05:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d263sm4299037eec.5.2026.04.29.16.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:05:06 -0700 (PDT)
Message-ID: <ab1ebea0-3c87-4f10-a776-e24f1ba2f9ce@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:05:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] bsd-user: Add do_bsd_ioctl main function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-16-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-16-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AsFXTi_Qn-dd2xOWRYDD9682deR-DWkP
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f28ea5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=DV1IPIIyUOv4gmfp9iQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: AsFXTi_Qn-dd2xOWRYDD9682deR-DWkP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX6lv48s/p/qWw
 UktPQhUYISAhQsz5fu+QcgkhIl5D4nVYXm+hg0RCZJqioWexauj8nZhOcZTR0r8qL4S4Aw08Bx8
 PwAxvWUiW/quvQ5Gg7unPWJ5Y8khoqMIfS2e6BtDGpXtbeFuXy8YZNY7LuLm3fvQPtWiZ2LGRL8
 nPq6DvWCHfown0vPXJvOf3W9YH6hk/4r316gjrqyJVr3/0JernYJuad0tUwEY6PpblkUJx1ae0C
 CZF+4iNw7Yb4enf9CsP0EAm3oX6gsgFpDU23NmTcKoCtZEUWjIMXT3KBjkuqdIXsaj6L+mw/U9y
 ar6rMVPKHDN4SsyHYWqRjru+IPIxWalXX5lR4N0Viv55rtZZNMBbC2eAa6zUpq7tT1ji1AT8QP3
 /XoLc2mbavt+ROXXmclfPU3oeM+Cp857mngx2e9AyXC1HkMopgqkwTQsvtN6ZOsTDar+rb4QEO1
 GFgPolWEjFORTH14jog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add main ioctl emulation dispatcher that handles table-driven
> ioctl translation with thunk-based structure conversion. Supports
> TYPE_NULL, TYPE_INT, and TYPE_PTR argument types with read, write,
> and read-write access modes.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

