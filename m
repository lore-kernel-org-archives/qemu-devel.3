Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD9606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=JNz3PNKU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VRrL+EUh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThC1-0005Q1-5o; Wed, 18 Nov 2026 10:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThB1-00052i-V5
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:29 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThAz-0003N0-Pp
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:23 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 06FAEEC0AFF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 10:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014141;
 x=1795100541; bh=K+BI1AxWrp7G3ieV3bXw1U9T9+MSMVqF+RKvEfWHmNI=; b=
 JNz3PNKUuJkj0keNO22OMHFuoJLg5du4olcsUEfkcHs363BbvOJYDsSk6X1rzyiF
 H+StB3l7uJYCAjaGKb9krfAjnU2Ky/2jyBMeW6nPgvE4YDpKxzkpMd0qEn5ratnb
 kD3hbZcRZpHy0FUKPvskdqgZjGJ49Q5cMOMze6QmXlgsej32tCer+zQMZPXpP/U8
 gvgm+AntG+jefLBcEQgE3KlCy3OuKp6tLSniBtSqDIjQcu3Gg03W6qGX7TLlBYY/
 VfUgp6kuNxcQsjGx2yvOkH7jrhfFGU+Wpeyb5aVgr9apJJlMx2BohpAE9EHcHxpq
 V2PSNEw8uY3x2JZhaw9AGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014141; x=
 1795100541; bh=K+BI1AxWrp7G3ieV3bXw1U9T9+MSMVqF+RKvEfWHmNI=; b=V
 RrL+EUh20R4BuhgjkJfnV1TD7MHuJhsIaQpQzSeZQuy9F0Ousxte0o71ZAtJe5Hj
 2v5uiTGolPmK9MdkKvngdUKiwFlvR+OPeZcS58gni1zSosGpVvtlaRu5dv9ROaXA
 j1xG2Ccox/i9rByLwvWfmWkf7B4F451EALzp6+pYatSWi/cft6Q7aQgWuxVCFzCD
 /6wHGcA/tOgmTBFVe4nQ4tm3uCPXchboTqJVdGfRszZQVumjtyaFr42Vox1r7ckV
 t93BZeXF42CwAh2BOTek9IqNbCAVZU+azn8INHDJfbjNRbIQpJWA9e66VFprfLMg
 kca1TclAoXPTToG8TPOjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014141; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:FCaJ5Y/z7XCBeD3Aw3frM0B2zcusCWGog74FppzB8wkOuMG
 tFvDWBmhnK1YtPtwuNHZ1vL5xIxZDvzRD0dSxF0ZWwlZ1lpK8YxuwMuTSGh9y7vk
 A1sWIu6QxgKLKqog+ZIdzGddAsFsXUnI/HwYwuXQk287hnZykXd7DoFOO2AqO9T5
 U2uDNsFW/TYL7eKASd32KV18dxQLHAIKSuFDYt910vSOL4+sV0LTtYSuJ6GtbmKc
 1kMxdOrHaoKZx9wuWiTjg/sE6U5C5hT76EIKeUQSTcz5m7tDs5uHy/ne/nSOCX7G
 byYwRoCoBvOJqv0SGnxJ8Rv271Z0IHJcEtMofxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:tng5x4MjFQNzpschSQqnWasoBi9emkbpvvll8pKfRoQ=:gIdko7ibWUarwBIgfETABeIW0OCbjp3OZitlczHLgFo=;
X-ME-Sender: <xms:_L39apTwJyF0iHNcP9wSFRe0fFcy6OqDjz6n46gPBEwTpElZKvsOAQ>
 <xme:_L39arvAkiSXuTwmOaHDWzWY7aLAIZFNxSo5wYaI70W1eD0_cQrEbTHLQwjeUeTHE
 5F6lrPc5X2y5sSZJMXOil1yzyhzLQATzO2K6wddHQOf5iUhFt4lqP8>
X-ME-Received: <xmr:_L39aqZZQZjSR-wzb0gaeZUtUIkETcQHjTPJB6jt79CVl8YANkr5APRYI8dPz9Qlznc>
X-ME-Proxy-Cause: dmFkZTEb3vsAhEsk+czLgVLgpYCRht1vdkohoC7UopAIGj3NwdEa7iroZHyj5SkJgWMtSZ
 1c5iEYe4KFRrorvYenfcw5rGx9fJswQlfcMx/rXj9OF/wAw/8kM5R4Y7lXuXMtjHgVNeax
 GnG6V0FQcnP2B9HFSsEUm+VJ35DFfhZIl7EdN3F+3VZ3qRRt3eVBGMqvOC0SNQ8MGyQpDJ
 rWjg3WbD4EDdi9ec2CaU2k2YVfj8kprsW3Yf5bJYnpOqh5fhzwTusvnWXuPgX3CP+xi0yO
 eXCKUtwgyyRkd3Nt1POKvbeUAKm/VTGYmXQbkstcjsd90jXGppRUMoAZM6LjQ8bSFYpMiC
 CJ4bgtE+v17VkXfICusBbwiezg9zHE9UJkGuJsQ+mmdACYn4bw+Miz7SDaAWBwYOFhiqSL
 Xn8PHvlA0uW5a9r3OSwiIJQ791FEFAnG5nops+qaG0tu6ro+Ntr7E+y7AzNMHf73haNOBc
 LGcu49a9WduEwIBRL23/ln0/ovdWtS+Zd/GLO4LmygAUGr9miTny5xX3fvVPmLriAZsD8q
 5XXga27P34axnHRXyEDRYHTRqvRj1EaAa7fzDsjYufCXDajbR72PHYTrbo+mrWRPxUhP5m
 zrwHlFp9FLbQWQaEmHj//d42RHS5zz88UYVFkac9shaB8OSfiFa48HsXrZAw
X-ME-Proxy: <xmx:_L39ahGR1xqppievqgSdqvMNBfJLmOVVd7C8gtayyd2wwVM1eBTB1w>
 <xmx:_L39auxkjdwybysGLTZ8b72Yl9qHdNaD3s-P7207vt_mszI-K7leXw>
 <xmx:_L39ajlwXYbfXLh__NAPbozmJcLU2Q4LcfGOmX6EJBAUpILh5EQzHQ>
 <xmx:_L39annNnXHwKate4PhsbH0SpdBb9gv0rK52WbH5ww3BdhrBIpB9ww>
 <xmx:_b39au0wBKG7Mt7ByDgWoQV2ho5g6WGP-Q_mkGhwZziy_7Xm5iqswYZW>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:12 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:29 +0100
Subject: [PATCH 2/7] hw/nvme: get feature - fix and revamp NS/NSID checks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-2-ed76fad7861d@samsung.com>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.146; envelope-from=foss@defmacro.it;
 helo=fout-a3-smtp.messagingengine.com
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


