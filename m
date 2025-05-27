Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17F4C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuVE-0001Ed-KC; Tue, 27 May 2025 09:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJuVB-0001DS-Me
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJuV8-0002qM-Pp
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748353072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SQ5kQwicfysbKtjpVJhFRMadZlT2IejENdYEybwg8Y=;
 b=K57xIgYsoHE/OBMHZ9QheyJsPsDWVVFz0QJsDnlLDQdxyMnY09dA75NvNJlKBrMkUDzg+y
 emAM53NtleMKLv2DKj/3p98WH55ErcK9SXY1k2/rOAtpvYToaKyAmidNGMQthzsICQAl+k
 Bgd6W7p2mUx6zzq90U1ATDeR9PYzLiY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-YIfbS9haO5GITZggmaXLzA-1; Tue, 27 May 2025 09:37:50 -0400
X-MC-Unique: YIfbS9haO5GITZggmaXLzA-1
X-Mimecast-MFC-AGG-ID: YIfbS9haO5GITZggmaXLzA_1748353069
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-445135eb689so21189885e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748353069; x=1748957869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SQ5kQwicfysbKtjpVJhFRMadZlT2IejENdYEybwg8Y=;
 b=Tw7tD+9mqLVtcXd4nWqI9Q81LreiwNQcge2fCTd6HCIbg0rycMyJD6cPCayqH+weJX
 T0olo7lyn0a/VdDRiQzPcMyfdyHrSZKME5a458HySwJEOi2eWGBaXoeRVAfhCwhdu3f4
 9X/OjbAdmR9m7aLpHsFi/l16QZIZgg6ENlizKKIKoj0GOA0KBCwCZrlsQBBuf9GMjD9J
 v3O7I7hioc1oeloVmB1llIovU0wUbjEYezZtplAjj6toM8KNYgjhy/Z4lLVDs6iCitSt
 i0+svNAsJQe0rDmNaC+4XO+4UqA1Crbr1qYZ+TID2KNtDPiEWm8OM3M9oFvsCWmc2MyR
 wX9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7DDyFfL/U2CUDOvSK6H8MZY/Fp/bOZoWXC8PqtfqZN+8+EL2efN1XXK+8vQqVaLRRmw3g4LB9sTB9@nongnu.org
X-Gm-Message-State: AOJu0YzeKX7p/Yj0kX9uMBnvWFnSmOHQ9SmNg1lL4jXyX0+eGNljgFLq
 VESpB+4N7N4+TU8cePqCQ3keM0C3CHsxGTQ7DbTJkZHC3gcLSG/spRRo3I/uvT3JxI3mX4Yv3TK
 Dl4CMpI8zRPKN4ddWlOhAJXVdgafLBJEymwS8eiFMOUXaFnuYEwC7M86P
X-Gm-Gg: ASbGncvQMm9MoCJe/ar1hmiDD2c6R6KbW1PCEHjJUIdYJ8M+vvfUzqjQPU9mXzXZzMF
 m9itQ8VY8SeX1jMs6Pu2NE+mbvJ2sKlD5wbuXECNi8eb+BVX1qtCTiDUaca9sbTN1ilJR5F1de4
 7QdrQY0zx5PBB+prdPOP/ESae++jR54O7t8YXeNaVncafq0XanbGButPyAPJGMgCxVGIeD1UOkI
 OThW54h0ETcRFDHhGDE5nNX34IS98Ktn+Fes9minrjXPbYYQlDKdg5XPlTCfwyAlcx27oUtVfVR
 REtF5kHEjht+N+ygom69uiizhlrC0GPI
X-Received: by 2002:a05:600c:1388:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-44c916fc5efmr114842855e9.6.1748353069467; 
 Tue, 27 May 2025 06:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrhSE+HHCukp2ZXu4hbp24TFy5K98iIWxJJBZvi6UkYyuGrcZGdrzvF5KxaFtEyTSLrUr31w==
X-Received: by 2002:a05:600c:1388:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-44c916fc5efmr114842455e9.6.1748353068980; 
 Tue, 27 May 2025 06:37:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd9c65sm279954375e9.39.2025.05.27.06.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:37:46 -0700 (PDT)
Date: Tue, 27 May 2025 15:37:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 13/25] hw/i386/acpi-build: Move
 build_append_notification_callback to pcihp
Message-ID: <20250527153745.70c39f4c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-14-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-14-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 27 May 2025 09:40:15 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> We plan to reuse build_append_notification_callback() on ARM
> so let's move it to pcihp.c.
> 
> No functional change intended.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/pcihp.h |  1 +
>  hw/acpi/pcihp.c         | 58 +++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c    | 58 -----------------------------------------
>  3 files changed, 59 insertions(+), 58 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 253ac6e483..f4fd44cb32 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -78,6 +78,7 @@ void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
>  void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
>  void build_append_pcihp_resources(Aml *table,
>                                    uint64_t io_addr, uint64_t io_len);
> +bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus);
>  
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 310a5c54bd..907a08ac7f 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -39,6 +39,7 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qom/qom-qobject.h"
> +#include "qobject/qnum.h"
>  #include "trace.h"
>  
>  #define ACPI_PCIHP_SIZE 0x0018
> @@ -705,6 +706,63 @@ void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
>      aml_append(scope, dev);
>  }
>  
> +bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
> +{
> +    Aml *method;
> +    PCIBus *sec;
> +    QObject *bsel;
> +    int nr_notifiers = 0;
> +    GQueue *pcnt_bus_list = g_queue_new();
> +
> +    QLIST_FOREACH(sec, &bus->child, sibling) {
> +        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
> +        if (pci_bus_is_root(sec)) {
> +            continue;
> +        }
> +        nr_notifiers = nr_notifiers +
> +                       build_append_notification_callback(br_scope, sec);
> +        /*
> +         * add new child scope to parent
> +         * and keep track of bus that have PCNT,
> +         * bus list is used later to call children PCNTs from this level PCNT
> +         */
> +        if (nr_notifiers) {
> +            g_queue_push_tail(pcnt_bus_list, sec);
> +            aml_append(parent_scope, br_scope);
> +        }
> +    }
> +
> +    /*
> +     * Append PCNT method to notify about events on local and child buses.
> +     * ps: hostbridge might not have hotplug (bsel) enabled but might have
> +     * child bridges that do have bsel.
> +     */
> +    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> +
> +    /* If bus supports hotplug select it and notify about local events */
> +    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> +    if (bsel) {
> +        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> +
> +        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> +        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> +                                     aml_int(1))); /* Device Check */
> +        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> +                                     aml_int(3))); /* Eject Request */
> +        nr_notifiers++;
> +    }
> +
> +    /* Notify about child bus events in any case */
> +    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
> +        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
> +    }
> +
> +    aml_append(parent_scope, method);
> +    qobject_unref(bsel);
> +    g_queue_free(pcnt_bus_list);
> +    return !!nr_notifiers;
> +}
> +
>  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>      .name = "acpi_pcihp_pci_status",
>      .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6ca2b34ef8..3275675e60 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -563,64 +563,6 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>      }
>  }
>  
> -static bool build_append_notification_callback(Aml *parent_scope,
> -                                               const PCIBus *bus)
> -{
> -    Aml *method;
> -    PCIBus *sec;
> -    QObject *bsel;
> -    int nr_notifiers = 0;
> -    GQueue *pcnt_bus_list = g_queue_new();
> -
> -    QLIST_FOREACH(sec, &bus->child, sibling) {
> -        Aml *br_scope = aml_scope("S%.02X", sec->parent_dev->devfn);
> -        if (pci_bus_is_root(sec)) {
> -            continue;
> -        }
> -        nr_notifiers = nr_notifiers +
> -                       build_append_notification_callback(br_scope, sec);
> -        /*
> -         * add new child scope to parent
> -         * and keep track of bus that have PCNT,
> -         * bus list is used later to call children PCNTs from this level PCNT
> -         */
> -        if (nr_notifiers) {
> -            g_queue_push_tail(pcnt_bus_list, sec);
> -            aml_append(parent_scope, br_scope);
> -        }
> -    }
> -
> -    /*
> -     * Append PCNT method to notify about events on local and child buses.
> -     * ps: hostbridge might not have hotplug (bsel) enabled but might have
> -     * child bridges that do have bsel.
> -     */
> -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> -
> -    /* If bus supports hotplug select it and notify about local events */
> -    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
> -    if (bsel) {
> -        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> -
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> -        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> -                                     aml_int(1))); /* Device Check */
> -        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> -                                     aml_int(3))); /* Eject Request */
> -        nr_notifiers++;
> -    }
> -
> -    /* Notify about child bus events in any case */
> -    while ((sec = g_queue_pop_head(pcnt_bus_list))) {
> -        aml_append(method, aml_name("^S%.02X.PCNT", sec->parent_dev->devfn));
> -    }
> -
> -    aml_append(parent_scope, method);
> -    qobject_unref(bsel);
> -    g_queue_free(pcnt_bus_list);
> -    return !!nr_notifiers;
> -}
> -
>  /*
>   * build_prt - Define interrupt routing rules
>   *


