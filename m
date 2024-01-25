Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0317C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSx5d-0007ZX-PL; Thu, 25 Jan 2024 05:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSx5b-0007WA-9H
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 05:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSx5Z-0008WC-TT
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 05:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706178964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aI8CbuiyC4bOr9Lu4ccL2jCFMGVKbL3JuSYKgPFfm2osSFOMjZdWWeCbP2/0O8s0yXgkLo
 /6frAlOlm7+1hDORygFm1s5+HDOtr0sFyHSPn+yw1BQgxzMjhXkPU7zJUFJcEysIhwFFpn
 E8TxMD/dz9YmyyEumu9UMWGdVrE5jxE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-OriBRpeEPM6A4gqGsVofgg-1; Thu, 25 Jan 2024 05:36:02 -0500
X-MC-Unique: OriBRpeEPM6A4gqGsVofgg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a27eddc1c27so311280066b.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 02:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706178961; x=1706783761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GYHSbKZAUW3eVMf52uMoLjXJIjbTr1hJgDeou7hENHFLEuN6wfR6VWYUXmsMHPN4hP
 GHLZUiY1VuMwrGPF/DNku+C3DgkGlhgnWr9X3w0hQMHQqb7qvXaCp40T05XnAPBFxwTb
 VF0qdCloXfjGHmUn32H/wKU5Erz5ylfZogvrBg2j0TBezfUtCc5B1HxzhdMW8BgiwxPM
 Mv/wqSz5KqHTbsy2z1AcGmN9bs0QqZSiB0+q0PeQ7u7P5qaXdTUGMUsJltv4kafrxc+w
 bgK2eYewF9jfGroqdqVuEj684lKAFjHhuUOMfj7smTgsf8V6Q8yq6/0r17Kh2UewY7OA
 tm/Q==
X-Gm-Message-State: AOJu0YzLo+LCyHBTNE+y7YjyyUoNcDOEkd6PCHUtI0Ra3MxeLJIGdiWP
 Bh5IlsV2wOVyQhx9QYG7qrPIl+8MEAd9yFopPff5hCDiSCQ7EmCPHXD6plhT18AwSQfSey/5KL3
 vqskbK6TCjTbsC2faRC8vP5n7lZuuZFcR39TkHH0sFkxEatHxgnke
X-Received: by 2002:a17:906:b7d1:b0:a29:906e:b8f4 with SMTP id
 fy17-20020a170906b7d100b00a29906eb8f4mr261233ejb.46.1706178961239; 
 Thu, 25 Jan 2024 02:36:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI3F7rDewc72YTUwjEU3W4vp+87Av/lrWcxCfZvnFA9Myuo1hStdQH4XZAU4hqe42ph1+Mxw==
X-Received: by 2002:a17:906:b7d1:b0:a29:906e:b8f4 with SMTP id
 fy17-20020a170906b7d100b00a29906eb8f4mr261229ejb.46.1706178960846; 
 Thu, 25 Jan 2024 02:36:00 -0800 (PST)
Received: from [192.168.1.174] ([151.48.72.171])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a17090653cd00b00a28badcf367sm880604ejo.54.2024.01.25.02.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 02:36:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] physmem: replace function name with __func__ in
 ram_block_discard_range()
Date: Thu, 25 Jan 2024 11:35:41 +0100
Message-ID: <20240125103541.789156-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125023328.2520888-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


