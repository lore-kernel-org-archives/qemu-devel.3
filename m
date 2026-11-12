Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D0606A336
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=KnU5TBSG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i7ESvbLW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXLb-000845-VI; Thu, 12 Nov 2026 11:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRXLO-0007we-V6
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:08:14 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRXLL-0000dZ-Ny
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:08:09 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0C5237A01C3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 11:08:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 11:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1794499684; x=
 1794586084; bh=hZqwhHB2CVXDmn/lG2qW8GqkezJQntwpEQ/slOfYUPA=; b=K
 nU5TBSGQf1T4kZ1SCpX5S3JyfB9XZHNPW65uic2oYGSStTnqSlD/YiyjfW7FPMmu
 nvGaYzBtc/Men41g2MKy+8D++yWv58U87E3WTMsdYzUU9VivgywamzeQT/kO4Hux
 4tEkIr+jSnMMDZo4LUL75ZDIe0xJslh3pZ7yuGREwOS/l1brhLEhuqVmY9y9ODC4
 aPZOkYPDJGqWzlAo07HjCn1SNpP2cEnxXcn6sJlqEEGf/F5x51iPfNcdvTdal/ek
 dVNPCb2zn3Y9nHNU10/kSdH6BhXuv4dDYP/TuJGamtqd213INdOfkrpzAfBQw1uU
 P+d2OrvF7yCz+IO8/WXRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1794499684; x=1794586084; bh=hZqwhHB2CVXDm
 n/lG2qW8GqkezJQntwpEQ/slOfYUPA=; b=i7ESvbLWSC7ZHUitE13F3xS1frYMH
 LH1CHnjVzAX6EJbvqczFWbQr0aj9IIZ58J9gxn2B9gtz9kn4ol8CXnMQOisqiEYC
 Jhl6zk1q45YyrKO5NGQxSXDo3pFwU1o8TxPmrAFvVHaj3Wg570JdEhXNHeizAlAa
 bfZLiQ1WzH0c4tL5Kt6xZJtT/9Lmdo18FMT5WFU+1vy52CS4uli6YeOEIzz71giN
 fHnfuLdO47NHYAOcBEDHnvMqK6Pr9o7Q616ayzn+rYCXP+n2Fp40up2Bv8c1eA4v
 WgPQhzX7k8fOGoH+xIwGBJBpodZGBRZMvZBN6IwV5cbc4kbPaN5Q+xEng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794499684; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:n3LFnnvzeAghicnEQ3B31lW28OLYRF9MW30zKPdjGLFzLau
 n+UpAEF0/Hd9DkYxTvmYh5NSmUocyxDnwHBcLFthPPFWgPD3vzeCKSEqLH6TqrOI
 BkFOLb01B9tVzakf12JLSkYWFGi3G5RSZM3zugh3NRRXUcjuEObxly7bVxtyy1pz
 9WCEku52dKCU58pudG0+GCf8S+u+8+fbI/lE+/HJq+JIQfCUVOe5GoyKOF2jgSUM
 BxqgIwAX5qstm36qabkW95eQSw+J2d69qElPpFMnUztCSGF2heXh8xQgYV6VdoUg
 nEuzle5W3Wx3//9y3HMs3x35b83/0M7M18FbxiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:uSYDfQLrEnm3mKk09p8tlIcEgaPLrYBaB6PytC38ea8=:uzMl7qbJHvhMRzddP76hI33Q7o9J5ay0as0gKrh3qxs=;
X-ME-Sender: <xms:Y-T1al45L-8W_F1bBHNy8dGvh0ii_oRMgMKBxSzyuY5LuTh6mXzF0w>
 <xme:Y-T1auUu5PnvIsH7SM_eCEE34AvnZ9Yns63bhOzD5ozV6P6OgABDHl9cNFN6ybszf
 cgksdXSCv6YNsbjcepxkR5cZEjekU41GivTQB111rygpZqW-f2VPLcg>
X-ME-Received: <xmr:Y-T1av_IUMGekQALv-tR8Y2o-D6jGT_vDGXZLRa2G2vwGZ_JeI7ArF2grMxQN3YP7DV2-Ehe2VwKbx9T1FzjFrctIw>
X-ME-Proxy-Cause: dmFkZTFi2ElymW9lnqMjYykLI/XeuR3D/m1Vogm/UCFv/PZgGgVC00CucioA+d2tjPD7nD
 HyeqaYMVs44MkkICOboRmKrmPhs7VreCDZLCzrq6/SfU+QOsN6gAz5VVxgTx5nzUS3ijRf
 JPRar0OFD9jlzpckDpVJIdtaE3v53msTRv7GDq63IEBpibyJeb/KmsnprGeEzv+Az3enH8
 WiUVyELNhBzpiBuA8WJZZsZKiYug8zk/qz+Na5WH2hxBcbBFyXQL9mB0pfG/ghxSCeBe98
 ZLlpZAwoy5BTQ8N5J1hbQ3MaoQHsadGfjPuow8FlLAftf7/2aPv/PcCI5S3tVkdRCHqLKN
 XG+fYhwWUrFOooKOnuQjNzNKP0FVydye13k6fdqg0W5wZIT/eHWumGRqzbYSuFz2OzLKhe
 mzZhzHGGPwRAVSw+V38aPMhmxM45Hy7E63/WVhQUPmTx2cv1B7xk3p5s2MMiDJ/2DTEp+C
 f/hFpKRgoCTEti+uvGFNWq3iPyQ98hlxZCyEvpjN/tvoufUWGCJHAI5doE9T9cIszHeYe8
 ODKosqeZyZMFxU7bYqB7k5XsKTtL/6KGxXf6LBixFnvAmG+jyld+5HXkAS7T3SB4+1u0nM
 WLUAbPIZ19PrB54kRMPE2jJZX2PV6qJ61mqCjuxt84NvKT1/VfwsejsddsxA
X-ME-Proxy: <xmx:Y-T1aimVO2zJ3RUOmGxGPAJNeBghpS8hCINhddbtBVC01uBcVAYO9Q>
 <xmx:Y-T1alXrP1BDGha8-oKwlEXfKIFrKPZ7wrWzKWx_dT0Rj2U2K4sx_A>
 <xmx:Y-T1anG7osY3p8L0wZV-JZalIr186PmjD5OYEglHBrA3849CkMhpiQ>
 <xmx:Y-T1ahcS88bPSIZfGc9qdvXbef-SF83R79k14uSE9RLnFE2cUC_DFw>
 <xmx:ZOT1ajPhr914FjsBk5Wn-sbYDILph4Vyco8RlxJuyJExpSOPQhQ0k3T_>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:08:02 -0500 (EST)
Date: Thu, 12 Nov 2026 17:08:00 +0100
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 2/3] hw/nvme: fix fdp reclaim unit accounting
Message-ID: <20261112165350.0-foss@defmacro.it>
In-Reply-To: <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-2-69b3e5dcd5c8@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0, 1.0
X-Mailer: neolore
Received-SPF: pass client-ip=202.12.124.159; envelope-from=foss@defmacro.it;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 12 Nov 2026 10:53:29 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> nvme_do_write_fdp falls back to placement handle zero for a write that
> has no Data Placement directive or where the placement identifier is
> invalid. However, it then passes the invalid placement identifier to
> nvme_update_ruh which results in no update to RUAMW for placement handle
> zero.
>
> Reset the placement identifier along with the handle in the fallback.
>
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 685cbc2f340c..a0d22dacedfa 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -3754,6 +3754,7 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequest *req, uint64_t slba,
>          !nvme_parse_pid(ns, pid, &ph, &rg)) {
>          ph = 0;
>          rg = 0;
> +        pid = 0;
>      }
>  
>      ruhid = ns->fdp.phs[ph];
>
> -- 
> 2.53.0
>
>
>

Correct.
Had to re-familiarize myself, but pid (placement identifier) is essentially
a 2-tuple of (rg, ph)  (reclaim group, placement handle).

NVMe Base Specification 2.4, §8.1.12.1 states that if the data placement directive
is unset/invalid that the write must then use the placement handle 0, but that
the reclaim group may be defined by the controller.

Setting `pid=0` is correct, but only so long as we also set rg to 0.
Perhaps a clearer way to specify this would be:

```
pid = 0;
nvme_parse_pid(ns, pid, &ph, &rg);
```

.. it more clearly captures the relationship between PID and RG/PH.
But the change is correct.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>



