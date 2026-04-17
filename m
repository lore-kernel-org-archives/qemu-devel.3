Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF8DF8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbTG-0006rH-EB; Fri, 17 Apr 2026 01:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbTB-0006qA-Io
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbT8-0002Ne-Ua
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so225417f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776402616; x=1777007416; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bdrXfCfuCy+d2q1OMNLzrT9RPclLZK8MOD3nTYpEpXs=;
 b=ESwr2oWdOPB39jStTaNHBmyLVele+Td27HfEvsjULPvflQ9tfKwvjploSqYHoQN4qH
 2qdPmOazt7689NohdyM6Bubo4fcF19gg30ycLfanIcMe64lPEVsnvInhn16R8Z9VY0w3
 W9CCqe94fVGE+F0v6BHp841vSvVaO1F38GO9vyUTkLqHZunU09Hla73kxWJ3YOdRNqCI
 EnXcQKI6jVSv8ffK+hensh07TDgvYRQOmQ9EYyCxATU4RMP+1e2Cr9fQYFVrTTRfeDup
 o33YyFoqZAvpUIiNWNqoxB1ohiavZQzmjefZtlPnYRAwF4f8khJ/F3jgDOAyZCYPfm6C
 7NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776402616; x=1777007416;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdrXfCfuCy+d2q1OMNLzrT9RPclLZK8MOD3nTYpEpXs=;
 b=SB2a96sBT2dPk70rDBay3pxh2AY3y+7q3YpFw/dtmqT6aFfS9VkymhyxxdmQoxtb5s
 GBQKymb/eVnf0hlNRpngtM3fV0AEHYnBs79zRMG4szg1G2UyWG+O1HA6MtFY1Vto4W4T
 +ZCFQ8rX1Br2pknaKVgQEfoOUS7OgFqXUOM+a8qe9bHkSSepGU+bw0+Aqt8tyjZYU/Kv
 m+QtnzDAztaZLeOE4hN/6DGcuQhVrZ9zj4VbgZhQDM2awHD6ae6hsZZgNkAAhmgzTcUG
 tK2oFZ/VrZht0wBQmwKEPEtCWmFOLS4DRB/OYOy4/qBRXhikNYRDB7aJNGUt8RFmyjTt
 ta7w==
X-Gm-Message-State: AOJu0YxuX5QXYi8hmtyR3Sp5wU2Pef+eeNlUj0aZzJLe0s6ZdsrQLCtq
 FIPZeo4HTjgVEauwEyKTQH/z9FQ0qvrMdOX0vhBuQ2WZMnOuNxURq7MbI1JM4FvNnXIlCCv+V4p
 2/Ub7up8=
X-Gm-Gg: AeBDieuGR1BW9GOOw4OKjh5kGZQpEPuJ6uiAtTzwMRYnIMYlNKfsVEy4RxOMxFeF/Hq
 xjplCkuign2bhBFMK6JbgOVSfnfwCxjw7ynbvwYbkdwkDQdluxmn+xQwm+ROXegpBo/YB6Zig/j
 FOHkyNV3jcisLYb1E+s83u8MLisXK7O1c63oubF88Ivkfh5lTOQp6eEhgdSr239f6h34KWsR1ub
 pvTIRAs2Tci2AdigwSaN/o8zdm1wbW9i1bCnBJR6yKp7ocCP+ycxVQrop7dSY0K1hP86jIUKI1p
 q/FWJpiXnTHrbSWDBOxdu3jWPWkeX2C9Rkt8IZmSQYy+h/lJhzQ+0tySVjbDprydrPUiDfuaaz/
 LFI6Uzs+joVbkRHhUutNtIbPQML1Q+1kzIVyejdHRKY7DP38AIRF7NnV5TSZGK+jC5byzg8mWQY
 0Spi25x8GowfGs++iLnCyXeZH3XisRkaFAJvGyx1lYgxgTj4miJR9Mvt3iRTIXK6y15GwhrvPg3
 oJqoWZysdvsHmOkB1x9buFnH1gm6AKwTPaW7FFTqQa+Mf3Zl+w=
X-Received: by 2002:a05:6000:1447:b0:43d:7b90:fa2a with SMTP id
 ffacd0b85a97d-43fe3db9c3bmr1757551f8f.3.1776402615798; 
 Thu, 16 Apr 2026 22:10:15 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm1749524f8f.20.2026.04.16.22.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 22:10:15 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 0/2] More virtio-snd fortifications/coverity fixes
Date: Fri, 17 Apr 2026 08:10:08 +0300
Message-Id: <20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALDA4WkC/13MTQrCMBCG4auUWRtJpj+Kq95DuojJ2A5IUyY1K
 CV3NxbcuHxn+J4NIglThEu1gVDiyGEugYcK3GTnkRT70oAaO92YViWWlYO68+u5RFXfXG2NNc7
 jCcpmESqf3bsOpSeOa5D3zifzvf6k7k9KRmlFzjSEnvS5xf7Bs5VwDDLCkHP+AF28W9qrAAAA
X-Change-ID: 20260415-virtio-fixups-3bc3a1a1cd27
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=674;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=6DJIPpuVXFOeSoxae/DKW/v0aDPSBXAYP/EA3AJfz8U=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0Y0MyQ1VqOWdZUHFyVks2Nmh4ZERLMk9Jai9ZCjNpZGJ6QTkzellXMG5tWTBk
 NDZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVIQXRnQUt
 DUkIzS2Nkd2YzNEowQ1RIRUFDY3VyNTVyNjRzOUc1T1RCMFBnTGxMallmVFhWbXNpbTBXWW1oLw
 pHd2ErTDBrYlFKdEtNWUdhVjhJak43d1BTZGJoaUtFUEpUeTREQWJuNlFMYmk5cWRBSlQzc1ZrV
 URadUtuWk9ZCmJiNWcxNDUza251UjZoMmlPMEZOVWhjSTV6c0l0ajR2dGZWSXhtbkJoeGZ3TXB6
 YlkrYTc2UzY4Wmw0MUdLRzMKRjhoNCtGaUdBWUJ2cElZbU5rZ2dCWFE3bWhEQ0JzWEVUYUJQT2d
 tcjhkREkyVGtmUmRMK1p0a0ZVRjBhNkNIawpYWDhVVTQ0Zi9QcmhkSVBCcnZFRzY3bDBnNmIrWW
 5NN3o1Q1JIem9nTy9rRFpRb2MxRXN6VGFPVVZUM2ZTWkUvCndOQTdBZE5KMnFGTHlKRGJKRForN
 S9iOHFqVEUxQ295TlgxRGZjTHR3MERMNVhMNDFnMU5aUWtQcGcvTFRiSGwKcTUxbUJ3RGZVd2th
 aE9wQkorU3h3Q21vUGVUb3NXaWlxa2h3RDlEb0VPSzFvekJXcnM1ckkxbmpYa2xTalB5Ygp6UHY
 5WUJMY09relpuS0hXK2RRU3I2OEgwL3NUWWpOTWlFQlNLN3U2UXhWU3pjME9jeXZpdStCbDZJay
 9HcC95ClBrSXB1V21GS3h4UzBFaG5uaUNhNkRoYkYvZlRKb0sxQmtuUVlTd21EbWxXRTg0MEVOT
 DdySGtoOUgwaDJrYlkKdlgxQmcxRWlibWhqUGhvaEN0RE43OTV4cE11K29Tc0xNcWxDeHBuZlpr
 RkRQbHdJTWRxS3ZGdWV5WGlBeUU3aQpMOWs2bnpHN1NPWGtrUkRjOUt4OU1jUHZQUmVYcXIvdTR
 mVUFyN3dUcTh4QXhPNnV6cnA2bGdwaUJTdTdsSjgrCjYvNDZPdz09Cj16dDM4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Added checks for stuff coverity pointed out.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Use g_size_checked_add (thanks rth)
- Link to v1: https://lore.kernel.org/qemu-devel/20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org

---
Manos Pitsidianakis (2):
      virtio-snd: check rx buffer descriptor size
      virtio-snd: check for overflow before g_malloc0

 hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260415-virtio-fixups-3bc3a1a1cd27

--
γαῖα πυρί μιχθήτω


