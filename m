Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTRN-0005Q7-9t; Tue, 05 Mar 2024 06:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhTR3-0005Hm-Gc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:58:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhTR1-0006kD-IP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709639894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKwhmBuTWb1mos2F+eLZ6xOv4/u4fxphsdrliS55SgA=;
 b=Onpk/c0nLm2miyyeihlUwZkS/dCqYV1AF4MxHg34mCrpQW9X5i0Q4ZYRhodjtrBwlPdL9d
 7jN3dYqCOm8RK3Ss/AdplGbPdma39p/1Z4l9OzHRIHD9Sy0t4puhbDLQQWGQBAp5Uy+OgI
 xoVBwbvNWWGANiFrB/Ir5uo7RRnFrno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Kx_79SudM5WnC6aQHhlHoQ-1; Tue, 05 Mar 2024 06:58:11 -0500
X-MC-Unique: Kx_79SudM5WnC6aQHhlHoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3797800268;
 Tue,  5 Mar 2024 11:58:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE36C8173;
 Tue,  5 Mar 2024 11:58:08 +0000 (UTC)
Date: Tue, 5 Mar 2024 11:58:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
Message-ID: <ZecIzqmNouZZBrbv@redhat.com>
References: <20240223161300.938542-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 23, 2024 at 04:13:00PM +0000, Peter Maydell wrote:
> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
> 
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Before we can commit this to either head-of-git or any stable branch,
> we need a Signed-off-by: from everybody who's touched this file (or,
> for corporate contributions, from somebody from the relevant company
> who can confirm that the company is OK with the licensing, which is
> RedHat and Linaro in this case).
> 
> The full list of people who've made changes to the file is:
>  Artyom Tarasenko <atar4qemu@gmail.com>
>  Philippe Mathieu-Daudé <philmd@linaro.org>

NB mailmap translations - the commit was philmd@redhat.com originally

>  Markus Armbruster <armbru@redhat.com>
>  Eduardo Habkost <ehabkost@redhat.com>

On behalf of Red Hat, I can confirm that any contributions to
this file where Red Hat would hold copyright are acceptable
to relicense to GPL-v2-or-later.

  Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


