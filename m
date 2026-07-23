Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61FC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxQg-0007ue-VV; Thu, 23 Jul 2026 13:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wmxQf-0007uN-SP
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:41:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wmxQd-0005gK-So
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:41:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso432427f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828510; x=1785433310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/cf6kQIx7implXn1s6QI7Mman3N6ab3laLzvURomzM=;
 b=HYzIc7XGkRr8tf/p3AGRVx0aI7/Wk7QsgYB/LuGU8R3OC9o5NmNjQochgDpybAyZuH
 SPbjvTGpZ8J6F767coM9QRLFiPRU64/sXSB2aDPo/ySCWMV81WnMPs6LN1bRGuwlVxQO
 4QKbxSz2gQTT3lmcgpbLHJFABqmj5TAMUvddckoXFbfcvF8cWOQTISZGlRbDYboFbinS
 xGdEkrMTl+CMkbbOzax/JVV2shpOoZ9AZFo6kFijB2oojSnvVPeR85mGa3hG5KGkpYBK
 ADC60U8FTLlA+OBqM0Zl40STumZrkWCCh/KxU2KM2jZLUDJuPbll6Cqa9qxHKuvIkgJq
 5Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828510; x=1785433310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/cf6kQIx7implXn1s6QI7Mman3N6ab3laLzvURomzM=;
 b=NzCtPuswvRU/Q8WHsQxD+WZPeGKLT2wkDIkJMMLR12PADXLo6GoI5I0F0Kdd2BmwKR
 GBPej3xYqBxbcT/EaMJ71bCtMvYEi/KDEsFpPiVYnhuiZPX/lfFKguKBU8Qz8LE48+p0
 SovNu7Lc3gDxYYgVRupl1VO9kuQekqh32XQcSwyTCdgDZ8pI9NVh2Pj51o9zNIau2QSC
 E7dfgjwJcXHwOGDj+Gj6wqfZah5dw84kcVenS5K7sp0i6ZlHYCQ2+NNMw2QD2Rxtxate
 3ubMDa1oUOaHpFwkj4yORE5AzVQgSG9enm/D2rigj2+FPKUnQZZfxBASqr5aWOzulla5
 byzg==
X-Gm-Message-State: AOJu0Yz2DZXHI6gjEvW45NEKOEPMkx2xZTSfVNtoiUDu+2Ip9YbR96nK
 z0Q8BecocQpZczyh4CXyQ2sunkanicxxz0XPcHK55+0v59wiK7g0NFSnAsahKA4i+oo=
X-Gm-Gg: AR+sD11vZDCrRPCWe5UD5HB2GA29GO/baXA27va2c1lMFSCZwpOsB0dtw9+ZlfxBeot
 P9wFRbMkcYYr53dQ3KK2e9XXdSz8oHWrGQccCAaMUKWL+RuQ5wHc7f6KEeoTp3laUNYuwRBVpy2
 iBsEG/dqIcD6/3dRWCUB8PJ/mkFNGKTEQ/Tka9CANjqS5NcGSDZpIs8Wmy8zOpiw4Y5YmSNexUy
 6byh+lPJ5bD08lfJq8TS/nHJ0rvqiOZlKpPi8I82c36fTt213Kh7d5GH59OmjJ7qTyty/7YjY++
 IAXicHAb/fJsXO25vBVqLj+Z6NuawmIqpfuXvl7WJ5e3xmMrm5l3AJwfSyf8FanH2eP1Cuj61LP
 dCo90pBnFkDeBmexW2LC8Yw0tjXfqgc6HoNVEg+0oYM2Gu6JMTcdTziqB/LELju82/uiTTO+MG4
 0O1kfv1J0=
X-Received: by 2002:a05:600c:4e89:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49573ccd115mr51286885e9.10.1784828509277; 
 Thu, 23 Jul 2026 10:41:49 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49571c4b664sm68460735e9.4.2026.07.23.10.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:41:48 -0700 (PDT)
From: mike.malyshev@gmail.com
To: qemu-devel@nongnu.org, Tomita Moeko <tomitamoeko@gmail.com>,
 alex@shazbot.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
Subject: Re: [PATCH] vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU
 passthrough
Date: Thu, 23 Jul 2026 17:41:47 +0000
Message-ID: <20260723174147.479506-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e7b38b86-fde1-400d-ae5f-5b2ad0b4cb6e@gmail.com>
References: <20260717084942.1555442-1-mike.malyshev@gmail.com>
 <e7b38b86-fde1-400d-ae5f-5b2ad0b4cb6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=mike.malyshev@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NEW_PRODUCTS=1.249, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

Hi Moeko,

Thanks for the review.

> Just wondering if this aimed to solve some kind of "CPU pipe A FIFO
> underrun" error. If possible, could you please paste some log? The i915
> driver seems to only read POWER_STATE in gen9_dbuf_slice_set(), and a
> warning should be printed if there is an inconsisitency.

Worth clarifying up front: the guest here is Windows (Intel KMD), not
Linux/i915, so there is no i915 dmesg or gen9_dbuf_slice_set() WARN to
paste. The visible symptom is corrupted scanout (~128px vertical stripes)
from a plane FIFO underrun, not a logged kernel error. I have not run a
Linux/i915 guest on this platform, so I can't show it hitting or not
hitting the bug -- and per your point about the WARN, i915 may well flag
or avoid it, which is consistent with us only observing this on Windows.

The trigger is a single inconsistent read on the first-boot modeset.
Captured with x-no-mmap=on so BAR0 is trapped and every access is visible,
the DBUF_CTL programming is a read-modify-write that never sets
POWER_REQUEST:

  vfio_region_read  index=0x0 addr=0x45008 data=0x4040c000  # STATE(30)=1, REQUEST(31)=0 (stale POST leftover)
  vfio_region_write index=0x0 addr=0x45008 data=0x4043c000  # RMW: tracker bits only; REQUEST still 0
  vfio_region_read  index=0x0 addr=0x45008 data=0x0043c000  # DBUF now powered down (STATE=0) -> underrun

The driver sees STATE=1, assumes the slice is already powered, and leaves
REQUEST clear. Only after a display sleep/wake does it actually request
power, which is exactly why sleep/wake "repairs" the display:

  vfio_region_write index=0x0 addr=0x45008 data=0x8043c000  # REQUEST=1
  vfio_region_read  index=0x0 addr=0x45008 data=0xc043c000  # STATE follows -> powered, scanout clean

Same pattern on 0x44fe8/0x44300/0x44304. This was originally reproduced,
and the fix hardware-validated, on QEMU 9.1; this patch is the forward-port
to current master.

I'm happy to share the full trace event log (~400 MB) -- where would you
prefer it? I can drop it on Google Drive and link it here if that's
acceptable, or attach a trimmed excerpt inline.

> Here GVT means the GVT-g (kvmgt) driver under drivers/gpu/drm/i915/gvt,
> right? Please correct me if I am wrong.

Yes, GVT-g (kvmgt). It emulates STATE-follows-REQUEST for this class of
inconsistency; this quirk is the read-side equivalent for full passthrough.

> IGDDbufCtlQuirk *dq = g_malloc0(sizeof(*dq));
> dquirk->data = dq;
> would have better readability.
>
> A `vfio_quirk_alloc(nslices)` might also be better here?

Both make sense -- I'll split the allocation and use a single
vfio_quirk_alloc(nslices) with one mem[] entry per slice.

Let me know if the patch looks acceptable in general and I'll proceed with
a v2 folding in the above.

Thanks,
Mike

