Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216E606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ST7X1cdr;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kz9kjOjZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWihs-00086O-Ri; Thu, 26 Nov 2026 18:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihm-00083W-5U
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihj-00060p-5y
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795734996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f827cYPbGOO2I9OLMAplBQVdFOYhlfxNOAyzGKNqU8k=;
 b=ST7X1cdrYY0JjDZWtLPk324zERKNsmcsx3RVMgE0iFcjIVaSCSa+ruMkJMJ4nlZ3KMKSKu
 0aHBct/deaGZY2k7y8hD7tmMycpEO97ZhQibNPrlDBBy7hzTkkjq1T4kOnZvo5uGxSdKjO
 07zm5/BbKxc6SbGgv0jRMUUcQe3CT80=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-W2SzLH27N9-Wwx0vx_rbMw-1; Thu, 26 Nov 2026 23:16:34 +0000
X-MC-Unique: W2SzLH27N9-Wwx0vx_rbMw-1
X-Mimecast-MFC-AGG-ID: W2SzLH27N9-Wwx0vx_rbMw_1795734994
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9211d51dcefso135637456d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795734994; x=1796339794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f827cYPbGOO2I9OLMAplBQVdFOYhlfxNOAyzGKNqU8k=;
 b=kz9kjOjZxbDhjKCf+e1+7um1w9+SAq+309FAqwpKd+TuVM4TbOg3T5WiO0MbgVsFux
 8FkuBNqHC31bck3VYEZN2DqUKJF/4HpviDv//qHn1tCWshvgIkDzxYMvZ1Z2Yf1E4d3p
 kSpU2JFKOWk756SM1BQvSKFVoV2fGheRLQgT4zlBbpvd1VTRCa3SyQHUdCP1BgnAOV88
 IzdqsnrNvPjKg/kJKV1Fsgwld2XQ7+NYDktMfH9kR4ZgUNIcXuRPb7vUDdVrEjWC23nL
 oO34nYK7++zfyvp9cUUen+rg76F/eARhWfPdURHwmH21Sq6EsG5Pj4l0KmD3VYDCalw6
 bKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795734994; x=1796339794;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f827cYPbGOO2I9OLMAplBQVdFOYhlfxNOAyzGKNqU8k=;
 b=NUirkCGy3wrPDAifIlwf0c2dybxxcR3g1aW/jcCFvquaHcXi5UQ2HOyVGW26jPPtwr
 4Gkc+JlZcaexavUnj6s1gEkRSnhXAOFglQaRUpJxxYo/Ga/Aa0zgjzJensDgh2ynI90i
 mYlGJoMvz99b2OoyUe7R6Xz9OKMkGtPD2906Y8cHz5Xw+FxWBA5LOapDahxQ9lbqM2Gz
 If/e3a0GgeiREmF7FOT6IvoiZWP6dIq2jmmstjy0ie8dGrMv74heKaVds5ta8ysQwRpg
 tyY3Vej4+g16DSrSxydqeU8MwqZmhtrR1D0wIsTpoY9P4F7e0yD/crJbHGqMt9lEIJYu
 fxHg==
X-Gm-Message-State: APuU4Z/WqqO0Ubxuft4RghLQdXNpSzn7C6OIx5sS75kw2U/9z5FeEi76
 uV5eZjUgXoBoA2JP8Q1IT4ksmmc33tXzUKR8UfeZIfI29Xf/cat36y8XJH6WNS5Q4ZdpQBNz5VV
 76CCPzxNFF/AsTqigH6SqVasWf5Vu1C9KypAitYaYR+Tnw5lD7PredQXnwJ2z/29qqajnQEBCNC
 ruyxnF9rQcCVlgyT+sXqiLwG1bzeyqjB4da6gV6g==
X-Gm-Gg: AZFdTZcllhS7liOF6eBmtu2S8S/vuPyZ3vFCZUS93r/lhEX+7rXkWxYblaFOBLgu4n3
 Ah7hnwbLD5Ys33OoK5gZbEfUvjz9jB5wqt31qTg3/tnEmp1mP9D3dtCb8T1ijdNQLc0/+TsOBth
 av92pOrNJ1Wl6F+Ismi55AHczl4nxG7RvswP1rPffIUg9TX0qkLbjEm6aEioLyFEH3k4mRLlHNp
 hae7MO7RoK88BBMk1imUzzqsR0B7Jxf8BacRwpv1TjyUDG2EUPYPXx6W817IjUfKzwoPee2J/mb
 tPZCTyb8hp7wPrI6kRY6VC3cNaz5WlmDhgeHhTwF/qQqD0mw8zY6WHIT9nwulYZD3/MNoy6bmls
 Kvphgu6sQyHw4X0iMQMigp7xCKzUJlS4tBGx6PxH701Gw
X-Received: by 2002:a05:6214:8608:b0:921:18d3:f897 with SMTP id
 6a1803df08f44-92134a7da74mr404967076d6.25.1795734993870; 
 Thu, 26 Nov 2026 15:16:33 -0800 (PST)
X-Received: by 2002:a05:6214:8608:b0:921:18d3:f897 with SMTP id
 6a1803df08f44-92134a7da74mr404966756d6.25.1795734993335; 
 Thu, 26 Nov 2026 15:16:33 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921347a0b79sm199553886d6.5.2026.11.26.15.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>
Subject: [PATCH for-12.0 v2 0/9] migration: Remove VMSTATE_VALIDATE() and
 VMS_MUST_EXIST
Date: Thu, 26 Nov 2026 18:16:22 -0500
Message-ID: <20261126231631.3392756-1-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CI: https://gitlab.com/peterx/qemu/-/pipelines/3120617486

v2:
- Patch "hw/gpio/zaurus: Move VMSTATE_VALIDATE() check into
  post_load_errp()":
  - Unwrap vmstate_scoop_validate() [PeterM]
- Patch "rust: Replace vmstate_validate with post_load"
  - Replaced by three patches from Zhao's v1 at the beginning as dependency
    https://lore.kernel.org/r/20261124095814.437738-1-zhao1.liu@intel.com
- Patch "arm/machine: Move all VMSTATE_VALIDATE() usages into post_load"
  - Move all checks into the cpu_post_load() [PeterM]
  - Added one more dependency patch to make cpu_post_load() take errp
- Patch "hpet: Move VMSTATE_VALIDATE() check into post_load"
  - NOTE: I didn't touch this patch, assuming what we check doesn't really
    matter.. I kept it to make it still aligned with Rust change.

This is for QEMU 12.0 material only.

===8<===

Peter Maydell reported an unwanted assertion on source QEMU due to a failed
check in VMSTATE_VALIDATE():

https://lore.kernel.org/r/20261119165546.3050013-1-peter.maydell@linaro.org

I decided to look at this in a slightly broader range, because I always
thought hijacking field_exists() is very error prone and hard to follow,
and VMSTATE_VALIDATE() is the only user of it (VMS_MUST_EXIST).  Meanwhile
it is the only VMSTATE_*() macro that does not carry a real entity of data
stream, so it's not really a FIELD, but some checker we added adhoc inline
into the VMSD fields.  It might be confusing to anyone new reading VMSD
code, including myself when reading it first time.

Instead of updating the source behavior, let's directly wipe that code out.
I think it's not making a lot of sense doing device state check in save(),
because those sanity check should be done in emulation code, not after
seding all RAM, which is extremely awkward.  post_load() OTOH still makes
some sense to sanity check fields, so I moved all VALIDATE there.

Any comment welcomed, thanks.

Peter Xu (6):
  pcie/aer: Remove the usage of VMSTATE_VALIDATE()
  hw/gpio/zaurus: Move VMSTATE_VALIDATE() check into post_load_errp()
  hpet: Move VMSTATE_VALIDATE() check into post_load
  arm/machine: Convert cpu_post_load() to take Error**
  arm/machine: Move all VMSTATE_VALIDATE() usages into post_load
  migration: Drop VMSTATE_VALIDATE() and VMS_MUST_EXIST

Zhao Liu (3):
  rust/migration: Allow usize as the length of a varray
  rust/hpet: Move vmstate_validate!() check into post_load
  rust/migration: Remove vmstate_validate!() macro and test

 include/migration/vmstate.h       |  11 ---
 hw/gpio/zaurus.c                  |  24 +++--
 hw/pci/pcie_aer.c                 |  40 +++++++--
 hw/timer/hpet.c                   |  18 ++--
 migration/savevm.c                |   5 --
 migration/vmstate.c               |  12 ---
 target/arm/machine.c              | 142 ++++++++++++++----------------
 rust/hw/timer/hpet/src/device.rs  |  45 +++++-----
 rust/migration/src/prelude.rs     |   1 -
 rust/migration/src/vmstate.rs     |  33 +++----
 rust/tests/tests/vmstate_tests.rs |  72 +++++----------
 11 files changed, 181 insertions(+), 222 deletions(-)

-- 
2.56.0


