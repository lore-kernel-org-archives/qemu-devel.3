Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025EACD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hW-00034h-Ac; Sun, 21 Jun 2026 00:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hM-00033Q-TP
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:20 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hK-0005Gn-V0
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:20 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-447046c980aso1585680fac.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015738; x=1782620538;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UjN9Lj6CRIZkO6eSwN2LZNNxHatuBucXujeKYt2epOE=;
 b=jrBvcQBiB7Vp/RWkKqekzD0reWv2c62tq9uOfKQ60K7/NE+pXAlKz6QQwQ3Ttg5Uk+
 f9PIOrU7hzuQvO49/7z+JAPZOm/pGGaAuBbV7KkYTKVQFC5syo6MF4mR8FQpvcP7W8Uy
 3RpLq++XYDDazkpkB/Z7IgPdz+ktz8aOcntMFgMf2g5ulR08es56PdjJTxlOUQgTqdoQ
 /BVOQ6fYXsEOz6m6IlrFl+pB1Tc1gKQrTTa0X9JznmaYwouC43CmG2aZCmT9yVASe0OO
 jwMO0BmvIRASAqrlvLN/SI2N5lhFE6x90RPsUvqfZML0L8MhueFyGJqzAUvYSNUvQ2El
 psiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015738; x=1782620538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UjN9Lj6CRIZkO6eSwN2LZNNxHatuBucXujeKYt2epOE=;
 b=OqqeQ2YeCsbV+70s6DkvP8QvsquDnWe/V3NxM5LwJ0KIA7pZcznM/xirJUybz4yv3c
 TYBcL3OO7+ZGHWqDXoNtqn2VmuW13k6IgEACxBxLDQAXgfv3ESIl+ESo4Rwu4UQ0qbVX
 gb0SYPG4h0RJ6OjiCiYAyjBmNfvOrqvshC8KztLn0/EmUK6FTNWyhmvCc2cN0GKHLvWn
 ldHTMaNBCj4HKwxLluiumOdrr7J6e71tFx2mYiP4BZOSSpEL3UY2Ifp/2VhPoSMxqWRe
 pTignGM+X9vkYWAu0va0qNouLu/n+HveYatJ5kwOl9gfiwEcpkYeOwHsOBP0jzSBpk2b
 qK+g==
X-Gm-Message-State: AOJu0YwkgVt+yFTWdHKmxrimFgSrnnu0zUlnrCNS7i11gS5I709p9blF
 fpR1gEwDSIumnfgtXvliEPIbzpdunaA4Jsv5QG5ylt9mHkK/EZeRbpc1m2HFtTzO3U8=
X-Gm-Gg: AfdE7cnBNv0THz88WAgy39eXNnA0IC/J1qEI7/RM6IYvaK375yWEraOdRwXEwTKey7R
 GFf9uumFwMNJtr0LXUlA7HUad1c7Em5/esEARlYWygvMWPpaawPErLsvTibEIcrfWAu9d5A1y8O
 3FIRSoiM9veyzz1ZSCVf7b4N08EBjslLg2WeJbMjBzNxGvCSrYTBgDk8cDx1zdVmc+d5DK+LJCX
 9vpgAMSEa3P289QN/V+C8Rk1P6ahf72YtqeIRSdqBBotKK/BtoewqkEBpMW1twG1nBqU8UEFNNP
 INVSwweKBdiw7esBtQ3lhO+1iManZLuXGsyyrdiKr5oAI6aHRdRzExmnhKNPbTtnDwugHaRrPAi
 +lv0N3AyuxDeaEgs4wglB39A25QngCejU/JUtsubpQQzlF9fWjnVF2Z0ubvEUHj4QjdCd8JYq7A
 Q=
X-Received: by 2002:a05:6820:6ac8:b0:696:806e:fd6 with SMTP id
 006d021491bc7-6a0d8d08c96mr7103927eaf.40.1782015737751; 
 Sat, 20 Jun 2026 21:22:17 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:13 -0600
Subject: [PATCH v3 26/40] bsd-user: Add thread, umtx, and ACL type definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-26-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5941; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=DkOdsmDodR6NsS9KAlFPGyeDTFdGshISXXa9GaUsHwk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aAVenTwaikcSi3FliivOyEpZRFvraaHEYHF
 nBPUb044mSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AGvUEACtTI/tN7UqwxbzjG1xgPqyK1X9jzi+g/AzP7WnUfkF5G7xfamUr6sOmNnjJJximhAtg2l
 ebW0oTRl95A3wQcoUELwJDAWpjYnPR9yLqjzX1GrF/d8O7meAfH3vIP4T1G4pLoJkgsQXIk1nIv
 IUjX11n7beItIvNAPMDS1u7ceN/R83jet2WJa7Jywq/W+/zZF9C9VK5KEtDYSCCk9gUrnwSQzVA
 NNwrwSJqHhkL+c+6t9zlthNujx4qG3NXwSuNwRymyPtXzD4awdgIh9uHmeeJL7AafOYvRZAZqLY
 aFbJPRIzEtul/DZg88GW1h4HrRyCZcAh9RHQyvUc1peNVVDiPZ8dQetxuNh/nOFMB+gboIHnHta
 JAM+vNZjJHIKCgnLaeMgo24MJtT8oYaIvQgLJchPzaEJZ/5GyiW5PdTJOqQHaz3nt26+ER8zcAN
 S3kVrLFXJo7XNB18xydaFqdd1XqRDThlQAjW+M3YLCMmebatIXWBz7yHFFTfLK64vkcdfY7pbxZ
 s2kK30454mKCLElrTYugF4VCfax8HEdBFSdRhhOQwkAdvEhAgxelnSSPVvy4KiyH3iybcSVHFuJ
 iraYrOhB7ZHi0/Ehuy3VnvBFlgmTfGXflsFi2ml54jUcpODorq5SyGVgB5aSyaVFU+cjdCWf0qA
 iUdirWJGf4h4fuw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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

Add target_freebsd_thr_param, target_freebsd_rtprio,
new_freebsd_thread_info_t, TARGET_UMTX_OP_* opcodes, umutex/urwlock
flags, and target_freebsd_acl structures to syscall_defs.h. Add forward
declarations for os-time.c, os-socket.c, os-thread.c, and os-extattr.c
functions to qemu-os.h. Add thread and umtx function declarations to
qemu.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/qemu-os.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/qemu.h            | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index 12adc50928..b1ff5c0cd5 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -32,6 +32,54 @@
 
 struct freebsd11_stat;
 
+/* os-time.c */
+abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+
+abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr);
+abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts);
+
+abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
+        abi_ulong target_ut_size, void *host_t, size_t *host_tsz);
+
+abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr);
+abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *host_tx);
+
+abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
+        struct ntptimeval *ntv);
+
+abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n);
+abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
+        abi_ulong target_fds_addr, int n);
+abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds,
+        int n);
+
+abi_int next_free_host_timer(void);
+int host_to_target_timerid(int timerid);
+abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+        abi_ulong target_addr);
+abi_long host_to_target_itimerspec(abi_ulong target_addr,
+        struct itimerspec *host_its);
+int get_timer_id(abi_long arg);
+
+/* os-socket.c */
+abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
+                struct target_msghdr *target_msgh);
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+                struct msghdr *msgh);
+
+/* os-thread.c */
+abi_long t2h_freebsd_rtprio(struct rtprio *host_rtp, abi_ulong target_addr);
+abi_long h2t_freebsd_rtprio(abi_ulong target_addr, struct rtprio *host_rtp);
+abi_long do_freebsd_thr_new(CPUArchState *env, abi_ulong target_param_addr,
+        int32_t param_size);
+
+/* os-extattr.c */
+struct acl;
+abi_long t2h_freebsd_acl(struct acl *host_acl, abi_ulong target_addr);
+abi_long h2t_freebsd_acl(abi_ulong target_addr, struct acl *host_acl);
+abi_long t2h_freebsd_acl_type(acl_type_t *host_type, abi_long target_type);
+
 /* os-stat.c */
 abi_long h2t_freebsd11_stat(abi_ulong target_addr,
         struct freebsd11_stat *host_st);
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 60d1adf560..069baa7011 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,47 @@ abi_long do_freebsd_sysctlbyname(CPUArchState *env, abi_ulong namep,
         abi_ulong newlen);
 abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2);
 
+/* os-thread.c */
+extern pthread_mutex_t *new_freebsd_thread_lock_ptr;
+extern pthread_mutex_t *freebsd_umtx_wait_lck_ptr;
+void *new_freebsd_thread_start(void *arg);
+abi_long freebsd_lock_umtx(abi_ulong target_addr, abi_long tid,
+        size_t tsz, void *t);
+abi_long freebsd_unlock_umtx(abi_ulong target_addr, abi_long id);
+abi_long freebsd_umtx_wait(abi_ulong targ_addr, abi_ulong id,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_wake_unsafe(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_mutex_wake(abi_ulong target_addr, abi_long val);
+abi_long freebsd_umtx_wait_uint(abi_ulong obj, uint32_t val, size_t tsz,
+        void *t);
+abi_long freebsd_umtx_wait_uint_private(abi_ulong obj, uint32_t val,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_nwake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_mutex_wake2(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_sem2_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem2_wake(abi_ulong obj);
+abi_long freebsd_umtx_sem_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem_wake(abi_ulong obj);
+abi_long freebsd_lock_umutex(abi_ulong target_addr, uint32_t id,
+        void *ts, size_t tsz, int mode, abi_ulong val);
+abi_long freebsd_unlock_umutex(abi_ulong target_addr, uint32_t id);
+abi_long freebsd_cv_wait(abi_ulong target_ucond_addr,
+        abi_ulong target_umtx_addr, struct timespec *ts, int wflags);
+abi_long freebsd_cv_signal(abi_ulong target_ucond_addr);
+abi_long freebsd_cv_broadcast(abi_ulong target_ucond_addr);
+abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_unlock(abi_ulong target_addr);
+abi_long freebsd_umtx_shm(abi_ulong target_addr, long fflag);
+abi_long freebsd_umtx_robust_list(abi_ulong target_addr, size_t rbsize);
+abi_long freebsd_set_ceiling(abi_ulong target_addr, uint32_t ceiling,
+        uint32_t *old_ceiling);
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /* user access */
 
 #define VERIFY_READ  PAGE_READ

-- 
2.52.0


