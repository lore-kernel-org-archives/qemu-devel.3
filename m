Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF71CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMTF-0008Vg-Se; Tue, 04 Nov 2025 14:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGMT9-0008VI-O8; Tue, 04 Nov 2025 14:13:28 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGMT7-0001oS-Dy; Tue, 04 Nov 2025 14:13:26 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E40167A00F6;
 Tue,  4 Nov 2025 14:13:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 14:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762283603; x=1762370003; bh=4tY7q6V0gn2WQwRCDpLbKckgmAySWDt4
 f/iJvglJ8ec=; b=RzUvqUVFxjqU9kOrwv71TaGaYfjKCNF+JRRENUoUK+7x6jIA
 uErjGLkmpzuFj7YD8Fol9Em+PjYtj+n5KMDdSN6dU1nm3Lx88WSX1t1OTNOtuDDX
 dyWkfij/9xhOM/LF25JKvq7UV3hdBg2HjZ/M876docIMCdY+tMDKAjNJM1bBXcO/
 g0+j/Pv6+24wyKinHniDcqafA+KPL4AYzNHqJoVc2vFhVu6UA+RSWN7ZiUdMBCJJ
 BLvcPlZVmouEff3iOthGRd4sXUqclOP9iTHDLO81btO89x/Mqm8lYKWuW3Pi5p/W
 M3pBzQTtev6QK1sPnwXyyBb5DvGKiYjOuiBNoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762283603; x=
 1762370003; bh=4tY7q6V0gn2WQwRCDpLbKckgmAySWDt4f/iJvglJ8ec=; b=X
 GuziqVlsHHipUSO7L06UiMwprmOipK584xo+wonNtXaCacH4+MoTUqcOKM6Gut5g
 NW5YfNRRao52k8Bafb8SNA0SUDg52UaD/BsjB1tHGrqhD99OAzkQolmLKiA1xOE1
 QIl1iXUn9xCD7BTMrUUMJib7TUqE5757i6JMlcnkDNKriyVP9IZbNIO6C3ytMsyX
 aUSZemg91RMJeNVEa2H5NfDxWu4eGatJLRGYVNRLTTz5S6q2bL17ORfKVEPEvrq3
 gQ5UyGYbkY3cnKuG3jF4L0Q1IKwJL472fL34+b5XD0HCVXv1zGzqT9uuX0GIfTD7
 1T5Dnoq6Q3IZjTEztVNMg==
X-ME-Sender: <xms:UlAKaQlxRMUR6v2zThjLd110h9t42Y0cwJbVIHzPLEcCOeM_ZbxtjQ>
 <xme:UlAKaTh4b3UCqFga_pdueN2-AOuuELR6s9X_3X_ujb0ar6TwXmxlGU7FR9mZYdk-p
 pO4Mm-Sf-t9iXfp4jcb4sFmrOojg6MoweEC1ryxdm_USR6ZJe1DsEQ>
X-ME-Received: <xmr:UlAKaYfa29JkKlNLApMf1hRvI4X98ww4ScRk71LzVi6qygVHgmF1Tyz7db5u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedukeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmrghrtggrnhgurhgv
 rdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvg
 guhhgrthdrtghomhdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggslhhonhhskhhirdighiii
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:UlAKaTjFUriIIJeFAZRrNi4PwU6ioVq9QBFcP_fOybsMahNe7OT41Q>
 <xmx:UlAKaQwYhJ7jFeMn0_f6vX_owmON5eyP6cqSsuw77CDmpT_wztQU6g>
 <xmx:UlAKafMjGU6W18dg6QIvj2zdq_4UTjd0pfvoUbNte3myIUOUfzP8tA>
 <xmx:UlAKaRUXDcNwTTm6f7vVdrMY_re3UO4SOpZMnge8eoR_bcQEU4vvqw>
 <xmx:U1AKafDW9__UlTo4oMGjnXy5vXQJ4SoBzeRPs0lLIryXidM2dhymWDeh>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 14:13:22 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id f43d87ba;
 Tue, 4 Nov 2025 19:13:20 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 14:13:20 -0500
Message-Id: <DE05EDLSW2E5.RLGYNUKUOZIO@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>,
 <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH] ati-vga: Separate default control bit for source
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251007195435.8ACAC56F2A3@zero.eik.bme.hu>
 <DDYPYWJR1NYS.IV5FU7V1GR5B@jablonski.xyz>
 <9830b63d-4a83-0c58-3ce4-c2a19fd47efa@eik.bme.hu>
In-Reply-To: <9830b63d-4a83-0c58-3ce4-c2a19fd47efa@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

>
> Matching hardware is more important than matching style, after all this i=
s
> supposed to emulate hardware and we already found places where the docs
> were wrong. So if you can test and match what hardware does that would be
> best.
>

I just tested this using the same environment I tested the clipping
fields with and it looks like offset and pitch also latch to default
values:

Test SRC pitch and offset
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

** Initializing DEFAULT_OFFSET to 0x0 **
** Initializing DEFAULT_PITCH to 0x0 **
** Initializing SRC_OFFSET to 0x0 **
** Initializing SRC_PITCH to 0x0 **

Initial State
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x00000000
DEFAULT_PITCH:           0x00000000
SRC_OFFSET:              0x00000000
SRC_PITCH:               0x00000000

** Setting DEFAULT_OFFSET to 0x000000aa **
** Setting DEFAULT_PITCH to 0x000000bb **
** Setting SRC_OFFSET to 0x11 **
** Setting SRC_PITCH to 0x22 **

State After Setting
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x000000a0  <=3D=3D=3D=3D=3D=3D=3D 4:0 are hardwir=
ed to 0
DEFAULT_PITCH:           0x000000bb           just like the docs say
SRC_OFFSET:              0x00000010  <=3D=3D=3D=3D=3D=3D=3D 4:0 are hardwir=
ed to 0
SRC_PITCH:               0x00000022           just like the docs say

** Setting GMC_SRC_PITCH_OFFSET_CNTL to default **

State After Setting Default
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00c
DEFAULT_OFFSET:          0x000000a0
DEFAULT_PITCH:           0x000000bb
SRC_OFFSET:              0x000000a0  <=3D=3D=3D=3D=3D=3D=3D Set to default
SRC_PITCH:               0x000000bb  <=3D=3D=3D=3D=3D=3D=3D Set to default

** Setting GMC_SRC_PITCH_OFFSET_CNTL to leave alone **

State After Setting Leave Alone
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x000000a0
DEFAULT_PITCH:           0x000000bb
SRC_OFFSET:              0x000000a0  <=3D=3D=3D=3D=3D=3D=3D STILL default
SRC_PITCH:               0x000000bb  <=3D=3D=3D=3D=3D=3D=3D STILL default

Test DST pitch and offset
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

** Initializing DEFAULT_OFFSET to 0x0 **
** Initializing DEFAULT_PITCH to 0x0 **
** Initializing DST_OFFSET to 0x0 **
** Initializing DST_PITCH to 0x0 **

Initial State
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x00000000
DEFAULT_PITCH:           0x00000000
DST_OFFSET:              0x00000000
DST_PITCH:               0x00000000

** Setting DEFAULT_OFFSET to 0x000000aa **
** Setting DEFAULT_PITCH to 0x000000bb **
** Setting DST_OFFSET to 0x11 **
** Setting DST_PITCH to 0x22 **

State After Setting
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x000000a0  <=3D=3D=3D=3D=3D=3D=3D 4:0 are hardwir=
ed to 0
DEFAULT_PITCH:           0x000000bb           just like the docs say
DST_OFFSET:              0x00000010  <=3D=3D=3D=3D=3D=3D=3D 4:0 are hardwir=
ed to 0
DST_PITCH:               0x00000022           just like the docs say

** Setting GMC_DST_PITCH_OFFSET_CNTL to default **

State After Setting Default
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00c
DEFAULT_OFFSET:          0x000000a0
DEFAULT_PITCH:           0x000000bb
DST_OFFSET:              0x000000a0  <=3D=3D=3D=3D=3D=3D=3D Set to default
DST_PITCH:               0x000000bb  <=3D=3D=3D=3D=3D=3D=3D Set to default

** Setting GMC_DST_PITCH_OFFSET_CNTL to leave alone **

State After Setting Leave Alone
------------------------------------
DP_GUI_MASTER_CNTL:      0x30f0e00d
DEFAULT_OFFSET:          0x000000a0
DEFAULT_PITCH:           0x000000bb
DST_OFFSET:              0x000000a0  <=3D=3D=3D=3D=3D=3D=3D STILL default
DST_PITCH:               0x000000bb  <=3D=3D=3D=3D=3D=3D=3D STILL default


