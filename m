Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7EFCD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPl-0006Kt-QW; Wed, 06 May 2026 22:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPj-0006FD-Pn
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:35 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPh-0007dy-QW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:35 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6967fd0416bso199982eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120672; x=1778725472;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3u0FxYSV8ioorvbJiF5UQtlkvJS2lMH4tRonZlbtlE=;
 b=IDBsNxkdlpWv4TLNaBRVtLX5D0WM83ySJY/s+00qkOw8ySNGNJ1WF9AV67OAAufmJb
 ZQq9PTjMXPLB3s3L2xfUW5I/2RKauHEc+MgYD/Df88FSmftZLXZsnLI0n/R4Uk2/dgX4
 wEQZk7qG7vR4O9L7EXlQAxxH70UjF8JQ9ozZVYuBkXkl7QndJJniMdNYNikWr9N55YXp
 oFEZOLbLbrRL4yYbGj8UdDBnko3u0gM9gLwtQ++d/kzsbz9ZdICra7aTathgaCISnIfM
 VTrcuhemkwHT1uKL39/7ahUL5y59ka/KKLEXIszWeGpEXNhWaUodj+qy8mQYLYWCQ8yx
 BB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120672; x=1778725472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3u0FxYSV8ioorvbJiF5UQtlkvJS2lMH4tRonZlbtlE=;
 b=mIwnjQIdVECt26b+sVkCg1Iod5+hcx9LOfxpqDU/EAy3K4TLz2/SbUUx8Hg5v/Gjdw
 5R3+hm4xmW30mmYVxVxtkqctGyBOpi7daYUaOiB/ljcdcyByAqWKC3ob2MMNIPmNewsP
 DxzFgj2FTPzoSxFK/NcgtnwEmnvamTVXZYiTJCL5kaLmKSiGDqmNl8HVe1KVZqHbAMdX
 z0uVKsI74gKurWw3YXTKR9/OMe3lwa9Drz+7mT2zOhnTlbSC5CHaoikq4vwLhepDpnh7
 jvZuNNFdhNj3ZC3spjWpcraOca6HHRL8UadM83ngKEPe+Zz6ef3aBN3+tpnWZBb4qti7
 xkxQ==
X-Gm-Message-State: AOJu0Yw3OE31kqQ13Yl05DnnNuVpaIFnTVVSSuM+M8yjnESIEHssvUC4
 qe/tdecMkbqCV5KZ9XV6T+1TFpNrg3ywXvUNHT5aea91mSrO21nxN6IlRRjChLMOec42uF6kiuF
 XJQM/IJk=
X-Gm-Gg: AeBDiev71yzguUmOxhsAsUM+uH9cexPy965AunA80NmitYENrxTwQ9vGjMcupUhw03A
 UQv+1IhLgjIF1wj6Anc5QKiNXtkvGgBZevNY+nLFodAI/SEej6mG8RFL95MJ0i6hoYYrwO/A0DD
 jDxiing/x5iGOGPXCsnyYPhfM6wfKWRHmWMDnjdITVC6wXRCcxcntFa05Kba9XBlcGqMFRf38q4
 906nSeygSOHMBZIDCxXO+2JAD462ufSPW+zVpcNWbILM6vY4GNe4sc1ct+uLdljsuXwy0wylwNf
 u0fS1J2AZqwcM2dCKIop0XcodOzaCSI0iHnHOYdrsH1lAMNkj5+VM70PNEmWH+j6SmKK8JAF685
 IHbTinfXU1SZiM7SRMTdUgaKid7Ve+z3jxa1Z9oFJfxaLLrmyHd+FVhxoSGJ5ufyQtaT/qgg1wf
 FBiaJc4h6szQTsJh9EAMLr59kzU2ovuJjsYMRasfYOZg==
X-Received: by 2002:a05:6820:1c91:b0:67e:ae5:732e with SMTP id
 006d021491bc7-69998cfe0e9mr2912646eaf.36.1778120672391; 
 Wed, 06 May 2026 19:24:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 13/25] bsd-user: Add FreeBSD IPv6 ioctl definitions
Date: Wed,  6 May 2026 20:22:07 -0600
Message-ID: <20260507022219.44171-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stacey Son <sson@FreeBSD.org>

Add os-ioctl-in6_var.h with IPv6 network interface ioctl definitions
including SIOCAIFADDR_IN6, SIOCDIFADDR_IN6, and related IPv6
configuration ioctls with target_in6_* structure definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-in6_var.h | 226 ++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 bsd-user/freebsd/os-ioctl-in6_var.h

diff --git a/bsd-user/freebsd/os-ioctl-in6_var.h b/bsd-user/freebsd/os-ioctl-in6_var.h
new file mode 100644
index 0000000000..82f0514c7b
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-in6_var.h
@@ -0,0 +1,226 @@
+/*
+ * FreeBSD in6 definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2014-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H
+#define BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H
+
+#include "os-ioctl-sockio.h"
+
+/*
+ * see netinet6/in6_var.h
+ * and see netinet/in6.h
+ * XXX target_in6_addr and target_sockaddr_in6 should maybe go
+ * somewhere else.
+ */
+struct target_in6_addr {
+        union {
+                uint8_t         __u6_addr8[16];
+                uint16_t        __u6_addr16[8];
+                uint32_t        __u6_addr32[4];
+        } __u6_addr;
+};
+
+struct target_sockaddr_in6 {
+        uint8_t         sin6_len;
+        uint8_t         sin6_family;
+        uint16_t        sin6_port;
+        uint32_t        sin6_flowinfo;
+        struct target_in6_addr sin6_addr;
+        uint32_t        sin6_scope_id;
+};
+
+struct target_in6_addrlifetime {
+        target_time_t ia6t_expire;
+        target_time_t ia6t_preferred;
+        u_int32_t ia6t_vltime;
+        u_int32_t ia6t_pltime;
+};
+
+struct target_in6_ifstat {
+        uint64_t ifs6_in_receive;
+        uint64_t ifs6_in_hdrerr;
+        uint64_t ifs6_in_toobig;
+        uint64_t ifs6_in_noroute;
+        uint64_t ifs6_in_addrerr;
+        uint64_t ifs6_in_protounknown;
+
+        uint64_t ifs6_in_truncated;
+        uint64_t ifs6_in_discard;
+
+        uint64_t ifs6_in_deliver;
+
+        uint64_t ifs6_out_forward;
+
+        uint64_t ifs6_out_request;
+
+        uint64_t ifs6_out_discard;
+        uint64_t ifs6_out_fragok;
+        uint64_t ifs6_out_fragfail;
+        uint64_t ifs6_out_fragcreat;
+
+        uint64_t ifs6_reass_reqd;
+
+        uint64_t ifs6_reass_ok;
+
+        uint64_t ifs6_reass_fail;
+
+        uint64_t ifs6_in_mcast;
+        uint64_t ifs6_out_mcast;
+};
+
+struct target_icmp6_ifstat {
+        uint64_t ifs6_in_msg;
+        uint64_t ifs6_in_error;
+        uint64_t ifs6_in_dstunreach;
+        uint64_t ifs6_in_adminprohib;
+        uint64_t ifs6_in_timeexceed;
+        uint64_t ifs6_in_paramprob;
+        uint64_t ifs6_in_pkttoobig;
+        uint64_t ifs6_in_echo;
+        uint64_t ifs6_in_echoreply;
+        uint64_t ifs6_in_routersolicit;
+        uint64_t ifs6_in_routeradvert;
+        uint64_t ifs6_in_neighborsolicit;
+        uint64_t ifs6_in_neighboradvert;
+        uint64_t ifs6_in_redirect;
+        uint64_t ifs6_in_mldquery;
+        uint64_t ifs6_in_mldreport;
+        uint64_t ifs6_in_mlddone;
+
+        uint64_t ifs6_out_msg;
+        uint64_t ifs6_out_error;
+        uint64_t ifs6_out_dstunreach;
+        uint64_t ifs6_out_adminprohib;
+        uint64_t ifs6_out_timeexceed;
+        uint64_t ifs6_out_paramprob;
+        uint64_t ifs6_out_pkttoobig;
+        uint64_t ifs6_out_echo;
+        uint64_t ifs6_out_echoreply;
+        uint64_t ifs6_out_routersolicit;
+        uint64_t ifs6_out_routeradvert;
+        uint64_t ifs6_out_neighborsolicit;
+        uint64_t ifs6_out_neighboradvert;
+        uint64_t ifs6_out_redirect;
+        uint64_t ifs6_out_mldquery;
+        uint64_t ifs6_out_mldreport;
+        uint64_t ifs6_out_mlddone;
+};
+
+struct target_in6_ifreq {
+        char ifr_name[TARGET_IFNAMSIZ];
+        union {
+                struct  target_sockaddr_in6 ifru_addr;
+                struct  target_sockaddr_in6 ifru_dstaddr;
+                abi_int     ifru_flags;
+                abi_int     ifru_flags6;
+                abi_int     ifru_metric;
+                abi_ulong       ifru_data;
+                struct target_in6_addrlifetime ifru_lifetime;
+                struct target_in6_ifstat ifru_stat;
+                struct target_icmp6_ifstat ifru_icmp6stat;
+                u_int32_t ifru_scope_id[16];
+        } ifr_ifru;
+};
+
+/* netinet6/nd6.h */
+struct target_nd_ifinfo {
+        uint32_t linkmtu;
+        uint32_t maxmtu;
+        uint32_t basereachable;
+        uint32_t reachable;
+        uint32_t retrans;
+        uint32_t flags;
+        int32_t  recalctm;
+        uint8_t  chlim;
+        uint8_t  initialized;
+        uint8_t  randomseed0[8];
+        uint8_t  randomseed1[8];
+        uint8_t  randomid[8];
+};
+
+/* netinet6/nd6.h */
+struct target_in6_ndireq {
+    char ifname[TARGET_IFNAMSIZ];
+    struct target_nd_ifinfo ndi;
+};
+
+struct  target_in6_ndifreq {
+    char ifname[TARGET_IFNAMSIZ];
+    abi_ulong ifindex;
+};
+
+
+#define TARGET_SIOCGIFDSTADDR_IN6 TARGET_IOWR('i', 34, struct target_in6_ifreq)
+#define TARGET_SIOCGIFNETMASK_IN6 TARGET_IOWR('i', 37, struct target_in6_ifreq)
+
+#define TARGET_SIOCDIFADDR_IN6 TARGET_IOW('i', 25, struct target_in6_ifreq)
+#ifdef notyet
+#define TARGET_OSIOCAIFADDR_IN6 TARGET_IOW('i', 26, struct target_oin6_aliasreq)
+#define TARGET_SIOCAIFADDR_IN6 TARGET_IOW('i', 27, struct target_in6_aliasreq)
+
+#define TARGET_SIOCSIFPHYADDR_IN6 TARGET_IOW('i', 70, \
+                                             struct target_in6_aliasreq)
+#endif
+#define TARGET_SIOCGIFPSRCADDR_IN6 TARGET_IOWR('i', 71, struct target_in6_ifreq)
+#define TARGET_SIOCGIFPDSTADDR_IN6 TARGET_IOWR('i', 72, struct target_in6_ifreq)
+
+#define TARGET_SIOCGIFAFLAG_IN6 TARGET_IOWR('i', 73, struct target_in6_ifreq)
+
+#ifdef notyet
+#define TARGET_SIOCGDRLST_IN6 TARGET_IOWR('i', 74, struct target_in6_drlist)
+#endif
+
+#define TARGET_SIOCGIFINFO_IN6 TARGET_IOWR('i', 108, struct target_in6_ndireq)
+#define TARGET_SIOCSIFINFO_IN6 TARGET_IOWR('i', 109, struct target_in6_ndireq)
+
+#define TARGET_SIOCSNDFLUSH_IN6 TARGET_IOWR('i', 77, struct target_in6_ifreq)
+#ifdef notyet
+#define TARGET_SIOCGNBRINFO_IN6 TARGET_IOWR('i', 78, struct target_in6_nbrinfo)
+#endif
+#define TARGET_SIOCSPFXFLUSH_IN6 TARGET_IOWR('i', 79, struct target_in6_ifreq)
+#define TARGET_SIOCSRTRFLUSH_IN6 TARGET_IOWR('i', 80, struct target_in6_ifreq)
+
+#define TARGET_SIOCGIFALIFETIME_IN6 TARGET_IOWR('i', 81, \
+                                                struct target_in6_ifreq)
+#define TARGET_SIOCGIFSTAT_IN6 TARGET_IOWR('i', 83, struct target_in6_ifreq)
+#define TARGET_SIOCGIFSTAT_ICMP6 TARGET_IOWR('i', 84, struct target_in6_ifreq)
+
+#define TARGET_SIOCSDEFIFACE_IN6 TARGET_IOWR('i', 85, struct target_in6_ndifreq)
+#define TARGET_SIOCGDEFIFACE_IN6 TARGET_IOWR('i', 86, struct target_in6_ndifreq)
+
+#define TARGET_SIOCSIFINFO_FLAGS TARGET_IOWR('i', 87, struct target_in6_ndireq)
+
+#define TARGET_SIOCSSCOPE6 TARGET_IOW('i', 88, struct target_in6_ifreq)
+#define TARGET_SIOCGSCOPE6 TARGET_IOWR('i', 89, struct target_in6_ifreq)
+#define TARGET_SIOCGSCOPE6DEF TARGET_IOWR('i', 90, struct target_in6_ifreq)
+
+#ifdef notyet
+#define TARGET_SIOCSIFPREFIX_IN6 TARGET_IOW('i', 100, \
+                                            struct target_in6_prefixreq)
+#define TARGET_SIOCGIFPREFIX_IN6 TARGET_IOWR('i', 101, \
+                                             struct target_in6_prefixreq)
+#define TARGET_SIOCDIFPREFIX_IN6 TARGET_IOW('i', 102, \
+                                            struct target_in6_prefixreq)
+#define TARGET_SIOCAIFPREFIX_IN6 TARGET_IOW('i', 103, \
+                                            struct target_in6_rrenumreq)
+#define TARGET_SIOCCIFPREFIX_IN6 TARGET_IOW('i', 104, \
+                                            struct target_in6_rrenumreq)
+#define TARGET_SIOCSGIFPREFIX_IN6 TARGET_IOW('i', 105, \
+                                             struct target_in6_rrenumreq)
+
+#define TARGET_SIOCGETSGCNT_IN6 TARGET_IOWR('u', 106, \
+                                            struct target_sioc_sg_req6)
+#define TARGET_SIOCGETMIFCNT_IN6 TARGET_IOWR('u', 107, \
+                                             struct target_sioc_mif_req6)
+
+#define TARGET_SIOCAADDRCTL_POLICY TARGET_IOW('u', 108, \
+                                              struct target_in6_addrpolicy)
+#define TARGET_SIOCDADDRCTL_POLICY TARGET_IOW('u', 109, \
+                                              struct target_in6_addrpolicy)
+#endif
+
+#endif /* BSD_USER_FREEBSD_OS_IOCTL_IN6_VAR_H */
-- 
2.52.0


