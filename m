Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C3EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoz5-0001vg-LS; Tue, 10 Feb 2026 09:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpoyw-0001s1-C4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:44:52 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vpoyp-0001pL-0Y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:44:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7521D596A0A;
 Tue, 10 Feb 2026 15:44:41 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 53akYCnGt378; Tue, 10 Feb 2026 15:44:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 36B105969FA; Tue, 10 Feb 2026 15:44:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 30B0D5969F6;
 Tue, 10 Feb 2026 15:44:39 +0100 (CET)
Date: Tue, 10 Feb 2026 15:44:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 07/21] qom/object: introduce user interaction flags
 for properties
In-Reply-To: <20260210032348.987549-8-zhao1.liu@intel.com>
Message-ID: <d5d64a1d-bfac-261b-b9a6-cec6a7aad7d6@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-8-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 10 Feb 2026, Zhao Liu wrote:
> Introduce three new flags to `ObjectPropertyFlags` to better manage
> property interactions with external users (CLI, QMP, HMP):
>
> 1. OBJ_PROP_FLAG_USER_SET:
>   Marks a property as having been modified by an external user.
>
>   This flag is designed to be "sticky": once set, it persists even if
>   the property value is subsequently overwritten by internal logic.
>   It allows the QEMU system to distinguish user intent.
>
>   The advantage of this design is that it is not needed to manually
>   clear the USER_SET flag on every internal write. This simplifies the
>   logic and decouples flag management from the current property setting
>   path (object_property_set()).
>
>   This is chosen over a strict "current origin" approach (where
>   internal writes would clear the flag) for a practical reason: QEMU
>   code often modifies underlying struct fields (which are defined as
>   properties) directly, bypassing the property API entirely. This makes
>   it impossible to "accurately" track whether the *current* value truly
>   comes from the user. Therefore, a sticky "user touched this" flag is
>   the only meaningful and robust solution.
>
> 2. OBJ_PROP_FLAG_DEPRECATED:
>   Marks a property as deprecated.
>
> 3. OBJ_PROP_FLAG_INTERNAL:
>   Marks a property as internal-only, disallowing external user access.
>
> Additionally, update object_property_set_flags() to implement the
> enforcement logic. When a property is flagged with
> OBJ_PROP_FLAG_USER_SET:
> - If the property is also marked OBJ_PROP_FLAG_DEPRECATED, report a
>   warning.
> - If the property is also marked OBJ_PROP_FLAG_INTERNAL, raise an error
>   and stop the operation.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> include/qom/object.h | 24 ++++++++++++++++++++++++
> qom/object.c         | 15 +++++++++++++++
> 2 files changed, 39 insertions(+)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 856b12e7289c..1b77429aa28b 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -109,6 +109,30 @@ typedef enum {
>      * will automatically add a getter and a setter to this property.
>      */
>     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> +    /*
> +     * The property was explicitly set by an external user.
> +     *
> +     * This flag is set whenever the property is modified via external interfaces
> +     * (CLI, QMP, HMP). It allows internal code to distinguish whether the
> +     * property has been modified by the user.
> +     *
> +     * Once set, this flag persists even if the property value is subsequently
> +     * overwritten by internal logic. It is NOT automatically cleared and must
> +     * be explicitly cleared using object_property_clear_flags().
> +     */
> +    OBJ_PROP_FLAG_USER_SET = BIT(2),

As this isn't strictly for user set maybe jusr call it 
OBJ_PROP_FLAG_EXTERNAL? (Can be set by external management application or 
global compat prop in later patches so user set is not quite right name,)

