Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB2C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvmi-0007EF-UH; Mon, 21 Jul 2025 15:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udvhg-0002RB-UH
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udvhf-0001ru-2h
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753124254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gqxslruIjq4zYHBKVg7Uq00NacAheB29jTrBs+WK8BM=;
 b=NCme4DzF93WIklq43EA2WT5oX4RMyiM2WBT6ol9R7Hl/bZUrvE/6JO776tknBpDIavfVTO
 QzQd3igbxh0fWjlWn/bmYWtvAejWAVqMqkO9z8UbIJ6SUP8yHYWXEY7SWLSXLUFOnD17Ec
 P0g2troZMeuBpAX/TpkmH5VmBl7qkzk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-uHYnP6hcPzqiIIODZdB0cA-1; Mon,
 21 Jul 2025 14:57:13 -0400
X-MC-Unique: uHYnP6hcPzqiIIODZdB0cA-1
X-Mimecast-MFC-AGG-ID: uHYnP6hcPzqiIIODZdB0cA_1753124232
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC2371955E88; Mon, 21 Jul 2025 18:57:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.213])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56C9319560B3; Mon, 21 Jul 2025 18:57:08 +0000 (UTC)
Date: Mon, 21 Jul 2025 19:57:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PULL 1/1] trace: log.py: human-readable timestamp
Message-ID: <aH6Ngt6dmk56uMEt@redhat.com>
References: <20250721181051.61143-1-stefanha@redhat.com>
 <20250721181051.61143-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721181051.61143-2-stefanha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 21, 2025 at 02:10:51PM -0400, Stefan Hajnoczi wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> So tired to parse all these timestamps, when need to compare them
> with other logs.
> 
> Use iso8601 format as in warn_report() (info_report(), error_report())
> already used.
> 
> Also, start line with date, to be similar with warn_report() as well.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Message-id: 20250626195514.366177-1-vsementsov@yandex-team.ru
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/backend/log.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index 17ba1cd90e..61118474b1 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -39,10 +39,15 @@ def generate_h(event, group):
>          '        if (message_with_timestamp) {',
>          '            struct timeval _now;',
>          '            gettimeofday(&_now, NULL);',
> +        '            time_t _seconds = _now.tv_sec;',
> +        '            struct tm _tm;',
> +        '            gmtime_r(&_seconds, &_tm);',
>          '#line %(event_lineno)d "%(event_filename)s"',
> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
> -        '                     qemu_get_thread_id(),',
> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
> +        '            qemu_log("%%04d-%%02d-%%02dT%%02d:%%02d:%%02d.%%06ldZ'
> +        ' (%%d) %(name)s " %(fmt)s "\\n",',
> +        '                     _tm.tm_year + 1900, _tm.tm_mon + 1, _tm.tm_mday,',
> +        '                     _tm.tm_hour, _tm.tm_min, _tm.tm_sec, _now.tv_usec,',
> +        '                     qemu_get_thread_id()',
>          '                     %(argnames)s);',

IMHO this is undesirable, as it bloats the QEMU binaries by another 1 MB
as we have an excessive amount of code being inlined in every trace call
location. I've co-incidentally just sent a patch that would fix the same
problem based on a discussion last week about a bug caused by this log
backend adding 'error-report.h' into all files:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04905.html

>          '#line %(out_next_lineno)d "%(out_filename)s"',
>          '        } else {',

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


