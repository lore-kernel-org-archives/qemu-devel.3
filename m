Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDAFCFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 07:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxLwd-000818-UB; Sun, 06 Oct 2024 03:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxLwa-00080Y-Sc
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 03:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxLwZ-0001Zv-66
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 03:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728200681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZpaJWaVL+njfEiCQfzWx5IQKp7zTYVlofI2ZCbuWAIXcTk1bJvZDErTQU65DQtQ09MLX6D
 6AK2pMA16h5wF3arqPIog272aH+/G2TBAe6B1JoLXx9fTTaszrR2Q7pBJZvatmSwNWdAT3
 zNZ75bkv+2Zg9jC9MDqoMoBz8SobxBk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-GQxwkw78Mjas1Qd1YN2GnQ-1; Sun, 06 Oct 2024 03:44:39 -0400
X-MC-Unique: GQxwkw78Mjas1Qd1YN2GnQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso21631855e9.3
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 00:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728200678; x=1728805478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NQxGXcqP0fJmOXOS0DNEzhdbgAJHPcOujYghpoHieNPL9MmxXPPXYJRu45KuqUqNqN
 h5ZFNYSxjuwBaIKuS+L8YV+p4TU0z1aitpt9oaPK0mbT+juLTo/Do9MKVYV4XHHJ6vtv
 KiVt61NQNVCYPgDrPdqtsqHjuGJ/AVdXV/5AIMCUe5y90BZy2l60PH/ZqFrJPse1KPJE
 6r2eVSPe5XQYPxy2X89NeTSBg+qHAiaiFWmGrsqVmQEq9gfQv99UsfANJY8EBFSB6oyb
 jREo+qnjzns5yhBigxUn2OHhY+Zaw+R9JC2MpzVceHw+OWAUnJysmXe7UNb/HS+ist+i
 2p4g==
X-Gm-Message-State: AOJu0Yy0qIjyuQ3G+RSrP7+xw4+c6/DZsdFjxLHp2txqXj5T7yC3T1cQ
 +VkS06C7EUf3ZHiXHo39QXU7CEDbJsaeahadjtSR1U4eLEGKV+xy8lsvmQCisbmQcuTBIk4+4WR
 CA8asfqXlmw+O1kLG3hRYZFxNLkPx4lxre7ocr+NbP3Qe+L11JoQR
X-Received: by 2002:adf:f58c:0:b0:378:89d8:8242 with SMTP id
 ffacd0b85a97d-37d0e768b46mr4655296f8f.26.1728200678662; 
 Sun, 06 Oct 2024 00:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1d5YCRcyEEjWntH+ys1L7cAzy57oQpxd6cP4KtmIkX+EU5rO6QbBLYg2k3ooitlOSvVUvnw==
X-Received: by 2002:adf:f58c:0:b0:378:89d8:8242 with SMTP id
 ffacd0b85a97d-37d0e768b46mr4655280f8f.26.1728200678231; 
 Sun, 06 Oct 2024 00:44:38 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1698e885sm3164298f8f.114.2024.10.06.00.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Oct 2024 00:44:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: fix machine option for x86_version
Date: Sun,  6 Oct 2024 09:44:32 +0200
Message-ID: <20241006074432.1166749-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


