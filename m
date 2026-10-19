Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABDACCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIiLE-0000jR-Gt; Mon, 19 Oct 2026 04:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3y87VagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com>)
 id 1xIiLA-0000j7-Hd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:03:28 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3y87VagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com>)
 id 1xIiL8-0003qj-NZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:03:27 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8a0688a43d3so560955b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792397004; x=1793001804; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nrEi1oIFehaWsOgSrcZoXh48qkgjSbMTKUFU5X0gmO8=;
 b=ayImV61/hZrJXYeqcHd2lUbywLzppyT0c4YoH9NyL6jSf0Jp2JR4tbyKqSqsl3VFVY
 8195I9BBFlDRhYyVWdtDNFIu6hwU5vY/9WI151DHeli/TOJYnt+vqwMbQh5liBJDtg1b
 fUOdS9bEEl8stmr48WJseNpEcBUAgsSYSTads/4BY/Vk6vzAaqC2c5iXJodLTvRihZAD
 JgwclEzT8bOx5Q7NyiLdcLbJT8KuU1G7sQkbmsmH3yFK7szXUQIGRs6hfplITsEU3ogm
 j8ejjeUE30TpGiQDNib6+eTZtwbXLT2rs2/m3AOrsDkq2XzxOny80GEkO0mMeTCwsg1i
 RbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792397004; x=1793001804;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nrEi1oIFehaWsOgSrcZoXh48qkgjSbMTKUFU5X0gmO8=;
 b=C+2EmMirWPfT5OwD7hrkQU0w1jaXgcNi3GrOxX7ZukkdZP3U3fbD8fvXpTvQ7klZ/Q
 lv4yj6382U1nU/7XKYgmYEfwXqfZz5noQat/l8VRmzOrQLBDFIUbnpk6c/E9MQtdV4rB
 S/SXPPVdn+aTSMZnIWyFeXyCM6CrQZxKIOTaS0wqsR2PW4f8+IxusUzLfT8mTzqYH8F6
 beJzFXDkfWF7kF5NSo1AYNwYfS8UlBOYSicHRawg27xGewkHR3a82eZNlqvb2R0e5pXF
 X+1XNV65e+XdQYJdaopShoq+DgW1olOFtvinX0jRYD1Hll3z8FFWTWdlrGgpDKboDVgl
 9olw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztrNyQ852jmqXT+seTIdpiL7wogLswVAYWbqLADdzWRBbVQJM1fMVLeHVDnNfbYZocWcdKvNhEmxEs@nongnu.org
X-Gm-Message-State: AFq9FYJ7lYWbetFYKYmGmLlElODt5CGFDyf5dfDXFYwZVFNvGCuCFjP6
 gWNhPAuW/VruNjpOLcpqJqEYgvPEMuW4lRhKpc34mytUVG31fFZO7GGZP1iUwbmdpAHeJdiUzaa
 AI0yjNstNQYDU4OylNWDcnA==
X-Received: from pfbgm11.prod.google.com
 ([2002:a05:6a00:640b:b0:89f:4f8e:282d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:348e:b0:89f:34c3:2031 with SMTP id
 d2e1a72fcca58-8a04cb24760mr5312480b3a.53.1792397003641; 
 Mon, 19 Oct 2026 01:03:23 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:03:21 +0800
In-Reply-To: <20261019013307epcms2p14049cf5797cbe5332877ddeb950f18bc@epcms2p1>
Mime-Version: 1.0
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5@epcms2p4>
 <20261016115434.2658500-1-stanleyjhu@google.com>
 <20261019013307epcms2p14049cf5797cbe5332877ddeb950f18bc@epcms2p1>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019080321.1982926-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 3/6] hw/ufs: Limit data transfers to the transfer
 length of the CDB
From: Stanley Jhu <stanleyjhu@google.com>
To: Daejun Park <daejun7.park@samsung.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3y87VagoKCh4MN4HF8SDBOAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Oct 2026 10:33:07 +0900, Daejun Park wrote:
> UFSHCI reports a data buffer that is too small with OCS MISMATCH DATA
> BUFFER SIZE, so the status belongs to ufs.c. ufs.c does not parse the
> CDB, though; the LU does, in scsi_req_new(). In v3 the LU would pass
> the transfer length to ufs.c, and ufs.c would fail the request with
> that OCS when the PRDT is smaller, before scsi-hd sees it and with the
> write pointer unchanged. Would that split work for you?

Yes, that split sounds good to me. Thanks.

Stanley

