Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758E606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOYW9UPB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJe6p-0008If-I7; Wed, 21 Oct 2026 17:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xJe6n-0008I8-GW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xJe6l-0004Fn-Bb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 17:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792619066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VINmb4x3Xxocs4PGQJ2dWdDYl2Z9hpdwBqciw6h8+N8=;
 b=jOYW9UPBeSnGV2N8jOZZ+PBD6/Cf6E27XGpXjjl7JE6Ad9no1zmTFpmrQBHNV5QGzfRnJw
 xKGHCyZSdotJQ7Bjy+In2jS5NnK77b2dQ2bUfEZ6nEJ891gC2ftL5Bc3b5wKT9GqGp0rNl
 1zkY94HsmdyaC0yQOHfE/123Q5VqYmU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-KJKT9whAOjGKU8sYKPhbbw-1; Wed,
 21 Oct 2026 17:44:24 -0400
X-MC-Unique: KJKT9whAOjGKU8sYKPhbbw-1
X-Mimecast-MFC-AGG-ID: KJKT9whAOjGKU8sYKPhbbw_1792619063
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 687D41955DD4; Wed, 21 Oct 2026 21:44:23 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 231FD30000E3; Wed, 21 Oct 2026 21:44:20 +0000 (UTC)
Date: Wed, 21 Oct 2026 16:44:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 16/24] trace: eliminate dupe
 trace_event_get_state_dynamic_by_id() calls
Message-ID: <atkxgW7Oed3UE4A4@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
 <20261005120855.421973-17-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005120855.421973-17-berrange@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 01:08:47PM +0100, Daniel P. Berrangé wrote:
> Each backend generates the same trace_event_get_state_dynamic_by_id()
> call for the TRACE....DSTATE() macro body, so when multiple backends
> are enabled, the same check is repeated:
> 
>  #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
>      QEMU_TEST_WIBBLE_ENABLED() || \
>      trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
>      trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
>      trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
>      trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
>      tracepoint_enabled(qemu, test_wibble) || \
>      false)
> 
> Expanding the use of the 'backend.check_trace_event_get_state'
> attr in the C header generator removes the duplication, in the
> same way that the Rust generator already does.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +++ b/scripts/tracetool/backend/__init__.py
> @@ -133,8 +133,8 @@ def generate_begin(self, events, group):
>      def generate(self, event, group, check_trace_event_get_state=None):
>          self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
>  
> -    def generate_backend_dstate(self, event, group):
> -        self._run_function("generate_%s_backend_dstate", event, group)
> +    def generate_backend_dstate(self, event, group, check_trace_event_get_state=None):
> +        self._run_function("generate_%s_backend_dstate", event, group, check_trace_event_get_state=check_trace_event_get_state)

I guess we don't care about long lines in python the way we do in C.
If a lint check flags it, the fix is trivial; otherwise I'm fine with
it as is.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


