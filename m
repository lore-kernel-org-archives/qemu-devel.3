Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CDFD5B154
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 21:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5X7X-00041C-Kv; Mon, 28 Oct 2024 17:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t5X7V-00040n-9Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1t5X7T-0004vW-5J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 17:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730150265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9yXQx6CUSGYQAyHhPOLAki9LUCVSXELr2t2+lTGyyk=;
 b=Cl0wYMzsEz3aNwOpCS2Tg/yL8AYkwLXAiBDKrw4QUcVL87pD7gxyeDOoBemQifu3Zv4xrC
 S5Rov8Too83TkpWaVNS5KhRbAMyiEJ6x38ip0xAISOI3TK8SR38/zKM9heOWeidQ1i8iIM
 FskXvrcM8zfYtnpXkCZY+5aF1p91d6E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Pe_AsnNgMnuLHkrU2oYL-g-1; Mon,
 28 Oct 2024 17:17:42 -0400
X-MC-Unique: Pe_AsnNgMnuLHkrU2oYL-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA93195608B; Mon, 28 Oct 2024 21:17:39 +0000 (UTC)
Received: from pinwheel (unknown [10.39.208.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D291319560A2; Mon, 28 Oct 2024 21:17:29 +0000 (UTC)
Date: Mon, 28 Oct 2024 22:17:26 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Message-ID: <Zx__Zi3Zpg1AspnE@pinwheel>
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025101959.601048-22-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
> From: Cornelia Huck <cohuck@redhat.com>
> 
> Add some documentation for the custom model.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index a5fb929243..962a2c6c26 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -2,7 +2,10 @@ Arm CPU Features

[...]

> +Using the ``host`` type means the guest is provided all the same CPU
> +features as the host CPU type has.  And, for this reason, the ``host``
> +CPU type should enable all CPU features that the host has by default.
> +
> +In case some features need to be hidden to the guest, ``custom`` model
> +shall be used instead. This is especially useful for migration purpose.
> +
> +The ``custom`` CPU model generally is the better choice if you want more
> +flexibility or stability across different machines or with different kernel
> +versions. 

Does "more flexibility or stability across different machines" also
imply "live migration compatiblity across host CPUs"?

> However, even the ``custom`` CPU model will not allow configuring
> +an arbitrary set of features; the ID registers must describe a subset of the
> +host's features, and all differences to the host's configuration must actually
> +be supported by the kernel to be deconfigured.

[...]

> +The ``custom`` CPU model needs to be configured via individual ID register
> +field properties, for example::
> +
> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0

If possible, it would be really helpful (and user-friendly) to be able
to specify the CPU feature names as you see under /proc/cpuinfo, and be
able to turn the flags on or off:
    
        -M virt -cpu franken,rndr=on,ts=on,fhm=off

(... instead of specifying long system register IDs that groups together
a bunch of CPU features.  If I understand it correctly, the register
"ID_AA64ISAR0_EL1" maps to a set of visible features listed here:
https://docs.kernel.org/arch/arm64/cpu-feature-registers.html)


Next, I prefix the below by noting that I wrote it before seeing
Cornelia's reply that the name "custom" is not set in stone:
https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00987.html.

I wonder if the word "custom" is starting to get overloaded; on x86:

  - Libvirt itself uses the term "custom" this way, to quote its
    documentation[1] for the 'custom' XML attribute:

      custom
    
      In this mode, the 'cpu' element describes the CPU that should be
      presented to the guest. This is the default when no 'mode'
      attribute is specified. This mode makes it so that a persistent
      guest will see the same hardware no matter what host the guest is
      booted on.

  - Some management tools also follow libvirt and use the term "custom"
    to refer to one of two things, (a) a specific named CPU model that
    libvirt and QEMU recognize, e.g. "Cascadelake-Server"; or (b) a
    named CPU model + extra CPU flags, e.g. this is how OpenStack
    uses[2] "custom" to configure CPU models, and flags that can be
    enabled or disabled via "+" or "-":

      [libvirt]
      cpu_mode = custom
      cpu_model = IvyBridge-IBRS
      cpu_model_extra_flags="ss,+vmx,-pcid [...]"

    (Note the "cpu_mode" there: it is referring to the three possible
    modes that libvirt and QEMU support today: 'host-passthrough',
    'host-model', and named CPU models via "custom".)

    The above config translates to this QEMU command-line:

        -cpu IvyBridge-IBRS,ss=on,vmx=on,pcid=off [...]

Now if QEMU introduces "custom", it is likely to create some confusion.
But luckily, as referenced above, it is open to change. :)

    * * *

FWIW, I agree with Dan here[3] that it would cause less future pain if
Arm's named CPU models also decides on a "baseline that matches some
corresponding real world silicon".  I've experienced plenty of such
debugging pain in x86-land from years of troubleshooting live migration
bugs involving CPU model (in)compatibility.  (Often, with help from
DanPB and Jiri Denemark).

[1] https://docs.openstack.org/nova/latest/admin/cpu-models.html#cpu-modes
[2] https://libvirt.org/formatdomain.html#cpu-model-and-topology
[3] https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00888.html
    — [RFC 21/21] arm/cpu-features: Document custom vcpu model

[...]

-- 
/kashyap


