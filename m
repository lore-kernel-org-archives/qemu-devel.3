Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64C606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zh1mDs6P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ5S3-0001Kf-9b; Tue, 20 Oct 2026 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1xJ5S1-0001KN-5e
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 04:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1xJ5Rz-00027Y-2K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 04:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792485841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTbdtk+aMD5bH0CKhwmgQiJIZZIyl7rI+WNKMuRwKjI=;
 b=Zh1mDs6PLy1VWUovoc6lX60B5//hRYr7IqFeYhxKIeB1BchFx92763ya0xui2lOBe1dv6Q
 7L3JasPlyIY6rtg6a5SGAhL27+ZYhngcBjb1zi71OXAIVuWzfJo8ZLVvjGYBEO5jsygYcV
 uzmqn4IqqIIgoNG956/xdzsJmoLDg9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-aSrXdarRMteXGLlLRBhTOQ-1; Tue,
 20 Oct 2026 04:42:49 -0400
X-MC-Unique: aSrXdarRMteXGLlLRBhTOQ-1
X-Mimecast-MFC-AGG-ID: aSrXdarRMteXGLlLRBhTOQ_1792485768
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A555C195419C; Tue, 20 Oct 2026 08:42:47 +0000 (UTC)
Received: from jtomko.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B3271956088; Tue, 20 Oct 2026 08:42:43 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:42:41 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] system: Remove deprecated '-name foo, debug-threads=...'
 option
Message-ID: <atcpgXk-rQ5m1PDK@jtomko.csb>
References: <20261018232917.7716-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018232917.7716-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a Monday in 2026, Philippe Mathieu-Daudé via qemu development wrote:
>'debug-threads' option for -name was deprecated in v11.0
>(commit 1b65aeed2a0 "system: unconditionally enable thread
>naming") thus can now be removed.
>

libvirt patch sent:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/E5HZUYURWU3JCQSXQJEM3HLW52KUQPKB/

>Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>---
> docs/about/deprecated.rst             |  7 -------
> docs/about/removed-features.rst       |  9 +++++++--
> system/vl.c                           | 11 -----------
> tests/qtest/migration/framework.c     |  4 ++--
> tests/qtest/migration/precopy-tests.c |  2 +-
> qemu-options.hx                       |  7 +++----
> 6 files changed, 13 insertions(+), 27 deletions(-)
>

Reviewed-by: Ján Tomko <jtomko@redhat.com>

Jano


