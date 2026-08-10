Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B6C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUlB-0003M5-Ir; Mon, 10 Aug 2026 14:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUl9-0003Lr-UR
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUl7-0005W2-Qh
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eP8FEiTg1q4wpp724LGiCsSf4FvgmykO6e0WONiUYKw=;
 b=gUC/MT0GRlfdBts5+Inr013LFL/rGw/H3TA0nkZU1pxXOiA2opQB5PY5fpOQEh9zds6xfg
 xLCTQ1QAoSNp2GFG1libJAdznIAQGtUjOXaltXnlSN8e0nAK/RO2GtE583p3T+jzRPpsrm
 XcaYdVIXgyor0jBlzGEBIMxNAFEeBjk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-A5mlXF6IMwSiyFfoP20uhQ-1; Mon,
 10 Aug 2026 14:29:58 -0400
X-MC-Unique: A5mlXF6IMwSiyFfoP20uhQ-1
X-Mimecast-MFC-AGG-ID: A5mlXF6IMwSiyFfoP20uhQ_1786386597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9ECE1800107; Mon, 10 Aug 2026 18:29:57 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F0CD180034F; Mon, 10 Aug 2026 18:29:56 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:29:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 30/39] tests: skip HMP-dependent tests when HMP is
 disabled
Message-ID: <anoYoZs68jUPpBOu@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-30-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-30-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 26, 2026 at 01:19:31AM +0400, Marc-André Lureau wrote:
> Add runtime detection of HMP availability so tests gracefully skip
> instead of failing when QEMU is built without HMP support.
> 
> For qtests (drive_del-test), use compile-time #ifndef CONFIG_HMP guards.
> 
> For bash iotests, add _require_hmp() to common.rc that probes QEMU.
> 
> For Python iotests, add _verify_hmp() and a require_hmp parameter
> threaded through execute_setup_common()/main()/script_initialize()/
> script_main().
> 
> An earlier version of this series did an almost-complete conversion of
> the tests to QMP. However, this made the series even longer. I decided
> to post-pone it for now.

Makese sense as a tradeoff.

> 
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/drive_del-test.c                       | 25 ++++++++++++++++++++++
>  tests/qemu-iotests/028                             |  1 +
>  tests/qemu-iotests/045                             |  3 ++-
>  tests/qemu-iotests/051                             |  1 +
>  tests/qemu-iotests/056                             |  3 ++-
>  tests/qemu-iotests/060                             |  1 +
>  tests/qemu-iotests/068                             |  1 +
>  tests/qemu-iotests/071                             |  1 +
>  tests/qemu-iotests/081                             |  1 +
>  tests/qemu-iotests/091                             |  1 +
>  tests/qemu-iotests/093                             |  3 ++-
>  tests/qemu-iotests/102                             |  1 +
>  tests/qemu-iotests/117                             |  1 +
>  tests/qemu-iotests/119                             |  1 +
>  tests/qemu-iotests/120                             |  1 +
>  tests/qemu-iotests/124                             |  3 ++-
>  tests/qemu-iotests/130                             |  1 +
>  tests/qemu-iotests/132                             |  3 ++-
>  tests/qemu-iotests/136                             |  3 ++-
>  tests/qemu-iotests/142                             |  1 +
>  tests/qemu-iotests/145                             |  1 +
>  tests/qemu-iotests/146                             |  1 +
>  tests/qemu-iotests/148                             |  3 ++-
>  tests/qemu-iotests/151                             |  3 ++-
>  tests/qemu-iotests/152                             |  3 ++-
>  tests/qemu-iotests/153                             |  1 +
>  tests/qemu-iotests/156                             |  1 +
>  tests/qemu-iotests/157                             |  1 +
>  tests/qemu-iotests/161                             |  1 +
>  tests/qemu-iotests/165                             |  3 ++-
>  tests/qemu-iotests/172                             |  1 +
>  tests/qemu-iotests/181                             |  1 +
>  tests/qemu-iotests/185                             |  1 +
>  tests/qemu-iotests/186                             |  1 +
>  tests/qemu-iotests/192                             |  1 +
>  tests/qemu-iotests/201                             |  1 +
>  tests/qemu-iotests/216                             |  3 ++-
>  tests/qemu-iotests/225                             |  1 +
>  tests/qemu-iotests/232                             |  1 +
>  tests/qemu-iotests/236                             |  3 ++-
>  tests/qemu-iotests/245                             |  3 ++-
>  tests/qemu-iotests/246                             |  3 ++-
>  tests/qemu-iotests/249                             |  1 +
>  tests/qemu-iotests/254                             |  3 ++-
>  tests/qemu-iotests/255                             |  3 ++-
>  tests/qemu-iotests/257                             |  3 ++-
>  tests/qemu-iotests/260                             |  3 ++-
>  tests/qemu-iotests/264                             |  3 ++-
>  tests/qemu-iotests/267                             |  1 +
>  tests/qemu-iotests/274                             |  3 ++-
>  tests/qemu-iotests/280                             |  1 +
>  tests/qemu-iotests/281                             |  3 ++-
>  tests/qemu-iotests/283                             |  1 +
>  tests/qemu-iotests/286                             |  1 +
>  tests/qemu-iotests/298                             |  3 ++-
>  tests/qemu-iotests/300                             |  3 ++-
>  tests/qemu-iotests/304                             |  3 ++-
>  tests/qemu-iotests/310                             |  3 ++-
>  tests/qemu-iotests/common.rc                       |  8 +++++++
>  tests/qemu-iotests/iotests.py                      | 14 +++++++++++-
>  tests/qemu-iotests/tests/backup-discard-source     |  3 ++-
>  tests/qemu-iotests/tests/copy-before-write         |  3 ++-
>  tests/qemu-iotests/tests/image-fleecing            |  3 ++-
>  tests/qemu-iotests/tests/iothreads-create          |  3 ++-
>  tests/qemu-iotests/tests/luks-detached-header      |  3 ++-
>  .../tests/migrate-bitmaps-postcopy-test            |  3 ++-
>  tests/qemu-iotests/tests/migrate-bitmaps-test      |  3 ++-
>  tests/qemu-iotests/tests/mirror-change-copy-mode   |  3 ++-
>  tests/qemu-iotests/tests/mirror-ready-cancel-error |  3 ++-
>  tests/qemu-iotests/tests/qcow2-internal-snapshots  |  1 +
>  tests/qemu-iotests/tests/qsd-migrate               |  3 ++-
>  tests/qemu-iotests/tests/reopen-file               |  3 ++-
>  tests/qemu-iotests/tests/write-zeroes-unmap        |  1 +
>  73 files changed, 152 insertions(+), 37 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


