Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A22EB3625
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7Cb-0005Oq-Oy; Mon, 02 Mar 2026 12:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx7CZ-0005Oc-BW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx7CX-0002YF-R5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772473020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPTfl4nQTa4JsvY762hRzg7CKMCcDVt01Vy3bMvj9dM=;
 b=b2gZ5GU+pNJsMez+y0ye+Ii4dfwUuSy1UXPL51D9qvSMe+nN/lHzJTUPVMiQT70rOSqPss
 Kl3/SMnBvmtu8UG9rh16+wiSk5PQuwv3eN4j/pDw7IszCyd4oKCjqMYYOY7dWE7tbDClac
 Kq2opYqGKCv91h97rVeKqsUBTjPakLU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-WKSSSiJkMjyXIr0Sk74Dfw-1; Mon, 02 Mar 2026 12:36:59 -0500
X-MC-Unique: WKSSSiJkMjyXIr0Sk74Dfw-1
X-Mimecast-MFC-AGG-ID: WKSSSiJkMjyXIr0Sk74Dfw_1772473019
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb3ad1b81aso5965672785a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772473019; x=1773077819; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iPTfl4nQTa4JsvY762hRzg7CKMCcDVt01Vy3bMvj9dM=;
 b=ntEKgwwATZLSxSPL7UNAhsc96Pt0SlHgwsQNrXwuwiL78OKCRCo8S1fYiGQTDZN0lL
 oYeZGMOcWA3MAm/N1V35628KavXdtGo4aPZGTBfbmUsx/cy4p+emkx/lwhCulqOAaFcJ
 4F+1Dom2kpiF8YqK05873FfqV16DPVVM8BZLKhbaTNoGNFq6dAJf1HgDlBy5m/j4XxC9
 fMvwBs1HA5g9tBHdhOy4mJGQNU5OJSWuO/t7/ibtyA41e1eylCFbVhZJb+Fnbjs7R5YA
 oSSEH2Mt4h6XavR+Mm0S/bTGfjCa8U8WgZscD3MJShgOZZjeG1v7/YdMGIlrKX+T7p4M
 t/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772473019; x=1773077819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPTfl4nQTa4JsvY762hRzg7CKMCcDVt01Vy3bMvj9dM=;
 b=aF/NRhgCpivuS0sq1Rt3tF3wRQnE4KgLY+y6BbYpbQQVZcIA9f8Crzr8I537Ox5OZy
 LW38LTRtm0gWXWRUIkDb28YZPipJtG5LpZ6YAFAEbHNasdZRxLn/DtqBvFKLG/+TFxy8
 BkE/wLVYkv0hUer4+RyoTfBy9v6qbkCQBjHrjl+yNfmJrvQM2OsDAbKuBBH0wAnLmRIy
 kpG9D5TQxVVTBzIjINg4OULoXOhwcuXFW2dcA6up418rS4PckN9Xg+zgfcKD6Ke3HiU2
 rGxnIoim7DKiQBlcRAN1AUcu9v3sQtTiASjP0fQi+9YciSAedrcawswrMgAVcOgvSU4a
 g1GQ==
X-Gm-Message-State: AOJu0YwwNmkYb4ABgwNsKMSB0pDPFIKoZNHmhNOREz+grb9DuQ1Mb/KG
 HDYHKn12OmuZZDGsePPfn89TlZPuMPBDztWeFtn+gT4GYZFHDAIZyL0qxbfWT1R+VtzKvB+KHwZ
 lH6tn4A865mjKraTLc10r9iJ4qs/uGxvKQC9nrjzYCr7fDmbBGabOMR+I
X-Gm-Gg: ATEYQzxjBe16qVTZgKVBW/G6rBZxMk10NzXS+aANhsPis57gQAtlfL0Pdm5y3cIbW+/
 S3FRhMg492FxAy9bBlikPQjFOmbwC+1tAgtms2NAys218nCCoo6aZqdYJba9NFkQCZUBnNpZ7Hx
 PtWAQKgbK7KIaGXdYU1a9BkJ88liB5+DMtTrRLEu6/XkdeAQs3JJYyeUzXSB2sPEzE63ADTM1fk
 zutTO0AOcUVb1o84N31mnP6TTTESA3mJsm6Buk5pqzkCw5ZGefK8nLZO8BBCKFRUks5OZeo20oC
 Z85fLka9oIR2Tr3Ph5ZBWptQ7+YszJcK9ePGdlZyoBM6S0oiqzX2y247ZzDE79ZhNhDGqSzKT/N
 3bgTUjYx37E4+y+4S+sbDwtJ9XeF8ofYlInKuZzyfttdZjOr0p/f0hb3f8JleRmbowb/es/vRPR
 JqvDpsUQ==
X-Received: by 2002:a05:620a:28c6:b0:8ca:2bab:a0f9 with SMTP id
 af79cd13be357-8cbc8dc4990mr1778360185a.1.1772473018617; 
 Mon, 02 Mar 2026 09:36:58 -0800 (PST)
X-Received: by 2002:a05:620a:28c6:b0:8ca:2bab:a0f9 with SMTP id
 af79cd13be357-8cbc8dc4990mr1778356485a.1.1772473018080; 
 Mon, 02 Mar 2026 09:36:58 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6541f1sm1179562785a.3.2026.03.02.09.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:36:57 -0800 (PST)
Date: Mon, 2 Mar 2026 12:36:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <aaXKt87sJS5Bog5B@x1.local>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On Mon, Mar 02, 2026 at 12:06:26PM +0500, Alexandr Moshkov wrote:
> When loading a subset, its name is checked for the parent prefix. The
> following bug may occur here:
> 
> Let's say there is a vmstate named "virtio-blk", it has a subsection
> named "virtio-blk/subsection", and it also has another vmstate named
> "virtio" in the fields.
> Then, during the migration, when trying to load this subsection for
> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> then the migration will break, because this vmstate does not have such a
> subsection.
> 
> In other words, if a field inside vmstate1 is set via vmstate2 with a
> name that is a prefix of the parent vmstate, then the field can "steal"
> a subsection belonging to the parent state.
> 
> Looks like it happens because migration stream for "virtio-blk" looks
> like this:
> 
>  [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
> 
> "virtio-blk" contains "virtio" field, so migration stream is:
> 
>  [virtio-blk header] [virtio header] [virtio fields] [virtio
> subsections] [virtio-blk subsections]
> 
> And when we load the subsections of the "virtio" device,
> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
> this is his subsection. This is where we encounter an error.
> 
> Thus, the error occurs due to the fact that vmsd does not know how many
> subsections it has when loading (this does not appear anywhere in the
> migration stream), so it tries to load all the appropriate ones by
> names.
> 
> Fix it by checking `/` at the end of idstr.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


