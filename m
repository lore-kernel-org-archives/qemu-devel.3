Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82167EDA697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTvZ-0007g8-Mt; Tue, 03 Mar 2026 12:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vxTvY-0007fr-L2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vxTvW-000431-So
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:53:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772560375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=bW1tQan0ordKarQCVk1Jil7Sj0ebMaC214ih+ddU4gQ=;
 b=MUC+6r+jSnA20cNdWH2mLsV4e3LKsMtcy2SpuJFKNVYJL8QE13S8+MkjddAgUP2iSXQvon
 gZIIR+yokYR56uWE34csKaD9TS1uC9uIwhKnbvK4J2Z+8p4ce+IS8074ZqvHTsHKRVEifB
 5JbeZclms0SA3KfLIcTJruuUoJcwT6M=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-JoJSrvmyPD-nuSFLhU1i2A-1; Tue, 03 Mar 2026 12:52:54 -0500
X-MC-Unique: JoJSrvmyPD-nuSFLhU1i2A-1
X-Mimecast-MFC-AGG-ID: JoJSrvmyPD-nuSFLhU1i2A_1772560373
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79868eae64fso118161767b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772560373; cv=none;
 d=google.com; s=arc-20240605;
 b=gwEL1K9cyOgdjJRzUH31LAehJEShea3Rg3c5k/TT7vyak8zckuYMYKSSriVqc0RmR3
 LIXhtzoID7nQduF32ECSkpsqwqkOKPq+2LkEGLgkVmQK1yk2a1hu7996ZSsogGKPwz+p
 L0KxGdUPUdRZ0brqS87T8MCx//U6J8bfSbNswctEOj92tUmCqKg3nOIKC9TnbsIZdvzI
 MqNpTjHgfcw7IlmygycvMWl6db0oWKiuaqbuweolSa7VIcnL/1MC0HmgssRY6U7f111k
 QOWpdRUns6zD0ctC82TEIMM0iWGTXqvzhxsMXd3xSffmkI2K36F/po+LjDvBAt0GEzy3
 rXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bW1tQan0ordKarQCVk1Jil7Sj0ebMaC214ih+ddU4gQ=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=TqKJQ6x4uAef++hWg+szxHDO4eeEVDkHXLaN1UDF4a36OBc2fD7ENoYM4u+FT4YjLf
 7PjQlaG6BhPvVYK0e9wbgP8jjJDIjwLADXQS9b9zR0ZhXtnEtVht/1Cp8noBu9+bcLd1
 kiEhl7GaCLxCMviccrGIQwvhX7kbYmBNiBj/T2TvHCWfDryhTjNMsvuo7KlGskqf/bjI
 k6rS2d83MhRA7LW+wwCF4qelwNb+dS5Ir53/RYgEjOkaFHGg40fNb+eS2pTOrjZ5gZUB
 iRX17CVZA6w1EDv9nUVBsiOlfFwUzi08yng7MmuZ5GUNxb0KADJGJw6r6ywT39e6tzcG
 gihQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772560373; x=1773165173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bW1tQan0ordKarQCVk1Jil7Sj0ebMaC214ih+ddU4gQ=;
 b=Sy1QdfzZvU0LeaHbNO2hiBVUWQE6/lLhTLBtAycLiU4pMwnYYUDEYykrqbQk/2YC6k
 P0J4cO8cpUEu5T7zD0RRufyDuFlmsIIEAfvxKT/yoRCnlsmuuFCGIab+KnSj9HeQV+lK
 NFMBqU7Ef9Z0OZcQrBjmJRO9KdMh/yKTG4O508KQ+IF5qwImnjDbohj+wXqKI4cNaQfW
 /0oGfbaC+trdOW1RRhpEkbCd840e1kMVNvUAE5H8vPCcQmKN7XwXfr7R5r5FSQluJ3VP
 UNdaFQ25jm88j0FodHR9na5AFg5SOhTLcSRKAdiQ3iEvFAKGYeUTX1M7BTLZDkpTeqtT
 K3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772560373; x=1773165173;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bW1tQan0ordKarQCVk1Jil7Sj0ebMaC214ih+ddU4gQ=;
 b=pKDXkdpqmvRL8ldcynZe9CzECv53Bw2qv4/pdJrGqRBB2RQDEjnc8ZWd5+jkqT6FNk
 yv2ayb0i5XaNiKxes98oq9ZI01M8AaTjpMaq33NYLcVkit4uco3kC8fdhjLZW3S9m2RU
 LKdILN/HrDh+XxetTVAoJMGWr24jrDH9ytgL2VgivTAw8rd3MHbwPNpqTqFJ2dtMOvHE
 OkWcQvsO2lLUhlcJncX7sOo9TUM769kzu62/o19kR1NeongRv5wd30HJrEbp2CyPJgcI
 NDlW6TtgG+DPopVDsFiXgagdSiKnzutXhe32cGAoCbKyNrgbOrEajemFt1MI/OVGBpOw
 WQrw==
X-Gm-Message-State: AOJu0YyZFM/ixku2YqQ3CWpwDi8DyvsnIsnOYj/r/xA4DhiNI1VSaZfi
 DlCyX19xR46uH6d6VawBMcZziHz+y6IVyW4DTL1UExWZ9GismXiQjokftY3+gOu2FkV4T+Afsxp
 G5WgHdb/kH2/f112Z8Ds2R8sFfKR7/3QkCd+zIEisKnrCTgUiWG9Pueb5bbuHpI1QUIYSeNuLBa
 uRuyMClmlpmIcGAW1aBDWvV7xKEH6oIzkp50dw6hr6KA==
X-Gm-Gg: ATEYQzwnm9xe1BG6rHZS/zFHCYpUACwXdylvLFWtJEwWiH6Ag52tG+SWNeArYKqbEOJ
 u2yy7yiy9z/7ESHn2Rhv1CQqQZCLlFF7Voh1qNhrqbKL3IO3eFg6VH71FlyA5ck/QwAASSlHSAa
 LhxFK+23hFgyE2ONbxVB1B3OMY6JJDqVGowlMwXZvZaTMJDwchUwXJofByLH9kxZ1cOLao9zVej
 PumXvE33oa9t/FS2xxv3SbVYrRD8kxML76giA==
X-Received: by 2002:a05:690c:4507:b0:798:50ee:5b02 with SMTP id
 00721157ae682-7988559ca7dmr155384957b3.42.1772560373282; 
 Tue, 03 Mar 2026 09:52:53 -0800 (PST)
X-Received: by 2002:a05:690c:4507:b0:798:50ee:5b02 with SMTP id
 00721157ae682-7988559ca7dmr155384657b3.42.1772560372810; Tue, 03 Mar 2026
 09:52:52 -0800 (PST)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Mar 2026 12:52:42 -0500
X-Gm-Features: AaiRm51tKqhqlmym-Hb4gRHgvgEX2gcaA3JIMdX1PrUM63qawHV-v3K_lbJIxQQ
Message-ID: <CAFn=p-bNbEwV+1ijfs=+_bCVfexjvN9WRNZwL13Qas+i_HmUBQ@mail.gmail.com>
Subject: QAPIDoc Total Section Ordering
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, let's recap...

In general, it would be nice to have a strict inter-section ordering
for a few reasons:

(1) It makes it easier to add generated sections such as return
values, undocumented members, or undocumented features/flags (such as
Out-of-band execution), because there is a clear and obvious place
where we should insert the generated doc. We have a few spots in the
code now where we have a bespoke algorithm to find the correct
insertion point, and it would be nice to consolidate this logic.

(2) It makes the inliner easier, because merging two doc sections is
more obvious when there is a normal order that must be adhered to;
fields that are absent in one or the other docs list do not cause
problems or complex edge cases.

(3) It allows us to design around a unified look and layout in the
HTML generator, which increases visual cohesion and yadda yadda yadda.
In particular, each "group" of doc types is laid out in a block where
having multiple fields of the same type be non-contiguous greatly
increases visual clutter. i.e. all arguments should be contiguous, all
features should be contiguous, etc. I have in the past referred to
these groupings of doc section types as "doc regions".

For these reasons, I'd like to nail down the order once and for all,
and clarify a few things.

The order I think you prefer is something like this:

(1) Introduction ("Plain text", currently) - Always the first section,
always precisely one section. (But may be multiple paragraphs housed
within that single section.)
(2) Arguments/members/values/alternatives
(3) Return(s)
(4) Error(s)
(5) Feature(s)
(6) Details ("Plain text", currently - generally used for clarifying
detail, examples, and other information.)

Before I go any further, is this order "roughly correct" to you?

...

We previously discussed prohibiting "plain text" from appearing
anywhere except in (1) or (6). From memory, the summary of that
discussion is:

Me: Prohibiting plaintext from appearing between 2-5 makes inlining
easier, and improves HTML output by preventing plaintext paragraphs
from interrupting the "tabular" output used to render metadata fields.

You: Although it is not often utilized, we may want the freedom/power
to use plaintext paragraphs to add addendums/notes attached to
specific sections, i.e. adding a "Note:" to the tail of the arguments
section specifically.

I recall we debated this particular restriction quite a few times and
at length; does this summary sound roughly accurate as far as you
remember?


