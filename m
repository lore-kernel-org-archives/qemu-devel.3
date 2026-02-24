Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F93F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutaw-0000LN-M1; Tue, 24 Feb 2026 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutao-0000J7-Aw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:55 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutam-0001Ht-RG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:40:54 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so5155044a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944051; x=1772548851;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e2UYyOMHlja6Kl2L8NhlVAAFnx93AP80rNAabxdIAvw=;
 b=JO/jThbsY+lKDBHqSipex3IA59/A2vGV4aMqFgAMpLo7GsUFpqGGXEMcg2TbabsaL3
 urULOmjmSUiCwULPEzUn9p3Qrf1AtpTfTsSV7V8Ii+mVHxbmQ1yIlhSaxSwoPueyYClV
 IyM2SN0fECXZi35b+2iw6brctZkp8qxjrQU7LrK4bIzSeuAeZm0jRb01OL2AkVc45UtR
 UNvqWswS2+CePPRtVIQpJ9JoiYN2HEjSxsh0eS832dgSlUqAbL5lTubiS11oPcS6JeyS
 1m11tZZRG04REOnS3B7ItHGDarSSj80IGBHFyeQN8F/kfyhSxy7766RCoXTKoMrFf8DJ
 6lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944051; x=1772548851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e2UYyOMHlja6Kl2L8NhlVAAFnx93AP80rNAabxdIAvw=;
 b=gYP5uxwmR360vWBeCJa1n+F9d2L1d6qAEXCCkO/jZdYvHAlzEmOH/+1lsuS0E/TmZ2
 TW9OkBTwRAV0pFq7YsqMYpIp7wtk7QLiegEeyGQtM8FaxpD27F0oz0hmUHXENqU07ywG
 N/tY1xLuCBL9ai5CA+VwTsfXx3btc0ELzG0dD4b8N7gLcuVPUSgjBDqMOFCebf3+809q
 GupaxdoJOAQHHmBE0CwRddMtxgAtLVZo8mjzLT00OgzyJDs6wXgJQ5E7tFFAlI0drkO3
 d5b6MRQ5L+9I4jmJsc0TNDfObwSFtH3KWWWeB95OY6M44g69UiQ4yuyhhYHiTfGhaKKG
 SrxQ==
X-Gm-Message-State: AOJu0YykWYZXmjj7GcbEkbL2LTds49cVxkJrLjZo5exJrxN9U3IQzpRJ
 ia+d28vlYs1EY+lQTCoy+FapO+qnZ9Aa2DpngPXhIsQSGhe66Zpby+QnlewhahKMEDNvanXg9XQ
 RQUwUR24=
X-Gm-Gg: AZuq6aKF6TR5YQcpbyJ8hotIOpD5W5hMmJ+r5Ny9gIjRptoRObbinfe78GwWLL3RnSH
 u4zbW5c2rqdCE3CfKA7AJCvQVKOqqMuEuzgmDvK+VIjdC8DRCsR/6X+8C/de00m337kDKoQpj3V
 kUl/kuAZUPt+XgUkmLcrumaR4oQF9Zi1TVubrYQx8qaKer0y5aAS2Vj5eAgUjHcOWE2Hm3rLw0Q
 d4rHIaaw09gAiaJ79gh0Tn1OmkZ5/rtDbhtv+bmg0VsbAxoeIbQ0Y4diLD534YXqvPDEd5xcJC7
 cAPy81RZF3NwQm3ppWwfua+Q0EFqlvdQuWRwqnrJNXGsvTFNFkuxSjVZq9P/2FGWqSwBYhCV3x1
 WhYvGh++7ITJHsMR4e0mjxr2X4/fyRoX8M/mnW+OYjAsQ7gxLe1owPy3jPjEkt1uR1vwWiFVAzs
 IiHiS0JlCn+g==
X-Received: by 2002:a05:6830:3c07:b0:7c7:5d72:566c with SMTP id
 46e09a7af769-7d52bf35ec3mr8423247a34.24.1771944051486; 
 Tue, 24 Feb 2026 06:40:51 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:40:50 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:32 -0700
Subject: [PATCH v4 08/24] bsd-user: Add host_to_target_semarray for
 semaphore operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-8-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=1LFR2/aewofcqUWaUSfvi7cCnimlAOVVnZsi6mqqDx0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhn68Ss10uRCoXc8pHT5iJOAJPMPjxA+J7/t
 5PdwoGWz0uJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24ZwAKCRBsHNEofbAR
 ALLOEACogmjDALLJRXaWNP/1ZBQb1VELi/7fG2xUNWKCMhPvxpmj9j9ePPYn0OAcvffdABEZCRw
 1zZgm2yVMNtEf38on1xU2kHe+9EvPpVoze5FnJGTca8J/jfhgk5h+iA/nSDe4HVGnw/S1tpJclh
 Hh3dikg5UB+KvPp0Mo2sMdWh520oaRIybc9ZjSVGYGimoMIAr0ZrhNLwz50tULUgmgJuCC4LUXm
 lqIJZb2cN7Z/Nsx+0XF7IF54dTeuaeZXKV+67gy8+kzo/jYFV7pSvj5l0K7+nFYJ9vN4Fws88Dt
 r4+UpTBJHJ+v9DvaQVljvfQv7wxaj4k3RUQSHxYj/5XUHSETkOMY94oCoGYfqu5/DYa/dB4FxX8
 Y2BkR2LA+o+XYzmR9oQZEWBNrihEZROeGQdeD1NKtu5c3R6dFogK4BAoEdrvFCtbXgmBDUr9ydw
 zBZVOyunzTlgAgNlb5vbr9i12TvOK3sd20wdqCvGv4kP/SgMhB1ECd0UkDzqsw0w7ilCINuwpoX
 WQo2zvgKo3zMdAbRHibl3qx/CxCT/2iVefOyuH0TnGmJh170fTLDnGaoBndp7asXPOrO0r4G90P
 xoRntwllC4LWYwQq4T9pwP6QwySSdOqTETxFDovDzqCrlQq48nmKxytpa++L3gEamxfy8lTbcer
 Lx1kHBt8Yp66NAg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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

Add host_to_target_semarray() to convert host semaphore array to target
format for semctl(2) GETALL operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index d1645db46b..65fd7b72e5 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -68,3 +68,33 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
 
     return 0;
 }
+
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_arrayp)
+{
+    g_autofree unsigned short *host_array = *host_arrayp;
+    abi_long ret;
+    int nsems, i;
+    unsigned short *array;
+    union semun semun;
+    struct semid_ds semid_ds;
+
+    semun.buf = &semid_ds;
+
+    ret = semctl(semid, 0, IPC_STAT, semun);
+    if (ret == -1) {
+        return get_errno(ret);
+    }
+
+    nsems = semid_ds.sem_nsems;
+    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
+        nsems * sizeof(unsigned short), 0);
+    if (array == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsems; i++) {
+        __put_user(array[i], host_array + i);
+    }
+    unlock_user(array, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


