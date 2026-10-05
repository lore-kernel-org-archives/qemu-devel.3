Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B331CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgTa-0002WX-Fh; Mon, 05 Oct 2026 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38IPDagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTW-0002Rg-0l
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:18 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38IPDagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com>)
 id 1xDgTU-0005Ov-77
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:03:17 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so3065438a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791198193; x=1791802993; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FH1iLKBetG4x/MDzsh4R7Fyx25gsAQ78NtG4N/fApBM=;
 b=TVYPdeO1JWBrn6CXN5l8n+BK72PsC793dg4hdchw/469eWDRIOwmaJWD0Iy0ODSuf1
 YWstYd7pgKltDKDJcpt+GKqYUjCFeC1BvbCghEriJJArFxuAkf56BgdGc+mJFhjkQDT8
 F7Y0OVsVTvkcaeCiG/J3I+K+gEZu7yZrlKcDkC2Bo0Rv/tQUfdCWiOfgXscpmRi6OvmA
 ApYP+iBiGedjAcHyo0ywUIzjITf6nCJu/Z/2fe9E7CrgWlRal5JYa98ebzKvKRKjA7X/
 /qkPAsRwZXNNZbNBU2//e5B8UspXeLVinTegWD/fz6CpdiB2rMRsr1G62KvPrZuTsr+V
 f1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791198193; x=1791802993;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FH1iLKBetG4x/MDzsh4R7Fyx25gsAQ78NtG4N/fApBM=;
 b=C4rNOg61RkKlLHLCiuEJV0qdtfd3RNzXj3n6sA9cSb4yhyIWtKEAuA68roWnzMv2A6
 AG9eUq1X8D/ZXa784an7Nz8aflHcBsxsZF2Mw8c16sIlE1S4ldUrNsLHQPHQfULUd5XC
 hc8k0MC6TIAlnLkJ0K1SKkjmVtsJrhRHwjHr153R+GN1PNB8/W+6ZspFM0CCS5fPFPqC
 C7sbFPuyxy+vOuSUbmUX8y8HKxgTBwkHKwY4YvWk5FuuSFCgtqgbMTp2yYCvV5y66EWy
 snsT9KaZEm3HctXk3ttOORicZcNYk5uWHUw2j4zumfbHnmdmZGqOwJdliCQDOd/jGrt1
 pffw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUTudtFSyT55lXUyJlYxHkxS58VG2vl5lb7otsHN7uJJvIGpSnxQ2w0WLjlEvpa1EjDweZ3SlZOfBG@nongnu.org
X-Gm-Message-State: AFq9FYJC1ZwgG10sGWGt6EaHUFC6gb7FcoRs/NpaCFkQmCrv03wU5E+k
 IVrn66a95gAIucBajMv1Y/TJhua5+/uvibcdM5KnpWj3dcwTXgKLcHFY0s+y1767SZhh1CNPcB6
 HpFjaScW8q9S/V6eOj24P2g==
X-Received: from pgme8-n2.prod.google.com
 ([2002:a05:6a02:6c88:20b0:cc7:caf5:50f3])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5347:b0:3a4:b061:2765 with SMTP id
 98e67ed59e1d1-3a6cec13adbmr8660175a91.15.1791198192928; 
 Mon, 05 Oct 2026 04:03:12 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:03:10 +0800
In-Reply-To: <179093130014.85103.8462033204202020267.b4-review@b4>
Mime-Version: 1.0
References: <20260923144911.2877141-1-stanleyjhu@google.com>
 <20260923144911.2877141-3-stanleyjhu@google.com>
 <179093130014.85103.8462033204202020267.b4-review@b4>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005110310.3326834-1-stanleyjhu@google.com>
Subject: Re: [PATCH v3 2/3] hw/ufs: Support MCQ runtime interrupt and queue
 status registers
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, fam@euphon.net, 
 kwolf@redhat.com, hreitz@redhat.com, j-young.choi@samsung.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=38IPDagoKCmMTUBOMFZKIVHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1047.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 02 Oct 2026 17:55:00 +0900, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
> RTC = 0 reports successful cleanup, whereas a missing task must be reported
> with RTC = 1. If no request matches the nexus from SQCTI, this path posts no
> OCS = ABORTED CQE but still sets CUS = 1 and RTC = 0. Please report RTC = 1
> for this path.

Fixed in v4.

