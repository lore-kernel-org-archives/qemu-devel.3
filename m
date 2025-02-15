Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BAAC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 09:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjEMQ-00046F-M4; Sat, 15 Feb 2025 04:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tjEMN-000412-LW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 04:21:15 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tjEMK-00016D-Ki
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 04:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739611269; bh=T/lBQQUEjYxoF++jTScOVESLCoMUCLXIdWXrkSCEQ9g=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=vJFEj0dlHF9D2bU2n+F1/cYsWR9Bb6oMfJj+Zu1M/6RPP+39ZsShOEue74WcmNXRU
 asQ+UOo1zpQOkkypu2+NJGIuvr5zxhi7ELTed6YJh5ARiWkQsqmQJMCK0zHcCkJc/g
 ZVkFa0yTdoSw1z2/RMOmKtbdkfhuTNFCFcFRagERURhQSxtulWpohnJ6DAnKTiXrLb
 cZmRLk4WiEGGZwCEovCWSy7sumDhzQxn8hhokiNukXY/chGUSacPTzaevCtuiN48oF
 wDl4joFJH12tjHnq5LySdDZ9d1bFp4VsdPklcflDubZVKd2+V8aVUfQruhPaxC3fDT
 oa+jZJrE0IV2g==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 45C703F22326
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 01:21:09 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id r4tOMikMeNll for <qemu-devel@nongnu.org>;
 Sat, 15 Feb 2025 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739611266; bh=T/lBQQUEjYxoF++jTScOVESLCoMUCLXIdWXrkSCEQ9g=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=rFr3VASc8uIs+IKTrzAnpRztPMXD/ZEvEyC4dXv2QAmeWZos6bnN9kB44R/p6uU5w
 lISC8KwiSaLLa2HjB0vocJfFM58MAPjZdRZDysKokjyFNez3GCvEm1lQRAz9rgZOv/
 woDqQ98lQKgECxxGrdqLKcBN+nNttLp7f5lgSUOU59jLw0PXejtG2Pyptf7kBvkJGo
 qMLKc5WsZBZo/u+rIjh6pQF+LIkaCkAr2Lor8ioARxPWrxRn5aIwrdi82ZgJRxmjnQ
 hxZcVAyFqKxFukp2/67mxiQSsbmzmrvLPhaoHcC3Afw8ecwmUwA0nhUJugZpdfHBHh
 JQUpCTWoePbtw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id E8EF03F207AB
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 01:21:06 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id ACF8A1E60096; Sat, 15 Feb 2025 01:21:06 -0800 (PST)
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] target/rx: Remove TCG_CALL_NO_WG from helpers which
 write env
In-Reply-To: <20250215021654.1786679-6-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-6-keithp@keithp.com>
Date: Sat, 15 Feb 2025 01:21:06 -0800
Message-ID: <87jz9r1s3h.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Functions which modify virtual machine state (such as virtual
> registers stored in memory) must not be marked TCG_CALL_NO_WG as that
> tells the optimizer that virtual registers values already loaded in
> machine registers are still valid, hence discards any changes which
> these helpers may have made.

I still don't understand the restrictions on using these flags. I just
had to disable this flag for other helpers which only set conditions
codes in PSW and FPSW. Is that expected? When are these flags supposed
to be valid?

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmewXIIACgkQ2yIaaQAA
ABFy7A//Y37uywu0XpRQYjb4KCoWkV1pJkmqp8p42vlGE46clEQ0TXBuZtAUB6vf
4k7xm79iXVsmsz+MImZ5nidH+6crbJ/o3Hrtvnz++r55To4n61kdiU2KCgawoPGP
y/7phUJzrEkc7z3AbA310L0memBHDjRdBCxHlT/x+iGLVaHf4JeuMW7XGH7fqH6c
rru+L3iFSNV0sMiob/+DglilOAyg5OzlbLiNmYbITNXUuBvQfxz4MGGM9PT4n2tU
AM5O3tjbAUYScigOOjJehithON2hg5571dVWgTjqVi6g1qmj1R2H9+md//WMuoBB
ZHub1o2IeU8ofg2xarL1nvY6kznja1XxW+G5pPwAY//KO9Jgc3E5dtil4XvdOGCQ
sEoWoKQSqtfv7wzQZEy0znEjfnttdKX9jXWW1GjnF1er2Y9Pm6yXKVhGz78ftCfk
2KJ+8ia2YO7NKgvmB/LmXQAJlQz8uexZ3CqPVPfbv52zXD6d8BBaGPIWeUXGWQdO
qGD5vyVq53FXI9+EB08DYximMrzB7hdVqLeamG5euTW5Lgx/NN2wlCp0aLJFk5A2
G4SQPdoC5NAqrq5S7xlzcNT2nzOwzDjmfL6rsByQnqKKdQonOLPzgduVOfSIYHTQ
RLezv6Ygo+VJLkYxd7FmbtE8oPYEFuOcHuA+mCOwpTQDseShUZ4=
=KqAo
-----END PGP SIGNATURE-----
--=-=-=--

