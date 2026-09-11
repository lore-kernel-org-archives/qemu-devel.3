Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9172CC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBO-00082U-PG; Fri, 11 Sep 2026 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xB1-0006XI-Mv
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAz-0008R6-Fv
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=Uuzk8cdtI92OvL3RUbfRdDFw+n0nNEBXyh2JLTo3SfYLUztM4nNNcmGJ/Jk4nxy/eF2H04
 1nBKGOchW2T1yXWCJyvPQx56UbNknNOstRWPmZGWvikB0XhUDqvILifK2YWAf/BBVAHDR6
 b9Chbkg7dccYmHDKdvUD/76j4r7z8uI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-g_YeLaZLPeyZopd9ZPgA2g-1; Fri, 11 Sep 2026 05:04:03 -0400
X-MC-Unique: g_YeLaZLPeyZopd9ZPgA2g-1
X-Mimecast-MFC-AGG-ID: g_YeLaZLPeyZopd9ZPgA2g_1789117442
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso1187505e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117442; x=1789722242; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=VYrjE0rb8SwIFu6dUg/aAL2scZWSr9XB2MG1IWupXGUATZlvrA8awtBrOhP0akqkBm
 NthD0XpIsvmKIT0uA9zcq1a5YlrwjpQPK69zvNlSjnKhUuu9t0FSE6/UxUpepCHupW3/
 IX0XG0xq2MNkVisoDzUa/mfsf1+zXxy7A8QI3uvHFzii8BbfRXu6XjzfU+UFW2LhLxt0
 +w6wVUHP1SAye3m+WOnO+kz06e5NVgCnahinmdedDt/viB4HpXFFXM3maOx8ojuUlOzn
 yGun98CGLKAvdTX0jvM1rnCiH6wwej2G+49pGbbyREsJL+Sp+DRjuCbOB+v41p7r/ux7
 XTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117442; x=1789722242;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KaGnA6790D1crogtaW20lAmdvIS1bCL1ahQfy0qBOJg=;
 b=HqS9ouotDja4Hb48nFeeHhKsRRZk9F48PGC9n/iYHXYjT/liZhC6/y6xSAMv26qtS1
 EnsZLlzvmqWU8hOffeXkbne0VNdI+9xRF0Sn1JxxxaEhL6rbbM7ZsuxCcbuWuDkccyYh
 7+gR7J/K2foeBomqSdgDxZxEzPExuABr1NhQmQFiuq4vnvbeciGOEKxiuN1T8cw8VgW5
 /7DZ9ojtEpg01Jd+vf7Yza5bwpVtyAwCEdaZvmNnsMG55EdGz7kL5+nZpjBRYaq2spW/
 mSvQESccf3xjZ+Pi2sIESgJYHziiGYAAiItxjF738Bnq84Gg840uA1wBtOMzcKoY1jDQ
 /acw==
X-Gm-Message-State: AFuF++mv4eSky67RCzbvsD1/hkuOGOSAMP7w83+5crVgD3yk/IorMDi6
 RwPiTIT18DT7vLlEAm/n5+Xb19huTmGf2oGAJPtmtu6a30b+kBxkPm23U5sZMKBZ+LAbS+ZyNQ8
 sN4NLVXsX/Ly1hyU0/hVv1NsXdXZBWdK29z+p0gJL+wXGQK8dVT+OamIEBU6uWEKH1sfA7ndEoW
 iM/xVjQGz9XSpFitwW+nueo4ex3RPHCzPwjQ==
X-Gm-Gg: AYBFou2SUV0VrLiBSnsGsVqSNE7JiPDHt4383FvOD1ILpi0gAC+qIt+m8fEXanNAjPj
 sYLjAe+prtRJb4450MDoBtPuYcmY7ahylxT9M2dZFs1CAsXt4/KoW5ipJrdSeIhbV+SWnaamVgj
 BlzBURa8cizTO2MQKJdmbrHaev6exJIXm1QLNYYAsOLyfivxQ7enxeMPs0iyTmCZjdlEPTpYJlR
 zcskmgC2dQstsRg6CMlieo6c5T0hIRBr5xnOKFpXT6Fs8HtSvYn329mnORHpP6rfl5FR33cnacZ
 8dboUZf2XFDgLCTYvTjjF6Nq8AjLcL+DsltbkbQFO+74DQNpmLktGIqHr4elGgMpVlgUT3k91JJ
 roGh3Q7DCoKIYF3zSupKxqcU=
X-Received: by 2002:a05:600c:3145:b0:49c:fc6e:8cae with SMTP id
 5b1f17b1804b1-49e619bbca8mr32818185e9.18.1789117441734; 
 Fri, 11 Sep 2026 02:04:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:49c:fc6e:8cae with SMTP id
 5b1f17b1804b1-49e619bbca8mr32817485e9.18.1789117441165; 
 Fri, 11 Sep 2026 02:04:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm30230865e9.2.2026.09.11.02.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:00 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Weimin Xiong <xiongwm2026@163.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 66/75] net/tap-solaris: Fix resource leaks on error paths
Message-ID: <44345a8a5f03f459ce6ff81b14ece81afd9c90d5.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/tap-solaris.c | 69 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 8704b1084b..2c6c7af15e 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -60,8 +60,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
  */
 static int tap_alloc(char *dev, size_t dev_size, Error **errp)
 {
-    /* FIXME leaks like a sieve on error paths */
-    /* FIXME suspicious: many errors are reported, then ignored */
     int tap_fd, if_fd, ppa = -1;
     static int ip_fd = 0;
     char *ptr;
@@ -102,45 +100,61 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
     strioc_ppa.ic_timout = 0;
     strioc_ppa.ic_len = sizeof(ppa);
     strioc_ppa.ic_dp = (char *)&ppa;
-    if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0)
+    if ((ppa = ioctl (tap_fd, I_STR, &strioc_ppa)) < 0) {
         error_report("Can't assign new interface");
+        goto fail_tap_fd;
+    }
 
     if_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
     if (if_fd < 0) {
         error_setg_file_open(errp, errno, "/dev/tap");
-        return -1;
+        goto fail_tap_fd;
     }
     if(ioctl(if_fd, I_PUSH, "ip") < 0){
         error_setg(errp, "Can't push IP module");
-        return -1;
+        goto fail_if_fd;
     }
 
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
         error_report("Can't get flags");
+        goto fail_if_fd;
+    }
 
-    snprintf (actual_name, 32, "tap%d", ppa);
+    snprintf(actual_name, 32, "tap%d", ppa);
     pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
 
     ifr.lifr_ppa = ppa;
-    /* Assign ppa according to the unit number returned by tun device */
-
-    if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
+    if (ioctl(if_fd, SIOCSLIFNAME, &ifr) < 0) {
         error_report("Can't set PPA %d", ppa);
-    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
+        goto fail_if_fd;
+    }
+
+    if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0) {
         error_report("Can't get flags");
+        goto fail_if_fd;
+    }
+
     /* Push arp module to if_fd */
-    if (ioctl (if_fd, I_PUSH, "arp") < 0)
+    if (ioctl(if_fd, I_PUSH, "arp") < 0) {
         error_report("Can't push ARP module (2)");
+        goto fail_if_fd;
+    }
 
     /* Push arp module to ip_fd */
-    if (ioctl (ip_fd, I_POP, NULL) < 0)
+    if (ioctl(ip_fd, I_POP, NULL) < 0) {
         error_report("I_POP failed");
-    if (ioctl (ip_fd, I_PUSH, "arp") < 0)
+        goto fail_if_fd;
+    }
+    if (ioctl(ip_fd, I_PUSH, "arp") < 0) {
         error_report("Can't push ARP module (3)");
+        goto fail_if_fd;
+    }
     /* Open arp_fd */
     arp_fd = RETRY_ON_EINTR(open("/dev/tap", O_RDWR, 0));
-    if (arp_fd < 0)
+    if (arp_fd < 0) {
         error_report("Can't open %s", "/dev/tap");
+        goto fail_if_fd;
+    }
 
     /* Set ifname to arp */
     strioc_if.ic_cmd = SIOCSLIFNAME;
@@ -149,32 +163,45 @@ static int tap_alloc(char *dev, size_t dev_size, Error **errp)
     strioc_if.ic_dp = (char *)&ifr;
     if (ioctl(arp_fd, I_STR, &strioc_if) < 0){
         error_report("Can't set ifname to arp");
+        goto fail_arp_fd;
     }
 
     if((ip_muxid = ioctl(ip_fd, I_LINK, if_fd)) < 0){
         error_setg(errp, "Can't link TAP device to IP");
-        return -1;
+        goto fail_arp_fd;
     }
 
-    if ((arp_muxid = ioctl (ip_fd, link_type, arp_fd)) < 0)
+    if ((arp_muxid = ioctl(ip_fd, link_type, arp_fd)) < 0) {
         error_report("Can't link TAP device to ARP");
+        goto fail_ip_muxid;
+    }
 
-    close (if_fd);
+    close(if_fd);
 
     memset(&ifr, 0x0, sizeof(ifr));
     pstrcpy(ifr.lifr_name, sizeof(ifr.lifr_name), actual_name);
     ifr.lifr_ip_muxid  = ip_muxid;
     ifr.lifr_arp_muxid = arp_muxid;
 
-    if (ioctl (ip_fd, SIOCSLIFMUXID, &ifr) < 0)
+    if (ioctl(ip_fd, SIOCSLIFMUXID, &ifr) < 0)
     {
-      ioctl (ip_fd, I_PUNLINK , arp_muxid);
-      ioctl (ip_fd, I_PUNLINK, ip_muxid);
+      ioctl(ip_fd, I_PUNLINK, arp_muxid);
+      ioctl(ip_fd, I_PUNLINK, ip_muxid);
       error_report("Can't set multiplexor id");
     }
 
     snprintf(dev, dev_size, "tap%d", ppa);
     return tap_fd;
+
+fail_ip_muxid:
+    ioctl(ip_fd, I_PUNLINK, ip_muxid);
+fail_arp_fd:
+    close(arp_fd);
+fail_if_fd:
+    close(if_fd);
+fail_tap_fd:
+    close(tap_fd);
+    return -1;
 }
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
-- 
MST


