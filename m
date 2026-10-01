Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164D9CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOA0-0000Ra-NN; Thu, 01 Oct 2026 17:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xCO9y-0000N7-FC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:17:46 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xCO9w-0005yA-3z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:17:46 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso7865265e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790889462; x=1791494262; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LJrM2zHJE0bHSadqxaKwcktCdzBCY82pB6AzlRB6GKg=;
 b=ENHyWyP5rZ663xXRhUI1rFNefXuQpcxqtFkDjLveXWLG3r3qZmKFjvFU+Pkc0C5wSQ
 JogBL7EYYaiFbM5rlFi8z34+qVPidGN0tPa1rjoE0Cfr7UVEmI+bDQ1GPqFXrhpeIpWV
 SkFdzGdZwYh+pUBhhVNqI1hMxUv0Uar+oExXbX0KwYhuYGhXzBldLl78QtNDTAV8QAip
 H+A8s/qDLvSYRndZO8Mar/xxzaawZ0NfXqjI+MrjP+ieEZG0Cj7oWsIC2NctFJxG1ylT
 +l3KPru4AkEVUl0VpfRp0LjbrenJZ1dxS+Ina0b6zWTl1d7fmgwGUWAaIZoqUrWlnMyK
 LNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790889462; x=1791494262;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LJrM2zHJE0bHSadqxaKwcktCdzBCY82pB6AzlRB6GKg=;
 b=s8jMoTE6qhVQwR1/WmDcEPOWpSgf6cRCCtdQ9G3s0m26Qsmy2lQWxWo7ekWQflOojw
 LE1qKQTtDe/kGaPTv1moPqabW7LR87zG6oz/5wseVrglgzCOHdfoDppyQc4y/ZulQLqG
 4WdyElWm1Tv+sZcAGdqeqXvwXjLvhNVjy2btD/iNCVmle19h04AstS6vG0eecOX8BtCr
 JqUOKlx1+ILmEc+Sd8HfbbPn4ZuzRUXH0x2fx4iynGjAZqlGxJ+Qv6az3nYukssWElVp
 gNy8KZPqgeIPxErxWqiPF58ENyXBGuICZfpHLcgc+DnI4ayTELhrH+Qd6MVZXRbDYGQj
 nKiQ==
X-Gm-Message-State: AFuF++klK2o4JQ4lgQfxHY8fQIvzVY9KnaJ9v30ClAIUgDyc1qZBKO4N
 cMn4Qb8bSvCqXFxPrUTs/sceOVhuKHFNvtXzbro3zWsCnykjrx2GPrSE
X-Gm-Gg: AYBFou32MItkxICTzSf8MSG5Z3uzYwc0rGIaS1AOlAlrfmDeHlysupdum30PBDz1HMb
 pvJJ6e2G1wZz8EO+qlmYQMWaD3mJuIb2xBC99s7sjnK4n+sbvRFLtdoHwgtauocPfeFZKFJ904x
 Bk4d8jNiSDO+y/wpKzG5/4SiLRhUBEuZUClLYujNq9SjX1tOLpFeLdxsRsQ2aaMEFBujwqOczot
 VTlInjntSXk1okXdMy7apTS1k+vZMDCPzJ4hVx6UArLiqwYxIcSK5fXa31A3YvJkpfVaMkSb3x8
 Ovwfp09AwRslTsjgG5ZGJxEgVOBgscI48kre32e3U/3Hdzf8tKqSWj1zLmyIDRH/nF3DZToHrkg
 83NKX5ArfUNSEipC0ZGILv0nBsfsBXBLchYXTDvJN5Vp0OpC5ZppTWddF6+fEvIif63oN8WALfy
 bsXuh3tS472kjqHh/GeCsPdYXf+lRKST28FzeFxcIXQNpgNLU0mzn6lnZIS0qp0UgKKbMRuyobs
 6yOjUCwahqHtNTIiDpgnPsH0PPIov7Vavylu5R8jjvsTrfcZLVA/AsrxjiAVhdghozmX0XUZVVT
 htyJppYZpWuxefAgiR6C7U55zpvCkQs/XNz9sbzl
X-Received: by 2002:a05:600c:3e1a:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a027559e29mr12171665e9.16.1790889462067; 
 Thu, 01 Oct 2026 14:17:42 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-6629-ec00-3db8-be4b-50ee-6c68.310.pool.telefonica.de.
 [2a02:3100:6629:ec00:3db8:be4b:50ee:6c68])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027734b49sm19825835e9.10.2026.10.01.14.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 14:17:41 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 01 Oct 2026 23:15:41 +0200
Subject: [PATCH v2] net/vmnet: Add host address options for vmnet-host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-vmnet-host-address-v2-1-6de517697453@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jHQAA2u/A/Doo8p1Ag1ndpoC
 P8u4N7lSc49dwGm6InhUiwQKXv2Yd5AnAowo5oHQm83BlGKtuyExDzNlHAMnFBZG4kZa+lcYzt
 ljdawDZ+RnH8f0Vv/Y37pO5m0l3Zj9JxC/Byvudq9vwe5wgpbR1rWTgppmuswKf84mzBBv67rF
 7jYPJrGAAAA
X-Change-ID: 20260927-vmnet-host-address-47ff5d9adcbb
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=timpambor@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When a vmnet-host interface is added to an isolated network via
'net-uuid', vmnet does not provide DHCP, and the host side of the
bridge gets no address, so the host cannot talk to guests on that
network without manually assigning an IP address to the bridge
interface after QEMU has started.

vmnet provides the vmnet_host_ip_address_key,
vmnet_host_subnet_mask_key and vmnet_host_ipv6_address_key
properties to assign addresses to the host interface in this case.
Expose them as the 'host-ip-address', 'host-subnet-mask' and
'host-ipv6-address' options of the vmnet-host backend.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
Changes in v2:
- Fixed spelling in the commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20260927-vmnet-host-address-v1-1-6feb74f727c5@gmail.com
---
 net/vmnet-host.c | 35 +++++++++++++++++++++++++++++++++++
 qapi/net.json    | 15 ++++++++++++++-
 qemu-options.hx  |  6 +++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/vmnet-host.c b/net/vmnet-host.c
index 49fb25c224..8ed7ee9d41 100644
--- a/net/vmnet-host.c
+++ b/net/vmnet-host.c
@@ -41,6 +41,26 @@ static bool validate_options(const Netdev *netdev, Error **errp)
         return false;
     }
 
+    if ((options->host_ip_address || options->host_subnet_mask) &&
+        !(options->host_ip_address && options->host_subnet_mask)) {
+        error_setg(errp,
+                   "'host-ip-address' and 'host-subnet-mask' "
+                   "should be provided together");
+        return false;
+    }
+
+    if (options->host_ip_address && !options->net_uuid) {
+        error_setg(errp,
+                   "'host-ip-address' requires 'net-uuid' to be specified");
+        return false;
+    }
+
+    if (options->host_ipv6_address && !options->net_uuid) {
+        error_setg(errp,
+                   "'host-ipv6-address' requires 'net-uuid' to be specified");
+        return false;
+    }
+
     return true;
 }
 
@@ -77,6 +97,21 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                   options->subnet_mask);
     }
 
+    if (options->host_ip_address) {
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_ip_address_key,
+                                  options->host_ip_address);
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_subnet_mask_key,
+                                  options->host_subnet_mask);
+    }
+
+    if (options->host_ipv6_address) {
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_ipv6_address_key,
+                                  options->host_ipv6_address);
+    }
+
     return if_desc;
 }
 
diff --git a/qapi/net.json b/qapi/net.json
index b46af1fdc9..38b43d20ed 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -795,6 +795,16 @@
 #     is allowed only with other interfaces added to this network
 #     identified by the UUID.  Requires at least macOS Big Sur 11.0.
 #
+# @host-ip-address: The IPv4 address to set on the host side of the
+#     interface.  Only applicable when @net-uuid is also specified.
+#     Must be specified along with @host-subnet-mask.
+#
+# @host-subnet-mask: The IPv4 subnet mask to set on the host side of
+#     the interface.  Must be specified along with @host-ip-address.
+#
+# @host-ipv6-address: The IPv6 address to set on the host side of the
+#     interface.  Only applicable when @net-uuid is also specified.
+#
 # Since: 7.1
 ##
 { 'struct': 'NetdevVmnetHostOptions',
@@ -803,7 +813,10 @@
     '*end-address':   'str',
     '*subnet-mask':   'str',
     '*isolated':      'bool',
-    '*net-uuid':      'str' },
+    '*net-uuid':      'str',
+    '*host-ip-address': 'str',
+    '*host-subnet-mask': 'str',
+    '*host-ipv6-address': 'str' },
   'if': 'CONFIG_VMNET' }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b..9e250ad196 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3137,11 +3137,15 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_VMNET
     "-netdev vmnet-host,id=str[,isolated=on|off][,net-uuid=uuid]\n"
     "         [,start-address=addr,end-address=addr,subnet-mask=mask]\n"
+    "         [,host-ip-address=addr,host-subnet-mask=mask][,host-ipv6-address=addr]\n"
     "                configure a vmnet network backend in host mode with ID 'str',\n"
     "                isolate this interface from others with 'isolated',\n"
     "                configure the address range and choose a subnet mask,\n"
     "                specify network UUID 'uuid' to disable DHCP and interact with\n"
-    "                vmnet-host interfaces within this isolated network\n"
+    "                vmnet-host interfaces within this isolated network,\n"
+    "                set the host-side IPv4 address and subnet mask on an\n"
+    "                isolated network with 'host-ip-address' and 'host-subnet-mask',\n"
+    "                set the host-side IPv6 address with 'host-ipv6-address'\n"
     "-netdev vmnet-shared,id=str[,isolated=on|off][,nat66-prefix=addr]\n"
     "         [,start-address=addr,end-address=addr,subnet-mask=mask]\n"
     "                configure a vmnet network backend in shared mode with ID 'str',\n"

---
base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457
change-id: 20260927-vmnet-host-address-47ff5d9adcbb

Best regards,
--  
Tim Pambor <timpambor@gmail.com>


