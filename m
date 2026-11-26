Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DE606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OX7shb2v;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VFQaqjPz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWii0-0008DN-Mq; Thu, 26 Nov 2026 18:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihs-00086g-Qk
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihr-00062f-5G
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=OX7shb2vno5Vk1ZRXiG4v1r2UfX/uInf16vE1lSAWVErOpwvVWbCWgnGtLMZfvp16zjsmD
 rSvbYjLYDpdvhi2LfBrwGIjbH13ejhObeXgv+Pmnx99v4pcBrJOCO8qtXwwklOfBIZBf6A
 GR9R1uqSpzKul9VBPLI5e78RPD5Ezpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-tufI0Z05ObyfgbcOcYxfng-1; Thu, 26 Nov 2026 23:16:42 +0000
X-MC-Unique: tufI0Z05ObyfgbcOcYxfng-1
X-Mimecast-MFC-AGG-ID: tufI0Z05ObyfgbcOcYxfng_1795735002
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-544019b1831so146436461cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735002; x=1796339802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=VFQaqjPz/i58IrimKy4RHh9FIoxCy7ZB9tGByvZ69asEY2cj8GZJzdBKxRfGnvFg+l
 0bG79cOjUE5tyzJHd32Mw6iNSiSaYDRbzCrnXSuNnEoYJP0AUpFzQH6RlZ88QbO0rx1d
 vmA7/vng7MGR7CaX1KNszKFv+iE09Mlvq0lxvLvSajcbtUAawQueE4XWfEm4iZGjcZ/5
 rw7szVpDfQQ66g06n3BJnKaTWye0xzobeFfDnAD7wQv3QozFhcHEpIVfkxsFEIfoyO74
 vv3h7yzvZ5tpOw3cbsTYnZ7nZ5kA7N1zMUzmgxZ2Wx9Z3e9be/VI4RyH07udHHWs10Ey
 D6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735002; x=1796339802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TPBdbWhRH+ndA7WfjTIrEZ1e2jC4NB4OMmjiegGEePI=;
 b=KPtVGsL8Dm7gu/NT5pnvhrGYgahHdHfHYiKVfE87/3fOC7eXTD7RcKUlw/YA0Xf70w
 3t+O1vuArziIv4kB0VWkweTO7y5COyNd5jQWoGWCTiriU7HWimQ3KtfkpqO2CZ33duk7
 3Fa/7Sfcia5Wu5r8hmZh+GXW5s7u0DO6zTZIhMs18HcVkz5c58lQyQPnQ9yeNG1ocSEo
 2pqt4TLO5PDFlhV1GluZrrcirxMVxohGZh85gq5y2N0PoHbWeucROJX1ZXGaWUj45E/z
 RwgcAPPwlQXkpHnjJXwoFsyPoZdiXjELDv0/2b0bnqB11vFrbLr6LL04PYbGrzKkZaYz
 RpAg==
X-Gm-Message-State: APuU4Z9OrdyAYr4hApl/+5SFrfYN4QwW7nCmmrmsYSNpc1dBDTwG5jgz
 q0lwhwTG1LVgEBMK5BbJlueVLjqSMDuJHlMMszQlJgMjpW5yaQB9j9++DehWkhKflCxJyu8bkv5
 XSiCxYVXigq1tW4Dxk9oG+FdpTIcJQd3AUrYc9rAiWGajplJMfIVklAAYPtK1t514xYbW6WA41l
 +WXM2wFJoQiFILEXzIcsvZqn7zYTXS8oKMg56/mQ==
X-Gm-Gg: AZFdTZeTb4FHBoD9TUMnmZHHzXdGfM/I05SPWiv6DScTpKay4iAbnMk1tVbqNKMcV7B
 TMxJ+D3maQsOu5uCECi+DPuLh1eKlqU3Uy+kRxlgfrH7q01qqdbCvky/C2tKAeADI0dGymQOeeo
 OuL5KAiCsXomawpGaXyI0VivZvXQzFcCI8hxjBSCjpGfqzDoK2UHMXBXH7fzQsvvuTn5iQvDPWy
 E16RARh0Sfio3yb5MTOu480UbwUxDIjgkEhHXpUB40IzO0GnpUPr4JbJabTWm83AxyjqzaltY7r
 JbnPsMmkNsj4WOJAAVzxYf5lXTihkE+D0Dj6G2OmWaxCOg9WBVquV4ACk1EknUEaZ28mf2UQ9pk
 QpMu2sNlvWLE90zvtCabX8cF5srJIAUG3JoSgaiomxLmg
X-Received: by 2002:a05:620a:45a4:b0:944:110b:d824 with SMTP id
 af79cd13be357-949ba8237f7mr4170134885a.5.1795735001928; 
 Thu, 26 Nov 2026 15:16:41 -0800 (PST)
X-Received: by 2002:a05:620a:45a4:b0:944:110b:d824 with SMTP id
 af79cd13be357-949ba8237f7mr4170127785a.5.1795735001111; 
 Thu, 26 Nov 2026 15:16:41 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94a0c18267esm431130785a.4.2026.11.26.15.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:40 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH for-12.0 v2 4/9] pcie/aer: Remove the usage of
 VMSTATE_VALIDATE()
Date: Thu, 26 Nov 2026 18:16:26 -0500
Message-ID: <20261126231631.3392756-5-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paving way removing it.  We can replace it with a post_load_errp() instead.
Tested with migration with "-device ioh3420,id=rp0" against pre-patch,
which means migration compatibility is unaffected.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci/pcie_aer.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 43b14c1f22..87248556d4 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -807,21 +807,51 @@ static const VMStateDescription vmstate_pcie_aer_err = {
     }
 };
 
-static bool pcie_aer_state_log_num_valid(void *opaque, int version_id)
-{
-    PCIEAERLog *s = opaque;
+typedef struct {
+    uint16_t v;
+} tmp_u16;
 
+static bool pcie_aer_state_log_num_valid(PCIEAERLog *s)
+{
     return s->log_num <= s->log_max;
 }
 
+static bool pcie_aer_state_log_num_post_load(void *opaque, int version,
+                                             Error **errp)
+{
+    PCIEAERLog *s = container_of(opaque, PCIEAERLog, log_num);
+
+    if (!pcie_aer_state_log_num_valid(s)) {
+        error_setg(errp, "PCIe AER log num too big: log_num > log_max");
+        return false;
+    }
+
+    return true;
+}
+
+static const VMStateDescription vmstate_pcie_aer_log_num = {
+    .name = "PCIE_AER_ERROR_LOG/NUM",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load_errp = pcie_aer_state_log_num_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(v, tmp_u16),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_pcie_aer_log = {
     .name = "PCIE_AER_ERROR_LOG",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT16(log_num, PCIEAERLog),
+        /*
+         * Only to use STRUCT for a post_load_errp().  New code should try
+         * to use something look better, e.g. subsections in order.
+         */
+        VMSTATE_STRUCT(log_num, PCIEAERLog, 1,
+                       vmstate_pcie_aer_log_num, uint16_t),
         VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
-        VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
                               vmstate_pcie_aer_err, PCIEAERErr),
         VMSTATE_END_OF_LIST()
-- 
2.56.0


