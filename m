Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B3606B564
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFdBK7Ip;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VB0fzuV4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrEc-0004dZ-J1; Fri, 13 Nov 2026 08:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRrEY-0004YM-3W
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:22:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRrEV-0007w9-RP
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794576142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd2SYn8BxDOOac/6SjAZIGmT4kogYWdyguNDSODkGok=;
 b=IFdBK7IptGHSbkw9KpgMdn49mYjZuhAWOaE9j7VN6i2wj1NUSNiJqcAdG9MMQB8CNwj/Y/
 9jWvw7YBsUVrh0PUMKz3bpLPdEqsczeIUjdWmcHuPBIV2DVgFfWUZYQXnoryODV7xPt1iM
 Z4Zntbpy7zglGbKdDH27g8fTOh0Kf6A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-MeoGv7lTOKmDjmKxtwl2Og-1; Fri, 13 Nov 2026 08:22:19 -0500
X-MC-Unique: MeoGv7lTOKmDjmKxtwl2Og-1
X-Mimecast-MFC-AGG-ID: MeoGv7lTOKmDjmKxtwl2Og_1794576138
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-492b5408dedso496916f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794576138; x=1795180938; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rd2SYn8BxDOOac/6SjAZIGmT4kogYWdyguNDSODkGok=;
 b=VB0fzuV4MrUTFDBAxW+FCqBzAI2PMJryHIrUx5R5GHO6MJCMnphokTa777bE8ecDev
 V2Ddz23GHTbquyQV9ni3a93oXtWOPzSBbn2aeJxmYylCHacnQb2qwG7qR3IsDF23AUV8
 mNmktDfVM7wm487kegqNCGTISYKyq6d7pOOO39KjkKoifOPkSd8Iyf3Wfj++JS38ozp/
 lovMgT4i0PJvCgAOKgMSSBpfNmAusja1aSAh8Ir+9jT+FERYFMc/bITcwPZxtAMTqFdi
 xGyRm26FgBbuPdnvatJlNLzbP+QygKY+1AKpdyK7XxdIixjlNz9W1Z0X9Xx38NftjFWh
 gvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794576138; x=1795180938;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rd2SYn8BxDOOac/6SjAZIGmT4kogYWdyguNDSODkGok=;
 b=bJh4vuGdi8/UkKw5TBz+y+MQp44Bi+SWL1uLkmp2UJAYVTi8/yf1TtfyZ92jk9LrC9
 QCMnHXPGK0kwBTnEZLY4WMB3z+AVS0NBNlvVoexnJFIu3ncj4UDsAIQsWrsPe57jN6b9
 to+S0xfXbBOOfpBAasoB0+Ox6OgFuTHT4hAquFU/bWM6/cVlCvPnLoLxexVnLseOSXIE
 yMM6GH4A0esI5xMStzUY2H1lnR/joWCnmal93iOAuMVsQVSTzOypPeFhXwVzMWR4DzOU
 yUpqC3qW6gVQYlmgnHA8VFEh71Pjo3louVcG1PtVbL2Xn/cbgC5xcJRfG0SiB76t6GNy
 489Q==
X-Gm-Message-State: APuU4Z9zhkfpJ7mMMjc0RPYXH3MfdNy0X106iKhqKY8d2dyQ+jymA8xF
 mTbblQExftPTkBvzF44mJ+ZGsysjsxgCue4IfrbLImlO87n2uypKUKKR2+bYOmHam/4SJRroq1G
 L0XWV/DPE1TXq11XB8HTrdi26LHEiTNk4ab7xPC8zDIfis8XuDBWWsvbL
X-Gm-Gg: AYBFou26J1C5nVuLswV8793VgyVXW8vaGqvbWR3Eu2YRUKBkmI1iwlCiS+e5jDBx/gC
 2n9BdlHEbEwFb16zl41TU9lC45kArh3H4PhkK8M9NqWqarUpr1qs+69Rx7oL/66RUir1p8M8/qy
 p3AIhw0Wwylscm/Bh6IvDYSpBBh4s1qdGG/Tc8+VhPX3u8i2plVdrblyinT7lqunBZc84jtdOJn
 kTYq4Iaqdf+j/TTbbHb3MUITRnffR/i/a7kAErwLjAX6Vc7n3kdSp9UdLYSGGU1xwwheaNG+Sm5
 tXibj36sj2NoPzb1jUo30EK1z7A1PO16iSWn9OYDg+lifQGQr5nVd0sxCVepF4RtgbZwP7ZKTAy
 w1iL1KmvA9QE9FXliOsa9
X-Received: by 2002:a05:600c:890d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb5c97f545mr13230945e9.24.1794576138314; 
 Fri, 13 Nov 2026 05:22:18 -0800 (PST)
X-Received: by 2002:a05:600c:890d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb5c97f545mr13230535e9.24.1794576137791; 
 Fri, 13 Nov 2026 05:22:17 -0800 (PST)
Received: from localhost ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e252f7fsm163489045e9.2.2026.11.13.05.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 05:22:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 14:22:16 +0100
Message-Id: <DMU45BQNS73Y.PS91851Q47GH@redhat.com>
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Klaus Jensen" <its@irrelevant.dk>, "Tommaso Califano"
 <tcalifano@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Keith Busch" <kbusch@kernel.org>, "Jesper
 Devantier" <foss@defmacro.it>, <qemu-block@nongnu.org>, "Klaus Jensen"
 <k.jensen@samsung.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 1/3] hw/nvme: reject fdp.runs smaller than the lba data
 size
X-Mailer: aerc 0.22.0
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-1-69b3e5dcd5c8@samsung.com>
 <DMT9BXQ9TPPI.2JEJKF00POB19@redhat.com>
 <avX_vc432uGe1kmf@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <avX_vc432uGe1kmf@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 7:04 PM CET, Klaus Jensen wrote:
> On Nov 12 14:13, Tommaso Califano wrote:
>> On Thu Nov 12, 2026 at 10:53 AM CET, Klaus Jensen wrote:
>> > From: Klaus Jensen <k.jensen@samsung.com>
>> >
>> > The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
>> > is configured to be smaller than LBADS.
>> >
>> > Reject such an invalid configuration upfront.
>> >
>> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
>>=20
>> /s/Link/Resolves
>>=20
>
> Issue #4520 is a bulk report that unfortunately contains more than just
> one issue. I didn't want automation to close the issue. That's why I
> used Link instead of Resolves.
>

Makes sense!

>> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>=20
>> Maybe Fixes tag and QEMU stable in cc?
>
> Doh. Yes.
>
> Thanks!

Regards,
Tommaso


