Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0457C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wedyU-0002LC-PX; Tue, 30 Jun 2026 15:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wedyJ-0002Kk-M0
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:18:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wedyH-0008VH-4h
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 15:18:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDpl22947914
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 19:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 or3XV+xQJNaj58B/y7d8yNxH5i7dSkKWHEAVpdyNoFU=; b=PcE6HZRlOAa7R+aC
 RcOLVvQPDOS5rPGfamPmvuloe3syM7rLaj5QCTQZi0/zhaZdu936afTZrWu0L3Cl
 wkLD6vMVHTDRL+GkcvaYwd/3zwdy++0O0pbRwY255+617ljwNF+cxVffOy6UMhhK
 hdidN8tavYovuFQE+muI4gNPyJBwjJOnZx+Cd019FLH2iWAPE3/Ee6fYXPaQrXKc
 fXNVY+7U8PfDcNguHXWH+Tbe8/xXIy3ETk7XQlO7xMzFVJi8ftXBuKLjEOg82TrJ
 LRCa5vOfn4nm3WtWIrL6iFDJof19tbAuwafVEfcNOMzN28LBbmcZzKdxtv8Wv0p4
 gxPV3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0as10w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 19:18:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so150436eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782847089; x=1783451889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=or3XV+xQJNaj58B/y7d8yNxH5i7dSkKWHEAVpdyNoFU=;
 b=GMBAbEByLec2kY5jv7AxY+kH+z7ZL7MMv1rtvucum+iSPyJAKjhKEjQmPxuEDJQ06v
 CXsheWoUH9wdnaU2YEsoPeHJ6W+SVkvXUuRyrA58Rg3JdFHt3vMI8uhqDTJEhL0QxcI8
 7NT7AB9CuMF6rd8pfmztZyBXIotwIxiumI5bxUrIMp6KBVghPQuY9Ks44DAbE3PegBdC
 KXDIk6KY7lKmZ2237WSb6y22vH3LO3IRMdASeSuVEq4FnF2aTAIGwzI4i6gVScK65cET
 1pLnKmcnqFuC9kG6L9G5ZXLb4I77YUiSmunQFkJqX1ZNZhwygV4exywynxYw3GNuFphb
 zqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782847089; x=1783451889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=or3XV+xQJNaj58B/y7d8yNxH5i7dSkKWHEAVpdyNoFU=;
 b=ArPUVy/Yw7UgIE8jQRDMkyWfl2ZngXnXU8zNMB+Xn5MEdItM5t1gpJdSsqdX2GFFuu
 LCZqZtosJIRuuDSJl1IlktrirWDX0+C7wEu8jT+jGbbBn1pLYXakfh0gczMMvjkk6XZd
 3F15nm4zTyYYGEu91WDKehKtm2puEi8kcnNkeEfUe/3EwrWWD2A0SGAmHfehp+j1VJ+/
 1M9Zfxfy8DhGWO1ud1Aki6o+lyy1JTNwNR0D4lXDQqJ43iepN3kHB/UqtVHHO1Vv37Lm
 gneCAanA67f2/Pw9N+ewYJIqkTXn8lFaqskqFHrlaMIfBNG66pl6FZ5jeU8aYrnz9KcD
 +owg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcIbu97oKEHojC4rycgqZJc7zHfq8nCFOAqBXL/fUxe1hIK2msvtpuvCCTmKiU0e3SaDP1b9Jh95N/@nongnu.org
X-Gm-Message-State: AOJu0Yz/6wrLRJzcLJA7qctscpSk1PJTm+N7rmG+w0KC3GggVh5bRMnV
 xO7tme2H5H3jnwPAXXsDi5A3Dt3F7K1bbtThf2BD1O/SZnfKMozr3zWxporsF2L0/Wu6WasjxpX
 ePIK/toNzfMG31hd4LRXO6i+L9eD7VEnjhz962grLFRNm13NAy8yM0NaGvw==
X-Gm-Gg: AfdE7cksHm+FxtlBSlCSbSY1BOya14CNj6YJIdY8pgXHVMZprzQ1OCDFCe66mdrN8EG
 Bf3+rdG6yohl/i3eT27WSDau8UVs7x34hKWVI0S1Moj3AeWbQMYNYgZPlbHDI6AvpZMx6TOMF83
 MjlWMolH69ZikItAfGRywWzxm/fmxistzjHfG50f8549q8yHS/gFyLDeshB+9oHtsDescb2PTB4
 fYp4C4kZUermnSy6rIIWpJr08RJ7RHf9hLntG31ULu3F0ZW2fV6Mqs5Dchem/TQHhTFJg5PIDRO
 85UHuYxrCeMtSLpl9Cs2//YnMOPiMgiAXtIAvWPT7CZp9x5Vmj0YU4Wk68iedZkSVVDER7KyORD
 fpxw6TPW23/sZFgb3x7bfRxfNwZuzoKuv20LAsFGBC1ZtObnJEnmhSu0LSJNeazbdCwIu9ljzi0
 zmWhE=
X-Received: by 2002:a05:7300:7312:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-30ef0821d0dmr1576610eec.2.1782847089044; 
 Tue, 30 Jun 2026 12:18:09 -0700 (PDT)
X-Received: by 2002:a05:7300:7312:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-30ef0821d0dmr1576569eec.2.1782847088340; 
 Tue, 30 Jun 2026 12:18:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3170ee7sm10033624eec.14.2026.06.30.12.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 12:18:07 -0700 (PDT)
Message-ID: <4b314e75-1eef-4fc8-8880-b4574a7592a9@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 12:18:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] contrib/plugins: add a minimal dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <20260629160217.1637276-1-functioner@sjtu.edu.cn>
 <20260629160217.1637276-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260629160217.1637276-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a441672 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Lx1EvxgrAAAA:8 a=ShkMcha_sgAh9ySUZG8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-ORIG-GUID: zA1irlxYRuMvRufxK0SXPDohcxztqJya
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX2fbAkuOhBD0D
 jB0pGPSYJ/wxGhcS2pFGhmpuk3TYcjGFeu3VG1Uy8S6qt0ywMIwmqALzcpmcL4VPRwnA8Vt7hQX
 dXSC0VFhckhfOozaUA8jlblfBret/B8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4NiBTYWx0ZWRfX7R3QLTjTmrjb
 sRfelz6CQxnWRsuQYKj1DwYmnwtAm9morabgkZ9q2duHiUxdQo3q6nwKL8juyZJjBOUYNhbMeSg
 1y4fxpwphogaFA5Bt4e+ikxBQkfyRG7QX2tyW+giRu7bhgE8G2aJZ6dHrRfpNb48crJw/FaaSjw
 6zU5BFkShwdBPDhVqyP55QEI9Z8i5FDZMj1y2AgNk9U5QhYsD10NQSENMK7dIQuVsbj3jp109b1
 9X0FlBezjiFn8SGDaaHrSNQjSrucvBkT+o1vj0gBR8uXXzikmkzTU8brmYDbAQkYMbNYPo5SKsz
 bYTGIPzqQZ1bCkw1B2L6MYITIoRF35MR6cOGcw6iQWuEvfnAJCfYJf35KlEQiyoAog6XcXjUkh2
 ZybMOocMEzRcUWq+lbuNEIB+UYGfgNqQtH4KZi6B4Y2nGFHPsTvq6J6csjGpUxeTAsClNcpBE5B
 5gvvsMasEZoEcPSMZ4g==
X-Proofpoint-GUID: zA1irlxYRuMvRufxK0SXPDohcxztqJya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300186
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

On 6/29/2026 9:02 AM, Ziyang Zhang wrote:
> Add a minimal dlcall plugin that lets the guest invoke host functions
> through magic system calls. The plugin registers a vCPU syscall filter
> callback that intercepts a reserved syscall number and dispatches a set
> of pass-through operations: querying host attributes, loading and freeing
> shared libraries, resolving symbols, retrieving the last library error,
> and invoking a host function through a common interface.
> 
> The magic syscall number defaults to 4096 and can be overridden at load
> time with the "syscall_num=N" argument; values low enough to clash with a
> real syscall are rejected.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  contrib/plugins/dlcall.c    | 238 ++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |   5 +
>  2 files changed, 243 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 
> diff --git a/contrib/plugins/dlcall.c b/contrib/plugins/dlcall.c
> new file mode 100644
> index 0000000000..3a8f47cdf8
> --- /dev/null
> +++ b/contrib/plugins/dlcall.c
> @@ -0,0 +1,238 @@
> +/*
> + * Copyright (C) 2026, Ziyang Zhang <functioner@sjtu.edu.cn>
> + *
> + * dlcall plugin: lets a linux-user guest invoke host functions by issuing a
> + * magic system call. The guest can ask QEMU to dlopen() a host shared
> + * library, dlsym() a symbol, and call it with guest-supplied arguments.
> + *
> + * WARNING: trusted guests only. The guest can load arbitrary host libraries
> + * and execute arbitrary host code with arbitrary arguments, i.e. full code
> + * execution in the QEMU host process. It is NOT a sandbox and provides no
> + * isolation; only load it for guests you fully trust.
> + *
> + * WARNING: requires guest_base == 0, which is qemu-user's default. Pointer
> + * operands are dereferenced as host addresses directly, and the invoked host
> + * functions dereference guest pointers with no address translation, so guest
> + * and host must share a single address space. A non-zero guest_base (e.g. set
> + * via -B/-R) would make every pointer off by guest_base and hit unrelated
> + * host memory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <glib.h>
> +#include <dlfcn.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +/*
> + * The magic system call number for dlcall.
> + *
> + * It defaults to DLCALL_SYSCALL_DEFAULT and can be overridden at load time
> + * with the "syscall_num=N" argument. To avoid hijacking a real syscall the
> + * guest might issue, N must be at least DLCALL_SYSCALL_MIN: every Linux ABI
> + * keeps its syscall numbers well below this; numbers from here up are free.
> + */
> +enum {
> +    DLCALL_SYSCALL_DEFAULT = 4096,
> +    DLCALL_SYSCALL_MIN = 4096,
> +};
> +
> +static int64_t dlcall_syscall_num = DLCALL_SYSCALL_DEFAULT;
> +
> +/*
> + * dlcall calling convention.
> + *
> + * The guest issues the magic system call (dlcall_syscall_num). The first
> + * argument (a1) is one of the call IDs below; the remaining arguments (a2, a3,
> + * a4, ...) are that ID's operands. All pointer operands are guest virtual
> + * addresses that the plugin dereferences as host addresses directly (see the
> + * guest_base requirement above). Results are written back through
> + * caller-provided "out" pointers rather than returned in the syscall value.
> + *
> + * The syscall return value (*sysret) only reports dispatch status: 0 on a
> + * recognised ID, -EINVAL for an unknown one. The actual success/failure of an
> + * operation (e.g. a NULL handle from dlopen) is delivered through its out
> + * pointer, exactly like the underlying libdl call.
> + *
> + * Operands per ID:
> + *
> + *   DLCALL_ID_GET_HOST_ATTRIBUTE
> + *     a2  const char *key        in:  attribute name to query
> + *     a3  const char **attr_ptr  out: matching value, or NULL if unknown
> + *
> + *   DLCALL_ID_LOAD_LIBRARY                            (wraps dlopen)
> + *     a2  const char *path       in:  library path
> + *     a3  int flags              in:  dlopen() flags (e.g. RTLD_NOW)
> + *     a4  void **handle_ptr      out: library handle, or NULL on failure
> + *
> + *   DLCALL_ID_GET_PROC_ADDRESS                        (wraps dlsym)
> + *     a2  void *handle           in:  library handle
> + *     a3  const char *name       in:  symbol name
> + *     a4  void **entry_ptr       out: symbol address, or NULL if not found
> + *
> + *   DLCALL_ID_FREE_LIBRARY                            (wraps dlclose)
> + *     a2  void *handle           in:  library handle
> + *     a3  int *ret_ptr           out: dlclose() return value (0 on success)
> + *
> + *   DLCALL_ID_GET_LIBRARY_ERROR                       (wraps dlerror)
> + *     a2  const char **error_ptr out: last libdl error string, or NULL
> + *
> + *   DLCALL_ID_INVOKE_PROC                             (calls the symbol)
> + *     a2  void *proc             in:  function pointer, signature
> + *                                     void (*)(void *arg1, void *arg2)
> + *     a3  void *arg1             in:  first argument forwarded to proc
> + *     a4  void *arg2             in:  second argument forwarded to proc
> + */
> +enum DlcallID {
> +    DLCALL_ID_GET_HOST_ATTRIBUTE,
> +    DLCALL_ID_LOAD_LIBRARY,
> +    DLCALL_ID_GET_PROC_ADDRESS,
> +    DLCALL_ID_FREE_LIBRARY,
> +    DLCALL_ID_GET_LIBRARY_ERROR,
> +    DLCALL_ID_INVOKE_PROC,
> +};
> +
> +static inline const char *query_host_attribute(const char *key)
> +{
> +    if (strcmp(key, "emu") == 0) {
> +        return "qemu";
> +    }
> +    return NULL;
> +}
> +
> +static inline void invoke_proc(void *proc, void *arg1, void *arg2)
> +{
> +    typedef void (*Func)(void * /*arg1*/, void * /*arg2*/);
> +    Func func = (Func) proc;
> +    func(arg1, arg2);
> +}
> +
> +static bool vcpu_syscall_filter(unsigned int vcpu_index,
> +                                int64_t num, uint64_t a1, uint64_t a2,
> +                                uint64_t a3, uint64_t a4, uint64_t a5,
> +                                uint64_t a6, uint64_t a7, uint64_t a8,
> +                                int64_t *sysret, void *userdata)
> +{
> +    if (num == dlcall_syscall_num) {
> +        switch (a1) {
> +        /* Query host attribute by a reserved key. */
> +        case DLCALL_ID_GET_HOST_ATTRIBUTE: {
> +            const char *key = (const char *) a2;
> +            const char **attr_ptr = (const char **) a3;
> +            assert(attr_ptr);
> +            *attr_ptr = query_host_attribute(key);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Load a shared library. */
> +        case DLCALL_ID_LOAD_LIBRARY: {
> +            const char *path = (const char *) a2;
> +            int flags = (int) a3;
> +            void **handle_ptr = (void **) a4;
> +            assert(handle_ptr);
> +            *handle_ptr = dlopen(path, flags);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Get the address of a function in a shared library. */
> +        case DLCALL_ID_GET_PROC_ADDRESS: {
> +            void *handle = (void *) a2;
> +            const char *name = (const char *) a3;
> +            void **entry_ptr = (void **) a4;
> +            assert(entry_ptr);
> +            *entry_ptr = dlsym(handle, name);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Free a shared library. */
> +        case DLCALL_ID_FREE_LIBRARY: {
> +            void *handle = (void *) a2;
> +            int *ret_ptr = (int *) a3;
> +            *ret_ptr = dlclose(handle);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Get the last error message for a library event. */
> +        case DLCALL_ID_GET_LIBRARY_ERROR: {
> +            const char **error_ptr = (const char **) a2;
> +            *error_ptr = dlerror();
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Invoke a function of a common interface. */
> +        case DLCALL_ID_INVOKE_PROC: {
> +            void *proc = (void *) a2;
> +            void *arg1 = (void *) a3;
> +            void *arg2 = (void *) a4;
> +            assert(proc);
> +            invoke_proc(proc, arg1, arg2);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        default:
> +            *sysret = -EINVAL;
> +            break;
> +        }
> +        return true;
> +    }
> +    return false;
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    if (info->system_emulation) {
> +        fprintf(stderr, "plugin dlcall: only useful for user emulation\n");
> +        return -1;
> +    }
> +
> +    for (int i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "syscall_num") == 0) {
> +            const char *val = tokens[1];
> +            char *endptr = NULL;
> +            guint64 num;
> +            if (!val || *val == '\0') {
> +                fprintf(stderr,
> +                        "plugin dlcall: missing value for syscall_num\n");
> +                return -1;
> +            }
> +            num = g_ascii_strtoull(val, &endptr, 0);
> +            if (*endptr != '\0' || g_strrstr(val, "-") != NULL) {
> +                fprintf(stderr,
> +                        "plugin dlcall: invalid syscall_num '%s'\n", val);
> +                return -1;
> +            }
> +            if (num < DLCALL_SYSCALL_MIN || num > G_MAXINT64) {
> +                fprintf(stderr,
> +                        "plugin dlcall: syscall_num %s is out of range; "
> +                        "it must be >= %d to avoid clashing with a real "
> +                        "syscall\n", val, DLCALL_SYSCALL_MIN);
> +                return -1;
> +            }
> +            dlcall_syscall_num = (int64_t) num;
> +        } else {
> +            fprintf(stderr, "plugin dlcall: unknown option '%s'\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter, NULL);
> +
> +    return 0;
> +}
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 099319e7a1..e7fc4d6d8f 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -19,6 +19,11 @@ if host_os != 'windows'
>    contrib_plugins += 'lockstep.c'
>  endif
>  
> +if host_os == 'linux'
> +  # dlcall passes guest calls through to host libraries; linux-user only
> +  contrib_plugins += 'dlcall.c'
> +endif
> +
>  if 'cpp' in all_languages
>    contrib_plugins += 'cpp.cpp'
>  endif

Plugin can be renamed to Lorelei.
Also, some (QEMU) documentation should be added about how to use it.
(see docs/about/emulation.rst)
Ideally, with a minimal example of how to use Lorelei, without all the
internal details.

Overall, it's all good, there are just some details about Lorelei itself
that we need to take care of. See my answer on the cover letter.

Regards,
Pierrick

