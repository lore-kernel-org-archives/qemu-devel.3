Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC3CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJFs-0007FF-A9; Thu, 18 Jun 2026 16:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJFr-0007F7-8r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:22:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJFo-0000Un-EZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:22:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IIgmPW2558862
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xyp6pwAlOeQrB4xOenV+lka09rPZhRa8esgiIGykv9Y=; b=S7pT2Fn/I62dWCd7
 SFrA74U07GzOIm0MEuDuL5/x0CJGT935BGtHvaokQJPzRd1xqn1X/Z69vQq8bKdZ
 fv9ERsJlcM/odlIwWLp/YB4Fc09do7tZi0mGYn41EYCiLIi1ZO8Ifb99s9SKqkE0
 Ldz/k22B3z5L1cRtLY6qSJC2luStcmAkUgD8lhBRUjygiHahJfUqJC9NUsSVkRSC
 W1JjRzPGynZpWZcIi88ZjqkwsAYGn3PnLXLZ9j4F3PY9125uDUPFIdt2sVqdGK8I
 xZ23teYJ3KzJVyVVUyOJeDN1V6CjMNXOdGU6WYiW4Ux5isNLzZ0vxAOlqDP1mOBX
 gKAG4w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6s8gwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:22:21 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bbdeb06f62so979932e0c.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781814141; x=1782418941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xyp6pwAlOeQrB4xOenV+lka09rPZhRa8esgiIGykv9Y=;
 b=Vwv3kAc54Tze9H514OjkRhKVL1rJvHlyKzKDiOUWZp4nj/PkVK5SROxTjafg4M2PGO
 PuOH8OWKByzdD+/5uYwIv2QsuzIlCpt3zzA3qKVTxQwQnQ/C060AuLQVWdPkS61Joxpt
 3WeL0KlHhVc1o0iU/cFgsG4no++uJrBwveQWuxq7wpnYdvF7AKjzD8CXIGcSquGDaoIr
 +L4swy7tbNG0/97OG3okMXE/t9vDhklyVFr4kbv2BZa8f48Z7u0mIQN9l58Qqt3OZvqA
 6cRhoWfHF0ncdiVonO+OPsRw7iejJV3wv3Goc+sqknnCEGCWhly/ihEoTu6x1K0rN5Vh
 xvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781814141; x=1782418941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xyp6pwAlOeQrB4xOenV+lka09rPZhRa8esgiIGykv9Y=;
 b=j4L+YDsnLbRPOvRAer2aJdSd1WglL+u5Av0Nv7rPI9Lwow9jA1qRNMYsWg+M1MHmeD
 /s5QGhKTpFgl3lr4ANYvssPpRpAZhikA8oO2QDk1j0hbvXtBXRTcjU/9z1AoUot/hxwT
 K8tSMGTTOACC7U2Id0aY4lW8aGDcoQdklD+M4F6YrMX82T2NSWQKKouXTQoVetchrPz4
 emY60XLliZSJsv1o4XACfdqehPdmNiXcugze9kulVipssLiSJnz4MPddW4l8Q9+hYF/f
 cC5irn0uUBPFMsqN5zWYHeDkIeeexOZi6ddVRoMkf3Matd63NI82Jg+SpquDCZ0qbZ3E
 qbhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/koWf6JI0mPw03++GhVfKIxeTjBGFaw3628JI2VtKnnEtZSIJBan/mPmz4q2s9q873HdS9KbxqcIhV@nongnu.org
X-Gm-Message-State: AOJu0YxURYSxD6E3Vw8NzPFXB59IQtU3iOlgv6M/Srjo5jKUk/6V/WdW
 2nWrXKcWGltOHF2jSbz/NP1uVPk9mDJkl0q2ZhNr/OivvCuG00IMFfbrgkIzreQLbQdURi4ZDoO
 sWaWdExwN6Xlp054hgZcIg51epS4GdfN1A0YfgdeGenuzOYpoJj9ZoUmSmg==
X-Gm-Gg: AfdE7ckYGvbDdp5wbkQ1nXh4pLNb/TZY+9I9UWDxne+mNoTb9dhQzgdre8usbvGgeij
 HUomu1QBou8eJEB3YBQ67JNXUA8WuU1GEs5TNNbrVmHRwiI+Yzur3ijO7f4Nm3wZaq6YH2knW+l
 u44L/TwY+3tmgSP9CdugZ3vyP5TmixcLPXpi75QDt/2yAjfNQXdljhMagnW9x6g+Vv4XZRdIEvM
 DchMoxqkQY4htzXG0JBP5/L78fms3pp0mCStC/J0ydPbGmai2VjVhK28s2wLDK9cFnxXKuC2EAf
 DtIbi6FKadQ7BVMY+f7lYAInqRdFeE25HUsYuDiE+Jt3yKdyaaQUM1yXSKBvvgULI5mXu0XeRJG
 J1jW76ymO7zMFqM2SOS/MBc6qx432n19fMxt+gHKn3lfCmQaKyDO/jBgyvAQhHg==
X-Received: by 2002:a05:6122:922:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-5bbebbcf5f0mr218184e0c.4.1781814140885; 
 Thu, 18 Jun 2026 13:22:20 -0700 (PDT)
X-Received: by 2002:a05:6122:922:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-5bbebbcf5f0mr218173e0c.4.1781814140415; 
 Thu, 18 Jun 2026 13:22:20 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240084928sm12251825e9.15.2026.06.18.13.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:22:19 -0700 (PDT)
Message-ID: <768aa959-290f-46c8-aa6f-e724592831c9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] common-user: Implement read_self_maps for FreeBSD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618195520.589907-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0v3dyH8fmESn_0Cqr7pW53PwWAddkofS
X-Proofpoint-ORIG-GUID: 0v3dyH8fmESn_0Cqr7pW53PwWAddkofS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfX91cO+9tkwTPm
 L3HZ2xm9+z318iIdNxmySeiSIumDWZSqn7Yjgay/wrTu7nxLNkNqbHc4Wi8D0fqJzsc0SnxvXQe
 dTPerb7rVNOjJ5MWLdTu97pZH+8Qg+JMoYKC2RZFxZUrHqg41TGVLrPx1JwRfPfXYLsy41TsmB7
 9GgZv8Qv21egr0aQZZ5qMGqFnukOWFkx0qbMRP4gS0zXgj9VynKcaxe/9u2Q0WKmXeYF5urKZc6
 VOVwTqiPG2Y5tQ1atjiv35RHyLML7xdA11EWHKKZMypovX0xOwFsZhU+keGy3YBYYSZkJAw29es
 YyjfN+sjgtn9/GqYMs62ZKb0iV7CpFjz6IelxgJg/yRCDs5InBnzMP8ea6k+3t5UPffcVUSuBw8
 foV6Wf+N5HaHwa7tUhd8CHYVR6FFNfhBJbOt9OzV3XrmW/ndnl0gphYNk/zSb7iL2tdHM5Cc9Jx
 AjfMMdRHPz4BZfINJ+A==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a34537d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7Qk2ozbKAAAA:8 a=KKAkSRfTAAAA:8 a=4ab70ZgC3rs_dxIxScAA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=1lyxoWkJIXJV6VJUPhuM:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NiBTYWx0ZWRfXypGkU1gAkQdV
 6JH43gAxdQgsGpan81E6bymALZsk7rzQmwZzcC0Dc9Mbn0C4+MIFFyG+iJWPNEAtkpC0UZryLHF
 93vANy3BRJbHdCPbeUh6yoUgJIiAe30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 18/6/26 21:55, Richard Henderson wrote:
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
>   common-user/meson.build |  5 +++++
>   2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/common-user/selfmap.c b/common-user/selfmap.c
> index a1b88dee66..151d066801 100644
> --- a/common-user/selfmap.c
> +++ b/common-user/selfmap.c
> @@ -9,6 +9,10 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
>   #include "user/selfmap.h"
> +#ifdef __FreeBSD__
> +#include <libutil.h>

Out of curiosity, what is libutil for?

> +#include <sys/user.h>
> +#endif
>   
>   IntervalTreeRoot *read_self_maps(void)
>   {
> @@ -80,9 +84,44 @@ IntervalTreeRoot *read_self_maps(void)
>       g_strfreev(lines);
>       g_free(maps);
>   
> +    return root;
> +#elif defined(__FreeBSD__)
> +    int n = 0;
> +    struct kinfo_vmentry *entries = kinfo_getvmmap(getpid(), &n);
> +    IntervalTreeRoot *root;
> +
> +    if (!entries) {
> +        return NULL;
> +    }
> +    root = g_new0(IntervalTreeRoot, 1);
> +
> +    for (int i = 0; i < n; ++i) {
> +        struct kinfo_vmentry *k = &entries[i];
> +        size_t path_len = strnlen(k->kve_path, sizeof(k->kve_path)) + 1;
> +        MapInfo *e = g_malloc0(sizeof(*e) + path_len);
> +
> +        e->itree.start = k->kve_start;
> +        e->itree.last = k->kve_end - 1;
> +
> +        /* ??? The rest of these fields are only used in linux-user. */
> +        e->dev = k->kve_vn_fsid_freebsd11;
> +        e->inode = k->kve_vn_fileid;
> +        e->offset = k->kve_offset;
> +        e->is_read = k->kve_protection & KVME_PROT_READ;
> +        e->is_write = k->kve_protection & KVME_PROT_WRITE;
> +        e->is_exec = k->kve_protection & KVME_PROT_EXEC;
> +        e->is_priv = k->kve_flags & KVME_FLAG_COW;
> +        if (path_len) {
> +            e->path = memcpy(e + 1, k->kve_path, path_len);
> +        }
> +
> +        interval_tree_insert(&e->itree, root);
> +    }
> +
> +    free(entries);
>       return root;
>   #else
> -    return NULL;
> +# error
>   #endif
>   }
>   
> diff --git a/common-user/meson.build b/common-user/meson.build
> index 831a7273fb..5e041de55e 100644
> --- a/common-user/meson.build
> +++ b/common-user/meson.build
> @@ -10,3 +10,8 @@ user_ss.add(files(
>     'safe-syscall-error.c',
>     'selfmap.c',
>   ))
> +
> +if host_os == 'freebsd'
> +  libutil = cc.find_library('util', required: true)
> +  user_ss.add(libutil)
> +endif


