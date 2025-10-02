Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61203CCA472
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4F19-0005lA-T4; Thu, 02 Oct 2025 04:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4F13-0005df-2d
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:50:21 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1v4F0l-00038t-NF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1759395004; x=1790931004;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=hyffX+jy6px+0Nq2TWzG3/pMhIY3pgCCom7dcW4B7xo=;
 b=frtxitTS9UTteHgLsPf71cYsg+tEU66MOybaV6BIIN6YqiGm32A8ReaJ
 rAqBy5VbF4WEQmNG/SUaO3/0AjZvoC7MbTNKkeTG0OWzPtfrrlVc0NMpl
 27Yucu9gOXKrYxZniJUox9xclB3yIx3oXJ5HKoHr7iiZhfNoplSZVyibr M=;
X-CSE-ConnectionGUID: eIcHfTgpT+O6PnIufibRsg==
X-CSE-MsgGUID: kMv/62XtSoaCPQTQckLgxA==
X-IronPort-AV: E=Sophos;i="6.18,309,1751234400"; 
   d="scan'208";a="3128560"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 02 Oct 2025 10:49:46 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <20251001161823.2032399-4-Marco.Cavenati@eurecom.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-4-Marco.Cavenati@eurecom.fr>
Date: Thu, 02 Oct 2025 10:49:45 +0200
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 ppandit@redhat.com, berrange@redhat.com
To: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Message-ID: <26083e-68de3c80-5f3-4691f480@28926673>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/3] =?utf-8?q?migration=3A?=
 =?utf-8?q?_mapped-ram=3A?= handle zero pages
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
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

Please note that there are a couple of errors (swapped parameters), whi=
ch are
detailed below.
I will address these in the next iteration, along with any additional c=
hanges
based on your feedback.

Thank you
Marco

On Wednesday, October 01, 2025 18:18 CEST, Marco Cavenati <Marco.Cavena=
ti@eurecom.fr> wrote:

> Make mapped-ram compatible with loadvm snapshot restoring by explicit=
ly
> zeroing memory pages in this case.
> Skip zeroing for -incoming and -loadvm migrations to preserve perform=
ance.
>=20
> Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> ---
>  migration/ram.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++=
+-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index e238c9233f..597d5ffe9e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3958,12 +3958,55 @@ static size=5Ft ram=5Fload=5Fmultifd=5Fpages(=
void *host=5Faddr, size=5Ft size,
>      return size;
>  }
> =20
> +/**
> + * handle=5Fzero=5Fmapped=5Fram: Zero out a range of RAM pages if re=
quired during
> + * mapped-ram load
> + *
> + * Zeroing is only performed when restoring from a snapshot (HMP loa=
dvm).
> + * During incoming migration or -loadvm cli snapshot load, the funct=
ion is a
> + * no-op and returns true as in those cases the pages are already gu=
aranteed to
> + * be zeroed.
> + *
> + * Returns: true on success, false on error (with @errp set).
> + * @from=5Fbit=5Fidx: Starting index relative to the map of the page=
 (inclusive)
> + * @to=5Fbit=5Fidx:   Ending index relative to the map of the page (=
exclusive)
> + */
> +static bool handle=5Fzero=5Fmapped=5Fram(RAMBlock *block, unsigned l=
ong from=5Fbit=5Fidx,
> +                                   unsigned long to=5Fbit=5Fidx, Err=
or **errp)
> +{
> +    ERRP=5FGUARD();
> +    ram=5Faddr=5Ft offset;
> +    size=5Ft size;
> +    void *host;
> +
> +    if (runstate=5Fcheck(RUN=5FSTATE=5FINMIGRATE) ||
> +        runstate=5Fcheck(RUN=5FSTATE=5FPRELAUNCH)) {
> +        return true;
> +    }
> +
> +    if (from=5Fbit=5Fidx =3D=3D to=5Fbit=5Fidx) {
> +        return true;
> +    }
> +
> +    size =3D TARGET=5FPAGE=5FSIZE * (to=5Fbit=5Fidx - from=5Fbit=5Fi=
dx);
> +    offset =3D from=5Fbit=5Fidx << TARGET=5FPAGE=5FBITS;
> +    host =3D host=5Ffrom=5Fram=5Fblock=5Foffset(block, offset);
> +    if (!host) {
> +        error=5Fsetg(errp, "zero page outside of ramblock %s range",
> +                   block->idstr);
> +        return false;
> +    }
> +    ram=5Fhandle=5Fzero(host, size);
> +
> +    return true;
> +}
> +
>  static bool read=5Framblock=5Fmapped=5Fram(QEMUFile *f, RAMBlock *bl=
ock,
>                                       long num=5Fpages, unsigned long=
 *bitmap,
>                                       Error **errp)
>  {
>      ERRP=5FGUARD();
> -    unsigned long set=5Fbit=5Fidx, clear=5Fbit=5Fidx;
> +    unsigned long set=5Fbit=5Fidx, clear=5Fbit=5Fidx =3D 0;
>      ram=5Faddr=5Ft offset;
>      void *host;
>      size=5Ft read, unread, size;
> @@ -3972,6 +4015,12 @@ static bool read=5Framblock=5Fmapped=5Fram(QEM=
UFile *f, RAMBlock *block,
>           set=5Fbit=5Fidx < num=5Fpages;
>           set=5Fbit=5Fidx =3D find=5Fnext=5Fbit(bitmap, num=5Fpages, =
clear=5Fbit=5Fidx + 1)) {
> =20
> +        /* Zero pages */
> +        if (!handle=5Fzero=5Fmapped=5Fram(block, set=5Fbit=5Fidx, cl=
ear=5Fbit=5Fidx, errp)) {

This should be
+         if (!handle=5Fzero=5Fmapped=5Fram(block, clear=5Fbit=5Fidx, s=
et=5Fbit=5Fidx, errp)) {

> +            return false;
> +        }
> +
> +        /* Non-zero pages */
>          clear=5Fbit=5Fidx =3D find=5Fnext=5Fzero=5Fbit(bitmap, num=5F=
pages, set=5Fbit=5Fidx + 1);
> =20
>          unread =3D TARGET=5FPAGE=5FSIZE * (clear=5Fbit=5Fidx - set=5F=
bit=5Fidx);
> @@ -4003,6 +4052,11 @@ static bool read=5Framblock=5Fmapped=5Fram(QEM=
UFile *f, RAMBlock *block,
>          }
>      }
> =20
> +    /* Handle trailing 0 pages */
> +    if (!handle=5Fzero=5Fmapped=5Fram(block, num=5Fpages, clear=5Fbi=
t=5Fidx, errp)) {

This should be
+    if (!handle=5Fzero=5Fmapped=5Fram(block, clear=5Fbit=5Fidx, num=5F=
pages, errp)) {

> +        return false;
> +    }
> +
>      return true;
> =20
>  err:
> --=20
> 2.48.1
>


