Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F3C109E553
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5dmy-0004Bc-OI; Thu, 26 Mar 2026 02:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5dmx-0004BE-NT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:01:51 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5dmu-0000G3-W0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:01:51 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so271172a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774504907; x=1775109707; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kupUV4i4hPwNPk5q1NPJfQR4+oRKXq8N/9LiP1M5nuA=;
 b=QiUl+doR59Fvr0vO0cy9AMrKM88dtcrFRtzQvCUQN528oWiWRLeUlzhK2ND5hCJcxw
 9OwlrlRT1ulireBKPxGEpzNfrMybalxYweXBlTskwt6cU5dw8PNyLstcMbQiH2z5qjFt
 BIwmcXNBIJfVhIPwFzEMaFzS4PlJGiU0oRiras0bmfuQAkTmXCpJuGtVj3I5MgGaF6+S
 Wlqv1Z8HSXLyJDuzXiauDlLAJ2WPQWk5ICILjjohgwHamo3QpZzRJRFizJ4BuLGJimeg
 kw3Q3cepaJ0HY/Kv4j5X4Kub9gKS+312LMiRz9eAWZR2LodR5XVB+1tpmtjMnMmRIPkU
 2Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774504907; x=1775109707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kupUV4i4hPwNPk5q1NPJfQR4+oRKXq8N/9LiP1M5nuA=;
 b=fapfobemxYx47cc1m81nRRFNL6/DoCZBdTN26yhHcSs9xkMmW4pCzuIuEZi5ZEcDJ5
 FsPYwULxoi9nZr4xZDOCNwlAeKzht0ywI1qKcl0rABVYrBXXXeu6Ip1zV10Zq2mOwquu
 Kf6x4HRlIOBfMKbR4p8xPEbiSpjPVTsbuzyU9FsZS3Ef6pqRlstkg6atxEj7C1EZ3usv
 go+BFteSnKc5x4DrLad4A9W3CEYLze0PHS2/XfaQrbV4bmcyU/bWs3PVNyN0fMxhGnVp
 Y67vFNLEWzV6alXzWnmARkAh8TsZmwiTZHN6XUvO8Tm2ck/XMNlgIAIuZFozrd6LWBkt
 vKuw==
X-Gm-Message-State: AOJu0YzRnszkHy1iISplb75nfZ/BoVxJs66FNjJquQ6EOHWvoxCx4Kvd
 bPH90OXWvzo1PJ3RIVCAarwXCPU3dRJpYKncd6Q5VDfyXVTVH5G+pVTe
X-Gm-Gg: ATEYQzyhRvMmJszKjOK1gbNe/PpHycozUsVz6N32dQHu8NZ2ew69EKvmYj5KBGdFVPB
 XHlo8xw40bBjC23EMixRSgPNNxbchVscaDO1uDlCbf7uFkDn7/gK+1J+IjjTQi9WaZgJXPQW64/
 tH60yquQDvCa/d2NeV6rSA65t5KyW41lqlmZuZ5FepkZ2UzhAqzIzCY84MgHG166kvYnqI4tB66
 61WhcvpH8/0hTNgX7Kwkaue2CFpGY1tnTd9asA0aQFu+pdlNUnU3sXAG6HeJKdeS+74bFgG9oHn
 s8eZwHMS1vAcBDVP1zu5VTUcfTHEIDQybSZ5DBgdkvxgG9BozrhZRKvILNsq8vZ4P1FDfbD15MU
 dUo4pNcbFUjRTtfwcCA9dDkHAA+DX/WUS0J5GnycmBpgQ/kjyzXBSjTQqK5MlChsivbRKkoeY36
 XC2mkQW8VuPRAb0zGdVzjYEHtT78qu58BtOKmGEe4AI0krwyM6xdFvjZTHCG7yQ3o0
X-Received: by 2002:a05:6a20:a123:b0:398:8a92:78a5 with SMTP id
 adf61e73a8af0-39c4ab915c1mr7212415637.28.1774504906719; 
 Wed, 25 Mar 2026 23:01:46 -0700 (PDT)
Received: from localhost (103.95.112.190.qld.leaptel.network. [103.95.112.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767397b235sm1135907a12.26.2026.03.25.23.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:01:45 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:01:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 2/3] linux-user: Fix unlock_user API usage
Message-ID: <acTKJSWVB8xrzRr7@lima-default>
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-3-npiggin@gmail.com>
 <ab-Q2znE0qdtTRsT@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab-Q2znE0qdtTRsT@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Mar 22, 2026 at 02:54:31PM +0800, Chao Liu wrote:
> On Sat, Mar 21, 2026 at 10:48:35AM +1000, Nicholas Piggin wrote:
> > Fix errors in unlock_user() calls:
> > - unlock_user() with len=1 instead of len=written
> > - unlock_user() with len=1 instead of len=0
> > - unlock_user() with len=0 instead of len=1
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  linux-user/linuxload.c | 2 +-
> >  linux-user/syscall.c   | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> > index 85d700953e..79416a94c9 100644
> > --- a/linux-user/linuxload.c
> > +++ b/linux-user/linuxload.c
> > @@ -19,7 +19,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src, unsigned long len)
> >          return -TARGET_EFAULT;
> >      }
> >      memcpy(host_ptr, src, len);
> > -    unlock_user(host_ptr, dest, 1);
> > +    unlock_user(host_ptr, dest, len);
> This fixes the writeback -- old code had 0 which meant
> no flush at all, so getsockopt results were silently
> lost under CONFIG_DEBUG_REMAP.
> 
> Minor observation: getsockopt returns actual bytes in
> lv, so using lv rather than len would be more precise.
> That said, the swap loop above also uses len, so this
> is consistent with the existing code.

I guess this comment is for the next hunk below.

The swap loop as you noted stores to the full len, so I
think it's better to use that. If the logic changes to
only store lv, then the unlock would change.

> >      return 0;
> >  }
> >  
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 7832a1aba5..13b8bd9ed3 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -2989,7 +2989,7 @@ get_timeout:
> >              if (put_user_u32(lv, optlen)) {
> >                  return -TARGET_EFAULT;
> >              }
> > -            unlock_user(results, optval_addr, 0);
> > +            unlock_user(results, optval_addr, len);
> >              break;
> >          }

Actually missing unlock on error too, I'll fix that up.

> >  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> > @@ -4006,7 +4006,7 @@ static inline abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> >          __put_user((*host_array)[i], &array[i]);
> >      }
> >      g_free(*host_array);
> > -    unlock_user(array, target_addr, 1);
> > +    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
> >  
> >      return 0;
> >  }
> > @@ -7888,7 +7888,7 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
> >      host_sevp->sigev_notify = tswap32(target_sevp->sigev_notify);
> >      host_sevp->sigev_notify_thread_id = tswap32(target_sevp->_sigev_un._tid);
> >  
> > -    unlock_user_struct(target_sevp, target_addr, 1);
> > +    unlock_user_struct(target_sevp, target_addr, 0);
> Right. This function only reads from target, so
> copy=0 (no writeback) is the correct semantic.
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Nick

