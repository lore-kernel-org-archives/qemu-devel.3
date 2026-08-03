Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F0C5516F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 04:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqkan-00070N-0D; Mon, 03 Aug 2026 00:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wqkam-000709-2w
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 00:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wqkak-0007gi-QG
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 00:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785732478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euXNk0ql96+RgQveB0Xy9OBkuMxpFqAoD1h8RqMtTJQ=;
 b=anK301+Xxx6LhaJsTSjddrAWYmlg6NCg91wLKlMBM/hMuur2HeD8VYD1jimYxiUYRqRlfj
 emwQg7T9CprP5dLPQEE3tx861jOUth1XF9KfvWPC42G2P8HvpnSNESWkWHCs5C8cG7JN6e
 EeXgZXrn72fdIOsJp2e1vr865YuqriM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-FsmEksXkOMuQxlhGahNPvQ-1; Mon,
 03 Aug 2026 00:47:48 -0400
X-MC-Unique: FsmEksXkOMuQxlhGahNPvQ-1
X-Mimecast-MFC-AGG-ID: FsmEksXkOMuQxlhGahNPvQ_1785732467
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C731956089; Mon,  3 Aug 2026 04:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E7141C; Mon,  3 Aug 2026 04:47:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FF7C21E6920; Mon, 03 Aug 2026 06:47:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
In-Reply-To: <20260730081325.1816193-2-den@openvz.org> (Denis V. Lunev's
 message of "Thu, 30 Jul 2026 10:13:17 +0200")
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
Date: Mon, 03 Aug 2026 06:47:44 +0200
Message-ID: <87ecgfajyn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

"Denis V. Lunev" <den@openvz.org> writes:

> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..4628793dde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>=20=20
>  IDE
>  M: John Snow <jsnow@redhat.com>
> +M: Denis V. Lunev <den@openvz.org>
>  L: qemu-block@nongnu.org
>  S: Odd Fixes
>  F: include/hw/ide/

Was this patch ever posted to the list?  I can't find it in the
archive...


