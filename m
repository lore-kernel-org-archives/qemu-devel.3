Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32FC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKAH-0003h6-2F; Tue, 20 May 2025 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHKAE-0003gZ-1R
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHKA6-0004EZ-1V
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747736725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eanb8p9+Goxj8mt5y0Xn3fcuxtg4sDG3WvlGbqaREwU=;
 b=RQAbtlz60Crk0qm9Fh2vvu2Cuqv8SNt7fPVZn+jKuSZqQfBnpWjckpqzP9C8UGc5zNR74h
 Kw9rS6cUIu+seuxTvEUc7aG5Ft/1mbkDBrXDYzUtrJO34JF3W1jMjlJOt1J8MpYip6EdVB
 DjYXk9JkE7FDJSd/vmXSwk2cojtK1J4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-lqOSs9nANP-WPUjDNHoQ7w-1; Tue, 20 May 2025 06:25:24 -0400
X-MC-Unique: lqOSs9nANP-WPUjDNHoQ7w-1
X-Mimecast-MFC-AGG-ID: lqOSs9nANP-WPUjDNHoQ7w_1747736723
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a364802ec5so905662f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747736723; x=1748341523;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eanb8p9+Goxj8mt5y0Xn3fcuxtg4sDG3WvlGbqaREwU=;
 b=glu53s8587DAtJWxz+m4UC2uXwuct/XYkLswP4hQgRWeXMT1Qg8t1Td/z/yFp+OkQs
 gONKgZmQO02qckPSN2ZEEGwQh+c5nfDmiUVS9SIdwG8K5wjvASAJ+8tSozZKH6dwzvxf
 ijTMQiEw2ew7oTDBhrzH7dVJpMfyZ/MHvMlg1QGcoox7xZeuigNV4GPiNtUK4hscGwuI
 vwNHoJbmIUkr7uFCWfdRP9cGiWneSMciC5anvFPnmrXP+p79twvu5Trmkdzzks+PSPvN
 +0IkErC9ohcvXLagT7uimBhCZRcf59TY9upYpAexvyQDkWGaGSDZQx0Qvq1cReuNqUeH
 F7JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkkpwgLdUgnH/oI1Xg2VbBkbZ8RFWcyNy0a0/JAJAJFsE+XRaIG8zDSen6E9kvUxQmRFrTp67s4KbR@nongnu.org
X-Gm-Message-State: AOJu0YxkiEE82G45CbBHm/Ivvj+w8zdFzUZIQa2SZCkhc4Vv7o5AHMcI
 T0LKEI0Atj3W08KijnDNTvLaqs7sNdEUa4i+A4OkLeFBJl690ZpB3AmfQJ+IWjGNdZMx+XS2WBF
 +FpwWLDXBAuMdC7Do2LZtjifGjLoQRwlJaUPMMUkDR2kD3f+b8MqFpfb1
X-Gm-Gg: ASbGncslGVGDpS0/NInpS0GP7maZs3oVI9//u2R0CDUfKDL87u1/2F/uM4lhi6eOGoA
 0EKo3vScGBvL1LFujSR+k3bL/wzNEKmxBxGScUoABqL9lpVw1AS13BJwDmLDHndMiX8v9das38g
 CuxMOpHWBUb99/qSFbhuINo6vNsBSjAElWCNO9hkS/xcPf9WVd38NmJZQYQ2EkxO7UjW1xLT+Jl
 rixvGtgNBV0T67sQqs0+M5Hg7KC6vK0SvooJ+mwxuoTlDriH8t8NamwUHUYThHepygRNCUJmC15
 OEsY1FkQsJdZ6zGTWrgrtrwGffXwk0QffShs8hTsJxk=
X-Received: by 2002:a05:6000:40de:b0:3a3:7465:7e6d with SMTP id
 ffacd0b85a97d-3a37474c253mr5137291f8f.27.1747736723005; 
 Tue, 20 May 2025 03:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrFc/5tSuTIZt4pCxjkHluf49zAZNb7VJZFlQgKrEaYQ71sm6HJ2xTycMxVsf/VEjDsc/0kA==
X-Received: by 2002:a05:6000:40de:b0:3a3:7465:7e6d with SMTP id
 ffacd0b85a97d-3a37474c253mr5137261f8f.27.1747736722526; 
 Tue, 20 May 2025 03:25:22 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78aeb7fsm24357795e9.26.2025.05.20.03.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 03:25:22 -0700 (PDT)
Message-ID: <53616ccd-3fb5-41e9-bd6a-0a0243b1a392@redhat.com>
Date: Tue, 20 May 2025 12:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/25] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-18-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile     |   3 +-
>   pc-bios/s390-ccw/bootmap.c    | 192 +++++++++++++++++++++++++++++++++-
>   pc-bios/s390-ccw/bootmap.h    |   9 ++
>   pc-bios/s390-ccw/main.c       |   9 ++
>   pc-bios/s390-ccw/s390-ccw.h   |  14 +++
>   pc-bios/s390-ccw/sclp.c       |  44 ++++++++
>   pc-bios/s390-ccw/sclp.h       |   6 ++
>   pc-bios/s390-ccw/secure-ipl.c | 175 +++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h | 109 +++++++++++++++++++
>   9 files changed, 558 insertions(+), 3 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index dc69dd484f..fedb89a387 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   .PHONY : all clean build-all distclean
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> +	  secure-ipl.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 3dd09fda7e..06cea0929a 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -15,6 +15,7 @@
>   #include "bootmap.h"
>   #include "virtio.h"
>   #include "bswap.h"
> +#include "secure-ipl.h"
>   
>   #ifdef DEBUG
>   /* #define DEBUG_FALLBACK */
> @@ -34,6 +35,13 @@ static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
>   const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
>                                     "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>   
> +/* sector for storing certificates */
> +static uint8_t certs_sec[CERT_MAX_SIZE * MAX_CERTIFICATES];

If I calculated correctly, that's a buffer of 512 kB... That's quite huge 
already. Would it be possible to malloc() it only if we really need this 
instead of statically allocating it?

> +/* sector for storing signatures */
> +static uint8_t sig_sec[MAX_SECTOR_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
> +
> +ipl_print_func_t zipl_secure_print_func;
> +
>   /*
>    * Match two CCWs located after PSW and eight filler bytes.
>    * From libmagic and arch/s390/kernel/head.S.
> @@ -676,6 +684,155 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>       return comp_len;
>   }
>   
> +static uint32_t zipl_handle_sig_entry(ComponentEntry *entry)
> +{
> +    uint32_t sig_len;
> +
> +    if (zipl_load_segment(entry, (uint64_t)sig_sec) < 0) {
> +        return -1;
> +    }
> +
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return -1;
> +    }
> +    sig_len = entry->compdat.sig_info.sig_len;
> +
> +    return sig_len;
> +}
> +
> +static int handle_certificate(int *cert_table, uint64_t **cert,
> +                             uint64_t cert_len, uint8_t cert_idx,
> +                             IplSignatureCertificateList *certs, int cert_index)
> +{
> +    bool unused;
> +
> +    unused = cert_table[cert_idx] == -1;
> +    if (unused) {
> +        if (zipl_secure_request_certificate(*cert, cert_idx)) {
> +            zipl_secure_cert_list_add(certs, cert_index, *cert, cert_len);
> +            cert_table[cert_idx] = cert_index;
> +            *cert += cert_len;

So zipl_secure_cert_list_add() checks for the index not going beyond 
MAX_CERTIFICATES, but here you ignore that error and update cert_table and 
*cert anyway? Sounds like a potential bug to me.

> +        } else {
> +            puts("Could not get certificate");
> +            return -1;
> +        }
> +
> +        /* increment cert_index for the next cert entry */
> +        return ++cert_index;
> +    }
> +
> +    return cert_index;
> +}
> +
> +static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
> +{
> +    bool found_signature = false;
> +    IplDeviceComponentList comps;
> +    IplSignatureCertificateList certs;
> +    uint64_t *cert = (uint64_t *)certs_sec;
> +    int cert_index = 0;
> +    int comp_index = 0;
> +    uint64_t comp_addr;
> +    int comp_len;
> +    bool have_sig;
> +    uint32_t sig_len;
> +    uint64_t cert_len = -1;
> +    uint8_t cert_idx = -1;
> +    bool verified;
> +    /*
> +     * Store indices of cert entry that have already used for signature verification
> +     * to prevent allocating the same certificate multiple times.
> +     * cert_table index: index of certificate from qemu cert store used for verification
> +     * cert_table value: index of cert entry in cert list that contains the certificate
> +     */
> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
> +    zipl_secure_print_func = zipl_secure_get_print_func(boot_mode);
> +
> +    if (!zipl_secure_ipl_supported()) {
> +        return -1;
> +    }
> +
> +    zipl_secure_init_lists(&comps, &certs);
> +
> +    have_sig = false;
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            /* There should never be two signatures in a row */
> +            if (have_sig) {
> +                return -1;
> +            }
> +
> +            sig_len = zipl_handle_sig_entry(entry);
> +            if (sig_len < 0) {
> +                return -1;
> +            }
> +
> +            have_sig = true;
> +        } else {
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry, comp_addr);
> +            if (comp_len < 0) {
> +                return -1;
> +            }
> +
> +            if (have_sig) {
> +                verified = verify_signature(comp_len, comp_addr,
> +                                            sig_len, (uint64_t)sig_sec,
> +                                            &cert_len, &cert_idx);
> +
> +                if (verified) {
> +                    cert_index = handle_certificate(cert_table, &cert,
> +                                                    cert_len, cert_idx,
> +                                                    &certs, cert_index);
> +
> +                    puts("Verified component");
> +                    zipl_secure_comp_list_add(&comps, comp_index, cert_table[cert_idx],
> +                                              comp_addr, comp_len,
> +                                              S390_IPL_COMPONENT_FLAG_SC |
> +                                              S390_IPL_COMPONENT_FLAG_CSV);
> +                } else {
> +                    zipl_secure_comp_list_add(&comps, comp_index, -1,
> +                                              comp_addr, comp_len,
> +                                              S390_IPL_COMPONENT_FLAG_SC);
> +                    zipl_secure_print_func(verified, "Could not verify component");
> +                }
> +
> +                comp_index++;
> +                found_signature = true;
> +                /* After a signature is used another new one can be accepted */
> +                have_sig = false;
> +            }
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {

Less parentheses please:

         if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {

> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
...
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..4e2328840b
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,109 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
> +
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
> +uint32_t zipl_secure_request_certificate(uint64_t *cert, uint8_t index);
> +void zipl_secure_cert_list_add(IplSignatureCertificateList *certs, int cert_index,
> +                               uint64_t *cert, uint64_t cert_len);
> +void zipl_secure_comp_list_add(IplDeviceComponentList *comps, int comp_index,
> +                               int cert_index, uint64_t comp_addr,
> +                               uint64_t comp_len, uint8_t flags);
> +int zipl_secure_update_iirb(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs);
> +bool zipl_secure_ipl_supported(void);
> +void zipl_secure_init_lists(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs);
> +
> +typedef void (*ipl_print_func_t)(bool, const char *);
> +
> +static inline ipl_print_func_t zipl_secure_get_print_func(ZiplBootMode boot_mode)
> +{
> +    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +        return &IPL_check;
> +    }
> +
> +    return NULL;
> +}

What is this function really good for?? And why do we need the function 
pointer below??? Aparently, the function pointer can also be NULL, but you 
call it also without checking for NULL first in the various other functions 
of this file ... looks very buggy to me, please rework this!

> +extern ipl_print_func_t zipl_secure_print_func;
> +
> +static inline uint64_t diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x320\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline uint64_t get_320_subcodes(uint64_t *ism)
> +{
> +    return diag320(ism, DIAG_320_SUBC_QUERY_ISM);
> +}

For such a simple call, it's likely not worth the effort to have a wrapper 
function.

> +static inline bool is_cert_store_facility_supported(void)
> +{
> +    uint64_t d320_ism;
> +
> +    get_320_subcodes(&d320_ism);
> +    return (d320_ism & DIAG_320_ISM_QUERY_VCSI) &&
> +           (d320_ism & DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x508\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline uint64_t get_508_subcodes(void)
> +{
> +    return _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +}

dito.

> +static inline bool is_secure_ipl_extension_supported(void)
> +{
> +    uint64_t d508_subcodes;
> +
> +    d508_subcodes = get_508_subcodes();
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(uint64_t comp_len, uint64_t comp_addr,
> +                                    uint64_t sig_len, uint64_t sig_addr,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SignatureVerificationBlock svb = {{}, comp_len, comp_addr,
> +                                             sig_len, sig_addr };
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
> +        *cert_len = svb.csi.len;
> +        *cert_idx = svb.csi.idx;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */

  Thomas


