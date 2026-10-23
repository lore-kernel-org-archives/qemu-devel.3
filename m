Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECE606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=hQ808bkU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJSJ-0003OB-LA; Fri, 23 Oct 2026 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKJSH-0003Np-Sq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:53:25 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xKJSF-00038I-Ra
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:53:25 -0400
Message-ID: <a1b9fb9e6c9c5bd6e7d3b5ebc0983662a39629b3.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792778000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0zP4PJq9LufZZK/RXdRaGYZ/+c3CWBWcLGDBz2Oecw=;
 b=hQ808bkUvDTF1kEvN2w/OprwC6HDNXoF0PWeqT3786fwlRJ8H+NcYOntIjq9x+io7YOgWL
 euG5cfm+Jx1h3e/J2tFeRaW0ID8IFyMZuOV1HfgBrCwF/bewoFntucf9fxRoR2jpuqjh+E
 lD4CuaHNqrYy5I5SG7Qyc9EoSKS54Rw=
Subject: Re: [PATCH] accel/tcg: Do not chain from a TB freed by
 tb_gen_code's flush
From: Stian Halseth <stian@itx.no>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Matt Turner <mattst88@gmail.com>
Date: Fri, 23 Oct 2026 19:53:19 +0200
In-Reply-To: <8733tws5yt.fsf@draig.linaro.org>
References: <20261023113245.562358-1-stian@itx.no>
 <8733tws5yt.fsf@draig.linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-ZqaZQl4K+0M96Y2LlKbj"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-ZqaZQl4K+0M96Y2LlKbj
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Fri, 2026-10-23 at 18:05 +0100, Alex Benn=E9e wrote:
> I wonder how much:
>=20
> =A0=A0=A0=A0=A0=A0=A0 /* flush must be done */
> =A0=A0=A0=A0=A0=A0=A0 if (cpu_in_serial_context(cpu)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_tb_gen_code_buffer_overflow("tcg_=
tb_alloc");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tb_flush__exclusive_or_serial();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto buffer_overflow;
> =A0=A0=A0=A0=A0=A0=A0 }
>=20
> actually saves? Because we are skipping both cleanup in cpu_loop_exit
> (the mem helpers) and cpu_exec_longjmp_cleanup which we get to when
> we jump out.

Not much, as far as I can measure. I timed the sparc64 reproducer with
-tb-size 1, where the buffer flushes constantly, so the worst case for
the longjmp, with three variants on current master:

- this patch (keep the shortcut, drop last_tb)
- flush in place, then leave through cpu_loop_exit()
- drop the shortcut, back to queue_tb_flush() + cpu_loop_exit()

All three fix the crash and pass test-xpage-chain and tb-link, and the
run times are within noise of each other.

Dropping the shortcut looks like the cleaner fix though. no last_tb
bookkeeping, and the cleanup you mention runs again. Richard, would you
prefer that as v2, or is there a case where the in-place retry matters,
e.g. cpu_exec_step_atomic?

/Stian

--=-ZqaZQl4K+0M96Y2LlKbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatufDwAKCRDoeAEuJe36
VujcAP92DZrslT9ySfb4gTfe6Sfp/5paE77faHcD6jIN/NMbcwD/Y6jXYAhsCa/s
3aRpVc0wRB0U/SngaxfshSv31rUjRgI=
=X+/6
-----END PGP SIGNATURE-----

--=-ZqaZQl4K+0M96Y2LlKbj--

