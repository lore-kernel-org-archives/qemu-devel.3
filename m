Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07D0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggtK-0002Ev-Bw; Mon, 06 Jul 2026 06:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wggtI-0002Dq-5u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wggtG-0006Ng-T7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783334968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGjq8lLyCq1tGI1y0KxZKJ5RpIF+xFrfxdj0Cg73QYM=;
 b=W+k+bMLr/x/eyCiEXJmYb+8v6/xn2IBJtV4AtloJTLqWMJisL7pC7wJlIzVD16+9hlR/cn
 yYsn6dO2Ga3ZXLNY1GW02bXtIOtGrEwQ/4gPq90xG96CETX1xVI6tX9zmIA0il1VLxO/7l
 sHpIrtDcjGfG/EAaLi/AEaxCtTeXYTY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-G9ylA0cHPsCxqoJq1s-aGQ-1; Mon,
 06 Jul 2026 06:49:25 -0400
X-MC-Unique: G9ylA0cHPsCxqoJq1s-aGQ-1
X-Mimecast-MFC-AGG-ID: G9ylA0cHPsCxqoJq1s-aGQ_1783334964
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5060F1955F78; Mon,  6 Jul 2026 10:49:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E685F1956047; Mon,  6 Jul 2026 10:49:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ABED31800081; Mon, 06 Jul 2026 12:49:22 +0200 (CEST)
Date: Mon, 6 Jul 2026 12:49:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH v2 2/2] hw/uefi: disable debug function
Message-ID: <akuH4_LIFInl78Th@sirius.home.kraxel.org>
References: <20260702092349.4183512-1-kraxel@redhat.com>
 <20260702092349.4183512-3-kraxel@redhat.com>
 <2a13fcae-779a-4596-bd2d-c5cd7cf8ad1f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a13fcae-779a-4596-bd2d-c5cd7cf8ad1f@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> > @@ -173,7 +176,9 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv,
> >       pe = pol->entry;
> >       uefi_trace_variable(__func__, var->guid, var->name, var->name_size);
> 
> ... better keep it compiled with a trace event:
> 
>        if (trace_event_get_state_backends(TRACE_UEFI_POLICY)) {

Hmm?  The function called doesn't use trace points ...

take care,
  Gerd


