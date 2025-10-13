Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DCECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HUT-0004zg-8S; Mon, 13 Oct 2025 08:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8HUQ-0004zE-56
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8HUE-00048G-0e
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760357812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMOKmOY2SI14PC2niT4Nxzad4dSlDi9rBck7aiSfyvw=;
 b=ZzL/T3bXLI/loi3m86QbmPqVRIZYFdZ7xmBAWSxO9AC+lCMdT31zyqlwn4JH1TVCDudbOr
 qYOJaVg39v/n9u2lNhWFCNh/tkVJVH9Py4BdqTANmqrncabsovaNxwjElS/HLU4KSowBRZ
 e3dGTaO8U0vh0BwOaWpbjYO6lYVrvVs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Rtbo_Qw9NrWih63tStU8TQ-1; Mon,
 13 Oct 2025 08:16:43 -0400
X-MC-Unique: Rtbo_Qw9NrWih63tStU8TQ-1
X-Mimecast-MFC-AGG-ID: Rtbo_Qw9NrWih63tStU8TQ_1760357802
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9D76180034C; Mon, 13 Oct 2025 12:16:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03E9530002CE; Mon, 13 Oct 2025 12:16:33 +0000 (UTC)
Date: Mon, 13 Oct 2025 14:16:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, viktor.prutyanov@phystech.edu,
 hreitz@redhat.com, kwolf@redhat.com, maochenxi@bosc.ac.cn,
 berrange@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Message-ID: <aOztn9fdKGaV2eVj@redhat.com>
References: <20251009141026.4042021-1-rjones@redhat.com>
 <20251009141026.4042021-2-rjones@redhat.com>
 <5b5e10b1-cede-42da-91ae-72f2d5172116@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b5e10b1-cede-42da-91ae-72f2d5172116@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

[Restored the original Cc: list]

Am 10.10.2025 um 21:03 hat Richard Henderson geschrieben:
> On 10/9/25 07:08, Richard W.M. Jones wrote:
> > curl_easy_setopt takes a variable argument that depends on what
> > CURLOPT you are setting.  Some require a long constant.  Passing a
> > plain int constant is potentially wrong on some platforms.
> > 
> > With warnings enabled, multiple warnings like this were printed:
> > 
> > ../block/curl.c: In function ‘curl_init_state’:
> > ../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
> >    474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
> >        |             ^

It would have been good to mention on which platforms/compilers/curl
versions you get the warning (and why only now), because I don't see
this warning even after reverting the commit.

It's too late for the commit message now, but maybe we can at least have
it here, in the mailing list thread associated with the Message-ID in
the commit?

> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   block/curl.c               | 10 +++++-----
> >   contrib/elf2dmp/download.c |  4 ++--
> >   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> Thanks.  I directly applied this to master during the last PR batch.

Please don't drop CCs in replies. This is true in general, but even more
so if it's CCs for the maintainers you're bypassing.

Kevin


