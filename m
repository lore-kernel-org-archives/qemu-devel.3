Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E45E73156
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmrxn-00068V-KR; Mon, 02 Feb 2026 06:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmrxm-000680-NQ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:19:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vmrxk-0001Yz-S4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770031162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eccSpPKhQCQDrkAbpiEbzoq0z2Pj66GpHpX9SbrwNYk=;
 b=f5EHUv9dPEDRGlWYLLb9z7QwGmZvr/EFHaGbz2k0DeBZoi4iTvpVzuq7j8OHP8gpW4VUnU
 +UUU/XzNzIiXuxvR0PMtDcrGC99qZ8H/jSXPVbcdO/UM+Jw8qNVEaluasWYN8xlxZ9Tf8g
 /O92PsO1kZJmVq8+zQ0iGWyFxEcAi/Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-r-dwJduFOPuyleA2X4K2RQ-1; Mon,
 02 Feb 2026 06:19:19 -0500
X-MC-Unique: r-dwJduFOPuyleA2X4K2RQ-1
X-Mimecast-MFC-AGG-ID: r-dwJduFOPuyleA2X4K2RQ_1770031157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6AE2195607A; Mon,  2 Feb 2026 11:19:17 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.68])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92158180009E; Mon,  2 Feb 2026 11:19:13 +0000 (UTC)
Date: Mon, 2 Feb 2026 11:19:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, jpcottin@google.com,
 Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Will Hollins <whollins@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] bulk: Stop forward-declaring enum typedefs
Message-ID: <aYCILbNMs18MvRSF@redhat.com>
References: <20260130211746.46667-1-philmd@linaro.org>
 <20260130211746.46667-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130211746.46667-2-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 30, 2026 at 10:17:45PM +0100, Philippe Mathieu-Daudé wrote:
> The C99 standard chapter §6.7.2.2 point 4 mentions:
> 
>   Each enumerated type shall be compatible with char, a signed
>   integer type, or an unsigned integer type. The choice of type
>   is implementation-defined, but shall be capable of representing
>   the values of all the members of the enumeration.
> 
> Align with that recommendation by defining the typedef
> along with the enum.

What am I missing here - that text isn't talking about forward
declarations / typedefs ? It is just saying that the size of
an enum can vary betweeen compilers.


> For information, building with -Werror=pedantic was reporting:
> 
>   In file included from ../../ui/kbd-state.c:10:
>   include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
>      12 | typedef enum QKbdModifier QKbdModifier;
>         |              ^
>   ...

Compliance with -Wpedantic is a non-goal for QEMU. We long ago
declared that our goal was only to support GCC/CLang, with the
GNU dialect of C, explicitly *NOT* strict compliance with ISO C.



> diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
> index 1f37b932eb6..3522ebe51b9 100644
> --- a/include/ui/kbd-state.h
> +++ b/include/ui/kbd-state.h
> @@ -9,9 +9,7 @@
>  
>  #include "qapi/qapi-types-ui.h"
>  
> -typedef enum QKbdModifier QKbdModifier;

Note this style...

> -
> -enum QKbdModifier {
> +typedef enum QKbdModifier {
>      QKBD_MOD_NONE = 0,
>  
>      QKBD_MOD_SHIFT,
> @@ -23,7 +21,7 @@ enum QKbdModifier {
>      QKBD_MOD_CAPSLOCK,
>  
>      QKBD_MOD__MAX
> -};
> +} QKbdModifier;
>  
>  typedef struct QKbdState QKbdState;

...is a match for this style we use with structs, so this patch is forcing
divergence in styles.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


