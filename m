Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04254C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOD-0006RP-UM; Thu, 27 Aug 2026 18:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOA-0006Dp-Lc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO8-0006AR-9n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLhPa1358582
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oYzPbQd0QkX2e3rCmeKZWocZ6rXEJsJ+E4Fzatc071E=; b=K2DyVzTI7lsd7KwP
 AnHAo8A3fn0ND0oFyk/khMqSw34dqTRHne15t9YsUbgWqfl30Ig7GICotYCsWXzx
 5qraPJyLBlTaPixqk3Dc+JKqSjggnj61bE3mhvX7IrQTe9am6DQY50cWgT1NKryY
 Pe1oUArLkqSBUDKqUThBa/V0Dv/DiEQY6uksT0oHx6UHjUV3RVvj/KlkZtWIWvWu
 y5dWfDAD458iQtnxoalHQorGUyhsYHB8vLvxX7q9TYIWJH2MK1IB20P/xAoEj/gd
 WTnRqi0/yT4rpvYyzdxiRkO2UyB5huzwKxl2sJFbjdgwYMr4aZk0l74QyG0X/qra
 g/ah4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva9v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso3382825ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868948; x=1788473748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oYzPbQd0QkX2e3rCmeKZWocZ6rXEJsJ+E4Fzatc071E=;
 b=BlGSWlCUx11SXaqRb7ybysrglaWZ9g7eOzRuTS/mD3PWLFdteBZTmneUTj8esyoppl
 5nLQG1+CE0BFowDxyVnNPwvhYq/ISkvj8L61pM8EZXFfWvi/OvxAyZcVcfkXiAEXLYyz
 dEtxxb5fWzi5xAuWKo9XZLnEOTOXlzL3RSVeyx/tYoKp2TsHl4jEPFZs7Dib493gE3ZR
 31UjFrno7CMlN3ih8rWXXFR/qN/OkeBE6RKoi2ouDtRuz90mK25jkqHsGnUNnQuRdIxM
 mMqlY5rgkflWjjFyPCx6DAMHkh19kFL0vAyd25RvjBTOeTxYLZY3k/6SBz/JBw6P2TmW
 T9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868948; x=1788473748;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oYzPbQd0QkX2e3rCmeKZWocZ6rXEJsJ+E4Fzatc071E=;
 b=XZJ88zCyCg/RqMVR13w4k4cqKtA7MGkw8L1YnQdq+NlTFzd4tcL5vXJXYEAQfKodCT
 UZgVMHwBpkQGRquEBuimCqHnPiX/vYLVHNW5jGQL3Rx1x5M8nl13emZnDF0plUz6Bg6N
 b2gxR/UcnMRYN3AtAREtjMApiUUdS6djMhXtRXt0RqraZULkJd0eNkE0HPS9zvUREPVS
 o31BHsEtalvIqNQdhVvLALBtwAKgkYK606GXMBcSBV2LARcvGUIxcOfmZhQlatxUDVrB
 GKAJAp5UnsgrClQB2OPZ7mLWnfA2IuajNJEmkmXDxg+5kydRFLzBaI7ZcxDb4WbzHi91
 TpDg==
X-Gm-Message-State: AFuF++kX0V0IldhZI1LcNYfc9XjIdvvo8Njn4xuuILIt+/8BvjYznztd
 JWTB+mt+Lpxi5JuVkY2EcGhM36i66UwAgvSwcWRn3KXVvCo4x9wraTVxk26ASzRkBUSg6mA4Fcj
 FICpKm5NHRPVPOtYO3hK538yw7oF9RzyZKMPycDuAn3VKVXaDRfhz1SGcNPJZ2+g0Zw==
X-Gm-Gg: AR+sD1344bxPSlVcCrov+8giQ6aUbNbxP61kbz4YssHawDwq6KQjDy/ZIc+tCftpaec
 PZ8mTKFuEzW++MAf9I6njSV8+XGKhqJNg0H2e0vGS52Gu7HXCOjMEb3475SuthD9N8EQGMUV/om
 amewMVLcrthalB7qzTnLNsEcVYSk7jrdNwDbGA7pqVywaHsX2WrC66S/zO1cUck5eIFv/V6NxjG
 i1fGdLS9zrgjSsfqfDZiJPhmj3vi6zw5EaloidW86Xv34tcLL9kWO9Wb4y+5ANNc/he29GJympG
 GsoAbyeGVDse5ZELWnGMgh4HWWD2wQhiBeiLQm59dtpPXxdrwo2+2UtBP719h1AWAZPSsp8bhSI
 L7Zo8ore1ujH5d5i3WtvhcOeGx3kScgYdjIv9C+m9BwJ+Rl/gwDvhRRsTvBNOaaMfO6HR
X-Received: by 2002:a17:903:1ae4:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d74dc514f4mr40038905ad.4.1787868948210; 
 Thu, 27 Aug 2026 15:15:48 -0700 (PDT)
X-Received: by 2002:a17:903:1ae4:b0:2d0:401c:2ebb with SMTP id
 d9443c01a7336-2d74dc514f4mr40037865ad.4.1787868947758; 
 Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d63bb23sm23530848eec.7.2026.08.27.15.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
Message-ID: <fd1c36da-f4bd-48ba-a45f-09cbe0b4d9fe@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:15:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NXjsNLgMhdQNUVydXXahSaMgh7fyjAN6
X-Proofpoint-GUID: NXjsNLgMhdQNUVydXXahSaMgh7fyjAN6
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b714 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=kCyDZpeUPR-4KfjfqXgA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7vuqNu4olzB6
 SlEnB2tznC0cAdfuQsRV6NdrCdZV4w7OSAdAW/96G5OE4uvUQQoFZpbfHYVwd7XjDDTbVuhzjqi
 ETuSwzoo/n+589bHqllWKpHEdayniFIwlIPXCIzMLG3qXRqjRoXUEHeF1cHOUQRHCV4a1xh2tHx
 Zxtz9wL7wxFI84fXGUuUy8G3vsKrHQfXi+8gG1B6OpJPY9dU1odxHtY9O31j7QqTRlpNg+ifx4j
 SMnAh/U7mkxRAreDqk9U40U0J7ExaVNmLk0xnXJDGZOQJcUuIxGwfq+1V2RxyR8ihkWNcGNqOvL
 BsE6h7zLcOnn9Lrjnxu/FF9Og0xhhpCxZcHB4xAO8sukFNJB2SRIbxafxBOyPooXz/49IagRHxU
 yTgJQ60M+ACI6E7Hc0jGBy6LX4dcwazbhmh+Lww3gUrgAF/KpwmqV09YUYE5Oiugm4ovHtdeclE
 F8/sqZFviVkoFXA9DYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX51xQgxCvDOEn
 CW0kRsx0C+T7wJw3BffDuCA+M00REhlL9h5kw8KrAh7PJ0jCHGvEMhsDqGjy3jCYhPtLaNO4kWK
 lRdHTJx0K+X6ucUOUUlB4wuArBNgSog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Please ignore this thread, sending was interrupted.
Will resend.

Regards,
Pierrick

