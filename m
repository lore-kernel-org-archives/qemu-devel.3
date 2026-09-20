Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02336C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89z9-0006QW-HB; Sun, 20 Sep 2026 01:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z7-0006Q4-Mr
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:05 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z6-0002As-1n
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:05 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-470417e5b52so1498888fac.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881663; x=1790486463;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/aafcq/csDJa1UZaYBIFoIJSQMYPsOz1xJbfqG7LhTg=;
 b=AaoSwRxiLz4/IGLfUcAXX9QvgNJMfJk216Wa9kluYbqwuR3VTnjZw3DAt4AYWtMxny
 p/qE3G1g+o2sw5X19DVrp0HQrlh+0+Af3YopjZ82+5dVVIZ2L7hCo/WOPULi3YKtKbaN
 kd0/1adFcj1qOBzuyllH4O9inoQhoQXTb9BRrvovYTYA6XnU4K51Z4s8S8BX6kalcmVk
 RRwJo9/0LAGpkJRA1TaSZuc/qh1kxn55V3WkDeaZRzubTb7NH1wkcArP2Orqub1AouhM
 sgApq2jvMIZ6N5UXJdlssA6xYdCDU6sXbbQu+lnGRRVUhHxRzZaV1ghHWMyxRH5+6vSe
 lwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881663; x=1790486463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/aafcq/csDJa1UZaYBIFoIJSQMYPsOz1xJbfqG7LhTg=;
 b=1gkJqgUdO6NkC6pow4L2vfViYW9AQGZ+gUibj7s3thb6Qq7EJ/cRveSyvFzJXoSXb6
 thKUz0CkXC2QOezRkkC3041kFAEHZn918sOikG6G5Kn5dCoAkkOCxjsSVF2l4AVZPjQ0
 cuQvCfWsHfi8qyGXMy+v1e1ZGXLvWw6mXj7bdQL2TuYXMVNMNgIn44TlTaMJ8xlj315Q
 xdZEFEjwjljONtFWuf0m5YgHBb+TNU+WPbWly8kMLbOmLsAnY7tTFDIUYIevBaDB5Iz9
 jPZZz0HBn/2aIF28sNAQgtDzeS7vK76+nPlYIl37cwJv2ooPoVZ6x3RBeyNcXZ1tDbHU
 LpGw==
X-Gm-Message-State: AFuF++m9ZInlP4qNU+qWTQ6wV3r7frYkG3Y545S1Z5w1uPNDtr8I3PgA
 q/jWnVPXs7DWcixo6RrinhpYZWiSHP47YNUdEV8JAF8i54E916lAooGp+0Xk9GzGtsg=
X-Gm-Gg: AYBFou2WrazbaQz8wk2jhJ3a+itYpGZpB74RbYirmGEOgkU4aD8kIQD9sxAhYLfMnkS
 M7NFtPiIJhpebeMtgUvx0ru55j6jh5h91zMk3wvXdYrFEQnoliRSJutSqCfcoA1D42+l5mOgb57
 oUl1eHWu5ZsqFqmt3/8iidOZt+oNPgr+2ilyFIpoORFmVXhosKeL+/i37XBZjclQzWvjrEQ1j5c
 UqRe49fg0Dq7PSsJjmhxzGnLMC5Pt0tw+Q54Qf++c3DRoFl2meczuy3wi5315tUhIqkzNxxhLQe
 Swxefkdm1BgY9UI9F3vQgpGxm8PoQ7CjNT0/OrUxznXSEu3C91OWOd6T++jZ36jRsvW+yS8OVy6
 Pr7Yfobqm0YIBi+LCq+WdOPfQMlo3WUcW9Hypd988imgXlITFq2b+agx9KrsW6drXIVgVOMv0pf
 BL8f3wnXbmVldf9liNTP+IGi5DyqnVZa39UssJDdMTsF+I0fiphGVIQfxDIw==
X-Received: by 2002:a05:6820:2221:b0:6c7:7668:a297 with SMTP id
 006d021491bc7-6ca9a22cb09mr6343399eaf.1.1789881662769; 
 Sat, 19 Sep 2026 22:21:02 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:38 -0600
Subject: [PATCH 02/14] bsd-user: Drop support for FreeBSD 12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-2-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lwQPYjfcLlLGXO1WOwNb4B+G4uN+9tStASCCSyWsQTs=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wGHsFrDaOrpDwBNhkRoBXN2eWXS4ga1Ost
 blMDI5rTnuJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBoPg//UCnQk4oz4cY5hht7xAkB3d/F1ryPVNG
 nfTdGxkNNABW6AT9jehXgHe1haJscyqTW7sNWH/lKKAfpoDe+/n5X/AOu/lXIU5FpMeUAJQGX40
 0qj3ezCnFCZ5qNte35wh7jOzkMpgkTrlgVtoxrtBETF73ZdQWzoqos/ARbR7h0sn4ubDDPCbmjr
 0EnIxo2Ol4o/rQvLpuE72o4RSTA9qASW6g3AI1g6Y2UXXFsbatdKLE07p3Qw+9xcD+u3EDPan7o
 TTCrbpkhfC5Gvkg1jya+TbtxuX9Z+9dYqqfMJdvcJaAUsLnEdpQlPdfN8ihkb0EYE+QA8JHTiHR
 5RITTna2VXjZ/AXfSzNTYZ5tWea608xGG/jI2FCn+E93899vfxNZwz+6pt2awNVjY0fXU/3ZcLL
 Dq9TbMRAeSQWZKM61KDqpr8ilvleE6cAi2cdu0SqJpZhlYigAmjqlz9kVZxDWzKDUilqkWBp1RB
 EpAB283tMrFZ8CU3PuBLeCMpyWejI8BaSYFHfOi5fgOlPBTaB4wu5bBntCE9oTATjeZ/9TssoxF
 18UpZJMAxfPGCazFi0zjO/lCincRU1MXKWSJQrns7QwtTr2h41yQrsaF1NMFFEhbCxRTRwt1Uj+
 bRBTfW45yq+iJ8WRNXxNAwkCM3UwdWAmpOYF4QGBy/rNWt1vKAek=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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

All supported branches have these, so we don't need ifdefs anymore.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/target_os_user.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index 9703b9a61a..688da6c81a 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -297,17 +297,12 @@ struct target_kinfo_vmentry {
     uint32_t kve_vn_rdev_freebsd11;  /* Device id if device. */
     uint16_t kve_vn_mode;   /* File mode. */
     uint16_t kve_status;   /* Status flags. */
-#if (__FreeBSD_version >= 1300501 && __FreeBSD_version < 1400000) ||    \
-    __FreeBSD_version >= 1400009
     union {
         uint64_t _kve_vn_fsid;  /* dev_t of vnode location */
         uint64_t _kve_obj;  /* handle of anon obj */
     } kve_type_spec;
 #define kve_vn_fsid kve_type_spec._kve_vn_fsid
 #define kve_obj  kve_type_spec._kve_obj
-#else
-    uint64_t kve_vn_fsid;   /* dev_t of vnode location */
-#endif
     uint64_t kve_vn_rdev;   /* Device id if device. */
     int  _kve_ispare[8];  /* Space for more stuff. */
     /* Truncated before copyout in sysctl */

-- 
2.55.0


