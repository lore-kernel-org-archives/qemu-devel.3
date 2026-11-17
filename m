Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46108606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X4u8GNlf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rq3RfJkv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOoZ-0005aQ-MQ; Tue, 17 Nov 2026 14:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xTOoY-0005aI-RA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xTOoX-0006Lw-79
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794943554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYJOYmMRpa+58zg04ePGocLLAlV341a/mR14+veifPE=;
 b=X4u8GNlfPmAZLeqPZ02zCyy7xqUbFUKPe3l6ZVnSCECo8auVYDaxeAYDmk28TdphaiXSZa
 n6WDqH5Bexuz2ZaBqSV6nHLpeiCjuPEJqy/veRp14mRGDCFsGbuYsY5CLSNVuYa5I2/jyb
 +dwVEVyfzyR1XK8F+WSIQfpNdGfW8Rk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-NLPQH0cbP-q8F-G61UDWPw-1; Tue, 17 Nov 2026 14:25:53 -0500
X-MC-Unique: NLPQH0cbP-q8F-G61UDWPw-1
X-Mimecast-MFC-AGG-ID: NLPQH0cbP-q8F-G61UDWPw_1794943553
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55bc8181defso3609341cf.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794943553; x=1795548353; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UYJOYmMRpa+58zg04ePGocLLAlV341a/mR14+veifPE=;
 b=rq3RfJkv9Gg4HXNtMmBlSHGfI0Fjla+jEA2HO/xmI5PDurqTY2G/PjLqtwQuRagr0H
 0GYMw/cO7ex3AZVSK0fMWKZlhmHh4xA/tcZmshk3ADcHs8MjaGSsjt1cSnLelkiIV5FF
 iDMZzGkmp8lEIbUv1rbWw7TiG31bCiyHZQWbu+0QX4hJzO4Y/P+IiuPNoKto9HEUSyU/
 cAZVWsjN0SYwtlTOG2qqssa+BiOtQ+oAhgqOsxoOVDcHH4Qatp9WLBFlqM0Z1smDjRMc
 bkFcSb91p0v41FO7EHhG651bm3tU2BrMWgG5DogOj1MvRCVptQOu4nA/h+FFEf6ALEZD
 CzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943553; x=1795548353;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UYJOYmMRpa+58zg04ePGocLLAlV341a/mR14+veifPE=;
 b=g8Pvs+lL0QMA0BExK1OhkcsolRpMzPaJh7DiedeirUVsgluHOp5bElHPQD53IzJk87
 3uR99EmzuCcjmctcZjz0igXyE2RcKRs0hBVV7gfJPoKhLXRV30v/EdnorhuR3uPOhiEc
 G/oVyIaaD5h/cHX8coHm5QcdAKz7hBJHAcRaAunS3T/HbiI1YJwdRbzDyojBzXzuxEMh
 On99ac3K/PXetoNONqllljCHBNwvSsUv3Guac2lb4U1Un0iPp+lblucSPzj0Q/at8WYW
 KUulacNlwEa2G6UwXamW3GFI/P+Xk+Xe1T3qWvK3DEP1lBVGiu32S9Q5pC65Iu7HjYUw
 ++Tg==
X-Forwarded-Encrypted: i=1;
 AL+hErEt7Lp9yXI64CX2r4REKabsthK6cYxLUul/NZSkKZ4G0+eb9W5H20NU8zq17MnmzILEmmBAjAi5/+qq@nongnu.org
X-Gm-Message-State: APuU4Z9Bps5ENtigohR8XHyvhu2B6DpBXy9KwKq5MICfgXsa/Wpnuxf3
 fHLzsGFlu6Tt5h1eJpJtqTfjj3m56pcGqqeS19E94OJwqJ/CYR6zl+CS2yZLcdX6A3uUyzaa8JJ
 KXoqf4JR9Nus85JcER09peOijGw3yTuTd+sBZAueFC5V2O4ab8jFjxAF+
X-Gm-Gg: AYBFou0B9atEHyGrPNeaiAY0OjacYO5L6z/JpkRksrwNFVwb8TpIDvMLultaiXWxTvu
 m2oWr44l+7ItS4/XqllMjaxDxDja+TlJOHsNqgMrzIgujj2/FresJ+wG/tB0ej4nVS7wLgw38xg
 wVQ2AYUnVr+AQXnHMF0tTO0wgn1mbnZP031m4yuuYWTL7XCJIu3+RVv8iM59ZTsa/U+eQNBM4QI
 AF1V0uKDP39GwCmh64I2AZ9pYdG+8OQuEeLUkiWyd7dRePu3A+ROCzJk/kyLy6peYZBaJOuV8x2
 4/x7y73HWWQwj37p4eabsqTdrYVcy/+9AS4jdvVzu9kf/mHBjT5svB082fAHd96BozshoNdHhfx
 f736Lqc2YGK0Jz2R+vlktDl4BctII26s1xSpljjdupP3k
X-Received: by 2002:a05:622a:13cd:b0:536:6f16:d923 with SMTP id
 d75a77b69052e-55d5a6b62c5mr4691521cf.40.1794943552600; 
 Tue, 17 Nov 2026 11:25:52 -0800 (PST)
X-Received: by 2002:a05:622a:13cd:b0:536:6f16:d923 with SMTP id
 d75a77b69052e-55d5a6b62c5mr4691101cf.40.1794943552032; 
 Tue, 17 Nov 2026 11:25:52 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d5909ec98sm3944261cf.22.2026.11.17.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 11:25:51 -0800 (PST)
Date: Tue, 17 Nov 2026 14:25:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
Message-ID: <avyqPuj7jz3QKM7K@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com>
 <875wxvs2na.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875wxvs2na.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 04:01:45PM -0300, Fabiano Rosas wrote:
> Sorry for the delay, we're all swimming in slop these days. The only
> feedback I have at the moment is that this feature needs tests. What's
> your plan in this regard? Can this run with nested virtualization? Or
> perhaps is there a way to mock the kernel interfaces and ensure QEMU
> does the right thing even without them? We don't need much, but the code
> definitely needs to be exercised somehow.

Apologize from my side too on being slow, I'm going to start reading mails
on the list this week, but it'll still be slow, together with other things.
Just to say, this one is on my review list.  Sorry again.

-- 
Peter Xu


