Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A57D2A52C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 15:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16Ix-0002by-J2; Wed, 16 Oct 2024 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t16Iu-0002bo-Dl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t16Is-0003EN-Ty
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729093873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldiboOCAZqe5CxQDuHIwMconnoK1NMufdm9Dw9yBZXE=;
 b=Tnh75WUg/7+bqrvs3AAo+LDSRo0/yn0JRT72LaZFdIMmDPBYel0Zsw9kbroGgrNxy8a+Dy
 +1RiPYNcAyuCmKLh6iHv+zla4xdXrMJrZXU7mRtN6G4lIWi4Ki4F46EjETi0sFM6TfxvR5
 1lM8hHAjeezf2TcIz48Ha5ANiWEgZEM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-MyJaKVqoPCq_vhn4wtO4vQ-1; Wed, 16 Oct 2024 11:51:12 -0400
X-MC-Unique: MyJaKVqoPCq_vhn4wtO4vQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cc10cd78e4so58257466d6.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 08:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093872; x=1729698672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldiboOCAZqe5CxQDuHIwMconnoK1NMufdm9Dw9yBZXE=;
 b=OJ/5HnSk0iE5e+wul7EkaLeaOPGa666LRUVNwSJNUuqRuo9ikhLkEWBH3W31STmADn
 A29qrmYoWRiOUJPBTodA42ZigiYugxQ78f/hCXP9Y2YHtIeWyR4BOkVUpgcUsmaqff06
 Wu9t9cwmPmu0YLv+uSv31+VyiSn61vl5B5m+bL2nJ80j3rSLVBg2ZgvjdC+flz9hhjOc
 oXl1SPOyrXsuH0jKCWJAbRImBd6cpAbtfrJ5B+fmLWwNt/rlg/cOIzY/WGioe9/+/QfH
 zLZiA/y4zvpHRFeN3EdHKHuz6knL1ju17xt6yywa8cvKxnXhfj5P/70v3pU/3K2jUxb6
 ECPw==
X-Gm-Message-State: AOJu0YzZ1cYghzcwYY+8qb+WTMuuHjsdLpCiY3AXC0QtY6g7NCs8NAVa
 WGJenVnDXHby6+4RIh87wByneN3fxVhqs5u08lisWYDvjxK1g8O5ySuyvbK7itchlwAiZGZJhAC
 5KrbzBKoDpzy9bGtA1+uOsoHzdwhqRSg0ihRjsR/tt7ou4xCS95gA
X-Received: by 2002:a05:6214:4607:b0:6c3:6c66:af6e with SMTP id
 6a1803df08f44-6cc2b92dcbcmr81720266d6.47.1729093871963; 
 Wed, 16 Oct 2024 08:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo6CNHfWIInbqmp594RzfZRlqLW8upoSkt/zeprs0bAjh5LUFbCDjd5vJtUxB9SZcppfIuRg==
X-Received: by 2002:a05:6214:4607:b0:6c3:6c66:af6e with SMTP id
 6a1803df08f44-6cc2b92dcbcmr81719946d6.47.1729093871619; 
 Wed, 16 Oct 2024 08:51:11 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290fe8csm19224966d6.14.2024.10.16.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:51:10 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:51:09 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] migration: Remove "rs" parameter in
 migration_bitmap_sync_precopy
Message-ID: <Zw_g7RfhcUBHE91T@x1n>
References: <cover.1729064919.git.yong.huang@smartx.com>
 <63b04591ecd6fcd1ffe570e1005fc3040168ad42.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63b04591ecd6fcd1ffe570e1005fc3040168ad42.1729064919.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 16, 2024 at 03:56:43PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> The global static variable ram_state in fact is referred to by the
> "rs" parameter in migration_bitmap_sync_precopy. For ease of calling
> by the callees, use the global variable directly in
> migration_bitmap_sync_precopy and remove "rs" parameter.
> 
> The migration_bitmap_sync_precopy will be exported in the next commit.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


