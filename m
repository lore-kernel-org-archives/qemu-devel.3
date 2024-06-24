Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CCCC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLin0-0001R1-Ho; Mon, 24 Jun 2024 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLimz-0001QX-2t
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLimx-0002ib-8I
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719232033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TWK+sfwtHYlg1TGDTvMfWnHFSmraa886QsMrQY+oCU=;
 b=cA+ZwrAjh7gmwMdP9ydGz0NBpHrnM4vnk1icV0F9oK/ybQo01G1/2ujvpzjiJ20gKZ/17r
 GAdg63AmIRX3fDNr8ODrONrjxAkIPsSSpTXA+Mt1HApXcEjAAsMJpfVM5Y8iL4F+QFoCJk
 A17ysH7k3naivSvqApF0wAumoHUbvOo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-1i5udWVHN-GQOARtFFsDhQ-1; Mon, 24 Jun 2024 08:27:09 -0400
X-MC-Unique: 1i5udWVHN-GQOARtFFsDhQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52cdbc21fa2so1701690e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 05:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719232028; x=1719836828;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2TWK+sfwtHYlg1TGDTvMfWnHFSmraa886QsMrQY+oCU=;
 b=vhlsOMeN7OMhn2H30pmcMn87DoRWx2K0sajf2dCF1vMPDbpRnvvhpEznLAXcEdy1ur
 orIvZ63ZRueNOpQnj9RucI+nlQGYyXF+/Xl+mUCPy9FZfIlljPg7/Akz9h0yK7z+mivj
 3RZiLC9coVecLNY6ErGyYB5KcSi7cf9Sv7IRHmM4+RtgWeZdN2qyocV4Oqpa/FmGFXRf
 CfI8gHV4k0Rx/11xHpB3A7kX/gP7O/r3d85kGJH4ORA4fGQ8Dquc1Y+OSQg2lCi/n+3U
 8YsCd8yMgxcOyTeVNcvtiOyG6C3oY+8zBKeP01rDOo8FWGnjk0YiMp/iGUSk33EyLY6q
 U9Zg==
X-Gm-Message-State: AOJu0YyQ4czbpvqlC/V8ErCBzSgToVcwlWgKRlHrTXOFNIzVuuh5jNg5
 MpxBm/0KxzffS2rZr77Ea/Ty2rFIVUibZjyKPfuFEUSB5LNqrTmUwio/9iHpCSsOZVjh97toHCN
 2waqhoFWkz7tyFEE/IwhMbGoTdR/6UWZjknwzjbjbFms7pJbvEXc3
X-Received: by 2002:ac2:5ded:0:b0:52c:dac0:59f8 with SMTP id
 2adb3069b0e04-52ce185fb12mr2622557e87.53.1719232027862; 
 Mon, 24 Jun 2024 05:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGypNezLYvbgrPRJVO8xMHU9PQhPBSJ/O+uOgMOiAgMLLFOYLeIE4z87cK0nU4upF/BOyuLkA==
X-Received: by 2002:ac2:5ded:0:b0:52c:dac0:59f8 with SMTP id
 2adb3069b0e04-52ce185fb12mr2622542e87.53.1719232027066; 
 Mon, 24 Jun 2024 05:27:07 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366bd575f6asm9284881f8f.6.2024.06.24.05.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 05:27:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:27:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386: revert defaults to 'legacy-vm-type=true' for
 SEV(-ES) guests
Message-ID: <20240624080458-mutt-send-email-mst@kernel.org>
References: <20240614103924.1420121-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614103924.1420121-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 14, 2024 at 11:39:24AM +0100, Daniel P. Berrangé wrote:
> The KVM_SEV_INIT2 ioctl was only introduced in Linux 6.10, which will
> only have been released for a bit over a month when QEMU 9.1 is
> released.
> 
> The SEV(-ES) support in QEMU has been present since 2.12 dating back
> to 2018. With this in mind, the overwhealming majority of users of
> SEV(-ES) are unlikely to be running Linux >= 6.10, any time in the
> forseeable future.
> 
> IOW, defaulting new QEMU to 'legacy-vm-type=false' means latest QEMU
> machine types will be broken out of the box for most SEV(-ES) users.
> Even if the kernel is new enough, it also affects the guest measurement,
> which means that their existing tools for validating measurements will
> also be broken by the new default.
> 
> This is not a sensible default choice at this point in time. Revert to
> the historical behaviour which is compatible with what most users are
> currently running.
> 
> This can be re-evaluated a few years down the line, though it is more
> likely that all attention will be on SEV-SNP by this time. Distro
> vendors may still choose to change this default downstream to align
> with their new major releases where they can guarantee the kernel
> will always provide the required functionality.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

This makes sense superficially, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and I'll let kvm maintainers merge this.

However I wonder, wouldn't it be better to refactor this:

    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
        cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
        
        ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
    } else {
        struct kvm_sev_init args = { 0 };
                
        ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
    }   

to something like:

if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) != KVM_X86_DEFAULT_VM) {
        struct kvm_sev_init args = { 0 };
                
        ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
	if (ret && errno == ENOTTY) {
		cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;

		ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
	}
}


Yes I realize this means measurement will then depend on the host
but it seems nicer than failing guest start, no?




> ---
>  hw/i386/pc.c      |  1 -
>  qapi/qom.json     | 12 ++++++------
>  target/i386/sev.c |  7 +++++++
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0469af00a7..b65843c559 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -82,7 +82,6 @@
>  GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
> -    { "sev-guest", "legacy-vm-type", "true" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..714ebeec8b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -912,12 +912,12 @@
>  # @handle: SEV firmware handle (default: 0)
>  #
>  # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
> -#                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
> -#                  state when initializing the VMSA structures, which will
> -#                  result in a different guest measurement. Set this to
> -#                  maintain compatibility with older QEMU or kernel versions
> -#                  that rely on legacy KVM_SEV_INIT behavior.
> -#                  (default: false) (since 9.1)
> +#                  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10, syncs
> +#                  additional vCPU state when initializing the VMSA structures,
> +#                  which will result in a different guest measurement. Toggle
> +#                  this to control compatibility with older QEMU or kernel
> +#                  versions that rely on legacy KVM_SEV_INIT behavior.
> +#                  (default: true) (since 9.1)
>  #
>  # Since: 2.12
>  ##
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 004c667ac1..16029282b7 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2086,6 +2086,13 @@ sev_guest_instance_init(Object *obj)
>      object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
>                                     OBJ_PROP_FLAG_READWRITE);
>      object_apply_compat_props(obj);
> +
> +    /*
> +     * KVM_SEV_INIT2 was only introduced in Linux 6.10. Avoid
> +     * breaking existing users of SEV, since the overwhealming
> +     * majority won't have a new enough kernel for a long time
> +     */
> +    sev_guest->legacy_vm_type = true;
>  }
>  
>  /* guest info specific sev/sev-es */
> -- 
> 2.45.1


