Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099F6C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjb8-0006Yj-A5; Fri, 31 Jul 2026 05:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpjb5-0006YP-RA; Fri, 31 Jul 2026 05:32:07 -0400
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wpjb4-0002Cc-C8; Fri, 31 Jul 2026 05:32:07 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 719D97A0122;
 Fri, 31 Jul 2026 05:32:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 05:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785490324; x=
 1785576724; bh=ThzjpddC4DsxghiN4NvwmQyDw64na/DBhNhTlOWH4Ts=; b=v
 FSS6mdeN9eh2IhfbbtPxS8wvIExupLQlSTgwleuRnOkcou9UNipmvxiudhUs4Ba5
 7HRFkbme2FT7YTTkJnoyQqBOPf5nKbH6QivS/Qkxzah6EMh/d5swvpLD5VA17WfE
 GBZrM/9h3DyPIQNHxilG6K8ZNB8Nz3ly0crCLcSd99D3ZsqEtc6TAYZpJ/q9ShOZ
 u/vW8jluOMHL+7BpqzG90FRcNU9Ia6vRYOEtYQN1bVJDU9ConCRvGWpzo8wJufgq
 qLH3c55u9uIzemQG3s8hqJYChtQjtDKauPCuzR1idluHFvnJ/LE8Psi0ialrRv/C
 06F0RTYHYK7nFZglC30bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785490324; x=1785576724; bh=ThzjpddC4DsxghiN4NvwmQyDw64na/DBhNh
 TlOWH4Ts=; b=leTqeMEj9in7GzmWj/vWNWGX1ksMb7jELxMPOcQvcUXa1x2sKw9
 jjjG4nbYiBnYT5SG4Ggmqgi4tYI0JIZA7rMNyTZH10yRnu5yh0V4WF/FEZG5x+oB
 QC/VhyIR3aleTuxAEf1B5+dQLsvYkOGUCJKUNpG60/YS2iPR/5bkVlQd8Ropxbpm
 VqmioH+BoDePSmkxmMOYEIIsvzf5rrdMsccNq8Uln5/e7CwxQzTvy+jZuLNzk5Fc
 IL1X3N5hsBhrXth5qIcK38E9GwLXAdnd/GHsg312jKiw5dWs4vWl62cf5eEKYo9l
 zuL6xlxktJuZfZqrqqNHStSTuK2eeWyOHqA==
X-ME-Sender: <xms:k2tsaqADs47w3AlNCTwXOLjQkiBUMU00TuPgiW_uz6WUL9v43vkDmw>
 <xme:k2tsavdpKj4j5LZ01NDrooCgbRucBamKXpt8vdRw0jxGNrhNOkyVYcxE9RL1i3udP
 6NFvPzd6q7LGJZO0qtm9dWTwQ3Z1wgcWhtIR1L2O5Gs2YL2-BB93NE>
X-ME-Received: <xmr:k2tsasl-_4LZOR1iMUfh9VVLA34XSdWgdOB5iwKwRTMNdI9hj-mIgmfgiM8RGw>
X-ME-Proxy-Cause: dmFkZTEi6UlvsavDqCbSnKLWvpAaMLKZohS0PTf7f8zl0oYEt17p/1QZd6KAXtKNC/m1Rq
 ippVfQSB5eu8blNQZ0I/Rv4oSLk4dRKwZAkHo4QKBsckBIicfgg0Abj2ECueWry/ktGsSs
 RmEWKHgkwphuTkzkgZY9ODUBRwJQGrCQtBvFZO/RGJg4bActoXr55h2mD1fISdRfrIPhWg
 oY+ML+tdrO8ztJPH4+HuDRZon3cpY6vlak+1kXj1ndgTP/3SP7svRKzvbYonkouFhimEic
 fLbSRxbi5YZ//JHaiOkJJJuufA0I9Iiuah9utYNLds/gGFxRgn0eUK5FLI6yIzrigbP2om
 a2g4HWLco72TK9h/UiIlfSn0SLjMnRQcVx28YDSIG2K5mOG/lvaNn02GqhLLJ8iCE28PhE
 3IydHrlE+GssIhgWMsCk8CozJScRzQZsi/95fPoC8bXpLPBaP+W+UxNNrBc1MZKibmezid
 Ar5eKaTQ+/5ciHRrHSDhNb/ooWw35lb3PXWbJzdyNAENXae37fZ+AbBg4vhxxYl5TZ8hxX
 y9HHY2rjiB5Co+0THkhSxfm3dKc9xRwezW9AEWk8wddFa8wTSb6f5Pdd54/rKGpB+cYFGZ
 S+ibUgdo1d3mvxCIukiVezrotWL4OmId5QHIzuZSxMIjdO8s7N/s+nQVq0Jg
X-ME-Proxy: <xmx:k2tsauGVy4BJr2HIBwGnGOe0mI2MqjuYvnXJVIQ8J4JAB6LFlT8b7A>
 <xmx:k2tsas7SBvRT65MUGnh3scoyFyFSAZnHeeyDGTxDcjJV2vZN_q-cOg>
 <xmx:k2tsaulD5JBJCyEfRWn14L7PoelD8zW0INCERBe_yPx9_xqRlgFSMw>
 <xmx:k2tsapoUtbanC_jt2SLz4T17u7ReJJXnuqlltarxuS02qShFPPOvpw>
 <xmx:lGtsahbZSt-BWig5lQ0tl2NUpSlHfJFyI4bmmEzYenlts4p05B19XcXe>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:32:03 -0400 (EDT)
Date: Fri, 31 Jul 2026 11:32:02 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: Re: [PATCH 1/3] hw/nvme: drop AER requests without aiocb in
 nvme_del_sq()
Message-ID: <amxrkvNDWoVwU4Qs@AALNPWKJENSEN.aal.scsc.local>
References: <20260729103454.26947-1-minwoo.im@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yj0GnnuDYDkmNVLY"
Content-Disposition: inline
In-Reply-To: <20260729103454.26947-1-minwoo.im@samsung.com>
Received-SPF: pass client-ip=202.12.124.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

--yj0GnnuDYDkmNVLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 29 19:34, Minwoo Im wrote:
> nvme_del_sq() asserted r->aiocb was always set when canceling a
> queue's inflight requests. A pending Async Event Request has no
> aiocb (nvme_aer() parks it without issuing any block I/O), so
> deleting a queue with an outstanding AER trips the assert instead of
> just dropping the request.
>=20
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>  hw/nvme/ctrl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..e715de8247d1 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4858,12 +4858,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequ=
est *req)
>      sq =3D n->sq[qid];
>      while (!QTAILQ_EMPTY(&sq->out_req_list)) {
>          r =3D QTAILQ_FIRST(&sq->out_req_list);
> -        assert(r->aiocb);
>          r->status =3D NVME_CMD_ABORT_SQ_DEL;
> -        blk_aio_cancel(r->aiocb);
> -    }
> =20
> -    assert(QTAILQ_EMPTY(&sq->out_req_list));
> +        if (r->aiocb) {
> +            blk_aio_cancel(r->aiocb);
> +        } else {
> +            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
> +        }
> +    }
> =20
>      if (!nvme_check_cqid(n, sq->cqid)) {
>          cq =3D n->cq[sq->cqid];
> --=20
> 2.34.1
>=20
>=20

Thanks,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--yj0GnnuDYDkmNVLY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpsa5IACgkQTeGvMW1P
DelymQf/evsuqw+aH4yYNdECcTZmWwHtqcr8fp4QHqenGjBGOGLgdsGWqbR5vRsW
dXb2sQmJBTW5wWEXalrCGuiMB6tVejIglYXJNmCunfREhFMT80zeecwI8rcAHsny
ImRjdRbUO0ssAKPger6uRmbm2ET12E8Roo2k/lF509y6je5yR/N/t+Qy/qOfnB1b
IQ80AzyhknU3dEwGB0v8PrJySa/FLka0aMvIxHl9F+AVHUackPpaIQvbucJ0wBw4
3S9mi5QByMeqg0gaKM3FU6cjbotI0JM0e/EsURP138aQOh9PhZqvfc+A9n3rkBXf
Wwadtg+S/zK9IorNBmQKN2fndfcHZA==
=l7Vl
-----END PGP SIGNATURE-----

--yj0GnnuDYDkmNVLY--

