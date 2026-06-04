Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00CFCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV9ZW-0004oL-73; Thu, 04 Jun 2026 11:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV9ZT-0004nC-D1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV9ZQ-0006OK-6I
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780585278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyQOEJb2g40T65xUnj+36nikscngXGiTRSuUgR8V5yA=;
 b=TRIwT6qHZiyOP7dMN/+f9S63Zb91bOmjHUAXc9D/WDRLspIdx3UgRICUfkzdsFpIo8KFyw
 qUvrbWhxbS+RR0Tqbw1aPD5KZSrOQPALMEytFG+5+xMkEqd0+ET5v8hEnppbKYyUHy9M81
 VhwHIFvsAWluKwDet6zES/P0lls0wQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-mSXBIeR0NDymjRaCrAw7ew-1; Thu,
 04 Jun 2026 11:01:16 -0400
X-MC-Unique: mSXBIeR0NDymjRaCrAw7ew-1
X-Mimecast-MFC-AGG-ID: mSXBIeR0NDymjRaCrAw7ew_1780585275
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 334DF193E8B6
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2026 15:01:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA2ED180049F; Thu,  4 Jun 2026 15:01:13 +0000 (UTC)
Date: Thu, 4 Jun 2026 16:01:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v3 16/24] hw/i386/nitro_enclave: add instance finalize
Message-ID: <aiGTNf5iyWnk1OS1@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-16-3f20c3a029a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516-qom-tests-v3-16-3f20c3a029a7@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, May 16, 2026 at 11:59:15AM +0400, Marc-André Lureau wrote:
> Property setter strings (vsock, id, parent_role, parent_id) were
> never freed because nitro_enclave_machine_info had no
> instance_finalize.
> 
> Fixes: f1826463d2e8 ("machine/nitro-enclave: New machine type for AWS Nitro Enclaves")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/i386/nitro_enclave.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
> index a29f0044d0e..1ce9ee3358a 100644
> --- a/hw/i386/nitro_enclave.c
> +++ b/hw/i386/nitro_enclave.c
> @@ -337,11 +337,22 @@ static void nitro_enclave_class_init(ObjectClass *oc, const void *data)
>                                            "Set parent instance identifier");
>  }
>  
> +static void nitro_enclave_machine_finalize(Object *obj)
> +{
> +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
> +
> +    g_free(nems->vsock);
> +    g_free(nems->id);
> +    g_free(nems->parent_role);
> +    g_free(nems->parent_id);
> +}


Beyond these strings, nems->vnsm is initialized from
qdev_new(...) and I'm not seeing what frees that
device.

I presume the qom test at the end only exposed the
string leaks ?


> +
>  static const TypeInfo nitro_enclave_machine_info = {
>      .name          = TYPE_NITRO_ENCLAVE_MACHINE,
>      .parent        = TYPE_MICROVM_MACHINE,
>      .instance_size = sizeof(NitroEnclaveMachineState),
>      .instance_init = nitro_enclave_machine_initfn,
> +    .instance_finalize = nitro_enclave_machine_finalize,
>      .class_size    = sizeof(NitroEnclaveMachineClass),
>      .class_init    = nitro_enclave_class_init,
>  };
> 
> -- 
> 2.54.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


