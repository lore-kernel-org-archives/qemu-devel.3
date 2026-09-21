Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9198C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8agh-00056A-S2; Mon, 21 Sep 2026 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8agg-00055e-Gj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:51:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8agf-0007Qz-2m
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:51:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L8aNRs4146586
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PSlMyHhWFrEhvJ5vne6Rj2f5NzUBG1S8FtzVxfY15aE=; b=WfmsD4qt/LDRHv8E
 TuwUGqlCheItGpgr5eU7rVoqaFDNQT7Ruw/of+x/5Ci73qen43cKQWZfQ6LjqxY4
 PdtzlNxQEQdjwjFBWbQJ4cevvlXYXi3dyCAVfoQ+iDmVY6lHJBLgjYq5rvNMqJoQ
 ky/GOGuYK/rc4AviGlP+KQ0JVOeZm3NzqCbQ+/UyXiq+/y35e9QWGVtpkdx03/e3
 gN/ycagy3RgKJid5/syxp+Y4hw/JymTrpKKNCpFbc2yTIPMJYFJg0gvybkvAYtXJ
 +l6cY0A1EAFHT3PLNA29GAmK+9pwlKiV46lloEPQLdV9c/Fyh+4zE5wlGvXZP/z6
 tC8XFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17grath-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:51:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a00c70d28so462576485a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789984306; x=1790589106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSlMyHhWFrEhvJ5vne6Rj2f5NzUBG1S8FtzVxfY15aE=;
 b=P5ZY22Lie6MVtVPeHGxzXVuoKhTz4iFKMc7fZ/Fn0UTf8y3YeDRngXmAeDO7dN1idR
 tOQhIN2d4irEvoIJ3LHLRCgaJawa7S3yq3xzJBzSViR5SadVKCAij8ybBwQREV7Vgply
 +0JqvS3S7grKLLm5e1LD2ye8W0ynf1YStR3Bpo14fFdsJtIfiTjCRe4NYShwEngk3xsq
 9bUZUni1J0RIo3PrdB4DMsxZEqSCXv+2qlYZmtoB3fqoEHaLMGYye9eopfcPHuVgYNYm
 K8oeUb/JH2p4qbXIWcIKZdDY4JwMl5MGSfb5YHh0CzNdnYtX4Tx9rndZc1mpnSsUKbwe
 AqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984306; x=1790589106;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSlMyHhWFrEhvJ5vne6Rj2f5NzUBG1S8FtzVxfY15aE=;
 b=PqL9DT4g73d4t5O+HR0j4hzxrDK9paZvWrzIYIdAuAc4o1MrJ/ktsMFaLFBCnqCYfg
 gE8G/B2Jk8YqG1EsmvvoRYj5LPBBKSAF3IXj3BcWtzpeRPXnZnf/viEWpkwr9F1ljMMi
 C8jfwjsowct+pMBqm9ojtDhgEWapF30QZy/l42fRILOFbv+XIyRhWtHwqqwrQVha8HTH
 PmU1XxDtSIbJhiwyG/dvQvQPICQT1FFQc/68IfKa0K5TOtW2zi5PDxNJCzMljwo0xejU
 q02MegYY3QIwXeUPpm5lTImSugDBPd+wsZcPvLjFtZcMS5snngqtvwthswRljCxYyuUt
 Jreg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFtz+JnejADIVrZbt02z8EP3NuIU322rFy6k7kkkveMkbbtqsXlcLc9dJyQCkO+6QNxUlzCv4t8+1k@nongnu.org
X-Gm-Message-State: AFuF++k7Fy0wuLbGB8yFq+ihHICKmmz92tG9XrBZhayoYSre2tuL1kLz
 YG/AjTX+vDPoNu7dR64xY/VtZRAxqqqLW/p0LFYj15oUTYvA3z2ZnWxS27VAvcJvKAN6KojNjFA
 9zWCs9mO2LalYnebqd98W3RKwIUM1yTXfa1Nf8UZ1CP4lxC8sBiYfja/Kkw==
X-Gm-Gg: AYBFou06BvbSM9qsPoJMpW3C0K+kZrQwUidN1Bj2KbjwgQl66mubR0zdMmCty7VPJZC
 Lit8RKgmTt5cYIsIUqZrJtW2f0VHObM5cYgZrUMObrE4Ym/dF3/RCIZw4bIiEav+enWwFYx+uZy
 AlhJWX41o5WPRXwcTTy8qoqd4EggfZiWd1ONT80ZuqCzoUg5yFiQElbwTDN+Ql3x84Rx8ld+CYm
 X9zEzkjAxzaM9IoOBBn5XgUibD750T6o5gh3z+ry3pmx2fM1PQgQqWMt6UoKD8kUrGAVHt9NYy3
 Fp0CsYnJ6aFk1RxC72OICuedmmm7O1QSKUd5GWAiMPUxfkrmlWGmT8lT7yCW+L87mPfHh3dWfJK
 TOHwclw7AKjmwfJ62Xk9gHmC0MZP1VKDIvg==
X-Received: by 2002:a05:620a:198a:b0:939:b559:1e82 with SMTP id
 af79cd13be357-93bf56edb33mr916882785a.41.1789984306176; 
 Mon, 21 Sep 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a05:620a:198a:b0:939:b559:1e82 with SMTP id
 af79cd13be357-93bf56edb33mr916880785a.41.1789984305745; 
 Mon, 21 Sep 2026 02:51:45 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd07411fsm226727635e9.7.2026.09.21.02.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:51:44 -0700 (PDT)
Message-ID: <7f21b82c-9c3a-4075-84e4-e170c0b1accd@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] hw/isa/pc87560: Add main isa code for NS 87560 SuperIO
 chip
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Helge Deller <deller@gmx.de>,
 "Denis V. Lunev" <den@openvz.org>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
References: <20260918163829.2917-1-deller@kernel.org>
 <20260918163829.2917-3-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918163829.2917-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8f3DvYU63E3EtqtojTnlvkvyrKOIivXh
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab0fe33 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=ThA4JjV-dTwqHUUXHCAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0MSBTYWx0ZWRfX0a7TCOHVmPKC
 AwctcEXL4DqVUgQZaefhmHSVJshQqtwsy5JmexhToUqai80tnKhcAN+vlHrJKzcsef67FU89VBw
 lDdbRIAuf6yU1BoBoUV3GeACWB6XjMnuaCxJ9D2mAfHqBaYCIHfyRDeM9lkvN0DecNJQ0E26+bx
 sSRqnHINNVcCvA++GE2og+1jq5gwpb84aNzR2B6rAMNE9qpuARShsJhI1DapfBr8bJ4FjLFJn75
 FwuFsQVvFgmnUoIQscuRmB9uTOp3hjg1KWduK7/C+WQ0MdPJa3L8vEGWtVhaT2A9tAU/3hreSKS
 Niia4tIQgM45m42DpATH1Ylpv0eoJdsGMatbYYBX5HDg7O5DS3uxuexAsz8V8IRt7ho51BkF1QF
 0sGm1oThbXu3nOmelKoENrhoJuNZEBT0MSTe0UPsPB170oWjPCghZd++c8Jf9NAIFyRrGn7GsVR
 328SyEl+kw1EpYWe0MA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0MSBTYWx0ZWRfX/MKFJnEGJcZF
 9ajtjG58wJjg+35pjnafOaNlBsn14/0eRu8n5lw7dBS9teaLK23rU33U5Qdu6s+0zaqBFKuiKo5
 fWtQaVQJdJugmRJRoBTrh5dJheD/Ml8=
X-Proofpoint-ORIG-GUID: 8f3DvYU63E3EtqtojTnlvkvyrKOIivXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 18/9/26 18:38, Helge Deller wrote:
> From: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
> 
> Add emulation of the core components (PCI function 1 aka I/O
> Peripherals) of the National Semiconductor SuperIO chip which was
> commonly used in HP PA-RISC B- and C-class workstations. This includes
> the PIC interrupt controller, the floppy controller, serial and parallel
> ports.
> 
> Signed-off-by: Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   MAINTAINERS              |   2 +
>   hw/isa/Kconfig           |  11 +
>   hw/isa/pc87560.c         | 510 +++++++++++++++++++++++++++++++++++++++
>   include/hw/isa/pc87560.h |  96 ++++++++
>   4 files changed, 619 insertions(+)
>   create mode 100644 hw/isa/pc87560.c
>   create mode 100644 include/hw/isa/pc87560.h


> diff --git a/hw/isa/pc87560.c b/hw/isa/pc87560.c
> new file mode 100644
> index 0000000000..c13c54deb2
> --- /dev/null
> +++ b/hw/isa/pc87560.c
> @@ -0,0 +1,510 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Did we change the coding style to allow C++ comments?

