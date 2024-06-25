Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA82C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6YW-0006x2-Cf; Tue, 25 Jun 2024 09:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YT-0006vB-ST
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sM6YQ-0007II-Mb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:49:52 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d07f07a27so6285350a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719323388; x=1719928188;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d1fYQ7uSy0JYSBDhMCphzksyQ7P/f641WoT9TQMYJeE=;
 b=jE+UaBgI4a625dI54X67TEcN1f8yfWkJmrTHvw4l28FyXab4Oq08BRC8sRoIsF28R+
 /5RK9XREpY9rN9JsarJB0HhuHAa8mR/6zQndNEl00vSAdYIABkGOkepHa+AiijZDSnhM
 b+oUQL/rzmls0ZBLikNdIod57Twa6gE26ExGIesVQf0Exw8tf61W9GJvFwZmJQEd9VY7
 m5n2LfaDaJfQS5CaN3zYDJ5OIy1oJ8ijGxxzoSHV7D7ZaE3m9KTeZNbIccFJ4m7Ezbdl
 JPPMf6sZcVECczK8mC04WrN7FHZG+PG9kaprXB1rfRFgY1s6MovdCpcwBLglM0s/Si2Q
 KepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719323388; x=1719928188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1fYQ7uSy0JYSBDhMCphzksyQ7P/f641WoT9TQMYJeE=;
 b=OtZNvFT/0Evu8PruPdK4JMPdDXHYyUi5wMPAhxcxjlruFuNUjo1AUyMenJF6QYZFlY
 g30LK5JKupywEBfLVzArVCR010P8q6CqaJ95DwjQ8FyUJ2CrcWWrKDOome29DtWc3Eu2
 9w43dUs3t4GARiaZKWE8cg+Er0Qx11+SoR1c6E8cu7gxZObRY9aufdKKKfMZnG0cGOlx
 If8vkd3RwQRZXJWOB014oxfbUag3FAbd2DVZgqOCY37lbOSREhvB0JlDSkfMXmKggd/2
 ydQqRHYmFCuji2eGU6/nKdOSOIM0KvoENn+DUJ439El0/jBkio6MJgL2z4caAB39hup7
 Q5dQ==
X-Gm-Message-State: AOJu0YyxINWC0aXg37x2sepLHSn9kDxhWdVbZQMf3DRjY+24556IbFen
 ESzgoR/E8sgNG4/5dMDQhr+JJcqzWZzXysYixkGSA9iMYBZW9cdAOU1lGeX1r+BRu0HQz3R7rZI
 q5Q==
X-Google-Smtp-Source: AGHT+IENc6qXlA18ThHHXpxt/cA1tjoEgnfXbNtZqjAkF9vjVyRSdmQVFDXXxCkyh2uKMBglywNdyA==
X-Received: by 2002:a17:906:199a:b0:a72:450f:6045 with SMTP id
 a640c23a62f3a-a7245b6252cmr388985366b.21.1719323387966; 
 Tue, 25 Jun 2024 06:49:47 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a726e13a4d7sm77299166b.19.2024.06.25.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 06:49:47 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com,
 akihiko.odaki@daynix.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 0/2] ui/cocoa: Adds native absolute pointer support
Date: Tue, 25 Jun 2024 15:49:29 +0200
Message-Id: <20240625134931.92279-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::534;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x534.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

This change implements passing guest cursors through to the native
Cocoa host NSCursor on macOS when using absolute pointing device
input.

The first pass at this was based purely on NSCursor, which drew
some criticism due to the somewhat complex nature of the code which
was required to generate correct relative pointer input events
after teleporting the host cursor.

This new version builds on Akihiko Odaki's work implementing CALayer
based cursors. We retain CALayer for compositing cursors when the
input is relative and the pointer thus completely captured by the
guest. When using absolute positioning of the pointer, we use the
fully host-integrated NSCursor, with no offsetting or teleporting
needed.

The first patch consists of a few reference counting fixes to the
existing CALayer patch, the second implements the NSCursor logic
and switches between CALayer and NSCursor depending on whether
relative or absolute input is used.

Based-on: <20240318-cursor-v1-2-0bbe6c382217@daynix.com>


Phil Dennis-Jordan (2):
  ui/cocoa: Minor fixes to CALayer based cursors
  ui/cocoa: Adds NSCursor absolute pointer support

 ui/cocoa.m | 93 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 18 deletions(-)

-- 
2.39.3 (Apple Git-146)


