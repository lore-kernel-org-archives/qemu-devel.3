Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53222EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUij-0003Am-3B; Tue, 03 Mar 2026 13:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUih-0003Ac-Vn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUig-0006Vu-0t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772563423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2zeKKfODt4CL6GJIdGMOBnySyY8rAGdhFpXXoca0Q8=;
 b=IMr81w4AoK9JbLi7GLYmvhd+tQOMSsOsOKSqLbu58i1lh7Yijl4ed0w3rXFaXT2iyqH3T1
 Fd/Y8QFrvVcVy5WC+Xww4N1C8BfC+9qB0UTbuXWNQDFoIpo5HowwtdUMWc+SUuhmKgTvH0
 qt/274fpj3vBMlqPdn5FMLo4kghD0h8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Fh4JjPUNMcOmWYcvT8AReA-1; Tue, 03 Mar 2026 13:43:42 -0500
X-MC-Unique: Fh4JjPUNMcOmWYcvT8AReA-1
X-Mimecast-MFC-AGG-ID: Fh4JjPUNMcOmWYcvT8AReA_1772563422
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb3a129cd2so4656793185a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772563421; x=1773168221; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D2zeKKfODt4CL6GJIdGMOBnySyY8rAGdhFpXXoca0Q8=;
 b=Uy5Rg/Uq+GtvI+EH/q6bR3p99okzpcVxFFFxdP9LKh+08NuZv4vOV1isAnw4+dBoK1
 cTXwMt00RH8xlCBJiLyW8yLuARR+5mstgQoqC2ulJ0LkvsCTyMhPzYPeLk/qUJaOk6Pg
 JoPe0LxebXYliICavzdCXeEYHyhUnOeoGxNOreUKQfz1dU9onSB/gvMpCssmVBKqELsi
 +Bpfs+dFWdL6dJUuA4DKC5mWhTqxfV7E+opUURxQAroyGN/5rvlekgcAD8RmGAuw4d+B
 M8e0ngaOY6EofHHZUKLil/nSmAlfo+2mxwLfhBiSVIPAz9vUPH4QHkZJPLgfvA1L6vF/
 W3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563421; x=1773168221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2zeKKfODt4CL6GJIdGMOBnySyY8rAGdhFpXXoca0Q8=;
 b=sdpUr3VjGIwhF11Io4kuF+JoremYIfaXNBAyKsYOFK5KntauKNx3Ew3hwziDbNPRDh
 l0GWK2F+riQDUgKbyaiL47Jv8aMter3dM9F4UlVHcISjw2mmRGX26qkIE/fD5+9uB2w/
 iL0kzbuhZ/3bDNpvz1fKEJ6nyrvJnRdE1WXipSyqk0jVJwsgBkktvR+EYgBHZQiE2FXd
 pj556nKN1m+qKsvdjPNNDfbUZDg1zTRvpkMS6A/OAzUm689yhVD49o/FS64sGS3ZEorT
 1OKd/9WO9V7BUsOhc+kkz+FO0VsezG88AzlmQNCqhPkhjwJoq+dy4Az/41RfkFwwj/jL
 f6Tw==
X-Gm-Message-State: AOJu0YyfB+UKmwnpwiWL7tLqpfB2LTZP0HF2q+F3vPZXxTPlAi+U/Rw5
 KbAqoO6x8ZwSJfuOBxkbnkknQhNCp8JBf1GZwXnRdwPKctMydSGeUPFJ9r2bQfV5/iULlUmT8DY
 2icFIdEzoepoFcTSlFp79NYncG7LmZogp6pW3DSsbzSTZ07vt72LPGkPY
X-Gm-Gg: ATEYQzwWdVXQ62QALU+R+P0bc2xNORsBnpZdP0Ng/SfZj6BfMYsuEaJARizAgLFBFcW
 g3tK49Wt1JyR5axKO9ArFyObuA5i+mxg6B1KOtmcwgMp8U84hB1KbdW2fbuCkCAZFwwIkjNv8bF
 43LKzo0s0f63fSvmatpSyjusRLhh94e0d35Camie6iSGWr/RxEzzdBVjVmrEezMPWR3SD3ch6oq
 K+78h8M2Hzp0iW9i6OAKenqEavnynInapajkZAJpkarln8PyD20c8urzeF8UEO3FqJ8JmQd/IKz
 OZ2QHpPK98tjQhnu38rHxyByxIMQ/fZ9IunM5seiLuRgvWr+8D18+lRK51KdFdwSVxnZIE9DRm9
 4/SxEk2Kyqyb63Q==
X-Received: by 2002:a05:620a:470d:b0:8b2:f5b5:c9bf with SMTP id
 af79cd13be357-8cd509c2057mr366659485a.22.1772563421587; 
 Tue, 03 Mar 2026 10:43:41 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:8b2:f5b5:c9bf with SMTP id
 af79cd13be357-8cd509c2057mr366656385a.22.1772563421118; 
 Tue, 03 Mar 2026 10:43:41 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66f325sm1443836585a.16.2026.03.03.10.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:43:40 -0800 (PST)
Date: Tue, 3 Mar 2026 13:43:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, adityag@linux.ibm.com, thuth@redhat.com,
 berrange@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] tests/functional/ppc64/pseries: Remove custom
 migration routine
Message-ID: <aacr0aznC4RmBReB@x1.local>
References: <20260303173320.10942-1-farosas@suse.de>
 <20260303173320.10942-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303173320.10942-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 03, 2026 at 02:33:20PM -0300, Fabiano Rosas wrote:
> Don't implement a custom migration routine at PpcMigrationTest and
> instead reuse the generic one from MigrationTest.
> 
> This removes the dependency of PpcMigrationTest from
> PseriesMachine. Having one test import another causes unittest code to
> instantiate the imported test, resulting in the setup and teardown
> methods being invoked for the imported test class, even if no test
> from that class will be executed.
> 
> If run in parallel, the extra setup/teardown methods that result from
> importing can race with the ones from the actual test being executed
> and cause the following error:
> 
> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> shutil.rmtree(self.workdir)
> ...
> FileNotFoundError: [Errno 2] No such file or directory:
> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
> 
> The PseriesMachine class is changed to inherit from MigrationTest so
> both the migration routines and the class attributes of PseriesMachine
> can be accessed without the need to instantiate another object.
> 
> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


