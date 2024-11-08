Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB95D5E147
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KJ7-0000Aq-Gh; Fri, 08 Nov 2024 03:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9KJ4-0000Ah-4Y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9KJ1-0006cZ-DI
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731054321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CVUCM2xbUnaVfwneuFZj0i2oTN1m/l/C8sTJi5Jalt8QqhO1wD6YA61PrZSgh4BkPXuKmN
 OO8vMjYvXaMnB1NT6PdZ+7LkgrQ7TKrRoHX02vO+ZZ2KvHLs2ZzAOAiN61zAbbKtN+Zti6
 tvuLlnihF0b50W0OIBN+oU94NqFyB7U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-AYs2W2hgPIS6jEFjytNUZg-1; Fri, 08 Nov 2024 03:25:18 -0500
X-MC-Unique: AYs2W2hgPIS6jEFjytNUZg-1
X-Mimecast-MFC-AGG-ID: AYs2W2hgPIS6jEFjytNUZg
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53a246ecb7bso1011941e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 00:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731054317; x=1731659117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JDZufmLn7R+eveIv5K5AZ7xk1jMzsHaJOaEAPqOAsOnN2nRNeSHAMNmOepQgiQZ+Of
 YcliI189cyAWCBZVXbLz2iVKP6e51SXlWzHE0F6dmMtDK0tRJAbj+Ngn+l+QMB3U8UCK
 A0oql4OlXOby70Ioj5tUqr9TKQ3TVfvy8ZjtYrgSZbOg8pScawlJPmuTvRKD+F8TGMUF
 ht+KxA8E83/vm6XvUd+kewFwBN5gOKrkS4VKkpyDeZTATvQ2TxMt+R7pWgYnOfrMfogy
 JsZyb2vqdUeyKNznPGSWgul0wNpXJrIqVAuCjJo2izN0PwC28SlDaKRH0bbFdS+wuf41
 su2Q==
X-Gm-Message-State: AOJu0YxXRGJLwrHc3BJEbrRdED+pDUDZoAIdZkFPJpuA1D/OHHyAEXC1
 PJGRc//+vh8JnS2T1py/BWkBMg7fCNNsK17KsQCvE/3UwV4OEFSrjpOjeUFnc9Bo1PVSNrWE9XR
 8rxXGcCoaYKDyfFiczuaTnJ4BVlNnouSVIrbUipFRral5t22zB0An
X-Received: by 2002:a05:6512:304e:b0:539:e2cc:d380 with SMTP id
 2adb3069b0e04-53d8623e163mr915326e87.27.1731054317229; 
 Fri, 08 Nov 2024 00:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkEIkkqdKrl+MKpIO76uIpzPayk4EwYtHyujME8ZgzhQNsEzI123hRVphqSvbooFf2GCkMcg==
X-Received: by 2002:a05:6512:304e:b0:539:e2cc:d380 with SMTP id
 2adb3069b0e04-53d8623e163mr915307e87.27.1731054316712; 
 Fri, 08 Nov 2024 00:25:16 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053047dsm54154885e9.3.2024.11.08.00.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 00:25:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] hw/i386/pc: Don't try to init PCI NICs if there is no PCI
 bus
Date: Fri,  8 Nov 2024 09:25:14 +0100
Message-ID: <20241108082514.71664-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105171813.3031969-1-peter.maydell@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Queued, thanks.

Paolo


