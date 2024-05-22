Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21856C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 16:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ovB-00069d-Qb; Wed, 22 May 2024 12:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9ovA-00069H-Ul
 for qemu-devel@nongnu.org; Wed, 22 May 2024 12:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9ov7-0000v8-EF
 for qemu-devel@nongnu.org; Wed, 22 May 2024 12:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716395661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+6SZwgxkVKI8HZe1WQLRNYhgjJNn8fIqeZYy03JvixQ=;
 b=e0gqdQTgB7sDBtiInww2RUtUpTRyHx+nFXX0olpE6QmzcXE+qMF9IQDq6508Dyy0WQHG3X
 xqwVeE5SRsuZFYsZzGGeb2aM0cnMaU7uTVlC8hrSo8gBQjm2apNStujs4AIKFoF5QA2e++
 ikwUGw9dWR1XBX/tB3CSjlFOHOtgA9c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-LngbyqNlPOyG_YcNJQLvdg-1; Wed, 22 May 2024 12:34:19 -0400
X-MC-Unique: LngbyqNlPOyG_YcNJQLvdg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-792ba913db8so2468585a.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 09:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716395659; x=1717000459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6SZwgxkVKI8HZe1WQLRNYhgjJNn8fIqeZYy03JvixQ=;
 b=hHPbTPMoMNWI4mhJ6TIlfdETyPlzxj9fGljBUdkB6+dlN3fT3m6LN7rbgRp/+DpxRc
 myYJb8SUObmTzVAKtQ+lwk8bHGLICvyOn3hu0sVQ0z4SuUaNzcKHyzj5jk3gkFHKA+X3
 BzYkOFjiuBHiq8BI3D3f+KKrMc1wYuJPQ8IMnaQTvUZOUH6BWF4jW7By3fYDLcnq4MY5
 UpbR7NDU4ExmnT9CU2z9h0loRubpX3fO9Q/i6P6Cw5KP16NpORIWzRe4hvpg7RVm157i
 pX6XcWKQKdJN7+7Wo+VbUergRlKLZrCtYO3V4ylQ3zUsKv9ptVgMx8YNxOheCOOECIj6
 Lm4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2TQGb33CVyEp8mRBrBG9aGa02Tg3ZNmj0jySjI3jrwaUIXQvdJ6AqUPeBGMPBEQSS/2BlkiIX43ip6cmfLxNOxrDY7/Q=
X-Gm-Message-State: AOJu0YzIgvk1ZizPabnJmglpEtEuq4RX4FZo0X5eswUBaQF4hvU3Dbfw
 Llbar03/0YGB7enRNabXd+afUlRM66Li9msgPhZv4Ja+f4xHjwliap/tvJDAmSrRc/HZanQobK3
 7wkdZOdEUHTWbOwAdId2n8Inwxov3u6LLcz+HpYP2SQIrVbLtxKxP
X-Received: by 2002:a05:622a:1887:b0:439:9377:3aed with SMTP id
 d75a77b69052e-43f9e19e7f8mr24564321cf.3.1716395658531; 
 Wed, 22 May 2024 09:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO2PvcQZ0MTZ+wH9K1+uKnzTNSNW+UnkwsZJ+jFJpJPadNgb/TexupxotzRIYlkEF+S3+dzA==
X-Received: by 2002:a05:622a:1887:b0:439:9377:3aed with SMTP id
 d75a77b69052e-43f9e19e7f8mr24563841cf.3.1716395657833; 
 Wed, 22 May 2024 09:34:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43f99073d12sm16611231cf.15.2024.05.22.09.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:34:17 -0700 (PDT)
Date: Wed, 22 May 2024 12:34:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration-test: Run some basic tests on
 s390x and ppc64 with TCG, too
Message-ID: <Zk4ehyEUV_JlKYQb@x1n>
References: <20240522091255.417263-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522091255.417263-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 22, 2024 at 11:12:55AM +0200, Thomas Huth wrote:
> On s390x, we recently had a regression that broke migration / savevm
> (see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
> saving the machine state"). The problem was merged without being noticed
> since we currently do not run any migration / savevm related tests on
> x86 hosts.
> While we currently cannot run all migration tests for the s390x target
> on x86 hosts yet (due to some unresolved issues with TCG), we can at
> least run some of the non-live tests to avoid such problems in the future.
> Thus enable the "analyze-script" and the "bad_dest" tests before checking
> for KVM on s390x or ppc64 (this also fixes the problem that the
> "analyze-script" test was not run on s390x at all anymore since it got
> disabled again by accident in a previous refactoring of the code).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Irrelevant of this patch, when I was looking at cleaning of bootfile it
looks to me that we're leaking bootpath in the test loops.. maybe we need a
bootfile_delete() at the entry of bootfile_create()?

Or even better, prepare bootfile once only and use it in all tests.  The
only trick arch is x86 who needs to support suspend_me=true, but maybe we
can provide two bootfiles.

-- 
Peter Xu


