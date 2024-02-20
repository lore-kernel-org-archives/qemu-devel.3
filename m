Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C8C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMdc-0000cP-HB; Tue, 20 Feb 2024 04:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcMda-0000bz-VY
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcMdY-0008De-CL
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 04:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708422123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95NWdqEvDvEHWuhc9yoURC9Wu755Ti4feHyNbe4VG6M=;
 b=ioOYqnGTd7uLmuFHCE8b4VIEpdfKlZSRJAdtzASCsG2gpyKQ6MTQAv/M+BsXsODLErg8qC
 ZJLwjHPokpCeDKGSKDdHpKTM3Qa7FrDnm70tRiUT6airle2KW92kXMXjBoN5kGDlOdTf2d
 5QMxHQd5y0KshUZ3SmSHh85iQyJOstg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-utUi9NOcOAOomUeoXEPwfQ-1; Tue,
 20 Feb 2024 04:42:00 -0500
X-MC-Unique: utUi9NOcOAOomUeoXEPwfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C708D38143B3;
 Tue, 20 Feb 2024 09:41:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A22EC1121312;
 Tue, 20 Feb 2024 09:41:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F5B321E66C8; Tue, 20 Feb 2024 10:41:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org,  qemu-devel@nongnu.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v1 15/21] qapi/ui: correct typos
In-Reply-To: <2b12236539211bfa887364cf7b621586addbb42e.1708419115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Tue, 20 Feb 2024 10:52:22 +0200")
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <2b12236539211bfa887364cf7b621586addbb42e.1708419115.git.manos.pitsidianakis@linaro.org>
Date: Tue, 20 Feb 2024 10:41:58 +0100
Message-ID: <87a5nvcw0p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  qapi/ui.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index b6d7e142b7..1448eaca73 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -63,7 +63,7 @@
>  ##
>  # @SetPasswordOptionsVnc:
>  #
> -# Options for set_password specific to the VNC procotol.
> +# Options for set_password specific to the VNC protocol.
>  #
>  # @display: The id of the display where the password should be
>  #     changed.  Defaults to the first.
> @@ -125,7 +125,7 @@
>  ##
>  # @ExpirePasswordOptionsVnc:
>  #
> -# Options for expire_password specific to the VNC procotol.
> +# Options for expire_password specific to the VNC protocol.
>  #
>  # @display: The id of the display where the expiration should be
>  #     changed.  Defaults to the first.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


