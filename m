Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE11CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUiDQ-00018D-0V; Wed, 03 Jun 2026 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUiDN-00017g-F5
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUiDM-0007DB-1h
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780480123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSHr85HJ/QULiB83aDhYle9gsiafs+He26kyRPUzyho=;
 b=I7IWtcYSEHRj3e/pIYFZIc72wFYwzrHU5aAS/1V2xREFTfp1onYtrS7SoY8lrTKlTA8asi
 IMoo+weIjiC5q9oG/w/JLd7/SY3ohSvK8hrEojAlEhDx1CiU+U3M4GAkCy4zJlyfqrRzHf
 6FZxn9ZOF3+k0RGq71D36VFi5WKwK1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-mPEQgeUSPGeY7BaRFUycrw-1; Wed,
 03 Jun 2026 05:48:39 -0400
X-MC-Unique: mPEQgeUSPGeY7BaRFUycrw-1
X-Mimecast-MFC-AGG-ID: mPEQgeUSPGeY7BaRFUycrw_1780480118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70FF319560A2; Wed,  3 Jun 2026 09:48:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE157180049F; Wed,  3 Jun 2026 09:48:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F35421E6A01; Wed, 03 Jun 2026 11:48:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v2 00/38] MAINTAINERS: Fix F: lines
In-Reply-To: <41ef9019-99f2-48d3-bc9e-8739f95865fc@mailo.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 3 Jun 2026 09:28:54
 +0200")
References: <20260603064032.3733394-1-armbru@redhat.com>
 <41ef9019-99f2-48d3-bc9e-8739f95865fc@mailo.com>
Date: Wed, 03 Jun 2026 11:48:35 +0200
Message-ID: <87tsrkkl8s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com> writes:

> Hi Markus,
>
> On 3/6/26 08:39, Markus Armbruster wrote:
>> Quite a few F: lines don't match any files.  The quick & dirty check
>>=20
>>      $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>=20
>> finds about fifty.
>>=20
>> Philippe Mathieu-Daud=C3=A9 recently posted a few fixes:
>>=20
>>    MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>    MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch secti=
on
>>    MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>    MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>    MAINTAINERS: Cover python.docker with Python library section
>>    MAINTAINERS: Fix s390x storage key/attribute device paths
>>    MAINTAINERS: Fix tcg/s390x/ path
>>    MAINTAINERS: Correct scripts/coverity-model.c path
>>    MAINTAINERS: Fix RISCV related paths
>>    MAINTAINERS: Fix hexagon-linux-user.mak path
>>=20
>> These are in
>>=20
>>     Subject: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
>>     Date: Mon, 18 May 2026 12:22:15 +0200
>>     Message-ID: <20260518102222.80735-1-philmd@linaro.org>
>>=20
>>     Subject: [PATCH v2 0/4] buildsys: Stop checking for ESA/390 host
>>     Date: Tue, 19 May 2026 19:12:36 +0200
>>     Message-ID: <20260519171240.97420-1-philmd@linaro.org>
>>=20
>>     Subject: [PATCH] MAINTAINERS: Correct scripts/coverity-model.c path
>>     Date: Tue, 19 May 2026 19:19:26 +0200
>>     Message-ID: <20260519171926.98099-1-philmd@linaro.org>
>>=20
>>     Subject: [PATCH] MAINTAINERS: Fix RISCV related paths
>>     Date: Tue, 19 May 2026 19:26:21 +0200
>>     Message-ID: <20260519172621.98469-1-philmd@linaro.org>
>>=20
>>     Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
>>     Date: Wed, 20 May 2026 14:39:47 +0200
>>     Message-ID: <20260520123947.12711-1-philmd@linaro.org>
>>=20
>> This series takes care of the remainder, except for one discussed
>> next.  It applies cleanly with and without Philippe's patches.
>
> Not sure if you are expecting something from me here, I dropped
> these thinking you'd include them in your cleanup series or in
> a PR.

I do not expect anything from you at this time.

Since my patches apply fine without yours, I posted them without yours.

If I post a PR for mine, I will of course include yours, along with
other MAINTAINERS patches that are ready, if any.

[...]


