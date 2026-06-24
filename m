Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1785FCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcSec-0002pB-LD; Wed, 24 Jun 2026 14:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcSeY-0002oY-CQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:48:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcSeW-0001PG-D3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:48:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OHiu1R3832113
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tQJgaxQIf+0WdlA1H+KgOF0reIHJgs9/u5UqfA+dqdc=; b=RYO0k2lDHlsdKqf1
 qjXv/ppZOOr6Vby9ZbTxK6QX7ueT7HDVZe2rnyVz3xYcS+CfEJxNv9+f63YL81bz
 KmxVRWkpWyEUjWxrP0VXZ/EBQgs5wB2o/usFRMNzWm3f58tmWN0ELv7bTQsJ5uuk
 K1yWa9aAuYxjYb7w2t09iS5L5fEP/DMww8tu5L9XS9rdalOX5313Yk9viomhl1HL
 sLbxTnS2ps1fdKXvc1E4W3KMvQSYxgiR9VzEKQMgn5nCX2POE7fY3PGKn38ULpNM
 a8mrih+z1iqUzZcQ7UvLu488Al5nMgCBs1JB+XjcoZIe+gDZ0lKKgBtjf6t03wAy
 JIOcWg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7drr2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:48:42 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so5172816c88.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782326921; x=1782931721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQJgaxQIf+0WdlA1H+KgOF0reIHJgs9/u5UqfA+dqdc=;
 b=jJUY6SKwBfc2w0QFiP3cu9adJ4KHhJJp0a4WgHiN86OAVULVYmcr/kqpwhx8078oRi
 mEOM7R3opk1/8FXlCfAt4x79e6f+DKpSDklGvpk6fdcFZD8hAH3jZeV7Nl5McHGfwTiF
 sX9MjIMEqxzu9rzfjNQK7eGzkKNPVeIh/mPGw8cFzJjYhcaYOipUD28CwkaS+fGUipIh
 LimBtP0GgjugJ/wX8nSqO9/nbxE8Cvjh0h1GZUfaOsyyOlz58UxvaO9Wme8jv/mdd20V
 6h2dyqM3N+snNnRB92O5H2Bkxf1a7uq0quwD7ZOIX0JrQC5/Ghjx+opDMVNAd4pKhRm+
 AGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782326921; x=1782931721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQJgaxQIf+0WdlA1H+KgOF0reIHJgs9/u5UqfA+dqdc=;
 b=PjPi97rYk2RZUpbyZgUsqmG6yiyaFYkBhL221nZmbLGdR8Qysbp8ZtRIow6LLsAzZX
 VZmghfGDXfrX1g2idherMU2cW+K7eK8FFXbs3AkK+vACfmw8kmcaoLt4kKpnEvZeh0ZO
 cszG9MITCAK9rXMk3FRrZKUFZZXKCjkiXXnxGM/hzP7FMxSiDVnOAdYtG4hwfnxzGaoi
 k0w9TgKaCwnOTH1ZySW9RVFpp1fcnpBnA7figfvgjTv2Z+Vl5b3XCL7RiCckmEjiGBcd
 yPq5zKdftcTMa0ybSK/FFtVv0O9ZKux64hDsraYUQKkZqgvdzdtfoczPkmaMQFQN5WeD
 IpjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DBCAmDt7IpymoW51Ll55VbSjTE38Bildt4Us09MnK0DfCc4RE3vic+VTs8TmOJ67xbuCRQWIJyn+V@nongnu.org
X-Gm-Message-State: AOJu0YzjyH9PrS9a5POiWFq84TjY8kXESTRsQBJd3MSGDJI+I+aLKxkD
 cqyCjg8AixLWe4aarSPi9rAXW6ZxP2fxI/czYgmjS7zx/v7U65/j83WZFn6OCj+p6usE+xpKtkv
 vSpkIHdgRPBgvcXdyGyGk9n3F94t+IrIcbdSq6NDh+BqwWWNPAo6fovAgeA==
X-Gm-Gg: AfdE7clWkrT4IJcgQyJOblviKaDc6g8BiAHAyVZcdnXaWfHSw90zgZy8uKA92LPkBJa
 V9pi8aEvAygA0gA32RjDppw5QT8tFz0/I9i+RkBYbO/FDXEVk3JOmb2qHeT7Dfrq0Q6qcoMNQBb
 y/szCO4vQLaZPPXifL1IKo+do7xmYhKv/gFxHhIA91dCHNWbGOJGatO7nsOnBPIc6fYjJvIvMd1
 +Pzt+MNa6P5WUchx2d2T57acMVZaiw1vspsVXUHD8dQFoMwyfPAulpAU2BI25+US1WZ45kANuDj
 bp3YiISHxcG2sIZnkTpmUxH1q8+TqMd+64DvJ6x2M0psky9ZJWGrYSoNSSz5iNs9mc1oFPIwUfA
 5goXmdX6lS4P6/GHrxTt85QrTIqyLENK+K5hmw9ncS9s+A0ceBrkwLdZb7eZl56GEgCb4A0ZZDM
 FYZ8I=
X-Received: by 2002:a05:7022:69a4:b0:138:49ea:f487 with SMTP id
 a92af1059eb24-139d0c040f2mr4122687c88.6.1782326921309; 
 Wed, 24 Jun 2026 11:48:41 -0700 (PDT)
X-Received: by 2002:a05:7022:69a4:b0:138:49ea:f487 with SMTP id
 a92af1059eb24-139d0c040f2mr4122668c88.6.1782326920729; 
 Wed, 24 Jun 2026 11:48:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d91006bcsm952532c88.13.2026.06.24.11.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 11:48:40 -0700 (PDT)
Message-ID: <53dcdeeb-997c-4ab1-a17a-2a28b507790b@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 11:48:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, stefanha@gmail.com, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5-_En52O1GanBjxeDBepV7iG51GmgVqk
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3c268a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=DvgQ1PzX-81DNFkKbFgA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE1NiBTYWx0ZWRfX0mP0VEhUafH5
 GO/D8oHAHWjpNdyQdipQSW3wvgZyUPkX6OgJWPhO0dpMPK5qk7UeDEgJWlez+dizetx55BaqG+N
 v3BAaKhRqh7gafy/sqNyd7H119H0a7g=
X-Proofpoint-ORIG-GUID: 5-_En52O1GanBjxeDBepV7iG51GmgVqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE1NiBTYWx0ZWRfX+sKSoUK6YiiR
 LDkTODvxk+DRWXzN2tqGLKVkFkOPAUPzAbVhYsCkkUvc7Z4cSoRWdI9UVlBCBNblXk4eXx34oiB
 YuVIngCjDEkD6gqtJ2FMhvI2OXiVL+loQgdsSxxht14+on5fEHCaDksg35b55b734VMSN7t0FD1
 N+vGPXcKAnNAzANIeI8SOsr6yzVMudretRbEsaeE3nySPCo5aAEWNlMfDm3pJkfggo3TNPembtR
 aKTJlJG++frj774WNXsZIQylh/Kcwjl6v7DsuBxQvUDsz9SZ1zsUvkObKmi81kKSHMSZzzTvtQr
 nHvXTBTgoOYGFWSZfahQjKC3rgT8FvVDFHr6g9E5c6aW8kSiu2Qv8e14Rr63Xf7rTkknnp3rIh+
 AOv4Yudl2fGc5oSPmRkT3JWUUOfe2tHZnaykgnWOzXruVNfupLkl2Y40iKNYvnGVdGoeTah1a0o
 VkqVb+xWLHyyYCapIqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240156
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

On 6/23/2026 10:48 PM, Brian Cain wrote:
> The hexagon idef-parser requires flex and bison as host build
> tools.  Add them to the emsdk-wasm64-cross container image so that
> wasm64 builds including hexagon-softmmu can find them.
> 
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index 8a924816f92..5debbc77d08 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -19,7 +19,9 @@ ENV CXXFLAGS="$CFLAGS"
>  ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
>  RUN apt-get update && apt-get install -y \
>      autoconf \
> +    bison \
>      build-essential \
> +    flex \
>      libglib2.0-dev \
>      libtool \
>      pkgconf \

Feel free to pull this directly as part of an Hexagon PR.

Regards,
Pierrick

