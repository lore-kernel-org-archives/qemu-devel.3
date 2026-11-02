Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E05606A32C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=biz0HOs4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oZZvM/74
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNq5h-0007ZB-Uv; Mon, 02 Nov 2026 06:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNq5f-0007YU-MS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:20:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xNq5d-0003GF-Md
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793618436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=reZ4KvMRpiYBfWvauEmLonF58ltzO9Dk3TPTnzkrIM0=;
 b=biz0HOs4M5EWstxQElYPuclTbuuwskh2V77vY544bX6EyjL5BJSAHDhYdG3XFRTrpWQPEp
 l2683ubRUPzTKFw+YlLgYZcTdOBTCRNps+9zlr55fgFB9Sdi/dafL8iK/jdcpy7CNJbwaY
 WbA5bG0lMGB8RVjcwa1TgyBY3DKjcwg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ivLsq3xJMWSAyiEzOdVVVQ-1; Mon, 02 Nov 2026 06:20:35 -0500
X-MC-Unique: ivLsq3xJMWSAyiEzOdVVVQ-1
X-Mimecast-MFC-AGG-ID: ivLsq3xJMWSAyiEzOdVVVQ_1793618434
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc7e0321ec1so3507760a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 03:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618434; cv=none;
 d=google.com; s=arc-20260327;
 b=cnVTsMifR8V4t+YbD1OknjOLAY6TLe6hflrimyGoTJT29KteIW4LkJlw7f4DHiZwEr
 oI44RYMraeAbZJTg5TQyk9Te+qswgAg/xvWVoeOZih5hvo6Lec+zbAhoexlOQB3k4J+6
 nSh3GngFNQcrJhQF6wM3kg9YhhGVKl+3HDHUdQAuW4x+tG/hkkxx9tTb2pOiviGfL0X/
 JmVga3m2W5w4uWXJakVPcP/Qofofb/b+W6/KpGwV4cmGkWo3uKoTyVkAbWXWMbNl1Vh5
 ir75edi9jYKFLsYr17Gdp2cBKpcmy6u5mr2C2Xo5Hh0QzP7jV3E3ZIFJ2I+cXTQj2yPz
 22PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=reZ4KvMRpiYBfWvauEmLonF58ltzO9Dk3TPTnzkrIM0=;
 fh=JX2I+55v+lOxShsKPMdWwgcbtP1Gb6oPO+6PLX8ToUE=;
 b=CST3toEP1SmKaiERKoMgjn1pFT7i+mlydxN9q53rHRL15v1ct/1/Wrr0wzn9lM3UPw
 Zy9+Uy6YBFor/ISZoaOpd2V8/DBELdctDJOfaU3owZEofuOBQlpXU1gj0riIWdYI/2L2
 PPf8mTBMkGYXfzPtuk6LPZeGFOvUH3BTK0picK3btEVMFon8VRFLURfa1jleawF6JvXu
 hmUQX26Py6JjQD6eoTYymOG5/xnZdZRB7lahj2hNCKvKgJaT3M9qdfQ4D7Z8oOIvzDqy
 YQOELJhSzlXqQdapS9PFCqEA4g9/DbV8L/mMty5M53fFsxwfS7k+xHYPzfkH0i37aPLb
 mXrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793618434; x=1794223234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=reZ4KvMRpiYBfWvauEmLonF58ltzO9Dk3TPTnzkrIM0=;
 b=oZZvM/74FuC4os45PUI3YWZ+O/ZxDA/qDBtDSikmgj6ezeZxxvQKz0EdNdAH5HWpPg
 0btbhoumF15v1ZXxuSrOIwEIfGBPokExmosSSGsRnSxQxmoIw84iWlDIChqZzkSDulzp
 ODgUse8YTh/9LQlU+s2evR8v31CQAWBOI0WR9ieFv7UTlMvCnZbDdzy3yGSMYLMKHjNn
 UEu+7m1xsTc5KG/foheRMgTkmOeSQ8NPVkfQsmANgBgR1LDWOepLV54hHD0TjdcNFH+c
 Y/UBnnkGuRizAeLHPUOdeKjupIbfsmInFAd94V+eaOSnhEWHoR6uM5hprwQ+A6m+tNJX
 bSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618434; x=1794223234;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=reZ4KvMRpiYBfWvauEmLonF58ltzO9Dk3TPTnzkrIM0=;
 b=wsBtmDQ6JMxrn70FAlGHeSMsztj+kKqXQqG/5VSw8UlGDe9KPqco0RHjS5JpbA8OSr
 8CgiOEJmH1KU6NPvukIbO/2RtVk0/1ZZR2bq498CbnV12JbChbLJ/JGAD1ICgGPskmiD
 u6Wb1npcufilJWqgH82zbZygZnJOkFYwzg6KWepjj+YQyEkP9TbB3vDG9yY4v+z09mTJ
 VyaUEF3Jju8Wj0DawDk01YeORZhXP6BRwbyxGhFnpPpfCVJWV1bAK8sxTV0dB5Sal2qj
 UapnUghWmVEz7zht4P6wIvyfvQYJWxCCjtPb+tBw81e3nOJNQTMqywuZe3cdP62VMlba
 +Rtg==
X-Gm-Message-State: APuU4Z/EAVCFe5TMAMP5Sj1zAmXDZ36JP0iGj8Hz+jqTYqr+HRi44yiF
 iuKS1NnIU0lcmk5VXYh7LdI0d38GMpoYPIllFDKBX5mh9eHc0k+Dt0rTbtqmQhmor/LbhB4M1R4
 Z7jH1BK4jKM+YWrIejQRQ9aHYIwpodYA7H1Xf4TqQqdpZlW+J7DM+V59hovW+hmoLIkAzKXbQqG
 C8wbSxvaGpGL+UuX2JVIppex26PrqZ+no=
X-Gm-Gg: AYBFou0LvqFi0Kppci9ikFI7dNhJCO4fvR7o6FejgBrwO2Q+Gl45z11GX2yVWBAbgZR
 tyOld7OkFv/Mzj7OchbtkFr/HQQ4unxXOKAcRcRaPWgRhtFC5yctX8jisHQpWIsICodOC7O9uqt
 LWHkx93+8LwykaJJgZ6UyyHWpex3XEUZmJAhI3SdRGDb6luwn5FIAjHBLWW2q3zfghcg4SBF96l
 n4e3ESBUa5izUgN3sLJ05c7PtJclTHTT/pZkGllMOZYGNM1ygpHtkkWlJFWA8usHFanc6Skj855
 hQ==
X-Received: by 2002:a17:90a:d887:b0:3a8:6045:5a19 with SMTP id
 98e67ed59e1d1-3ae89777139mr8710474a91.37.1793618434139; 
 Mon, 02 Nov 2026 03:20:34 -0800 (PST)
X-Received: by 2002:a17:90a:d887:b0:3a8:6045:5a19 with SMTP id
 98e67ed59e1d1-3ae89777139mr8710446a91.37.1793618433570; Mon, 02 Nov 2026
 03:20:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-49-armbru@redhat.com>
 <87tslzr2a6.fsf_-_@pond.sub.org>
In-Reply-To: <87tslzr2a6.fsf_-_@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 2 Nov 2026 15:20:21 +0400
X-Gm-Features: AclHuK-BtO_qzBRiLbn9BOqfmzWAU5w1xeM5ctU1f49XomqsKIUbi0VW_3FVGbo
Message-ID: <CAMxuvayLOm-ZUV9ac6ybkXVvW5Ed=ZXN9jv9ZOsUtym6k1XX+w@mail.gmail.com>
Subject: Re: [PATCH v8 48.5/56] hw/ufs: Convert PropertyInfo to QAPITypeInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 stanleyjhu@google.com, jeuk20.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 1:49=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> This gives properties "x-fault-inject-tag" and "x-fault-inject-mode" a
> generated type_info with a valid masked_name, so it appears in
> query-qmp-schema introspection and the qapi-type field of
> qom-list-properties output.
>
> The conversion is trivial for ufs_prop_get_fault_inject_tag.  For
> ufs_prop_get_fault_inject_tag, we need to conver UfsFaultInjectMode to
> a QAPI enum.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Fixup needed for commit c821f2f69f1 (hw/ufs: Add experimental fault
> injection properties for holding requests)
>
>  qapi/common.json | 30 ++++++++++++++++++++++++++++++
>  hw/ufs/ufs.h     | 34 ----------------------------------
>  hw/ufs/ufs.c     | 15 +++------------
>  3 files changed, 33 insertions(+), 46 deletions(-)
>
> diff --git a/qapi/common.json b/qapi/common.json
> index 68b649ecf2..84f12c133a 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -245,3 +245,33 @@
>      'tm_hour': 'int32',
>      'tm_min': 'int32',
>      'tm_sec': 'int32' } }
> +
> +##
> +# @UfsFaultInjectMode:
> +#     Fault injection modes for x-fault-inject-mode property.
> +#     Controls how the held transfer request and subsequent Task
> +#     Management Request (TMR) are resolved by the controller:
> +#
> +# @abort-success: TMR ABORT_TASK aborts the held request, clears its
> +#     state, and returns SUCCESS (COMPL).
> +#
> +# @abort-failed: TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED,
> +#     forcing host driver to escalate to Host Reset.
> +#
> +# @in-transition: TMR QUERY_TASK releases the held request to execute
> +#     normally through the SCSI layer and returns the real task status
> +#     (SUCCEEDED while the command is still in flight); ABORT_TASK
> +#     cancels the held request and returns FUNCTION_COMPLETE.
> +#
> +# @timeout: TMR ABORT_TASK does not complete or clear doorbell,
> +#     triggering hardware-level TMR timeout.
> +#
> +# @ssu-timeout: Intercepts SCSI START_STOP (0x1B) commands targeting
> +#     the UFS Device WLUN when x-fault-inject-tag is armed.
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'UfsFaultInjectMode',
> +  'prefix': 'UFS_FAULT_INJECT',
> +  'data': [ 'abort-success', 'abort-failed', 'in-transition', 'timeout',
> +            'ssu-timeout' ] }
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index 7ddc540546..0014978322 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -90,39 +90,6 @@ typedef struct UfsLu {
>      UfsScsiOp scsi_op;
>  } UfsLu;
>
> -/*
> - * Fault injection modes for x-fault-inject-mode property.
> - * Controls how the held transfer request and subsequent Task Management
> - * Request (TMR) are resolved by the controller:
> - *
> - * UFS_FAULT_INJECT_ABORT_SUCCESS: TMR ABORT_TASK aborts the held reques=
t,
> - *                                 clears its state, and returns SUCCESS
> - *                                 (COMPL).
> - * UFS_FAULT_INJECT_ABORT_FAILED:  TMR ABORT_TASK returns
> - *                                 TASK_MANAGEMENT_FUNC_FAILED, forcing =
host
> - *                                 driver to escalate to Host Reset.
> - * UFS_FAULT_INJECT_IN_TRANSITION: TMR QUERY_TASK releases the held requ=
est to
> - *                                 execute normally through the SCSI lay=
er and
> - *                                 returns the real task status (SUCCEED=
ED while
> - *                                 the command is still in flight);
> - *                                 ABORT_TASK cancels the held request a=
nd
> - *                                 returns FUNCTION_COMPLETE.
> - * UFS_FAULT_INJECT_TIMEOUT:       TMR ABORT_TASK does not complete or c=
lear
> - *                                 doorbell, triggering hardware-level T=
MR
> - *                                 timeout.
> - * UFS_FAULT_INJECT_SSU_TIMEOUT:   Intercepts SCSI START_STOP (0x1B) com=
mands
> - *                                 targeting the UFS Device WLUN when
> - *                                 x-fault-inject-tag is armed.
> - */
> -typedef enum UfsFaultInjectMode {
> -    UFS_FAULT_INJECT_ABORT_SUCCESS =3D 0,
> -    UFS_FAULT_INJECT_ABORT_FAILED,
> -    UFS_FAULT_INJECT_IN_TRANSITION,
> -    UFS_FAULT_INJECT_TIMEOUT,
> -    UFS_FAULT_INJECT_SSU_TIMEOUT,
> -    UFS_FAULT_INJECT_MODE_MAX,
> -} UfsFaultInjectMode;
> -
>  /*
>   * Sentinel values for x-fault-inject-tag property.
>   * Task Tags in UFS are 8-bit (0..255). Values >=3D 256 are reserved as
> @@ -375,6 +342,5 @@ void ufs_unrealize(UfsHc *u);
>
>  extern const PropertyInfo ufs_prop_fault_inject_tag;
>  extern const PropertyInfo ufs_prop_fault_inject_mode;
> -extern const QEnumLookup UfsFaultInjectMode_lookup;
>
>  #endif /* HW_UFS_UFS_H */
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index f8da7c9554..3de67831ea 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -15,6 +15,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-type-infos-common.h"
>  #include "qapi/visitor.h"
>  #include "scsi/constants.h"
>  #include "hw/core/irq.h"
> @@ -3234,17 +3235,6 @@ static void ufs_init_hc(UfsHc *u)
>      ufs_fault_inject_init(u);
>  }
>
> -const QEnumLookup UfsFaultInjectMode_lookup =3D {
> -    .array =3D (const char *const[]) {
> -        [UFS_FAULT_INJECT_ABORT_SUCCESS] =3D "abort-success",
> -        [UFS_FAULT_INJECT_ABORT_FAILED] =3D "abort-failed",
> -        [UFS_FAULT_INJECT_IN_TRANSITION] =3D "in-transition",
> -        [UFS_FAULT_INJECT_TIMEOUT] =3D "timeout",
> -        [UFS_FAULT_INJECT_SSU_TIMEOUT] =3D "ssu-timeout",
> -    },
> -    .size =3D UFS_FAULT_INJECT_MODE_MAX,
> -};
> -
>  static void ufs_prop_get_fault_inject_tag(Object *obj, Visitor *v,
>                                            const char *name, void *opaque=
,
>                                            Error **errp)
> @@ -3300,6 +3290,7 @@ static void ufs_prop_set_default_fault_inject_tag(O=
bjectProperty *op,
>
>  const PropertyInfo ufs_prop_fault_inject_tag =3D {
>      .type =3D "uint32",
> +    .qapi_type =3D &uint32_type_info,
>      .description =3D "Task tag to hold for fault injection",
>      .get =3D ufs_prop_get_fault_inject_tag,
>      .set =3D ufs_prop_set_fault_inject_tag,
> @@ -3309,9 +3300,9 @@ const PropertyInfo ufs_prop_fault_inject_tag =3D {
>
>  const PropertyInfo ufs_prop_fault_inject_mode =3D {
>      .type =3D "UfsFaultInjectMode",
> +    .qapi_type =3D &UfsFaultInjectMode_type_info,
>      .description =3D "Fault injection mode: abort-success, abort-failed,=
 "
>                     "in-transition, timeout, ssu-timeout",
> -    .enum_table =3D &UfsFaultInjectMode_lookup,
>      .get =3D qdev_propinfo_get_enum,
>      .set =3D qdev_propinfo_set_enum,
>      .set_default_value =3D qdev_propinfo_set_default_value_enum,
> --
> 2.55.0
>


