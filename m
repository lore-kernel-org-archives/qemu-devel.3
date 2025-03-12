Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B41CC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJ3S-0005XG-Nu; Wed, 12 Mar 2025 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsJ3Q-0005VX-5l
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsJ3L-0006Pd-92
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741774264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsLoqxuYpvPWnVCJ/PNV5zMKUzyxQgiCMruqWlq97LI=;
 b=a7eQ38MbjrFxDRo8UXtjWNZPcWTPD6KHJCtXPWNJ6LviMXawiY7wSgEmvSzf2FL+QnyZkR
 w+ibfvX5aATBVJJAU4CO/q6Re7xCrCbKpw+QHWS63sywZQujRDus6T3qHhMf82spTX9/Ye
 3E/l2H5Y0K4kY/VpyGhaYFjnHzQVkdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113--X4k600bOXeowWSYYSefzw-1; Wed,
 12 Mar 2025 06:11:01 -0400
X-MC-Unique: -X4k600bOXeowWSYYSefzw-1
X-Mimecast-MFC-AGG-ID: -X4k600bOXeowWSYYSefzw_1741774260
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C79A1955BC1; Wed, 12 Mar 2025 10:10:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C5F21828A98; Wed, 12 Mar 2025 10:10:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 494A521E675E; Wed, 12 Mar 2025 11:10:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Akihiko
 Odaki <akihiko.odaki@daynix.com>,  Bibo Mao <maobibo@loongson.cn>,  Peter
 Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?=
 Mathieu--Drif <clement.mathieu--drif@eviden.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>
Subject: Re: Giving your own patches your Reviewed-by
In-Reply-To: <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 12 Mar 2025 11:03:04
 +0100")
References: <878qpamvk6.fsf@pond.sub.org>
 <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
Date: Wed, 12 Mar 2025 11:10:49 +0100
Message-ID: <87a59qlfti.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Markus,
>
(Cc'ing Yi, Cl=C3=A9ment and Zhenzhong for commit eda4c9b5b3c)
>
> On 12/3/25 10:45, Markus Armbruster wrote:
>> I stumbled over commits that carry the author's Reviewed-by.
>>=20
>> There may be cases where the recorded author isn't the lone author, and
>> the recorded author did some meaningful review of the patch's parts that
>> are not theirs.  Mind that we do need all authors to provide their
>> Signed-off-by.
>>=20
>> When the only Signed-off-by is from the recorded author, and there's
>> also their Reviewed-by, the Reviewed-by is almost certainly bogus.
>>=20
>> Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
>> help reduce the accident rate :)
>>=20
>> Here's my quick & sloppy search for potentially problematic uses of
>> Reviewed-by:
>>=20
>> $ git-log --since 'two years ago' | awk -F: '/^commit / { commit=3D$0 } =
/^Author: / { guy=3D$2 } /^    Reviewed-by: / { if ($2 =3D=3D guy) { print =
commit; print guy } }'
>
>
> Explaining some commits where I'm mentioned:

[...]

> Is this workflow making sense and accepted? Otherwise what should
> we change? Maybe clarify along with the tags; or including all
> Message-Id could make this easier to track?

The workflow is good enough as is if you ask me.

Note that the patches you quoted all have more than one Signed-off-by.
My quick & sloppy search neglects to filter these out :)


