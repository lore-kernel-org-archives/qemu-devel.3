Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2295CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw52-0002iL-Td; Fri, 15 May 2026 13:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw48-0002Fv-5l
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:11:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw42-0003Kp-BZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:11:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FAMB9G3671009
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oFO5woUqy20XiAUuX19KXkAoiarIehV6NHqtEXjhBFg=; b=FIe9zRkeXJUrDW3R
 ZQf6LviVTKS5hsSQvswotbqKI48hhFdU9jGAeuSo2HzP92Xscrtms4LBKvu+5P6c
 GeVwbAONdKdZnHgIf8RkzbnxOIlNIze4UV8JmSLuZPVNf3s3jG7fsGL2aXs16/4P
 xJ/sR9FZvUMHT+OPhNfOjECuDtob4dCHj4Xu8H1BUdmQpWCKvlcGfCBwyawvRMQ3
 dUJrT8Tj5j4nGvgafRL/SQ5OxIOU779nz+S0z9DIQlypPGcom7m4QPGNmv4CTy1u
 QUjICFN10PL9GDZEkYgs9YU1TpGz9oIRf2Tb4bvkdz6eQ/SwPAYvxpa0t1JQ/WM9
 PAcRsA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s4765-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:11:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee5b73c5f2so405536eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865064; x=1779469864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oFO5woUqy20XiAUuX19KXkAoiarIehV6NHqtEXjhBFg=;
 b=HU+FSLfBfa9uAIBNpY6lMNU3al48SG2uHz3gpoAFrWUtpWYVl1f6DsW2WEdxPm3fyW
 RHyEz317KDu8OGklncxhuI9Y+/QzUNPZYHGrkwA9LbF/93azUkuabmqFDUq/8exR5FZL
 O6FI6H3rjKtyZTZLhH3h9a2SUdhUEWfe1V8FllDB0h84N6TIWIcYFgr860+bIE0uwsyA
 xozJNyBWgdrs5g314yWLH9XKneYxudKOMCeLU/ieWezTwNFjAozugVK/VpK9fU8sMTw2
 xypH6jLZwbcamm38cjCVhLECV8X1pLzgkMMjWrSd24xULXd/cQyYLjpclMH7LSZayHvH
 5e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865064; x=1779469864;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFO5woUqy20XiAUuX19KXkAoiarIehV6NHqtEXjhBFg=;
 b=JFh4d+B9mv+BQhMv6jTusCEVFqOp664SW5YqaeJjIWYqk6pnHolMJoFDQiZeqlHDDD
 BSeZktFffZDLMFxnWOOH6FhJPzIIcZZnq+X6tyojNf3TYqlz0LYXXJzyLjwFVfWEAmk1
 m/O8odnKghwGjomrXPUNowJch0WbYNPOUJK/k5SkaFrJbRApykH/1L6LhBxOJLjklv7O
 xZYwQyPOqYgY+jQIhKxgRL3PNwwMTEToiaJ7ib9TWro/Ip7koIrZ+GK+PKXFe4zO9f/q
 9EDZnZARH4OzJy2PUvOVbKFnDjG/htFA8ujChkRkGIf4j19AaUsFOFwXxXZ6XTRBhleV
 W/Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cjqusKXw1WgdQeZZxKYWvC76j/Rd2ym7RkaW5PZJMukRlk2Ob0xjILmr7w6vEEZiwHJmw8dtHtIH9@nongnu.org
X-Gm-Message-State: AOJu0YwJxuOF7GV4Z45Baldt3B+QEU2KKRb966/WBWFrPfPs1T0/yGwf
 5Dre1QQ3HJc1HQQ2PskgRdB/FelO+PD/KBgj1Xx6pAAARy/G3RfZQxC/ZPGidWaea9YDnvPAgLr
 goLpMe9BJMHdVtGj17PS0LGfODBUP9aZjSI4wxlJJGfbXQPDuJP7ayaQGVQ==
X-Gm-Gg: Acq92OGf0BZE4WWV3yDHwYZbMRKXtVxzCnjAaCDqF2KTvkXRnVQ64j0biALKwgAXsRl
 IddUfg97iBjBNsLnZLGOJdwt7j/jnQGfRq5qB/dUhcajpvBFmTCeMDyjm6CNtwsVDArZpyr4RYS
 GWbSkDNQIO1jc44nuKxcKmdhcjGL+xlzxc75xNMIUOWmp/kAts0qMvBT4hTLrYXi71/b9ZjFV5P
 adffBDLDz6JWjoGUXCkvkSX3DJfGF8Y13UcbJ1KLFJjIxVBf7NKOMcUBvGpceUTFlYbCEZESDcK
 evmerZb8Tg97hwJE2ky60HHAwc30PWSC8sW01qDUzIoosRIl/VkYa8iOyV3MMwKfosk4kNCcGNo
 fYteuHCbGJ0LPPYtU9ajzPkyMDCVhIi2aTvwDBNCE64vJGHE1YssJH1/Jwxlp5FRa6/FA9PKwRh
 HNg8ayUPPT3Eq2GA==
X-Received: by 2002:a05:7301:3f0a:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-303982be43emr2435025eec.14.1778865063904; 
 Fri, 15 May 2026 10:11:03 -0700 (PDT)
X-Received: by 2002:a05:7301:3f0a:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-303982be43emr2435000eec.14.1778865063354; 
 Fri, 15 May 2026 10:11:03 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm7365542eec.21.2026.05.15.10.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:11:02 -0700 (PDT)
Message-ID: <55545b13-fda9-4098-ab18-9849a73ce404@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:11:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/20] target/arm: Implement DBGDEVID* registers in max
 AArch32 CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXy2Cn0D1SBY53
 ecKztmKZl6uV1qk5wR+qhO3gb226Ez4jMijBaY/I6jYBzhORJz2qdkC6zK7Z22Eu1/ZmfmO+fXw
 J6S1TsHUClz/wIUyWeyg62n1fKZ8+LvGYGRFxDccbntBnmPUrovUMfU1g+1IzzBlC6DRYXzx9Vk
 7izGb4gvXcvJbQ1VdYZdmBPqckQgwE89x30hnqY99+rp/ctqBuWmx9WmCdmJr4PzLSxHg+sYTuL
 jFb4jdpZSzwG8RA8Fx2tzFfxa95nlaf+zFtfZYY1bWK/j8DhkcBwS2QqzUdLZ09XnlPgobe33G7
 ceWgn8KIxvdw1GJJlk4Sj/SuR0cJS+N0/rXTbk0P9aT8ZBQSoZxt7JWcwZmFWi/t58NMpecN2Zm
 8sqTKXh2h6nvpTKHKlzoxe7AmjhVHuHfPh1rszaNaM7llpnZPiXxMQ3Bt+VR8/YA33kSSG328nq
 KI0Kq8f6EG0p+hKxt8g==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a0753a8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EI1JDHWyahz5gcua6e8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YQowfmstXU6OD6wdltTP7TjXZPsBvqxm
X-Proofpoint-ORIG-GUID: YQowfmstXU6OD6wdltTP7TjXZPsBvqxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150175
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> 32-bit ARM max CPU is a 'Cortex-A57 advertising none of the AArch64
> features'. Keep it as close as possible as the A57, by implementing
> the debug ID registers, following the changes in aarch64_a57_initfn
> added by commits 48eb3ae64b3 ("target-arm: Adjust debug ID registers
> per-CPU") and 09754ca867f ("target/arm: Implement AArch32 DBGDEVID,
> DBGDEVID1, DBGDEVID2").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/tcg/cpu32.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

