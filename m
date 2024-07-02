Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7673C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxv-0006Gi-34; Tue, 02 Jul 2024 16:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxQ-0005M6-RX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxI-0000MV-GL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=J9F1JBfSXBC2c7IviaI5pP2LOvDB4Uqkd2kygHU4kuEjtWVSIVzOGaikuZ0Matc0PBHUOn
 d5BuO9zTCwzgTqZs3fyHo0oQCqQ5NWIlkigLRcqsuzLJTqu/jLgamLeb3TqGRx/Ud4va7c
 78e2Anunro4LsTKe4I+POfJoQd89rEs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-503S1CFmONG6Q3uepPP7FQ-1; Tue, 02 Jul 2024 16:18:20 -0400
X-MC-Unique: 503S1CFmONG6Q3uepPP7FQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52e960523ecso45672e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951498; x=1720556298;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=fU19n9H2aZMtp6XXw1RCJsHfZwt0gij41e44BFIzRNVhAHsktfGGNLk1RhCOlxHhgx
 QaKoKf/dMktf0l9Rp/6HG78MUksO9e9DTfrA8cf3tv0w+GO51GJ1AFkx9zKfPtIBgEXi
 bvY9ODi6KFsP177t+sUXUFgMyIAdrc8L2/4GRMlpG+b5CKjKWox0swbuK72fqzQ9ut1P
 cSo+5QI2J/vEMN4emqb77W5bvxdyxW8Ev6u+a6a78YQWlwkkSqaqxWkIMpW5gmuMUYVl
 HiufX1/uQdx4iQWBTYei9edoopzlJ5dc47fYU2uBOSqbynRYi1+8AnhQqUpJKGheeBRJ
 y4Kg==
X-Gm-Message-State: AOJu0YzZdMXjexH894lj7sK1s9q/UR5jSE8vmLIN31+AA41STQlQCJ9a
 0Sx2Jrn/NqkNfEr5BxgkndpOcMEzIuyamASsWzts8m1m3mVvh5lWpYQCmJpkYxbyPNGbax+IGZD
 DsuDjn1sa8Sh/j/DaMsuEaUgaKEkLQz/cjOnyrCsl/6YLkJZ5+zWCvrThq/MbHd8EmR59s07XDB
 yxjsHihKcKLMmlwRtY33gZsRn6A802Dg==
X-Received: by 2002:a05:6512:3a84:b0:52c:d8e8:b398 with SMTP id
 2adb3069b0e04-52e8273cad1mr6156349e87.69.1719951497917; 
 Tue, 02 Jul 2024 13:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiCNwc3VwMZrjVbUioIBAZr84x2nxdOAkiQz1TJ3VdXZVyzZNV+gzZ/teRfl1/mqb77kr4Qg==
X-Received: by 2002:a05:6512:3a84:b0:52c:d8e8:b398 with SMTP id
 2adb3069b0e04-52e8273cad1mr6156325e87.69.1719951497334; 
 Tue, 02 Jul 2024 13:18:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd562sm14181255f8f.15.2024.07.02.13.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: [PULL v2 46/88] qapi: clarify that the default is backend dependent
Message-ID: <0aa7f10c7af222a32e49e38df8383e394a0aa5c3.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

The default value of the @share option of the @MemoryBackendProperties
really depends on the backend type, so let's document the default
values in the same place where we define the option to avoid
dispersing the information.

Cc: David Hildenbrand <david@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-2-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..9b8f6a7ab5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -600,7 +600,9 @@
 #     preallocation threads (default: none) (since 7.2)
 #
 # @share: if false, the memory is private to QEMU; if true, it is
-#     shared (default: false)
+#     shared (default false for backends memory-backend-file and
+#     memory-backend-ram, true for backends memory-backend-epc and
+#     memory-backend-memfd)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -700,8 +702,6 @@
 #
 # Properties for memory-backend-memfd objects.
 #
-# The @share boolean option is true by default with memfd.
-#
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
 #
@@ -726,8 +726,6 @@
 #
 # Properties for memory-backend-epc objects.
 #
-# The @share boolean option is true by default with epc
-#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
-- 
MST


