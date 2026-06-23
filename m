Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5018ECDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1sP-0007Ke-1q; Tue, 23 Jun 2026 10:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wc1sN-0007KT-Vd
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:13:20 -0400
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wc1sM-0004Z0-0k
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 10:13:19 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F32697A011F;
 Tue, 23 Jun 2026 10:13:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Tue, 23 Jun 2026 10:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1782223994; x=1782310394; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p
 0gRn5cEe2Wc=; b=VJ2PPdebhQFLA2N2Iqe5LpaTzrGTd5WkUtt5Dx4cNs4ixHFt
 2dHFdlGQmxz1AyO1OjhFrpJOpn8OvkfhicPvLamcb+299mrJx7LxP7rorSi930hn
 SFMcMu1bv5ed+XMN9A38aU+WU8eArrRpjlM8Xooz7bS3OSHt84JICxalKboBVNdg
 OIrLE4nk2RKDVIxFGW93KwHPXWvdkBCsQAZBh+uM1huOpt9FZqpfj/VK7yrjbWdV
 x/xFxjWccHqsRf+MLR2nrCZ/svaUBnehRTFu09KHWDQLrSl/J19Rj2Dg9c88FZ2A
 MKj0pfnGCkNrr73/+P3Yl+IvakZ+V38naL2j0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782223994; x=
 1782310394; bh=X4vr3y5P7uxElxeresXU7PPjABdWVi5p0gRn5cEe2Wc=; b=U
 0VzogcvhPlvSYmgonoJD7lu2qsrhYBLlKdE+JKXt0smFw9aSeE7zkL1cBGUIadtl
 mhWpCast7q9xvqmBV3V/CbnVla0YYGr2WC6JFRownG3DAgFDj+ZY5Kxc7r5KHD8v
 naMXJNIcunhYLJQ6/Lmirn/4tkDY6iXKONF40DeUss4YesbZ2UAp3+IdV8W/NoNZ
 foO7Zz8vkblV6w48lSpFkTz58dXvt5Iembhasn3VGjdNwis27ay2og3ceLBxI98x
 Gq7EUwri0T3kbvJPth2LlHCEY4XgO2c8g55CXVZlJ29Hx2LAjUIdzFyhhauvwUkZ
 EqYEw4TyLb9LtUDsuu2Ew==
X-ME-Sender: <xms:epQ6akn01KNcqSxIcolTJOBqDXJR2ymLKzcYjEVGdEcmA7j9DQpgkg>
 <xme:epQ6aqt_nrEv0nPER3L6-BGNyxMEOKpmt34yDt1JjvS7BFcW8W57wV_f8LkOTi1Cu
 ad6Nm7ghQtx4ZNPWQm41IfQR7RLoDBdNcF6v2cOf2RxBS2aeh7foVg>
X-ME-Received: <xmr:epQ6aq-Q5qWqxWXztkZL4NLRuDPoxR5r2SZk-WP7uMnYsCVlKmBRvm55p_s>
X-ME-Proxy-Cause: dmFkZTFutI53BvieSVO4DfDWAcEI8MJJ4HTWVWHuz2EnRu7XRNZe/elAb4qc3JJ13dhQqO
 ZJixaevoqRgfZJ1rPDAsgB6LeGnG8VvA/BDtqAy3uMw5NI1Wzo+HHtSNyoulkL4zgUqtlA
 eZbkJ69pYfkNdkM5ObdeRUANC2hI6sy8uXmpdima+TrhroJZRBHBvQnYOfL9K44DgJsLoJ
 npjxRe7jzX99+PgeoiTE9DcZJGpXfDZKdKFZc9L9p6LLrduVoGhXC0wwfhqCUPWgtW9Spz
 CRX/FjXPPrUa6OA1UHfloS6PBarksxNkIn3E1tVd9Zuo/V+nTdb7S3KpFOLep8KKMCLkY9
 rjlzLdgYBHEkKpCrOSoRDftgyGFV8s1ISJFxQtgLJ9fjx2qZo/9KKfne7AgzagcNjPhRmM
 rpN1vXPuO7vnihekQirKcSmFnTpXR10OxGauEpTKL4NzDIinZx4Dg9thGoVayO1+kvp2ho
 hGfba8iY0jqkpDcI6vTTZD6VAJinDf+djijGWmZr02TeYWqb1HMkYWsBIX4EYOwIaSwumw
 5QfVFVyE9XahvhMuq9qVCBaFl43OzHFZ5uSkiTJ42nkl7ID2mWZASbxSKq43Jv3pDmSr/z
 +uVIA1Qa3X+VExLiilpT5rDbExOKIp6sInvbS/jsHXhU+FWyKJx8Tkz9vQtw
X-ME-Proxy: <xmx:epQ6asP-HXLa36Vf8nNRdvltEgZcwnAMpAp3dSj4tCVySCMr6l_DmA>
 <xmx:epQ6agFogrSrU0wGMVojnIUoZimVlm3dQ89oUm_grqXBhTBkFstNUg>
 <xmx:epQ6aiSI38eo4YeGJopJWJ4CbJHXuxtf04rqXhkyO11SgwaPixhTJA>
 <xmx:epQ6aluX5v1pYdUcWvFdHAHCPTeHrP4OkCIs9wFCEK0Kf5d-tbYhNw>
 <xmx:epQ6anKMopviK-_GQ6e2_Fr_LzFnyUNw0FSW4SQeOn7NHUPlD_yFn1rR>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 10:13:13 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8eba9730;
 Tue, 23 Jun 2026 14:13:12 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 10:13:12 -0400
Message-Id: <DJGHOFFA4GHN.37WEW8UUAE0LQ@jablonski.xyz>
Cc: "Gerd Hoffmann" <kraxel@redhat.com>, <marcandre.lureau@redhat.com>,
 "Chad Jablonski" <chad@jablonski.xyz>
Subject: Re: [PATCH] ati-vga: Include vga state in the blit context
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260619140408.6CF98596948@zero.eik.bme.hu>
In-Reply-To: <20260619140408.6CF98596948@zero.eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Chad Jablonski <chad@jablonski.xyz>

