Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD4ACAC592
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 04:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxHwM-00030i-3z; Sat, 13 Sep 2025 00:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHwK-00030Q-2F
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHwC-0002z6-QJ
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757737952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Kadw1UGFepwdd5vESwftDEwJEZf4/sJ0tJaf5iPYyyld3Rco1wCaG2j15MGHWY6OYxcl9J
 KK2Uu49PUPrK+Vp3iIuNc+MtcWaMoU4G4yl4u+vHhMWMN8HUC9vbmsBCGEnNbNYAnE6Mq+
 4/e9H++iZ9dMqvjl2bifoC4Q1h1Sic8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-vbfubfrAODaJm3FkRkdiFA-1; Sat, 13 Sep 2025 00:32:30 -0400
X-MC-Unique: vbfubfrAODaJm3FkRkdiFA-1
X-Mimecast-MFC-AGG-ID: vbfubfrAODaJm3FkRkdiFA_1757737949
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso19054675e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 21:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757737949; x=1758342749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=PpLUbJ3zV+IPf+DR+NR0khqMuswR2mNrQ/GiPbblSLO8r9ngkc5CFZmhlS3jfncW/W
 jYm/5cSrt65QKH/LpHAw+TviMk/qsw52XJbxQN2RkeFgKh7HTOm5zaZe7nLIExIJmChX
 JXQWYd3sRaYCsepm/klq+qKwFLx1DrTVMS0xE877mKGI0KzMYe6idKsUWFjgZn1q3uxs
 6lCzGd5f/jh1a9zIbsZU9DSjMcb1coAKn6hb5EDfHQCZ+2DPu3Gyxvt2MJ5G+GuBvFI2
 l6LstXDEivbBS0Ukx9RGG/fP3LZxx776mVXgtvmaiFbJMxvJyZnEPRV7TXaIkyX8z1CP
 tPfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK1PCDJUGvgqyMqDcLrc5Ugwx72Zhmiof6MptA65EF48jLlSq5aE7mDWMUUBFYWVSv5KYa4nhNoKbF@nongnu.org
X-Gm-Message-State: AOJu0YwWeoEsC53uLPfwczz5r6WDMma4Wg+4ZN49cpUyQNw1PjRPY+t8
 oygrTNTAtTLovVsntzO5vmGdRRkFocGiM/PC4pEGFAoCnFQgZWbXsJFxHasjj1oL9ZPUh5yshJI
 GpnF0R43SZ3S483cDZjE8Fj3zOvwBFoovH5aSnTSiBL/H+BY+MXLYgv9g
X-Gm-Gg: ASbGncuT8KBSg6wrVaaxPyFyGpTPD+sQmN5DpFqNEPYvvtdYwz1x4pfKwPXXO5u/qjj
 sx3ezGnnVCEWR1G4DK6fgBzxPVOtvWAtIlnBnMqjzuWDu8iGN05tVFM73chwS2Pe1orPRjn574G
 qQg/diTWPieH1Eit4YVZemLmLiEFSBkTpeiHSiLDcg2uhvSOTGNRckqc1wXfICWuGvOoFT3z9h9
 +l6d3DXH58RvP8oq/uqHaPpEn8zDAB6x3tOzesYkJ2cl3qTsnumyM5lPP4+e3zW2BUQZoyJPgH+
 aeFXjxHQYEuxlBko0lNTWHGCHlFLP7zYNIXNYn0SHTIoBQFgK0zmPXRUriZ2/K0sJP6iE9XKPE3
 qM1n6/499ivVYROShn8ywTMgg0dJcG79XxyImHmc9jeE=
X-Received: by 2002:a05:600c:1c0b:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-45f212f9888mr45299535e9.18.1757737949304; 
 Fri, 12 Sep 2025 21:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBf3p6VDhdfGxTpCfks3gZZPB5LXum69hBit7fs1x0mK2XZc8HGQntmlBTZYJERgm0xf4oQw==
X-Received: by 2002:a05:600c:1c0b:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-45f212f9888mr45299365e9.18.1757737948914; 
 Fri, 12 Sep 2025 21:32:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760777851sm8938617f8f.4.2025.09.12.21.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 21:32:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] i386/kvm: Enable SMM address space for i386 cpu
Date: Sat, 13 Sep 2025 06:32:26 +0200
Message-ID: <20250913043226.2549151-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250730095253.1833411-1-xiaoyao.li@intel.com>
References: 
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


