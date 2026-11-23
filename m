Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E9606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=lFooIn2t;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B80SyuV1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcG-0001nG-53; Mon, 23 Nov 2026 10:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbK-0001Lh-Ks
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:03 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbG-0003gS-Ir
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:00 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 46D5314003BD
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:04:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 10:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446296;
 x=1795532696; bh=K+BI1AxWrp7G3ieV3bXw1U9T9+MSMVqF+RKvEfWHmNI=; b=
 lFooIn2tx+c/GziWkd506oxzxrAaLmrkorY1DClc7Lv53FUGBVPmvdqs7QLKv82/
 As4bUD3lXtnlsYBcxNdozIb3fOj/4Rp8OOBFmUdUYx6wREWVU/PCB/xPiMXYcsGR
 sIHZMVR3cjWfTi6aiIc1Lm9Ec+Y0my3oF298U/THEjTeQ90TapHQtxzEVaZRriau
 AqT/Lh0JwPVyPCJ/tP+q/i907mojfjYnuudD4b0Z48zUXgLM/R7ScXBQnGTBPsvr
 fvLIIopzwr8Z97PtPnxFAVQ6Nweply73PyZq3zE2VmZZ89QhgQsQzLYu/94RRhHD
 Thbza/3e8LAO26LohI+vXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446296; x=
 1795532696; bh=K+BI1AxWrp7G3ieV3bXw1U9T9+MSMVqF+RKvEfWHmNI=; b=B
 80SyuV1h4KtJQ0gPuJ6gCgyUAWKXlqJverLb+YwIwk2+wXi6DFWngfo5xB2VylF1
 alfSZb0Q4tBEJnorJzgmDrYLENpdrVlrRVc5Z+iRU3s8J7YJt9+8b0OL/oXv6ewm
 /NzHbfWWZ1ygK9e45wONjlf6GJPcBhdcALawqjxHU1bfgyqYUbj5hybm3hBch2SB
 9BhPN7Tlk3QCooeErfbIPJgXSCfjH+8G4lAjfcHg6K3/M4N4oHRNODCt5+s1ZgQ1
 gHbHCsoPyaFPpWlR9ojNzaTo2O0Mm0K8uA1kGZb7jnpyzICSxx9xArKcs/IUrewf
 w4Md7ua+1xJwbB/XkS+Gg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446296; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:GCy9+aifGpSZP4byoL2lILn4Qr4mOdqCjsvECRP+0wybxn0
 AO0/GyPC+jelsVCWBbSuIptK1eXnbLVshnJ1JUU6jZvObaCUplio9bXjimrTNU6e
 rylVNO4qJ04CK/kCcom4axLrQN6QZgEsHdZ4jCvFZg0APej5BHwYTP1717sy61Bo
 CXqwkX9BPsL52oX8ZvrieRsueWoXUa4jChJV3plu4NvTe0xLZtF1aRhtrAGTNsqb
 GjuGQEsfxYTMwfq89fbIW8WjugQxFInNMzhUo3vkKyt0kCiAuqFEKW30PKcNw442
 ojSAI6voOrgFftGk9YypKtXuOY8Gs1lix+XMWbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:TuItl3nj8BuuAbb/+6Kh8IhY6W2ONZFo0Pt+JU1VG24=:gIdko7ibWUarwBIgfETABeIW0OCbjp3OZitlczHLgFo=;
X-ME-Sender: <xms:GFYEaxDz65T_9klLppWkznqbzOEpcGkZcsi8-fxha087hXHaOFYmtQ>
 <xme:GFYEa_-TOGlEPXzpQhg8FOK2OlUQ-FUVdIBdJS4Hg98NYFNRNvvxT4fCKizsjbZn4
 tK5JczMwYSdb35GXFcNSj9LD7gOBXW7xhumlutdAGtTQbRrAH9gBXKO>
X-ME-Received: <xmr:GFYEa9QZKfyBmb7Le4a9CdnEYuu80jBAR7N6hBso5A7SYP_fOwjR_6K6wwJMnNRxXID0nJVsWgI-SlwHZD3Iufq2TVDIo-Qu7UIw>
X-ME-Proxy-Cause: dmFkZTE+oIySUTencSDrezjdlYlA3KRh/B+gt/B7pvsu4MYYZUmi9LXvi9Ffrqz4t56wFH
 eDEN1nNdacz5DD1luGTgKjOqmCi06+6FPKXqnvYVkitPCyyh5BZizsVnUsjbYqWs7QIb+m
 KHSxtZhJEfsjm2cF5L++Mi7A+djysq2nH/FN84chbpJMoWKoEui2Lm3b3ikSnZ5VKaUqbI
 nwmFM4Ie4ZaT4pNhF1HIQWpJZ9q9IkC/OfP7nGHsmxwKnRtVil+fcHNEgWhQG+7qx11qUr
 3uSsMPiQDMStnjDIePLvIjHwJ8aCzUSJ50KHyZNdCVN5tVRmohrAi9u15+uOtwQMfFJ0PE
 HciyxYfnEkcHBbPdQBpjqG/+58qpYVLskNiD/PHcya6EC8dRBSX1iBf9g4vB9VLK9ZSVsQ
 6tA46cnTPym+lwnIK1rTYU5BDRNf+9UvyQz1wW01Rtcd4OQtyC525XRDSk2kC7IkqaPK6S
 vEZ3BrwrgZqLGmxgu+Ct8SR3RR+hdljn+F6wUUcPKJ66Kdh7DtBNSoWpeLe7GAvDhPX620
 vTx99KzTsnUPfKFOun4K9NnPRiVm1sFRHYRVc4jDuQAsRyaN53ydELIDC97zDGCri7nTlW
 kTgCAtkwgZJhW+eoDFvVloMy6cbZ7ShBmjmvePv/xSgFVWH5B0cF0cIJXDdQ
X-ME-Proxy: <xmx:GFYEazVe8GmAY2JzQ29-x2usEamLmc9pTudYAj9V0MKme9Dj3Eq3yA>
 <xmx:GFYEa3TzfVLQkYA6H9CXYBwEM15GKVCmRsPe6lhWQwMToI7oTBvXSQ>
 <xmx:GFYEa73hv3_gozkg9B0cjommFaD7VXDVnGVYSz-Q9-FBibbrVa2aGw>
 <xmx:GFYEa3fD3CUL3XCVF8V6bmS9AEJeW4UbA_ITGwbTAVTEaiJfww7keg>
 <xmx:GFYEa2IGvDXKjl6KnEtPG3eak6NWpt8VKlafMfMxv056anlwCUwdiWhc>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:04:54 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:49 +0100
Subject: [PATCH v2 02/12] hw/nvme: get feature - fix and revamp NS/NSID checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-2-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.155; envelope-from=foss@defmacro.it;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jesper Wendel Devantier <j.devantier@samsung.com>

From the 2.4 Base specification, section 4.4 - RUH-scoped features'
get feature command should return Invalid Field if NSID is set to
the broadcast value.
NS-scoped features' get features command should, unless otherwise
specified in section 5.2.30, return Invalid Namespace or Format.

This patch
- reorders the checks
- ensures FID 1Eh (FDP events) correctly abort with Invalid Field
  if a broadcast NSID is provided
- handles this special check in a switch-case, to provide for
  other special cases - such as other RUH-scoped features or
  exceptions from 5.2.30
- saves the returned `NvmeNamespace *` from `nvme_ns` to `ns`
- removes duplicate checks for NVME_ERROR_RECOVERY and
  NVME_FDP_EVENTS

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ee670481876..c8da01f11d0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6436,18 +6436,26 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     }
 
     if (nvme_feature_cap[fid] & NVME_FEAT_CAP_NS) {
-        if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        if (nsid == NVME_NSID_BROADCAST) {
             /*
-             * The Reservation Notification Mask and Reservation Persistence
-             * features require a status code of Invalid Field in Command when
-             * NSID is FFFFFFFFh. Since the device does not support those
-             * features we can always return Invalid Namespace or Format as we
-             * should do for all other features.
+             * Base 2.4, section 4.4, if broadcast NSID:
+             * - If feature is RUH-scoped:
+             *   abort with Invalid field
+             * - If feature is NS-scoped:
+             *   Unless otherwise stated in 5.2.30, abort with
+             *   status Invalid Namespace or Format
              */
+            switch (fid) {
+            case NVME_FDP_EVENTS:
+                return NVME_INVALID_FIELD | NVME_DNR;
+            default:
+                return NVME_INVALID_NSID | NVME_DNR;
+            }
+        } else if (!nvme_nsid_valid(n, nsid)) {
             return NVME_INVALID_NSID | NVME_DNR;
         }
-
-        if (!nvme_ns(n, nsid)) {
+        ns = nvme_ns(n, nsid);
+        if (!ns) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
     }
@@ -6489,15 +6497,6 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 
         return NVME_INVALID_FIELD | NVME_DNR;
     case NVME_ERROR_RECOVERY:
-        if (!nvme_nsid_valid(n, nsid)) {
-            return NVME_INVALID_NSID | NVME_DNR;
-        }
-
-        ns = nvme_ns(n, nsid);
-        if (unlikely(!ns)) {
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
         result = ns->features.err_rec;
         goto out;
     case NVME_VOLATILE_WRITE_CACHE:
@@ -6536,15 +6535,6 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         }
         goto out;
     case NVME_FDP_EVENTS:
-        if (!nvme_nsid_valid(n, nsid)) {
-            return NVME_INVALID_NSID | NVME_DNR;
-        }
-
-        ns = nvme_ns(n, nsid);
-        if (unlikely(!ns)) {
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
         ret = nvme_get_feature_fdp_events(n, ns, req, &result);
         if (ret) {
             return ret;

-- 
2.51.2


