Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9772C54E4A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 06:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riqdb-0002jO-Nn; Sat, 09 Mar 2024 01:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1riqdZ-0002iG-Ul
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 01:56:53 -0500
Received: from out-177.mta1.migadu.com ([95.215.58.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1riqdW-0000F0-Oz
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 01:56:53 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709967408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj60nUs2fxU9scDwGWikRl4/aau5YaBdMc6G8b9w06Q=;
 b=r4TCUafuM0c6/QbKEDP4k3iI60qKq+Q5igw5QvLWbJ69ZdtzClX011ThGNnK7bArHwqNSw
 q1SPA+HeL2g6yTJpePw1yp4Sl8OKzfJoVo+6NJrDgT+M+y4PJ3xWmQGiey2PK7+YefY+bW
 tRHgAzr8aquW7LgTI3yEP4pYm7ESFK0=
Date: Sat, 09 Mar 2024 06:56:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <b52151927137b7f40a5b15fcea256d11da9935be@linux.dev>
TLS-Required: No
Subject: Re: [External] Re: [PATCH v4 6/7] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
To: armbru@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
In-Reply-To: <CAAYibXjyMT5YJqOcDheDUB1qzi+JjFhAcv3L57zM9pCFMGbYbw@mail.gmail.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-7-hao.xiang@bytedance.com>
 <87ttlqpfgr.fsf@pond.sub.org>
 <CAAYibXjyMT5YJqOcDheDUB1qzi+JjFhAcv3L57zM9pCFMGbYbw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.177; envelope-from=hao.xiang@linux.dev;
 helo=out-177.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>=20
>=20On Thu, Feb 29, 2024 at 11:40 PM Markus Armbruster <armbru@redhat.com=
> wrote:
>=20
>=20>=20
>=20> Hao Xiang <hao.xiang@bytedance.com> writes:
> >=20
>=20>  This change extends the MigrationStatus interface to track zero pa=
ges
> >=20
>=20>  and zero bytes counter.
> >=20
>=20>  Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >=20
>=20>  [...]
> >=20
>=20>  diff --git a/qapi/migration.json b/qapi/migration.json
> >=20
>=20>  index ca9561fbf1..03b850bab7 100644
> >=20
>=20>  --- a/qapi/migration.json
> >=20
>=20>  +++ b/qapi/migration.json
> >=20
>=20>  @@ -63,6 +63,10 @@
> >=20
>=20>  # between 0 and @dirty-sync-count * @multifd-channels. (since
> >=20
>=20>  # 7.1)
> >=20
>=20>  #
> >=20
>=20>  +# @zero-pages: number of zero pages (since 9.0)
> >=20
>=20>  +#
> >=20
>=20>  +# @zero-bytes: number of zero bytes sent (since 9.0)
> >=20
>=20>  +#
> >=20
>=20>  Discussion of v3 has led me to believe:
> >=20
>=20>  1. A page is either migrated as a normal page or as a zero page.
> >=20
>=20>  2. The following equations hold:
> >=20
>=20>  @normal-bytes =3D @normal * @page-size
> >=20
>=20>  @zero-bytes =3D @zero-pages * @page-size
> >=20
>=20>  3. @zero-pages is the same as @duplicate, with a better name. We i=
ntend
> >=20
>=20>  to drop @duplicate eventually.
> >=20
>=20>  If this is correct, I'd like you to
> >=20
>=20>  A. Name it @zero for consistency with @normal. Disregard my advice=
 to
> >=20
>=20>  name it @zero-pages; two consistent bad names are better than one =
bad
> >=20
>=20>  name, one good name, and inconsistency.
> >=20
>=20>  B. Add @zero and @zero-bytes next to @normal and @normal-bytes.
> >=20
>=20>  C. Deprecate @duplicate (item 3). Separate patch, please.
> >=20
>=20>  D. Consider documenting more clearly what normal and zero pages ar=
e
> >=20
>=20>  (item 1), and how @FOO, @FOO-pages and @page-size are related (ite=
m
> >=20
>=20>  2). Could be done in a followup patch.

I will move this out of the current patchset and put them into a seperate=
 patchset. I think I am not totally understanding the exact process of de=
precating an interface and hence will need your help to probably go a few=
 more versions. And I read from earlier conversation the soft release for=
 QEMU9.0 is 3/12 so hopefully the rest of this patchset can catch it.

> >=20
>=20>  # Features:
> >=20
>=20>  #
> >=20
>=20>  # @deprecated: Member @skipped is always zero since 1.5.3
> >=20
>=20>  @@ -81,7 +85,8 @@
> >=20
>=20>  'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> >=20
>=20>  'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
> >=20
>=20>  'postcopy-bytes': 'uint64',
> >=20
>=20>  - 'dirty-sync-missed-zero-copy': 'uint64' } }
> >=20
>=20>  + 'dirty-sync-missed-zero-copy': 'uint64',
> >=20
>=20>  + 'zero-pages': 'int', 'zero-bytes': 'size' } }
> >=20
>=20>  [...]
> >
>

