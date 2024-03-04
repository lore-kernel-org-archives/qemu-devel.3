Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2CAC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3DB-0006Yd-VM; Mon, 04 Mar 2024 02:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rh3DA-0006Y7-EN
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rh3D7-0005jO-Rx
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709539089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DWHlf6W2FbdVRMl0KlJYw7gmkWZaheC6bE2ORczGg1apAVomvyyrTD6+jjk75gMskeUQYX
 f7ezxvUKwbHd2F0xbA+/EQXRFuFBWNBkERR1Ev+F+magLrlx+BdZAISKrCYjqHLs1cDVe9
 ds1Yo+W7XcF1wGmdjPimLuyd3UccvvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-SNuwBnzCNhaJitZXfeHJ4g-1; Mon, 04 Mar 2024 02:58:07 -0500
X-MC-Unique: SNuwBnzCNhaJitZXfeHJ4g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33d4c09ec04so1979660f8f.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709539086; x=1710143886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Jb67wulUNfDfiphagEtiOtL8IVltjvaArivZL7fuesbP2jWMh6J9ASQuHD5haLf9RL
 kk4xp2dZy688AwcGSM1juhEpRrnn5bR4d4hxvL+I8gRqtxpBKOio7U52c1bLPaGHjcLW
 2C3YIFDXANydts55+Wfzk5L3UJCIA3louppC5YQQ55bDnlBy0lr2tLhOfC3uTb7HWS+O
 lsQU9xoLcSiDhEdjcDmB09u00RI4IKvtHzh2d584gm1WTSspg0PPZ8DpzWzXRfrAvzqc
 gFLKAHsuoO+u2RRrqqqKTYDfND7sV/JEpwIEZLQm/wUc5ZNcsYEO8nWm/uB4o7tMWRMz
 QJwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfvvz2mE8XpWvUEygZaV4STho1zhaS4V+7WPLfj0Wrna//lV7MZ5Hk77uQUEz7vNA8LHhSXXK4D6l03rCuuDb0bKQjiLU=
X-Gm-Message-State: AOJu0Yy/YXRSmhrYBCiC+rQ4j6fEzTpIED/XH2RUZyClSEMhTLIsOtdB
 ZAoVFcUa+K1XXjubFzyax0Un27bezXz4BqD2SGyp415dgBrtuseDVDgIuiK4tygUl48M3kQlOtw
 dqryMlGR7torYc9GwO1SI99+YDdpp2Fal1Qk6Kl8yhlkvx21iO2oy
X-Received: by 2002:adf:fd51:0:b0:33e:237a:98fd with SMTP id
 h17-20020adffd51000000b0033e237a98fdmr5458228wrs.68.1709539086519; 
 Sun, 03 Mar 2024 23:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq9YjQl0stBxQJeOYs86FQbcqoMOUwWhW+1r/2Fi5MV2NxsAekAs0zmUO6L/qgDFdoEItpdg==
X-Received: by 2002:adf:fd51:0:b0:33e:237a:98fd with SMTP id
 h17-20020adffd51000000b0033e237a98fdmr5458216wrs.68.1709539086206; 
 Sun, 03 Mar 2024 23:58:06 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 fm5-20020a05600c0c0500b00412e6513639sm898085wmb.23.2024.03.03.23.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:58:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Remove --warn-common ldflag
Date: Mon,  4 Mar 2024 08:58:03 +0100
Message-ID: <20240304075803.157498-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-common-v1-1-1a2005d1f350@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Queued, thanks.

Paolo


