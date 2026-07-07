Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF25C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7BY-0006WC-Qe; Tue, 07 Jul 2026 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wh7BV-0006VN-J9; Tue, 07 Jul 2026 10:54:06 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wh7BT-0003sc-7k; Tue, 07 Jul 2026 10:54:05 -0400
Received: from [192.168.25.24] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id CE2092003D0;
 Tue,  7 Jul 2026 16:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783436040;
 bh=wxn+y3DLqkCnX2j25VWYeyaBXgKQq8fu8hu8ofdeaE4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oxY184kckb22CZ/IZCgWWhEWsUG9qLwt+E/XHji2rluS6TvFenje3IqoaT5lw7eNz
 wjGuRrMPxrFGpz8dR/GAuOGQgu9W+QGcypn46yfb+fj4Z2nU0EomM44klvyRnBDpTR
 CZkj/p0t3Fqbd10zomAbRME155z4w/RObnygA+QRevfMJx3iFh6o4EnCaRR9U5usfa
 65ixdQ49liJXh1v6gI962cGT5jl2GSa8itPBHsRge4qGD8y+vH4VZjoGeeBE0sFvPj
 id1GpEh1n+V3O3efNbtnSsQJs27ZjuJ/8Y6j54juHUEBoFAWVyr+qmGhMefHPDlzil
 BVlVUJYGXVAFg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: alexander.hansen@9elements.com
Cc: qemu-devel@nongnu.org, eblot@meta.com, titusr@google.com, clg@kaod.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v7 3/4] hw/sensor: MAX31790 support
Date: Tue, 07 Jul 2026 16:53:47 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <3A5D372A-26CD-49AD-99D1-395611E11ED4@free.fr>
In-Reply-To: <20260619115533.5664-4-alexander.hansen@9elements.com>
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-4-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_41D68B74-AC9B-4CA4-AC23-558CEA64B6F0_="
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--=_MailMate_41D68B74-AC9B-4CA4-AC23-558CEA64B6F0_=
Content-Type: text/plain; markup=markdown



On 19 Jun 2026, at 13:55, alexander.hansen@9elements.com wrote:

> From: Alexander Hansen <alexander.hansen@9elements.com>
> diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
> new file mode 100644
> index 0000000000..af610376d1
> --- /dev/null
> +++ b/hw/sensor/max31790.c
> @@ -0,0 +1,584 @@

> +#include "qapi/error.h"
> +#include "qapi/visitor.h"

I do not think error.h nor visitor.h APIs are used in this file

> +struct MAX31790Class {
> +    I2CSlaveClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)

Maybe stick with the I2CSlaveClass as no feature is added here, with
OBJECT_DECLARE_TYPED_SIMPLE(MAX31790State, MAX31790)


--=_MailMate_41D68B74-AC9B-4CA4-AC23-558CEA64B6F0_=
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8"=
>
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" sty=
le=3D"white-space: normal;">
<p dir=3D"auto">On 19 Jun 2026, at 13:55, <a href=3D"mailto:alexander.han=
sen@9elements.com" style=3D"color: #3983C4;">alexander.hansen@9elements.c=
om</a> wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">From: Alexander Hansen <a href=3D"mailto:alexander.hansen=
@9elements.com" style=3D"color: #777777;">alexander.hansen@9elements.com<=
/a><br>
diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c<br>
new file mode 100644<br>
index 0000000000..af610376d1<br>
--- /dev/null<br>
+++ b/hw/sensor/max31790.c<br>
@@ -0,0 +1,584 @@</p>
</blockquote>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qapi/visitor.h&quot;</p>
</blockquote>
<p dir=3D"auto">I do not think error.h nor visitor.h APIs are used in thi=
s file</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+struct MAX31790Class {</p>
<ul>
<li>I2CSlaveClass parent_class;</li>
</ul>
<p dir=3D"auto">+};<br>
+<br>
+OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)</p>
</blockquote>
<p dir=3D"auto">Maybe stick with the I2CSlaveClass as no feature is added=
 here, with<br>
OBJECT_DECLARE_TYPED_SIMPLE(MAX31790State, MAX31790)</p>

</div>
</div>
</body>

</html>

--=_MailMate_41D68B74-AC9B-4CA4-AC23-558CEA64B6F0_=--

