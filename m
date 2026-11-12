Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB960606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gM3DbeEl;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Rg5W1OGy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRdji-0000xD-Qy; Thu, 12 Nov 2026 17:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xRdjd-0000sC-8P
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 17:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xRdja-0000yt-O7
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 17:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794524253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhNKevsowgRkgGYHVsP6gepU4G/5TtJGOlEzBZgdb9U=;
 b=gM3DbeElcSqZj+3+5YW67Iq6YyxAqWhfmF7cjpXxa+Q/MIQlGTMRPNgE1o2rWUU+ScXqQQ
 NO//4V5eTE9XrxlOj/L8uZFulkZtQeVvEZ121ZFF37XnDc8u8TJmfh+Fp/ZCBpIkUsAf31
 AMrkTCpQbj00wT8oZGNMZhw+klvPBKo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-w8EsTwJPP6u5Csh01JR7RA-1; Thu, 12 Nov 2026 17:57:31 -0500
X-MC-Unique: w8EsTwJPP6u5Csh01JR7RA-1
X-Mimecast-MFC-AGG-ID: w8EsTwJPP6u5Csh01JR7RA_1794524251
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-555d08e97c5so7926201cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794524251; x=1795129051; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dhNKevsowgRkgGYHVsP6gepU4G/5TtJGOlEzBZgdb9U=;
 b=Rg5W1OGyftpj+0iFHObjqu0JL1Wuws170piHACu4ii5vy7QdeWZblHxhXxEJ6DzPIR
 FRRvBKDRY7nj7sTxaKe0ZGGv5BbD/Fqj5CBDPyCUxcND60Jb6GXGfTBx6aUft/+Rgnyd
 5Goz6V6SMnYNQO0R6fhY/g+HKl146opVFv6lT34qi6f/6466pSiJ9O5+nunGnJuCDfY8
 CrzFELt1mMyA5EgKM9DYQ6RYtQqz1Mv6QI8ZqQ2zPiTpsY4TbZ3FdwHdVIXdhQWf8kjo
 HB54Iwy6zTEK0/GQugA21y0nP0IonQPMwou88gGEO6xDayUntrDq+NQpthVXT7EySiJc
 pjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524251; x=1795129051;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dhNKevsowgRkgGYHVsP6gepU4G/5TtJGOlEzBZgdb9U=;
 b=SBzrpEXH1VVaohuzqdw12SUEPVEgQwY5UgTYts8Z0yVfs4AQy82JLo8mpZ4qzxA5om
 IE1ZkEKydk4cRaN7Ez/wP5El9gm0q+WkNOTvXdod6fZcPuvLU8hKz27oJ6Z0XnbYzJ/7
 pUPNQ5GH121wjx0zGT4OypAvJc1/5HdwJ3EeO58az/1c3C/sgvAxcWY8syNkKHRSe3he
 ROPQYEPVx+O6Ab3xpBD55PGQyRug2jFVjHzn1WahZ/lVfGXuYYMzEhwbH2OhOt/P2zyt
 H2ebD5I4BME/bXHp+QI3Iwc52D1ztVGhtwgguhVXPKpLmhUYfrjkStj8mVvRwAUZcs7I
 Sgfw==
X-Gm-Message-State: APuU4Z80ArPDdinPECiCAtE7DFANGRAcWa5gp1/Bn0pxJCZwelMFbGV8
 t80AoopFHgWvCecyggkVs1KYEfUE7LPTea9PTvhxihpTPM8CSbM/R2wj3lQNW2X4fIZiuj3hygO
 VgK2rOrfOoSlkdGhTEh2ZT4nyWepBLqpkI48QxjMws8U1EO5mcJ5iwXy5
X-Gm-Gg: AYBFou1zqmfMKtdKOrxXxX31C/yqn0aOoKPnWVF7MqhE6Gh4RWoQnToyN93DcJCRPtm
 WC/vGaLgpUf//JxcKfoGt5THS2C2QA7PFhJzHovxrtx0gT6mS/SqpBBvPww6tdBG9EMCF5c455V
 HN5xEnKkQfC/IL4SouSC9Alsc1rYz/tOTB8qWGnzEYKPBsW3vHPyX+65lOaDpQ6lHfQq0FPKTyM
 FNCkApAtj4P2pth3s9rXXH4fqZaJcikOtAqJ8BfjVt3rNmATkHmtLGNFdUi1LP07qjkNKHnu5iG
 YnAiC6H4sz22sTQZKZfEMiZ1E8zkQD65D+/BLjE6Vj0iFy13vonHopFY0McKcdcvsV5y3ZULZok
 0sP2vGLB8zK3uf/24QD2tgDhjVewxgAZdd8UN5wQYJEmgmIWQppei
X-Received: by 2002:a05:622a:14c9:b0:535:20ea:cefe with SMTP id
 d75a77b69052e-55ac817f1eamr14991601cf.18.1794524250609; 
 Thu, 12 Nov 2026 14:57:30 -0800 (PST)
X-Received: by 2002:a05:622a:14c9:b0:535:20ea:cefe with SMTP id
 d75a77b69052e-55ac817f1eamr14991401cf.18.1794524250088; 
 Thu, 12 Nov 2026 14:57:30 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad13fbdd5sm5379111cf.22.2026.11.12.14.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:57:29 -0800 (PST)
Date: Thu, 12 Nov 2026 23:57:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Lucido <simonlucido@meta.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 vhost-user@lists.linux.dev
Subject: Re: [PATCH v2] libvhost-user: return the backend mapping address for
 SET_MEM_TABLE
Message-ID: <avZESAvu8nq4P0uS@sgarzare-redhat>
References: <20261112-setmemtable-fix-v2-1-b38ee27e8f19@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261112-setmemtable-fix-v2-1-b38ee27e8f19@meta.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:38:46PM +0100, Simon Lucido wrote:
>During postcopy, the vhost-user backend ought to return the base address
>at which they mapped regions during SET_MEM_TABLE and ADD_MEM_REG calls
>[0]. This was done properly for ADD_MEM_REG, but not for SET_MEM_TABLE,
>so any frontend that was relying on that call would not work.
>
>The bug appeared in d288eef3a0a8, which, to silence the
>address-of-packed-member warning, created a local copy of vhost message.
>That's fine for reading the table, but for postcopy, we also write into
>it to send the base addresses back, and after d288eef3a0a8 we ended up
>writing into the copy.
>
>This bug was affecting ADD_MEM_REG and SET_MEM_TABLE alike, until
>905e8c7e260d fixed the ADD_MEM_REG path by copying back the memory into
>the payload.
>
>This commit fixes the SET_MEM_TABLE path by doing exactly that: copying
>back the memory table into the payload.
>
>QEMU wasn't affected as it uses ADD_MEM_REG, but any combination of a
>frontend that uses SET_MEM_TABLE and libvhost-user backend is.
>
>[0]: https://gitlab.com/qemu-project/qemu/-/blob/144393da8d4bd307a22525c7feea2bb29a0a7556/docs/interop/vhost-user.rst#L1263
>
>Fixes: d288eef3a0a8 ("libvhost-user: fix -Waddress-of-packed-member")
>Signed-off-by: Simon Lucido <simonlucido@meta.com>
>---
>Changes in v2:
>- Reword the commit message to better explain the original bug
>- Link to v1: https://lists.nongnu.org/archive/html/qemu-devel/2026-11/msg02840.html
>---
> subprojects/libvhost-user/libvhost-user.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


