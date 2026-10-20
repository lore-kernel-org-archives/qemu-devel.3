Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AC606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KdFifvu5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ8tD-00077e-36; Tue, 20 Oct 2026 08:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aF3XagoKCt0RS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com>)
 id 1xJ8t6-000774-07
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:24:16 -0400
Received: from mail-pl1-x646.google.com ([2607:f8b0:4864:20::646])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aF3XagoKCt0RS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com>)
 id 1xJ8t3-0003wU-Vs
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 08:24:15 -0400
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2e869e00005so35429405ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792499049; x=1793103849; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jIEy5cT5mmkkVcGKdpbeH8K331ZFV/0IWVEdNWVBdcc=;
 b=KdFifvu5P3t9nqZACED+plXDjUXoE13tb6ghqmsmDykhaUsNTiKbsbbtCXCs+jkv/u
 8qlPm/Fdwg9z8dykVexnpnQ9E03Y7gwADKP5QBiSi7g2RzgPLipKXNpnXcwilZWUit6a
 +eNEcarUsdv1PWoGb351vjUWuFNTIphR2b74rKQ+2o7kfOJLPtE8g+zD0CyDywAib42t
 3B2GIx1D6uVPUOGmfdCUUkp5o1YZ243APb6mC7u/Nw/jHd2Ct4R2o0aJ8+pFb6DxjxE+
 yeD7S8pM3w/Gs+5AbmMU8ZW+7sr6eisBlCTZ7DaQNwuyrvtWPnLmnzLIuImNA8rnY4iF
 ekeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499049; x=1793103849;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIEy5cT5mmkkVcGKdpbeH8K331ZFV/0IWVEdNWVBdcc=;
 b=LEvpVHM44S6MYJ4qdydyD4lUfiOWP2XGZb1uPpxPcPoHr/UlCFnFTMuGslx+ciH2ef
 EyWMzULE2f9zKsLoFuoZVAX/nZvVH2opfqr4zDu4A7veFJfyHiSqIWRveajrb1O3cnMW
 S3s6GKjpDkR6mPzW7un9bqA3UGqiysLDCWrzkSE5T3NhDTvuJ/1eghaSgs7y3l/YN/aj
 Ifup9LaOqm6Cl+dMjed/TOOR42f74j0HtpZI0OeqmbaO8OuQF5O9B9SBYf21tnoSjGLS
 77QFJRjWfqAaZu0zDC8ydw/6SSONHwr3yItQaB3uSNxCe45ruOaHeunblV7SAkjPUC8/
 A5Qg==
X-Gm-Message-State: AFq9FYIbNdp8RgmpYXy2XR2XIafOQnaZFc73yswfBW38b7TqMByLfO/D
 ne3dcoqrkSk1l6o67VGtNaVESW7hyUGIbC3FWy2OB18utjnBvUF7h+HyRi7jNeSWOWipYsDRYgx
 OaYgmabTaUaxfjIv1MyKyO++kETF8bn5eQh2gcYzxIh5FZ9J0tUVa+1aB/zr+3rAeampVEaKKzL
 ZX7NCJo+B2gGxFoaG1K7AILeZgoPA2zsrzeQ71aFLb1nfFxe6ZO8cxvFeL
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2e8:2364:2533])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b08:b0:2e6:679:9e4 with SMTP id
 d9443c01a7336-2e9a7254108mr84433795ad.60.1792499048098; 
 Tue, 20 Oct 2026 05:24:08 -0700 (PDT)
Date: Tue, 20 Oct 2026 20:24:04 +0800
In-Reply-To: <20261020002112epcms2p30a1e8fd3b2c6a3de2ac533f98b7b6c1e@epcms2p3>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <20261020002112epcms2p30a1e8fd3b2c6a3de2ac533f98b7b6c1e@epcms2p3>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020122404.1107182-2-stanleyjhu@google.com>
Subject: Re: [PATCH v3 5/6] hw/ufs: Support for Zoned UFS
From: Stanley Jhu <stanleyjhu@google.com>
To: qemu-devel@nongnu.org, Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com, 
 Keoseong Park <keosung.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::646;
 envelope-from=3aF3XagoKCt0RS9MKDXIGTFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--stanleyjhu.bounces.google.com;
 helo=mail-pl1-x646.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Stanley Jhu <stanleyjhu@google.com>

