Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648C8CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgWL-0006qs-47; Fri, 16 Oct 2026 07:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fhDSagoKCkUz0husl5qo1nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--stanleyjhu.bounces.google.com>)
 id 1xHgWI-0006po-To
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:54:43 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fhDSagoKCkUz0husl5qo1nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--stanleyjhu.bounces.google.com>)
 id 1xHgWH-0005Un-Ar
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:54:42 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-88c768885b4so8000108b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792151679; x=1792756479; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oheW5Op740V/+nUGs5eGA/C8HO4eGsjigH3FSeitlE8=;
 b=fT36x0L5NwAs4KRpJu09w3mMmsO0q9TKjANntn0yP9Ae55+Y6Yi45y/lbR6930Ss6x
 HxZbSFHO9UuJy6uIRnihJw0wK8ECjxW1BjPWnZldI+nza5uYboOEHePPs7/PvxopsqwD
 vHbrGDI4TWvUG6GmV6T9Pxhvm3WfTAUx0hD1ZHqJoSvu16guDrNCr9K5c2MfONGgSrth
 JRt2AxzKxhHJyU0fdenJOJV0rw1jVgkKISeyFo8lmhG+v9Nb8F+LzVzivVUM6Fno/PK8
 Hwc08+uN5JNwlGCK75RNmzj7ekJHNISxEI4/OptjrkHeDi8TUxCQJlmv5WoEuRXkjnsz
 PoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792151679; x=1792756479;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oheW5Op740V/+nUGs5eGA/C8HO4eGsjigH3FSeitlE8=;
 b=DSFnX+PN1Ic7Af3FDqNiZSq0leVFMH/QdFunhSonE+SI0aSHNt31wU7y2X5zFRxDpA
 AgJIYW3/s7fQlvaqL5N2ivNaSQmKdETOJZ4W9ZrukfPk/s/ei2iC9t/T8HsFhpee2zH9
 +lwW803exQ4k3Px/nquGLEunhIXLJzR0TvqVVrJVWcva4AB6BoCIO2nnP8K16E+t9G0A
 OQrLbuXcwhVLUG7tqrvCjAlCjH6e6aOH5wwur0eCSeaVnqrwccdBysTkowRG0p7en2wQ
 Iw5SSCD5Vs6NowYAUv3KOi/vACTNNQG9RbNzfFejINHfrQa5hRE+Lb+qZLcq1RUbqvun
 NYJw==
X-Gm-Message-State: AFq9FYKEsNcY0bxwinYH/wGjrnR6NkuHt5S14V35rjv1Xfd90vSz+oi/
 kcZ3CSaQBQIBicvk/+/5H9i6HGn+qeH1kICfyMmctmkafqQBLs6449bSEbf8QxSvHcm2Ja9/pE1
 rXWa28EKmYUzOhiUu1Rib5Fu+T3BIJDo39gyMX7IyQO0rPHCqP3DnK5/Usx0o8+MAeQ0wY0Xpjo
 nE3h4PC9Md8Sx2Un0bMb0OS4kkf3DyBSaiDun9iPCMjhFz36eqQivOhKmP
X-Received: from pfkh14.prod.google.com ([2002:a05:6a00:e:b0:89e:f715:6dea])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:349b:b0:89e:f8e9:205e with SMTP id
 d2e1a72fcca58-89ef8e927cdmr3657942b3a.40.1792151678437; 
 Fri, 16 Oct 2026 04:54:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 19:54:36 +0800
In-Reply-To: <20261016093343epcms2p8d5801bd57384c44d5120ae0b7c4eb206@epcms2p8>
Mime-Version: 1.0
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <20261016093343epcms2p8d5801bd57384c44d5120ae0b7c4eb206@epcms2p8>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016115436.2659347-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 5/6] hw/ufs: Support for Zoned UFS
From: Stanley Jhu <stanleyjhu@google.com>
To: qemu-devel@nongnu.org, Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3fhDSagoKCkUz0husl5qo1nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 16 Oct 2026 18:33:43 +0900, Daejun Park wrote:
> +    case WRITE_SAME_10:

As far as I can see, JESD220H does not list WRITE SAME among the UFS
commands. Would it make sense to reject WRITE SAME(10/16) on a zoned
LU?

Stanley

