Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05442606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=H5tp+e2d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0y1-0005Ty-Mv; Thu, 22 Oct 2026 18:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0xz-0005TP-SJ; Thu, 22 Oct 2026 18:08:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0xx-0002S0-8e; Thu, 22 Oct 2026 18:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+X6U4avdGgmnXTrYp6X6i/8TT7m65WPw1qd2QIuefNM=; b=H5tp+e2dNzkH3lRyC0x9RGwM2B
 FQq+ToMMStFRD3wJKfcKrg3zrYDKQCe7npJQ+vNrk06dCt1pwvCEaaFes8OALIkglSacXrnkNaYba
 OotBYWsDCYZOWIfHu+pubZhL96jyEoaqmnGj7VaLufi7SfwHRjM/UulCf6C2Nt3l+h9S1RCk8gBPC
 0xnLJLqQ2vMKBAHV8LOGCkJfXunM4wh4Y2e7IIrf03nL+cBKQXgNz8hmjeE1SPy12UuASeV77lW5Q
 kzxLMb7x3ljneISg2CFhTjq4BjVDfpTSbHr1YbIWUBtv9JQaiDtuJRbWpi5KaQe/A7bTdOihmvwHZ
 2mNom+01xxo7rxQVurLZ1Vrdv/DUi/Yh1i1SZ2qFZZ9mmHXOc0m/AedoddVyx2RMyFqsXYTd47e/5
 J7Ldv2Qqadgwyg1/gX2N9Zs7njBlr4UuSx6m2zAfV0+8ykt8uLvPr6WtD+ThkHwFcKzsneYM761pv
 tG1IUbbpRq0zv4VF7wec7NAYnC6ftBGMvnxM/x4RNYDybCUuMtg5NKbRSaiET/BJRBKavsbNp45i5
 EaX8xxOlNvOnm/Z/bJVs3oeFhfyDZSlDLKBAePMtN48O4CWN07+IdcivbRmYRw79sKUyrVtXcTL3v
 se7Om0ylSe8fGFeFEQkMuDMxn/bKICLsCCYAhDwFM=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0x8-003GDl-85; Thu, 22 Oct 2026 23:08:02 +0100
Message-ID: <52aa616b-8b34-4bfb-86a0-92e9437a416d@ilande.co.uk>
Date: Thu, 22 Oct 2026 23:08:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261022-nohmp-next-v3-0-8b581b590512@redhat.com>
 <20261022-nohmp-next-v3-6-8b581b590512@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20261022-nohmp-next-v3-6-8b581b590512@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 06/10] igvm: make IgvmMemoryRegion a QOM
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 12:47, Marc-André Lureau wrote:

> Make IgvmMemoryRegion a QOM object, embedding MemoryRegion, and use it
> as the region owner. The IGVM list and memory subsystem can now hold
> references independently, and QOM frees after the last reference is
> dropped, fixing leaks reported by ASAN while running tests.
> 
> - object_unparent() is no longer needed, children are automatically unref
> - switch to memory_region_init_ram_flags_nomigrate() as other helpers
>    expect a DEVICE
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/igvm.c                | 97 +++++++++++++++++++++++++-----------------
>   include/system/igvm-internal.h |  9 ++--
>   2 files changed, 64 insertions(+), 42 deletions(-)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 7aa76441d0d0..e659fea25517 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -35,6 +35,12 @@
>   #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
>   #endif
>   
> +struct IgvmMemoryRegion {
> +    Object parent_obj;

Don't forget the blank line here, as per our style guide :)

> +    MemoryRegion mr;
> +    QTAILQ_ENTRY(IgvmMemoryRegion) next;
> +};
> +
>   /*
>    * Bit 31 of the variable header type indicates that the header is
>    * optional and can be safely ignored by a loader that does not
> @@ -253,10 +259,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>                                     int region_identifier, Error **errp)
>   {
>       ERRP_GUARD();
> -    IgvmMemoryRegion *imr = NULL;
> +    g_autoptr(IgvmMemoryRegion) imr = NULL;
>       Int128 gpa_region_size;
> +    g_autofree char *region_name = NULL;
> +    uint32_t flags = 0;
>       MemoryRegionSection mrs =
>           memory_region_find(get_system_memory(), addr, size);
> +
>       if (mrs.mr) {
>           if (!memory_region_is_ram(mrs.mr)) {
>               memory_region_unref(mrs.mr);
> @@ -279,36 +288,29 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>               return NULL;
>           }
>           return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
> -    } else {
> -        /*
> -         * The region_identifier is the is the index of the IGVM directive that
> -         * contains the page with the lowest GPA in the region. This will
> -         * generate a unique region name.
> -         */
> -        g_autofree char *region_name =
> -            g_strdup_printf("igvm.%X", region_identifier);
> -        imr = g_new0(IgvmMemoryRegion, 1);
> -        imr->mr = g_new0(MemoryRegion, 1);
> -        if (ctx->machine_state->cgs &&
> -            ctx->machine_state->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd_private(
> -                    imr->mr, NULL, region_name, size, errp)) {
> -                g_free(imr->mr);
> -                g_free(imr);
> -                return NULL;
> -            }
> -        } else {
> -            if (!memory_region_init_ram(imr->mr, NULL, region_name, size,
> -                                        errp)) {
> -                g_free(imr->mr);
> -                g_free(imr);
> -                return NULL;
> -            }
> -        }
> -        memory_region_add_subregion(get_system_memory(), addr, imr->mr);
> -        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
> -        return memory_region_get_ram_ptr(imr->mr);
>       }
> +
> +    /*
> +     * The region_identifier is the is the index of the IGVM directive that
> +     * contains the page with the lowest GPA in the region. This will
> +     * generate a unique region name.
> +     */
> +    region_name = g_strdup_printf("igvm.%X", region_identifier);
> +    imr = IGVM_MEMORY_REGION(object_new(TYPE_IGVM_MEMORY_REGION));
> +    if (ctx->machine_state->cgs &&
> +        ctx->machine_state->cgs->require_guest_memfd) {
> +        flags = RAM_GUEST_MEMFD_PRIVATE;
> +    }
> +    if (!memory_region_init_ram_flags_nomigrate(&imr->mr, OBJECT(imr),
> +                                                region_name, size,
> +                                                flags, errp)) {
> +        return NULL;
> +    }
> +    vmstate_register_ram_global(&imr->mr);
> +    memory_region_add_subregion(get_system_memory(), addr, &imr->mr);
> +    object_ref(imr); /* for the list */
> +    QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
> +    return memory_region_get_ram_ptr(&imr->mr);
>   }
>   
>   static int qigvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
> @@ -1161,14 +1163,33 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
>   {
>       IgvmMemoryRegion *imr, *tmp;
>   
> -    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
> -    {
> -        trace_qigvm_cleanup_memory(imr->mr->name);
> -        memory_region_del_subregion(get_system_memory(), imr->mr);
> -        vmstate_unregister_ram(imr->mr, NULL);
> +    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp) {
> +        trace_qigvm_cleanup_memory(imr->mr.name);
>           QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
> -        /* this triggers MemoryRegion cleanup */
> -        object_unparent(OBJECT(imr->mr));
> -        g_free(imr);
> +        object_unref(OBJECT(imr));
>       }
>   }
> +
> +static void qigvm_memory_region_finalize(Object *obj)
> +{
> +    IgvmMemoryRegion *imr = IGVM_MEMORY_REGION(obj);
> +
> +    if (imr->mr.container) {
> +        memory_region_del_subregion(imr->mr.container, &imr->mr);
> +    }
> +    vmstate_unregister_ram(&imr->mr, NULL);
> +}
> +
> +static const TypeInfo qigvm_memory_region_info = {
> +    .name = TYPE_IGVM_MEMORY_REGION,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(IgvmMemoryRegion),
> +    .instance_finalize = qigvm_memory_region_finalize,
> +};
> +
> +static void qigvm_register_types(void)
> +{
> +    type_register_static(&qigvm_memory_region_info);
> +}
> +
> +type_init(qigvm_register_types);
> diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
> index b3b64cb58444..c2ceb57ffa65 100644
> --- a/include/system/igvm-internal.h
> +++ b/include/system/igvm-internal.h
> @@ -18,10 +18,11 @@
>   #include "system/confidential-guest-support.h"
>   #include <igvm/igvm.h>
>   
> -typedef struct IgvmMemoryRegion {
> -    QTAILQ_ENTRY(IgvmMemoryRegion) next;
> -    MemoryRegion *mr;
> -} IgvmMemoryRegion;
> +typedef struct IgvmMemoryRegion IgvmMemoryRegion;
> +
> +#define TYPE_IGVM_MEMORY_REGION "igvm-memory-region"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(IgvmMemoryRegion, IGVM_MEMORY_REGION)
>   
>   struct IgvmCfg {
>       Object parent_obj;
> 


ATB,

Mark.


