Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8985CCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 07:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsHzO-0004DX-9J; Thu, 04 Apr 2024 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsHzL-0004DF-94
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 03:58:23 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsHzJ-0002Yp-0A
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 03:58:23 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516c116f480so779447e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712217499; x=1712822299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29kHG75viy4/HEATAp26rY5d6bTq4Rxl5UIQ3wcYGDQ=;
 b=o9WgXDOu6SWBFsCpOxtvxwnwP1kNj7g5PCalFY6T16fwcGU4TpriyZVbQpmpsjMvZU
 ws3y2XvGzY1R8+IMY3+ApuxpCsy00emuTPS3bg7NN1bKKK9aRaTo2cA+UOAgSq4tVncj
 Sxq32f7ZNDbvF9jRNHIAhXd3jRGVjF5jkS8sLTcTlNZL0FDYRJx7ET34QGW9n7vzIVoS
 FDxD5VijRf0ulO2RduUVsjrgBfP2sMrDbXcBVTt4VP3u1m3czOHaL5ow0ktIBIWPkXte
 RBdBkkVQFW6p8buFIaoHQmjuSZV3jVZMbQv18OcbKvC7w0WuiKebhEkBKBim3X/JhA1Y
 xC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712217499; x=1712822299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29kHG75viy4/HEATAp26rY5d6bTq4Rxl5UIQ3wcYGDQ=;
 b=KpTCJQuievCuCW+ETnnEok7n6krnhF8xm3ZIRNFWqHK9VexDehFM21SBGFFB/Mi3Hg
 s3mvw58rPVD2cFJPBK1A/suISWhn5UN8NW+EWxjptFwFrzEhGIWKog4OEUuEHxJ2GGfQ
 oIZodpphfHRr0rP15uMI68XzQAm9PLwqoqYGiJgqZ1zVAr5r9g+tV8KZITTGQYokB3Ep
 gMfriMQCRZ8+hgGfmRToRaHf3QOEyLyNnQtk4dg7Bh9uCHAK1uT540Ua5bAhB1UCYkoK
 cPWgiufoE3Q/wquQn4LqXGVr8U5VeQ5otT56KTJiBD1hugBw3NeaAB0C1qNu9oH6/f9h
 QckQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTC6ms38HX//RKWWzd/Q3V7cwZ7LqAz44uoaa6mEdsG4W0jm5V9Fbhn3l8Q20M3t5gUqpW9JoH4fxeEYs6HQ160qiQyoQ=
X-Gm-Message-State: AOJu0YwG0LFn4rxdmbEiq400Fk5DEAHpq4udhmIjzkS56Q/8X6vZSJDG
 6uqN+Fkrh9VWeyUF0IlrJspgkFybleui/3znNL+GM7OgUJmNzy1n0iAdoJDjYrI=
X-Google-Smtp-Source: AGHT+IGKIdDHdzDs+TjZdAyHsh3u8/xmGYjl2flBvrE0cVjWngaptD/i8A0nl7974RT+b27UM5WrvA==
X-Received: by 2002:ac2:46fc:0:b0:516:a517:f26d with SMTP id
 q28-20020ac246fc000000b00516a517f26dmr1059938lfo.9.1712217498729; 
 Thu, 04 Apr 2024 00:58:18 -0700 (PDT)
Received: from [192.168.200.175] ([81.185.165.143])
 by smtp.gmail.com with ESMTPSA id
 fl13-20020a05600c0b8d00b004162ba5b46fsm289624wmb.42.2024.04.04.00.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 00:58:18 -0700 (PDT)
Message-ID: <905678ae-09cd-4e37-8dc1-5b5e5314d0ea@linaro.org>
Date: Thu, 4 Apr 2024 09:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] backends/igvm: Implement parsing and processing
 of IGVM files
To: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?J=C3=B6rg_Roedel?=
 <jroedel@suse.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <9e4268647c2b3dc7fcc59d795575622c4f35a413.1712141833.git.roy.hopkins@suse.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9e4268647c2b3dc7fcc59d795575622c4f35a413.1712141833.git.roy.hopkins@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Roy,

On 3/4/24 13:11, Roy Hopkins wrote:
> This commit adds an implementation of an IGVM loader which parses the
> file specified as a pararameter to ConfidentialGuestSupport and provides
> a function that uses the interface in the same object to configure and
> populate guest memory based on the contents of the file.
> 
> The IGVM file is parsed when a filename is provided but the code to
> process the IGVM file is not yet hooked into target systems. This will
> follow in a later commit.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>   backends/confidential-guest-support.c     |   4 +
>   backends/igvm.c                           | 745 ++++++++++++++++++++++
>   backends/meson.build                      |   1 +
>   include/exec/confidential-guest-support.h |   5 +
>   include/exec/igvm.h                       |  36 ++
>   5 files changed, 791 insertions(+)
>   create mode 100644 backends/igvm.c
>   create mode 100644 include/exec/igvm.h

Consider enabling scripts/git.orderfile.

> diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> index cb0bc543c0..adfe447334 100644
> --- a/backends/confidential-guest-support.c
> +++ b/backends/confidential-guest-support.c
> @@ -16,6 +16,7 @@
>   #include "exec/confidential-guest-support.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> +#include "exec/igvm.h"
>   
>   OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
>                               confidential_guest_support,
> @@ -34,6 +35,9 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
>       ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>       g_free(cgs->igvm_filename);
>       cgs->igvm_filename = g_strdup(value);
> +#if defined(CONFIG_IGVM)

You don't need the #ifdef'ry because if CONFIG_IGVM you defined
an inlined function which returns 0.

> +    igvm_file_init(cgs, errp);

You are deliberately ignoring the return value. Should the prototype
return void? Or at least a boolean, since the return value is (-1, 0).

> +#endif
>   }
>   #endif
>   
> diff --git a/backends/igvm.c b/backends/igvm.c
> new file mode 100644
> index 0000000000..87e6032a2e
> --- /dev/null
> +++ b/backends/igvm.c
> @@ -0,0 +1,745 @@
> +/*
> + * QEMU IGVM configuration backend for Confidential Guests
> + *
> + * Copyright (C) 2023-2024 SUSE
> + *
> + * Authors:
> + *  Roy Hopkins <roy.hopkins@suse.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#if defined(CONFIG_IGVM)

This file is only compiled when CONFIG_IGVM is set, so no need for
this guard.

> +#include "exec/confidential-guest-support.h"
> +#include "qemu/queue.h"
> +#include "qemu/typedefs.h"

No need to include "qemu/typedefs.h", we get it via "qemu/osdep.h".

> +#include "exec/igvm.h"
> +#include "qemu/error-report.h"
> +#include "hw/boards.h"

What is used from "hw/board.h"?

> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +
> +#include <igvm/igvm.h>
> +#include <igvm/igvm_defs.h>
> +#include <linux/kvm.h>
> +
> +typedef struct IgvmParameterData {
> +    QTAILQ_ENTRY(IgvmParameterData) next;
> +    uint8_t *data;
> +    uint32_t size;
> +    uint32_t index;
> +} IgvmParameterData;
> +
> +static QTAILQ_HEAD(, IgvmParameterData) parameter_data;

Can we store this in ConfidentialGuestSupport instead?

Possibly forward-declaring a structure, using an opaque
pointer in ConfidentialGuestSupport ...:

typedef struct QemuIvgm QemuIvgm;

struct ConfidentialGuestSupport {
     ...
     QemuIvgm *ivgm;
     ...
};

... and defining the struct here in igvm.c:

struct QemuIvgm {
     char *filename;
     IgvmHandle handle;
     QTAILQ_HEAD(, IgvmParameterData) parameter_data;
};

> +static int directive_page_data(ConfidentialGuestSupport *cgs, int i,
> +                               uint32_t compatibility_mask,
> +                               const uint8_t *header_data, Error **errp);
> +static int directive_vp_context(ConfidentialGuestSupport *cgs, int i,
> +                                uint32_t compatibility_mask,
> +                                const uint8_t *header_data, Error **errp);
> +static int directive_parameter_area(ConfidentialGuestSupport *cgs, int i,
> +                                    uint32_t compatibility_mask,
> +                                    const uint8_t *header_data, Error **errp);
> +static int directive_parameter_insert(ConfidentialGuestSupport *cgs, int i,
> +                                      uint32_t compatibility_mask,
> +                                      const uint8_t *header_data, Error **errp);
> +static int directive_memory_map(ConfidentialGuestSupport *cgs, int i,
> +                                uint32_t compatibility_mask,
> +                                const uint8_t *header_data, Error **errp);
> +static int directive_vp_count(ConfidentialGuestSupport *cgs, int i,
> +                              uint32_t compatibility_mask,
> +                              const uint8_t *header_data, Error **errp);
> +static int directive_environment_info(ConfidentialGuestSupport *cgs, int i,
> +                                      uint32_t compatibility_mask,
> +                                      const uint8_t *header_data, Error **errp);
> +static int directive_required_memory(ConfidentialGuestSupport *cgs, int i,
> +                                     uint32_t compatibility_mask,
> +                                     const uint8_t *header_data, Error **errp);
> +
> +struct IGVMDirectiveHandler {
> +    uint32_t type;
> +    int (*handler)(ConfidentialGuestSupport *cgs, int i,
> +                   uint32_t compatibility_mask, const uint8_t *header_data,
> +                   Error **errp);
> +};
> +
> +static struct IGVMDirectiveHandler directive_handlers[] = {

const.

> +    { IGVM_VHT_PAGE_DATA, directive_page_data },
> +    { IGVM_VHT_VP_CONTEXT, directive_vp_context },
> +    { IGVM_VHT_PARAMETER_AREA, directive_parameter_area },
> +    { IGVM_VHT_PARAMETER_INSERT, directive_parameter_insert },
> +    { IGVM_VHT_MEMORY_MAP, directive_memory_map },
> +    { IGVM_VHT_VP_COUNT_PARAMETER, directive_vp_count },
> +    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, directive_environment_info },
> +    { IGVM_VHT_REQUIRED_MEMORY, directive_required_memory },
> +};
> +
> +static int directive(uint32_t type, ConfidentialGuestSupport *cgs, int i,
> +                      uint32_t compatibility_mask, Error **errp)
> +{
> +    size_t handler;
> +    IgvmHandle header_handle;
> +    const uint8_t *header_data;
> +    int result;
> +
> +    for (handler = 0; handler < (sizeof(directive_handlers) /
> +                                 sizeof(struct IGVMDirectiveHandler));

We have ARRAY_SIZE(), which is easier to read.

> +         ++handler) {
> +        if (directive_handlers[handler].type == type) {
> +            header_handle =
> +                igvm_get_header(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +            if (header_handle < 0) {
> +                error_setg(
> +                    errp,
> +                    "IGVM file is invalid: Failed to read directive header (code: %d)",
> +                    (int)header_handle);
> +                return -1;
> +            }
> +            header_data = igvm_get_buffer(cgs->igvm, header_handle) +
> +                          sizeof(IGVM_VHS_VARIABLE_HEADER);
> +            result = directive_handlers[handler].handler(
> +                cgs, i, compatibility_mask, header_data, errp);
> +            igvm_free_buffer(cgs->igvm, header_handle);
> +            return result;
> +        }
> +    }
> +    error_setg(errp,
> +               "IGVM: Unknown directive type encountered when processing file: "
> +               "(type 0x%X)",
> +               type);
> +    return -1;
> +}

[...]

> +int igvm_process(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    int32_t result;
> +    int i;

Since 'i' is never set with a negative value, it can be declared
as unsigned.

> +    uint32_t compatibility_mask;
> +    IgvmParameterData *parameter;
> +    int retval = 0;
> +
> +    /*
> +     * If this is not a Confidential guest or no IGVM has been provided then
> +     * this is a no-op.
> +     */
> +    if (!cgs->igvm) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Check that the IGVM file provides configuration for the current
> +     * platform
> +     */
> +    compatibility_mask = supported_platform_compat_mask(cgs, errp);
> +    if (compatibility_mask == 0) {
> +        return -1;
> +    }
> +
> +    result = igvm_header_count(cgs->igvm, HEADER_SECTION_DIRECTIVE);
> +    if (result < 0) {
> +        error_setg(
> +            errp, "Invalid directive header count in IGVM file. Error code: %X",
> +            result);
> +        return -1;
> +    }
> +
> +    QTAILQ_INIT(&parameter_data);
> +
> +    for (i = 0; i < (int)result; ++i) {

Well, 'i' is clearly unsigned.

I'd rename s/result/header_count/ and s/i/header_index/ here and in all
the callees.

> +        IgvmVariableHeaderType type =
> +            igvm_get_header_type(cgs->igvm, HEADER_SECTION_DIRECTIVE, i);
> +        if (directive(type, cgs, i, compatibility_mask, errp) < 0) {
> +            retval = -1;
> +            break;
> +        }
> +    }
> +
> +    /*
> +     * Contiguous pages of data with compatible flags are grouped together in
> +     * order to reduce the number of memory regions we create. Make sure the
> +     * last group is processed with this call.
> +     */
> +    if (retval == 0) {
> +        retval = process_mem_page(cgs, i, NULL, errp);
> +    }
> +
> +    QTAILQ_FOREACH(parameter, &parameter_data, next)
> +    {
> +        g_free(parameter->data);
> +        parameter->data = NULL;
> +    }
> +
> +    return retval;
> +}
> +
> +#endif
> diff --git a/backends/meson.build b/backends/meson.build
> index d550ac19f7..d092850a07 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -32,6 +32,7 @@ system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
>   system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
>   if igvm.found()
>     system_ss.add(igvm)
> +  system_ss.add(files('igvm.c'))

You want in the same line to propagate the library flags to the built
objects:

     system_ss.add([files('igvm.c'), igvm])

>   endif
>   
>   subdir('tpm')
> diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
> index a8ad84fa07..9419e91249 100644
> --- a/include/exec/confidential-guest-support.h
> +++ b/include/exec/confidential-guest-support.h
> @@ -27,6 +27,10 @@
>   #include "igvm/igvm.h"
>   #endif
>   
> +#if defined(CONFIG_IGVM)
> +#include "igvm/igvm.h"

You already included it in the previous commit ;)

> +#endif
> +
>   #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
>   OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport, CONFIDENTIAL_GUEST_SUPPORT)
>   
> @@ -93,6 +97,7 @@ struct ConfidentialGuestSupport {
>        *                Virtual Machine (IGVM) format.
>        */
>       char *igvm_filename;
> +    IgvmHandle igvm;
>   #endif
>   
>       /*
> diff --git a/include/exec/igvm.h b/include/exec/igvm.h
> new file mode 100644
> index 0000000000..59594f047e
> --- /dev/null
> +++ b/include/exec/igvm.h

Please move to include/sysemu/ (confidential-guest-support.h will soon
be moved there).

> @@ -0,0 +1,36 @@
> +/*
> + * QEMU IGVM configuration backend for Confidential Guests
> + *
> + * Copyright (C) 2023-2024 SUSE
> + *
> + * Authors:
> + *  Roy Hopkins <roy.hopkins@suse.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef EXEC_IGVM_H
> +#define EXEC_IGVM_H
> +
> +#include "exec/confidential-guest-support.h"
> +
> +#if defined(CONFIG_IGVM)
> +
> +int igvm_file_init(ConfidentialGuestSupport *cgs, Error **errp);
> +int igvm_process(ConfidentialGuestSupport *cgs, Error **erp);
> +
> +#else
> +
> +static inline int igvm_file_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    return 0;
> +}
> +
> +static inline int igvm_process(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +}
> +
> +#endif
> +
> +#endif


