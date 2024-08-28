Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D78C63685
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL4w-0008Dc-Ij; Wed, 28 Aug 2024 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL4v-0008CR-BZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL4t-0000lc-Lq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724860762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8PRUk4GdXm2stqSFlWkSwP7PGtD8KtNvCEhRtO9kM8=;
 b=L0nYSc07s8WyuxmYzMw1Jcp7wKTbg/6oDr92lq8Ppffto4LjzTAYMR3HbnVYGSPAV6z3h1
 tuE2D249nB9RhsdTNXYmmkZf/p/VL/Ah3vu03T7q6hyasNd7ckD6+NfV/WUr14ddlTRSG/
 GV4JsvbbYI3hiW0MJqrINj7f0pj55SQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-RJFmh9MFOcGOHzOwJGgLUQ-1; Wed, 28 Aug 2024 11:59:21 -0400
X-MC-Unique: RJFmh9MFOcGOHzOwJGgLUQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-27003dcbfe8so8391714fac.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860760; x=1725465560;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8PRUk4GdXm2stqSFlWkSwP7PGtD8KtNvCEhRtO9kM8=;
 b=WHPw4Ana7WCFXAmTRclTNa43oSlFLtVIsr1jpmHc5tKMIisoW9STQf1An354l1BJ+U
 dDK74B6gp9SSfc2IytGA5nxFwjZxFoyHaKvx5lLkXk9OBXuIlggWPq9gcBB6hKC0iect
 KQgSQy2/6UGRKv5rq8Myu6rTAbL026jUd26e5ZrTPjllZOf/XIV1m9KbVNU0F2taZ5Vz
 6g4y1NySuZBq9gP34tlms66Rt0jcOVZ/7GUmSIa+hFZey5A81txB1u+UFFtDid0A9WdF
 PAjLLxR7KBTLT4YIkmUdmyJZ0alxz7NZlcZHrCb4ygkiOOcOLpMhybxoW0uZBbfWb19p
 dPKA==
X-Gm-Message-State: AOJu0Yy4lDKO6lYEcfzL8ie3iJX7hinUrlW1n0F2nsQxDTsvMT4cNCN2
 TLD56szThuri2MAhidHgU4tuSvTHw6JSlHRUNpznXbPm0zOqsjxAMeA0jY13pvFsNeEWxE5yx2U
 /SK+Zv3GhHhkM25ZRIpwKWHiNjNKvtmRas4VDcfVwdkcYN88jWaX0
X-Received: by 2002:a05:6870:8086:b0:254:c512:88c6 with SMTP id
 586e51a60fabf-2777d39b53bmr2160305fac.51.1724860760442; 
 Wed, 28 Aug 2024 08:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7VC03vdPkhmgXXqmIymNZY1PaLMs//HAg+JKrSL+y0Je9ADiud2CekY+19BlNDOo6Qkdtg==
X-Received: by 2002:a05:6870:8086:b0:254:c512:88c6 with SMTP id
 586e51a60fabf-2777d39b53bmr2160290fac.51.1724860760164; 
 Wed, 28 Aug 2024 08:59:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03a51aa6sm2907700a34.12.2024.08.28.08.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 08:59:19 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:59:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 1/4] migration/multifd: Stop changing the packet on
 recv side
Message-ID: <Zs9JVcI7YaLBxFlh@x1n>
References: <20240828145650.15879-1-farosas@suse.de>
 <20240828145650.15879-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828145650.15879-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 11:56:47AM -0300, Fabiano Rosas wrote:
> As observed by Philippe, the multifd_ram_unfill_packet() function
> currently leaves the MultiFDPacket structure with mixed
> endianness. This is harmless, but ultimately not very clean.
> 
> Stop touching the received packet and do the necessary work using
> stack variables instead.
> 
> While here tweak the error strings and fix the space before
> semicolons. Also remove the "100 times bigger" comment because it's
> just one possible explanation for a size mismatch and it doesn't even
> match the code.
> 
> CC: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


