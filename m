Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E4FC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbph-0000ZZ-22; Mon, 27 May 2024 11:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sBbpV-0000Wl-MG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sBbpT-0005P7-Tc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716822002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vadyJIoJufm/rqVegbv2k4Opl0RJ8p+aHZqWl4uw1sA=;
 b=SznE1x9Ei5mwH13JzVP8cJcGHLu6yR2Sv9iQzS92Kr1Zev0Q7fKL8LEGMI4uIGlsRKLT6t
 va7jBHtDRH/lYYluUs/SNZ57/NOcT84Pw/FCq/xH9rSZTCpS2pUtDCJ+MHRK+8LmWd9Qw1
 y2tCVfjs2s+MrSVhwKFKGHRRk48jMxI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-LqLGTqYDPeiZ4yBFO-IMMA-1; Mon,
 27 May 2024 10:58:33 -0400
X-MC-Unique: LqLGTqYDPeiZ4yBFO-IMMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E31C1C05138;
 Mon, 27 May 2024 14:58:33 +0000 (UTC)
Received: from localhost (unknown [10.22.8.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C87340004D;
 Mon, 27 May 2024 14:58:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Fix the path of
 setup_data.h
In-Reply-To: <20240527060126.12578-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240527060126.12578-1-thuth@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 27 May 2024 16:58:31 +0200
Message-ID: <874jajpai0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 27 2024, Thomas Huth <thuth@redhat.com> wrote:

> When running the update-linx-headers.sh script, it currently fails with:
>
> scripts/update-linux-headers.sh: line 73: .../qemu/standard-headers/asm-x86/setup_data.h: No such file or directory
>
> The "include" folder is obviously missing here - no clue how this could
> have worked before?

Presumably nobody tried to run the script against a 6.9-ish kernel?

>
> Fixes: 66210a1a30 ("scripts/update-linux-headers: Add setup_data.h to import list")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index fbf7e119bc..23afe8c08a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -159,7 +159,7 @@ for arch in $ARCHLIST; do
>          cp_portable "$hdrdir/bootparam.h" \
>                      "$output/include/standard-headers/asm-$arch"
>          cp_portable "$hdrdir/include/asm/setup_data.h" \
> -                    "$output/standard-headers/asm-x86"
> +                    "$output/include/standard-headers/asm-x86"
>      fi
>      if [ $arch = riscv ]; then
>          cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


