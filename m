Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5A6E69E97
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDzi-0001GM-NM; Mon, 02 Dec 2024 16:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDzf-0001Dh-Fz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIDzc-0003Gm-JK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733175005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dE6n2aH7SwD8NtPPcuG3K79LVIdT6uB2ObA774GAEbU=;
 b=chIbrjWrljFWjXIIItQ8nZtCsBYNlbebIbCsUTJvojjMcCDYD5pW5trKdNbFBVL6SinqOy
 WVhDqqUCyrYTUCPeycQqeeabUymwIvhSxYXRy0ebwvBVB1rhkd0O8YvgaJfURPrqvo/IjL
 dAXwdXINBfuxcmN7AS2gGXi/6CJqMJs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-5WyRH4ebO9GF6H5REFUb9w-1; Mon, 02 Dec 2024 16:30:01 -0500
X-MC-Unique: 5WyRH4ebO9GF6H5REFUb9w-1
X-Mimecast-MFC-AGG-ID: 5WyRH4ebO9GF6H5REFUb9w
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b67a8cd4d2so642712885a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733175000; x=1733779800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dE6n2aH7SwD8NtPPcuG3K79LVIdT6uB2ObA774GAEbU=;
 b=vEtf7pbSKEc9nwyoIW0Y1X4o8Llb1gLRzD3hYQT7PL74p7mUK7cg6ANBgD8K2AFULh
 KDS50C2WBPk+JdRciyOtxRziCj42xdFpn/m7/ftxY9laaV9DSERYrG9OuZ7yfbg0JzuZ
 V2uLo+i8guF5CWu2RLKP9jCxO0MlCuSasj+m4X/ZcXF2Xzx7aJOR3pnlLDLkNe2C5rAC
 7NBP/FrEtm0iXXnoXav58Fm4XJhXEI3kNdnE7a9QPm2RQRYpsXpX6OenFF1ZsFPKo0Bg
 +GLQGz/YhJHFv7bP6wlAS0dba3cPIC4iCYuCdQzAKRn+nNlE0aNfqT4b+tU5Nb5CS/4W
 xBNw==
X-Gm-Message-State: AOJu0YwhFVV9f7bzqXxNmw5uhqKsVUk5IVbzMluLSUo6f1XuD9DYZpod
 6O3cFRzZp1YJaPypsTDdKyn7l0qytKDCRqdqSKj3mV34724n418caSDFdGHM/I5ifyKuIuj1/F1
 BS+ssqzQSqG1sPFM5nUCSoQRpywdayDnYmLgIdnA8Ud8K6Z2XBIZlQX6yk7I04tx8YA4NOvHwNi
 9vI9T0z/H6pYNNAv8loIu6WD9iEljx/hm1dA==
X-Gm-Gg: ASbGncthYzvz+3y2Hif2Rh4AptcHmeg/B6iCGpunygfOW0OTBU3fiuriVBOBivDUdRZ
 9AuJ15aUvV9YZEjk2RNQzJea6QXFF2e1aOWhzeJp4IpfPkPTwEB56XuoPkKPXYGp3dnGvJWIf4h
 ZaQRmwkn3WqesjQqWBrrVTD90rYiR3XQnuAg4t8cuODJJel8tcFT86OUDdtLcpJHzpq9ItwVm+k
 pxCl8Ztr4lPWlaoQsd+vFMAQ9zMdeaGNAEOvVxgh7ALg6Wd6jWfRpBFGcNtOOQ1nTP+FNUGqY1B
 Cs0ABKGpmyjgWuByxoTKrANiKQ==
X-Received: by 2002:a05:620a:4049:b0:7a9:b049:1c3c with SMTP id
 af79cd13be357-7b67c4a55f3mr3181735185a.59.1733175000119; 
 Mon, 02 Dec 2024 13:30:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHINfmwyPNHE1BF8TbrtEh34IQlEheqOnp9cOoGMkaVpjE/Eax5OpBGrTxslN06UQeYLUWkFw==
X-Received: by 2002:a05:620a:4049:b0:7a9:b049:1c3c with SMTP id
 af79cd13be357-7b67c4a55f3mr3181730885a.59.1733174999683; 
 Mon, 02 Dec 2024 13:29:59 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492c9b4sm445642785a.29.2024.12.02.13.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 13:29:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 peterx@redhat.com
Subject: [PULL 0/1] Migration 20241202 patches
Date: Mon,  2 Dec 2024 16:29:56 -0500
Message-ID: <20241202212957.570277-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b52938:

  Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu into staging (2024-12-02 16:16:15 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241202-pull-request

for you to fetch changes up to 3b83e663611c628bb04ae84a4f7ee49bdb68138b:

  migration: correct multifd receive thread name (2024-12-02 14:20:44 -0500)

----------------------------------------------------------------
Migration pull for 9.2-rc3

- Prasad's one fix on thread name typo

----------------------------------------------------------------

Prasad J Pandit (1):
  migration: correct multifd receive thread name

 migration/migration.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.0


