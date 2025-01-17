Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657F9C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkT4-00071r-PN; Fri, 17 Jan 2025 06:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYkT2-00071g-Rl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYkSz-0003Xl-Vi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737113084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vM9WhxgvuYwcMhLCch7HdF1mcoSgklVIalTHV1MYKU=;
 b=YBUzyxKpJUglED+imq2eQNYM58+3WKV8odADYv3pRt4QE45PRnuayzxFcu5cytESTQVqVD
 pEGxGuMk8IRqnhkTeLs5h/5xklb8Hku5cegWr9Xm6XF/9YEGaobYUpF0sKH6k568MReHej
 ycjsgXuVSM49NiGKR24m0th2S5Fqw54=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-tAqiejv6OSOPCZbdk-cgBw-1; Fri,
 17 Jan 2025 06:24:40 -0500
X-MC-Unique: tAqiejv6OSOPCZbdk-cgBw-1
X-Mimecast-MFC-AGG-ID: tAqiejv6OSOPCZbdk-cgBw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 395671956056; Fri, 17 Jan 2025 11:24:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.176])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5ACCF195608A; Fri, 17 Jan 2025 11:24:34 +0000 (UTC)
Date: Fri, 17 Jan 2025 12:24:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, armbru@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2] qemu/compiler: Absorb 'clang-tsa.h'
Message-ID: <Z4o9738w_9vNjVal@redhat.com>
References: <20250116211111.53961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116211111.53961-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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

Am 16.01.2025 um 22:11 hat Philippe Mathieu-Daudé geschrieben:
> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity,
> let the common "qemu/compiler.h" deal with that by having it
> include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
> Add a check to not include "qemu/clang-tsa.h.inc" directly,
> remove previous "qemu/clang-tsa.h" inclusions.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Don't we normally try to reduce the number of header files that need to
be opened during the build instead of increasing it?

Either way, if we do want to do this, the implementation looks correct.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


