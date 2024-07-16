Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19960C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdpc-0006bH-8J; Tue, 16 Jul 2024 04:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdpb-0006Yv-6h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdpZ-00060s-ER
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AeTMI32VSC6JOok3NiBv7eMKFUNvFesJX7EFDIHnDpS8a1mh7oW9PkpSvPRSrVfYcb348W
 etP7VSoHoqkUUMWkZnDBWXz8E6UDG1p1YJNrf/5hq7WqQDWP9Rw5hco7V53Zza/nFGbOyk
 H5CltQXSmIVQktevWTqXAXdSS0VR+RI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-lTiJyPAGMvaVEz1scRE0yw-1; Tue, 16 Jul 2024 04:46:36 -0400
X-MC-Unique: lTiJyPAGMvaVEz1scRE0yw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso49407685e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119595; x=1721724395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=FdJ+1TyuC7v8gKrvaYHs1gAXgisMY/1Y+FbuFaY1DkuUknRsGYIhnYiIu8agu+QTNt
 /G9zT/ax2N1pkc7oP6swlNIBYqxMqAhpRxYg0yNGDV3rcYg5/0OL/mO00rP6px5rLDpL
 u7JkUNjFa8vvYIrzvd9SlHz8EFGYnM+RxA9XbZRk4wEkDl4NDPr2Sw5TGmgUd2LXYWs7
 v4KxeeMyi+lWevLZ4yc58AO7tNEqI1wAsr7kI+QlzjbndQrwNmR6bwtNyPPzWci/kNLF
 m21Mmwq1m1a3tdncgCgKXUdT1TkXBQ9x55k2SGj4ttOs+h3tJCE6XAubj9p7OxZsisHf
 C1uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMGk7HkDd+fwNsBkVGZkd1GVu6a8abd2iXxMOcU6JV8lMVubAEq54qdSwLEYcJd/K1q85DIdL9T7ScHBwh119a9A+Jr00=
X-Gm-Message-State: AOJu0YyCmoPsk8J543cEFzckBHZc4sfxc6U6vwhqGDH/kASr0jImRRTZ
 voeuz1DuESMwF0CAcGaaEZsIh8qQpK5KarvwHTVILXz4UOcC1yUXbskWNHw51FEBTcJKO2W57XX
 zV5fmpIawPSHLyARwfaUEYivFlNXnsS2cd/++l+WdQZN3KYIbEP2I
X-Received: by 2002:a05:600c:4708:b0:426:673a:2904 with SMTP id
 5b1f17b1804b1-427ba71ecdamr11886245e9.36.1721119595304; 
 Tue, 16 Jul 2024 01:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdOg4jYU1lldF5nkt4GpX0XEWkPdI7uESHXRZba8qZhANWJ86EHoCyLhoiR/T4Updy2ih8vA==
X-Received: by 2002:a05:600c:4708:b0:426:673a:2904 with SMTP id
 5b1f17b1804b1-427ba71ecdamr11886085e9.36.1721119594998; 
 Tue, 16 Jul 2024 01:46:34 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabef8csm8269555f8f.25.2024.07.16.01.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:46:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Use -fno-sanitize=function when available
Date: Tue, 16 Jul 2024 10:46:33 +0200
Message-ID: <20240716084633.185305-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714-function-v1-1-cc2acb4171ba@daynix.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


