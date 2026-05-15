Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2289CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzwz-00017V-Pd; Fri, 15 May 2026 17:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwx-00016c-T9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwv-0002cs-Od
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:03 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso336635a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880000; x=1779484800;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CenKEzTcPoLDRcBcEsTcXvijDJrJ/9k/bqUajU10YlI=;
 b=FOofpqmMUBBL30RSrKRVoNH6SNNl5V5E8VI4mDIZBq1pb5wnO6y7L3PP1CxKMAsE+o
 RPgVjrN4ES7Kq0eAnuCelCZFHieFoVAlC7wXh/Av4HNz/PX4Z5HZ4kYou1xYjOBm45AX
 BfzXHxb9geF1mnJdo+vk1DD7V9qXhd7+hFcsT9hLhIFbmuxU0xQT62NcbXzbjhuu5XXH
 gI98meMd3T1WF8ttLv2Jy7QLPh+mrYbNcqa7zWkkK6KLlY+di8dkH1eYoZqNLe8rbkX7
 znu17SWaP3or23RMBTVvRCtKfSX6yXE9CybQ3AhXzOE651tHqWlnMP9NAkqH9CnFwHlu
 YwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880000; x=1779484800;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CenKEzTcPoLDRcBcEsTcXvijDJrJ/9k/bqUajU10YlI=;
 b=mXCpslyLM49/nnMAoViQc8WYGzSEYg1Bx2efNnhDVW13PTvHXaMqWEV2sSmM4h78We
 IOhPRgxzGBPDP6ZVk0U4F+fNM8Q/uDiFhCBcqkOly49XgkpLsKr18GHo/ViX1mDIV8bA
 dLSMgtQfJmZlfAJoJRktLWsCOoaj9sR591D1aDpLUFNidFE+NhfnLknh5TnNe3sdY0Ei
 gI9XoMueOnLpRPqxvoJkXVjvJ7o3rWA06s0SqEcYAsJAHvutWJzEyZ1LIqKV7tlyPoOm
 Y+zuX+2QxtAmOysGlNv9JLwGr/3JVogstNMDaabK9zIk2nGHtCNsbPK5roFmtceBaOXC
 oxEw==
X-Gm-Message-State: AOJu0YyzJleM43LIVF5iSfugRYlqeeLjlnpUStN6N0RvNJ0HaC4XoArh
 2ayVhV2SGwLr00RzCHt8SvaO0/Dobs7XHeJO28nOPVmNafq37EXpBYXTicvg35BauGOUaSgMomv
 RCiamlT4=
X-Gm-Gg: Acq92OFRtXwv5H3GU1vpBBqb0vjPxivLCgtegXzI0rW3bNSmxc2+cfXCMxQEX/PJE9h
 UDtV9nvE5+dW3Rzt5a35ho6wEOU319Wogg9IXBms6nkSrWnFWEF14cYTIuRomb6/LGCV3qKSoBp
 XS8Ok4QnT9NY5e2ziLB0XCt7rvsZetAUYyjpLCekAe5rR/ELici3eckXFQwgtNo7a4KnCCxljmR
 jNh7CGrLGTm8aWb3UyVqqEtXGjo6dYFZsZWAE0YXR3ZRUmIbsp1ArdF6kMqGFce8s51nMwHC9Qa
 dbjXFiqKYciHJfNCenRT+K2h4UsiPQKeerORg1jtN9WjWNan78YqcKMuCeN7+ZkFW/4BjP6WCv+
 eGMm14kMaJ4jSKkVFUudUhWtbFFWAykB9yNzY+kt1+WnWNQRF/s83l+6T7v+TrO//ED40sqh3QJ
 JrU7C2HtKzVDFvvV386Aft
X-Received: by 2002:a05:6830:4489:b0:7dc:d601:a69 with SMTP id
 46e09a7af769-7e4f2b8e71emr4248089a34.20.1778880000642; 
 Fri, 15 May 2026 14:20:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:00 -0600
Subject: [PATCH 01/66] bsd-user: catchup to locking / mapping routines in
 bsd-misc.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-1-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1492; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pDBL7W85bLOqj4gx3AV175aLRI3QACypNGsgVG8xCQ4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43h29+NZ+VZeC6ZgQiJn8HpXMjhksTZ4/npe
 mDpleXfM3aJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 AP2XD/9Qc4PzmAM50SMpjsI9xuJtUgNDxlMZm1xVVntUSM0PGjD3PLJvtZfF5b2/h77Vov94s2R
 aqCoEP1vwdb9PHaKa2Wdrsk/cOWdkMqhAAyOKk3fwdGCTzVL/ofT+UPHlxbm6gSWisT6XGHoVYx
 kdjHBRVjaJwp5anILU4KhFZpiBtjXwoWDdMGek+odCfqFxRjvHhS4kDxWCSv1DHRzrjhZiO2bbm
 vIgmVJvJI9rgSl1ClktO9FFskMW3P+w+wcby0QDgTfbjLHDPM9Qpi4GfrPaFkXzRFzBzH807Vnb
 z0rmI3DZyXTfWyCEVsnp+fwyymCM8+isjT609Y9P1xF/RzgYTiIyBzOAWGIWCFTfYP7tHPUcNSX
 jOldSJN/d/qkmIVIsMuO0BOPNg+jbArTkonpxat9Ne2MBgCj87jlyf7zdsq+EZcb+uHF5OjVbkX
 KILUQ2+KCxFvUVHccjpoyzUCM/WZMNanOSJ5fT6VDO0o+Iy2gkc4vsX8q/H9CaSIuwePwhZtTRK
 cUAmLpyM920+OhSsFDDlRLt11032wZ7ItKZteE1ZV28uZ3hnlYjhSBi7AjYGBvu6dv/M0Ja1XX6
 e5O0Hd0+41DpCpNx+DC+E5aIkNqCyx6K5/hrn8iQVHG8AoacReF4kzqKULRirMSu+ksBkBwEmqU
 TiO8oAmMVLSv8GA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

These were added to bsd-misc.c in a prior series. The declarations
logically belong here, but aren't strictly needed with the current
structure of the code due to include contamination.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 756425d18e..f7c8338213 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -32,6 +32,24 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 /* bsd-mem.c */
 void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
         struct target_ipc_perm *target_ip);

-- 
2.52.0


