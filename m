Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8612FD75E34
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 19:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFIUM-0003Zy-9c; Sun, 24 Nov 2024 14:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIUK-0003Zl-MM; Sun, 24 Nov 2024 14:41:44 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFIUI-0004gs-Gw; Sun, 24 Nov 2024 14:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=kLm9Tx1ZLfEhgD3tWqT6NWRNq7WrS5u6DJ+Wesj0xV0=; b=oWGCdW7g+nBvovIK4O3n7YGzQs
 UBnGEbm7eopxnYxI9meirPW4DV666AgLFtpfHVEcgSCNfIO9XpxRd2hkDD+TvVveAMKTr6rSjHXJ8
 FawKEtUMgO1Pk6opVph6sOQ5oy5+bgqRNJ2MOvxGOV0SfTwsTI3LSeDyRC4XjgBPLKw/negbY55TZ
 5LsEWmAGeXmia3s65m07HPMZSju0xAYi1C5gL+aqvEmjzK92EfGrupbvYIXWUH0HF7yu11NuHGg4j
 nSAcGBt9xpZ0zIHbWOq8H4JCwFqerg1zOT2Wb8T/HWBvYJzckrDtsgWCe5WDHEkFaH/qNIy6aRT/d
 n9XI4U2tKxoo3Kft6S7eqraaxEPMgroJ8UMZB2i5eshp8xNZhHVFDA/s4a45z6aHNigavG1xIYn5f
 DrpUPhEWHMwDgnjdysOkTbw6AB5PCkBzuVi4Lr3PzQsd9U7qxR9uZNHpH1FbiF8C0AaGMoOcZf8EF
 2UUbdi08xJFEhASIKGVm/xyntgLkHaZnP6J13xIQcAuKfk9Pwwsx3n47P/Jv/x9FHwgJ6krRskyw/
 AvJ66l+or/61ZZnRlQOajV7lLzzc4xRauJ5rFrfOIPZt5YZhkE/mIGbLHvJoqC7FC/QPlgyREGBbF
 diAqfjLQqW4sXLGrlSNEdNOIjuHZXAM0N9FZjqlI8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/6] tests/9p: fix Rreaddir response name
Date: Sun, 24 Nov 2024 20:41:28 +0100
Message-ID: <9520555.eC8q9SBS7J@silver>
In-Reply-To: <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sunday, November 24, 2024 2:34:31 PM CET Christian Schoenebeck wrote:
> All 9p response types are prefixed with an "R", therefore fix
> "READDIR" -> "RREADDIR" in function rmessage_name().
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Fixes: 4829469fd9ff ('tests/virtio-9p: added readdir test')

>  tests/qtest/libqos/virtio-9p-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> index b8adc8d4b9..c61632fcd3 100644
> --- a/tests/qtest/libqos/virtio-9p-client.c
> +++ b/tests/qtest/libqos/virtio-9p-client.c
> @@ -238,7 +238,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
> -        id == P9_RREADDIR ? "READDIR" :
> +        id == P9_RREADDIR ? "RREADDIR" :
>          "<unknown>";
>  }
>  
> 




