Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B5F3C985
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutcB-0001wa-9C; Tue, 24 Feb 2026 09:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb8-0000hC-Gt
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:15 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vutb4-0001KF-JH
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:41:13 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c9537f90so3787244a34.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771944067; x=1772548867;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=bBxfjtBXITnOXyVt6YkFsPmSLrtv/29rJdTi2o3njw77xmHyJdFnax08el+LfvMGtu
 aLOObJbOqI/0ThdcC9Xd6YoBlVojahFiYmFu4dcQ/8SZhi4LulmmyjXFYtdP8/jC/fl8
 jlISCv+Dr9Hn7Q3qBZ+dsMc4smFfi1CJrYOtEULryq45C/tU7+nfw4RSOeyeIQn4GQ13
 07mAKt/+zLxM/gCSO+Unameyfk3Uuyy/C+fJvSMkB2CDjtJ7013sJgjwTu+AXttoBrKq
 DNgllKhb5kEZuRlseqGgJnD66GK3UbmW5UDlkwUILrATrJRFJZYIOR2ycNfbEl7x///5
 Fg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944067; x=1772548867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=aP8e9joJE2ebOsM1Min22NbE5GlgweC1zZ/Sdj1zOznr3+WKfpq0y3jYsLZWRcxNwh
 33WXQDpuudg9hehr/NxIEgUtmzAAkT57BFlmX+jYGmJNIlQAUd5QYvjoKS2sbTb60HhM
 JFfpF3vsFcuy+BZa3ni8pkyU/YLHjVjZihvjyNwMqZm69u2PuIuXuQWXpUprtdA7qGqf
 OreYpLlEVKmCyO8lyASIVgm9TcZN6I9JzlYqa+F4AP11btHsg+8e+zAPhXWL8+NlA1Pw
 hgkBKMzNckU7Q19fkh6aCCSf3xT4h7GDgozjSaJtA7X/k+EL7nwoBOoWpg/3wJ6bZ9js
 PeYA==
X-Gm-Message-State: AOJu0YwnLyVw2/eHUPpnRNgswH0vBRJOavxhXdDP87Pf+BlJEYtmhJFy
 PPbWvbVnRP7Zq7IXFHq8fhJOOh5goRjOMngC/oTS3cnvw3VCNRGYvfxEkpxtBKl3uog3+zFbgj1
 X8ZK28kA=
X-Gm-Gg: AZuq6aKLRL96uu6RSodknkKv9md7McajYBHVTXjqzQN1Z6Gn/7vCl/gHEdpmIpifXuP
 102HobryPHFAgDaGuYuSbHm4lDl+VnvnDx8MEVQFju+lrsiFAidYHBSARPe05dxX743wjo8Zt67
 +hjni/G/5QpU886GzZufxzgwIy4zkM9ZqqDUTt/xi5dCBbWmSOY5obInkzBxbv8ru279Gv0yh56
 dzREgiJgCCBLmurdk6zSEjKofqZgRuOXrx7Uqfk8PUWxZ4RMuvtrlD5lmV1b29jAC11abDgmqUl
 4NRs/XbGFCzcR/6Ose/AjlskmZJSGByBydvkPkO6+9C1pwvaiQuqTOWvYaxMEpoMHl0mO/O/Ojc
 I7t0I8Wrw2QFlN/LTOGPyGhGCxxX57IaetWaKgWdM9VF4rgfNvuZdOUTyPD8gWjmSf+hgzbHKUn
 nKLsM77SJOXw==
X-Received: by 2002:a05:6830:82dc:b0:7cf:d213:7ecf with SMTP id
 46e09a7af769-7d52bf5324bmr6565836a34.32.1771944066888; 
 Tue, 24 Feb 2026 06:41:06 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cfa04dbsm10099393a34.12.2026.02.24.06.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:41:06 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Feb 2026 07:40:45 -0700
Subject: [PATCH v4 21/24] bsd-user: Add bsd-misc.c to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-bsd-user-claude-v4-21-8ee5ae17056f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lYzRsyug+gEPTEbXMUdsQyKOjOqAIW1H1r6EjiVoPYg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpnbhofXcsQKSo+w0LBmSIlAL+7V/EpLSayMrPX
 EkyU88TU8iJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZ24aAAKCRBsHNEofbAR
 ANWwD/9sWD0J1TWLYVVBgdr1VzY0m72I0qsW20q2yYtGPqLb0212VfWQIWDJwhFC2Vst4sP8eHh
 bhtWv0O0xwGFk/0gLEBgJNgIC9Meu96ZSKSc1cyNQ8j2cvqc2k3LozKPbqbO55qIKTZtzdPiO1Y
 xu3iHcX2tb6KbF4Rv1eaVv3I0YcaEnHVAkMGKV886vrEQKvt92H5pO0Dmjb0JfSVLG53QtIZP/N
 clGkBDZ3Ssn+gzWT4W/K9Iv298pTOkaCB4eZ6FaNRWT+i24kTzAnPcLnQfRjniPdrhxXPF/iScz
 8+g2NwCxYYCYq9cnX9DHUWNerBU1arLNcFeX+owcIs3PzLBsF7KSOxx+CvWOEPxptxvwSf8dXqY
 nzhB8m3TrqW/mnii9dK+j2TI5sXJcP0ASOGXINNAV6i7aGkWfJrucWAvvvgqLnkJiwoXsy3ipkv
 Ou7Mh1coOeUyfwE1Vtf25lZigAOSu5gtoYqRIJMCKquF6K8bm11qgPw22PTQUWBTtewz6vdyn+5
 tTtCc0FwHvVfbtx3s2t8HRiXQKMcUFJ/ItjcwMJUyhFV1iBlAhJzKc909pnSKmbTWNBCmC3jrrH
 fwAZ4ztLoQqejQfrCOfzQaXrxAcvKjTJJrZM96jwy7XmkrsbBDxJdU0LKMx3L0RBcDiwc5RA0+7
 z0z1kgy6U4QC/fw==
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

Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
reboot and getdtablesize.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 37b7cd6de8..00428fc2f8 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -8,6 +8,7 @@ common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
   'bsd-mem.c',
+  'bsd-misc.c',
   'bsd-proc.c',
   'bsdload.c',
   'elfload.c',

-- 
2.52.0


