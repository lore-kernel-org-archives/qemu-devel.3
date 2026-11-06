Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FE606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=EeBCNxMZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pMKNUzL5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLMF-0004Lc-Ep; Fri, 06 Nov 2026 09:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xPLM7-0004Kk-PZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:55:52 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xPLM5-0002fL-KW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:55:51 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0AE2DEC01C3
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2026 09:55:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 09:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1793976947; x=1794063347; bh=NCeSe9AFXM
 LBatbjBpQLmJla39RALTonc6fB7Vot9rA=; b=EeBCNxMZ8qzavkpW5E4G063StW
 r0oG49g0dQaLJgwfganKJSaZsSDc9u0iLxn4h1QvFGbAAZEBXN21zGXl6egPWugB
 U+rvI2PNuqUQGWBXlGPtfJoYS9MYzQqaDzppbin8lYg4QpeG93xqtjt9Asip0MCz
 8thK+Fld1vJIBAt1FxkXYHnwdXpniFpFWwEpAjcEKYF4bP9IetZHmsrEpj6X+CqA
 hu5YPtFQY0TnM7I7v3aFTbL/Z8vSGg+UZFiCVxwiIAK3wSEHIgqR+Z7gSHe8aF+s
 9emLbNgqvnN12YJpNUSdbJV+phs4jcQf+bxwcZxPQdidBb9Pt0JkozTCMNjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1793976947; x=1794063347; bh=NCeSe9AFXMLBatbjBpQLmJla39RALTonc6f
 B7Vot9rA=; b=pMKNUzL5mWO7FczbdS8nKFSfUL2r45pm5JwybGml7lIJ8Yxo6lM
 So1CYgGhnRcSFT0nS11aYoBh8N3xIqoJVup+CvLsKcpCNEkbxHJbqX0Vz04ZflJe
 V6dPejn9Qnf+XBXfvnjteaAKIxte95YEWn7AXq8sNx6CvdPuC8LgnUQ6MR+NqdEs
 vJ4Wfib30Fhjzq5xJi/KipyRE5C1UX0EFcrDjQuMpD2JmX9HJ/3lQO3+P/FIM7RZ
 r5DwjlZOXTjrt5GZMqVSO5it5+QlzsYRDOAZy2bHACuOgaa33qKO3106EFplyky/
 a4QWLt1e4knsbYepWgdc7MuaChXOoeQdzYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793976947; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:XHPXIwH9R6wbTJZtGFoZbvFW6Q2vq5++w8PaklwABK0NKXO
 co+d8UHFl2x+j/Pv0ZRj6vfX0kkSnahGheDJ0p6jMXodtp+fyib13I34rMydlNBo
 XhEDyjmMQNosvgFtPKX8w45ALG9ZJvxTQloGP09yLeSzQvXOnYULquM++IkSFkQv
 GEU/8qNedXZP7WVbbSzhXDIixhLCoDvpYP1zwNmoAJ02Td03LXQdOgs/jm2skici
 46GthJl47iDtIe8zQf/fs8z+xuXN49Ne3t19aOC9+504SYTTI7dEMlUrp2OLuCq1
 pmMQFbb3pjITTbrgT+Io9CPzaMrzAsSdKSO9mSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:vJFh57hmPaIkMLdMEOCa9pp6R8Une+doW4q6kfDDnKc=:WDbm9sM3miTMf9rsVs/kZ5+ZxZ1IOte2ltpZlhW+cWA=;
X-ME-Sender: <xms:curtau3pSnmm0aiD-UZsL7TQv1fheKmjqJW9T9Zg4qg7Xybv0VYsYg>
 <xme:curtaqDhiCNAv8xCdhSeLhk_1ss4FOcoVLPaKSBC3pJhMGd7ZfnEWVgLWHLRaJLdW
 PtljtSEb76zvrgZLgmwr6kWKcw6KVaXJHiKYWKsIAIpuvUKdjscBdtB>
X-ME-Received: <xmr:curtaicZtzFz-UZD1-hDy48THJPUr4UHFSAIkSr6JFeQyLKAPoTR6BJOgD8EZNUkkmObBswcV2zc4y44uK8x>
X-ME-Proxy-Cause: dmFkZTFg6iSI3bSOzPWPglMVAOtrgOrENwAYQW9rHYgZTv3ZQ+Rze6dZ6GogwYiHpZlxfz
 o4z30t/UyileYCOKjjbDuvfv721E/x9NChQTYwp8L20QmI5YGybgPY/g33H6F6zd+OW+9m
 swhQ1M8AM5DCulGaalw0chGqXx2yxvR3OrXfPQQHQaVcjsqa/04gOsqRvNzKbWhGPrrCnR
 TqKaWmUIEsiAmMv5RMQJ4QV0e8figl6d6Sb2i6GW+eFJxyEWmgTezCjj8oyzbrhih1lwZR
 Nyz8vgIvw/zYBFQ4AwG2KnHkAaigBEEr+UJqIAcV6k2JJUU/RRDVocp5OLvKlomOHSnYeN
 noqb57c8iF5NkmTuCdbCuQZtNOCFTYIUQTObz4mKgt7o06N487Ci2AiZySPIhlG2nN490L
 SdIfRR4MsBzUdj6EUWnDelz/gL+L1APx89TrVyKEFOBzrFE5oi+IbBFrOtf/j7kS6GHKFm
 9dhx5rk1d0BYYhFX0oxVimB8wXlS7dIhVJm2ZACvdI4FvQxmLvir5XoYhxt8jwrhh2APDF
 X2Vkn43ql07ats/9ApOt6+Puq1L2WxF7haNwE1Cev0bJLvCUZxlB8TjAvfLdyKoOQziT/M
 Kkv+/fF8TVib+jV28Bl7MIsb7xvZsA3IlzEPi0PbUO7aNOPcyq0p+IrA0LRg
X-ME-Proxy: <xmx:curtav4A9KSPR-pqfe-vJH4a8Cx_ZzcHezb23QjZcDuPyijup0sseA>
 <xmx:curtatX6s-ts-6L3ug8eVTawY4e9ZtO4zcIy972nXqFjkmjPkI4hPw>
 <xmx:curtam6aRuW74-5Muy3XI9oX65yXJ7KjndzTlCgugO_i3mbpbrhjXg>
 <xmx:curtagpkrDWnhB7c7GXX54vvpz2-mYZIlhQO7HOc4dh1epJmx_LdWw>
 <xmx:c-rtak7uZxYqtirs7IpCdnDwpe1aZs1lRTc7doRikWbQ-p4Hmwc3VA1i>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:55:45 -0500 (EST)
Date: Fri, 6 Nov 2026 15:55:41 +0100
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: verify source and destination lba size for copy
Message-ID: <20261106154416.0-foss@defmacro.it>
In-Reply-To: <20261021-fix-4173-v1-1-e8045545f954@samsung.com>
References: <20261021-fix-4173-v1-1-e8045545f954@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Mailer: lorebird
Received-SPF: pass client-ip=103.168.172.149; envelope-from=foss@defmacro.it;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-10-21T15:37:46+02:00, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Cross-namespace copy requires the source and destination namespace to
> have the same logical block size. This is not verified, causing a heap
> out-of-bounds write.
>
> Fix by correctly identifying the invalid operation.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Feng Xue and XGPT of ThreatBook
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4173
> Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 578421c21761..b48bf599b5d6 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3277,6 +3277,11 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
>          status = NVME_INVALID_FIELD | NVME_DNR;
>          goto invalid;
>      } else if (snsid != dnsid) {
> +        if (sns->lbaf.ds != dns->lbaf.ds) {
> +            status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
> +            goto invalid;
> +        }
> +
>          if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
>              !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
>              if (!nvme_copy_matching_ns_format(sns, dns, false)) {
>
> ---
> base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
> change-id: 20261021-fix-4173-d188c1a2ffdf
>
> Best regards,
> --  
> Klaus Jensen <k.jensen@samsung.com>
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>





