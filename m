Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BAD1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpM-0001hQ-Eq; Wed, 03 Dec 2025 13:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpJ-0001gM-0w
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:45 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hH-86
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:44 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3HwA98876566
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=NID9cQ6TVR/7DxrIYOVpRG111sFYubPS/LHG9jXZ0ns=; b=Nb/jlPZNGw8h
 7z8T+D6oZoqhXMfYlBgNnz1UKCLOA5aeUtEzmD4ZP0spnKYAgUXVUE2GYOFz1CTx
 Xs8uC4CNJ0heCAK/zUFUQzbq1eqhRg4taNg1tbReWiWmKDIWqjTYh4Ykralq0DCT
 LyhrkCUFjW3aLyPZr0TJCmCGIbXZQmrZ0NrRPocJLR4NV5ky9Z8pIVeOGcSgvqOs
 LE+d5BWvX0FQ8RJ6Q98JaXjcdBRwBv4hNbJx+JKmCdsTMX7jT7gHEhcup1k3bSAe
 9G1Rh8hIA5aPb+tSBh+w9x5tZOrEir6YFuU/WcYdeQP1rCKWE8Smp/XLllkAHO4N
 u4s9Nyk5LA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aspcaad5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3GDt0q030112
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 13:43:38 -0500
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4aqw21m40e-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:43:38 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 481E595
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:26 -0500
Subject: [PATCH v3 5/8] tap: common return label
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-5-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=5311;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=C43PerSzdOjLbyjnfYhRXVpakesxZD1fRN+2JrhKpv0=;
 b=Zhk1leRkT5uThxIPptYwmf8rzVR/A99p8c5Hxzw4jiAU5gwcr5z0T5xzRtkI6W8QkdLHi4aMe
 8RC5el1HcScC45qvQEr7eB7O6VNhbvCLDYd23+UbpEl5/T7q9xxhZZy
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030146
X-Proofpoint-GUID: 12xyh9CYjLd_UOg-yjXZ5_bA21boCoNI
X-Authority-Analysis: v=2.4 cv=c5umgB9l c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=zPeY32rCmRbJBjnbAY4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 12xyh9CYjLd_UOg-yjXZ5_bA21boCoNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX1+lpwHw2irPk
 xJEVaXbLqdnyyT+IEUzS3J/UEAH3OubwpMUz5dIU9kZTKqzvr2SdpFFetGxnsuknlptGsZIGu2R
 g8SaSGKPlimT46VclnXeBeH+17wiCEPF0dBfCDQujNPNJYlEduw6bimXBHOujR5xlhEO2SJXa0Z
 DaNL7Hk9ZeiTQX8vgg4iEpDDIhUrlAkLf0dZTzjKV+Sm1jUlYiRPWky2ioqeIdpcAwP6SZp+ml+
 05PokBj6IMT/XnYfRuon5PCPwJaCeTTsjny//LloSikziV4bfqTxeWGOO/4fVvlJ8gZyebFH8DB
 k0qiyx6IkA+d+XHcl0KaB6aJapyaWkeujjBPSzBCMHumLqx+dCDpPX6dsVTiqhUpOsczrvx9gTm
 kYPtpRRBI6r7BjiADZC8sxOE9KvL+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Steve Sistare <steven.sistare@oracle.com>

Modify net_init_tap so every return branches to a common label, for
common cleanup in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 55 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index abe3b2d036..9d480574c3 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -830,7 +830,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
         error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
+        ret = -1;
+        goto out;
     }
 
     if (tap->fd) {
@@ -840,23 +841,27 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, fds=, and vhostfds= "
                        "are invalid with fd=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
@@ -865,7 +870,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else if (tap->fds) {
         char **fds;
@@ -878,7 +884,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "helper=, queues=, and vhostfd= "
                        "are invalid with fds=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fds = g_new0(char *, MAX_TAP_QUEUES);
@@ -940,29 +947,35 @@ free_fail:
         }
         g_free(fds);
         g_free(vhost_fds);
-        return ret;
+        goto out;
+
     } else if (tap->helper) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->has_queues || tap->vhostfds) {
             error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
                        "queues=, and vhostfds= are invalid with helper=");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
         if (fd == -1) {
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            return -1;
+            close(fd);
+            ret = -1;
+            goto out;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
@@ -971,14 +984,16 @@ free_fail:
         if (err) {
             error_propagate(errp, err);
             close(fd);
-            return -1;
+            ret = -1;
+            goto out;
         }
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-            return -1;
+            ret = -1;
+            goto out;
         }
 
         if (!script) {
@@ -999,14 +1014,16 @@ free_fail:
             fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
-                return -1;
+                ret = -1;
+                goto out;
             }
 
             if (queues > 1 && i == 0 && !tap->ifname) {
                 if (tap_fd_get_ifname(fd, ifname)) {
                     error_setg(errp, "Fail to get ifname");
                     close(fd);
-                    return -1;
+                    ret = -1;
+                    goto out;
                 }
             }
 
@@ -1017,12 +1034,14 @@ free_fail:
             if (err) {
                 error_propagate(errp, err);
                 close(fd);
-                return -1;
+                ret = -1;
+                goto out;
             }
         }
     }
 
-    return 0;
+out:
+    return ret;
 }
 
 int tap_enable(NetClientState *nc)

-- 
2.34.1


