Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE8CCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYBh-0006Lq-Uy; Thu, 30 Apr 2026 16:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYBd-0006LK-C3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:40:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYBZ-0001X5-QJ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:40:41 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UHfInx440792
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+Hjl5csEYvsS08g5OCf8tokeAYJYkej227694O267A=; b=UV9U+Ih9FHFLV6Ax
 08CqxUXM9NNgNFuP4kZqDqElCMH6YvBF0NOAb2wKHkX19ykdE8bKlgaAt5ERFpFN
 D6lQpBcy+EOnr2W0i+77P+K2CEx3l+eOFjHSpwdfQ7BMO27jtHkKc589rzEHhy8B
 DKmNmktMACitrIKC8iqHJVNh5VL2Z+XR4d2qYtC3c55RclqX1XQOcSzxpte4ludU
 rzslL5xWV1oRu9Gj4hxL+RsXhh9dAmaGPfRlPXfALRQxHY9tuYhtp0OgQc6j4F3A
 gNjQTW9s1lvjC+MQW3PpBGzFVyqIJyaS68caSQjBceeGFzR8zGfz9rhbUNxGKXYO
 Zw5A8A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvbpw8u0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:40:34 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c726f4055so2233898c88.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581633; x=1778186433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C+Hjl5csEYvsS08g5OCf8tokeAYJYkej227694O267A=;
 b=Ap5ku7huplTOxdDtAa7llXfat/JHzW8tPRJXWREY4GkN7RrbtJrseKCPS+R51b8IUd
 vQhuj80aVxA2eaSZQOQF55MQICWJt/trgzhbI5LXUc1tVzden7UajUuAxLQBP94JPc5v
 8qSSENIsD3OwW3mGL3OSxHxD7y7/nmLjOPYj4L9g97ajKdLaOPaUW+G0Y3ktPcpH45xu
 u79FPZNoy1sc8ioeKLuYBodNpe81Yd1N6Q4KOTL3i0odtapm0WdzSwcmXfRu5tquRyLT
 wn4K85xBZKaP4gDhDfTMbKqzXfQT4FeKS3EOce5A4yp+h/kgKsJKGANJqjjS25oL6nV9
 ihYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581633; x=1778186433;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+Hjl5csEYvsS08g5OCf8tokeAYJYkej227694O267A=;
 b=bl0FxMmjolUfzdtsPcUQxs3bZ2akBFs9v4X78n3/fOIjKTtJqMn5qogF9FNeAFlMSE
 yHGqEHT0bGurnF3cKXF7sVJ0fFUVIm2L0Wlxjj51aZyTlcN7eJaEydXifgpN23YQldKx
 EyCxavEdYPAfdRi+N1LT+HhdvkczrrNE7SzLuTvPlGee4Xna2RdUH0gJls1k5HOPN6Ik
 162HQQ6hUIhlR2oAUWxHXt+OuEYLfF8pB9sMPkeCXEYssuCyIRBI1uD29IZ031W/z7Kx
 k4VZv1RAd7NDSnQOJb0p19HRodD6fEvED7XY56mxrVIIpE3H2PQpnucTZ1APWmNWbBjM
 WldQ==
X-Gm-Message-State: AOJu0YzhqhGo9U5ATwU1KOEEL20J1q6yCN6HvRa1lw+k7rBi7kHls/b6
 z7eL94OJtjPEETCWpbDmscDwlPO5zwvl25iFt9ENlsv4KdXwqLg0imByy341Zjd7bKWaTZE1EMn
 OrI02vPIpzLHI/vLdNSebiPO1UhXSludtmA6WQtt1pJhZTppdOvn+zaoKKZzmbkz53WjK
X-Gm-Gg: AeBDiet5IU3fOBy63/UfeBCupsmcCM38aFds4VyuIFxISaFLOJOuDVxXMQveIq4mhsS
 RuK28bSBxBKbj/Bn0yxwkJDyDeS26iXe8RF7eVbmR2XFsKoVqH/8ImcT4gTh11Z+WjoVKK4Q3eL
 rppT6F9Qu/bUO2IMO1zIrsbx15S+kwdkVLBp6scCW/nxfZGUtJCiQH43A3V+AxwbWbe22FZi6r0
 boP3rHtkSwN3jxC/wligUqMmdnuBTJsWCuH1M2xgtGXdq6kBh/fitmqJwQvGh6jESSE0gPl//rM
 MMQTgDGrUbXU9erIE7lMOpnjotFQCkR+xHmWFmrlTbJZism6MbEnLlpQHOs8Urafv4TTwufdV9h
 mVEria9VHw8ZYYLJuTMU14TkBaUJResnSwVsr7Jsg3z3zlp0931WXGRQidB51EA1xQDuD6yVF4n
 v57p6Pujy8q64uPwPJ7knKZNH6
X-Received: by 2002:a05:7022:f40f:b0:128:d450:bc76 with SMTP id
 a92af1059eb24-12deacdf2edmr1948246c88.26.1777581633313; 
 Thu, 30 Apr 2026 13:40:33 -0700 (PDT)
X-Received: by 2002:a05:7022:f40f:b0:128:d450:bc76 with SMTP id
 a92af1059eb24-12deacdf2edmr1948212c88.26.1777581632721; 
 Thu, 30 Apr 2026 13:40:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12df82a141asm222391c88.8.2026.04.30.13.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 13:40:32 -0700 (PDT)
Message-ID: <b716111b-a86a-4d93-aabe-47e35e7beb8f@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 13:40:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] single-binary: deduplicate target_info()
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dozrzVg4 c=1 sm=1 tr=0 ts=69f3be42 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uBdxnfw8I0pi9JzHwZEA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX0RiD/CEuxVjx
 MPUCsLu0kCFCEQL48JyUD5aaln6SPRkGG9MT44JUn5vHwvVg22UfwLoyNr0LPijk3AP0qxoFSKA
 z5blIZLNGFIkHsew+2JbLC0mlrnElmkmWEHQvRo24a86H9jK5GdTG48Y49/uFpTpE8IpPcmhaOr
 5eDEMaeB61SeBI66ffV2vXmYyc7MJGzdYuS2yS6+kU5t5q3tIi87phNPU0KojlFrpdjc6Lm/+xY
 tD7Tymbauw1K/OuNb8JXt6oOu1NsOj3nmLhJ7QmEP2X6w1edwNx3q/Kor0PV8rs1n5Sc7SSE2N5
 vhP9IP63l6Cv2LwVkjjMrKZixtrrRKaSsMi/yny4Zq4y230bx+CH5urCybugUT3RTVPMmhaqDtW
 FHGAlRxLbL6YAzPnoW9O58GBvgc5uT+aYmCZv1RrbmTNovOeOCywp+cfhwRxoC4T7MyMOMKXQfV
 aQryDYfziPTjOLGGJ/Q==
X-Proofpoint-ORIG-GUID: 4YBl0846gc2CUXHJzn2U1Id3hCqIBDt7
X-Proofpoint-GUID: 4YBl0846gc2CUXHJzn2U1Id3hCqIBDt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300213
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

On 4/29/2026 8:56 PM, Pierrick Bouvier wrote:
> We are getting close to be able to link several targets in a single QEMU system
> binary, and the last obstacle on the road is to embed several TargetInfo in the
> same binary. The end result of this series is to have a single definition for
> target_info symbol.
> 
> This series adds TargetInfo types in QOM, and retrieve them dynamically(). At
> the moment, we don't deal yet with multiple TargetInfo selection, but install
> all that is needed to be able to do it easily.
> 
> Because TargetInfo data is set through class_init, it creates an issue at
> startup, where we may try to instantiate additional (unrelated) types just to
> retrieve the list of "target-info-X" types. Those other types class_init may be
> using target information, to add target specific properties for instance.
> This issue has been fixed by adding a new object_class_get_list_by_name_prefix
> that does not force instantiation of all QOM types, but only those matching a
> specific pattern. This way, we first initialize and retrieve target-info types
> before others.
> 
> An alternative would be to leave all this out of QOM, and use startup
> initializer to add them in a single list. However, because all the single-binary
> work has been using QOM where possible, it would be really sad to not use it for
> this final step. Comments are welcome!
> 
> Finally, sticking to our promise not create a special "single-binary
> configuration", the goal is to use the *exact* same codepath for normal binaries
> also. It means that even for existing system binaries, the goal will be to use
> QOM to retrieve current target, even if there is only one.
> 
> v2
> --
> 
> - fix header guards
> - introduce new module init step (MODULE_INIT_TARGET_INFO)
> - as a consequence of item above, we need to register TYPE_OBJECT before startup
> - fix xtensa core type registration using type_init instead of static ctor
> 
> Pierrick Bouvier (7):
>   target-info: extract target_info() definition in target-info-init.h
>   target-info: introduce TargetInfo in QOM
>   qom/object: register OBJECT and INTERFACE QOM types before main
>   target/xtensa/core: register types using type_init
>   system/vl: register target info types first in qom
>   target-info-qom: detect target from QOM
>   target-info: replace target_info() in system-mode
> 
>  configs/targets/aarch64-softmmu.c |  6 +--
>  configs/targets/arm-softmmu.c     |  6 +--
>  include/qemu/module.h             |  1 +
>  include/qemu/target-info-init.h   | 73 +++++++++++++++++++++++++++++++
>  include/qemu/target-info-qom.h    | 30 +++++++++++++
>  qom/object.c                      |  4 +-
>  system/vl.c                       |  5 +++
>  target-info-qom.c                 | 35 +++++++++++++++
>  target-info-stub.c                |  6 +--
>  target/xtensa/overlay_tool.h      |  5 ++-
>  10 files changed, 154 insertions(+), 17 deletions(-)
>  create mode 100644 include/qemu/target-info-init.h
>  create mode 100644 include/qemu/target-info-qom.h
> 

sent v3:
https://lore.kernel.org/qemu-devel/20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

