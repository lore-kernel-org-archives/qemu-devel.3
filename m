Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CDED12D55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQlnx-0000Pg-Hz; Wed, 03 Dec 2025 07:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQlnv-0000PL-Sw; Wed, 03 Dec 2025 07:17:56 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQlj1-0005jT-Ma; Wed, 03 Dec 2025 07:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=hPbCRtEx0Aylbs0pmVY/6rcU6UU/WC/vPI9krT1PqQs=; b=wjjSYoXt3FU5rcKRJiMVF0JxVs
 m8ETwFmfP/pHP3b7UGrtQwqJ0pU1EjMmR+J4ann9LCOfrdPZbOigOL1bvMOXpY+SEqYmve5dqk2FT
 Y9zwIxRswwrlCEMoVdxN1c+FQjhZeEMQqo+y1Lrh+KGOKyiXtb6ObcnlsD/6ncYmqkdAsR0pJ/wPj
 gkHZpaFwfs1X9/DLURSO3KYxeH0K9cu/y6C4T1eE1xjYY2AGCI5fFCEYPcwZfwSG8cd1tUoWJMQmY
 xCbJlfQuJ3QUwLIJTG26mPpwj/qOWnqXL8jxMxalLKW+KN/cMmdjq/bLwn5DjL9KislR3HMSRcrYP
 QHFGW/Fy0QkKhS3j8DlbfFtoUTDZ2A1xwncUnP4CYwBFAMUQgCCKQ0ygct11tv/hbIYb4mQTI1+Xi
 0uXp9KSLcKP+7KIKTLMXnbpNJomvoM7KtJl2jrpqfnarsdryaLxMPW9QyS3+Fvy9W2q0CJfzu1j76
 zYNyJUCWil66NW0wjTasB1+dt8YWgOuVe3I5qK1H28yW68C+A0020j7QU6O+P6rPXUIwWKfW8mESj
 j3i5gs/1CRlVVWgWJqzIiLDCM5oSvuuVwjDzZxcN0es9hLIye6lZTQi7kzulcJSi31GpmwTuSqkkf
 bAqoV8HdG5lc0aYfzG6lswHrGVqh3txxqO5G+acy0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org,
 Alano Song <AlanoSong@163.com>, AlanoSong@163.com,
 QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] hw/9pfs: Correct typo
Date: Wed, 03 Dec 2025 13:12:30 +0100
Message-ID: <3383884.aeNJFYEL58@weasel>
In-Reply-To: <20251202132132.17636-1-AlanoSong@163.com>
References: <20251202132132.17636-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 2 December 2025 14:21:32 CET AlanoSong@163.com wrote:
> Correct comment typo in xen_9pfs_bh()
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>

Please send a set of associated patches with a cover letter next time. It 
makes it easier for people when they are threaded together.

I assume this patch can also be pushed through qemu-trivial, so:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Otherwise let me know and I'll push it through my 9p queue.

/Christian

> ---
>  hw/9pfs/xen-9p-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 79359d911a..ca0fff5fa9 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -310,7 +310,7 @@ static void xen_9pfs_bh(void *opaque)
> 
>  again:
>      wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
> -    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
> +    /* paired with the smp_wmb barriers in xen_9pfs_init_in_iov_from_pdu
> */ smp_rmb();
>      if (wait) {
>          cpu_relax();



