Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB30F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutaw-0000LL-Mc; Tue, 24 Feb 2026 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutal-0000IA-2M
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:53 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutaj-0001HE-HG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:50 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so3804605a34.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944048; x=1772548848;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=aoDU9ozHlpNffOc2J4XIzL+C3O4B0a27Y5gZ80vPAxR2UDrhagJ/oMcvTvxXZjMX+c
 kfzBAgajArrk01v5SPrtnOd2BGPCN7UMjracwW9bemInTmAcnu5E1Hl+aHuJxZKxoIYm
 6zNxUa8qPjttu4AApiwTP9omhTaWM1ISihCq8V+NZQ2UoLm/8hzRL8zoE0iiOxNcNCe8
 3DqzhMng0EgDafs1BnwqbGjmmG8NtX/Ju6x+o+W+t2JQNu0Cue+8ai/qD0gJGjQMp43R
 i3gWh0NVYgcuypLvGWzVX9YQt1YwiWYGv7HeeH/9DmvElNJp5RNfNThrulvi+cMfOSBH
 9gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944048; x=1772548848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=MqLBVFbwhaWrMkC5keeyr28zmZoDoNN9LGLRoeU0xE8/d+nliY4ykOSoSeQiEjkR51
 8Tobvy+sbHMz8BXP9IlorGLDqKw5Ca4EN1qf9lHCAMIamcBnSzdRceQGXsari91auRE8
 wmutLFBk5VJOmLK9JH+PwxFyWpewZbXMyon8liTewJtZwNDLPGfc/lTTEtquEEwhwq6E
 L1KEzk2k0o33bbTg3k0F6ejcCv6J9l+A3wut7Ay8P/csJ0cLdq9ez1RtNcCaUFnAXmJk
 mYv/+GqZ9KrqLna6hNclqW4XCBe0UDws6NU7emiNF9NHbX0Rzb8ybqWyVA6uf58QCMUL
 1ONw==
X-Gm-Message-State: AOJu0YwJW0bp2zP390W2MjJDzoqIByipnr7x0560utWCngaMzwHv6h3f
 6sXKqYUB5WkmHPvfFs8s1UZVwu4oCHfDQy/V4zSelVgXogh0q6oZm9pyQuttXDzMwmzbpa9/QoV
 4xY/5cdY=
X-Gm-Gg: AZuq6aKCwoR6PHNxmfUT6Xb/rs3uey5nr+CTCD2UnThSP4zwOeT5GxV4vKFqCqcAgR/
 MfnLwV8riCv8s0SXuH/IYptNgkn/jB/rTNCSIBiiiB6y7W8/EfAuYl3EutG0zQZLSVC8zK6VinJ
 8cUsckP5t6GSKd1oypC9HfvBsxtZkFooHj3joVDmewtMAIRq7Nv/56TGoxyU3iOiAq+pXY522W+
 dBzMBf+f4DfvzdJlozJTnE/Nz9BsyI9GegplyG6HUl0jg7OPVgqVzWLaME4NTMIbpIGknQ09TAg
 6zYpmcgw5omow/4CpoTmZM/HFD9tMhtwYfiKi60loReJaLJztpCK5Bu8uJX6f6qrOjEaqcMuiHb
 WX4sVLY8fr79lFWDQWnXIdyWt8yFpPeclBLsuBXYRTXpq/LCAX+twpbKKqUKwwNhcuqgjq/QFDa
 B9PwBl1DUGiw==
X-Received: by 2002:a05:6830:374a:b0:7d4:7053:9840 with SMTP id
 46e09a7af769-7d52bf20673mr7645044a34.17.1771944048236; 
 Tue, 24 Feb 2026 06:40:48 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:47 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:29 -0700
Subject: [PATCH v4 05/24] bsd-user: Add function declarations for
 bsd-misc.c conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-5-8ee5ae17056f@bsdimp.com>
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=jMv8o/VOm7CxV+F9rGpvq+qe7MCeDgV1rt2GbfBrNoI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhmrgjXTVbhPPmRAYfLeoBNCQzx7TD1AA38S
 GjxG2F5Q6+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZgAKCRBsHNEofbAR
 AFWZEAC51sAstIx7N6DLCiKO9UzRYfEnOBV2xnrNIPB8iQCziQBZG0dxNiAGBL78pZjE64mzfCi
 qPYoNrsQbSpIOlLnm2X7nclUT6QqEEDP2zVsNbFVLoHULVOEAfW+T80IM0UQPJtRalXHySaEwdt
 zAtPf1PEv9VEszKIiX15Gpj++TtN3VG+nioL7B6lzo6a5NiOzucV4es+DG6PJcRmU4iMDUyW0BY
 3aS89wXV/Bqf5TaSpX7qhbhAsXj+BQRwjU1UpBKfi8E7ZIfMmstqtLaKFXKVMFSKfFCHCLa8+VW
 EfARDqBsp0t4MRLpxCuOgxwV9kPoASXB6ENPjDRlcfzLEbqedUDaPgzuB9IhfqAfMZyHVB2a2J/
 yPee5nktRZmbKvqUDxO+OJISYepzRL2+Fxdtgdis3w4aZI8lZrd5h8uEfqecVubvtjYNxm0WJ70
 R9F61vagk/Axk+M5y6MO7A5Ip/wxxQ5dexXtbMziahB+ijZpQCwAi68QPcP3s/7l5re3gofrm/5
 VVYew6r5QUj/UX2kAsiCcQuU0A1KHQfKmVSGqXvRGvfBJ4aMLhO5iwtmk5HATxf5KAZg6AJzA6W
 M5mhRn+qS5Ox/IULCTiR/ut3b0yw3z7EKX7jqA00maS1F0LC3XcTJ9GTt5DW0TO1cs1h3TDCDjG
 468805hUpTtY3Pw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add function declarations for BSD System V IPC and UUID conversion
routines that will be implemented in bsd-misc.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 56affcd31d..b98d1d76b2 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
 abi_long host_to_target_shmid_ds(abi_ulong target_addr,
         struct shmid_ds *host_sd);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 #endif /* QEMU_BSD_H */

-- 
2.52.0


