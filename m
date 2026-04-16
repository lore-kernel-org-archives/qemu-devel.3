Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC6FF8D757
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDO9w-0004MK-QC; Thu, 16 Apr 2026 10:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDO9q-0004M3-Od
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:57:31 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDO9o-0007PM-2H
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1776351445; x=1776956245; i=lukasstraub2@web.de;
 bh=XhycLMoKzK75JKilEgOO/xb7I6Wd2pMRm2mZ0KnJ5tc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qmUk5PCksyY4VMFBJEGfIOJ6lTY5fstM7zigarPT3lgER2lPv37ZXwEd/UFYUMT0
 vcnSZ5JchomsdYwEGzJ8opwxMfpzS5VF4zrsfMpEXd37qJgQvtFBI0aUccfkxZozB
 JXtB+yzslWNZ2HcIvrzGESgmok8i43CTbGKFcNgEx/8XR1Lyz7lLi8LGYRQMMesQy
 mDnEFxCV6zIsXL2n4q++s+GhUYpM7OpIILMoFmnCdg080jYMoPx8TS/QVrpMbSfdT
 mTLscLjPtIfjCOL5exwLvFR9lEc8OMLhotTL78mMs3FOctgzh2IRBzhvnOZBf/Dwz
 iTMtHxsGNNESR7U1nA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1vqBNh2hS8-00Yjke; Thu, 16
 Apr 2026 16:57:25 +0200
Date: Thu, 16 Apr 2026 16:57:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 26/28] MAINTAINERS: Remove Wen Congyang
Message-ID: <20260416165723.2842b887@penguin>
In-Reply-To: <20260416091654.316158-27-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-27-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ylcsKI/ar5CtYmzEsM+DYm/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:g0m/tP76VD7KkuGEpj4zuEOwUecSIeB3zNKG9Njeql8Y1vBMXE3
 I5SM0sQkJSSZrubdg09iK0J/XKAYYXlvPglA7iWUkpqw/Q3Trz4a9l0WBo5+QLerFeZ2+Ef
 rPSyLKqZ8UuD7tdqQY9lVRwQ3DpLBgIfkHc0khX02NyHa0fq4yrt/ZXQqM1wCxSyiGYeFtg
 hk5J5ZsUYuUBd3WDDvAOQ==
UI-OutboundReport: notjunk:1;M01:P0:ylTfMkk8pwg=;ZNg3sPynYjDwRBdQgmg3u3l3Oc6
 rBwRr4HlqdIP53KoYVfiz4vU5f7t6VhiEc4Mhg3y3VnXhixrS9HR4iDIG0QEUL4/sZA6Rt6rb
 Nb988xV4mIJPRTT3xmvoGL7I8XxEfpWQmwYxcOAa7oZ24QEAog0qaW/3Htx6sM2vpHJVo5dM9
 1Jow8G/hbDyNiM9WrCIil+nobo76uf++3R0Nucnwnmgj6tpWkfsO47wbjC13cTmeIpPbMWoKU
 SoFAani4g0Pvp1qoe+HXzYtVDeFn6YL+yrh9j4mpYfQe3v22oHGA7hdqx5QxirsgDzkLFkx5g
 3HSs6Gq5wM1OMG0G0fj8lc7WTFOtxRwzH1HYk9ulsNKXEkWbRl1JrHcpiZxyxfv9/Qvqh1e10
 ED8vSrsTIcoq8J7x/sZlz/AfG1G/6pa/457ZqOw8T3ZWXPaP01LpSg4g+4prWgEzHeHdkLWd2
 BM8R9QLt+5oZRzuFtyhtQkAKpWZudT53EXpIxcZBVbO3Gr4b7GAAqReMgJQikjRjhJZ7CdbOb
 JdbKlwBOp9DSujVxgIlQRxtiYlPAt2q/uYv9RtaFyqFxB/loKbnJlbjZ4gc9lgeEnFlylht5X
 1JFgpNjEbLXj3wFVHHIxGlBgLKZA9znCgp1NX9jh6pYajPqpAqgPNgToWXm3DzCLKZxqoqcNX
 9QJ/UUDyG2N+x3YbgEzGf49dZt+62DQW+ILY0wuXmvW7ZKPrImTP3TND5wZu6V0YqFuV+R9Vd
 cq+GBh8ObEYdE58Fugs4xxD5b6cXYqv5ApRiVarlr7VIB/gBaLOzjV9nRE+wjNXE44rd/RWk8
 DUs04B3N0yghyN2I0w99PuiESi4CXfBh9rRXBBdU1oYgfSRD1WiCFyeLUWvILI+W7OMy5Hvfg
 C4YFj/jG7NLYnIRHrsW6eOLqPs0ju0PB1U1ApNB+eDkQTHuyvMZeRkVRO8UZyl3GZcDBZNXKp
 YlLcUdv5p1KcqzSLSvvOj/jgLLeIl4xHib6PHuofRmi/mBVlC0wDxlg2xpfHSLJlLgRc8NGnZ
 G85bjHQ5UEnBP5QXA4/6pv3xN+UTjBUs3HP6i/cFQUEkFHSXJr+b8Q4RnGISktucWbRjZzCTL
 acMGRwLym5SCGQrzgGbBt09hCJVvcjtT+eTaOi3yJQ9LmKaHy7stBwhOm3ur8aNCcaHoPyoVR
 sYC4qnbUINYiLCUqmDqUF3K70qTpfN+VaRQFuxHM6iNb90KVov1DzQrkOalbocLdYRBoGxA4P
 Z/LJf/HVUrLLel1rBKUsBsiYE3j9hj8cSZTAbIB1p1szI0ha52Vy2iFF4kZBmn4rf27BcTh8y
 2jmGRSL5CI/RJwPQxkpkPqCWK+g099td6J9hk+pqi7E6mDyqfrkm/58izu/LuE6z9T+hcK8hp
 A8sZermz10LvNMWaJGzY4i6BLEl3FUs7L0WvNujgvo6kMvbUafy5YrSYfLgeALNBUhh2v3rNL
 GY08i/i9n2szh4+e9QJC6uC+IJ5UmEbyCXouXtxm9ArzylF0NinOy110XrWKiiZtYmyO1CM1J
 w2IE5EYrTFAMr5mkGUHqg44p5ZZzqYnPYhZeeklAolVdo9CSxHhSlzR16SH5jHf2rt68DDXPO
 B/XmV2RJouWLSrWI1654je7sFYoJyfMjV8twMJ+Fff3gavwEEUk9OrBOzwNA3sWVt1TQfcHVc
 nag9EOGeXhRHI+6Uzw5LUNhLzJt3DVGc7E614lYiT/NsQh4Z8KLiJaOEEU3rnHIHrkDWvUUXs
 OQRfan0S6Y0cWkCIFEAIFNi94qltwahxB6F1Qf6B9ZBM4tN4nccLAoCuLS1Rzd8gjgwTOnHK5
 7cl2UIrxFmthWBucrWfAfDdo9XFpkPIrg4mP9+musHsC9JgkkFT55cOduUvAb0PP3y9fDt9gg
 CEivBx0GCNEgaZF0svl4h5j8yUEef7stfXSoATauWn3QP3vb43GFpgIr9/91cah2DOLigSxFW
 qxZD9Yx5Avn6fi5cdQSGRCfu2ZkFeONP2ZuVI93pUCyZiQ1r6IBWdSK2BIKdb0oRNZ0pJxUI1
 oMD3jjOAOJlVSJmbcjPZg05A5Xz9YbeMc3IjXNrOnYqUcwROEnX4KVgT+qVPRxnkis/9UlT7l
 l9wL/8P93QNW4b5f01rk0/yZYNil6qynC0BgnzNLxRU0OJNMDWol91/oyK1CNaqzNZKjHPije
 kfwPIcB9xTM2UZThPHiVgwgLweRRjZ6WAnjMY3atnWZ7+FvEqRvujlXmu8B1gFh+oSUbbQ6dD
 cMIXLKGN+FTlkUPvz7MtYpRX/opjWl2SRtyx7KHQtRkg15NPIxdnUx3QjOQFZRhD8LRGZedgV
 Hkxo0q/rU5q5uDZt15QkyewSUgr85+v/ZFOVRlXHLnMxnTxB9pB8njs6m30wE4f5ap/6UxXNI
 Ga4WmGmftoSkSk+rnuEWl8JZzKC2pnOXkqj4xWHJEFXuOFhdRWzv6X7NsuP2g9S5Fl0VYFEe2
 lacD8L0fQ+aNAciaS4NPY6L1BX+M2dh1lQF0sqw9Uw7KoeBweHW4jKfBtIsfxKtCkhm26VPfa
 bjWwqhtSSxDlxZrjy6osQCKIOL2eRkml39rBwVrP/UIt2ahZrWov3o6TY/3tiaIdgeiqwXZ+p
 Ksse7juRB2iq3POQYy4DKjim2PrXFwLM7za4jPgAEfyyo1f8hGA/L04xqeRfK1bznr6DG6w/o
 BXO/ugxUjol4ws8QKiOeNCFN/BG7odsHo1BZ/5s5tVBIer27N/tLFZpfDLn87slvZbVuduCXj
 lHELWTkv6lPZIP4HLE9H8BOiKDX+sKNVfKmVBuOZFspNkXgQ/6WKB6dEvrF2HK1eASs4qPsmk
 9Is0zlKOxHXO5pvZAdZ0T9aOCETSwAJun8UdMJYb976dASoxil6S+tncWRoJz7wNHyCTUDawS
 C5w0wvDtpgwvMLfPdtSpBAjLPJsC/SoC71VhqM7eDGqWcQrd+A1i6C94P4x+xQqqn2ulGNg96
 1VsU8HVvnpl9vRWxyFQT14Y/ZLMwnt8BJog54thFTayW9/tcj2O4muHoBsq5sorNbziUyedGi
 lv3FGQNqswF9YA27giHC9VLYZsE3lDH8246ycUDj9g/T5I7k/q3bnFLQpBOTWjaEtteH45uWC
 8ZYpjc6OeqLEkxqmHqQ+IlBkDZVu89gkzv4A3NjiI9VAUm2bA2cUi/j2Wp3IGUFoyWeDvjRbq
 Eh7Qa4Y2b7Wx/exzgdcP7dbTGRj0pH1eYF+CsJ3XI7MO1yFGmxCTIPQZa/IbxZUNv8jIUm/Od
 eA7ZMMWzKb1CYwEue9lPq2jFH4H318X45M0FwSxzxbf3I4YsdrJ18rdc/1AtVgkAVXEiY4EJi
 K8xX4u220EnSVI0HpeXxhadVQatta/+IMQS1eY/yHJYjEUIoCqmcOQc4YcYWaQfgm2XpJNBI/
 bIS0X+wCjlRKs454LkqFLlRbwG38oMRCmuqZXA4R8wZdxe4rTHOufxa53yfpTGT5qs+ZwKz/i
 eo/y5GDnqjwZWFLu2AvSaUuDtMXVNlCehh8BWHyDMgnjSmpCUu6UQCQ6+GqDl55ZiQ2yUXrfG
 G8zK5YPQdKFOJw7Pls4BNYI23uSJDNxWBN0qKtgXSf4sUhB9+UivQ6ewktrOzfDTSji2Pp/va
 Zhd9GACKnmyu7SzZ0lQJCOsBmJfuKG9TMjW/cS47Y+PJTn/KRFiDtgl9AMmQVzbMuxbD62Fb8
 spBP6ClshUA8LpJL4HPNrRCbLM4FScsHBkB3fFUqjm02BreMYQZ/D6A/ElPzTQGIGtJDXdcK0
 4lP8mQ7Xkne5AC/hJ5i05K6JLgOdX04T3mw45I922k8ivcMc5qIqUQGBgxbik49hE9PtHoFy+
 AjecU8Qcva4u1uzZCHOfRhzZ53PBj4cIUoGdg3ysXVREMY1/SPeyVz2MfoP0QWpD0X8cbOTTB
 lRo0dF49pmEhUeZG/wYFvdnTZpa/MHhS/nEQ5hETa3xn6u9DA9tUYQXxi+LjPYNJf8Z9MCqJn
 cz1ypXDinfFJVHkYQAUMk3DlbHSS9FI6soME8g5bNb6saKJuwPttqd/SGXGINNVgl9n2DSnLz
 DbEdUSqL6LtTChNxLfSJpdGB+Z5xKs2oC36/Xth58BFbtWIz1FauVOi7HpqOwF6mQpb3NdyAw
 lNAliW2soMPxQkd9QaqqV8bEFc3GIwRsLGy2c6YQkKTSOgucm/876mEHzClbW2C1pkrihnQj2
 PEu1DTCpWQK9ngjd3yehGHupEo2zsEAQVYW8E3WXBIvuPd4ye04DG+fv+9fbJ8euxgFDdhs8T
 +vO4V1wDzZX8jHCYkXCU2nlH+qObLdoUcNgJROvbmdbKROxXw5sydZIHJR7JzE89NVc6jj0Oh
 bCs0mONRUepJ4r+p22fYTEl4UKfUpzmcRL7Uy3Srglj0R1/FmtKI88K8ErVSgdu4AM0cDMoIQ
 mzvBnxkn6k2YJ6EDPFKEadW1dNSu7d/xyQwZ4pBem+NyCNsuQmS/VhLEgivmRXdKTGg1klsTQ
 gLWJgHH/cXF8M1HDJf7yul1cTjmPaSq8Q9aWerEBB2f5sRMGYzt6qbUv+0qMkKdBc81AJ95vR
 i7mK7WYVPxRK5GVVFXy9O+R+Y9iPWgsEL10mT6VBdF6CSA+RGx6t4iVvKoaQRXzCY3jYNlGFb
 PxEPEHoiwgXXO/Be8oJVBjA5ainWMw3nz8OttGYz2DF8cGlutZZcTM2+pe+vRdzRAJGWmSI3j
 ah4KisOYwzOaXRvVp6zzifrP1c5QTo34e5LcnfzPJFfdHFht43fnNsFqJsx/jVklYszyOvnKe
 VrdRVmDSyKb8mxS/A49o3WpbcNLElfM6HEANwJI8AfDptOewFwx6sBz+T8mWUGA2uuLT4uRR0
 j14G6fcchr6PNdlF8lZIriSHwKDu877zZyhCGaNZSNd0OugoQRkpf4Jlx+y1MoIuHEgv4QLQQ
 AoGHdIKA7iDy3ZsPU3m/ofq5LWO3jJrenlfQqhVrB9b54vxoyozvj0IlRcfjK6x5qN79Y3u4R
 NOS7G4yZ2wim5WByYXWqhFrlpMZgOqyk4ce9DtbklQCIQc2iRPGSo4eFURghgPxW32ao8TowH
 W8Aw7auAGVy8Fso9RIOkSnrV7DE9PdWAfZcmq7U3QTdQtsvIG/Mr/34k/nnb+Yz8cKlpXYK//
 EFbjGV28r79WGvC1P4Vx7cs9obnhDM5AuVnlc94U6co+MDRowePecjBHTmznU4pkExZ7W05/e
 bowH+uFWgEniSNhtb1hEDzoKDayrZcoQR96lSTq+h0s+y4n63+uPQXonkfQxOLYnGDIqe5mBl
 EKNdEwR1n93Q3S0YvE1SvMDB9E14BTpS6WU+6fRGwaOFT7AiWq/bSDb0uoY8wenlTLFlaII0C
 raCkYpc9DwdNzifTZTe3sYiOVqbXc7VFAlxGGdVgTCPUusFu7b9OjDeJ8UrbQ6XgZ47K3dltY
 DrahzItCOB+uSgTUbyMCkDi0KRNIhczFqpF1lwUmQAQe6h4w3erqw5UR2pf4cGk16rZnrWN5H
 zj+W6q8+1pdHP7w==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/ylcsKI/ar5CtYmzEsM+DYm/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 10:16:52 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Wen Congyang has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca64361b24..81ffb56c31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4383,7 +4383,6 @@ F: block/export/vduse-blk.c
>  F: block/export/vduse-blk.h
> =20
>  Replication
> -M: Wen Congyang <wencongyang2@huawei.com>
>  M: Xie Changlong <xiechanglong.d@gmail.com>
>  S: Supported
>  F: replication*

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/ylcsKI/ar5CtYmzEsM+DYm/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmng+NMACgkQNasLKJxd
slji2w/+Mu6EZSmoKbgN40ztyAXqXlw+h2VIcdkdF5Lc5aTaLnxy3gZUVtfi+Lrh
LAA8R7fbreoksLffse9CnitVLLDvBgvEfHicBDb08KWY+F2cwE5Axc9ij59pPgjT
p7Cy+T5RESM0BqfBD218X89AC8ggvgvGGgb8FH4TjCNGLvFA/M1ed+Y0K21A+r6M
d9kFnYZffbx0jsXmJo371m+eTlBZmBZdtMNxpDULYOJV8XC75xtnndMJddA+oTSZ
T+rGX9XGBFKzbvZWRVPnDCEOxxMe3g18irKa5az6lI5g9tRubz0BlVQL7Rmj0kKv
BJhob2jQ+SZlDKJnr/yi+pP/p/GzjLWQPjBRHB7vxMKrszsbwoKXG7C/mMElyAoT
ZJhFROUA5ixtmrGM4Gf0uGPUPUCW+8c3wKn49bDCfCKGE1ncEsh9zleezLAFO4Gs
CH9K2FYxQO1hgI4WeW6Tyj3tME1lVe2jGrcH7/rOqw1JNlFlnEMuqDKNlo3wv6RJ
7Qid3gZ0ck8QY6yWbfSWgcfPtWMU1gLp6aMQEDhWtBCjTyKAd8tSunhey4PRcDTZ
25ayIplG1zw7k9GJ+X3zOv9hdOrs2yFZEOEavT5xGvBi0mBhspQbEOjMS4o8FyBr
mfgFha2axk1hDBBs30UdDErhBne4nUtcNa1kNTdvaAnD5rRffhs=
=Gwlg
-----END PGP SIGNATURE-----

--Sig_/ylcsKI/ar5CtYmzEsM+DYm/--

