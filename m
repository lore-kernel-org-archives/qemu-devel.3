Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B16C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhl0-0002wI-SX; Mon, 24 Mar 2025 09:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhka-0002t2-Rj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkY-0007WZ-28
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M6yvSO49qyolYnDoAGNj30Z0thsCPHDoVnPu7hyB0g=;
 b=FAZ7qNRuPYxnPwqgOkM8K5aL5wdtg3Bi6VPkipGvxp91W+f63xHQatTbJBWitt/4D23vme
 mkQ5P/ESAfqX4WzknijQOm3FAAOAQTpgpcLx/wM78MGRui5j4GVJUY41xRpcWi1O9Q7WH9
 LwMYDWCbLLNrcqqcvXqyK4qidTMPvko=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-P6VZ0hKLOe2JM36zlFSMCQ-1; Mon,
 24 Mar 2025 09:21:49 -0400
X-MC-Unique: P6VZ0hKLOe2JM36zlFSMCQ-1
X-Mimecast-MFC-AGG-ID: P6VZ0hKLOe2JM36zlFSMCQ_1742822507
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF7531801A1A; Mon, 24 Mar 2025 13:21:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91DF618009BC; Mon, 24 Mar 2025 13:21:45 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:29:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Song Gao <gaosong@loongson.cn>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PULL 0/6] Uefi 20250321 patches
Message-ID: <20250323222943.GA41879@fedora>
References: <20250321123604.2126923-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7KWoSPt+NB/SRPX4"
Content-Disposition: inline
In-Reply-To: <20250321123604.2126923-1-kraxel@redhat.com>
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


--7KWoSPt+NB/SRPX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--7KWoSPt+NB/SRPX4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgi1YACgkQnKSrs4Gr
c8iP8Af7B/RWThqLB2Hr+I4uBXysGLMJlLb4xQby+U3HxHZ30sajEVYlFZngzQ5r
vo3CbX7Sa7fjBs/YkYVDAxxk7gt78FQw8X2bpU2fMGZaD+tnfZ6x1nsykkQqmNMl
hp4kSeI4SF17AdT3KA//t3R9XnwLks1ApRWB5XoUOMEItVMs0lm7FGROeH5noZzA
hCNDS7AS5fzG9RuigLipU76wA3ewzGIF1lpHXrt0151liAf6c8OwSA2FWwCNSjHc
9DgQVTsfoeqn7uAHLptaH3NlTNLPG3zBMYM2GbL3Lw7IUBVzC1upCFiAezardh36
IeLr0IsYrY9N/HG/5zEBHgo4xrY2gQ==
=FB1Y
-----END PGP SIGNATURE-----

--7KWoSPt+NB/SRPX4--


