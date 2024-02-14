Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E67C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDa-0000iv-KB; Wed, 14 Feb 2024 06:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDU-0000VL-Pz
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDR-0006oo-9o
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNWmEEc1AFwNYSkngLIcbrXY7t57G8tK4w2tVPlRoEk=;
 b=Gfu6pyRK2Uh5TUROp3NIvXlhzafjvcoBL/AafcIVZ7W8o5qJgoLKK3LKWzlKIGiRk1fY8k
 j86GGW3M0+cKTtITKGE/9vOvVgDM7ypZcKZRRldHJLZGbBHfjVtF/cXb5v7ckpNZZ/TZTj
 x2/N7aCWwJxicU52PDqoU+nhOey/olI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-MRMpxzFPOdu8est3MnBadw-1; Wed, 14 Feb 2024 06:14:11 -0500
X-MC-Unique: MRMpxzFPOdu8est3MnBadw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso378365566b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909249; x=1708514049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNWmEEc1AFwNYSkngLIcbrXY7t57G8tK4w2tVPlRoEk=;
 b=hDDMS7zxJzHBTe1zAxNhJztu3wmjt2O5Xc1v44cVl4+YKnMmMQxfbQibtjYv3LcGH7
 JKu8O/Xv8fTphqe2BFN8uy40Smhau3Gyj5QnGT+gEJpefQ29Fl2MyCWq+Vyl1TfWwK9J
 c6TzQN0AU9zCu9I+dRvX5utY37YokpPsB+2RMpAczDOke9YVkhE9jJNtLcThTEDKHPQs
 CwJFJyLd9qcSVnwVJg7tu9y3WBfH+e2F8+MaGik3C3BEif7UAtbPB4g3r32x+aYpZiZX
 Kn1dKR5QShENTQkmg2ZCxhFXI3biKVVdevKL/UWG3johhTeWZ2hRcjPqjJaKIjZYpsTp
 0V9Q==
X-Gm-Message-State: AOJu0YzxWLqVqD6OT4DszStnQZdNSYAhNpj4VCFvv7Ccn8cXxHGSOykd
 xJBN8TZQ6l9Y4TfuilvWVmu2zDUzEd6xbXCtqzF1qhUIAT4LtDP7kvlQ1EI+VoQAdzraKZJUDbN
 kSZl9o9BrEAKd1bAUoY8BRFv6IavzGj2xSZF0aQu8ReUUz2bFtNBLWFzTaM0TACJLIab64UvPp+
 oIBatGq5fP8eS92ho15wg5gS6V8LrRFA==
X-Received: by 2002:a17:906:6bcd:b0:a38:7171:e832 with SMTP id
 t13-20020a1709066bcd00b00a387171e832mr1494960ejs.32.1707909249560; 
 Wed, 14 Feb 2024 03:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcJcIqC2Rx3Amk4km7PEH/Cc9S3s4kSzJDAyLO2TNhWkc9ZBHrpKBncETIiYFtU0eEQT5Zmw==
X-Received: by 2002:a17:906:6bcd:b0:a38:7171:e832 with SMTP id
 t13-20020a1709066bcd00b00a387171e832mr1494942ejs.32.1707909249331; 
 Wed, 14 Feb 2024 03:14:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW94K8mG1H3qnLzA4JpVm+kEWSUzDLv41ZTHTu2qGtxvblA7C62zwc2sFXkrjbVT/hCdfvIA7XpUknG/NoTImE5gr6XCIta3yVZuMs2naxM4DKBRcQ/QuAHZthICSIG5lZIDCaXI8TxzFq+36i9QP3u/Mw=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 vo10-20020a170907a80a00b00a3cfd838f32sm1620231ejc.178.2024.02.14.03.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:08 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 16/60] test: bios-tables-test: prepare IVRS change in ACPI table
Message-ID: <595cd6fd9dffe51ef3fdb3077979a87ff2947b1f.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Following the instructions in bios-tables-test, this lists that IVRS.ivrs
in ACPI table will be changed to add new IVHD type 0x11.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-6-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac420db6b7 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/IVRS.ivrs",
-- 
MST


