Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E09606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NOIrfgx+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOALJ-0007US-Ra; Tue, 03 Nov 2026 03:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOALB-0007TS-89
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOAL9-0006M7-No
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 03:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793696278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPfz3uB8SgaK35AfxozsaGHqeIG+rQYWDczMne26lUE=;
 b=NOIrfgx+DH1MnYjiTtk0YsaH+Z3a6zn6wX9X+fTlKdiGKGCZWgajXXzIPkx8nT+MLqYT/m
 2qpxqLOr0U/bXAxm/keS0Q9rgOaAxcnqTedhuWWF4U9xVJID2AamqktkroN25fTWwqVYgD
 4v+bG8oibZaz7UfToutwkp3ujLkDRDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-GzqMHYbVN3aU_X63AW6JdA-1; Tue,
 03 Nov 2026 03:57:55 -0500
X-MC-Unique: GzqMHYbVN3aU_X63AW6JdA-1
X-Mimecast-MFC-AGG-ID: GzqMHYbVN3aU_X63AW6JdA_1793696274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 694B71955F75; Tue,  3 Nov 2026 08:57:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2598018001CA; Tue,  3 Nov 2026 08:57:52 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 07/25] trace: remove obsolete references to vcpu
 property
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20261102142844.3464712-8-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
 <20261102142844.3464712-8-berrange@redhat.com>
Date: Tue, 03 Nov 2026 12:57:46 +0400
Message-Id: <179369626696.418241.1897282839775860000.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=coJ1KsNkn7IwtuW1ZRGELcUw8eOixPVD5qQGN63H+to=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6aINDJTGvW/frlQYA5x7SiKzoOZG184pnKsQ8
 vz/z43cuR6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaumiDQAKCRDa6OEJdZac
 5ddaD/0afrZDOi8vlNWgQr0wLsSYbg+jCWRf4EEUo7QH9skDvrIgKWSpv7Rg19E7LXXsPFt3HEO
 FKgEY6qSxoiWL1IY9MgnqJLHlbMA38LtS5egxD6btWVU9J1jXxTgF2g3v8D5KqAZnoWjiMpODFh
 BMg0+P+knpp32ng+J7PhsTZECB0tws/9flPheTb+yfJ/flN6qF6UGEfoIakJII8SSiRsfosWAy/
 3/ZsPGq6ycipqXaLlEbJQa2QDMOZomR7AGWAkj0kfx0PO7xh7G+NPEdIp3jl6ZSq9Ck2I+Y8qYV
 OR6XgiefP1Lxigime/+Z+hKoTudB16YmMk/956atSxYWuKT7aL7vgn5iaBRkv18xVA4Mi7GY6mL
 hWvJ9qiV4FPkcYclPAcRRbMafcG9C1coh0iOfBxY+Wb9Hdd0tZIBsmF/PySVaR3Zq2BeQehA/H/
 PfPZiKix+54QEy6Y41BqYw4qTDXEnSE+DF4YJPj7vsVgNFoCON/o310Ie+6KSmgjoZK/623h2Vb
 6t2Y4Xq42+IcwqLaYJCvtC6b8dj98OK7onWsdCqVVrU7t6DUK5LOXa7beKGCBcMnh224nlVqR59
 yJVYkLFvFt0qHjkxTbTVN6ed756oIK3WModK0+4rLrUwaAocqTCINF/zo0NzGqLxzSbn/OJGmF2
 fN8fhKn9RjShMWw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The 'vcpu' property for trace events was removed 2 years ago
> but some mentions of it remain in the code.
> 
> Fixes: 7ffc4894a63b ("trace: Remove deprecated 'vcpu' field from QMP trace events")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20261102142844.3464712-8-berrange@redhat.com>
> ---
>  trace/control-target.c |  6 ------
>  trace/control.c        |  6 ------
>  trace/control.h        | 12 ------------
>  trace/event-internal.h | 11 -----------
>  4 files changed, 35 deletions(-)
>
> diff --git a/trace/control-target.c b/trace/control-target.c
> index 24d9b7abbdea..87b0f5037df1 100644
> --- a/trace/control-target.c
> +++ b/trace/control-target.c
> @@ -14,12 +14,6 @@ void trace_event_set_state_dynamic(TraceEvent *ev, bool state)
>  {
>      assert(trace_event_get_state_static(ev));
>  
> -    /*
> -     * There is no longer a "vcpu" property, dstate can only be 1 or
> -     * 0. With it, we haven't instantiated any vCPU yet, so we will
> -     * set a global state instead, and trace_init_vcpu will reconcile

The same obsolete vcpu comment remains in stubs/trace-control.c.
qapi/trace.json:55 also still shows "vcpu": false in the
trace-event-get-state example.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


