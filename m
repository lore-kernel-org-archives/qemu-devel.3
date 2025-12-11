Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAE2D3E783
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 02:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTWVB-0005Ow-BO; Wed, 10 Dec 2025 21:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vTWV8-0005Og-Px
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:33:55 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vTWV7-0008WO-Bs
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:33:54 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id C3EB6EC0579;
 Wed, 10 Dec 2025 21:33:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 21:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1765420429; x=1765506829; bh=yE3+Lin4w5tWHByjjvRIvs02gGLrx+GT
 53OovcMawIo=; b=xwyn+g6txUNt0DGiTe4fciGz4549VCIYlCPqYkIekWYIwpHJ
 OEYttivLx5DqwC1f0Bp1HO45MaHt5TwW99G35TOzIu+rk/W/O19DYosNnTGCWmv6
 TP9GLWr4wdotFDdH7TdDfzf+cJw86k6cVmS1isV3xCinK1FPAAlRGd/Va3zJb2K3
 9OjUtn9L6qu9zAzxWvWdGr5Vm2zd6Zoa9Nm7LwK5UDX0iGUFwqbrehBn/9gbf3pB
 BU+Y3sLF4oJp3NklSOGVyAvPhqClWaB0x8kJPhTVPeAJt0D/tH6VYqM13lCc4WQV
 d18aKJVeOfD8ajGXBkJ7KeSHQL8UEFlevA7rTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765420429; x=
 1765506829; bh=yE3+Lin4w5tWHByjjvRIvs02gGLrx+GT53OovcMawIo=; b=a
 Ok3TQrkH0RcNVjJeeAjaonKkwFm42PkakQf+A9Xx2znOe0hkXbMld0tMilmfCq0y
 TIcKimWQJNVnH1KSg88gZ2TxhX2v1QUdrot42Kh+/ca6Fm6YUBJwHFZlEAQiTSKY
 smUvMO/w/FsdVNZQFRtV56uCN+sLX7e84j3+8gtxRBqL4Va5i0G1/sgpk3L5VMJz
 OBBCUaAESXlFGoaqaftEYLPjF8nCmlX8Ct5xpCc25m8UV4BlVrdtNmA0WMa33KGZ
 +UTUo6QX2TN+gxncDG2VRKfcCxCCI6Ueq3aAaHKeUbPxGkr/QJoh2vy8XqoQD9nb
 2rDnLnkBfiCFoMOZKdjWw==
X-ME-Sender: <xms:jS06aaeR8ydmx2KgEGYlv1lS-hIDXBdJV2EOP7GeN50O9FwfMuOPig>
 <xme:jS06aboFV6EJWsnYn0lI85T4q7Tt5eYD8P-D5OsLMLeksz2DCbKLE9lSqJyFoZyEW
 w7cqvGxLca3G9k1cbLao3e4unrb27CPqbepKkV0h8w3KJYPnEqL4w>
X-ME-Received: <xmr:jS06aY6UKKm0PWDJzVg-BY9e3jx1e8jad7QsqV05-uGWY26Gd00xLNmmVicF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhepggfgtgffkf
 evuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfvehhrgguucflrggslhhonhhs
 khhifdcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnh
 ephfefudffkeffheduffetledvkeetvdejhedtheektefhhedvgefhheethfffkeegnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrgguse
 hjrggslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtth
 hopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggu
 sehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:jS06aRpYcXtBqcbM-3XXypj5q6jj9HTvrtUIB7JIDYKMlAT-qg8b9g>
 <xmx:jS06aahaw5ISuJpnUV4MUtNEsZLdEexHy7I8BbTmCsYZgTd5C9HUsQ>
 <xmx:jS06abIKEk7k6qk_DIg5uxl6_wqKy5_-iu6mltdPzkpjHCysLsnJ0Q>
 <xmx:jS06aaCDNRl70BjxtG_6xI5eEOurEGSEmzzNxjKKOX9pjttV0nt3dg>
 <xmx:jS06aaV0U7HJ0ZjhxutxfuW61SPsHJbyOFZJWbj44pJEHEMQ2sSoJpjx>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 21:33:48 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 62e36222;
 Thu, 11 Dec 2025 02:33:46 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Dec 2025 21:33:46 -0500
Message-Id: <DEV1B7KO3P1T.1WB3D1SLTKAD4@jablonski.xyz>
Cc: <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 00/11] ati-vga: Implement HOST_DATA transfers to
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "Chad Jablonski" <chad@jablonski.xyz>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20251118154812.57861-1-chad@jablonski.xyz>
In-Reply-To: <20251118154812.57861-1-chad@jablonski.xyz>
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hey BALATON, just a friendly ping on the v3 HOST_DATA series. If there's
something I can take a look at as far as hardware validation or anything
else let me know! In the meantime I've been getting familiar with CCE and
poking at the microcode a bit.

