Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65829CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopdO-0003EP-D8; Wed, 20 Aug 2025 16:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdK-0003CV-77
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:10 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uopdI-0000Bz-MM
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:42:09 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb7aea37cso40115866b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755722525; x=1756327325; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0OxLqEEJqYAqri093pp4yMwxSVTDwskPahJePkHdh4Q=;
 b=esyM4q43a15A6C9AMgVYhmiWLHjqqhFmgmNHqTpPnBor0k16wrKzDUUeQGPSLxi8/N
 xvt84Glbnb7sal4nRDAooUmWqs2b7dCPW/o3OpzQI/v2u6A7c3APBSilljZ/I/a5slFM
 a3O8UYk8MrqawDVL8LBmDESxFJBatK7wgNYdYHR3DFJF08Oi/IiUWs5G7h+pPm5XWLZs
 pEp5yYW21YpTG969KWfwy4EH/idcMqneYvjXnG768msmz6glh4TqIy8reSJa2C1b0VG8
 Si4nMv8mYwa4eMAN1j9QQ+DDFkwSFekmTfk8A9tyFwi0KMjnodnxuIz8Rim76CHwOk8i
 Vk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755722525; x=1756327325;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OxLqEEJqYAqri093pp4yMwxSVTDwskPahJePkHdh4Q=;
 b=gWAjf+27lhyn87HezxqPRXhOdn4ibWTDZ4WWo5SP+WK1OKhs63X8Kf4gA+b3ajfWgz
 Y+V4bAsLGWsw5vGabKFMD/w8O0eL9lu5KAifBb8EyhCH+GWVu+f0SdLgqRBZ/l3JxUbO
 XdzF9ONoP3d9QaliWUkqUf123I8YJrIBE2zZVcHG/5c0Ys4krHqQclQ9nHGQL06IyKpP
 FjU5Q9tW6ycp9I8HV6OOEIkmkhmaWyV8SCpgAbA/tDEkWyBM4jNBcb53s4JZ9CuNhDY6
 mdtwCyxUFIIpWgqqjtXnQJ3pbvAVS37PQEDxv0Qulbz0zJGHhoKyFNeLGrNvyvhpvm+b
 RphQ==
X-Gm-Message-State: AOJu0Yx3EpZ9Ur3OAtvQvW3SlmTf/cEHXjtySxc3O+UxrKNx2QsoBPbQ
 YtGDtKvCZ8e2uBU/7LUDjj+u/l6c9lNmvbgSO6xnNdTWTB6Lt2TvqwAMJ6nlFN62KJYh0K6vb5v
 NhJvyVko=
X-Gm-Gg: ASbGncuSWcb76Jg85YtWOt4psqkC8r23nL8VGeHiBLMJjZ6/CUSXk0J2USO78hDY7XH
 QzVOAUIWZ6FrRW6yrDcKh2+UxxXf2hICYVtIBhgDNAS/ns2YWUcv2woQNxR91+5Klyzn8Vme8Wg
 1YyjC326obTY45hSITvvC2364jdGyRbkyE1h6K11IB/tWq1pJYCQlIvp3IVd8WkxWGLFXvRJ6nw
 +wyi0d2M1MH6Ivz36lKNQRLtG1OkVUs2MXZnmRAQemR6Pf8G/WpJ0kOqymwNIpqGpWdZJQHR0KB
 GmHJcfqFM3LhV3FvilET04dMh86nCcJO0FuFfbMDQH5Xm3yIZxOJsFO/QteM7i1IdtYB6Xq8hx2
 nrtxbJQ+Z+GjBlLVjWoBI6cFhea9NOhE/fpfsTlymzXmLtRMYzl2btynp/D6me959BIzswtXBSD
 oFaTY=
X-Google-Smtp-Source: AGHT+IGLPHvES/xrLt2Wz1HHF2m0q065bIj64zByM9mMhbjWrSTD4pJ/DRheMjS3/kqSkWkcnRvhqw==
X-Received: by 2002:a17:907:72d4:b0:af9:406d:f0a8 with SMTP id
 a640c23a62f3a-afe07a1f90emr17495266b.23.1755722524774; 
 Wed, 20 Aug 2025 13:42:04 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441256.home.otenet.gr. [79.129.180.152])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded5353cdsm246888166b.106.2025.08.20.13.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 13:42:04 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/2] Two minor minikconf.py fixes
Date: Wed, 20 Aug 2025 23:41:55 +0300
Message-Id: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABMzpmgC/x3L0QpAQBBA0V/RPJta0xJ+RR60ZplkaUdSm3+3e
 TzdbgLlKKzQFwki36JyhIyqLMCtU1gYZc4GMlSblgyqi3JeirsE2dwRPHp5WJEbmshY6nxtId9
 n5D/keRjf9wOVh4SKaQAAAA==
X-Change-ID: 20250820-scripts-minikconf-fixes-e62a20429f54
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=629;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=Ib/3u1w1IUYsgmigAHwnxjaHBX7yBqQ9/naW04suRvQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9wak1iNzRDWTYwc2VDZmZxaW9WV0MrQWVuM0o5CjJUZ3F1clZpdUg4YXF6Rll5
 SktKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUtZekd3QUt
 DUkIzS2Nkd2YzNEowQnpIRC8wVU9QZUpITWJrczZNZlpJQVhwNHVXMS80ZVBrOXRWUllsKy9QVA
 pMYkRsYlVDaDR2MWdScEFIREZmVHVMRVlpemJWQ3JQRzJQRHd5SldjakwrTEtCL1dyWXBad0R5T
 y9XWVh5MG1FCjBqcnRHaG5FcHUrNU15ZXpweUEwdEc5TzV1Z3hmOTBmUUY4WWRGRGVMRmIycFhz
 elEraHRna2YxczBDZ0ZCS28KQzRzV2x2WHQwcTNob05ySmV6UVA3cDBxTlh5SGhreE1sMXFFM1N
 GUVpkcVpIakc1bFd5NFd4RDF4UTQ2Kzk4WQpQUStFQllxM1VUdEw0Wnp2b3I3ZlIwUGtrT1BmRE
 5kMjBydWRlK3FLOElnUXRzSWk3M1VYUGl6QjhYYXZidVc2Cmwxc1BzV1dGYTJqU0tXYVMvcGlJb
 m5UWXZ5Q2VaYmMyU1hORFZ6T2lEbVJzeWpCbmM1VExIOTE5VGZmS3F5dFUKYzMxRG9uVlIzQWVO
 bS9CcHZ6blFvZ0ludVFQckZCalF2eWROcjFrdlZKcXlZOW9kdmRJdGdkZFM3eUZEQlIrWQp2Vy9
 nbXF5QVI0VlFMRXhxR2lFZm9pWC8rKzA4WXFoazZnZWZjS1BaUGZidmI1dUpiK3k3bXhCNUdhb0
 dyWHZtCndrZnZ0bGE4YWlOSEc5elJEWG41ZGZlK1RxUytRVFZCR2JMbHRieDhMbVVqVFRYVDUzY
 W1LdHpRUFJHYkVOS2EKblBYRGt6Y2tmcTVUTG1HSlVVUVV6ellQSStSN2ZDOUVsd2k0dks5Qklq
 dUcrcXl4Vyt6emVxRVhtUkE5NFV1egpRVFYvbE9yWnN5YU9xUmZIYW5Xbk5nZHE1VmFDV0hnajZ
 zVnJJeGN0ZTZNYWlNNnBVako2RW0rbnlwK0t2R1RYCjJLRWlndz09Cj1Id2ZnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes for two minor errors found randomly while running `ty check scripts/*.py`.

Since both seem to be 6 years old, they must be very hard to trigger in
practice.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (2):
      scripts/minikconf.py: fix invalid attribute access
      scripts/minikconf.py: s/Error/KconfigParserError

 scripts/minikconf.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 88f72048d2f5835a1b9eaba690c7861393aef283
change-id: 20250820-scripts-minikconf-fixes-e62a20429f54

--
γαῖα πυρί μιχθήτω


