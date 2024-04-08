Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D5CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtr2Q-0001Rn-3J; Mon, 08 Apr 2024 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtr2F-000151-Hc
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtr2B-0007Ea-K3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712590545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGh8D/gXUPxU4XUJjMkqXOP8XATnQ9RGub5/hny6ByY=;
 b=GJJXObtBiUj+G9xWCRXhGUFWpiKKHOkjIUlQ063Qyd6NPewSuBPkh29jVvEwPwLgX29am4
 +BU1tigdlTd97NIUGnUiF7K/ueam2oodcFdYKCEMiaBfWEsEXb/jbF2+FIxg/3GAIc9w7x
 Kc/eZXWgB6tw4bTZLbm3y5d0C8oUwhs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-lKL0jCsVO7q_nB3-KUGVaA-1; Mon, 08 Apr 2024 11:35:44 -0400
X-MC-Unique: lKL0jCsVO7q_nB3-KUGVaA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6993921ae18so4412306d6.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712590544; x=1713195344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGh8D/gXUPxU4XUJjMkqXOP8XATnQ9RGub5/hny6ByY=;
 b=pF5lN92aImGThn0xpLniZkH987iuir3APLvmU9nTESkaG4V44GZVltiPeHCosOtbcs
 oxP8IXESMwyeCTy0aQ5mp53sirsnUOc4Gh9/GDxmABwHCvnHl9Zbp+3k+F1Ozj0pmONy
 RaYT3kNP3msWI8bEb08sFd5c58w1vHwHJWlIsEjQ9+lmSwdkIr0HU0Nrp6rhQQlcq8Wg
 Snym+EdoGYRbAlAZsAcBlEoO2B2HjCYdl8In+qcJwewFVz/G5ZY/5thW/ce9LWFz/3k/
 U3RPzWqKMplrA+O80SAV+ic1uaDcIpL2An0EkhXuM4BXOhT2ituBK96ONALf9qI4273I
 r79w==
X-Gm-Message-State: AOJu0Yyf/r8IlzSaOaVP8jrW+VoXd7guD580+lb6IVb0trx5Jv+y5+WU
 s9B0xKzToqFlWqRnyRwbl9xN3TwUH9YZUuMZ3O4DSTzADQCiDDUJLbLxG0i6ViZXVR7QerDeysj
 7FVhW61aShpErdzlPravYyG6UM+UsdBAiJJ4cZUQCv04eS/TMA8wA
X-Received: by 2002:a05:6214:f63:b0:699:1907:7676 with SMTP id
 iy3-20020a0562140f6300b0069919077676mr10264512qvb.5.1712590543462; 
 Mon, 08 Apr 2024 08:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXhO2C7rX9K2TDu8njnepKtAKGDeNx+yv3nq91KHRdByQlZ034cs9tz+lUXLVpTdUMZUKSfQ==
X-Received: by 2002:a05:6214:f63:b0:699:1907:7676 with SMTP id
 iy3-20020a0562140f6300b0069919077676mr10264484qvb.5.1712590542852; 
 Mon, 08 Apr 2024 08:35:42 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o11-20020a0ce40b000000b00699437d4dfbsm2877458qvl.72.2024.04.08.08.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:35:42 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:35:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/2] Fix typo to allow migrate_qmp_fail command with
 'channels' argument
Message-ID: <ZhQOzMuQBNiqQVsi@x1n>
References: <20240407132125.159528-1-het.gala@nutanix.com>
 <20240407132125.159528-2-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407132125.159528-2-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hey, Het,

On Sun, Apr 07, 2024 at 01:21:24PM +0000, Het Gala wrote:
> Fixes: (tests/qtest/migration: Add negative tests to validate migration QAPIs)

I think I get your intention to provide two fixup patches on top of
migration-next, which indeed would be preferred so that I can squash them
into the patches before the pull.

However please next time use "git commit --fixup" so that a better subject
will be generated, and that'll make my life (and Fabiano's I suppose in the
future) easier because git rebase understand those subjects.  Then you
don't need Fixes with an empty commit ID.  They'll start with "fixup: XXX"
pointing to a commit with subject rather than commit IDs.

Thanks,

> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index d03a655f83..584d7c496f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1724,7 +1724,7 @@ static void test_precopy_common(MigrateCommon *args)
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, args->connect_uri, args->connect_uri, "{}");
> +        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
>          goto finish;
>      }

-- 
Peter Xu


