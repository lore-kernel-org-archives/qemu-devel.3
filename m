Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24850C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4o3M-0003MZ-5Z; Thu, 10 Sep 2026 19:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVh-0006PK-Rt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVV-0004V9-2I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=S1qSnFHW5/Z5n3cj34nTdqqxbLo2Lhyqd0nEniGoXl4zVQV/cl/RVrBi3p/r+gSlb3yRYD
 ZZq1GnV71DnV0gTBVJxGSQ4/4GWK/j6i9/jzlYlLtZl83E6h8BNer9Km/jKj8u8UMf4KMC
 PmjSB1DJ9n5GmeqeEx7Tkl0LOfZ66vU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-BHsiNiuwN5SANcj84uYzxw-1; Thu, 10 Sep 2026 16:11:35 -0400
X-MC-Unique: BHsiNiuwN5SANcj84uYzxw-1
X-Mimecast-MFC-AGG-ID: BHsiNiuwN5SANcj84uYzxw_1789071094
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485f6788029so99764f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071094; x=1789675894; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=QOSFWrES8I3JCObd9bhSm4Ll4YvdlzQLEPv1VIYfwD0Hj91jy2yrsRyiOTU0Md1RAR
 cHAIiwZkpjXUmeSa2euEaanTXhT7xl4yNgcOqD+JtLN8LHQCjHvS1BqVsSsMZDxYca0j
 JJjIlSa8blWBLTAmXl8JRFEpdkZ49ELWGQcOHrF3NscADXcfcLDWGrcWCYxN888Q2iqm
 bonKc2Eu1wEYsyZdgShUQqzkN2uPmZkEPUK85UxZcVTeTtu0pmIsPla6hUbj1+wX5Euc
 ZB6ckbTwUnUuApNCnjfyVfbLuCIFBv7lhPv2IxfjuKqrUEbE4hqBIOHl6Cj3NTxgIT6F
 rCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071094; x=1789675894;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=pT/jM1dJr/eaGeuZ4b+eQSM/Ew+F4dIsm9pTwUeKMXl6u8lWY/WL9oCpBtt6YSpUVO
 jZLMqWeRfvx9pm0VW6Er2Ylb6UKjeFCeXyhIxAc25FLsbi7R+ezAZDNxBneOny9KYNoa
 ZxHO8CqAmjpD2+MxW4jYbv9AhEnDJ8eOf3Vb/DTdaw9Ie1hQShVV/9K/7XiJ8l4zcmIe
 8ikl7NPBQEuJm77l063W5hHaYKYU4oz7BD6a+Oq3UJQU31IqF71oBKF6TZ6daujFKZvm
 UNA09GZOUsv9TCCmqSo7PNsTZP+py+JWjKfH7s5GOnTI16rouBlBOXJimnE7AaRLyIiG
 HWLg==
X-Gm-Message-State: AFuF++lQ6RnM1BfcsGuWn/7mPQicpywY61quAyr+LJu2Bm31wSGDJsR2
 qNb38vs1mRgeMuZNtLbC3IlUZ8ZXgnuYs+7V3r70dBylc4u8sg8a7JCh8FrQqgHypY/N2+rUOjN
 QjMDqu92IN/pT4iBIb8SPIA9rbhyYmpAG4AZf+nFVEo1mOpvlal6+1rE9F6CP++x/viQHmUOWI0
 Ub3Yji2FDYAWlewQq/JAVy1rn5cpAcmgGCsg==
X-Gm-Gg: AYBFou1qljtzsTMWvqDBsQv21S8OGHfuXTitcj2XemLNkoDBu5vE7lV/S0TgA6wzRvt
 rrtGMFQRE4LFGLKPUkZE7PnVUIFAEwmcfu7ljHZehFwVBhJli00rMx+Dit93/cucgplDgyV6v6+
 p2j7WhlxKIOCumbhYR345i7h1a8xkfbDVkugh8CxMX9x0aWvjPJt2rVrMDiYmupXKLCYeuHDebi
 vhRMpnxkrGqgMooPjHFnFKGHMD+SmumVMrm9NhcWIajNjIFDQj+LKgtbY8T/MOTrs92OLftHvTu
 pFtMeScJ+UStNEvoCymJyJ/yNcOKFfiDqMO0ITHI1G6LVclf7Hi4aNm9GliQuVE0LX9nzNq1Nh5
 +8V/3affRjn8xt7cD/dYHrCo=
X-Received: by 2002:a05:6000:4541:b0:47f:9254:d453 with SMTP id
 ffacd0b85a97d-486eb2db733mr1044069f8f.8.1789071093723; 
 Thu, 10 Sep 2026 13:11:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4541:b0:47f:9254:d453 with SMTP id
 ffacd0b85a97d-486eb2db733mr1044003f8f.8.1789071093177; 
 Thu, 10 Sep 2026 13:11:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm839873f8f.9.2026.09.10.13.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:32 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 04/90] hw/cxl: Fix guest-triggerable QEMU exit on reserved
 interleave ways
Message-ID: <713e7e85a2b43e9d4e58d91643aef230d2c30b07.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c  | 2 +-
 hw/mem/cxl_type3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index eba13c9e7c..369a985f9b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -442,7 +442,7 @@ static int update_non_interleaved(Object *obj, void *opaque)
             }
         }
 
-        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, NULL);
         if (interleave_ways_dec == 0) {
             return 0;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..6f44770db6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1200,7 +1200,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
MST


