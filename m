Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D22CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHgWJ-0006q9-M0; Fri, 16 Oct 2026 07:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fBDSagoKCkMxyfsqj3omzlttlqj.htrvjrz-ij0jqstslsz.twl@flex--stanleyjhu.bounces.google.com>)
 id 1xHgWH-0006pc-Rv
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:54:42 -0400
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fBDSagoKCkMxyfsqj3omzlttlqj.htrvjrz-ij0jqstslsz.twl@flex--stanleyjhu.bounces.google.com>)
 id 1xHgWG-0005Uc-5P
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:54:41 -0400
Received: by mail-pj1-x1046.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso4405887a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792151677; x=1792756477; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cg51OU+kKjbILgHrfEOh3Rjvm0yEHUx37HTeoChN4Fs=;
 b=dZf6LrFjvN8Qnir6g86GY0Emtbz1nCveLjdblfJe1hSbnqTzXhaWqxHveVplVFpm5n
 R/wE/6G+0wrE8qy9P/NA8bsw1DADZ+ur///54haFDYKNHjz/HTQtcGSZYPmWrlvQOtxG
 IPMh0svy7rteq00UOjmOum7smRhGBJ20BXwWLu1AULGvKlsndnJt+D5SEUAq/jvRYeFp
 8/KOMA1kQTGdM8RlOdPtPZZRTDr7xpvuHiDdM1NrlaTlh3kzu7R22MeSadrvJD5TbHse
 e8WdDCnDYglCUHTHGAOjkfKCLCXvovOH3ueHTxVLtwCLjRol2M4QLdwE5/OrCRNqsQky
 vv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792151677; x=1792756477;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cg51OU+kKjbILgHrfEOh3Rjvm0yEHUx37HTeoChN4Fs=;
 b=Hxidfn0m1dTm00faDEF477YKbApogf4VH7AyQI/Wf2cUW/lYtMXcyBTuKBvT+JF9PT
 01eEjYzyp6TkFXlJK+Tto8RJuMGpgHrobPj2CNpraAwjdtJxyYrSdI2rf/Ha6DQnzGyP
 XRWbrj0RAFxWotmOyqo3b2NJAR4s+A+CTYawzMmgowvZEack0CrlCU3bCOJFQXbBRH8P
 P2CGzb5HLHEvcQRF36wp4DGig/cb8VPoG/abx/TaOh8GpOKP6+C+wkFEPr2P0tvU93lq
 amBHgVARnl4Y7/uC+nzifk+6O417WCUC3ThFrOCPl2tj0jINmBYWuLqYiE/alGmXGbEi
 MX7g==
X-Gm-Message-State: AFq9FYLU2qU8r+IAWPVGNuqeQAGPNsw8bhJ75mnpuXkEpqZaI1q0/h2i
 3zEU0vEj5d0MYuXu9Oe1qm138Kzo5+B67IWZjn/Xz7QLl6H9wsxBPn8pNuFW7tnxISG2JRBHEYF
 /wO2k3emT5EPbOTkLXMXqNDyRgx8UHUvJb08tMkFORzXdHHFYy3h8Ag2qGLbrBZOmAG/pya4Ep5
 9L6EQdwKO08GQ/GPbFFm5i2ImYTGs/p8mrv1nhLtY/r9nAw6rtUxp2+Cv5
X-Received: from pgbcw1.prod.google.com ([2002:a05:6a02:4281:b0:cd6:16a9:5cc6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4b:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3ac945c9996mr5702576a91.66.1792151676244; 
 Fri, 16 Oct 2026 04:54:36 -0700 (PDT)
Date: Fri, 16 Oct 2026 19:54:34 +0800
In-Reply-To: <20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5@epcms2p4>
Mime-Version: 1.0
References: <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5@epcms2p4>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016115434.2658500-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2 3/6] hw/ufs: Limit data transfers to the transfer
 length of the CDB
From: Stanley Jhu <stanleyjhu@google.com>
To: qemu-devel@nongnu.org, Daejun Park <daejun7.park@samsung.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1046;
 envelope-from=3fBDSagoKCkMxyfsqj3omzlttlqj.htrvjrz-ij0jqstslsz.twl@flex--stanleyjhu.bounces.google.com;
 helo=mail-pj1-x1046.google.com
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

On Fri, 16 Oct 2026 18:31:09 +0900, Daejun Park wrote:
> +    if (req->sg && req->sg->size > scsi_req->cmd.xfer) {
> +        ufs_limit_sg_list(req, scsi_req->cmd.xfer);
> +    }

This handles a PRDT that is larger than the CDB. Does a PRDT that is
smaller than the CDB need to be handled as well? If so, could that be
done on the host controller side instead of in the LU?

Stanley

