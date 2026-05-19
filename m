Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B13CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLUO-0001cE-V3; Tue, 19 May 2026 10:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUM-0001bp-Kw
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLUL-0004fo-2y
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:32:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JAXaKX4131488
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GUAJtsqPXvSp5pllHS/C/RUHV4i6IlTknb85PlWzxWI=; b=YXiQfXj66s1DJ8kS
 8UAZsFGUiAKeCNK5zBAI7nE7kifzv5n1BT72Ma55GL+gqq35LbgslupUYAH6Lyyb
 wO95gIWYLexQp92x0+Zin+kDrrxrSfJBbQZyLEzN5odTNHY6NFDw+IBLskX7Fpe+
 Wu230419NPT3RYggOcoYfUL9MRSnoNzsIOl9mQXFiJRx8XCWt3GayEIFRqcvETwB
 SYZWO5Hzbldo2/9/mwx3ZIhwgY3WwGqIDs/l40ebuyG9qx4D64bhMI0eh4edyUV4
 8qSZeqwd7XYm3tTQSUxmRdednlQ3x0JqxCoqJ3U4oUBPljxR4AEmrEYwYDyipwM/
 SKVd5w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ht1j7nk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:32:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so4137464eec.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779201122; x=1779805922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUAJtsqPXvSp5pllHS/C/RUHV4i6IlTknb85PlWzxWI=;
 b=B2/qjQMy/v8X5g0Qx5jNg2dbjLCW/7cKECfp8nSEQb8FMh94bp2jyaDY64nV2tMlDA
 3K6eIjMWjH2KqiLISWlFPsAxSSYDhEdqtW5NcNlelHuu7z0UVeTUDey495K+YkGcSoO/
 bw0L7yuJuAiaak9YfTRSjSYSdw1TBvzX2jEKaFU1a6Gi7Uv5Me4gyop6nMFgHrxfQI7+
 F33qO7IgYWkf077EeXFB6jafVPRbcQdu9vH2JJxnaJvvmCiS+Cj8ZxfLPLD4M2icUtEo
 GITyBBb0zfPKzhJwd/5sYNCEuL9EApnlAmSBGgbdPXn8SpCd4kelVBbZC3Y8XpHqT5Li
 2cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201122; x=1779805922;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GUAJtsqPXvSp5pllHS/C/RUHV4i6IlTknb85PlWzxWI=;
 b=J+mar+iERKOM/n8B1r/mVxDe18qn8IfHLJ3HePfC1KIDVxwpZM4OYsrCh58FEgs9rq
 qwQbCxQmizH2ocdo2qc1P7zDW31OLz14BTA3yOdFtiFf4XpoIq3sbaOqN+lTN6aq1aP1
 EuPeU0YQ54sKaQSGHiTNZHmoezHYNIPYOig1PDB67mc3RGGo/X2n1RZff3lzs6Puh+jA
 at9JUOlCyC4vW1GpNokD8r9JKutv4+/LIhuwafplVSN73oofyUuKF6vlgaoqb/ZxCpS0
 NEggef3NL8a6M+pE6nvLrHuP2GBTuSB3dcC3vUHxOUtYNwVCr3y3qSVUVroxv7VHzVda
 CoEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qVHJR6YlwNcuclInoVJEA+GSZfyAl2YPkyoxXQaiO6Fs/XVxywD5NFJ17jrVhY+D1T6cgO7jD9v46@nongnu.org
X-Gm-Message-State: AOJu0YxPJEN/SQGj5s4lfWnZUjUq4LZOll/8nyoMPWVtKeqFA/NWJ5xS
 YzY1lzv8d9BiBsPBMWx6G+SyWPMXy6ShsJIOITj8GANasN57ExM2KWRlAgiTIARZp4lug4R4Lvh
 0jO1etOx8kXQAhiO7f9KeckQ8HXt7j9t1W+ekON5BD7NXw7t+tTAmJTlrXA==
X-Gm-Gg: Acq92OE7QVDKKBFukojsAhJsuaZMC3XAfpM4ZBVV3PtKLwpXjb4zDkqMbqvC1Fefb9U
 /MRxKPzWAsOQmq6yF6N4roObfRTyxtuV69KB+NZszWv6YSf4YqlLdXENVuW0l8RBEm5bYpDhBGR
 46aP2s/7ESXFqWq8aCIAMZrc+8isoKiqHnEp2g7pdONwNdSBgGoVR+5RgRvtJRSXjKdTr5WwGWH
 X6abAZAXCcf0EkBI8vYYUwtWMX6roQyW0CVJbOP5Ons0eHtO0i4NaZ9FD+xyWJVVKUaziJA12LT
 S8I3OijoR2o5JAydyFhE0HTXEQoOSYYLDZYvdwodYDXzwTMFbVrYZ1IP0QTjQvm5oxykskSMY1i
 PhSKNt8vPpICNUB5kAqHxupnGCNdE9B8TiNexFNzxrG2uLy+CfOJFPEg=
X-Received: by 2002:a05:7300:3b20:b0:2ed:e14:42ea with SMTP id
 5a478bee46e88-303986bbeddmr10971964eec.35.1779201122146; 
 Tue, 19 May 2026 07:32:02 -0700 (PDT)
X-Received: by 2002:a05:7300:3b20:b0:2ed:e14:42ea with SMTP id
 5a478bee46e88-303986bbeddmr10971924eec.35.1779201121603; 
 Tue, 19 May 2026 07:32:01 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm20868291eec.3.2026.05.19.07.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:32:01 -0700 (PDT)
Message-ID: <3372899b-57e9-4eb4-b137-9f95cda7f1a2@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:31:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] MAINTAINERS: Cover debian-loongarch-cross.docker with
 LoongArch section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518102222.80735-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JKULdcKb c=1 sm=1 tr=0 ts=6a0c7462 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=tSPrh7ZO0EESfjUX-b8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9UZMvMph9G4UwIDzHL_EoZoWaPvca5Xk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX98JhKLFYNGvl
 QcmQAxKOa3uzVR99TcyaLIuNVNaPyIkExTvlzWg4Dq2//BKZNoUvpNLzp6pm1VRpd9TfFNAvqpQ
 3NUiliKWtsbkR08qYqCe0IpgwxEQh8fDiqZG9CJcN4IpYTAU8Pp0NfJiR7Ub7cJMQShX1wFSwsj
 yDwbmZ0O9+r1+LiQd3ZOQ7mTfXjGArFblZWiE614iM+rkZSxlFqDb7ddO16R5SAymlAsmQnLw6t
 v0lCD3p7oJSB+cab1wFgSW2l5Kf4F8UOJuaG3pQ0oYttWIqYX/+lQ4sqKH/2m/iU9BG4MapfqpO
 pTgHQKAUlsCWgvxO2DSEtmZCdcMrvBMRpmZddqgJ0xqvAP8VssC+ydeKihzOsW4r0DKKTPyTZ9x
 J++1Id3dIp8XkOZ6DIkSgsOdZwaVuECxZuncdciqmgE4iIYct23PdKtyIOLvHAYeEB/gVEKDUf9
 g6shOdZ/LdbeLBoKjow==
X-Proofpoint-ORIG-GUID: 9UZMvMph9G4UwIDzHL_EoZoWaPvca5Xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143
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

On 5/18/2026 5:22 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

