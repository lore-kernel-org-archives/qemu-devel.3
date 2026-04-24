Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523B3FB44C4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAoA-0003SA-Ie; Fri, 24 Apr 2026 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGAo8-0003OI-48
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGAo6-0002Ix-JO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777015113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPl6j4oJkEBTqsDhFVaI6c5vDGJqBTZ6eWl/XQYCtEA=;
 b=K5Ppqis/Pcd8w+F97JSswUGwGRvc+9iL/j3XDjKK49StQ2jklAwmIq6DSWQyb6UzUHS2YG
 +iRKbfcZKMALIsAVpUduJ/ue0zMiFXdZZ4/4rPta2eZPYIcqKLmbZG2PxIVAXCA3y6/Msc
 EqAydVZJJlp3JkhFx7wkuUpTgFzeJM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-BDVX_r4nP-CDfqUHuhQQxw-1; Fri,
 24 Apr 2026 03:18:32 -0400
X-MC-Unique: BDVX_r4nP-CDfqUHuhQQxw-1
X-Mimecast-MFC-AGG-ID: BDVX_r4nP-CDfqUHuhQQxw_1777015110
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246131800378; Fri, 24 Apr 2026 07:18:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4C319560AB; Fri, 24 Apr 2026 07:18:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1669A21E6A28; Fri, 24 Apr 2026 09:18:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Avihai Horon
 <avihaih@nvidia.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,  Kirti Wankhede <kwankhede@nvidia.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 15/16] migration/qapi: Update unit for
 avail-switchover-bandwidth
In-Reply-To: <20260421202110.306051-16-peterx@redhat.com> (Peter Xu's message
 of "Tue, 21 Apr 2026 16:21:09 -0400")
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-16-peterx@redhat.com>
Date: Fri, 24 Apr 2026 09:18:27 +0200
Message-ID: <878qacvnb0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Add ", in bytes per second".  Unfortunately indentations need to be updated
> completely, but no change on the rest.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Juraj Marcin <jmarcin@redhat.com>
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>


