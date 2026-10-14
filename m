Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28C8C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3hx-0007d1-Ms; Wed, 14 Oct 2026 14:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3hv-0007XR-NN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:28:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3ht-00028R-Rw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:28:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpgo51672304
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6/jR0KJPW4hafLMzT157L1ms0Lp+PixZVKSbDfjMHrQ=; b=X718rcPkRxoUNjXw
 gd/DZUCTIe7Lek0IMSQ8nt7uLkIqfjqGIKO/IB59qINn9ZsIPsDS9Oqs5DhN53wj
 bGzy4nLF+vKBRFb+4Jyu6dBh4Qk5SoLuT02X2HkJcOZQJ2AnjL8kdr0xBT/1M4Cg
 bUEnB7NSr6yR9PrRzsEP3Epp5zNU7yL4Hcc+fZqaOGvVMkKJrh5DbRcvrL6tVOoo
 wS0iAZsFj5jjDOv0MBBWraVh15s9Oa9V4JyC+OmBdOUhahj33gn5AdYISD1weU8M
 f6P/WamZuFdDhHcA33LULwZ/F20YRQRJkssW4VJOldYiEYBrWYWjXYw2SeJBabn/
 2urJ3w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh8mam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:28:04 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-17dc865c94cso685364c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002484; x=1792607284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6/jR0KJPW4hafLMzT157L1ms0Lp+PixZVKSbDfjMHrQ=;
 b=J4oSu1LFkFlQwrCWcutssJniJkbHeA2wVevow7TzWK9cHY19BHcYWje3MeLp08ipn/
 kFAEu4oGzqEdyu4k6pDj6OQB765ApNYdfI0NIfUbIbKyHPpsdGprOBmJWrVmTtdxGOxa
 3QCjIb+fnNUJ0v/tDFgnDz/pqFniVSJrt0ihy3fFEsEKejbIct3skUL5WLYTfw3SrFIo
 NX1RiJSj08gyJGYSam4WjNkQYjbY/ZHP4i0ZkMvdlDxD8wunM0AIEEGCp7Mzh99LDF9E
 3t/nk7CE+jO8UbXueTzGNOY5uKGSoqLYOonH24oFbukdjj/QXd6lNHcm39Oxc7OfCcls
 xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002484; x=1792607284;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6/jR0KJPW4hafLMzT157L1ms0Lp+PixZVKSbDfjMHrQ=;
 b=1oxXKB4YgmvmWjh5y/SWETjpefU5i7NmE72HvAsxbkCxQAX9chTbKF320tY1r4mJ/Y
 tMJnwcfOIs4gShybGa4OqnHa5hmBFDset5POqPgZ8vVG3go59SO5XfNp3ue6BMfyKRPv
 n/I1OgcaquttMHo1L7C/4YOkx998L1IwknNlZzsY9sdrqly1uFuihON6vH4MGkj4Rlu9
 QZzYhtBPSfEAi84If4K1jdKJiYPFaWSWhvTP9jsdlOHlOa9LQlEgpQFlNn42LkEzZ4eM
 6wpSjJcltdHM3MsnNca348qYI094+Sv9/GuzuJt6XERKYsyIRdeIDjA4W1uWt+DAfoJS
 n81g==
X-Gm-Message-State: AFq9FYIJxjRO7E6MWc869C/11eOIUiURBgF0mvHvxuXtq7wuID6e6/zK
 uMe/D0lJIggLUJm7W96iYIyvRZvDCVCZeNJ670c78axF4cuWqw89prvQs+1UljhEAUvHIHbbQF6
 13oBj7pqrpvP75aLzIdaT3663mQysnkiIJMrCt05ln6iJ3+L5W5bH2kfOFpDrXX4LKA==
X-Gm-Gg: AYBFou2ZH+bwGIHHQMbN4WMREZVS4fBDmGghVdjtBSjFwZJd2PuMwmTBgjuXUywSdkp
 /q8u0Qg6IkEv1G1N4oLNbrjurP18YAHSPNG/do4ynkttIQCW4pY5bPAQ4NQgKC7znVWw+dzAv1Z
 28XhLjZekMgR+wQEr4bzjsEr/kvEAoCjkeR1/CfGS5q4L+0cUOTDrYlGH8egg0mPVHCUA5bYIsc
 A13tjeBnGgCPovKMqOjhvyGzULVnbMsByWpZL8SDtB8AChu7DaDdOzqzIRlaaXFQg0UR1vt1KLT
 0fEgLe4jcJTRZ1HRdXAyg/lNNCnRYqiD4lnHQ9wK7Zrlzw+SIOykeCuJGDoi54gjdW2I60XDi+G
 VIS/UnYa1KwM1g8ty+BJNI82tbSS9C9Zhhukkvkn5l4nX/GhDo4VkchjpfR3xqd1jbH2aiQ==
X-Received: by 2002:a05:7022:1605:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-16a5fc917b4mr27321544c88.10.1792002483487; 
 Wed, 14 Oct 2026 11:28:03 -0700 (PDT)
X-Received: by 2002:a05:7022:1605:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-16a5fc917b4mr27321411c88.10.1792002481709; 
 Wed, 14 Oct 2026 11:28:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a42407e7sm49133341c88.15.2026.10.14.11.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 11:28:01 -0700 (PDT)
Message-ID: <5cf6f17c-1a72-4add-beb2-be4498e94bbb@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:27:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] multi-target: add hexagon
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: X0HoU-pQft_NWs61uI212WtLoBuTgG34
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX0P9bC5nG4XG/
 ASslVEertpEtEOSvjCFManrVuFfCz5kdQoLgaKS6v2aWBf2VcB5qG9WyQk6PZHAIukHOVkYTAQh
 +NO4tJ9W+RuZv9pRumdYrgTglbldLiE=
X-Proofpoint-GUID: X0HoU-pQft_NWs61uI212WtLoBuTgG34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX+EWGXC2/EBGV
 DzMbV5WkAw1SXx3H4b0NBldz+A191U8HdC0xS7pLEjAP0b+NSzMDThhMyzDWBScS1nrgeJDnlBg
 0DfYpAtesTgiGpQ9HhyVMKiyluO2pWrMmRH6kv+3IYgIWD5zeKWgJoXQah9IdXSwz2UxIF72q0R
 lBE+ujzo1nIl6kXScA8u39674RcB2lXaoFiOpmFehBRj1z40cOu+5V13jSY+N5TtQfQil0/arKy
 hr2VN5b6+1gd/gtXT894UEkQE7KaXuuSegUDXN1UW8I4F1tLqcmJmMdPjELrVDxSbdNWe0ry/mb
 qh9mjC+RqhxbGx7GAqq5oEyUiJSamzfy+JnzNlgt4RL+GklVDL3sQ9WuL/t0471THFVlLdkeT7v
 uhqROPecXPZ9euXHAnwtx21x/6RkDBVFMDnrnZ5fMLlxgMlhW1ylvYYcYbM8KR+uYt+NGeqlykD
 rByxswdt52vVE64Z1Ng==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acfc9b4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q9RrAthI1Nh1P9Vuh0AA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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

On 10/9/2026 3:52 PM, Pierrick Bouvier wrote:
> This series makes hexagon compatible with the other ones we already integrated.
> 
> The biggest change is to introduce a semihosting interface, since existing arm
> symbols conflict with hexagon ones. This is also need for when we'll integrate
> riscv soon.
> 
> Pierrick Bouvier (11):
>   target/hexagon: prefix helpers conflicting with other arch
>   target-info: add target_hexagon
>   hw/hexagon/virt: make machine available for hexagon target only
>   hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
>   semihosting: declare semihosting cpu ops
>   target/riscv: declare semihosting ops
>   target/hexagon: declare semihosting ops
>   target/arm: declare semihosting ops
>   semihosting: use new semihosting ops
>   semihosting: remove common_* functions
>   meson.build: add hexagon-softmmu to multi-target
> 
>  hw/hexagon/virt.c                   |  2 ++
>  include/hw/core/cpu.h               |  8 +++++
>  include/qemu/target-info.h          |  7 ++++
>  include/semihosting/common-semi.h   | 24 +++++++++----
>  meson.build                         |  1 +
>  semihosting/arm-compat-semi.c       | 56 ++++++++++++++---------------
>  target-info.c                       |  5 +++
>  target/arm/common-semi-target.c     | 29 ++++++++++-----
>  target/arm/cpu.c                    |  4 +++
>  target/arm/internals.h              |  2 ++
>  target/hexagon/common-semi-target.c | 26 +++++++++-----
>  target/hexagon/cpu.c                |  2 ++
>  target/hexagon/gen_tcg_sys.h        |  2 +-
>  target/hexagon/helper.h             |  4 +--
>  target/hexagon/hex_mmu.c            |  2 +-
>  target/hexagon/hex_mmu.h            |  2 +-
>  target/hexagon/internal.h           |  2 ++
>  target/hexagon/op_helper.c          |  4 +--
>  target/hexagon/translate.c          |  4 +--
>  target/riscv/common-semi-target.c   | 29 ++++++++++-----
>  target/riscv/cpu.c                  |  4 +++
>  target/riscv/internals.h            |  2 ++
>  22 files changed, 151 insertions(+), 70 deletions(-)
> 

Sent v2, rebased on master:
https://lore.kernel.org/qemu-devel/20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

