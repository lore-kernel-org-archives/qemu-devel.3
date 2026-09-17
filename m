Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97BBC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Fhj-00031s-9u; Thu, 17 Sep 2026 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7FhJ-0002qP-LD; Thu, 17 Sep 2026 13:15:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7FhH-0003yd-ME; Thu, 17 Sep 2026 13:14:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1VX92552415; Thu, 17 Sep 2026 17:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c7j+M8
 eaddvle4iucZgH5k0r6L+9U4xp88ORMnm/yyg=; b=tFrP8b3BmDvVPhZmYjcHnr
 SNixcNVebAa3qt50GwH8QXyBuM/9/fyQce9qE35D6s45f++61odxFcF10LkwfpSN
 U6zXAJvPeVuJFki/6H6DtkDDTsjGm2wNBtL7o1b1j2EuMfjfw5j4oT0COxvrBIX+
 lWs1pGqe/CrqzmE0ARsJ7jDKyfZ3UuFCKzBAX+EA7r3548BCHE/c1s91fjUEsN9J
 XX+IOk8iGHOANInpYbNSUJ5OfDQzC4KrXW6Q/EGLLXkGD1kVnWyUi3AEOxdo7vPb
 ZvvR3Ml9xRf0BJkkUI7SF8hw6SrjR+81FgTqQnI/QyRZMpDSKhKOzJkylzMs+dMA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j3hxy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:14:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH91dY261526; Thu, 17 Sep 2026 17:14:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gek21y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:14:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HHEiJi44499258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 17:14:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46F7020049;
 Thu, 17 Sep 2026 17:14:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9B8920040;
 Thu, 17 Sep 2026 17:14:40 +0000 (GMT)
Received: from [9.39.22.229] (unknown [9.39.22.229])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 17:14:40 +0000 (GMT)
Message-ID: <b8a2b482-412f-49b2-84e4-2b289743bfa2@linux.ibm.com>
Date: Thu, 17 Sep 2026 22:44:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/loader: add load_elf_ram_sym_buf() for
 in-memory ELF loading
To: uverma@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-3-uverma@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260817102733.605346-3-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX1c/GC4/3CdEN
 YhnJ2AAvWFJfUPhkV1c+gUjGAfpa3GkYjRO0Yp98IwW3uzJ6RbwRBq+csq9/mnZN9jxT2bqzNc4
 69VosiL8BV83K72ZQXza+Wt4EWU6JANnIwBBKBqAG/hHzyVpCrm6UzcdsUL38iJgCK9mMoyE+Eb
 M2cgDJFkHWcWVxcAj14fM3+UsAv6x1AwhH+Qj8JC5CGN+tC1KVoMIqA2j5CK5an8+1yPqcDMkXT
 XW4Yb/gDHcdw2yevJW9d6GPgpUl/01Fi55fJw3tFXoOloiYONUThI/8cUl3UJJjbWS3M1CWuEzl
 OHFJ12MZvbPMw+J782vX4e1LaoFVszowkHgpDF9M5pj4m1yGbkmQwSCehWlgLhB6s1WGe0vVAuF
 c4TtGI4I0ru7jVZkOoRPgFp52xH5VUlWqRS/TorqpLpylphGXjP9f+bqxXU2JPmHNiVV9n8lExM
 brStW+3VH+H7I2iO/jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX56OkIYrbkypI
 QsbvQldVqcbSdZLwVCpwbIwmhtwaznmchVsAlfNUEWllMnvb1ZP2ZKAnbKpMDV1CBLthG1G2P6u
 l3cXR13143SkuVzN3XhzFDf//Bxb1WM=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac2009 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1Ev4rd7cM6WGa0Zo9nAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IYopm-8m2UEub3xXMH_XoejNRKfo0GlP
X-Proofpoint-GUID: pGSsTOFSHfDpxgfNu6uwkkZI7FbswaZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170243
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> Add a new public API load_elf_ram_sym_buf() that loads an ELF
> image from a caller-supplied memory buffer rather than a file path.
> The implementation writes the buffer to an anonymous memfd, then
> reuses the existing load_elf32/load_elf64 paths.
> 
> To support per-segment inspection by callers (e.g. detecting VoF
> firmware segments), extend the internal load_elf{32,64} template
> (elf_ops.h.inc) with an optional segment_fn_t callback that is
> invoked once for every PT_LOAD segment after its load address is
> resolved. Returning false from the callback aborts the load with
> ELF_LOAD_FAILED.
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   hw/core/loader.c         | 77 ++++++++++++++++++++++++++++++++++++++--
>   include/hw/core/loader.h | 30 ++++++++++++++++
>   include/hw/elf_ops.h.inc | 12 ++++++-
>   3 files changed, 116 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86..4e4e9764a3 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -43,6 +43,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/memfd.h"
>   #include "qemu/datadir.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> @@ -510,12 +511,14 @@ ssize_t load_elf_ram_sym(const char *filename,
>           ret = load_elf64(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
>                            pentry, lowaddr, highaddr, pflags, elf_machine,
> -                         clear_lsb, data_swab, as, load_rom, sym_cb);
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         NULL, NULL);
>       } else {
>           ret = load_elf32(filename, fd, elf_note_fn,
>                            translate_fn, translate_opaque, must_swab,
>                            pentry, lowaddr, highaddr, pflags, elf_machine,
> -                         clear_lsb, data_swab, as, load_rom, sym_cb);
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         NULL, NULL);
>       }
>   
>       if (ret > 0) {
> @@ -527,6 +530,76 @@ ssize_t load_elf_ram_sym(const char *filename,
>       return ret;
>   }
>   
> +ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
> +                              uint64_t (*elf_note_fn)(void *, void *, bool),
> +                              uint64_t (*translate_fn)(void *, uint64_t),
> +                              void *translate_opaque, uint64_t *pentry,
> +                              uint64_t *lowaddr, uint64_t *highaddr,
> +                              uint32_t *pflags, int elf_data_order,
> +                              int elf_machine, int clear_lsb, int data_swab,
> +                              AddressSpace *as, bool load_rom,
> +                              symbol_fn_t sym_cb,
> +                              segment_fn_t segment_fn, void *segment_opaque)
> +{
> +    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;
> +    int fd, must_swab;
> +    ssize_t ret = ELF_LOAD_FAILED;
> +    uint8_t e_ident[EI_NIDENT];
> +
> +    fd = memfd_create("qemu-elf-buf", MFD_CLOEXEC);

The memfd_create() is Linux-specific.

qemu/memfd.h only exposes the direct memfd_create() declaration for 
Linux configurations, so this also appears to break non-Linux system builds.

Could this use an existing portable QEMU temporary-fd abstraction, or 
alternatively could the ELF loader be factored so the common parser 
accepts an fd/buffer directly?

It seems undesirable for a generic loader API to require Linux memfd 
support.

OR

If it is an arch specific design decision, then we need to document it.

> +    if (fd < 0) {
> +        error_report("load_elf_ram_sym_buf: memfd_create: %s", strerror(errno));
> +        return ELF_LOAD_FAILED;
> +    }
> +
> +    if (write(fd, buf, buflen) != (ssize_t)buflen) {

A single write() is not guaranteed to consume the whole buffer and can 
be interrupted.

Also, if buflen > SSIZE_MAX, the cast used for comparison is problematic.

Please use the appropriate QEMU full-write helper (or loop handling 
short writes/EINTR).

> +        error_report("load_elf_ram_sym_buf: write: %s", strerror(errno));
> +        goto fail;
> +    }
> +
> +    lseek(fd, 0, SEEK_SET);
> +    if (read(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident)) {
> +        goto fail;
> +    }
> +    if (e_ident[0] != ELFMAG0 ||
> +        e_ident[1] != ELFMAG1 ||
> +        e_ident[2] != ELFMAG2 ||
> +        e_ident[3] != ELFMAG3) {
> +        ret = ELF_LOAD_NOT_ELF;
> +        goto fail;
> +    }
> +
> +    if (elf_data_order != ELFDATANONE && elf_data_order != e_ident[EI_DATA]) {
> +        ret = ELF_LOAD_WRONG_ENDIAN;
> +        goto fail;
> +    }
> +
> +    must_swab = host_data_order != e_ident[EI_DATA];
> +
> +    lseek(fd, 0, SEEK_SET);

both lseek call errors need to be handled.

> +    if (e_ident[EI_CLASS] == ELFCLASS64) {
> +        ret = load_elf64("(buffer)", fd, elf_note_fn,
> +                         translate_fn, translate_opaque, must_swab,
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         segment_fn, segment_opaque);
> +    } else {
> +        ret = load_elf32("(buffer)", fd, elf_note_fn,
> +                         translate_fn, translate_opaque, must_swab,
> +                         pentry, lowaddr, highaddr, pflags, elf_machine,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb,
> +                         segment_fn, segment_opaque);
> +    }
> +
> +    if (ret > 0) {
> +        debuginfo_report_elf("(buffer)", fd, 0);
> +    }
> +
> + fail:
> +    close(fd);
> +    return ret;
> +}
> +
>   static void bswap_uboot_header(uboot_image_header_t *hdr)
>   {
>   #if !HOST_BIG_ENDIAN
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d..b67b2ca013 100644
> --- a/include/hw/core/loader.h
> +++ b/include/hw/core/loader.h
> @@ -156,6 +156,36 @@ ssize_t load_elf_ram_sym(const char *filename,
>                            int clear_lsb, int data_swab,
>                            AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);
>   
> +/*
> + * segment_fn_t:
> + * Per-PT_LOAD segment callback for load_elf_ram_sym_buf().
> + */
> +typedef bool (*segment_fn_t)(void *opaque,
> +                             uint64_t paddr, uint64_t vaddr,
> +                             uint64_t filesz, uint64_t memsz);
> +
> +/*
> + * load_elf_ram_sym_buf:
> + * @buf: pointer to an in-memory ELF image
> + * @buflen: size of @buf in bytes
> + * @segment_fn: optional per-PT_LOAD callback
> + * @segment_opaque: opaque data passed to @segment_fn
> + *
> + * Identical to load_elf_ram_sym() but loads from a caller-supplied
> + * memory buffer instead of a file.  All other parameters have the
> + * same meaning as load_elf_ram_sym().
> + */
> +ssize_t load_elf_ram_sym_buf(const uint8_t *buf, size_t buflen,
> +                             uint64_t (*elf_note_fn)(void *, void *, bool),
> +                             uint64_t (*translate_fn)(void *, uint64_t),
> +                             void *translate_opaque, uint64_t *pentry,
> +                             uint64_t *lowaddr, uint64_t *highaddr,
> +                             uint32_t *pflags, int elf_data_order,
> +                             int elf_machine, int clear_lsb, int data_swab,
> +                             AddressSpace *as, bool load_rom,
> +                             symbol_fn_t sym_cb,
> +                             segment_fn_t segment_fn, void *segment_opaque);
> +
>   /** load_elf_as:
>    * Same as load_elf_ram_sym(), but always loads the elf as ROM
>    */
> diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
> index 044e72de2a..a2c9b52bf9 100644
> --- a/include/hw/elf_ops.h.inc
> +++ b/include/hw/elf_ops.h.inc
> @@ -321,7 +321,9 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>                                     uint32_t *pflags, int elf_machine,
>                                     int clear_lsb, int data_swab,
>                                     AddressSpace *as, bool load_rom,
> -                                  symbol_fn_t sym_cb)
> +                                  symbol_fn_t sym_cb,
> +                                  segment_fn_t segment_fn,
> +                                  void *segment_opaque)
>   {
>       struct elfhdr ehdr;
>       struct elf_phdr *phdr = NULL, *ph;
> @@ -504,6 +506,14 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>                   addr = ph->p_paddr;
>               }
>   
> +            if (segment_fn) {
> +                if (!segment_fn(segment_opaque, addr, ph->p_vaddr,
> +                                file_size, mem_size)) {
> +                    ret = ELF_LOAD_FAILED;
> +                    goto fail;
> +                }
> +            }
> +
>               if (data_swab) {
>                   elf_word j;
>                   for (j = 0; j < file_size; j += (1 << data_swab)) {

Thanks,
Narayana Murty N


