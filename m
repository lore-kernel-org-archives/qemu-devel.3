Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C69C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGGf-0008Pj-CI; Mon, 13 Jul 2026 09:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGGW-0008PP-D9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGGS-00079h-Mj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k28s8fWtXtRhuZG85v5QKUt8IiIXnNIzhjaG9kOU+1g=;
 b=cd69FAuVdRWn/m4I7koJ2ssgYDXgAoNOrAAdjy4zy0o9hTByN5jn+amXgpLBFbKX/LjjwJ
 hjKfYhqI3VQUysFhu5l37TEe0nfuLbcaItTdejC32cEsm75JLVA39od2RKV/ah0YLVgA3y
 3yefR1lck5B3dOCjPbYvSGrUrfqfmDE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-kWoxTyTHN_W-b_OFt9v6vA-1; Mon,
 13 Jul 2026 09:00:00 -0400
X-MC-Unique: kWoxTyTHN_W-b_OFt9v6vA-1
X-Mimecast-MFC-AGG-ID: kWoxTyTHN_W-b_OFt9v6vA_1783947599
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AD2D1955BC1; Mon, 13 Jul 2026 12:59:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 202781800593; Mon, 13 Jul 2026 12:59:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 888BC21E6920; Mon, 13 Jul 2026 14:59:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  linux-edac@vger.kernel.org,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  Alex Williamson
 <alex@shazbot.org>,  Paolo Bonzini <pbonzini@redhat.com>,  zhenwei pi
 <zhenwei.pi@linux.dev>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Eric Blake <eblake@redhat.com>,  =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater
 <clg@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu
 <zhao1.liu@intel.com>,  Lukas Straub <lukasstraub2@web.de>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/14] qapi: convert to explicit intro section syntax
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com> (John Snow's message
 of "Mon, 29 Jun 2026 17:36:10 -0400")
References: <20260629213624.936258-1-jsnow@redhat.com>
Date: Mon, 13 Jul 2026 14:59:54 +0200
Message-ID: <87ech7gi45.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2638342206
>
> Hi, this patchset converts some of the most trivial modules to use the
> new explicit intro syntax. This particular patchset does not
> differentiate between "trivial" conversions and those that take
> slightly more liberty in refactoring, but there are (debatably?) no
> such cases in this patchset.

Looks entirely mechanical to me.  Am I missing anything?


