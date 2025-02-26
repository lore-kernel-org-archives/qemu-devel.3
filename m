Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC98BC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnD6b-0007Hu-Ta; Wed, 26 Feb 2025 03:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnD6Z-0007H6-UD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnD6X-0006ZV-Co
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740559760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WIke/5wFFAVBF717oIdaxiq8oeoftnPkjl3krB0J3GM=;
 b=hZ6/QkY0Qxrlg9OajIJVsPUs+gMzDLxNhc5F4vvc5ecZTOK1BJsIVZpEIJCzbpyHWmhnrX
 lWNKEVrirHVJzEE5AfgDl7TM6QutGHOmoWkjUeigCXtq+3yYocUA8iCvfTYDzdSZbGd27E
 BmhzkLA21MXbxrj2UsD4zYUftHMBaRk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-0Qgf05MDOLGSEVW2VELDVg-1; Wed,
 26 Feb 2025 03:49:17 -0500
X-MC-Unique: 0Qgf05MDOLGSEVW2VELDVg-1
X-Mimecast-MFC-AGG-ID: 0Qgf05MDOLGSEVW2VELDVg_1740559756
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B6CE196E078; Wed, 26 Feb 2025 08:49:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58C691955BD4; Wed, 26 Feb 2025 08:49:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E957021E675E; Wed, 26 Feb 2025 09:49:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] qapi/char.json: minor doc rewording for `hub` device
In-Reply-To: <CACZ9PQUAvarw7yZxUTYXQY2+n6F=A8aZbf498Mf0rP37_W8Z7g@mail.gmail.com>
 (Roman Penyaev's message of "Wed, 26 Feb 2025 09:02:25 +0100")
References: <20250219090607.559887-1-r.peniaev@gmail.com>
 <87frka12zq.fsf@pond.sub.org>
 <CACZ9PQUAvarw7yZxUTYXQY2+n6F=A8aZbf498Mf0rP37_W8Z7g@mail.gmail.com>
Date: Wed, 26 Feb 2025 09:49:13 +0100
Message-ID: <87y0xt2ira.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> Hi Marc-Andre,
>
> If you don't have objections to this one small doc change,
> could you please pull the change?

I'm working on a pull request, and I'm happy to include this patch.


