Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0554F3ED70
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEgqx-0004sA-Ow; Mon, 20 Apr 2026 01:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqu-0004qW-9q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqr-0002al-EU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b150559bso19468725e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776661630; x=1777266430; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GR4Lk1zgM0nXzz+9kqUk+Mn9YNgYC/ffkrV5rZ22LWU=;
 b=VhQ4oz6mh82hjbCo1VYVIQDn2EdHSp4Q/1T+mjtL3rm3YGTNsnPLxhe7XuQHIiZboj
 bqFlE6PW8+pEGMYLnGM7VEFEWz0jDufME73Tf6cr4Bxv5Pp9Gqvg/qVO9z5Cj1svs6Kk
 stDmnyeFWVfgNHdXnl0MWNHBjjBXwTa1/CsDAkxiDqo14T14NoV7GmZh3JK+N1VzbbiG
 j3b7NktGVepjtbBbncJm80gCjyyMeMeaHiy5sSLLEduqCbDN8E2XsshDvo0AY1hrTXiy
 4m2PZlhdYMA7nd7673r1jPEM+mZ52dvTF2YUIPIsnURFvgYeVZHwSv5qcGB5RxkfLKxi
 X19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776661630; x=1777266430;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GR4Lk1zgM0nXzz+9kqUk+Mn9YNgYC/ffkrV5rZ22LWU=;
 b=e6ABtz7awG4UpT/ctYe+ADjnow9/8w5MKU/7XGqKhCNGcdB3uHxZEmAwfpwWcC+xZr
 EQfQ0D/zNyA94CQ7qkwYHhSeWXSuHqCOq/HR+go0pQgeJ8dgLaGz87KPqvwkApm9EW5d
 VUX7HXLMCyCJsARSHEkCH86sP/CvVdJjuoF/1YPoftmPQP3eCjc/j9ykZORsAqD3dKFF
 eEpnJJ2x1HGSUZZS6mO+OMqtu/KLl1WXHCqKvN63RpaQs0L35/NPg8vmwgbrOrpbXh5S
 y0w4ppRl65TIF11+6P7yDBIf4Knydn8VolKxWu7z9DqtlIuuJhhlVCV5qIiyIMAHw8sh
 Bq1A==
X-Gm-Message-State: AOJu0YzTLcV1/vK9e7MW18SJJi+e5b0n0ODSWacUmcpOE9Uwhxs86WiM
 WcODaOz4nrAveoHtJ2AJAN5MfFy90GMF+usaU0wOdCJ8zNswk0alfjqxbWb/aZcyFkoKWXKGX1f
 IplMpP+w=
X-Gm-Gg: AeBDieuuP1TWpaPQi+ZLI7LRabLTtEAcnllW/lxeU1/gppxhHq4Dp0aYvnTxD8Ojovp
 Byy0ZkzhUnfZsN6EPHranxSyCyAiVMV+0EXdBXS6AinQEDzy4SW6RwUaJswleaGn5ZiRbZvoJsE
 W/SwNDh8v57E5KSack85FUFYuNtD6GAzh+PgTeNrVSTe8+b38fheRycbH+VBayw+olmEqVlHCr2
 682irDdSm9AojBmJMuCWEoeEYf7OrnE2UdLAXV/RXQxLdnsO8ABir8ZJxLJDaOYP53YPffD+M+j
 ankzd/T98KrIPLQeXvx7maOys3YTyX0Ozt1wf3ZNen5JhFxkY/w2bHDOkVRIHs5/Epvs0hdkETv
 59zmcxq6SZsK9NWt3UUfuWmu59Ast2k9nfjbgiKSFVU0CTdBBPu12hRZYZXqASTRxYewBJx+iy4
 zGeXhH4BTHW1Aoc5OCgd5XBA2VIUf/E4iTsZvySW7ZS3vIgje1B7rMhkgud/glANg8fpSkZPSm+
 n+XGQAN92yAzVIYcIDCexPOEl/pxXmJ1FoPQsIUu+D+I6SJ4lY=
X-Received: by 2002:a05:600c:888b:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-488fb74bccbmr139301245e9.12.1776661629966; 
 Sun, 19 Apr 2026 22:07:09 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm28886954f8f.24.2026.04.19.22.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:07:09 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v3 0/2] More virtio-snd fortifications/coverity fixes
Date: Mon, 20 Apr 2026 08:07:04 +0300
Message-Id: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHi05WkC/12MwQrCMBAFf6XkbCTZpGnx5H+Ih5is7YI0JalBK
 f1304KgPc57zMwsYSRM7FTNLGKmRGEooA4Vc70dOuTkCzMQYISWNc8UJwr8Tq/nmLi6OWWllc5
 Dw4ozRizP1rtcC/eUphDfWz7Ldf2WzK6UJRccndQIHkVbw/lBg43hGGLH1lSGX73Z61B0bYVvj
 TLWQPunL8vyAc2JpCvqAAAA
X-Change-ID: 20260415-virtio-fixups-3bc3a1a1cd27
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=G9o7n535xER1FQmI3uvCYQFosFW66ejXKs0xw3gcpB4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA1YlI4cEpsZVN3RG5YSjdQcEoyRXFoOWkzbnlYCmZqOUpPVGV6ODhXNlpzdDFp
 bitKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVXMGZBQUt
 DUkIzS2Nkd2YzNEowQnFBRC80bWpuZi85TDUwUG8zZmtFU3N1RUpuZkRKNEs1K1NYbjNkZ2MvRQ
 piT0p1L3BKQVZwSEVlRmZya3lSR1JTTTJKK01tYXVES0gyUHpzUThhZTF2a1FZbVo0SDJaaDBpT
 FV2NGNpenAzCjBDZXZ3QStEMGZUSElzdVpnV25aZUVLcDd2S1NWR1NHaWJqYkltOGUyY0g3OFZJ
 US9lQVBvSTNCSnBNNjlyY1UKTjN4cHFKYU1SWkduemllTEFPM0NDdHVtUFZ6TG55ZW95d29scXF
 yd0EvNHZOdklmM3VqSG1aSzZDZlJTTE5ZOAo3Yk5WMHhwTTY3R0lFY1IvaW1lOHJhYTJwdnFHVm
 NlZWJQbzhRUldXNWdHNVpuVTdZRnllbUgybjJEb2hsQ2NWCkJIQ3BPNWxSUFE2S1J6N1dyZGVIe
 HZWV1pMdlZCaHYxQ01xU0xQVjkzb3Z6SzZ0WVZ6TEZUZzl3Sjc2Q3pwbXMKaVJrZllEOG50V2Za
 cHRBSHpVZXJYSXYyQTVWRFpXR24wclJGbGtsVDErdm95NC9jZEdhZllJUTNQNi9XOGp5SQo4UTF
 PS1F1dkUycTFHWGJjSjlBUWpreUloY3h2clRlaUFOOXY3b3pBYy9STzFHU2ZIRlpTVmpzKzJVZV
 BqOWtnCjJZZWx2ejNkc2NoYWJ5eTlBZVRJTkNjS3JxYWtuRFFHT0t6bmhJcFRud1p3UFJtTXZvd
 S9uRUNzK3VpRURzeUMKa2N6ZVBwM2JyL2cwK3c5Y3NnYVQ5bWlsVVFKajZxb2hvZ2RyMEN1eEJZ
 Z3dUTkNJdXVCSjN0d2VqdU0zbFZmRwpiajRtSlpGTVV4dEx3RDh2V3l3T3VDcTNKcWJWRzRkVDY
 5djRkYkZhcmUwYkdZMUFIS0xseWpSSWtzL2ZWbW1UClpWUG9ZUT09Cj1sbDlUCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

Added checks for stuff coverity pointed out (CID 1547527).

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v3:
- Added Coverity CID in patch message (thanks Alex)
- Link to v2: https://lore.kernel.org/qemu-devel/20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org

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


