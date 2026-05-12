Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B2CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMceH-0004ay-97; Mon, 11 May 2026 22:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMceC-0004Zx-0p
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:15:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMceA-000193-0G
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:14:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6rYJ3385188
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/T6HsVNbZ8MV9G/W0Cs7lihIlTVeTIpWZVIPs4UBFM=; b=mH1eRCWL4UzM2DJL
 wE+guqKwpb5n5tiIfFaixGABslTucZXCdAnNyurR0mw5+hr3CK1SB6solJYfxT5K
 XG9n45hKtAWpvzwYwP9DCHg/HFzdoOOzPLPVmwvGS58Yj3pBP01M9kno7vHE9bGQ
 4kacG2uWDwJ62TqW6M3d5je9e5O405l0AEJ/hNuDc+Y4b/dItoZzYvZePURWLXpZ
 ZZD4n5jGhMKm3FmrxoLfqyU3HA9W5honE+kbRnIkJt37QzpFuOiycSMinXSJxyEE
 sZ00Yqxo3z1fty34bN9OM1PJk6x5WyHhMciDl2davPe3kNaDfXvM6ZZJCAxF2avW
 2HpZCQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4h11g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:14:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so6707098eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778552095; x=1779156895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/T6HsVNbZ8MV9G/W0Cs7lihIlTVeTIpWZVIPs4UBFM=;
 b=iWHtPjFmd8wUb3SnrOPZiAvbvg0J7YA9yKUWExvxpKxNDnvoumNAPtZ8IskZJPYgVo
 zna7jYZoLk16cL5jQOvlUV76D+IlITPHXqH3Wmh0V4DqkTmU2Hz3X4w6x+oqmSlF5KXV
 MTWhfx7Z18yovF3sRg9ds3utjNPgqzWZKKtCjyB1FoUt9Grouim/bR/CaO0bI1Wvah6M
 bpBXelt3ya5ZfhNUv0JrHQ/+X54O7hkGU1i0aCOrKkxN9U3On9jC2il50OwQuo20aNKv
 EZLZTqiPUD6hvdY++Qz6jYqX1u7gbk2gw+h83MQIYw1n8HOizh5PNancQzA76dGEJ+3O
 8AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778552095; x=1779156895;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/T6HsVNbZ8MV9G/W0Cs7lihIlTVeTIpWZVIPs4UBFM=;
 b=W6IBd2LSrEftuCJyNH888sWkNq0QFgDpF2JPlsrj9etq/xTDHIGW4GaJaAfmhzF62r
 wH/KlVG5XNn1Qqb/VVj+QJVSXm1tqvZKK1ck3bipBXd34f/os4SFOoD8+B6Vq304GKiG
 zVnMXgYPShZPUwKeNkNC9bYPfnnMhB+LXi/gineMwu1yIAQ+jBOSF2af2qKwwn5nkabL
 QHsPtdHjoIHt8NW2sYz6sq/bPSwTxU1jdoPfDWOEJLqnQU5sYblnMJYqHkIH5qIMGvbz
 RTR5ifPH+YIJX9pxCeewHKjUnkuA0kaP8NzD2/SreNIl2luFBWfIGKywklQqjroh4YOY
 GX6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dBpWtZ5POwnZEy7iqJdagw+TDfl6uUy3O218il4vyjySZXXpunH5asd1IT1P+l4A5f4QwM1oIBKWe@nongnu.org
X-Gm-Message-State: AOJu0YxsD5jHcpZpib6YqFbeCHOsSfm9IUV5+gB8ZJAFVlORqf2YDxM2
 5NLmoDkvjLft94geGqMZ2ULAx+u/PrilwmT1AJ2Y2af5oK69tz42r24iLK7KRL8prsX/3TNMsvZ
 HO3QP5wQtXVqSNjK956FWHo+npJ77wEFbpZ9Hza1lCaeKqEy03vCjIX9Ivw==
X-Gm-Gg: Acq92OHrzsmqEL+tSaUK7H5OnlUmeDniZE0jSygu5MJzzfGvZRuPVEjEYkl4jFvGysH
 jo91TNbov6HP/c03JuqZf1qciRfrLzYWYWYOY6wRVXvdRJYGGLWZarI3MnTeoScZ3v5z9vdqfzd
 ZLFsEywE82yBv/Af0r6qeofAwTIds0jPDaRa9/wvvJSXWYsjzHIsH1E+Ur82DZVr/sXJ/ZSi3JC
 ljr70Ld+qcEYWPVoa8bzyt686417f4klvN4JeJ/4BHZwvdGEnjQBSgYCsXp9gAzs/Ag5wErNgii
 TVqxzRHK+G9aLfeu+m5TEDB+ef5t+bPzvDIJtQMYT3g6K4WnCDSvigSexkFS9sSfWHfuWe2+IKG
 A2Jo9SZqe4csqUEUSqR4qWxbUR6TAXcUHXesP9uYKk97HpXt4bSpLZ4ecZUvfUWHUO8m4wVz8GT
 GZHiJ7hF9IjBPOQw==
X-Received: by 2002:a05:7022:91f:b0:127:5c3d:bd95 with SMTP id
 a92af1059eb24-132a84faedbmr6320231c88.32.1778552094560; 
 Mon, 11 May 2026 19:14:54 -0700 (PDT)
X-Received: by 2002:a05:7022:91f:b0:127:5c3d:bd95 with SMTP id
 a92af1059eb24-132a84faedbmr6320214c88.32.1778552093968; 
 Mon, 11 May 2026 19:14:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278210ff2sm17279925c88.6.2026.05.11.19.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 19:14:53 -0700 (PDT)
Message-ID: <a31c87d2-8c57-4353-af45-01bdaa02fdc0@oss.qualcomm.com>
Date: Mon, 11 May 2026 19:14:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target_info optimizations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a028d1f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=d2ZiEkxV1j7TseBqg3kA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAxOSBTYWx0ZWRfX0aDTMCjnYkOQ
 FYCzfgJApxZLl9IBOy4GeTkL/KL/C7EhNzZUumtDXE5UQk1o0hGGAGmmB5T1i36YkJvIMJ93WBS
 w0krzax0k5q0z6qSb8z+J6JECTYbKZ2C9iOG8EBCbIsi6zE0jrgShyMq8xaPb57wNzvQ3BBej8e
 XdxPm/+5tRY0Ui74wlq+wbgiqe4ZWoSoejGdPkx/8mcNVhU2YFkXT2HCIvL+E/bBoc8HC7syllM
 +aGgHdUi0T/294DWWsXk1g3mLeQnf0eESPVCR7MBrg1tKCWGIKhOT4Tr6o82kfDZyaNMwbz7EWr
 DmbG5No1OdweEewYZun/xVbSUdTHD9gNoxCwITMdMMQ8IRwhRKkudrwyGVcgw/sCnky6EjIFJ/t
 gNpDJSrV1TQYrdGjaJNximl7R4C8itXa8wFwTw3sytJ72oWMH8tXwEZAB8eBPMJEpG1i2JsEsF1
 eyYECcMTx7/4hwNrYrQ==
X-Proofpoint-ORIG-GUID: 7oynwMgkyPaNvUz2BneF-64SN5pZrRNk
X-Proofpoint-GUID: 7oynwMgkyPaNvUz2BneF-64SN5pZrRNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120019
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Based-on: 20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com
> ("[PATCH v5 0/6] single-binary: deduplicate target_info()")
> 
> Allow TargetInfo accesses to resolve to a direct structure access.
> Arrange for the structure to appear const to the majority of qemu.
> For user-only, the structure actually is const; for system, the
> structure is initialized early.
>

It would be nice, if possible, to see those optimizations driven by a
concrete benchmark. We had to deal with several premature optimizations
along our road on the single-binary, and it would be great to not repeat
the same thing again on this new component.

> 
> r~
> 
> 
> Richard Henderson (5):
>   meson: Build target-info-qom.c with -fno-lto
>   target-info: Expose target_info as const data
>   target-info: Merge target-info-impl.h into target-info.h
>   target-info: Merge target-info-qapi.h into target-info.h
>   target-info: Inline accessors
> 
>  include/qemu/target-info-impl.h   |  44 -----------
>  include/qemu/target-info-init.h   |  45 ++++++++---
>  include/qemu/target-info-qapi.h   |  29 -------
>  include/qemu/target-info-qom.h    |   2 +-
>  include/qemu/target-info.h        | 123 +++++++++++++++++++++++++++---
>  configs/targets/aarch64-softmmu.c |  18 +----
>  configs/targets/arm-softmmu.c     |  18 +----
>  hw/core/machine-qmp-cmds.c        |   1 -
>  hw/uefi/ovmf-log.c                |   2 +-
>  hw/virtio/virtio-mem.c            |   2 +-
>  page-vary-common.c                |  10 +--
>  page-vary-system.c                |   8 +-
>  system/arch_init.c                |   2 +-
>  target-info-qom.c                 |  13 ++--
>  target-info-stub.c                |  27 +------
>  target-info.c                     |  95 -----------------------
>  meson.build                       |  13 ++--
>  17 files changed, 179 insertions(+), 273 deletions(-)
>  delete mode 100644 include/qemu/target-info-impl.h
>  delete mode 100644 include/qemu/target-info-qapi.h
>  delete mode 100644 target-info.c
> 


