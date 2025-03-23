Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7828BC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhkw-0002vP-5e; Mon, 24 Mar 2025 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkS-0002ro-Ps
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkQ-0007V5-C2
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5nCtq4ppJ+qaP279z3fFk6sH0B68+3DMBqxY7qvT6Y=;
 b=cSGcJ7u5vNu7M8ymQAhdFGRNnlAnSiUOtHyV4JW6V5wDDd6HMTiVZJsQu+Why6fykmBIPs
 NPuqL4lYGT+/FA3DCG69/MX0pxoqULWNlS+C7qe4TBHT8EiwxGEdXDhXmuYFbuaBhivleq
 0kumQ1pHC0Utc0Gn3w5+6cMdiT9022k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-RCChjd1PPYid_quwDFeruA-1; Mon,
 24 Mar 2025 09:21:38 -0400
X-MC-Unique: RCChjd1PPYid_quwDFeruA-1
X-Mimecast-MFC-AGG-ID: RCChjd1PPYid_quwDFeruA_1742822497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4886F1800265; Mon, 24 Mar 2025 13:21:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE35F1801756; Mon, 24 Mar 2025 13:21:35 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:28:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL 0/3] loongarch-to-apply queue
Message-ID: <20250323222848.GA41722@fedora>
References: <20250321034521.2425622-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wwKLJSJXkby3E72e"
Content-Disposition: inline
In-Reply-To: <20250321034521.2425622-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--wwKLJSJXkby3E72e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--wwKLJSJXkby3E72e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgix8ACgkQnKSrs4Gr
c8j1sggAuQTPH/NVXFNqK4HX9ETWeYYkvSA6M7WIRhqcglypLZWhFbmjKBA5bjVJ
PfoNf8F4If2Nex92uNsOSCBHwpYTfp7NKb5B/99S1+pQCIOqGeZwSQzLAms9xHiD
G+lBnzPo8I/lYmeie2T3v89cBaicQwni3GUzuhJ1i3VCn/RlCy5xiRJbIRmRWA5Q
jOEDVK7s+nws59FvbOdbtqj/XWXLtK6WR0AnZD+3i2rimZp+2/9xPOvWL8Bj0v49
4iA+ha6dkvA66t/23+P4KWU1tWC94cZZ6fqvxJ2GOvrkoQyr5tiQu5MmmgW6ceMr
AWkrg85wqPj5AojhAiwuz2I9tvdivA==
=MZgj
-----END PGP SIGNATURE-----

--wwKLJSJXkby3E72e--


