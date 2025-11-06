Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C8CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH22U-0000uF-66; Thu, 06 Nov 2025 10:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vH22P-0000la-Sx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:38 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vH22O-0004at-FI
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:37 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3304dd2f119so940370a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762443395; x=1763048195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGOZc/fcqXpTWSt4XHsoE8Nyfs0gaudxJSOVopQZf0Y=;
 b=YyCaGLBOJBrS37D01/xIdmCaWBeWDhf7NXQek6Hszrk9tGYQxD0Dc/s9sB+0L/mX9H
 jrBx+s5wub2huN4vecgfQgf2H8n0LQcdnsjA5wZiNeSuN/goixAeStSwhP3ENX/w+qWS
 Na5R2s6JA3A1JsdfqFAhIWAnQQOr9k1zBPFRRI7XgY8KGgzuWDdSIznFLUQErelEIxLY
 S+teMki06Nr4VNO+VjF2TNm+e9X4xSvvVGXkA9s5Zb3JvrUJmWdi5vSfcZQmyEcDVXmt
 lBHW976kLwdLaEu17hYnq5Slv+XPz7CYg9IsJTpKEkpFnWi1m37mj9t2DSOq12RAI6Xy
 cMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443395; x=1763048195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGOZc/fcqXpTWSt4XHsoE8Nyfs0gaudxJSOVopQZf0Y=;
 b=YesbDEgzlc2dYaHIEchvaKiXcj/mfugtg1/vUWanF+SwEnB6URsqYtOFlhuHeYZo+J
 RlsJe8ZRNFv52w5ddmG1Z41ltEz5Sl/QEBnR8h6/2+hOGIvUaOgWHHszf65jx+GvpD9J
 p+J2jB/briHesqx2gq6IcOq3p1qKb/yhlcWZihYI/Y8K+ikC5KpiqavxvFO3RKlu7Gjc
 GY3kc1Df594I5qsLHqiHu277fy/PvcEBxusEx9m98tRm57FZV50RxxNnWuG4Jf0bVQms
 6fXAX1I9VzlQ5/Yn9Ahzugku1fz4AeEbt8tTPsVWcEd8+EtrD5wqNyTtR8leeYeizyEg
 icxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7xjiux404l9x2TaVxNohB1lUW8VzUDestE/3e5Pojkg4zsd+ys/t1E1lcBcUG62WieyY3EpnsrLd7@nongnu.org
X-Gm-Message-State: AOJu0Yw67wuPGmx69qX0d76ESYm/ZcBnMcgEYc2Agpae3iiOl/VMqReu
 dUosN9nQyH25vpQv84D0ZjJY2EponpZcREk83OPoo4nUfZgga4Q8lZFd
X-Gm-Gg: ASbGnctawfU1TPe7vMjnC/lvNLZ+vqkDRzTKaVGNyIC2+t9Rszfaw55U0B/HJGQdJr/
 0obBRw0MhtRaiyg1ckx1jUEnJL/fx3rFS9weTeXTcDGnAGCIIhQW+Kgt2xPrwt/KQR2XevxTXGl
 hvDf/RGb63Q4RhsXMAqspDAd0P1n/DLQQCdsMY3nHnhqogz+A+rvNENdVZ09s0IVPECYdsMFquS
 OyFCTugU/EQUGDecx3zaeGBu2Sr1ycsIKQQOrNODFdTJL7W6zlyvvha1GenPZLebuPX/DRWgLk8
 k7te8aEOR4bUkrDYS47zeU20AcOG5xzrx7ZaMc7YEV3MI76yFh50+Lm0Wq4ZB1GrAAW9brpzf0x
 5ZHLD2teVKkkbP0umc+Z1plDsquWllKE7cLl7svlMtoIp4Mw3zqhVPceZc7XwTDrLU/miyH9If4
 l8CqFQH+uMwbhju4GS7ryntNvthpWHpPS1/xKsW6s=
X-Google-Smtp-Source: AGHT+IEWSqIuNmmqb/XkLYrY299c44JVi5aY0vub1MQQtPVxV2EDd8pDnyOPv1HJlyR5eJlGczaWIw==
X-Received: by 2002:a17:90b:5250:b0:33b:ba40:c3f with SMTP id
 98e67ed59e1d1-341a6c091cfmr8472542a91.5.1762443394853; 
 Thu, 06 Nov 2025 07:36:34 -0800 (PST)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a6993b43sm6643437a91.15.2025.11.06.07.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:36:34 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, deller@gmx.de,
 qemu-devel@nongnu.org, linux@roeck-us.net
Cc: Jason Wang <jasowang@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v4 2/2] i82596: Adding proper break-statement functionality in
 RX functions
Date: Thu,  6 Nov 2025 21:06:24 +0530
Message-ID: <20251106153624.29424-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251106153624.29424-1-soumyajyotisarkar23@gmail.com>
References: <20251106153624.29424-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pj1-x1044.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The initial issue was the break statement exited out of the for loop
unconditionally.
Now, the break only happens if rfd is null, out_of_resources or
bytes_copied < payload_size.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/net/i82596.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index f0b22093f9..541ad7dad3 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -1092,6 +1092,7 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                     rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                     i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                     packet_completed = true;
+                    break;
                 } else {
                     hwaddr remaining_rbd = I596_NULL;
                     size_t rbd_bytes = i82596_rx_copy_to_rbds(
@@ -1118,17 +1119,18 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                         i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                         rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                         packet_completed = true;
+                        break;
                     }
 
                     if (bytes_copied < payload_size) {
                         trace_i82596_rx_incomplete(bytes_copied, payload_size);
                         rx_status |= RFD_STATUS_TRUNC;
                         packet_completed = true;
+                        break;
                     }
                 }
             }
         }
-        break;
 
     } while (bytes_copied < payload_size);
 
-- 
2.49.0


