Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D1BE9A04D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswV8-0002mc-JD; Thu, 19 Feb 2026 00:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV4-0002lF-RU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:54 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswV3-0001oV-BY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:54 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40423dbe98bso229658fac.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478572; x=1772083372;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q5yEpB3N0ZOm8g2gFovCCvNwar1x4Vm84sgikfcwrfU=;
 b=G/+gqDchmlnmKKofp3hjqNiKe/SsoDGsJX3c3inuoLWG3IcDKkpk+vXqhBUcGaM2tR
 dTwhx6SVWrhti7XNI+AzXHWzM5mcay7I4/I7abvSYUZgqAflbVFd4YSmZ9B+yJjwJg0h
 GB4pPWIsuRn8E1qIFWiDLyEOI1rs8Xb5JeTPRgJ5OAWrl/bl6iW0ZBCtORy3t/o1+6Rx
 EHcF4tQScaE4z6zxtzjlEeetqxrfyRwefJ3TtZeqpRkQkI1i3ikIz7uCIY0FHDTBt1AE
 sq7rPuZ76Sc20VjZ/BAsUtbAUrTEadh/eQbkCXONVfLuyX5qqoRTc+iMdf+8kXaNtjLT
 B6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478572; x=1772083372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q5yEpB3N0ZOm8g2gFovCCvNwar1x4Vm84sgikfcwrfU=;
 b=smcJmn6le+FuJeyc0TJA3f8SSmt8/De3Ib3GTIwDHM79vxfF2oqJ9LZNdTsgvPJM8g
 wh7WhYKrPfJp/et1DqXZwGqay8VmtzUjT351ld/PNdMu9nv3uEm8eGq9yzQNSFXHsqKb
 F2vfa8CtJSaXcsK3Q8YO5wGBM9h/5X08Hs9QaCiInKDsYrAzYtkptjlQ93V4WCLlBZhB
 fw2TDlGQROTjo3dvwtDrfAeSakr7pFpuwKRmfCr9lci1u8smplZs+dQIcYYyrNQDw7Xn
 ZlfZ/CD8Wux6Zs5iL+jX4fpovUqT6/GSIo+rjOr01HGkCAFHzE7UbQHVdS+XbjgqduXk
 fXwA==
X-Gm-Message-State: AOJu0YxLWn7cE53eNiBvfeppdVSSiGsKCtTCQZPRdt/trLIGxqK/Kn8t
 d+1DSy0OhA49tOBqOCjhosaqaTqhYYhm6p013w4Fb0BAZoP4n2C9ERtUmeUXFU9x6MI=
X-Gm-Gg: AZuq6aK2DJVSHlGo9ilnwmI4hY7UZVuUS8A/NvYREArBuuvIm2mZtB58TrsRWN5NRKE
 jtizzobR6iBhcCtdvI9zQZkZyYIYEswIMn1oGDTeRlYQOuavhjAkK+TdUxWxVQGVM5W0hDo45Oj
 Qqa1dAHVHKMZ8FGtVKNj0VtICBpOk+e0e7NPyuXh1u6IxBFJHTk/tI8U/z9phnb7fmkKM1HKW3N
 MeGK8ViWTHcshmupYaTPd4lrQUUtI8NQd9HoubGhnzCJHZTOW1oLmA035PAr5aDjWJy592yhRph
 NA3DGONjTONldSasjpDiz8nRGR4B0OEvuFVyDKbGtAbiy8NnxDO5BprtXzz1CR1123tj/EF11Bk
 qbHet8mZ6ws+sGY9xv8MbWpgVIQKZ8w6clFQ4Z+ECKw0LVL1kx+6qqSKJg1kTWEFQaN8cYhz3Nc
 sPAA7SPEcbBg==
X-Received: by 2002:a05:6820:8c7:b0:65f:72fe:413f with SMTP id
 006d021491bc7-6785bb672e6mr9889224eaf.67.1771478572122; 
 Wed, 18 Feb 2026 21:22:52 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:51 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:35 -0700
Subject: [PATCH v3 12/24] bsd-user: Add host_to_target_msqid_ds for msgctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-12-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, Brooks Davis <brooks@one-eyed-alien.net>, 
 Sean Bruno <sbruno@FreeBSD.org>, Mikael Urankar <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gpFtwDCGHbSz2mhNk7LCOdK198vPiqLD6qg22mYpWf4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4sxtRBxb/Mpz9OTqQwBMKwixTgHblG4N+n6
 DFsUmDDmXmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 ANDeD/0dmET4N7cB0PTShzmhJAJV7lBbV7w0jdqUiCXjXJawJ69rwYdb5anaGYM4WEVoBm4laXl
 Saa8yLkgoQ5TrTNwlDNgm/kX3OXBfy1ubJiKo9ibYJphmRtoL1J37xKU8Ih27jCJCrjsorhvU6U
 djLrAAvzsbxwLl+yNjPcAhrd3r7zlRdBsIA6DTLcw+U6GwuhvMIDjLAIVhvxHGztxe7ye37Dt2X
 BjLEeIgPigKHUjQi7A2doW8HeyZOi9NJe/qwQmBFSkUYK5XlRVBmNCDL49Lq7vnxX9NndSO6S7+
 tX7hSn7ZY/N+HmWo8rN+2NGRJvJZFNiu9RXTGPUuDCnoPoPu7VjsKF1i6M95RGfLcc4VjfcyeiJ
 xPeN/A+arzQK+7l+OL+CEYatU3j96UPl7Nq10OF36+MIhm8EW9AWx3T+ZERe1+VhP/dWQm6t94G
 OEL2gxgrMdjPEGb0jsrgLf6DQ5cejI1c1bFkrieMH5/4Cu/RhrlVZZDX97cUpk7OTJvqlh7+y4D
 g3r5v2iLZqyBNUdW7Yws+HEtAjYsfqwvchgNlDodIMJEbjKauDjx3E+7urWpzT2V9FxAkBAjt9q
 c6gfKul8iS521p//6+JhzJTqs9P3LRBpkuyZzjW5iB4U6YSrCtz8MVbpTDfrWMxIg0+hMnTv0UT
 /Spkdn8X5Aky6NQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_msqid_ds() to convert host struct msqid_ds to target
format for msgctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Brooks Davis <brooks@one-eyed-alien.net>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikael Urankar <mikael.urankar@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 5e5a590227..3e1968718f 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -163,3 +163,30 @@ abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
 
     return 0;
 }
+
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md)
+{
+    struct target_msqid_ds *target_md;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_md, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    memset(target_md, 0, sizeof(struct target_msqid_ds));
+    host_to_target_ipc_perm__locked(&target_md->msg_perm,
+                                    &host_md->msg_perm);
+
+    /* msg_first and msg_last are not used by IPC_SET/IPC_STAT in kernel. */
+    __put_user(target_md->msg_cbytes, &host_md->msg_cbytes);
+    __put_user(target_md->msg_qnum, &host_md->msg_qnum);
+    __put_user(target_md->msg_qbytes, &host_md->msg_qbytes);
+    __put_user(target_md->msg_lspid, &host_md->msg_lspid);
+    __put_user(target_md->msg_lrpid, &host_md->msg_lrpid);
+    __put_user(target_md->msg_stime, &host_md->msg_stime);
+    __put_user(target_md->msg_rtime, &host_md->msg_rtime);
+    __put_user(target_md->msg_ctime, &host_md->msg_ctime);
+    unlock_user_struct(target_md, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


