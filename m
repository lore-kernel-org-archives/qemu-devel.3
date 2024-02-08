Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F97C4829C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY53C-0004gi-7O; Thu, 08 Feb 2024 09:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1rY4H2-0000tg-S7
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:17:05 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1rY4H0-0008MU-94
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 08:17:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 81D6F3200A11;
 Thu,  8 Feb 2024 08:16:58 -0500 (EST)
Received: from imap47 ([10.202.2.97])
 by compute2.internal (MEProxy); Thu, 08 Feb 2024 08:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1707398218; x=1707484618; bh=GcTFIGjp1H
 ZF57B3ATWWJsqJ4rPfGRtDxhfX1DqCbbE=; b=IwQUPrpi/o9J/RsNTwHgYo03WT
 4KFZrtjL89b7z1HnDbUh/RLGgNrKFAPlYcg2LSLmOukD6bugCtVZYh2q6Vx1EzOM
 yP7YPDobOB+vSRkCubWEK8n+TW6EeF/9PTme5WLoYrSRbW1PXamfCvV3D+tX2mfO
 bUlLOUAEXBPjnq8ntOw6tcuWI03IPmE+ZTywQE38yuxGTPzjtm3ZedLc+ceBeSAj
 gOYjMrOUGFkKArWVSNJMYRqMugDJATbimu7znB8iJ2VW+iVG7N4j0yEb3wfbrsjA
 3Q/5jYpKjqpJiSFf3ny64Xfack0Gw5yMqia3quJPjngnQaGEa8NfYXFucQtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1707398218; x=1707484618; bh=GcTFIGjp1HZF57B3ATWWJsqJ4rPf
 GRtDxhfX1DqCbbE=; b=mdk4DIqBqc/6qDk+z1VqR6tBpuShjP3498Lh64bgC1Lq
 qenSUdAcl6u68wtA5Hoql+Z0Xbr/d7CpaQEAWQucNdW8gna5yLzLBJQ4UtKSZGgA
 txsBPZdrJWI38vJ3W5MzL47myVGJ0y5ETi4TNwY0WHx9jsimJZUD3fgb5LKadFBR
 Dx9w7GBpVJY05Y0QPFDJ6STwuCSDHMhsnp+p3CAZiGGhh1yNFwlSsaNDQJfK7VVl
 VU6XbS/TXrxm3mutVj5u94ZHHCa+wvaohaP9OF7zHoIp27xc9VdWpcdwnFmDQcc3
 /JjyQi3NS/iQXkJAL5qz6oJ67qx48ia4UsWQGKW9mg==
X-ME-Sender: <xms:SdTEZbDveNLWSbUVFgf0oMBxVs4qoA9VKOFeQlO7Z6J9JAXOQBJIxA>
 <xme:SdTEZRhKDCOqfNie8eqGin7DiEVDiIfS2bP8nitVSrDxebVq1v0TxX5jhevcDHxVZ
 96lTfNQVMnU5eFuEnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdegkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflvghs
 phgvrhcuffgvvhgrnhhtihgvrhdfuceofhhoshhsseguvghfmhgrtghrohdrihhtqeenuc
 ggtffrrghtthgvrhhnpedviedtjeekvddtffevudelhfeuveegveegudfghfffueeutdel
 gfdtudehjeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehfohhsshesuggvfhhmrggtrhhordhith
X-ME-Proxy: <xmx:SdTEZWl0TQyZMZwGfM6xWXBiB7w0I3Xqh0qaphHaHzt-4D3Br04UNw>
 <xmx:SdTEZdxSQHfSbdvD3DvteLdblild1Ip03Ypi4hvH6VXFSTfAPPCDxw>
 <xmx:SdTEZQS06Pc4IWEp3gNLVxxqFiK1TxpLQuVYEaYxWUYPYNsYVzsvZQ>
 <xmx:StTEZbJd5AvBcrGp0qIW4nBkVgtc4U0HmzJ6O0kJOPKullVG5atyhg>
Feedback-ID: ic0014905:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 64D10A6007D; Thu,  8 Feb 2024 08:16:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
MIME-Version: 1.0
Message-Id: <34b12113-a105-464d-8a8c-73286d29b4a4@app.fastmail.com>
In-Reply-To: <20240208-maintainers-add-jesper-v1-1-1ed7eb9f8291@samsung.com>
References: <20240208-maintainers-add-jesper-v1-1-1ed7eb9f8291@samsung.com>
Date: Thu, 08 Feb 2024 14:16:17 +0100
From: "Jesper Devantier" <foss@defmacro.it>
To: "Klaus Jensen" <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: "Klaus Jensen" <k.jensen@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: add Jesper as reviewer on hw/nvme
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.24; envelope-from=foss@defmacro.it;
 helo=wout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Feb 2024 09:06:46 -0500
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

On Thu, Feb 8, 2024, at 1:54 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> My colleague, Jesper, will be assiting with hw/nvme related reviews. Add
> him with R: so he gets automatically bugged going forward.
> 
> Cc: Jesper Devantier <foss@defmacro.it>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Acked-by: Jesper Devantier <foss@defmacro.it>

> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f9741b898e8..ef70cc9f4166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2378,6 +2378,7 @@ F: docs/system/devices/virtio-snd.rst
> nvme
> M: Keith Busch <kbusch@kernel.org>
> M: Klaus Jensen <its@irrelevant.dk>
> +R: Jesper Devantier <foss@defmacro.it>
> L: qemu-block@nongnu.org
> S: Supported
> F: hw/nvme/*
> 
> ---
> base-commit: 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440
> change-id: 20240208-maintainers-add-jesper-d10e88ef88ee
> 
> Best regards,
> -- 
> Klaus Jensen <k.jensen@samsung.com>
> 
> 

