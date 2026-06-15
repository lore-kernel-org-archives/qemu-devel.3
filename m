Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B9BCD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD8c-00070w-IM; Mon, 15 Jun 2026 15:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD8U-0006ou-4t
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:38:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD8R-00029V-Vu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:38:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxE2D844427
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdIkpgkldlj9foHFULrZ7jGOCB+eBoeJxrBP6VVWZbk=; b=Tnshcc08zmrV6Wqp
 kaGcpqZcV1u7lsbpqfCFbe0sTj1Z/3VzT2YilLyuWsXNWlOtusVBm6Hcr86gwOZd
 UWluCLzG60gPFCOe3/Y2ya3QUVxLzIlkeM40zReMLABLQtLy7V1GXdOIAQidlZkn
 bz/6I0ygH1WjKSC78focUIdCxF6+L/bkxSYA+1L8nkZmcFrBqIERc95DaQwq4oen
 FYzXYnjaMuU1hzrb88ffq8OS8vkCD7Hl+oceKzr3Kf559AbVSxO4BNeu/ykSgUzH
 So6tI859OUoe0E1Yhm7g0qGxQFdlU0oWyILbDbTHISTBWuoh9l0Fz1gi6cEcFJeB
 mcYojQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter02kj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:38:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13967c19ac6so6845270c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552294; x=1782157094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rdIkpgkldlj9foHFULrZ7jGOCB+eBoeJxrBP6VVWZbk=;
 b=fOZtvohiYncpbv3uXfAnVU2+RDADY8DNQpnPvv/jMjOPDHAHFLR4QQ2u+o837EXxgk
 7Hb2lE2dzZhZc42mi22VoLXqcyscR5Btol225SxKwZQByogbrKBzm62oaZSb0D534MaM
 FNvs/m5jU5sRejiU3S7ncihysyoYKcw9X0Fc535h0FeppC+wMuVQHFc7MJnKbslGB6Xl
 VHugfiLK5TCyLncYPooSpfBhEBnsLaLXlicxhrGTbKPlhQ8XNh1AfG63dtB5Xy1XtSE3
 Yzi/HWKLRVG/JIskQPpPfJW0se/9noOLJu8gE6qMdTAHFWiKOM4XGiZMGSyBSwktHN2F
 xLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552294; x=1782157094;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rdIkpgkldlj9foHFULrZ7jGOCB+eBoeJxrBP6VVWZbk=;
 b=OgocypeC0K9NpE/YAD1nsip9oNsxcaEmc3K23Eudtt+Phh3fRwwqpuqkiuqCi508pS
 e0hMR5IaPlUy8SYxl7Db54LdRp3BrLNY1E/j4jv67tIKPXcAQkWLQrccIPHdUNJ4Icv1
 H82dOnHDxFM2LRzvlAsisthQrBKrl9McvQCuCqcWwR6/hcHqup91vY2Uc4GhajV+gRWM
 far6ynNbFYONQChuWy1+17sMOf30miObPiPSd2aHJgW7DWo0zuaHniaXAeB0cP3cV5qr
 WGhDj71x0gG4fH+G555YYpBgNUYqwny4xonFgbrsrg6Iiw/9FC1noNbJQj46wRn+CnSG
 hcqw==
X-Gm-Message-State: AOJu0Yx3oTI7WQ2YfSeAPYNvWtKNtuX3H31DS2vJ1FuyUlZj1W+XhsxT
 nvpoCGv47YedcaeCoKCzr11vw6W9KO0f4g/w6RiBidG3umrMb3+h0dctFDhD18ZpPJelm/ScUR6
 sZvLo2yxzSjN1P3gkinW5dtPbZd88pV4D0sN+k4NurPZaRYJBEnlY8V/+nR/g84xIgTKh
X-Gm-Gg: Acq92OF93sOHe5EQkaCO8ZodvaoCIeBWWbslvaK9ncFdAjV8yWYEaYSRWKbjcBDio7n
 R/f3ZhZKCNyVeB5/3rzxCVAvk5Sajxn22JUPOjg9NqL8CQbwphVfrXE09rJQzLyQaMCGB9kbqoH
 LmSAJzIoE76Njw4ETxpYG9eV5BK7beuOHr3YGBe5b1VoOntQ7wQtSOLKadUCOVLq2RWONubx+VS
 sGCl3syj8LbWdBpVoMS39+SUappQukCJfzRTuHuOQBYE/DhwvK0MJ7PVtTpfF4oKz9rUkIwDXTF
 1gZ7VpH+Tehk/7+y9a4ueDE5aNalRsC5JQu3SdD+nEVglGmcGRDY0g90iJFMY3Cv2evXe8n1zW2
 Gct6etg4rXm+QgldCUHe0oCiD6hZEB1BqhMYdfeQaX03LE1pm4j+7/7/KvSRWjdsWTuaG4BJbcu
 lOQh23E6mN0s5T5g==
X-Received: by 2002:a05:7022:f96:b0:137:ec47:8fd7 with SMTP id
 a92af1059eb24-1386f245648mr6024311c88.9.1781552293892; 
 Mon, 15 Jun 2026 12:38:13 -0700 (PDT)
X-Received: by 2002:a05:7022:f96:b0:137:ec47:8fd7 with SMTP id
 a92af1059eb24-1386f245648mr6024289c88.9.1781552293287; 
 Mon, 15 Jun 2026 12:38:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b975e55sm11827719c88.13.2026.06.15.12.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 12:38:12 -0700 (PDT)
Message-ID: <14380f29-c8d0-4800-8043-163c7dd8e162@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:38:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/25] plugins: refactor API to maintain state through
 callbacks chain
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5_QL-iOoolvRIra-rFc7O8_jqowUAG--
X-Proofpoint-GUID: 5_QL-iOoolvRIra-rFc7O8_jqowUAG--
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a3054a6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1nqhs7xc5XLLtRwDZDwA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwOCBTYWx0ZWRfX/sppsQicu39E
 e8sr3GbbMpRrKs071wB5v6km894qm01nQktefG3JWDp4ZXPILvAcciLZy9VtvOiR1KBW3M0r3kI
 mi0Uc03vzo3cc3D4abdQhAJYeQkjM4KxLP+1cV+sVkeKzCgzUdpoJXW7xOZ/YClt+jOpEO80Fa1
 c60Wh7ftClmZdNLNLXCFvvRhjY0Dp1pOhcqtNB7juokkjoPHp4QCQFip0EtFPI0ovmO78ijhV+C
 X6PXZ/H8vOrWQjm0S6R0DhFd3qOgWDi0+2dfrE0jDFGQTPhZQMw3LObUzYpeUpGkQrK6swLiF64
 GL2mN7xqAxBUpdruXBbS11c8IHOeJ8Jyto0qIPhIsPMdDAF6YZUGocV6N14iUeaSCNBohH46lo0
 k+IqQ0N+UlzY59f+nMQ2nPqFJe0pj0rk2G+7s8TVFyZXf/se9QzEaOmWy8iw9oqvm9eGIRicRwb
 yFmXHx9TI36a+oScUqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwOCBTYWx0ZWRfX4zi39FBOn3xs
 rbAQNhowUjUpJWFfgHhUgGW0Yotar649/21a+9SD0N+7EvdpJh0r8LYlnPps4AzuUjXFr7bSnE7
 ZI/qsl795N9QnuPqNP5dOO7vH7gtnOk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150208
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

On 6/3/2026 1:51 PM, Pierrick Bouvier wrote:
> A coworker recently wrote a C++ plugin, and noticed interesting limitations of
> current API. Basically, the biggest issue is that the only way to maintain state
> in a plugin is by using global variables. The root cause is that some
> callback types can't transfer user data.
> 
> Also, he asked why some callbacks have a qemu_plugin_id_t, and some other don't.
> This excellent question exposed that we don't need this most of the time. And if
> needed, we can rely on user data instead.
> 
> For functional programmers here, it allows to have something similar to
> continuation-passing style, with all callbacks carrying data to next one.
> 
> This series modifies our callback types to make sure they all have a userdata,
> and none have a qemu_plugin_id. Existing C plugins don't need to change, and
> global variables can still exist.
> 
> After all those changes, we can finally implement a C++ plugin without any
> static variable (well, out of qemu_plugin_version), using an object and
> lambdas. This act as a demonstration of how we could write future plugins, and
> also, how we are finally on the edge to offer a proper native interface
> in Rust using closures.
> 
> Pierrick Bouvier (25):
>   plugins: bump version
>   plugins: add userdata for qemu_plugin_{uninstall, reset}
>   plugins: add userdata to qemu_plugin_register_flush_cb
>   plugins: remove type qemu_plugin_simple_cb_t
>   plugins: remove qemu_plugin_id_t from qemu_plugin_udata_cb_t
>   plugins: remove qemu_plugin_id_t from qemu_plugin_vcpu_simple_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_init_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_exit_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_idle_cb
>   plugins: add userdata to qemu_plugin_register_vcpu_resume_cb
>   plugins: add userdata to qemu_plugin_vcpu_for_each
>   plugins: remove type qemu_plugin_vcpu_simple_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_discon_cb
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_discon_cb_t
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_tb_trans_cb_t
>   plugins: add userdata to qemu_plugin_vcpu_tb_trans_cb_t
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_cb
>   plugins: remove qemu_plugin_id from
>     qemu_plugin_vcpu_syscall_filter_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_filter_cb
>   plugins: remove qemu_plugin_id from qemu_plugin_vcpu_syscall_ret_cb_t
>   plugins: add userdata to qemu_plugin_register_vcpu_syscall_ret_cb
>   scripts/checkpatch: ignore spaces required around some operators in
>     C++
>   scripts/checkpatch: remove check on forbidden space before '[' in C++
>   plugins/cpp: register callbacks using captureless lambda
> 
>  contrib/plugins/bbv.c         |  10 +--
>  contrib/plugins/cache.c       |   6 +-
>  contrib/plugins/cflow.c       |   6 +-
>  contrib/plugins/cpp.cpp       |  89 +++++++++++++++++++++++++-
>  contrib/plugins/drcov.c       |   6 +-
>  contrib/plugins/execlog.c     |  10 +--
>  contrib/plugins/hotblocks.c   |   6 +-
>  contrib/plugins/hotpages.c    |   6 +-
>  contrib/plugins/howvec.c      |   6 +-
>  contrib/plugins/hwprofile.c   |   6 +-
>  contrib/plugins/ips.c         |  14 ++---
>  contrib/plugins/lockstep.c    |  18 +++---
>  contrib/plugins/stoptrigger.c |   6 +-
>  contrib/plugins/traps.c       |   9 +--
>  contrib/plugins/uftrace.c     |  10 +--
>  include/plugins/qemu-plugin.h | 114 +++++++++++++++++++---------------
>  include/qemu/plugin.h         |   2 -
>  plugins/api.c                 |  40 +++++++-----
>  plugins/core.c                |  94 +++++++++++-----------------
>  plugins/loader.c              |  13 ++--
>  plugins/plugin.h              |   5 +-
>  scripts/checkpatch.pl         |  20 +++++-
>  tests/tcg/plugins/bb.c        |  10 +--
>  tests/tcg/plugins/discons.c   |  10 +--
>  tests/tcg/plugins/empty.c     |   4 +-
>  tests/tcg/plugins/inline.c    |   6 +-
>  tests/tcg/plugins/insn.c      |  10 +--
>  tests/tcg/plugins/mem.c       |   6 +-
>  tests/tcg/plugins/patch.c     |   4 +-
>  tests/tcg/plugins/registers.c |   4 +-
>  tests/tcg/plugins/reset.c     |  17 ++---
>  tests/tcg/plugins/setpc.c     |  10 +--
>  tests/tcg/plugins/syscall.c   |  22 ++++---
>  33 files changed, 354 insertions(+), 245 deletions(-)
> 

sent v2:
https://lore.kernel.org/qemu-devel/20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

