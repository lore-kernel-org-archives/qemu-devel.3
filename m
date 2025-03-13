Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72396C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscl4-0001q1-Rj; Thu, 13 Mar 2025 03:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsckq-0001lS-23
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tscko-0000jz-Ac
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygfaaLeXorOg3lvUKg9a9NSyVm9G7rtOImLX7sIYTUw=;
 b=Ddq5h1oMu4yrVl+MMyqNvqPb8+aIcrCr5ahHdtGamvNSa8922/YbfPNsJjn9pZxDKkEXtH
 8YpJnIDsD9UxRfe711/8VlxUxpXdrXvtUVNrgDKZtrdDQjhWpx+zQFrQOdeXTvs3Tyzz9b
 ttB4r84afnNJjM5TDh904yeSrZ4vZw4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-_UdMuDKiOGqhHzOIM4Yusg-1; Thu,
 13 Mar 2025 03:13:10 -0400
X-MC-Unique: _UdMuDKiOGqhHzOIM4Yusg-1
X-Mimecast-MFC-AGG-ID: _UdMuDKiOGqhHzOIM4Yusg_1741849989
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 746251800267; Thu, 13 Mar 2025 07:13:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11C451800268; Thu, 13 Mar 2025 07:13:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3058421E66C1; Thu, 13 Mar 2025 08:13:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Yi Liu <yi.l.liu@intel.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,  Bibo Mao
 <maobibo@loongson.cn>,  Peter Maydell <peter.maydell@linaro.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>
Subject: Re: Giving your own patches your Reviewed-by
In-Reply-To: <542252f1-d4f5-41a7-badd-c17acd94e8bf@eviden.com> (CLEMENT
 MATHIEU--DRIF's message of "Thu, 13 Mar 2025 06:45:52 +0000")
References: <878qpamvk6.fsf@pond.sub.org>
 <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
 <ca6ab1ec-4f30-4da7-ac08-3a514d8b4a02@intel.com>
 <542252f1-d4f5-41a7-badd-c17acd94e8bf@eviden.com>
Date: Thu, 13 Mar 2025 08:13:03 +0100
Message-ID: <87h63xcsjk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com> writes:

> On 12/03/2025 13:54, Yi Liu wrote:

[...]

>> Commit eda4c9b5b3c is the similar case. Zhenzhong and Cl=C3=A9ment took
>> the patch from me and I was cced when Zhenzhong sent it out. I gave
>> my r-b after reviewing it.
>
> Some other commits of the same series were in a similar situation:=20
> initially written by me and slightly changed by Zhenzhong.
> These are not caught by one-liner above because I deliberately didn't=20
> give an rb.
>
> According to Daniel it seems to be ok to review a co-authored patch but
> is this considered a last resort?

Ideally, patch review is a fresh look at things.  If you can't get such
"outsider" review, and it's not for lack of trying, you work with the
maintainer to figure out what to do.  If you *are* the maintainer, you
make a judgement call.

That said, recording meaningful work can't be wrong.  If you feel you
did meaningful review work, go ahead and add your R-by.


