Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5282606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NMWEwh/N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDbX-0006kg-Iz; Fri, 23 Oct 2026 07:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NUfbagoKCo4ABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbW-0006kW-Fo
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:34 -0400
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NUfbagoKCo4ABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbU-00065t-S4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:34 -0400
Received: by mail-pj1-x1045.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso1233920a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755510; x=1793360310; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RUaKTbpmPG8VxZ+o56N38oJAR54dG27ARraYuWWXJpg=;
 b=NMWEwh/N6jCmoOtPhaLC0n3/gO+11PCjAAbiVI+paI/dHD8oxFB8Gw0xpmo+cPYlPq
 ixzQdrJg2bavWQbK3AzVPvn5yuJnW0ToIoqPNIVdpV6Ys4ml8hEAxnqDEQ3AkCbEOs+U
 aabf4qq1jozfqfucPY61H3RvS+ppq5AGA+Pak6/ifNnrs6QNCJx8fX2c24kaLAM+pBK0
 dVWBkPT+eIZsFgV+ay0Yh6WARzCTGsGKzFOExAlXhrBAN0vepOoCK3S8muOUlOvVL6BX
 OhWXKxqjA43TyJituNvHCPwLW+4BGhrw+6djQmM4jYGcxwEyIOLu2iBpZbBwCNuF9e6A
 qjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755510; x=1793360310;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RUaKTbpmPG8VxZ+o56N38oJAR54dG27ARraYuWWXJpg=;
 b=tKpeE14N1wQGe5opkXjec/7p6CUWZWbighUhgYSh39C9Jo2JML+19I6vf55Kgvp8xF
 GDQzBti5L5GRrjLnapuNapVedhFs8QZv7RrxuDDrVAcZlMHIwlGwGkqEquuDTXogOKk2
 6Rdrbut/3YI2zS61c9Al9DDJZzoM4zO1G2D9eh059P5XjYwe8Kww9eG5EuY/ebUcSu/3
 q9seABCMMJ6TTAAsv/YCLghVlWtZrvx2VGBt5n40LzknfxOwEsUhpAc13t+PfCmYUmU7
 qa52bsNlPoT3geNoWHUXzqu5DfhqcCtrkzYzQHplhLIPzqLONr6UeOdLGFMDPZLXdsEE
 X7XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi+1xkhUhxL6vfgU4A53ktMaF5dOpeQVRsq1DCpVm3p+XwkHo021rR5ZYlcOSZrbghX3Tn/zFa/WHw@nongnu.org
X-Gm-Message-State: AFq9FYJS73zwVjtK4gQSLcKYcLBTVlFBgoujY7Bt0/dy4N1ZF7Nm4+Rq
 +kFIgJIplsnELWm2Hga8HCakJXRtOQdBvS7pyyslu8ydpILxEfVMYiNadIXJIHfpTxsbxsQbJai
 OzBM1dU50KfJgdx8dt8zJTg==
X-Received: from pjnm13.prod.google.com ([2002:a17:90a:858d:b0:3ad:cb89:dd82])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e4b:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3adce811622mr1609636a91.44.1792755509988; 
 Fri, 23 Oct 2026 04:38:29 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:28 +0800
In-Reply-To: <20261023080134epcms2p2148696f3da2f7eae77b698010a406808@epcms2p2>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261022074513.2292281-1-stanleyjhu@google.com>
 <20261022074513.2292281-9-stanleyjhu@google.com>
 <20261023080134epcms2p2148696f3da2f7eae77b698010a406808@epcms2p2>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113828.3368495-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 8/8] tests/qtest/ufs-test: Add QOM fault injection task
 abort test
From: Stanley Jhu <stanleyjhu@google.com>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>,
 qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1045;
 envelope-from=3NUfbagoKCo4ABs53wG1zCy66y3w.u648w4C-vwDw3565y5C.69y@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1045.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 17:01:34 +0900, Daejun Park wrote:
> All three new tests use mcq_test_opts, and UFS_FAULT_INJECT_TAG_ANY is
> used only with ssu-timeout. To see what is covered, I removed each of
> the following on top of the series. Each build succeeded, and the UFS
> qtests still passed 29/29:
>
> - the legacy half of the abort-success branch in ufs_fault_inject_tmr()
>   (2/8)
> - the READ_10/WRITE_10 match for TAG_ANY in ufs_fault_inject_exec_req()
>   (1/8)
> - the body of ufs_fault_inject_sq_cleanup() (2/8)
>
> Could the fault injection cases also run with io_test_opts, and could
> one case cover TAG_ANY with a READ(10) below and above
> UFS_FAULT_INJECT_MIN_LBA?

Done.

> Minor:
>
> - 7/8 and 8/8 drop G_GNUC_UNUSED but keep the old continuation indent
>   of ufs_send_tmr() and ufs_mcq_send_scsi_cmd_async()
>   (tests/qtest/ufs-test.c:1903-1905 and 1932 after the series). If each
>   helper is added in the patch that first uses it, 5/8 does not need
>   G_GNUC_UNUSED.
> - 6/8, tests/qtest/ufs-test.c:2014: the comment says the queue
>   status/pointers "remain 0" after HCE=1, but only the HCE bit is
>   checked after it.

Fixed the continuation indentation of both helpers. We kept the helpers
in patch 5/8 with G_GNUC_UNUSED so patch 5/8 stays a self-contained
preparation patch.

Done.

Thanks,
Stanley

