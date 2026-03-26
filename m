Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E610AB82D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 22:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5tb1-0000bw-8S; Thu, 26 Mar 2026 18:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w5taw-0000bA-Qn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:54:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w5tau-0000W7-6E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 18:54:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QI58OO1476152
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GAJeOIQCFcqcDe0X77W4oTwnmC/GvUDN9WOkXNBwQWo=; b=cAjg7otcfSf4d4IO
 8pTfxIJdj86oMHOhH3LopNYVb2Ovp/nPr5XCo4sAQlzPTqWHW0xYiNIRCMrpm4hD
 Id9zMLw+sELFhfu6n7r50q4ONDaOhzuqi5Hp4lLctj5/7FZaYIvt/+JqBjjB73T4
 ZaI2ZlXb+OIIYps7/V/tpQNjv6SeUGI4pf4OUexfGqfIY64m4P33N4mZZQpZYbrk
 gMjUVPAaJxUER5PuDoWD2WOhtihUxKHBYRN24M4uxpLFTaYvEeC36MwLEihBMa1h
 NmaiHAjzvaCrFTgMKF8YbqYnNM81cAp4EVOFpzPGuDDIG6ybpmw/cNjkQRu6gSe6
 WkLtSA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s40t1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:54:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so1602386eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 15:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774565663; x=1775170463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GAJeOIQCFcqcDe0X77W4oTwnmC/GvUDN9WOkXNBwQWo=;
 b=a90Lg6FT74Bof6QcimzGwC5gz6Qnj2gYVnI5sai00TyRlULMYkwbMmOSTl54geL7/7
 7zZz8ctrwwBC1wZXM808v4hloPCnBolkgaEsWvuQi0yt2JPlN/aR0zK5A5pMw1MaGMkp
 +cZ+SiOqRSyDPaLYIz7/X7aqOQwvZCYy6i31QiJ1G4bNEFX8fZMsHExmoAR+p3NObTII
 Q0YvkyZLPbHOpWv/ETPRZP1zyFQRI3UmceIs9HoVe79lsQuiCLM6YbcV0tynjRElWtUo
 MrCmzbVi+5+FzrzX0oa6WldiDnE0nXyTLyTvwqfJxrjJdRHbBgKrgD5HFJCYA8dUgIuN
 WXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774565663; x=1775170463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GAJeOIQCFcqcDe0X77W4oTwnmC/GvUDN9WOkXNBwQWo=;
 b=Af/KADd2OUd0C0MKjEIlfi9mi5Sp8xbfPU2MvIsRdgqzX7mhkzuYMGtBCVu+o/u9vC
 +rUZv/2CgI41DMqAopmBgxH2IirB1j/8uELEjpzvAUdHQ8NRs1uoRl9nx24r89cCcDta
 52Oa0O2rDcNHk/w7dBnsfrUFhmqx8QLs9de0HE10BtebvcQCstp/4rd2uYj2xU+GnXWS
 MuinIGLNZ/qCEDMHHX7A8Uzvur390EkWEfuLLetqXAMGU0ib0+Z1Kf4Vj13tCy6m0Jk3
 pjXX9nVoMxYlKUR6KIpbpEYCsGtWxxXNEgJG0C4nx683j9lL/EgwK9/06ngPQAhR/lzO
 /Nhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnTazhsJhTbr8KcaE5s9QSEVMMYwkpUOiZQpCgxTxMgcTNqCdmEahnSf0Zv9VsbFbMcYTeZIlJnvce@nongnu.org
X-Gm-Message-State: AOJu0Ywfug3x5ex6yrH526e5gRvdStH8Zrrp9DGxWsNzKl8PBA2gFIuf
 rHVO4J7k251qgX+ePDi/XJ2XE6BjX69Z6nDZX8PutdKnH4K4Fd2gOpS0eQ5HOgeI87jA4rFVjm2
 0PtoncJ85ge46lkLF9p04MZTF3vbzW6H+HKfEO71a3AwIDw6e5Nx0Vj6KZg==
X-Gm-Gg: ATEYQzzfhm/Z/5kr+z7JFdZ9iqlQNjEabm2Wg7ss38ByxwtnX/8zK94QQrdZYVOCLsW
 o456D7XHOQJH8MOkfHx4411T+/eq4olLcQJta7mHRWrTowEUrxEJVRyiO8y8pZFMfmQHBzUQkT1
 qtCtaxsJNBT8lykBc0TKXoXWBFnu7RtdewMU9U2bRTzDnXvkr83h+aTeb2CPsUJrFNYRneJi035
 rvEbTM1yZPBF5fJbOAqu7UgFb6DGpsKRs6x376jw5qS5UdBKlvh1+u4MnZTuP5GAFag8FQsotzK
 gRKenOOyAxLLKv+UzdNETCvco72oviAZVFvt2uBFYjItvQWJNYGsjccR0jTByli28+W8UNjglgE
 C5gjEHR8O1RfMINOZ7mEtAGswxcWFGBukEfbid90S7rhCMpVwmYpA8zisZHCT22k6gUjhkeW8jt
 pdr3k=
X-Received: by 2002:a05:7022:4398:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-12ab2838ba5mr218915c88.2.1774565662827; 
 Thu, 26 Mar 2026 15:54:22 -0700 (PDT)
X-Received: by 2002:a05:7022:4398:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-12ab2838ba5mr218897c88.2.1774565662265; 
 Thu, 26 Mar 2026 15:54:22 -0700 (PDT)
Received: from [10.110.108.41] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee39627sm3608032eec.30.2026.03.26.15.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 15:54:21 -0700 (PDT)
Message-ID: <7927329d-68a5-48ff-9a90-3c010637c643@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 15:54:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/aspeed_i2c: reset and migrate pending_intr_sts
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <20260325085450.126595-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wFTKMpYQHvA8_ArR3eY8Kgmh4VuBZWTA
X-Proofpoint-GUID: wFTKMpYQHvA8_ArR3eY8Kgmh4VuBZWTA
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c5b91f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=54KzJIt8zcjPWxL9LpEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2MyBTYWx0ZWRfX+nh3/teEy5IN
 0ktNErhVdxg+Xp/kXM8We3+y80DouPHp4BZOouvI1e/V2HuRi0ukQbnUcYz2aRaArSIjJ48KmTi
 evCB/F68YEJq5xclpTA9xcrR8L2BbBwaUvDcu8p1w1EaS914N7Bec+A/a3bzVBBcomR/p/Wkee4
 HlXPOhO0kXI9vziCRnKsAqck+sikuw8bcjPlu/8TPY4GJh+UaWiTITfXN2nexFIjeHoT/bHyh5w
 X0rQBLJy30DmQ7d0+CuEfysJcIE/dk2BdOioD3yDTDOJgGg0XqTBCRwEG/8j7BFXUazLXMOnGmk
 OLTae/ZhpHaivgQ9CERmAqCyk9MjNIwf80MFiD2J+KpJfJCSKOo886ZmOK0w2XXftoCzLyoe9cn
 hNA94DhiFSdvT9XpUoFt98tAig2aom5cyrgPyhGFpdJZAsSl9HNtlZAbR99+vmYU9q6d8jNIcAy
 Z1YnoaDKQsMDAoK8ozQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/25/2026 1:54 AM, GuoHan Zhao wrote:
> Commit 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on
> back-to-back commands") introduced pending_intr_sts to preserve
> interrupt bits that collide with already pending status bits.
> 
> That deferred interrupt state is consumed later when the guest clears
> INTR_STS, but it is not reset in aspeed_i2c_bus_reset() and it is not
> part of the bus migration state. A reset can therefore leave stale
> deferred bits behind, and migration can silently drop them.

Thanks for identifying and fixing the aforementioned omissions

> 
> Clear pending_intr_sts on reset and include it in VMState while keeping
> compatibility with older migration streams.
> 
> Fixes: 7e82393ed058 ("hw/i2c/aspeed: fix lost interrupts on back-to-back commands")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>


Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>





Thanks
Jithu

