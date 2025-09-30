Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8B5CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vck-0008P5-9a; Tue, 30 Sep 2025 04:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vci-0008Oj-04
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VcB-0000gI-Eg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-414f48bd5a7so3627209f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220495; x=1759825295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=dkPWNGN7zF5fZQhZiFcb4FK/Cf/o7NFPXBn9KGlU5oFO9AnrxiSoySIygmjYlbKVaq
 YXqgSP6rLXJhj/DUXfzP/w7RjOSFHRBeRC5ggqYH/gey67ZJxyGH631asn7luULzHKG5
 1SVtFT0oNpnWtBlRLy9O3KHNBd4DdKoSN229NSvh5Zs+OPGZYodUHk1vwPvZrjE9zTe2
 rG4SYI5RSy3huFBcZc9RdkjTCw70pXDTvfGbvVA0j+SW5Dp6b9vjfaPgRvvb1FrR0M/M
 nHfGwtB3PlTNH+xgmt2g8HXuyIugDc6huTuDpAWwqiigqvpT6rV1hbWgaN2TIl60t7xI
 gi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220495; x=1759825295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6r7ywVdtgg6puBO7GNeh9QBn+ePwbPPQeAATrRMKjs=;
 b=N9uz9LOJF879D1OJKNjL3b3WiQbqCSkRkehVOWbAgsrnmd+BRf54+EL7pf10kc+9PV
 y0Bkp4zBJhCG80inu9tFaAUVojhT/APfXn4HEswnwKCmjv0GuhBik8TE0C9F5m07sD3o
 +XHaKplFOV8C2wUZiWnyuIJBkEvO7j16uU45BxAP58dDd2qa2FrYdUTqHzu63x/h7i5n
 42bzO5BUEFrlrpIweVVe15CwmiqLGAW5v3b3NtCGIztBya6vJJ+vTzqufWEoGCP+T5wn
 3Mskvf60tZmGy1tT7PJ3vFm9l3gLci8PwhIuTNOJcfEBTSPM8M1byx56+ovsv+fFPGtz
 /x/A==
X-Gm-Message-State: AOJu0YzBq85wtTzmLr0w+aUFSZDJ4f7Kdq+onLfjIWnY6/ceGlfj4PYW
 t/tfg9wZUadAzlFXXmJqwp4eLQSvNXXNUs1gdyvofa9lW7QeoLftUmn+mWDRPl5bTknww2/eWXA
 akuz6RtaIRQ==
X-Gm-Gg: ASbGncvFo6GCPf0phwQQTkH0DdcP4ea8bhZb1DsTiytVzBq3IWR1gjkSkVoDOZQC5Gc
 r2wYi3xpnWAQ06gwUV0FjuFOtU3TLxIPZcZMt56bIldRkK7QfV9lLcTGz15d5rEVaB1ExpMFyJo
 Ev9zH4e72YeIVOaeCROwQVH2prqXTdTeIhgw/2DgllXo6FQnGf5rmaIO4vLfblZCjrjH62ZfQSY
 0R/0CZsJe9N/cQPQ2Oun9SHVmT4w93rlOQApYWJPzFdp5vARHi7u72cgSNQGyF4RMFyPTJIsZrV
 Tjkixy99RXNy2Cg19g5H6+ssgxgCkx3kUk61wVy7u1msxSlYJECiTJ1fgM/qbg6QrGeCvKU+Dpc
 SZl9KurN2Kg2I/k+xBB2XCEoxu+hlRj5er7vL5oZed66H4sLtebduKmMZg4NLhVIhg38bbiik1R
 PhUBhdFDQzxnrR1sJO46VRN0DSAYqdiUk=
X-Google-Smtp-Source: AGHT+IFpI3GL5cse+8n+ih1oF0AV0V9hqADSW+14D/yEjGe7vAb5o0N9WY3TIiFao6rN6HuitLNGGw==
X-Received: by 2002:a05:6000:2089:b0:3eb:5245:7c1f with SMTP id
 ffacd0b85a97d-40e429c9c58mr19095049f8f.2.1759220494580; 
 Tue, 30 Sep 2025 01:21:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm21770765f8f.8.2025.09.30.01.21.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 01/18] docs/devel/loads-stores: Stop mentioning
 cpu_physical_memory_write_rom()
Date: Tue, 30 Sep 2025 10:21:08 +0200
Message-ID: <20250930082126.28618-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update the documentation after commit 3c8133f9737 ("Rename
cpu_physical_memory_write_rom() to address_space_write_rom()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 9471bac8599..f9b565da57a 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -474,7 +474,7 @@ This function is intended for use by the GDB stub and similar code.
 It takes a virtual address, converts it to a physical address via
 an MMU lookup using the current settings of the specified CPU,
 and then performs the access (using ``address_space_rw`` for
-reads or ``cpu_physical_memory_write_rom`` for writes).
+reads or ``address_space_write_rom`` for writes).
 This means that if the access is a write to a ROM then this
 function will modify the contents (whereas a normal guest CPU access
 would ignore the write attempt).
-- 
2.51.0


