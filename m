Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545C606A32D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=he6UI7uT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Br0NUMnQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqXg-0008PI-3s; Mon, 19 Oct 2026 12:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqXc-0008OW-Uu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:48:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIqXZ-0003yn-O3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:48:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPFqL2589773
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZSl/HJWWEMDnimVxwEoRJAvfwzxAdjS6yp7sMT/PWxA=; b=he6UI7uTTy+GGqEJ
 OxDEiWBrZH7NrOYDxkyGCX1HCso3yAgzvO7ZrKiEiRhA2JV+E8rXQlWzgYP+oWSY
 kdzU9+lWrGPvRFzHoX314JDbomAKDEyXoHqk1CnmGn0qqLu7dliIY3bUDwHCe/N/
 9hck/0IBQEXDGggm+28XgVQb3DcVDk/yI/15HfN7dMJmswHJiBTxQ8tJe/TJsOaf
 ZfJl6AL3KNxC0sAzB5z7848CkngqDQ2sc+swWc4AluFS1xRU6t4vlNfEKhcVkRKQ
 gl0+d01Vyde6sgtwV2QNoSfxtfjPYpOEyJvQqkHOm90cla13C4gUOtUk/QPyfUsz
 hRkqQg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n298v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 16:48:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so6295030eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792428525; x=1793033325; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZSl/HJWWEMDnimVxwEoRJAvfwzxAdjS6yp7sMT/PWxA=;
 b=Br0NUMnQfGy42CFBW/ceE1WbxDAENA61ffmK75ukFdYPez36+siS0ymOWwPUpPqp6G
 bteDPT7jJ1l5v2IfFXs51UDUJPq8H3X5agBu/OcFmn2/yqwa/sSAbGDHXcY9AB2yY9pR
 mxOsaBucq2GRToEROON1B7xjZPk7a7Dw+7o1tt8j1scIlXXZSUEPowL4A/5q4ZjxujHO
 WNvsJYYXFkAE4rxaRec4ydvtEOCKv+qQA6nmvFlsihZyl1dUaqF8bIz+QoGKSx6LoMg9
 aDimzDPwj8lGYHPphm9A/6ofyLvzqDrOYNyil1YaaHUX6tPKBNV8GwqUjFxd/484yQ/8
 Lu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792428525; x=1793033325;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSl/HJWWEMDnimVxwEoRJAvfwzxAdjS6yp7sMT/PWxA=;
 b=WPeoDWLqGR+DLKyRfF6glHcKQICnLrP6h4AK3UUatdPyY6LRmADHRyOfR4+6tCxZDT
 Td8nENxeRL7YDUK0pllkTsr2FobsW9elSNKqzRpMYwyOpFhCYAvVc/i5vLJhE0OPyf6+
 VKea/qrwCf5caZvodv0qrmnK/0wlHiw1vtpE0B94nwJqK5+09et2JSHgQnXVGYJzQguN
 XLN5kCoHW4N5zwJbtmpGHVig9M/SYcZNNL330dcvKsqI+Eb/ndc4Qbkq6a8zxv18wtR6
 0A+WEfhVn869NDi/Hh2pUgztAXvBvIyutK/f/X4cWqD8n3Sefc3Qt0/aonG1tpmGXNAo
 X85g==
X-Gm-Message-State: AFq9FYJWMjVBYfpOxYuzPCkRGsPnUK//5FRrjHbxXcBze4+mUnTSkbdf
 NKRQaH9qG4qpf36TeLzTC9q0AqRuoaDUnXMUiIRORYnpj5KOYlJ932Xh+0u91NuFn9+iUOgACPr
 AGJ4IK9hfRq/MdNTcbz9d4b4ZVe3fxzPozz2pMjazc4yO52AlQzmloXkbuA==
X-Gm-Gg: AYBFou3yotLv1ZfnzwcHr5n9TniMt4Q2bk2bwvw9Vj5zjCNwRO0hNgU977SpQxsGglL
 o7ZVSIc+7kLzUuodfw9x6UUab/WYJJX6jHYnBcsiRxZWQyFtpBi1q6TY6xiHip7GoSI09mFGgKt
 kZuxV0nerdCzTwh+aBkQCTxePC70pK7x3SM4QVNerJNr5eVXORIwBMLn85ErAnAiplFs9yrqUDP
 CbMjrqYM0AV/+1lTdpplUhlB2C2G7glD7ryAog8OJ2EJrFfz4c6XTpBC/2YGjw2ChXQhHIuOqru
 Va/GXJpYOhyfdb0HgntFj16TGMN8oJ+LCYKxWz04DdwOksClNDPG08HdsKmsRPKF+IxzamBb/PZ
 VL+xRQVkVKGsaKBnqdUXlv7uZlok1cS1Sm4GYLKjKYpXJjHHy372rRYCfReu07CNvmoFgwA==
X-Received: by 2002:a05:7300:768c:b0:35e:a117:8fd8 with SMTP id
 5a478bee46e88-361a18603d7mr17388665eec.17.1792428524438; 
 Mon, 19 Oct 2026 09:48:44 -0700 (PDT)
X-Received: by 2002:a05:7300:768c:b0:35e:a117:8fd8 with SMTP id
 5a478bee46e88-361a18603d7mr17388598eec.17.1792428523659; 
 Mon, 19 Oct 2026 09:48:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm56224958eec.28.2026.10.19.09.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 09:48:43 -0700 (PDT)
Message-ID: <f6583ee1-2f4c-4e07-8552-6c6c780370d8@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:48:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hw/i386: ELF endianness fixes
To: Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-2-farman@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019151233.230172-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfXzbP2yb+eLVj0
 P1C0xy9RcPcAu4qDh9oiwT0zrybl4um3a7vQr4GMeHqX87r8S8wuGFEJKZHD+KkegqnPc8l7Byu
 3Pa8MyGGv/e5EGf9U0ZvHLBqRejxrmg=
X-Proofpoint-ORIG-GUID: v09REuevn2CCAS6OStWJ7REwQ9p1SS28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NiBTYWx0ZWRfX6OLCESX/zXVw
 MC6tKstOBl1nJMVkRwZdcvmItyeiNlUMR+ytdvYDW+EvLUl7tKVTF1be9YX60/wHPjeI1LlNBvI
 +ijHNDSKRI3134bUQ6ix3/dLpEGttM1u2QH7ui1E80nV1EZ915DBU067NMEb0VdP2UIyq9ePqdu
 jzl+Qpxi6iE9KAp+8LNKRidDOlu7TuYcRy1WMmwQKLPlw2iZpKHJ/nhyRAnW8VsUQiyhOPwZJAO
 JMLfh99SW1lBfwNRS340e9ggGIlvb/pUupFb5eagV9E+GxEWdTpK9L+YPOzQ3s08W9kPl6NDmz3
 sFxjvFsYvPqW+VaKo42ZcGId0pr+z905ioSuALLx5KJwnxwcJ2TGnsjw+83cvCtQK1OzLg6xfGO
 20HgF7m8sMTHxOhOKh/K0bBQtY87crfTZawr59AyLbfC+BHTTFV4SZlqDB7/j8eD/gaDVS16Xnt
 FRdu+E03vn4CN2geuLA==
X-Proofpoint-GUID: v09REuevn2CCAS6OStWJ7REwQ9p1SS28
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad649ed cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=bP5XXabYqgtyESp_ZC0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 8:12 AM, Eric Farman wrote:
> Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails due
> to problems reading/parsing the ELF data:
> 
>   qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
> 
> There already exists logic in include/hw/elf_ops.h.inc to handle byte-swaps
> where necessary, but it does not perform this logic for ELF notes itself.
> 
> Fixing that improves matters, but yields other errors: most of the tests
> timeout while some generate confusing assertions. Both appear to be related
> to the data addresses in those notes, which are incorrect when running on a
> big-endian host.
> 
> Adding tswap wrappers, which will conditionally swap if the host and target
> endianness don't match, fixes that such that check-tcg-x86_64 runs cleanly
> on an s390 host.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/i386/x86-common.c     |  6 ++++--
>  include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index fa18bf1aece..dcd4fa8eb79 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -45,6 +45,8 @@
>  #include "kvm/kvm_i386.h"
>  #include "kvm/tdx.h"
>  
> +#include "exec/tswap.h"
> +
>  #ifdef CONFIG_XEN_EMU
>  #include "hw/xen/xen.h"
>  #include "hw/i386/kvm/xen_evtchn.h"
> @@ -573,7 +575,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
>              ((void *)nhdr64) + nhdr_size64 +
>              QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
>  
> -        pvh_start_addr = *elf_note_data_addr;
> +        pvh_start_addr = tswap64(*elf_note_data_addr);
>      } else {
>          struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
>          uint32_t nhdr_size32 = sizeof(struct elf32_note);
> @@ -584,7 +586,7 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
>              ((void *)nhdr32) + nhdr_size32 +
>              QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
>  
> -        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
> +        pvh_start_addr = tswap32(*(uint32_t *)elf_note_data_addr);
>      }
>  
>      return pvh_start_addr;
> diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
> index 044e72de2a2..b4fc0b146f0 100644
> --- a/include/hw/elf_ops.h.inc
> +++ b/include/hw/elf_ops.h.inc
> @@ -56,6 +56,13 @@ static void glue(bswap_rela, SZ)(struct elf_rela *rela)
>      bswapSZs((elf_word *)&rela->r_addend);
>  }
>  
> +static void glue(bswap_note, SZ)(struct elf_note *note)
> +{
> +    bswap32s(&note->n_namesz);
> +    bswap32s(&note->n_descsz);
> +    bswap32s(&note->n_type);
> +}
> +
>  static struct elf_shdr *glue(find_section, SZ)(struct elf_shdr *shdr_table,
>                                                 int n, int type)
>  {
> @@ -275,7 +282,8 @@ fail:
>  static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
>                                                      elf_word note_size,
>                                                      elf_word phdr_align,
> -                                                    elf_word elf_note_type)
> +                                                    elf_word elf_note_type,
> +                                                    int must_swab)
>  {
>      elf_word nhdr_size = sizeof(struct elf_note);
>      elf_word elf_note_entry_offset = 0;
> @@ -287,6 +295,10 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
>          return NULL;
>      }
>  
> +    if (must_swab) {
> +        glue(bswap_note, SZ)(nhdr);
> +    }
> +
>      note_type = nhdr->n_type;
>      while (note_type != elf_note_type) {
>          nhdr_namesz = nhdr->n_namesz;
> @@ -306,6 +318,9 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
>  
>          /* skip to the next ELF Note entry */
>          nhdr = (void *)nhdr + elf_note_entry_offset;
> +        if (must_swab) {
> +            glue(bswap_note, SZ)(nhdr);
> +        }
>          note_type = nhdr->n_type;
>      }
>  
> @@ -608,7 +623,8 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>              nhdr = (struct elf_note *)data;
>              assert(translate_opaque != NULL);
>              nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
> -                                               *(uint64_t *)translate_opaque);
> +                                               *(uint64_t *)translate_opaque,
> +                                               must_swab);
>              if (nhdr != NULL) {
>                  elf_note_fn((void *)nhdr, (void *)&ph->p_align, SZ == 64);
>              }

s/must_swab/must_swap?

For the rest,
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

