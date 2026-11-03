Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28152606A33D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c4Elh4FI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k+tQPJRM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2M-0003ed-Lj; Tue, 03 Nov 2026 06:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2G-0003be-QE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2D-0000K5-8G
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhEdBOGUBF5XH484uywNcup3u+CPILKNoSQkyF0EXK0=;
 b=c4Elh4FIWZ0CrB4vRFG+XCeo6aAJdt4XCYfdNr4n4u0ETTkNypZhqAhFqunjByjiiTbp3/
 AhS4+W38BgYsosDcwWdFKJ22FraZ8y9fflKYGJu0POd4ygMUq+eu0gRU9HgIVb/2jTj5VJ
 jfmKJ+Nmk/6NSiNF6+336wW8K5lC5Bc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-voqyWbI5Nj2XGAjyAIbg0A-1; Tue, 03 Nov 2026 06:50:35 -0500
X-MC-Unique: voqyWbI5Nj2XGAjyAIbg0A-1
X-Mimecast-MFC-AGG-ID: voqyWbI5Nj2XGAjyAIbg0A_1793706634
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso35081295e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706634; x=1794311434; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jhEdBOGUBF5XH484uywNcup3u+CPILKNoSQkyF0EXK0=;
 b=k+tQPJRMxl6GIfc7y0+6fzu3Pe3ZsC0AJhkK/jC+9bywtRX8RiHlVNLbEPxKsR/L6h
 0N0kEGuHjArVwwyKVKFEP2n9/fYHffQkZ9xLffyikor15Pv0D18zqtyMFVAgT/H/57oZ
 6NdX+2vM2fhqSealh1n8IGuSr2Tg2390HfeiZwK0kUbxfX4SzgiccSzjRi/6Yf/UG1Gh
 gpZtzt00aDZYRJfe4C4V7SvdAhi6bZuRZWRx1lDWVuB9VijuUaGsVqjrHJP/L6d9jv/z
 g9b9lRHDW3HZUE7a6Cxf1CwWwnOuzWtKw3veam4zxPjrsJss/J+4uYiMMIjWHAvgPbVO
 XWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706634; x=1794311434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jhEdBOGUBF5XH484uywNcup3u+CPILKNoSQkyF0EXK0=;
 b=JzKcoYem/eJnM/zwJlkFso9rZKCYZ4h9DnnKnrUA33tHuL7ZV4ZC6penC00PX2nHCI
 G3E7JHFdyKYB+7ZStLDz2RqLl/Jx1MwoauAqgj54/xJiN9mfPtQezJ1ZCS1+Wfs/T+R6
 oqgUDNk/Jk6pP+JvXA43XqAQpcWcT1VpEsu6PcRw2UvljMgeewIE7nCNLz5g3A9FZ4pn
 jQ70hXMy+Vf/rOgMhvbmX2lv0Zq00UgCCcHdTzUfc17YwKog/08i72kbCHbLVXI4lsVU
 ZVkPazV0kymaclusPjjMT0SV2y+I3iMJxWUx9KUOMGESDLUyYdTQgFTxq6pZ30NdgxnV
 Wp2w==
X-Gm-Message-State: APuU4Z8Pfnbxz7ZfvJCD590ZpjNOsedb7r9B5Ju4H3Pau1qVTIWJ4FgD
 xUPf5X/v0JjjvSfRmn0wGT6uXPQ7g/8zRhQbP9eR1HrEWF0xPpMhTgWWFT1UCWmNV46BVZQo30T
 W52qrmKbJud9eQZVx9xbjOJPvkWPyVaql8X2CPUwu6QrsArQuKko7B0f91NZa4gpYtexSYBXQ5O
 T0/7snR9fZBUEElb5hr0QAHKsvrg26bCv+pQ==
X-Gm-Gg: AYBFou28l9BMKOPSSjPTSPn9aAE727hAQDxMwqRYFpUEWNPcIIxn8N68XFupX/50YIg
 B0AszOrWcFvKNlPoh6lWnp7ZMGxt4X27CZHMJs7tO5LaAGKqnWliDJNiNyiZ9R8gqPMuwE0L71Y
 eDcdiS2w4UhfYMGtYUyntKhq8lzv1yNHDmLQm9ewxqY+Zly4Y5R+IXLQIA/edUI4zol1e7xYcYS
 PIXJpjC5+u7L1oWp+IWYemeUWwDYIvGqhoo/Gclq8FpgF0rPHsGTKpkEMbgUnp67u3EdUeEwc6C
 AY/VQ98Gpde38jABFgUGVugW/aCIN0lbxbBO9O7NM1o2jRYK6Iqt4eCI1Yg97BEaQUXKsM80COJ
 xkegMqo5I5E1Wx6iZr1ZEyUgajn3lCfuDvaZDl6Z/Vw==
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ac17d168b1mr327245575e9.11.1793706633895; 
 Tue, 03 Nov 2026 03:50:33 -0800 (PST)
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ac17d168b1mr327244815e9.11.1793706633242; 
 Tue, 03 Nov 2026 03:50:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77c132sm235400615e9.1.2026.11.03.03.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:32 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?xJDhuqF0IE5nw7QgUXXhu5Fj?= <datlechin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/17] pci id: assign pci subsystem id for osmates
Message-ID: <66086984bc9a42b6f85dc2e71d56cb5d16d44318.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gerd Hoffmann <kraxel@redhat.com>

Allows the guest driver to identify the host implementation,
useful to be more specific when applying quirks etc.

OSMates is an open source VMM for macOS under MIT license.
It will be released in near future and will be available from
github.com/osmates.

Cc: Đạt Ngô Quốc <datlechin@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261030115455.1121808-3-kraxel@redhat.com>
---
 docs/specs/pci-ids.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 53dd571de2..74460bb19e 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -50,6 +50,10 @@ maintained as part of the virtio specification.
   QEMU, such as the intel chipset devices.  Also used for virtio
   devices and generic pci class devices (1b36:00xx, see below).
 
+1af4:1101
+  PCI Subsystem ID for OSMates (github.com/osmates), will be used
+  for virtio devices and pci class devices (xhci, nvme).
+
 1af4:1110
   ivshmem device (:doc:`ivshmem-spec`)
 
-- 
MST


