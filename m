Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895C7D4921D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 14:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2lk-0003Px-RU; Mon, 18 Nov 2024 09:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iris@artins.org>)
 id 1tD2LQ-0007P9-Ck; Mon, 18 Nov 2024 09:03:12 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iris@artins.org>)
 id 1tD2LO-0008Tc-7d; Mon, 18 Nov 2024 09:03:12 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DD061254018C;
 Mon, 18 Nov 2024 09:03:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 09:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artins.org; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1731938586;
 x=1732024986; bh=ms84ASTUFEpAx9guXXRvLglR557aCd0QGxp1c8XoBMI=; b=
 gCD3reWrjCWDr7jbwj4oJ0xSVmfB9oTqlCwrqOoY9eXuzzRKNVSAvkauv7hQTn5s
 +P8ybP1LD3h2hCfjnOsc8xAkGownY9cios5bqiVAw178q2vh0IY6DJBefHW87PYX
 YvuUsl/cpTt13o0q/w+yyxypNVOayiCv3LVD7/BdmbDD3Y8OzccJhePJ2Of1mYP/
 PAfy6e+Yb6zvn0tFNtmT7gcB35srFk3fmlZmNxfCgCqu26iOf78TsiTsyMNrmGo6
 oXorlau7oY2DspKxB3DSUmSl3VoepYx0S5tJ/RW7SGFSZfb9QyL545DJPAbJEE7w
 LDmonEXJMU+xDEt4u4hr6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731938586; x=
 1732024986; bh=ms84ASTUFEpAx9guXXRvLglR557aCd0QGxp1c8XoBMI=; b=C
 qniTLkRQW79bFfuYZf975+8IpOsLw88oiqFuDIfSbvByIdqZuhCZtJELK2hF1Gr1
 LHvkmiQ25x1PQQm1YE9cr9nDFRs16HNMljv/nG6sG6Bvum0f1REv4XGNqqcTLbG+
 S+iwLRiAuTWw1K8ZZak1MnZQJcJArm5KGTdS9/HUYCUOqntKpKBzuQa4H2389U9B
 uXmT9G1otPFVcedtaks05NCsU98c6MUSygh6uBDn9JWDd7wh2pzmCWOjAeU8UwuT
 F2dd4KNsqnKqHMjpQ04UYhwSdXgldZ8E8SqG7SFKMKzaaRjtyElrPYfuBwzbu8wD
 WeF5ggOhIQL46ERpGZTAQ==
X-ME-Sender: <xms:Gkk7Zx_5uPaYHRgyPZqPgw7ujQaHmQAelofOdiEr-96dTozCL-fPNw>
 <xme:Gkk7Z1sIHg9uOcA-1BHWW-0Ddsdp7WyUfmZvE6oVai33crcw34YE9vGt370qgJmR9
 ktccly-JPn4Jp1d>
X-ME-Received: <xmr:Gkk7Z_CojwCtFeMBXddI4FMFP3sBcTtNsg2r82xpn8GVpl_WwuhIluNBmAteoNnUooO_7y54u6ZQn0GGXrwqVveL8ytQxp2k1fRTtiEzWB8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpegtggfuhfgjffevgffkfhfvofesthejmhdthhdtvden
 ucfhrhhomhepkfhrihhsucetrhhtihhnuceoihhrihhssegrrhhtihhnshdrohhrgheqne
 cuggftrfgrthhtvghrnhepudefgefffeevgeeifedviefgfefggfeigfeggfdvjeetgfet
 fedufedtieefhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepihhrihhssegrrhhtihhnshdrohhrghdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehgshhhrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghm
 uhdqughishgtuhhsshesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:Gkk7Z1f6FXH_nF1M7JjZHvYkop-6bJW91XBC8C6FbBMdkeZTHiME3g>
 <xmx:Gkk7Z2OFvVtnUuUMHwt5bEkCpJHq7LYQrqTTh64Gix1-db-k36zuFQ>
 <xmx:Gkk7Z3lZs6c4MMDS5CENq74SPK_3V_qNMnjNFeCY-L6id2nMrOQeZQ>
 <xmx:Gkk7Zwtg6WU1RUbNoPrYnINiFMJcc0mZRqe8wmch-ifIn3WllFc0YA>
 <xmx:Gkk7ZzrFRCHKBJ-UtXmKIu21vnqpdOWqCzmpSLj5gnM7J2F8J46uW3wH>
Feedback-ID: i42c040d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 09:03:05 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: avr5 not found in qemu-avr 9.1.1 on macOS
From: Iris Artin <iris@artins.org>
In-Reply-To: <84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org>
Date: Mon, 18 Nov 2024 09:02:56 -0500
Cc: Gavin Shan <gshan@redhat.com>, qemu-discuss@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: 7bit
Message-Id: <DD7BC2C5-003D-458B-9F25-BDC20D3A5FE1@artins.org>
References: <401F6B10-2316-42B4-BFAA-863E9B2B8F87@artins.org>
 <84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.200.121)
Received-SPF: pass client-ip=202.12.124.159; envelope-from=iris@artins.org;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 Nov 2024 09:30:21 -0500
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

> FYI this works:
> 
> $ qemu-system-avr -M 2009 -cpu avr5-avr-cpu
> -> OK

Aha! Thank you!



