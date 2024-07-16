Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757A4C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdpP-0006Ho-TT; Tue, 16 Jul 2024 04:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdpO-0006Go-0M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdpJ-0005zg-Nj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=G1No4SXglr8rklUjhGpkQVxI3pwXwctu/4vh1vRwI2XyQnFknctplXAQqG/2IWnckQMzaJ
 i58jJiDfd5Xyx2Mog/a1OVsGlAYt9hZN6rlA+sMvsN+0yaHmga++OxJ/Z16LDf1NyLSNjf
 LeTaYeu58NKQzTeXc3nZp+Y5ClLiGWo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-fwS1QOlANS2L8LGirdRMxw-1; Tue, 16 Jul 2024 04:46:20 -0400
X-MC-Unique: fwS1QOlANS2L8LGirdRMxw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee9b1b2cdcso48040271fa.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119579; x=1721724379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GF1hVvM9KXDEC9EcuMZq9MoFUa+VKBLhs6V4nhrtvb8ZEiOPYh5s+Wy41m8WdLzWXP
 lQOgGQL4kE5jG7/rI0ho4MxZjScDSxn1kZbh5dvRpT3oWbNfks9a32/px+VMxg5xjRNY
 mhREW7kz1wAWPkyxjRtWVAAnmO5+Wd+rZhGkri6d9p59IAqnMpUWCc9g+GdRS4LRNvMY
 cK6oMVkuTNqJXiTYA3tXxZQhajix17fug0QPvZ7zCK1mr70Ki3y1aUfQhDuvqN0cuhUI
 FDO/ZuKp0lOyuS+j/CbSnO2/WwZHMKT8PKI+Iuj2WtbRmnKHfkBEJ1zG7i3/Z6/oMA4T
 dURA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViv0UDu8yvt8RjRNXuI2fC/VZf0rx1VrQgwGKBEwQDvQdjqWQzZnSKGe1nBDtXzGboFAZ58++jbB4enk2Klgp0/6SC2rg=
X-Gm-Message-State: AOJu0YxxwiK6qvbZ49Z47W+IHxC33gQsMlUFkFlBFRW8uifpeB2YW8gs
 6U+JMJSIJ0f92zna5GEF7CMewA5lyTL6H6xBi1zaPZYP0vvyzTYWG4PWIQESRymNH/+J40eN2Py
 HfIhLDBWykWE8SMMbIlq+tIfg/cQgKtJcJT8k/abjYxXSm163kDid
X-Received: by 2002:a2e:9b99:0:b0:2ec:5172:dbb8 with SMTP id
 38308e7fff4ca-2eef415bae9mr9549271fa.7.1721119578809; 
 Tue, 16 Jul 2024 01:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkeNjQLZBXR7ABVkNGc9q8lzt4OQkuk8CZrjrYEpBNFu4Bg/w/RgFy+QYFwpsBCYTXPPdxVQ==
X-Received: by 2002:a2e:9b99:0:b0:2ec:5172:dbb8 with SMTP id
 38308e7fff4ca-2eef415bae9mr9549121fa.7.1721119578426; 
 Tue, 16 Jul 2024 01:46:18 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb525sm114051685e9.34.2024.07.16.01.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:46:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] cpu: Free queued CPU work
Date: Tue, 16 Jul 2024 10:46:16 +0200
Message-ID: <20240716084616.185216-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714-cpu-v1-1-19c2f8de2055@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


