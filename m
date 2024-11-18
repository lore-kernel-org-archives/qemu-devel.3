Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC2D49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyas-0000uZ-Ax; Mon, 18 Nov 2024 05:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tCyaP-0000rV-35
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:02:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tCyaN-0006ds-4N
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731924142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s+R5g1PAfqpGXGIdR6eEznFcm+OAepstd1mieiSuNAU=;
 b=HWPATtNEIwONtM00fQtt8zhwdfltDTiCMEa9fJ+lYv/GJ7Y01ny0rDUdStTWGQRYwRN4J9
 Zwg7OE4J/foPI4kYuWUu+6NsxB0+cdWgRbj1h/u7N8tiogBm1OC3mWwrgMdoqCzn7CqKeP
 0+TDCE/rBneR5YE8QhL/EJczyZ43lUE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-OusAtOHEMk-9e_3JsAYjjA-1; Mon, 18 Nov 2024 05:02:20 -0500
X-MC-Unique: OusAtOHEMk-9e_3JsAYjjA-1
X-Mimecast-MFC-AGG-ID: OusAtOHEMk-9e_3JsAYjjA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso32040265e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731924139; x=1732528939;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+R5g1PAfqpGXGIdR6eEznFcm+OAepstd1mieiSuNAU=;
 b=I776VVEfIEyZpu7zeC64MU8MwZqYWm0UBmvR2cWCFtqwy3sIkw8gkcZwi1z9YvxyI1
 g3OK1og/4Q79v2F5deYluxmsUxBKbezzlOi0O7hJoutkAzc4ZGlhfWw6Ni392Nx+hpYb
 ZUMuB4specjvzTYFIt8SZxn4AJSN9ZO+5zD4w/PldMqJweRXxHYMz2641rVFI4jA5HDQ
 lgmTbBbNXZb91aQB8o2ARolm2DwDKku9b/vX94HURsRN2JBNAPlRgfw6vcMWfeDxiI5x
 TomgafqUbXYWeQxZJuTXzn6t+QCaoixSBCHo8DEFI5ciE8QZXXnvp/HH5RInNmIF8dzr
 dT0g==
X-Gm-Message-State: AOJu0Yzcke2svQvepMnj/NSVoNTOd+AD1zUPxDHNJWI8mEDh+pj5U4ur
 GA9GQGIuvTZ1yiGX+ThzD74jkWZLT+lxsRx0grPX6BwEEpOYJsFSkflrc4Ctst9vQBXggdDivG5
 nJKSfQUzUmMyRWxacwZsIjjJ/x8fLY7EV/pdnryGFNys0RBYEeY3WRzliG4tw1RDPN5fOgfE1Al
 UTPJR4w9F5DRaSD5WpIhR1u9/utS+eY/+w
X-Received: by 2002:a05:600c:348c:b0:42c:bc22:e074 with SMTP id
 5b1f17b1804b1-432df7906f0mr91097175e9.29.1731924138777; 
 Mon, 18 Nov 2024 02:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBUWvzU3Cl8W61ns+2QTn9VNlHHiGIqVTmfznQOuS7yxL6rgG4JU0QjWw+2Voi/6L9AS9bjA==
X-Received: by 2002:a05:600c:348c:b0:42c:bc22:e074 with SMTP id
 5b1f17b1804b1-432df7906f0mr91096705e9.29.1731924138239; 
 Mon, 18 Nov 2024 02:02:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2946a3sm151443075e9.35.2024.11.18.02.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:02:17 -0800 (PST)
Message-ID: <eec8187b-eb57-4cb3-a845-45084ef48eb7@redhat.com>
Date: Mon, 18 Nov 2024 11:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241115141202.1877294-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241115141202.1877294-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 15/11/2024 15.12, Thomas Huth wrote:
> While adding the new flexible boot order feature on s390x recently,
> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
> devices. This property is required on s390x to pass the information
> to the boot loader about which kernel should be started or whether
> the boot menu should be shown. But even more serious: The missing
> property is now causing trouble with the corresponding libvirt patches
> that assume that the "loadparm" property is either settable for all
> bootable devices (when the "boot order" feature is implemented in
> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
> one "loadparm" at the machine level). To fix this broken situation,
> let's implement the "loadparm" property in for the SCSI devices, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2:
>   - Only add the property when running with the s390x target
>     (checked via the arch_type variable during runtime)
>   - Check bootindex property before setting the loadparm property
>   - Call the sanitize function before setting the property, so we
>     can now immediately reject bad properties for the scsi devices,
>     too (had to move the sanitize function to the common code in
>     qdev-properties-system.c for this)
> 
>   include/hw/qdev-properties-system.h |  3 ++
>   hw/core/qdev-properties-system.c    | 26 +++++++++++++++++
>   hw/s390x/ipl.c                      | 19 ++++---------
>   hw/scsi/scsi-disk.c                 | 43 +++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 13 deletions(-)

If there are no objections, I'll pick this up for my pull request for QEMU 
9.2-rc1.

  Thomas


> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index cdcc63056e..7ec37f6316 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -3,6 +3,9 @@
>   
>   #include "hw/qdev-properties.h"
>   
> +bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +                                       Error **errp);
> +
>   extern const PropertyInfo qdev_prop_chr;
>   extern const PropertyInfo qdev_prop_macaddr;
>   extern const PropertyInfo qdev_prop_reserved_region;
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 35deef05f3..a61c5ee6dd 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -58,6 +58,32 @@ static bool check_prop_still_unset(Object *obj, const char *name,
>       return false;
>   }
>   
> +bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +                                       Error **errp)
> +{
> +    int i, len;
> +
> +    len = strlen(str);
> +    if (len > 8) {
> +        error_setg(errp, "'loadparm' can only contain up to 8 characters");
> +        return false;
> +    }
> +
> +    for (i = 0; i < len; i++) {
> +        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
> +
> +        if (qemu_isalnum(c) || c == '.' || c == ' ') {
> +            loadparm[i] = c;
> +        } else {
> +            error_setg(errp,
> +                       "invalid character in 'loadparm': '%c' (ASCII 0x%02x)",
> +                       c, c);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
>   
>   /* --- drive --- */
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index dc02b0fdda..30734661ad 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -418,21 +418,9 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>   
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
>   {
> -    int i;
> -
>       /* Initialize the loadparm with spaces */
>       memset(loadparm, ' ', LOADPARM_LEN);
> -    for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
> -        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
> -
> -        if (qemu_isalnum(c) || c == '.' || c == ' ') {
> -            loadparm[i] = c;
> -        } else {
> -            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
> -                       c, c);
> -            return;
> -        }
> -    }
> +    qdev_prop_sanitize_s390x_loadparm(loadparm, str, errp);
>   }
>   
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
> @@ -452,6 +440,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
> +    g_autofree void *scsi_lp = NULL;
>   
>       /*
>        * Currently allow IPL only from CCW devices.
> @@ -463,6 +452,10 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> +            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
> +            if (scsi_lp && strlen(scsi_lp) > 0) {
> +                lp = scsi_lp;
> +            }
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index cb222da7a5..8e553487d5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/scsi/emulation.h"
>   #include "scsi/constants.h"
> +#include "sysemu/arch_init.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/blockdev.h"
>   #include "hw/block/block.h"
> @@ -111,6 +112,7 @@ struct SCSIDiskState {
>       char *vendor;
>       char *product;
>       char *device_id;
> +    char *loadparm;     /* only for s390x */
>       bool tray_open;
>       bool tray_locked;
>       /*
> @@ -3135,6 +3137,43 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
>       return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
>   }
>   
> +static char *scsi_property_get_loadparm(Object *obj, Error **errp)
> +{
> +    return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
> +}
> +
> +static void scsi_property_set_loadparm(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    void *lp_str;
> +
> +    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
> +        error_setg(errp, "'loadparm' is only valid for boot devices");
> +        return;
> +    }
> +
> +    lp_str = g_malloc0(strlen(value));
> +    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
> +        g_free(lp_str);
> +        return;
> +    }
> +    SCSI_DISK_BASE(obj)->loadparm = lp_str;
> +}
> +
> +static void scsi_property_add_specifics(DeviceClass *dc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(dc);
> +
> +    /* The loadparm property is only supported on s390x */
> +    if (arch_type & QEMU_ARCH_S390X) {
> +        object_class_property_add_str(oc, "loadparm",
> +                                      scsi_property_get_loadparm,
> +                                      scsi_property_set_loadparm);
> +        object_class_property_set_description(oc, "loadparm",
> +                                              "load parameter (s390x only)");
> +    }
> +}
> +
>   static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3218,6 +3257,8 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
>       dc->desc = "virtual SCSI disk";
>       device_class_set_props(dc, scsi_hd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
>   
>   static const TypeInfo scsi_hd_info = {
> @@ -3258,6 +3299,8 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
>       dc->desc = "virtual SCSI CD-ROM";
>       device_class_set_props(dc, scsi_cd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
>   
>   static const TypeInfo scsi_cd_info = {


