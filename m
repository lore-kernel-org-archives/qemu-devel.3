Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC341091901
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HV8-0002rS-Jk; Thu, 19 Mar 2026 13:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3HV5-0002r8-Rw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3HV2-0004tN-HA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773942573;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uQyBZzCwXDXdpUeXAxqBqXapSeTVDkRFWVG1TMgWj/o=;
 b=BB+aBK/iIZ4k3bm+TTjLCFd/CznTGDRMFR7VkaXFXTCQTxA5V2l3th8JysD64lgq+eq0uM
 M4USDuF5CBd2u/7SWA5wbDK1HlbWQL55IF7H2ynXtYUwWc34XazYlIJAi8Tk27/XWKCr1U
 eEuLxCpuxwGVSy3byQ8+mthLNVvEUTo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-MVPMckdeN5al8DVc57SLcQ-1; Thu,
 19 Mar 2026 13:49:29 -0400
X-MC-Unique: MVPMckdeN5al8DVc57SLcQ-1
X-Mimecast-MFC-AGG-ID: MVPMckdeN5al8DVc57SLcQ_1773942568
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BA1E19560B9; Thu, 19 Mar 2026 17:49:27 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 840861955F21; Thu, 19 Mar 2026 17:49:22 +0000 (UTC)
Date: Thu, 19 Mar 2026 17:49:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
Message-ID: <abw3HqBJqEWiY7GP@redhat.com>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317113840.33017-2-califano.tommaso@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
> With this change it is possible to run a VM with the SEV CPUID active
> adding:
> 
>     -accel tcg \
>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>     -machine memory-encryption=sev0

snip

> diff --git a/qapi/qom.json b/qapi/qom.json
> index c653248f85..35cda819ec 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1057,6 +1057,19 @@
>              '*handle': 'uint32',
>              '*legacy-vm-type': 'OnOffAuto' } }
>  
> +##
> +# @SevEmulatedProperties:
> +#
> +# Properties for sev-emulated objects.
> +# This object functionally emulates AMD SEV hardware via TCG, so
> +# it does not require real hardware to run.
> +#
> +# Since: 10.1.0
> +##
> +{ 'struct': 'SevEmulatedProperties',
> +  'base': 'SevGuestProperties',
> +  'data': {}}

This is deriving 'sev-emulated' from 'sev-guest' which means it
supports all the properties that 'sev-guest' does, which for
the record is:

 sev-guest options:
  dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
  kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
  legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
  session-file=<string>  - guest owners session parameters (encoded with base64)
  sev-device=<string>    - SEV device to use


Of those properties

 * dh-cert-file + session-file are traditionally used
   as a means to transfer the TIK+TEK to the SEV firmware,
   with wrapping to protect them from the hypervisor.

   These can't be used with sev-emulated, as implemented,
   since they require a key derivation  from the PDH, a
   concept which IIUC is not implemented in this series.

   Instead, in a later patch 'tik' and 'tek' properties
   are added to 'sev-emulated', and to pass the TIK+TEK
   in clear text.

 * sev-device + legacy-vm-type - these are only relevant
   to the KVM integration, so not applicable for emulation

 * kernel-hashes - would be relevant if formally emulating
   LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
   not done/used by this series
  

IOW, we're deriving from 'sev-guest' but AFAICT none of
its properties are relevant to the emulation. The
dh-cert-file and session-file could potentially be
relevant if implementing the PDH concept and key
derivation, but that's not done, instead the tik/tek
are passed explicitly.

What is the value we get from this sev-guest -> sev-emulated
inheritance ?  My gut feeling is that this perhaps isn't
the right way to be modelling things unless there's a plan
for future work that would benefit from them.

Another question related to modelling is whether there is
an intention to support SEV-SNP at a later date, would that
imply a sev-snp-emulated object type too ? If so, would it
inherit from sev-emulated or from sev-snp-guest ?

> +
>  ##
>  # @SevSnpGuestProperties:
>  #
> @@ -1241,6 +1254,7 @@
>      { 'name': 'secret_keyring',
>        'if': 'CONFIG_SECRET_KEYRING' },
>      'sev-guest',
> +    'sev-emulated',
>      'sev-snp-guest',
>      'thread-context',
>      's390-pv-guest',
> @@ -1318,6 +1332,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'sev-emulated':               'SevEmulatedProperties',
>        'sev-snp-guest':              'SevSnpGuestProperties',
>        'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 9dde972c11..2502e860e2 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -51,6 +51,7 @@
>  
>  OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
>  OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
> +OBJECT_DECLARE_TYPE(SevEmulatedState, SevCommonStateClass, SEV_EMULATED)
>  OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
>  
>  /* hard code sha256 digest size */
> @@ -177,6 +178,21 @@ struct SevGuestState {
>      OnOffAuto legacy_vm_type;
>  };
>  
> +/**
> + * SevEmulatedState:
> + *
> + * The SevEmulatedState object is used for creating and managing a SEV emulated
> + * guest.
> + *
> + * # $QEMU \
> + *         -object sev-emulated,id=sev0 \
> + *         -machine ...,memory-encryption=sev0
> + */
> +
> +typedef struct SevEmulatedState {
> +    SevGuestState parent_obj;
> +} SevEmulatedState;
> +
>  struct SevSnpGuestState {
>      SevCommonState parent_obj;
>  
> @@ -2936,6 +2952,46 @@ sev_guest_instance_init(Object *obj)
>      sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
>  }
>  
> +static int sev_emulated_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    SevCommonState *sev_common = SEV_COMMON(cgs);
> +
> +    /*
> +     * The cbitpos value will be placed in bit positions 5:0 of the EBX
> +     * register of CPUID 0x8000001F. We need to verify the range as the
> +     * comparison with the host cbitpos is missing.
> +     */
> +    if (sev_common->cbitpos < 32 ||
> +        sev_common->cbitpos > 63) {
> +        error_setg(errp, "%s: cbitpos check failed, requested '%d',"
> +                   "the firmware requires >=32",
> +                   __func__, sev_common->cbitpos);
> +        return -1;
> +    }
> +
> +    /*
> +     * The reduced-phys-bits value will be placed in bit positions 11:6 of
> +     * the EBX register of CPUID 0x8000001F, so verify the supplied value
> +     * is in the range of 1 to 63.
> +     */
> +    if (sev_common->reduced_phys_bits < 1 ||
> +        sev_common->reduced_phys_bits > 63) {
> +        error_setg(errp, "%s: reduced_phys_bits check failed,"
> +                   " it should be in the range of 1 to 63, requested '%d'",
> +                   __func__, sev_common->reduced_phys_bits);
> +        return -1;
> +    }
> +    cgs->ready = true;
> +    return 0;
> +}
> +
> +static void sev_emulated_class_init(ObjectClass *oc, const void *data)
> +{
> +    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> +    /* Override the sev-common method that uses kvm */
> +    klass->kvm_init = sev_emulated_init;
> +}
> +
>  /* guest info specific sev/sev-es */
>  static const TypeInfo sev_guest_info = {
>      .parent = TYPE_SEV_COMMON,
> @@ -2945,6 +3001,14 @@ static const TypeInfo sev_guest_info = {
>      .class_init = sev_guest_class_init,
>  };
>  
> +/* emulated sev */
> +static const TypeInfo sev_emulated_info = {
> +    .parent = TYPE_SEV_GUEST,
> +    .name = TYPE_SEV_EMULATED,
> +    .instance_size = sizeof(SevEmulatedState),
> +    .class_init = sev_emulated_class_init
> +};
> +
>  static void
>  sev_snp_guest_get_policy(Object *obj, Visitor *v, const char *name,
>                           void *opaque, Error **errp)
> @@ -3207,6 +3271,7 @@ static void
>  sev_register_types(void)
>  {
>      type_register_static(&sev_common_info);
> +    type_register_static(&sev_emulated_info);
>      type_register_static(&sev_guest_info);
>      type_register_static(&sev_snp_guest_info);
>  }
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 4358df40e4..839656e2be 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -33,6 +33,7 @@ bool sev_snp_enabled(void);
>  #if !defined(CONFIG_USER_ONLY)
>  
>  #define TYPE_SEV_COMMON "sev-common"
> +#define TYPE_SEV_EMULATED "sev-emulated"
>  #define TYPE_SEV_GUEST "sev-guest"
>  #define TYPE_SEV_SNP_GUEST "sev-snp-guest"
>  
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


