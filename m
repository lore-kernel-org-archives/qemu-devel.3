Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F80CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Wtr-0003J5-I2; Thu, 16 Oct 2025 18:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v9Wtp-0003IZ-I0; Thu, 16 Oct 2025 18:56:45 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1v9Wtm-0005kd-7m; Thu, 16 Oct 2025 18:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1760655390;
 bh=2tHUA9KypZGygYUg71MDShVw/PB4OLsxexmo6QzMG3Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cJhvLOnGirWCn60PQqMN0iyp3D3776yacH+HF+JgC/tF6IIQOgooCx48z4cucoyao
 kV6nM/OEh5iyYMn97zw57XxwGYmMEfvDTerCQ9es975Ud3CEB5lXYI5dQripcD0N6U
 e/+ID+rvQCnJVcDTsRhJxa4U7LHkS2HtsIHXMJBvBpIZeOaX1eEY/R8NbZG23upew6
 VVHF57gZjIhsS7YT6oQlbaO+ure6FheFuIrM/6Vp5F+xXpq5dyxH4acSd54LiOYJLx
 XwYWQ4i+PCHSvKrhExcJ5Yx89zcNRaCvoB7FKSUKVS6xHwPy9z/gdxqg+PE575eL1z
 xRj69sWFRLy1Q==
Received: from [192.168.68.113] (unknown [180.150.112.213])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C7D06477A;
 Fri, 17 Oct 2025 06:56:29 +0800 (AWST)
Message-ID: <dbd7c26cf0a77545bffaccaed7c9a364f97ac7af.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits
 basis
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Coco Li <lixiaoyan@google.com>, peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, flwu@google.com, 
 philmd@linaro.org
Date: Fri, 17 Oct 2025 09:26:29 +1030
In-Reply-To: <20251015011830.1688468-2-lixiaoyan@google.com>
References: <20251015011830.1688468-1-lixiaoyan@google.com>
 <20251015011830.1688468-2-lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
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

On Wed, 2025-10-15 at 01:18 +0000, Coco Li wrote:
> From: Felix Wu <flwu@google.com>
>=20
> Added 32 bits property for ASPEED GPIO. Previously it can only be access =
in bitwise manner.
>=20
> The changes to qobject is to index gpios with array indices on top of acc=
essing with registers.
> This allows for easier gpio access, especially in tests with complex beha=
viors that requires large number of gpios at a time, like fault injection a=
nd networking behaviors.
>=20
> Indexing multiple gpios at once allows qmp/side band client to no longer =
hardcode and populate register names and manipulate them faster.
>=20
> Signed-off-by: Felix Wu <flwu@google.com>

Thanks for updating the commit message. It should be properly wrapped,
but I expect that can be done when the patch is applied.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

