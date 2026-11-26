Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E35606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UVsn3U/r;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BM/GrTiG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWfEG-000093-0X; Thu, 26 Nov 2026 14:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfEE-00005z-Ol
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfED-0001oM-5D
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795721635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YEQPpdpxeB7f1dpVhS2Hd08mHaIfP4m2o5VVublAW/w=;
 b=UVsn3U/rwZCZbLnfdtIVahy1yF4am3bucBoXP5ExgO56br+vQHfYFhFUI318oKdTA7yACi
 kYik0e4eCbRR1yIr7Me26TiwMHVqb9pcQULmGVn+g5upynOQP7nUGAt1omD+Zfcxs9e/iA
 LJkEd0FGt6m6td8unAtPy6nMTlQ1sfc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-AXlozz_rMYqEPU5FKoKMOA-1; Thu, 26 Nov 2026 19:33:53 +0000
X-MC-Unique: AXlozz_rMYqEPU5FKoKMOA-1
X-Mimecast-MFC-AGG-ID: AXlozz_rMYqEPU5FKoKMOA_1795721633
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55d2c5f10ddso149869781cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795721633; x=1796326433; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YEQPpdpxeB7f1dpVhS2Hd08mHaIfP4m2o5VVublAW/w=;
 b=BM/GrTiGa3MSou9B2vmJTffWgT7NKGNt09d9y04L2WM0tvW7xK2eFhXQIWvoF2UmeB
 DXXHcuZpaD0y6STWJ4A5UXzN3xomGnASsFZagdGJKCXz8xOdMD4QHEap302/EehSna6f
 xRh98dVqYpboMpkMXoGkL3vgzlbK9muNd/nrO7LmYeEF0s1rVtLJ/LKFqVhgQdacqiCo
 emo0pqeV8VtZYiLWcmbzMCnXeh37jGGqhQU9g5FTze7sYg4ALZwO+ygOO3QQaZEWToqb
 TQsDStU+7R1Jj1q2476aSKUUglf9tZYuFuRgBDThiFko0pDZEdrwmUG1Aa6xWfHfKETD
 mnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721633; x=1796326433;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YEQPpdpxeB7f1dpVhS2Hd08mHaIfP4m2o5VVublAW/w=;
 b=gji7LW5YPGuOIVYaes0K3G8irEyJIYwGuD2p0EGiy3EXNffDXc6710jM+Lot9nOt8X
 Brk2tLkM34uhZPlPJ+0Y7tAj7/gK0ddO1AJxnn7vzE9FDfQaN0iYjN5WcnTbio+AYbs9
 kym62FIqL7CEkPMeGYa26uZVUhb6F6+a/3mzIzCT0crlZf82cmkOXeoJeJC3h7/wCmKu
 LiuPjN/ifaembQpcuEp+ja1NPr+KedS9W2lwpO5jbDySPKxUBoRAy3VGpJqhrApqsqal
 nny51Wue0fmHTuTkWKTDWEZ0Ij6QIUFv+qXcmD+rki7G7VBgW8A2fldJcEduO3T9zjug
 lrJw==
X-Gm-Message-State: APuU4Z/pcGdHUqPzXU9WXa1/LPT+vsUVD5Gmbu/nlQpX29cRLS2JN13J
 HBUUtTFAFMey9bSCT6A/HnYIa3BsysJjl+9iTSndncd18i9/WNzFuPdOBKGpqfFYqLuCuAKgNOS
 jUdEFyyhr9D8HjDgifxPqkc3tyuufyIetl9Q0I5axLTHrqYthmrhw5SgW
X-Gm-Gg: AZFdTZfy9BoFLi/9eqRCDRmVVNigkuO+EvdkeEKafu7MZF3ezsnSsTeCXQK0568NolF
 COTS8axDDp0glPyiNpDDzE6OErlxJUBc7fU6gALUcj3FL9BFy4pt6PKFdbZnRlt6c/JU7n+txjh
 hfkhZ1QLCSXb8gyaDu1ImO77RSJQIzMiuA9niPWc9EdAn4kftfMu1Y9nmbDvc2ot15y/nhYs8zD
 VE7pIiQTJ0rzKh42NrULstZK/Kmsp5wqoOIBLShtCoaIFnXz17tYkO0fg5F7MX4AkiMDDK9bO6p
 dktrauNLAlTtqB36VantjBdTKoSc06Ew7YJG/dCUYDPBIslmpGp0G7+Y7zPfLmp3AhihJhUzg8B
 O4POufufTpBaM7HmVPegF+fnc8zStcX23KOTcdaY5E8Fi
X-Received: by 2002:a05:622a:507:b0:55c:5ebd:8823 with SMTP id
 d75a77b69052e-55d76ad31b1mr418159931cf.66.1795721633262; 
 Thu, 26 Nov 2026 11:33:53 -0800 (PST)
X-Received: by 2002:a05:622a:507:b0:55c:5ebd:8823 with SMTP id
 d75a77b69052e-55d76ad31b1mr418159571cf.66.1795721632784; 
 Thu, 26 Nov 2026 11:33:52 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78e4fc12sm187216311cf.0.2026.11.26.11.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:33:52 -0800 (PST)
Date: Thu, 26 Nov 2026 14:33:51 -0500
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 2/2] tests/qtest/migration: test cancel before the
 channel connects
Message-ID: <awiJn88rCzL8fSvr@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261125193102.1423555-1-den@openvz.org>
 <20261125193102.1423555-3-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125193102.1423555-3-den@openvz.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 08:31:02PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Cancel a migration while the source is still connecting, then let the
> connection succeed. The source must end up in "cancelled", and a
> second migration afterwards must complete.
> 
> To keep the source waiting in connect(), the test points it at a unix
> socket of its own whose listen queue is already full. On Linux,
> connect() then blocks until the test accepts a connection, so the test
> is Linux-only.
> 
> The return-path capability is on because the hang this test guards
> against is the cleanup waiting for the return path thread.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

