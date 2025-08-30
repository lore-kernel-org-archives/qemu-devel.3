Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D7DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUVI-0001sI-Ew; Sat, 30 Aug 2025 18:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUVG-0001rO-Im; Sat, 30 Aug 2025 18:56:58 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUVE-0004Nq-EU; Sat, 30 Aug 2025 18:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=NUh6bO8L0LYDQR9o9qVeYCHHW269TxHhGS6wdWMt4Ow=; b=gorBBJXyVvHbXmmZ
 1RIZef+3yJ1CkSGY/CiigIWhnNZpyRczBvjyR/m44BCsJa+4XhnfddGUsVkowvLWbrkgKz1XdP+ao
 JgZnz2G67XCevmT8+OzkF5QHu3mhgTqz7WhiP3cfyiDHTEYH+vJZOdI9rbVqU8IaNFycBgISR6Fnc
 z3T0G4ItH+lqxs6UPYnrBYcWLcBzR0J/EhB4uL2AeZISVMZJZ1TGkdUelxjow15vpkf5RCr55UCj8
 fE0gwlTczdOi2bVDLuU4sJT+cfTwJtALaESrdHTtSY+hG8z/3M1or5NFlvf6mw/zm1GTVHMcWqV1f
 Za31i/CbRAGdk/S40g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1usUV8-007aU9-2r;
 Sat, 30 Aug 2025 22:56:50 +0000
Date: Sat, 30 Aug 2025 22:56:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 01/14] include: define constant for early constructor
 priority
Message-ID: <aLOBsnccBvRWWI1V@gallifrey>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829180354.2922145-2-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 22:56:44 up 125 days,  7:10,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> Functions marked with __attribute__((__constructor__)) will be
> invoked in linker order. In theory this is well defined, but
> in practice, it is hard to determine what this order will be
> with the layers of indirection through meson, ninja and the
> static libraries QEMU builds.
> 
> Notably, the order currently appears different between Linux
> and Windows (as tested with Wine on Linux). This can cause
> problems when certain QEMU constructors have a dependancy on
> other QEMU constructors.
> 
> To address this define a QEMU_CONSTRUCTOR_EARLY constant which
> provides a priority value that will run before other default
> constructors. This is to be used for QEMU constructors that
> are themselves self-contained, but may be relied upon by other
> constructors.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1c2b673c05..4c49f52eb0 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -194,6 +194,14 @@
>  # define QEMU_USED
>  #endif
>  
> +/*
> + * A priority for __attribute__((constructor(...))) that
> + * will run earlier than the default constructors. Must
> + * only be used for functions that have no dependency
> + * on global initialization of other QEMU subsystems.
> + */
> +#define QEMU_CONSTRUCTOR_EARLY 101
> +
>  /*
>   * Disable -ftrivial-auto-var-init on a local variable.
>   *
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

