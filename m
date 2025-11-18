Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAADCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFqW-00027r-E1; Tue, 18 Nov 2025 02:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLFqT-00027R-6E
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLFqR-0003pP-HR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763449781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Toifaw7DXU5ayiQqLRRpc67wqcg5r3HHGX/dvRFWIak=;
 b=GOI2tNKzXI+5wXGjvydYcyBR1MJZEUNyLQXqS+d9W41Imo7MVAtoCjspgL+5DuO5ZtqEth
 lSVmQJkmcpCSEA25ARcG2mwg4/MfZwLLmmHHg2cNZxeoWQAqecUYdi0hueEzErNMcty75G
 YjbwVWSo8L/7KnKfpNmItx7ZFkVAVJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-HDoyw-DJMoOzQgAGK_40Lw-1; Tue,
 18 Nov 2025 02:09:38 -0500
X-MC-Unique: HDoyw-DJMoOzQgAGK_40Lw-1
X-Mimecast-MFC-AGG-ID: HDoyw-DJMoOzQgAGK_40Lw_1763449777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9789A1956089; Tue, 18 Nov 2025 07:09:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.167])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A07195608E; Tue, 18 Nov 2025 07:09:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4A67E18000B2; Tue, 18 Nov 2025 08:09:34 +0100 (CET)
Date: Tue, 18 Nov 2025 08:09:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH-for-10.2] roms: Do not try to build EDK2 for 32-bit ARM
 on Fedora
Message-ID: <vnutsclexonswf5dv2nx5qjp3v2k5gtcpkseqhvojtjbeag2f5@q7i2zxhw5r4z>
References: <20251117140420.62193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117140420.62193-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 17, 2025 at 03:04:20PM +0100, Philippe Mathieu-Daudé wrote:
> With Fedora 27, support for 32-bit ARM hosts was dropped.
> QEMU also stopped building the docker images in commit
> 0054dc8bde4 ("Update lcitool and fedora to 37").

/me fails to see the link to the patch ...

This is about the /guest/ firmware images, and they are
cross-compiled.  And note that you can run 32-bit guests
on 64-bit hosts (if supported by the cpu).

Note that I have no objections to removing the 32-bit edk2
firmware images.  Upstream edk2 is in the process of removing
32-bit support, so that is going to happen sooner or later
anyway (for both arm and ia32).  Also UEFI on 32-bit never
really took off in the first place.

But when doing so do it properly please.  Remove build config
(in edk2-build.config), pre-built binaries, maybe also test
cases, ...

take care,
  Gerd


