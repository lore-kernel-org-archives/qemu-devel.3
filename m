Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C58606A32F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MV4qi08g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALk-0007Yi-RV; Tue, 03 Nov 2026 03:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALN-0007VQ-4V
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALL-0006Nn-Nv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gsp0QUMOLU2f+fhNCQLBjl2kqyUGVhYIOLuVE8jkVg4=;
 b=MV4qi08gPdG2WoQWb4NBAN7zfiyej2wbHQWK14Z1FCwcRqO7L86ytqIxMqNz/zOQfWVEle
 ZcExEnr1gt91/0vl5Ac0FQC4V6gORuOWobSePZ5P2lkKdypjQRslbYh6do4C7RJO1ri2ue
 JRo9jM5kUaMJCsTrahcpfqzrAN95gVM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-bHlUZ4heP3aPo9AbSFYxKQ-1; Tue,
 03 Nov 2026 03:58:09 -0500
X-MC-Unique: bHlUZ4heP3aPo9AbSFYxKQ-1
X-Mimecast-MFC-AGG-ID: bHlUZ4heP3aPo9AbSFYxKQ_1793696288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51DC180062F
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 08:58:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5F6718005B0; Tue,  3 Nov 2026 08:58:07 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 16/25] trace: eliminate dupe
 trace_event_get_state_dynamic_by_id() calls
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Blake <eblake@redhat.com>
In-Reply-To: <20261102142844.3464712-17-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-17-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:46 +0400
Message-Id: <179369626699.418241.11693565880360511133.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7tAuZRVgGJn29bJQdYcPGvGoqEoDqdoLKC9E8mbPCwc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aIOahadOYzzBxj837igbGXdz7ll54EyGDQuK
 GH2x6A8IgaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDgAKCRDa6OEJdZac
 5Tw4EACzdIsr8yNu+u9kiI2g2P7LNilaVbdnLHFk2kZOLmi+afAhYrodufxi2W2SOTfEIVEv+95
 VHJKvqvgQGDr/eLIxXtouahXfV94husuAaCSZ/lshG5dmH1JNvRKLkVJiyFYwAK5weUFq/vryFo
 AVOMfLwgdu8QD319wF7wPVxvG8hlazcyMwfRM4HFMviTdmp+f2uSA3xJBguTH3AKktBJl7NmsWH
 +tqgzWR/Ess1OdqPVns5o0I/7ijzzUiUbZtGyPswiWuvSmSDJ+vct8GT34xXoc8hi0KvVfR2jkt
 GmC8U7+J6kt96CmsK7gvQ70DS4uU0qVvQO4FG+AzbCjQ37D7y0OArxVudSKWlSYrxW6pbOS78LH
 6wE3G7gyzSc5R8wpv3qbfJar22dlm0IN4R6P+Y2xp9NSOYbvYqDqOYWSl9O80jPdLDSVUXGPfi4
 25MyLCNGceRzL/5Fa523Zzsq0kn1izB0yoSWhaXF/qC/NzhOQFuYtRdb8BOp9nYJ7OOByKpWF4a
 /Vi6DRDLhK3j5XQv84s3XYPUC9vHxnqYTte9Ma48zpNdmQ8TG6RSfoPWWNwPA77NO2TL09F1ROt
 7kU+Wc0Ossp4bIhZS/xOCcj1pWeGXvaDEMLgwncDEphaB33flSu2MLxsOlKHkXd1EkLxIqE6iVz
 PV6IO2bwh7vvoDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 14:28:35 +0000, Daniel P. Berrangé <berrange@redhat.com> wrote:
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
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


