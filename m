Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B2EF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASI-00010g-5h; Sun, 08 Feb 2026 14:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQq-0000cC-35
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:01 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQR-0008Ug-RU
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:33 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-669f0b0290fso2107062eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578790; x=1771183590;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=Tj8b6AGdUmSAiABadFNSTJfqIByq/uRtZCtOudMIkku8zv5tPWMwACEPA/3/Efdqyu
 pqaeF4UzMCL/NrQz/y1qpgvpVCjzrAosEimKZqixsHEZqX3cBBiQZ+zdPhOZ6aUezrna
 tDWvH969SPr9KErFesYDmGAzV+1L2/wCeQvoGHIG8W5nYEpzJBEUizo9IEp7GAoJabed
 T6nxmwijDyEu1QcseKYkZuOvK+enI3Tmm2miDm4ms5RdfnwN+bPMeM0mGSc04nJyGxTG
 FugmHLW/fJVNQ0q9XFyLg3rZUQdbdRGHoaCzewkFBaU/Qpddvb1t74U3bOrvULLlp3FO
 RgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578790; x=1771183590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=EBBYcVy6LXDqhYuhfG/FjlrX8yxZllyuHdKHVlSORpgYRdCDUUDTDTb4pxJH6MmkLb
 c2gboa+e7Z0MAHQVVwY8xR12vjgPR6tH/X3Evd5GaHooBU9q2k/hzQUcsn7DTidU8K64
 oNvGwjqeFgZru6JhqHxNqW4Gw18cMs9kTp0SXJvziCxJJ640Kzwn2y0l6p08ZMzT+z4o
 zMy+B4K1+LQjBlI2Hk+NrsAL/jVqYi2rq2tSy2aep+ar/ek8U4OZjjLElwYrlg/cAuom
 Ej9XWtxWOPe5mNTtnf7ueTslMF0zs3N6V3lqHsuiO97OoPgZJnj9YnH8eLMFvXDuOr/z
 snDA==
X-Gm-Message-State: AOJu0Yyj8PZZY0tSFkTMrqqQBsxCH7NirxrQjau+jBr4eblDJVpS+6x1
 zlX1ern00S8Germ5DnYR0Y9l3umX+k8ZzqSTeSjwnjPynQRWPoT2shmlWtazoxJp92Y=
X-Gm-Gg: AZuq6aKrIyDW0K57amZN/8LeteJbkVWObEhHEebbqpSrS1mQmSSzA6JBQM+61P04FA4
 QmyGBdQyZd2l/HMryubOCOnrfDDjgaUwmMwGMHdFahXXC9WW/JSe88DSw3aIDp2iie+a2QVqE3/
 k6hzknwq/yzeap6TOWav7USNYS4Vjrn/+FC6t2T1DH8vsvUNjSQsFDvYOPXHRgTlIJxLjkjJyau
 znEsByfvVaxsHjaVB9Uf74sYLH14/aMYhv+lQwieCpeYxpUmB12Kcbuuu5YY9hy/oSPrViLnYPB
 +jh+0WUYajEHEy3QrI9aDwT2YY31cZPs5gr1aULKsTrxBq8K43C5U+p4qygOwCrLPymP3ukF1+u
 PFtmcTGJZEuiRdlUxmQIevobDhLQTP6k+8jbyWSJ5TMssojqU59mh/GzaygMgnljAuNCAPBfE7g
 ==
X-Received: by 2002:a05:6820:2292:b0:664:85db:66bf with SMTP id
 006d021491bc7-66d0c94e3fdmr4404322eaf.66.1770578789994; 
 Sun, 08 Feb 2026 11:26:29 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:29 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:14 -0700
Subject: [PATCH v2 05/24] bsd-user: Add function declarations for
 bsd-misc.c conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-5-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
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
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgTXJ4C7FQGVNGP+v6OZQFaEor0Y/WwSNtW
 LgN/A3PwNqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 ABtIEAC+xxxMXTEOKQ84XRDtEUWNJ3CnDZjZKubzz6JJS3S4YSDLgXZJQzKVFNNd3ZHkJY8dEI4
 IAy4krmb4jVlcD/eFcXd66gDxAqR95Qy4YgoyagcNEJ3E3a3X3fMB5uog5dQtucOjLydI7Niy29
 pwlojwHFZkqNFHVeMR0sSnRrzW3Xi3igyqq15y+/pwJ3rwWa8BPanxkf/NUpRQbsuW94muy8uCS
 qgj+0TaVdMjIf5ZXcJh6VJOZqw62ZIyawBe1sLargxm/4HtBLM1saArhuYMpiEdDkJFRHtEeFSH
 rSu2UXsiEcP/c0SaDa4jb1bb6NlemK1vryWjFT1oB6RVcv9KfoO7g7vg0oZi6s4k0q7WJkivL9m
 XxoZGWDu6P9nxdCH8TH05lVOo6/UG4kSI/l46MeH091F1ikLfG0crP5NEqp8Ve/hzyTYK4sQW+P
 LzJaQzfv5BqwcMLsMW1lG4VvMUpcoVfoJwslqUpIw8+9hf+zh/qS4QWyM1oF5FRnlUvQNXz772Z
 IcnC4B0fyY6bGjdwlJAhGPK5RCq698+J116ty4H9syFWPX0ibU/ycsC2UBQZ82XlJqGfAejSpn6
 PcgmKMiqHnYg+kNE9uO+6pXseVUsbv8T4rrFBxhV/H+YyqWASa6vurYQaJeT11awaZpfG2H88q8
 EryEFwYB0hF+lyw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
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


