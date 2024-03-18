Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3352AC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeQ-00074s-TJ; Mon, 18 Mar 2024 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeM-000736-Eb
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeI-0004YC-Ac
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vb2XPO70AEln4QjXZz3yhsVjTizmmAgSKUpNYloZ4WY=;
 b=L8xP/mfujITQSvXXTxqTtukjFBht4alfg2cNi0c4NdUu+ZZ5yLQDGq9lJaTw1CwyBfTBNp
 alTahWAt/Q6vgSgJQ4JWq91KpGcsMDGbfeEsPqgaacf3J0OpMw4otjhyWbPZgE21gdTjXD
 /kHMEvsStr5f6qAQIIUH6JSCmMBhGMU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Uu2O5rtpMLKvFUwUfz0uMg-1; Mon, 18 Mar 2024 12:15:39 -0400
X-MC-Unique: Uu2O5rtpMLKvFUwUfz0uMg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513e3ed9bc4so1433167e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778537; x=1711383337;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vb2XPO70AEln4QjXZz3yhsVjTizmmAgSKUpNYloZ4WY=;
 b=udtaa8qCTTb72652P61YUXEEaLxtYD0dMyuAsWAHfrgIoxJCJeCIL3MK7BAmT9Hikf
 LoWLBje5f1zCXHGwf516lM9eHZtDTSvImdMgKMfOIXaDDnNlQ0PeVczjA6HgWLqXjPBB
 fTtmNcQgQ/NzJr0WSbmAOpaFDyd/bBMiIQ4/G9CzbQ5tfDQHoKu0jIBYBVAPD3+tQn0b
 one0UnTM+y2sDWkiBeZlL0lXvJNvXp8I/ph4ki08cRPN+/d9kwg+JqdBP4sd3Nbk0TUB
 pXPOO5UyenckMqq5yJnjiWdo89fJCyuyePryOvsgAORixPQoO0qJbFNcpxGNkkOZgZn9
 EwjA==
X-Gm-Message-State: AOJu0Yywa1jSZ8tR0V2QJdVWEgyKbVl66PhdKEFJL41/pe3xcJVbRXIE
 oGsppf2rj/Cgf6LbUdETwcc1JMzuFmoLFiYHznVAZHZGe908k0cGzGgrmX6zL01zGbteUHAN5i5
 2msoFoVP6pNk8aIY4DF92OKz5S04k+sFKU28eD1wuJeTGL59fwsk4Wq4FbM7Td+tkEtivpQy3Vx
 9lY9TfdEbo/RucESvlkr+hmQ1Wa0E7GQ==
X-Received: by 2002:ac2:5b4c:0:b0:513:dbcd:7b87 with SMTP id
 i12-20020ac25b4c000000b00513dbcd7b87mr5935277lfp.45.1710778536947; 
 Mon, 18 Mar 2024 09:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIgj/Lp5jF3nKobkQnCf+d2quJ4MMXqroBLW0H1WUuvzdCxIjmS2bO6kCJAs7EkSMzyroqew==
X-Received: by 2002:ac2:5b4c:0:b0:513:dbcd:7b87 with SMTP id
 i12-20020ac25b4c000000b00513dbcd7b87mr5935247lfp.45.1710778536311; 
 Mon, 18 Mar 2024 09:15:36 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 fj14-20020a05600c0c8e00b00413385ec7e6sm18525269wmb.47.2024.03.18.09.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:35 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lukas Stockner <lstockner@genesiscloud.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 02/24] qapi: document PCIe Gen5/Gen6 speeds since 9.0
Message-ID: <1bdef7a6290b1a7ed820aa2e9c25fa85069b2b85.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Document that PCIe Gen5/Gen6 speeds are only in QAPI
since 9.0 - the rest is since 4.0.

Cc: Lukas Stockner <lstockner@genesiscloud.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Fixes: c08da86dc4 ("pcie: Support PCIe Gen5/Gen6 link speeds")
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/common.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 867a9ad9b0..7558ce5430 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -107,9 +107,9 @@
 #
 # @16: 16.0GT/s
 #
-# @32: 32.0GT/s
+# @32: 32.0GT/s (since 9.0)
 #
-# @64: 64.0GT/s
+# @64: 64.0GT/s (since 9.0)
 #
 # Since: 4.0
 ##
-- 
MST


