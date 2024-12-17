Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7AE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNfQB-0005qe-Ki; Tue, 17 Dec 2024 16:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNfQ8-0005qS-EM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:48:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNfQ3-0007Zm-Ov
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734472068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6nFrR0uqWi7Y7MzAGEdSsLPGY3sEPtMVnrg0Uzx9DM=;
 b=SrB/U+4N2BtDD1OthKv3o81nncnJ6fj/AIzM1M6DcZGZZyEYfWl/U4ODA3w8C6BeOtvxUk
 9bF0uIegrwJN4cHwooRM/3uD+iz0wicULtUTzNcN419ScH9tjRyMChAMEK57yf0RK9yV3x
 cIBtuHo+JdRKHiCDWU3X0COAfcg/0+k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-l_xyO-seOfSMmZu57-eROA-1; Tue, 17 Dec 2024 16:47:43 -0500
X-MC-Unique: l_xyO-seOfSMmZu57-eROA-1
X-Mimecast-MFC-AGG-ID: l_xyO-seOfSMmZu57-eROA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8edb40083so3462266d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 13:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734472063; x=1735076863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6nFrR0uqWi7Y7MzAGEdSsLPGY3sEPtMVnrg0Uzx9DM=;
 b=t5+/N6vIBbuupUDRLp3UzeXZ8i7rAuzuvgBeX3Y9FRzdPwS8KaConv0Y9a194dFO61
 xV6T+O2i95us7mM2Hj90nMnLeIfHxxsCLnW/1EnH6EHwXpn6IWbATFI3fZ+nhIEBBgAk
 Js7mXw0MLJwGMq+lZ3T42XMWbqisLr4JsCaESIVYN4azjH6xt0ltka3G6K62izkE4V5T
 71C+PJGSs+rcLiTSwBwA3sKpuVUSspYClaMxhmd2wrfHt0KtqCSRcoiWDDQU1RHKMpXv
 kKVimxZa5xRNml44b6wISRuwAFQsJw/N18kA9MhzDQRiFHQluebkHiP88+uRXUFmdJFv
 oJjA==
X-Gm-Message-State: AOJu0YzrF9N8I7jPOHAeZq6HsuGInRoynleVT9BWBI6ulmisWPuEe/1N
 Lfxvq5CrIOM8i0iERNu31mpd3Vug6oyY1ua5+tOXe15RdKS11S2c0d+399QAoVgA32UfmcOgv8b
 woQkXZWR4ZktElC65+E69yOpGRIXT7p6Bx4ICT/lDfuNY/1PJ+Ks3
X-Gm-Gg: ASbGncuwfkF+iVX0N/xHopKlMsxuxuLPSv2NG0B2t/VB4JC4CfFUKL24XOAdX53K6+A
 RWqoqDE8xOoXPtz3atclvE05KUApKE40dfHZ0djXcLvAObJgCqW+zeWLegmzpYI0cleQgyN+2GR
 HzJeorWOynBGJXuaKWdkplrz+pgJPul2wMTgSUmL5Tj2sKdWMX0tEji1myM+Ym78qs+tHlFcjha
 WH+sPtlhqWhl3TK3MseRe6yk4tA/8lukeKFlQtkiT7BgDtCIP5v42F49CRzlGhAthjYc/aktggP
 jLy2VYZsfKDfCVfGuw==
X-Received: by 2002:ad4:5ec6:0:b0:6d8:893b:2a13 with SMTP id
 6a1803df08f44-6dd09822933mr7012596d6.0.1734472063175; 
 Tue, 17 Dec 2024 13:47:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaHqe9cgCrcCzEjuy9l65sxRwqrOLfea4kWHZ9V52WKbI+BK68E2bUshlW56ANYzEy6lgDDA==
X-Received: by 2002:ad4:5ec6:0:b0:6d8:893b:2a13 with SMTP id
 6a1803df08f44-6dd09822933mr7012406d6.0.1734472062854; 
 Tue, 17 Dec 2024 13:47:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22f1fdsm43373526d6.6.2024.12.17.13.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 13:47:41 -0800 (PST)
Date: Tue, 17 Dec 2024 16:47:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
Message-ID: <Z2Hxe0PyVACaKIlZ@x1n>
References: <20241217212201.23376-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217212201.23376-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
> Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
> utils") moved the ufd_version_check() function to another file but
> failed to bring along the <sys/syscall> include, which is necessary to
> pull in <asm/unistd.h> for __NR_userfaultd.
> 
> Restore the missing include.

Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe worth
explicit mention that in the commit message if so, only when you merge.

> 
> While here, remove the ifdef __linux__ that's redundant and fix a
> couple of typos.
> 
> Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Maybe we don't need to be as careful on old kernels anymore especially in
tests, because userfaultfd syscall existed for ~10 years. So if we want we
can start requiring __NR_userfaultfd present for __linux__, then no way to
miss such spot next time.

-- 
Peter Xu


