Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E83CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvEG-0007wH-8G; Mon, 18 May 2026 06:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wOvEE-0007w5-GP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wOvED-0007mU-7t
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779100179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4OS6M1jxDklUM0RhbmYavqsuMfjqG2w9Jz1/fziLhw=;
 b=PDwOHAHu3nk0Mr+/+6hya2+Zl7VO7QNLrQB1fNu7lCWfGIVznKOZhMLH6/qGMd0RB8kyNy
 Ua1VcOmdVEUpjOo6W30ZDIJ0Gh4s24Z0l3sNKPth+hxa7urxBGAEdfbcEHRKfKivJVgfwR
 stsJ5BaY00WNJsVXvp5xoTiR2/g2mik=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-iIecikslPu2T2Wht7I17Qw-1; Mon,
 18 May 2026 06:29:36 -0400
X-MC-Unique: iIecikslPu2T2Wht7I17Qw-1
X-Mimecast-MFC-AGG-ID: iIecikslPu2T2Wht7I17Qw_1779100175
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5621C19560BB; Mon, 18 May 2026 10:29:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0C1918004A3; Mon, 18 May 2026 10:29:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
From: marcandre.lureau@redhat.com
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
In-Reply-To: <agThgiOYAYujkWul@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com> <agThgiOYAYujkWul@x1.local>
Date: Mon, 18 May 2026 14:29:29 +0400
Message-Id: <177910016940.1283661.15695115213614547293.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O38vXekMfNA7MA1B8VRObJ3zrvSJ1wfw6+0+/v/UgMk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCuoJlU7A76kvz+DsKe34spln5X2srAkX5LUlS
 07ltpPlD0WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagrqCQAKCRDa6OEJdZac
 5XvNEAC6jQxnDjlzDK5HCJFDe5+QR+2L70zqok8dxO8uDB8ttu4oFPGTMd1oIWLjcZUJ5PmB+67
 5wS5V1i1uNBXQswmTlN0EBExXZfoH55iNSNPN4K9pcU8U68crlhHN/nE5MuBhBrZogsP3uneXHn
 m4wHwyjOg9c+2nKYvXO5SrEIsIqdsqqYc7ZxHZtoYyN4dNhW7ifdv4wNTQnG/0HjR+pCYMdp/Es
 HCUDvVDTh/CnsdgPawhDGj6ohdtvzjz1V8TnMt3MkyFY4EgjvowNDD8ke1C5I1GRRBR5Ldy4JtX
 HzRNnZmtCpNQR16HaN0iaOdKlSHScJznxuI98jD9vS2Fyz2hrBmhz18l9DCufIW1hXIBXthx//F
 4d4hADPh8K4Vzf1/EVvaBj8iBnLiSBDUGRWKvtPEJoSh8dCsXIu+WhNZz3TMKtEEHm75x/XHLjD
 T5hNvRgHGCyhxIZE0ILcHfdB30w8nodlAeP+8yfQ2xcHPnOyr+RDR5/a+lF23UKQ7I4w4pe/kQC
 sI6JOo/nhmctw1m23lG57oFKmVeJTLSLQ7L5mYAE896H+qNhCxVnpC/ZZC1sNf/4b9Tr0yqDyg3
 maPpBegEPlmWXBH0je6C8fKVZ22Vy1T+qBFaFRhbW8EwphV/hTFMnSrTipObBumOiPn11D4OuNH
 FvtFi7NPEPGwXog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi,

On 2026-05-13 16:39:30-04:00, Peter Xu wrote:
> On Mon, May 04, 2026 at 04:30:18PM +0400, Marc-André Lureau wrote:
> > +            range = g_new0(RamBlockAttributeRange, 1);
> > +            range->start = start_offset;
> > +            range->length = length;
> > +            range->shared = is_shared;
> > +
> > +            if (has_rdm) {
> 
> Is this only for extra safety?  My understanding is when reaching here,
> attr!=NULL, which means we have at least one disgard manager source, then
> the manager must be there.  So I wonder if we could assert.  But not a big
> deal. Maybe I overlooked that it is needed?

Correct, a RAM block attribute ensures the presence of a discard manager.
This should remain valid in the future, I'll use assert().



