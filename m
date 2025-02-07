Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2396EC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLb3-0005rE-Oi; Fri, 07 Feb 2025 05:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLaz-0005qh-98
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLax-00087Q-VH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmD+16UecI98MvulLKK3BNxXE9Dyx/qjgkaXyWooVX4=;
 b=ZqCSouf5IbDLUU94LkcvhmTsBCyCzzYdFFa6P7k32RdRnlxFsieg/eZrKORkwOhv+zbCkO
 OH1PobQk/tzyb34lPEEbL3GvirEdGarjITcq3ZlAcsv3PjefKO987YnwvPYhjfQhMxLlQE
 m1JWxKdxeWDxWIYJ9qL3toVOpVqiLdo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-7XnYmGriNiWw6d5oHhLG6A-1; Fri, 07 Feb 2025 05:28:21 -0500
X-MC-Unique: 7XnYmGriNiWw6d5oHhLG6A-1
X-Mimecast-MFC-AGG-ID: 7XnYmGriNiWw6d5oHhLG6A
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa689b88293so210725066b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924098; x=1739528898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmD+16UecI98MvulLKK3BNxXE9Dyx/qjgkaXyWooVX4=;
 b=mkCALqWsIy6N9XR3TiIGwCTskssLAWMERheOqn0r9kzX77mYr3UHXe4n73TOk9m99y
 TfLhacNQarLH0XoOeg42pNIgsMtnZXsH8ry+bBsWOZvNkMoBP315LlxvrzVhfKD9AtYq
 crnchRgjExOwBCaDdcP2DR1zZneyaHqVCb3kWGuubDyO1LWNsLjQcyzjsztuf0h2XUPb
 yoUmSW6Ufc2ZOUQY5Ap4H+ZQ0MMrzNd40jilxVMUdoV/x83Y8vr4mabTMyrY/kMq+qrd
 cqg3sLT22/tZfd6ATbKpmN6l0RQ5H+38zJS+1zY/MGkXMvyX9oTQTgc8Ixqr/5WCqwWf
 4j5A==
X-Gm-Message-State: AOJu0YyyPUplMYA5isQ9+LU8KYtP4qgUKpArrTtWlt3Q9R/ecnlLRA12
 8f1G1p7KgzqDShlzfzg68yUYBNTK0JSc6Cx0cnoYLAszA4cmePjcfJzzThx4QljkUpVXA3JOF+g
 UXKb9HlxlGBYy9dGMT/oZBD8TLZASGbPjwXVgfbx4T3AFkdt8UkL0pcWEBi4cSOW0KfIMsnwbLo
 NZiI+9T3pCn6NHqPQw/d7uN6+/TqJUy7xA089jjVM=
X-Gm-Gg: ASbGncsQGfeLlHjWX/fIn+Znx8C4UX1eSFegmqe2GN+q+Fg9vSfd6e6KE4yeMQmvjjP
 TD5Iwqm54TpCcHLK8c4JHrqF8mISr25xsbVoC3uW69i2/jkw18ct7nLdxZMhDp8fN2G6VhcQ63t
 xyvd48nllqS4Ek7lKr/Ob5X2oMOv5Jl+2WnZ5ryyRYty8VURxDExcRWV6kTDmXYJ7h7iZ+m1SHF
 /321ak2GGPGyXyhGa5Y5r1exCurbwEvCIv0NCTyUeecUHe8PYYqUoqwgd0EpeBKWtrjioNHnVq8
 f7Q5ZQ==
X-Received: by 2002:a17:907:1c22:b0:ab7:647:d52d with SMTP id
 a640c23a62f3a-ab789c6e8c9mr254972366b.51.1738924098129; 
 Fri, 07 Feb 2025 02:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3pIFrrCOhJOG+jMA5c1EXWcW5vtHuGhARLTWqqy9/HgYAXS+TWh4WXlKHJQZrLVarFPzZJg==
X-Received: by 2002:a17:907:1c22:b0:ab7:647:d52d with SMTP id
 a640c23a62f3a-ab789c6e8c9mr254968966b.51.1738924097616; 
 Fri, 07 Feb 2025 02:28:17 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab773339993sm243521766b.140.2025.02.07.02.28.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] rust: add clippy configuration file
Date: Fri,  7 Feb 2025 11:27:58 +0100
Message-ID: <20250207102802.2445596-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Configure the minimum supported Rust version (though strictly speaking
that's redundant with Cargo.toml), and the list of CamelCase identifiers
that are not Rust types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/clippy.toml | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 rust/clippy.toml

diff --git a/rust/clippy.toml b/rust/clippy.toml
new file mode 100644
index 00000000000..f42154e95ec
--- /dev/null
+++ b/rust/clippy.toml
@@ -0,0 +1,2 @@
+doc-valid-idents = ["PrimeCell", ".."]
+msrv = "1.63.0"
-- 
2.48.1


