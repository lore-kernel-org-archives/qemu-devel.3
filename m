Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D303606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dtVzKPdy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lIlZbkXw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2H4-0004Pq-9Y; Wed, 28 Oct 2026 07:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2H0-0004PO-9y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2Gy-00069n-RC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBLVfl05Sz0/5z99L0MAE3gy8CXtzJ7Db/IRUSvMMSg=;
 b=dtVzKPdyqOOO0ZfVgEn0XF4s0OsIQE8aQlXlhTgRzuC+b6fJ56w5rGUjCExOHl9ga+9+62
 MwUF99wxuPOx0czaOYW9ENOFxUqUeruLiYY4YkIa/4HPqg0z3hqVnxxYL7cXAEXTsTffFd
 QbchAHmTqUJQSOsEeSvquGtR4dIjc8c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-x3W5mjLOO9a3KmnRZq0PKQ-1; Wed, 28 Oct 2026 07:56:44 -0400
X-MC-Unique: x3W5mjLOO9a3KmnRZq0PKQ-1
X-Mimecast-MFC-AGG-ID: x3W5mjLOO9a3KmnRZq0PKQ_1793188604
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338c215ed2so17209361cf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188604; cv=none;
 d=google.com; s=arc-20260327;
 b=pozc30U3RbbNUwkXOOM7Bgly+mucQxviLWT3qPWRobh/JobIDDO/gz6zZowLCbo9q+
 XQyScTgcDyuQl/qdtH+LXhwAYS/oS554kFkpbuRuI0AYBYPYJqs7qVXeQ9q7ldsY2vhC
 0v/ABIyjntc7QRc8euGIg35qGBJxhn2MWrgMv/bf1D5/fyBhKvhxZEziTh7r0cu9oLdB
 K7Y2LvZl9FnxQ6HyVUqhLr09U9ueav7loozNGI7Fd34SQH97EFpGiLM/rQbv2fb0ylpg
 teG9rfkmiPEtg4uT1EpuCdrmZBc54QokXqy/1ENm9BEW+69v3TM3JD5OXdi7uBafnoaH
 /X3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OBLVfl05Sz0/5z99L0MAE3gy8CXtzJ7Db/IRUSvMMSg=;
 fh=lJ3l5h8sU9OcQSbaOuYA9KlOiaqQMCXiQDGuHTun508=;
 b=B9NoJD5R8SiuEagWiily6+uUbpptD7kpwzB2KVusHttKSPIC/wNCEmy6mczgEiQmGJ
 e5StnxSBr+tbbuMN05ehJcLJA/eWoDoM8+tzk8HOOPM2XOamCSVmXOPnTKjaiUgTLazQ
 L2t0nntAr4s8kBgGngbWGNyvY+yDPybChTaRNxl5pT8YVEzOEdbwGo9tfjE4o0UwA/e+
 dyhHvKYvmP0zwXkFU6lTt1E+cMUkNFbizs258E2dyRsZ4Q9VUbbUZWjN1a2VyyYZlBzQ
 bgffH0QLy2mbCm7EOense8GEaKwchyaCGw6vak/pPp1fKB3xBnwB5FISDnq7cqLlXI31
 pqTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188604; x=1793793404; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OBLVfl05Sz0/5z99L0MAE3gy8CXtzJ7Db/IRUSvMMSg=;
 b=lIlZbkXwzVr+DE5CwjHOSvgeR6FnouphqQ3YInQqf4d/UyibmUHKuq1tbqF+5rkvjp
 7fnu2sBnTluMEnlqL4+HjL7A9+QA381Dz8/F5RPnj28Ldr3nF1puA/MKv2PKFywVN7Wy
 hxkkXViM7sP3dsUt5b7mlFaLJrkm3roWKI52B8lXB9N51b9/e5IkaMgHwsHkxDCFIE0W
 dw4uRvBkP5O4ck7qHmP0SSkynNoKM8Fq4kSDRAUKjMVsF07hD7YqBDKbPtrBYycQJrCV
 QUIPkiS9BYu+RwIBmlO91a8OQFpc8zDWKBbUVAheXoJfkGBH9fdvN5XNecGlXdDkZCXS
 dMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188604; x=1793793404;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OBLVfl05Sz0/5z99L0MAE3gy8CXtzJ7Db/IRUSvMMSg=;
 b=aEKu1IeW/PwEQ7GefCHIW+nCGu1TQyDNa540WadFwj8A5GYdosHKxVL7dA5nSHl/8j
 zoWrOFZvpYpuwN2wKJnQwpAF7GKezkwysEF4Bxc5FqQRfZCdPVGsD0yHlvii2VPju3Ge
 O2eQ1Et7iQEuMG5EzrzmcAKVnBSY1RZLvmHN/lOFr2U1h+WcYuXDpChOItcuhLiqkc1s
 zBt59s4bLu9RQ8sA8kMRsBqiM7z4YwOrUlhYE2f/IHd8wJzU26jLDZyVG89UDxp8hiDH
 UWK7dyCeLgu3CsryGYGjJQLZq1IPnhreDlRz5biHNK2AoFxrBm/aV+jq+O1p4NqvmiVY
 ePJA==
X-Gm-Message-State: AFq9FYJC83yvfXP8AfF6et/A3S1yrcIQbgn+3j2NsQTBQQonM1YVIJf0
 WQscu5q6EIemZU/tefQWwS0KJsHHV2Z+4PKaxHVIfBYfRFg1v6tK4CcQNCxDoD6V6ziM8y32n9l
 lh4f844qY0U4xBrdpzssNDryAUCqSG+u6g97n7xm/zWCQxpMG8UNnhZSwxkybwD7eN5kt07e3xs
 vf3EVu4umJV7hlKjz/mbFjO44sbagHPBQ=
X-Gm-Gg: AYBFou3fryQ5CX8FZg5PbYU61029yAk4FB4hN7wNtMrhZq48/kRoLeU1TnpLpy97Ql+
 DMlbaTzdg7/3FutxvONTTSa29PuskkD77l4yCOin3SJdDJXX3shpKuZbyYkJ3LdxWqaxcbatdau
 AQdK1UYj6y0FmObe1IbuPmZkzPf8bLsZa4BU9hpSill36gHPytDYiG/XRPtGlYKoEJd80c432uo
 G/0tC6I9ciY3AVsZkgWpg1nu3Uy1DsDkkWjK86MGyeu3aOmzhJluDSQYE0wAJL1WzPp7AsQPpEo
X-Received: by 2002:a05:622a:999:b0:535:a5f9:7529 with SMTP id
 d75a77b69052e-53fcd190e11mr32793671cf.72.1793188603836; 
 Wed, 28 Oct 2026 04:56:43 -0700 (PDT)
X-Received: by 2002:a05:622a:999:b0:535:a5f9:7529 with SMTP id
 d75a77b69052e-53fcd190e11mr32793481cf.72.1793188603413; Wed, 28 Oct 2026
 04:56:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
 <20261015173250.65942-2-bogorodskiy@gmail.com>
 <CAPMcbCos82eavn8oci6O+T+Qbw6Vt8UWPezwA0Fc9KDN1CLX0w@mail.gmail.com>
 <auHhzRcOxIEZeMn6@tulp>
In-Reply-To: <auHhzRcOxIEZeMn6@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 13:56:31 +0200
X-Gm-Features: AclHuK9NB3wSIBpTz7_GBON23ZdOVHZVfcy8tP8pNh8f--uCmQaAHn3klW5utPM
Message-ID: <CAPMcbCo5=+nnXMr5GLXYrGhjHbsp2wY_UjZG3qX79+j6WS8G9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga: fix build on illumos
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000b8dee4065ee54158"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b8dee4065ee54158
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

--000000000000b8dee4065ee54158
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href="mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div>

--000000000000b8dee4065ee54158--


