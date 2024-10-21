Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D489DD15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vM9-0003qg-Ks; Mon, 21 Oct 2024 12:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vM6-0003ls-5h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2vM4-0005w9-CF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzZmwzaQd04bedMVTIrI5FXhQT55ZcAeMrc7nCoKkJM=;
 b=EYJWvi0aEjuX1b+ZFSub+GNA53aK5p74cn40G6qcsKxPXhxImtrkGRQ50dZvKfdCca2prp
 LNfBbTry+7YIdAqVN5tbZhDgzVEMDqKidREYzQxe3Kvv1K4dLT2QuPJl+fJD9aKgiNRiuq
 bfy2SzChqxsIIQfsTTiLQ0sKCkBqe4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-k7n0KNz6M4Ct4EUVikydcg-1; Mon,
 21 Oct 2024 12:34:01 -0400
X-MC-Unique: k7n0KNz6M4Ct4EUVikydcg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEDED1956046; Mon, 21 Oct 2024 16:34:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED83C19560AA; Mon, 21 Oct 2024 16:33:58 +0000 (UTC)
Date: Mon, 21 Oct 2024 17:33:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/5] tests/migration: Move the guestperf tool to
 scripts directory
Message-ID: <ZxaCczNvLbYiizdJ@redhat.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
 <52c9b1f94ef5a9451e462a27ca8386190317e22b.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c9b1f94ef5a9451e462a27ca8386190317e22b.1729275266.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 19, 2024 at 02:25:03AM +0800, Hyman Huang wrote:
> Guestperf was designed to test the performance of migration,
> with a loose connection to the fundamental test cases of QEMU.
> 
> To improve the repository's structure, move it to the scripts
> directory.
> 
> Add myself as a maintainer for the guestperf so that I can
> help to fix bugs.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  MAINTAINERS                                          | 5 +++++
>  {tests => scripts}/migration/guestperf-batch.py      | 0
>  {tests => scripts}/migration/guestperf-plot.py       | 0
>  {tests => scripts}/migration/guestperf.py            | 0
>  {tests => scripts}/migration/guestperf/__init__.py   | 0
>  {tests => scripts}/migration/guestperf/comparison.py | 0
>  {tests => scripts}/migration/guestperf/engine.py     | 0
>  {tests => scripts}/migration/guestperf/hardware.py   | 0
>  {tests => scripts}/migration/guestperf/plot.py       | 0
>  {tests => scripts}/migration/guestperf/progress.py   | 0
>  {tests => scripts}/migration/guestperf/report.py     | 0
>  {tests => scripts}/migration/guestperf/scenario.py   | 0
>  {tests => scripts}/migration/guestperf/shell.py      | 0
>  {tests => scripts}/migration/guestperf/timings.py    | 0
>  14 files changed, 5 insertions(+)
>  rename {tests => scripts}/migration/guestperf-batch.py (100%)
>  rename {tests => scripts}/migration/guestperf-plot.py (100%)
>  rename {tests => scripts}/migration/guestperf.py (100%)
>  rename {tests => scripts}/migration/guestperf/__init__.py (100%)
>  rename {tests => scripts}/migration/guestperf/comparison.py (100%)
>  rename {tests => scripts}/migration/guestperf/engine.py (100%)
>  rename {tests => scripts}/migration/guestperf/hardware.py (100%)
>  rename {tests => scripts}/migration/guestperf/plot.py (100%)
>  rename {tests => scripts}/migration/guestperf/progress.py (100%)
>  rename {tests => scripts}/migration/guestperf/report.py (100%)
>  rename {tests => scripts}/migration/guestperf/scenario.py (100%)
>  rename {tests => scripts}/migration/guestperf/shell.py (100%)
>  rename {tests => scripts}/migration/guestperf/timings.py (100%)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


