Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCE7D1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t381v-0003QF-6P; Tue, 22 Oct 2024 02:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t381s-0003Q1-Gm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t381q-0000ar-Iw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729577161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AUhJGPrvwfhz5oewiU8UBp1jl6177dr8hX7BaCTcqJI=;
 b=Poqi+Hd6N3uU4OjplEb5G/WS/VMZIOx3yG9cx5G7p+y2DGbcmgIQiKLhQD4FwkSwkxPpKS
 lLkrNNs+yuYdj9umx4zyasc3NA0Wdz+fb8KhOtIWabJpi9yPVkXtUeuDl0w7i8r0V/LnHU
 W5G2kSxRsDxaajk3p764Sn28U/9EiW4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-BtAOFixYNuOsgf3Nvo_hoQ-1; Tue, 22 Oct 2024 02:04:39 -0400
X-MC-Unique: BtAOFixYNuOsgf3Nvo_hoQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539eaa0561bso4249784e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729577077; x=1730181877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUhJGPrvwfhz5oewiU8UBp1jl6177dr8hX7BaCTcqJI=;
 b=k57KaeoUflT0xoz8l4qVU1eG8QwyECtGxlVcEIE+ZUcEGUBg2TmeNkFBXG9tUFA2tf
 OaVxs4x7aAv4Rblxx1icv3a1oZkeanF3BDtthjrFF76O1N0eUnvwSFHZ/Vlu1dS70rw1
 yuTdGgJoGVHTFAx8ktjUWbmoWPL/mpiEU/uSb0fDLLzB/YxS4Db1VlxFtgtt6uAYyMEa
 S67L5xe6e0SZFUByDJhMmjMaxPCQOmYqpsKbnZ6asA1kQd/qOymx0zgohvwhhCnoVQr/
 MyvR+e1HZZrbgCx/7I5El2E+pTlCqCnJhTYFDD+eoCEqbyjx6Nlmt6iShE7hjePUJDxH
 jhGw==
X-Gm-Message-State: AOJu0YwZe8f6kCxXd/BiWVkQWaVyhALDwcJv+63oXxzhTYN5O3TlyNHq
 vWKdJAlkd5F3NqK0fkBqA8xeW2eKMCIhxkLStmfIH46yTqSzl7eKbknzqVlN5AkLie8QxBQuTo+
 moezT4RQdaPIOa8cJUELJQh+rP1zdT86ynuQYQqU1X0CwqAWwuyyT/FwOhqm/zbsAs0QGbAVQhg
 CM9CVMwYAX6GAqJ1W7TMxamTDJ6T0=
X-Received: by 2002:a05:6512:224e:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-53a154a9eecmr7204782e87.25.1729577077374; 
 Mon, 21 Oct 2024 23:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQhJtrB56hGuRtNj+AFY1ywftLfbYoU3OK1RxghYnowVKrEl3Rt8PqEIN2v5RTK1QSbmaLYmsch+CjrpDsxbk=
X-Received: by 2002:a05:6512:224e:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-53a154a9eecmr7204760e87.25.1729577076950; Mon, 21 Oct 2024
 23:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729562974.git.yong.huang@smartx.com>
 <fe995bdedf850f4618721911fb4122621f4768c9.1729562974.git.yong.huang@smartx.com>
In-Reply-To: <fe995bdedf850f4618721911fb4122621f4768c9.1729562974.git.yong.huang@smartx.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 22 Oct 2024 11:34:20 +0530
Message-ID: <CAE8KmOx5pENWSYszGiY1OTVs5w=TxEtzYzWM5CLGN-_U+toacg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tests/migration: Move the guestperf tool to
 scripts directory
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 22 Oct 2024 at 07:46, <yong.huang@smartx.com> wrote:
> Guestperf was designed to test the performance of migration,
> with a loose connection to the fundamental test cases of QEMU.
>
> To improve the repository's structure, move it to the scripts
> directory.
>
> Add myself as a maintainer for the guestperf so that I can
> help to fix bugs.
...
>  MAINTAINERS                                          | 5 +++++
>  {tests => scripts}/migration/guestperf-batch.py      | 0
>  {tests => scripts}/migration/guestperf-plot.py       | 0
>  {tests => scripts}/migration/guestperf.py            | 0
>  {tests => scripts}/migration/guestperf/__init__.py   | 0
>  {tests => scripts}/migration/guestperf/comparison.py | 0
>  {tests => scripts}/migration/guestperf/engine.py     | 0
>  {tests => scripts}/migration/guestperf/hardware.py   | 0
>  {tests => scripts}/migration/guestperf/plot.py       | 0
>  {tests => scripts}/migration/guestperf/progress.py   | 0
>  {tests => scripts}/migration/guestperf/report.py     | 0
>  {tests => scripts}/migration/guestperf/scenario.py   | 0
>  {tests => scripts}/migration/guestperf/shell.py      | 0
>  {tests => scripts}/migration/guestperf/timings.py    | 0
>  14 files changed, 5 insertions(+)
>  rename {tests => scripts}/migration/guestperf-batch.py (100%)
>  rename {tests => scripts}/migration/guestperf-plot.py (100%)
>  rename {tests => scripts}/migration/guestperf.py (100%)
>  rename {tests => scripts}/migration/guestperf/__init__.py (100%)
>  rename {tests => scripts}/migration/guestperf/comparison.py (100%)
>  rename {tests => scripts}/migration/guestperf/engine.py (100%)
>  rename {tests => scripts}/migration/guestperf/hardware.py (100%)
>  rename {tests => scripts}/migration/guestperf/plot.py (100%)
>  rename {tests => scripts}/migration/guestperf/progress.py (100%)
>  rename {tests => scripts}/migration/guestperf/report.py (100%)
>  rename {tests => scripts}/migration/guestperf/scenario.py (100%)
>  rename {tests => scripts}/migration/guestperf/shell.py (100%)
>  rename {tests => scripts}/migration/guestperf/timings.py (100%)
>

Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


