Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E1D29C36
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqlV-0003nS-4g; Mon, 19 Jan 2026 10:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqlT-0003my-Cz
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhqlR-0002uK-IL
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768834916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nd9+4K82OqUbNnr+hwh6S7L8Uy5+O48ckJN/MqUavIc=;
 b=JUllsZfjKlp3t3qgV0RB5+KJ0JhcKi9n4JXH+pr6QlnBpxiyUITrbY122T3V8jqqPt8XI/
 474eqxvwz5ozAiYX8Yvr+/En2cxGE1ZZtahlkqAaYN2IOe1j1etbSA9aKFtZ4ZjeSvFL5H
 hww9zibpx8zG3uQccjDkEZbnR58xdRo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-NdbWNaEOMoK7-Ta65kgntg-1; Mon,
 19 Jan 2026 10:01:51 -0500
X-MC-Unique: NdbWNaEOMoK7-Ta65kgntg-1
X-Mimecast-MFC-AGG-ID: NdbWNaEOMoK7-Ta65kgntg_1768834910
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 480221956052; Mon, 19 Jan 2026 15:01:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFE3819560A2; Mon, 19 Jan 2026 15:01:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40EE821E692D; Mon, 19 Jan 2026 16:01:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>,  Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/4] docs: avoid unintended mailto: hyperlinks
In-Reply-To: <20260115142629.665319-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 15 Jan 2026 14:26:27 +0000")
References: <20260115142629.665319-1-peter.maydell@linaro.org>
 <20260115142629.665319-3-peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 16:01:47 +0100
Message-ID: <87jyxdlk84.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In rST documents, an '@' character in normal text or a parsed-literal is
> assumed to be an email address and will result in a 'mailto:' hyperlink in
> the generated HTML.  In several places we have mailto: hyperlinks that are
> unintended nonsense; correct these by either escaping the @ character or
> making the text use ``...`` preformatted rendering.
>
> This commit covers only the simple cases which can be trivially fixed
> with escaping or ``..``; the remaining cases will be handled in
> separate commits.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


