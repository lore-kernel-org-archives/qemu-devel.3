Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C9CD5BA8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm9zk-0004qh-BG; Thu, 05 Sep 2024 06:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sm9zi-0004nF-Lf
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sm9zh-0002z6-1y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725533138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GVQgQXQd/MGbPcK6zLvM1PFE6E4vu2DtG5Zece/4l+c=;
 b=cEIlNajwZ3TW7EdMK1viitOj6IXZvajz+aiDg/OmpBXzGdICnSJ23mVTvvMihbUh7XB2aA
 VpYKZecME1d4ZbGV1+VVCb4njoSY4uN0QpiMCivcGFDDVMOgx1N9YKEKejQSsnlJ7x4k7E
 SEndcTrR6SsazlyCWbsO+685LAC4QlE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Pb9J2GIJPtOh2iJ5kCMV5w-1; Thu,
 05 Sep 2024 06:45:36 -0400
X-MC-Unique: Pb9J2GIJPtOh2iJ5kCMV5w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25FE195604F; Thu,  5 Sep 2024 10:45:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 393663000236; Thu,  5 Sep 2024 10:45:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C68621E6A28; Thu,  5 Sep 2024 12:45:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: eblake@redhat.com,  qemu-devel@nongnu.org,  arei.gonglei@huawei.com
Subject: Re: [PATCH] qapi: Document QCryptodevBackendServiceType
In-Reply-To: <20240812014252.1398754-1-pizhenwei@bytedance.com> (zhenwei pi's
 message of "Mon, 12 Aug 2024 09:42:52 +0800")
References: <20240812014252.1398754-1-pizhenwei@bytedance.com>
Date: Thu, 05 Sep 2024 12:45:31 +0200
Message-ID: <87y1462xbo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

zhenwei pi <pizhenwei@bytedance.com> writes:

> QCryptodevBackendServiceType was introduced by
> bc304a6442e (cryptodev: Introduce server type in QAPI). However there
> is a lack of member description. Thanks to Markus for pointing out
> this.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  qapi/cryptodev.json | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
> index 68289f4984..9622c6d92b 100644
> --- a/qapi/cryptodev.json
> +++ b/qapi/cryptodev.json
> @@ -28,6 +28,16 @@
>  #
>  # The supported service types of a crypto device.
>  #
> +# @cipher: Symmetric Key Cipher service
> +#
> +# @hash: Hash service
> +#
> +# @mac: Message Authentication Codes service
> +#
> +# @aead: Authenticated Encryption with Associated Data service
> +#
> +# @akcipher: Asymmetric Key Cipher service
> +#
>  # Since: 8.0
>  ##
>  { 'enum': 'QCryptodevBackendServiceType',

Missing: removal of QCryptodevBackendServiceType from pragma
documentation-exceptions.  Happy to do that in my tree.

Apart from that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


