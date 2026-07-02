Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64A7C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHZU-0007Il-LS; Thu, 02 Jul 2026 09:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHZQ-0007AI-14
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:35:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHZO-0000eS-Ea
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:35:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0cuY406514
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eBIUme7Dp8TPgfG1/patlC/ZlkGHJU+GTWIu2CZ9AQ4=; b=iOrL+1I64lgdWPew
 jz0pezVt822obe1hRceUATmw6dnxbgKKQMvjyPSOJGcAtkIkX/qOSmxw4OIS6fWh
 I8WkJu3y9GbydLY0Hfh3fbetjxem3ZrLAsrjCDrfyDtQpvvhnPlAIxcI5nj3RjXw
 UfhgVeAJLyqJnbU0SrepuIEIPiZeosddfiOhyXYYYysCK4maMdBclqZ/lF0Wb0Ve
 j5a3UbRFTALYVsQ8+TeMh4AORSTl/m2BL+262aiQmHmOTxj1ylYBDGTr5lyOYh6o
 ECUYC7Qek/mlKg3UNHIRY4+rUDP2Wn4vKaCkCG2yCARWIyJINmPg90/hYLZqWg3v
 IWEEEg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98hxgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:35:09 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bdaa7039d7so1782599e0c.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782999309; x=1783604109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBIUme7Dp8TPgfG1/patlC/ZlkGHJU+GTWIu2CZ9AQ4=;
 b=adfesn+3jd7wxwHdKeH6pfc2bGH0bX4q3RbKhzEhIDWYzjivxM+joAqlqNaBmV5VlZ
 eUrHkxkD4/VCkjyuhew8KmFBzkY12XtmZO50AIO1tdLp1hRyWsJ1xFmVCeDWQzK2F2lw
 3D8LYrDMMB3Yqxcm8d4VQD1S3wkxpjAeZDMlpWP33gviioDY8TYW4uQWGo/dHR7NA0kv
 RonrPoV8KNpWIPK8K3q0RqnkmUcJfwhJ0S5A6GW3WxN0QGR4z7UiDzcU52mFKDqCBI6u
 Emh0/Hy5sZLF+e3HiUkQyMAYoANGTUE7KfwBw9sq1PgZS15YspB6oAwXC0mYFKMqERIT
 t2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999309; x=1783604109;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBIUme7Dp8TPgfG1/patlC/ZlkGHJU+GTWIu2CZ9AQ4=;
 b=Rshmn7Bs454TYZutvTKlG4Ta8J7DmSfJnGZ37B/iWadw1EKjo5C8Xj1lk70VYpurhU
 FIfrwF4G+HPMTireRXxb9Ls5q+WEXmx2zy8xlp2y8pDJPElYknfrSVlhYl9Uv+VDArEV
 g/m6K2tGoBhWx5eVrVF2F1FUiqvWmp84oLNsnVoOG1gqeszJXlfLqWFnpRLSXQ28UCT4
 T56WyelByPmv2Tv1c2dGL77ORUtfUgSeiA0EtQ6lZF+KfkBI++h3gYtvOcLwPxKMZ6r5
 AiHpqtkKvoECo8INSe10El19nCKVa/mll+5kXnCqv3r+Nzknc3toDBN7htPkPiN/Uzgs
 m6zg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr0hXSXcd9aGT+U2qID8NDpPHjVD5MA2yIyjXW7U2vuLhkgEMPu1zHXW6OC+M9gpFBK6Ju9AHrd/mg@nongnu.org
X-Gm-Message-State: AOJu0Yw7wR7WD177UjHp/GfdVEWb1u6TR2q6iamJwEDOOPhyo8HnL4ak
 bOcaQNJ8Zghs9fFhHWIcTS5nS+r+zaglqCy9Lxf5yzG9XfLLv1zkg7nfxRWdP5rs+HHDZJdrklx
 quKmqNX/VY6sWGwqX2O8wVcTIwCK8jAuR41RysklmWNAv10VYACGr9AH2Ow==
X-Gm-Gg: AfdE7cnU4VoPeBxub3qrZfsCdqrRw/z8xu8vA2n1RS2or35XffPD1tW8UvOJn7v2k+Q
 LA7XrlcS7ZqwXZam7g010lwpyUcFABkJtLtu9GfAegUqPrgo3oGArLAR88oh8tTczZ2KCV5vcJa
 12e3I64ckQREOb/bJ/BpWNHFV5mA0EikKJvUEyn8knpc48eFvgG+9jnk7/pdH2GgTQtLOF8tot+
 2+h9xdFVh/Le0/Xxs0J00pW1nwqff6vnsjeoVu0zJbp0hTaQtJPhsSKTZQxDJRAxNyw1cPbz/z/
 +P7ZYp8x9AFl7Nvh+L4EvO2YBNvbznmL04QFyWlE3Mvks9A/QmFJ7Z1sOq85wpeCFZeAt8IoY1G
 270rSggcidLTbNKc1Ju40gMbaLSfNhJw99+5qTJkmtlYx
X-Received: by 2002:a05:6122:3b8b:b0:5bd:a6e9:711b with SMTP id
 71dfb90a1353d-5bde3cefdfcmr2246028e0c.13.1782999307969; 
 Thu, 02 Jul 2026 06:35:07 -0700 (PDT)
X-Received: by 2002:a05:6122:3b8b:b0:5bd:a6e9:711b with SMTP id
 71dfb90a1353d-5bde3cefdfcmr2246007e0c.13.1782999307566; 
 Thu, 02 Jul 2026 06:35:07 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-969838c7330sm935359241.6.2026.07.02.06.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:35:07 -0700 (PDT)
Message-ID: <762694f6-d324-48ac-93a8-5ae59b61f9cf@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:35:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] cpu: Better name cpu_single_step() trace event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-31-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-31-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GdSV8M6rMw_NI6XDSY7Lii2Sqox3SYN3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX7eSQUB89+0yR
 qW0laFK16zq12M4R/Vk5fhGNShGFXadPKdZE8pi067Fi3caIf7IikiyUB9I9qzBODw9iJZzEMHR
 CgUKZnEd1hhmEq7+ZJWI2jToGJSs01Fcq1/Y6eagOeSJbiFreSxrZGUpU9HRmWSh5TC0k7kttFg
 KgNPN90und+7n0XJm+41fblf9tE5HrbgfDWs+At3RMeptXFPSNn6pt3gglkNi7lFeyzhoWMnuh4
 dxCJdSz+ShYTRQRKh+1FmEV8d5GTPVH3iEyxLhPa0rULpD/nuYT34ObOCTLAwehYAirnJMDTzEJ
 V5syn5Q/hW7YoXHSiUH6CB3/ZOAkOzZNhvcFqRcaeqN1bYrBlIolmOc07GAEbTKqCJv9PZX2rvZ
 W94ac84j6dI7LQWp3oXMufv1szCzUqqgXLkA60kyp5SuVo9LWqg1zNgXU5p+gD3AAuyjdBhOJjk
 F+KWEDzlqgBiNi+eUDw==
X-Proofpoint-GUID: GdSV8M6rMw_NI6XDSY7Lii2Sqox3SYN3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX3zHcdGRgUMmC
 5vgtNeYTiv7f1kiYNexbDzzXWAGeHPlE773oK/C50drqxEPsdyeUSulNnNhtUewoTE+VAibVU7L
 951UflibHgeQutaHBFfKIRvqABZBsNk=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46690d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MH2uMzepxiT5-WGLEYEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> cpu_single_step() is not related to breakpoints. Rename the
> trace event.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   cpu-target.c | 4 ++--
>   trace-events | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index f030e2c642e..019906b32eb 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -31,6 +31,8 @@
>   void cpu_single_step(CPUState *cpu, int enabled)
>   {
>       if (cpu->singlestep_enabled != enabled) {
> +        trace_cpu_change_singlestep_flags(cpu->cpu_index,
> +                                          cpu->singlestep_enabled, enabled);
>           cpu->singlestep_enabled = enabled;
>   
>   #if !defined(CONFIG_USER_ONLY)
> @@ -39,8 +41,6 @@ void cpu_single_step(CPUState *cpu, int enabled)
>               ops->update_guest_debug(cpu);
>           }
>   #endif
> -
> -        trace_breakpoint_singlestep(cpu->cpu_index, enabled);
>       }
>   }
>   
> diff --git a/trace-events b/trace-events
> index faeba6242fa..ea1d2b11a22 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -28,7 +28,7 @@
>   # cpu.c
>   breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
>   breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
> -breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
> +cpu_change_singlestep_flags(int cpu_index, int old_flags, int new_flags) "cpu=%d flags=0x%x -> 0x%x"
>   cpu_exec_start(int cpu_index) "cpu=%d"
>   cpu_exec_end(int cpu_index) "cpu=%d"
>   


