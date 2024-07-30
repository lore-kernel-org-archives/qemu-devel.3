Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631E7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpox-0007AI-TC; Tue, 30 Jul 2024 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpou-0006tq-9K
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYpos-0005ko-R8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722357325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5LSiAOYjzbi2o2Kyzo668us0AG4xEjNfi7pFYkQXEYM=;
 b=eotLYxU6eCd8pezRSYxBc/40l8HLP1bjqbXXS/bh+KolviJD6Nexyyl0UHASR+gMBl+kqL
 2CzdhyKBy5JHpYaO8HOWI+rvpTS6woI/tn9ZQtbRlx2XFJQ5zXhRs4EXhpjlF9KmfE2iVm
 G9CHun77YcQOnw8DsAtq4Gs4Aj4eMbI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-Usdqm7PdM76RMN5ZWJG88g-1; Tue, 30 Jul 2024 12:35:22 -0400
X-MC-Unique: Usdqm7PdM76RMN5ZWJG88g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a0fa34d1c9so5192058a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722357320; x=1722962120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LSiAOYjzbi2o2Kyzo668us0AG4xEjNfi7pFYkQXEYM=;
 b=ttlmG9lKtFzoAEXaufU56nbQtdAHMmLGiQKoIQa1doSsKLwTXnPxNvk7Ceu23Ln7Xh
 MuVc6dwMSmNliP+yO8ShYmyYemm6gz3eD68ES3JiDVrjA8hw8MzhowUcwOYGCuy7pWIp
 DvSWL3K0mSZIND6fXXxdXz1BMJrWMtSR1wAmilU0YkXqGPO3cfSLoivAMcC35ATDlhVe
 kXmMGT8yGEcosipC1DQ+KQJr/oSIPI00SOdisMFik+PUJJeroq7l5QdD37MOy9xkQzqs
 fF3wUsTQb1hMWeeG5P4YcEDwsWd/HDWBlG2MeUezGMry13+5cznq2/Pm2CPfijPs63XP
 12JQ==
X-Gm-Message-State: AOJu0YzR1pCtJcOec0yf4u788CE+PwE1e1BklpVdv9heDZFxuX3W90Tj
 95w986GWAC8WVznJoprgmUkhyMIuZC7K20NU4oPf5mKNgqKPklrcKVv2I3CUQ8ei3YgrT1aNZ4T
 etfAUGSWc2O4MiQCggzwmk4GtW6H1UF7LXnTXgcMdQXPvS/WCHbyxKOAbRmoXwzujhKcaGodWXw
 8frq9sCsFjZK8mVraDMT9kf9PgiCaSSwvkIPCa
X-Received: by 2002:a50:cd5b:0:b0:5b4:4bf7:59ef with SMTP id
 4fb4d7f45d1cf-5b44bf75b5amr1991254a12.6.1722357319805; 
 Tue, 30 Jul 2024 09:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDleRUynbZ+Iu5xqtjBhBAyErz7UxbkD1dwjqSZn25ISwDKP0W1EmTwO5FNIwIqAVoa/3CxQ==
X-Received: by 2002:a50:cd5b:0:b0:5b4:4bf7:59ef with SMTP id
 4fb4d7f45d1cf-5b44bf75b5amr1991229a12.6.1722357319318; 
 Tue, 30 Jul 2024 09:35:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac64eb3c1esm7435044a12.78.2024.07.30.09.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:35:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: aharivel@redhat.com
Subject: [PATCH 0/2] qemu-vmsr-helper: fix socket loop breakage
Date: Tue, 30 Jul 2024 18:35:14 +0200
Message-ID: <20240730163516.83566-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Coverity reported a breakage that snuck in between v5 and v6 of
the series, when the socket loop of qemu-vmsr-helper was changed to
allow sending multiple requests on the same socket.  Unfortunately, the
condition of the while loop is botched and the loop will never be entered.
Clean it up, and also improve the error reporting to be more like
qemu-pr-helper's.

Paolo

Paolo Bonzini (2):
  qemu-vmsr-helper: fix socket loop breakage
  qemu-vmsr-helper: implement --verbose/-v

 tools/i386/qemu-vmsr-helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.45.2


