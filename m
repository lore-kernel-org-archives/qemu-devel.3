Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD1CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENYq-0003pT-EY; Wed, 07 Oct 2026 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEKl9-0001x5-4B
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEKl6-0001VR-IM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791353047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kb5gXpMojGNUpscsafc2qRNiwU8zcbmwS/ii8Ebb1og=;
 b=GDDpPc/Lj351gDomy8GGZYCkKeBq33/y7aVf1peYReu0voYS9ikVEaBNNG+dwWmSjlz2AU
 bQ0Qcnaif92gH7/XG2CehJMkHDoca1GcftRE0vEEHBuVcRsfWIe80fWKKk5g8bXTrChdXy
 as4Z86VOi3WUbFk3irOxj9gSY/NcJE8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6WZ-R45wPtmmckYTbU5SOA-1; Tue, 06 Oct 2026 09:23:25 -0400
X-MC-Unique: 6WZ-R45wPtmmckYTbU5SOA-1
X-Mimecast-MFC-AGG-ID: 6WZ-R45wPtmmckYTbU5SOA_1791293005
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9196b477c4cso21039036d6.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791293005; x=1791897805; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kb5gXpMojGNUpscsafc2qRNiwU8zcbmwS/ii8Ebb1og=;
 b=tU3D/haTkd3uwrF7z/qe7m8O6xNz16sBkLfB/Lfo20zRN+hDKlpKz29p6ll8UTUCRd
 n12hDlWvBsKhDRKkxHT/vqIpXMApc7j1PLqlpqsXKf3R9j75+lL972QnXjTi/W5FKKz3
 xaaFLvrG9cRQADKBUC4cUQfGUoFZMYOqvCveAfnnybTwuJlTlbt+myU6EDcsrEh27ack
 toZbvg//uAt/Yh72VEGFzzSaF8v1oBIYjck6hjTSuOPG6AmJZ+7DqBd05N6GYTVfYX0O
 uCWCUlW8qZhcsk2EBOUA+8yACvPjewOlRyR9SfB3ZJscupH3nl6P0vCABHCbmmCTJS4Y
 c60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791293005; x=1791897805;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kb5gXpMojGNUpscsafc2qRNiwU8zcbmwS/ii8Ebb1og=;
 b=RA/RTq6i4rtB9DfP31BJY6kBa0uWtD3WN0Uqpu2lJgMjGGqk4TbP+x3pAIuGqWCe43
 T5akX9zgTpGakUcTCWU3uMCsWT8xNfmVoD/Wlm1MWHWx2HWehjYj5dBuk8eN3c2mqpBd
 RGN6GrU1i9jQCUYv1i2/d1hjAEcqXMXvx5Y+NJ9WUS7Mpk81kbc2rZEZNvbqXz6xcENS
 nM03uO4dp/68+2/xxtY6w6ZZ+Ik/UZImQw56Db0LOLkpcsBtGiL+PKVGqZ8lW6AuEMFQ
 gmqsy2FdTm4IwfSK/TvMF+8iINiM8gnRI2idWXtgKj01fgmYiauFrTJ/Vz/l06tzoYH9
 +TRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtEsLV3NIEfWjmW8euhL6KBohbaL0BVqYrrivG/n6UjgKphX8hj6ppMTAA3LED1+Z8h/afAdC/WSf1@nongnu.org
X-Gm-Message-State: AFq9FYI2tfBl76zkfzWCsCZS3Cc5OeIHek3DGrYGsuVv3wa6BGi65uuu
 ztw2X9yF45GGKsKaOZOPCoaItHGtHAd37qLoNvAOZLMhQ67RG1ynlkR+eHYjiQUOvhcjaFs0QFc
 6nBvMK+KYuuy7xgww8Y1L6adcaEomfDNPOVOxvMEShLQirYuxJc1HKEWY
X-Gm-Gg: AYBFou3HhpMs8QUX4STMv+4/J+M3BLRCR3P2yzel1igLNkh7H7wGqxSUWKxaaDvHO+c
 0vnLe6z65tQ3sxTmLbYIJ16DY8iR1wUemeOqvajo7IFFEa/dGi5GdqGOeILc78Gvu0I6ATVAUJN
 nRaiiafFpd94QRahYzaDFBbl5egTSPUJ3Xw6jWE1+4wPmrR5+Cnbpwfx8UY9ZKGACndirwQ2Rsh
 9GSbu0mDqAEHWm3/kBAfWNaS/k7IlS/3/XgScEBHjy9PGK5P8o0dVh7t7uz7SBHFMa9dao+y1AI
 Ss0iruoFSXfruLEpZAV37NLggDxb9CEjT+DkZvmR/usLyXLXqxv+Fm1nnr2uGtBLt3BN7RM=
X-Received: by 2002:a05:6214:5e06:b0:919:89f4:64f9 with SMTP id
 6a1803df08f44-91989f469e4mr25669326d6.27.1791293004967; 
 Tue, 06 Oct 2026 06:23:24 -0700 (PDT)
X-Received: by 2002:a05:6214:5e06:b0:919:89f4:64f9 with SMTP id
 6a1803df08f44-91989f469e4mr25668836d6.27.1791293004386; 
 Tue, 06 Oct 2026 06:23:24 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b1aef0sm114001506d6.12.2026.10.06.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:23:23 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:23:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 zhao1.liu@intel.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] tests/functional: add test_tap_migration
Message-ID: <asT2SnsSrKENc9Fa@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
 <20260914175351.393680-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914175351.393680-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 08:53:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Add test for a new local-migration migration of virtio-net/tap, with fd
> passing through UNIX socket.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


